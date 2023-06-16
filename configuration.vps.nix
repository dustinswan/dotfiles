# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda"; # or "nodev" for efi only

  networking.hostName = "dustinswan"; # Define your hostname.

  time.timeZone = "US/Mountain";

  environment.systemPackages = [ pkgs.docker-compose ];

  nixpkgs.config.allowUnfree = true;

  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "no";

  programs.mosh.enable = true;

  security.acme = {
    acceptTerms = true;
    defaults.email = "dustin@dustinswan.com";
  };

  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    appendHttpConfig = "limit_req_zone $binary_remote_addr zone=mylimit:10m rate=10r/s;";

    virtualHosts = {
      "dustinswan.com" = {
        forceSSL = true;
        enableACME = true;
        serverAliases = ["www.dustinswan.com"];
        root = "/web/dustinswan.com";
        extraConfig = "add_header 'Access-Control-Allow-Origin' '*';";
      };

      "rockwall.farm" = {
        forceSSL = true;
        enableACME = true;
        serverAliases = ["rwf.dustinswan.com" "www.rockwall.farm"];
        root = "/web/rwf";
      };

      "git.dustinswan.com" = {
        forceSSL = true;
        enableACME = true;

        locations."/" = {
          proxyPass = "http://localhost:3000";
        };
      };
    };
  };

  services.gitea = { # port 3000
    enable = true;
    settings = {
      server = {
        DOMAIN = "https://dustinswan.com";
        ROOT_URL = "https://git.dustinswan.com";
        # CERT_FILE = "/var/lib/acme/git.dustinswan.com/cert.pem";
        # KEY_FILE = "/var/lib/acme/git.dustinswan.com/key.pem";
      };
      service.DISABLE_REGISTRATION = true;
    };
  };

  services.molly-brown = { # port 1965
    enable = true;
    hostName = "dustinswan.com";
    certPath = "/var/lib/acme/dustinswan.com/cert.pem";
    keyPath = "/var/lib/acme/dustinswan.com/key.pem";
    docBase = "/srv/gemini"; # /var/lib/molly-brown
  };

  systemd.services.molly-brown.serviceConfig.SupplementaryGroups =
    [ config.security.acme.certs."dustinswan.com".group ];

  networking.firewall.allowedTCPPorts = [ 80 443 1965 9001 ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  virtualisation.docker.enable = true;

  users.extraUsers.dustinswan = {
    isNormalUser = true;
    extraGroups = ["wheel" "docker"];
    uid = 1000;
    shell = "/home/dustinswan/.nix-profile/bin/zsh";
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "17.09"; # Did you read the comment?
}
