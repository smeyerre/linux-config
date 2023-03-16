# linux-config

Sets up new computer after an Arch linux installation.
Look at the [migration guide](https://wiki.archlinux.org/title/Migrate_installation_to_new_hardware) for more information.

Automatically configures:
- pacman packages
- Aur packages
- bash dotfiles
- i3 (optional)
- vim (optional)

## To run setup:
 - Follow the Arch [installation guide](https://wiki.archlinux.org/title/Installation_guide) till the end but do not reboot
 - Ensure you are signed in as your user account
 - Set up git:
     ```
     sudo pacman -S git
     ssh-keygen -t ed25519 -C "your_email@example.com"
     eval "$(ssh-agent -s)"
     ssh-add ~/.ssh/id_ed25519
     ```
    - Add your public key to your GitHub account
 - Clone the repo and run the script!
    ```
    git clone git@github.com:smeyerre/linux-config.git ~/linux-config
    cd ~/linux-config
    ./setup.sh
    ```

# TODO
 - Change some absolute path home directory references to "~"
 - Setup remaining config files eg. `/etc/`, `/usr/`, ...
