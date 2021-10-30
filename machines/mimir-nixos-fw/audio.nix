{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ libjack2 jack2 qjackctl ];
  security.pam.loginLimits = [
    { domain = "@audio"; item = "memlock"; type = "*"; value = "unlimited"; }
    { domain = "@audio"; item = "rtprio"; type = "*"; value = "99"; }
    { domain = "@audio"; item = "nofile"; type = "soft"; value = "99999"; }
    { domain = "@audio"; item = "nofile"; type = "hard"; value = "99999"; }
  ];

  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudio.override { jackaudioSupport = true; };

  services.jack = {
    jackd.enable = false;
    # support ALSA only programs via ALSA JACK PCM plugin
    alsa.enable = false;
    # support ALSA only programs via loopback device (supports programs like Steam)
    loopback = {
      enable = true;
      # buffering parameters for dmix device to work with ALSA only semi-professional sound programs
      #dmixConfig = ''
      #  period_size 2048
      #'';
    };
  };
}
