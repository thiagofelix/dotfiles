#!/bin/bash

# Define log file
LOG_FILE=~/.dotfiles_setup_log.txt

# Function to log messages
log_message() {
    echo "$(date): $1" | tee -a "$LOG_FILE"
}

# Create the .dotfiles directory
create_dotfiles_directory() {
    log_message "Creating the ~/.dotfiles directory..."
    mkdir -p ~/.dotfiles
    log_message "Directory ~/.dotfiles created."
}

# Check if Homebrew is installed
is_homebrew_installed() {
    [[ -d "/opt/homebrew" ]]
}

# Install Homebrew
install_homebrew() {
    if is_homebrew_installed; then
        log_message "Homebrew is already installed."
    else
        log_message "Homebrew is not installed. Asking for permission to install..."
        read -p "Do you want to install Homebrew? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            log_message "Installing Homebrew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            log_message "Homebrew installed."
        else
            log_message "Homebrew installation skipped."
        fi
    fi
}

# Run the Brewfile
run_brewfile() {

    local BREWFILE=~/.dotfiles/Brewfile
    if [[ -f "$BREWFILE" ]]; then

	echo "Installing brew bundle. Do you want to proceed? (y/n)"
	read -r confirmation
    	if [[ $confirmation =~ ^[Yy]$ ]]; then
	  log_message "Brewfile found. Installing packages and casks..."
	  /opt/homebrew/bin/brew bundle --file="$BREWFILE"
	  log_message "Brewfile processed."
	else
          log_message "Skipping brew bundle."
	fi
    else
        log_message "Brewfile not found. Skipping package and cask installation."
    fi
}

run_stow() {
    log_message "Starting dry-run for linking dotfiles using Stow..."
    cd ~/.dotfiles

    /opt/homebrew/bin/stow --ignore='^(?!\.).+' -n .
    echo "The above changes will be made. Do you want to proceed? (y/n)"
    read -r confirmation
    if [[ $confirmation =~ ^[Yy]$ ]]; then
        log_message "Applying Stow changes..."
    	/opt/homebrew/bin/stow --ignore='^(?!\.).+' .
        log_message "Dotfiles linked."
    else
        log_message "Stow changes cancelled."
    fi
}


update_macos_settings() {
    log_message "Starting to update macOS system-wide settings..."
    
    echo "WARNING: You are about to change system-wide settings. This can affect your system's security and functionality. Do you want to proceed? (y/n)"
    read -r proceed
    if [[ $proceed =~ ^[Yy]$ ]]; then
        disable_system_integrity_protection
        # Add other system-wide settings changes here
    else
        log_message "System-wide settings update cancelled."
    fi
}

disable_system_integrity_protection() {
    log_message "Preparing to disable System Integrity Protection (SIP)..."

    echo "WARNING: Disabling SIP reduces the security of your system and is generally not recommended. Do you want to proceed? (y/n)"
    read -r confirm_sip
    if [[ $confirm_sip =~ ^[Yy]$ ]]; then
        # Detect processor type
        if [[ $(uname -m) == 'arm64' ]]; then
            # Apple Silicon
            log_message "Apple Silicon detected. Preparing SIP commands for Apple Silicon..."
            echo "For macOS 13.x.x (Apple Silicon):"
            echo "Run 'csrutil enable --without fs --without debug --without nvram' in Recovery Mode."
            echo "For macOS 12.x.x (Apple Silicon):"
            echo "Run 'csrutil disable --with kext --with dtrace --with basesystem' in Recovery Mode."
            echo "After rebooting, open a terminal and run 'sudo nvram boot-args=-arm64e_preview_abi', then reboot again."
        else
            # Intel
            log_message "Intel processor detected. Preparing SIP commands for Intel..."
            echo "For Intel macOS 13.x.x, 12.x.x, or 11.x.x:"
            echo "Run 'csrutil disable --with kext --with dtrace --with nvram --with basesystem' in Recovery Mode."
        fi
        log_message "Please reboot into Recovery Mode to complete this process."
    else
        log_message "Disabling of SIP cancelled."
    fi
}

disable_system_integrity_protection() {
    log_message "Checking System Integrity Protection (SIP) status..."

    # Check SIP status
    if csrutil status | grep -q "disabled"; then
        log_message "SIP is already disabled."
        return
    fi

    log_message "Preparing to disable System Integrity Protection (SIP)..."

    echo "WARNING: Disabling SIP reduces the security of your system and is generally not recommended. Do you want to proceed? (y/n)"
    read -r confirm_sip
    if [[ $confirm_sip =~ ^[Yy]$ ]]; then
        # Get macOS version
        macOS_version=$(sw_vers -productVersion)
        log_message "macOS Version: $macOS_version"

        # Detect processor type
        if [[ $(uname -m) == 'arm64' ]]; then
            # Apple Silicon
            log_message "Apple Silicon detected. Preparing SIP commands for Apple Silicon..."
            if [[ $macOS_version == 13* ]]; then
                echo "Detected macOS 13.x.x (Apple Silicon)"
		csrutil enable --without fs --without debug --without nvram
            elif [[ $macOS_version == 12* ]]; then
                echo "Detected macOS 12.x.x (Apple Silicon)"
		csrutil disable --with kext --with dtrace --with basesystem
            fi
            echo "After rebooting, open a terminal and run \nsudo nvram boot-args=-arm64e_preview_abi\n, then reboot again."
        else
            # Intel
            log_message "Intel processor detected. Preparing SIP commands for Intel..."
            echo "Detected Intel macOS"
	    csrutil disable --with kext --with dtrace --with nvram --with basesystem
        fi
        log_message "Please reboot into Recovery Mode to complete this process."
    else
        log_message "Disabling of SIP cancelled."
    fi
}

main() {
    create_dotfiles_directory
    install_homebrew
    run_brewfile
    run_stow
    update_macos_settings
    log_message "Dotfiles setup complete."
}

main

