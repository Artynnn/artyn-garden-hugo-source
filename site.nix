# to deploy: morph deploy site.nix switch
{
  nixie = { modulesPath, pkgs, lib, ... }: {
    imports = lib.optional (builtins.pathExists ./do-userdata.nix) ./do-userdata.nix ++ [
      (modulesPath + "/virtualisation/digital-ocean-config.nix")
    ];

    deployment.targetHost = "164.90.140.81";
    deployment.targetUser = "root";
    networking.hostName = "nixie";

    # 80: HTTP
    # 443: HTTPS
    # 4533: Navidrome
    # 1965: Gemini
    networking.firewall.allowedTCPPorts = [ 80 443 4533 1965];

    # HTTP web server
    services.nginx = {
      enable = true;
      virtualHosts."artyn.me" = {
        addSSL = true;
        enableACME = true;
        root = "/var/www/artyn.me";
      };
    };

    # audio server?
    services.navidrome = {
      enable = true;
      settings = {
        Port = 4444;
        Address = "164.90.140.81";
        MusicFolder = "/var/www/music";
      };
    };

    # gemini server:
    services.agate = {
      enable = true;
      package = pkgs.agate;
      language = "en";
      hostnames = [ "artyn.me" ];
      addresses = [ "164.90.140.81:1965"];
      extraArgs = [
        "--log-ip"
      ];
      # contentDir = "/var/lib/agate/content";
      contentDir = "/var/gemini/artyn.me/";
      certificatesDir = "/var/lib/agate/certificates";
      onlyTls_1_3 = false;
    };


    services.ergo = {
       enable = true;
       group = "ergo";
    };
    

    # for HTTPS:
    security.acme.acceptTerms = true;
    security.acme.certs = {
      "artyn.me".email = "felipeconde3@gmail.com";
    };

    # installing packages:
    environment.systemPackages = with pkgs; [
      hugo
      git
    ];
  };
}
