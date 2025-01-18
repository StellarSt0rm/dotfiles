{ config, lib, pkgs, ... }: {
  users.users.gemini = {
    isNormalUser = true;
    
    home = "/home/gemini";
    shell = pkgs.fish;
    
    extraGroups = [ "wheel" "networkManager" ];
  };

  programs.fish.enable = true;

  # Set set time zone to Europe/Madrid
  time.timeZone = "Europe/Madrid";
  
  # Set language to en_US
  i18n.defaultLocale = "en_US.UTF-8";
  
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  
  # Configure keyboard layout and variant
  services.xserver.xkb = {
    layout = "es";
    variant = "";
  };
  
  console.keyMap = "es";
  
  # Set user profile picture
  system.activationScripts.script.text = ''
    mkdir -p /var/lib/AccountsService/{icons,users}
    cp ${toString ./modules/gnome/user-icon.png} /var/lib/AccountsService/icons/gemini
    echo -e "[User]\nIcon=/var/lib/AccountsService/icons/gemini\n" > /var/lib/AccountsService/users/gemini

    chown root:root /var/lib/AccountsService/users/gemini
    chmod 0600 /var/lib/AccountsService/users/gemini
 
    chown root:root /var/lib/AccountsService/icons/gemini
    chmod 0444 /var/lib/AccountsService/icons/gemini
  '';
}
