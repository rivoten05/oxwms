#!/bin/bash

# ┏━━━┳━━┳━┓┏━┳━━━┳┓╋╋┏━━┳━┓┏━┓
# ┗┓┏┓┣┫┣┫┃┗┛┃┃┏━━┫┃╋╋┗┫┣┻┓┗┛┏┛
# ╋┃┃┃┃┃┃┃┏┓┏┓┃┗━━┫┃╋╋╋┃┃╋┗┓┏┛
# ╋┃┃┃┃┃┃┃┃┃┃┃┃┏━━┫┃╋┏┓┃┃╋┏┛┗┓
# ┏┛┗┛┣┫┣┫┃┃┃┃┃┃╋╋┃┗━┛┣┫┣┳┛┏┓┗┓
# ┗━━━┻━━┻┛┗┛┗┻┛╋╋┗━━━┻━━┻━┛┗━┛
# The program was created by DIMFLIX
# Github: https://github.com/DIMFLIX-OFFICIAL
# Bluetooth functions adapted by Gemini

SESSION_TYPE="$XDG_SESSION_TYPE"
ENABLED_COLOR="#A3BE8C"
DISABLED_COLOR="#D35F5E"
BLUETOOTH_CONNECTED_ICON=" "

# Function to get Bluetooth status for status bar
get_bluetooth_status() {
    local status_icon="" # Default icon for Bluetooth
    local status_color=$DISABLED_COLOR

    if systemctl is-active --quiet bluetooth.service; then
        if bluetoothctl show | grep -q "Powered: yes"; then
            status_color=$ENABLED_COLOR
            # Check for connected devices
            if bluetoothctl devices Connected | grep -q "Device"; then
                status_icon="󰂯" # Icon for connected
            else
                status_icon="󰂲" # Icon for enabled but no connection
            fi
        fi
    fi

    if [[ "$SESSION_TYPE" == "wayland" ]]; then
        echo "<span color=\"$status_color\">$status_icon</span>"
    elif [[ "$SESSION_TYPE" == "x11" ]]; then
        echo "%{F$status_color}$status_icon%{F-}"
    fi
}

# Function to manage Bluetooth devices
manage_bluetooth() {
    local bluetooth_powered=$(bluetoothctl show | grep "Powered:" | awk '{print $2}')
    if [[ "$bluetooth_powered" == "no" ]]; then
        notify-send "Bluetooth Disabled" "Please enable Bluetooth first."
        return
    fi

    # Scan for new devices in the background
    bluetoothctl scan on & > /dev/null
    local scan_pid=$! # Get PID of the background scan process

    # Give it a moment to discover devices
    sleep 2

    local devices_raw=$(bluetoothctl devices Paired | grep "Device" | cut -d ' ' -f 2- | sed 's/^Device //')
    local available_devices_raw=$(bluetoothctl devices | grep "Device" | cut -d ' ' -f 2- | sed 's/^Device //')
    local device_list=""
    local macs=()
    local names=()

    # Add paired devices
    while IFS= read -r line; do
        local mac=$(echo "$line" | awk '{print $1}')
        local name=$(echo "$line" | cut -d ' ' -f 2-)
        local connected=$(bluetoothctl info "$mac" 2>/dev/null | grep "Connected:" | awk '{print $2}')

        local formatted_name="$name"
        if [[ "$connected" == "yes" ]]; then
            formatted_name="$BLUETOOTH_CONNECTED_ICON $name"
        fi
        
        device_list+="$formatted_name\n"
        macs+=("$mac")
        names+=("$name")
    done <<< "$devices_raw"

    # Add available devices (not paired)
    while IFS= read -r line; do
        local mac=$(echo "$line" | awk '{print $1}')
        local name=$(echo "$line" | cut -d ' ' -f 2-)
        
        # Only add if not already in paired list
        local found=false
        for existing_mac in "${macs[@]}"; do
            if [[ "$existing_mac" == "$mac" ]]; then
                found=true
                break
            fi
        done
        
        if ! $found; then
            device_list+="$name\n"
            macs+=("$mac")
            names+=("$name")
        fi
    done <<< "$available_devices_raw"

    # Stop scan after populating list
    kill $scan_pid 2>/dev/null
    bluetoothctl scan off > /dev/null

    local chosen_device=$(echo -e "$device_list" | rofi -dmenu -i -p "Bluetooth Devices:")

    if [ -z "$chosen_device" ]; then
        return
    fi

    # Extract original name and find MAC
    local chosen_name=$(echo "$chosen_device" | sed "s/$BLUETOOTH_CONNECTED_ICON //")
    local chosen_mac=""
    local chosen_index=-1
    for i in "${!names[@]}"; do
        if [[ "${names[$i]}" == "$chosen_name" ]]; then
            chosen_mac="${macs[$i]}"
            chosen_index=$i
            break
        fi
    done

    if [ -z "$chosen_mac" ]; then
        notify-send "Error" "Could not find MAC address for $chosen_name."
        return
    fi

    # Determine action based on device status
    local device_info=$(bluetoothctl info "$chosen_mac" 2>/dev/null)
    local paired=$(echo "$device_info" | grep "Paired:" | awk '{print $2}')
    local connected=$(echo "$device_info" | grep "Connected:" | awk '{print $2}')
    local trusted=$(echo "$device_info" | grep "Trusted:" | awk '{print $2}')

    local action_options=""
    if [[ "$connected" == "yes" ]]; then
        action_options+=" Disconnect\n"
    else
        action_options+="󰸋 Connect\n"
    fi

    if [[ "$paired" == "yes" ]]; then
        action_options+="󰦪 Unpair\n"
        if [[ "$trusted" == "no" ]]; then
            action_options+="󰠊 Trust\n"
        fi
    else
        action_options+="󰹑 Pair\n"
    fi

    local chosen_action=$(echo -e "$action_options" | rofi -dmenu -p "Action for $chosen_name:")

    case $chosen_action in
        "󰸋 Connect")
            bluetoothctl connect "$chosen_mac" && notify-send "Connected" "Successfully connected to $chosen_name." || notify-send "Connection Failed" "Could not connect to $chosen_name."
            ;;
        " Disconnect")
            bluetoothctl disconnect "$chosen_mac" && notify-send "Disconnected" "Successfully disconnected from $chosen_name." || notify-send "Disconnection Failed" "Could not disconnect from $chosen_name."
            ;;
        "󰹑 Pair")
            notify-send "Pairing Initiated" "Attempting to pair with $chosen_name. Check for any prompts."
            bluetoothctl pair "$chosen_mac" && notify-send "Paired" "Successfully paired with $chosen_name." || notify-send "Pairing Failed" "Could not pair with $chosen_name."
            ;;
        "󰦪 Unpair")
            bluetoothctl remove "$chosen_mac" && notify-send "Unpaired" "Successfully unpaired from $chosen_name." || notify-send "Unpair Failed" "Could not unpair from $chosen_name."
            ;;
        "󰠊 Trust")
            bluetoothctl trust "$chosen_mac" && notify-send "Trusted" "$chosen_name is now trusted." || notify-send "Trust Failed" "Could not trust $chosen_name."
            ;;
    esac
}

# Main menu for Bluetooth
bluetooth_main_menu() {
    ##==> Get necessary arguments
    ###############################################
    while [[ $# -gt 0 ]]; do
        case $1 in
            --status)
                status_mode=true
                shift
                ;;
            --enabled-color)
                ENABLED_COLOR="$2"
                shift 2
                ;;
            --disabled-color)
                DISABLED_COLOR="$2"
                shift 2
                ;;
            *)
                shift
                ;;
        esac
    done
            
    if [[ $status_mode == true ]]; then
        get_bluetooth_status
        exit 1
    fi

    ##==> Check if Bluetooth service is running
    ###############################################
    if ! systemctl is-active --quiet bluetooth.service; then
        echo -n "Root Password: "
        read -s password
        echo "$password" | sudo -S systemctl start bluetooth.service
        sleep 1 # Give it a moment to start
    fi

    ##==> Get action buttons and their functionality
    #######################################################
    local bluetooth_status=$(bluetoothctl show | grep "Powered:" | awk '{print $2}')
    local bluetooth_toggle
    if [[ "$bluetooth_status" == "yes" ]]; then
        bluetooth_toggle="󰂓 Disable Bluetooth"
        bluetooth_toggle_command="off"
        manage_bluetooth_btn="\n󰂰 Manage Devices"
    else
        bluetooth_toggle="󰂴 Enable Bluetooth"
        bluetooth_toggle_command="on"
        manage_bluetooth_btn=""
    fi

    ##==> Display Rofi menu
    #######################################################
    local chosen_option=$(echo -e "$bluetooth_toggle$manage_bluetooth_btn" | rofi -dmenu -p "󰂯 Bluetooth Management: ")
    case $chosen_option in
        "$bluetooth_toggle")
            bluetoothctl power $bluetooth_toggle_command
            ;;
        "󰂰 Manage Devices")
            manage_bluetooth
            ;;
    esac
}

bluetooth_main_menu "$@"
