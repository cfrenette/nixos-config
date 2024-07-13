{ pkgs, ... }:
{
  services.xserver = {
    desktopManager.gnome.enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };

  # GDM monitor config
  systemd.tmpfiles.rules = [
    "L+ /run/gdm/.config/monitors.xml - - - - ${pkgs.writeText "gdm-monitors.xml" ''
            <monitors version="2">
              <configuration>
                <logicalmonitor>
                  <x>0</x>
                  <y>0</y>
                  <scale>1.6</scale>
                  <primary>yes</primary>
                  <monitor>
                    <monitorspec>
                      <connector>eDP-1</connector>
                      <vendor>BOE</vendor>
                      <product>0x0bca</product>
                      <serial>0x00000000</serial>
                    </monitorspec>
                    <mode>
                      <width>2256</width>
                      <height>1504</height>
                      <rate>59.999</rate>
                    </mode>
                  </monitor>
                </logicalmonitor>
              </configuration>
              <configuration>
                <logicalmonitor>
                  <x>3840</x>
                  <y>0</y>
                  <scale>2</scale>
                  <monitor>
                    <monitorspec>
                      <connector>DP-10</connector>
                      <vendor>AUS</vendor>
                      <product>ASUS VG289</product>
                      <serial>0x0002ad37</serial>
                    </monitorspec>
                    <mode>
                      <width>3840</width>
                      <height>2160</height>
                      <rate>59.996</rate>
                    </mode>
                  </monitor>
                </logicalmonitor>
                <logicalmonitor>
                  <x>0</x>
                  <y>0</y>
                  <scale>2</scale>
                  <primary>yes</primary>
                  <monitor>
                    <monitorspec>
                      <connector>DP-6</connector>
                      <vendor>AUS</vendor>
                      <product>ASUS VG289</product>
                      <serial>0x0002ad32</serial>
                    </monitorspec>
                    <mode>
                      <width>3840</width>
                      <height>2160</height>
                      <rate>59.997</rate>
                    </mode>
                  </monitor>
                </logicalmonitor>
                <disabled>
                  <monitorspec>
                    <connector>eDP-1</connector>
                    <vendor>BOE</vendor>
                    <product>0x0bca</product>
                    <serial>0x00000000</serial>
                  </monitorspec>
                </disabled>
              </configuration>
              <configuration>
                <logicalmonitor>
                  <x>3840</x>
                  <y>0</y>
                  <scale>2</scale>
                  <monitor>
                    <monitorspec>
                      <connector>DP-10</connector>
                      <vendor>AUS</vendor>
                      <product>ASUS VG289</product>
                      <serial>0x0002ad37</serial>
                    </monitorspec>
                    <mode>
                      <width>3840</width>
                      <height>2160</height>
                      <rate>59.996</rate>
                    </mode>
                  </monitor>
                </logicalmonitor>
                <logicalmonitor>
                  <x>0</x>
                  <y>0</y>
                  <scale>2</scale>
                  <primary>yes</primary>
                  <monitor>
                    <monitorspec>
                      <connector>DP-6</connector>
                      <vendor>AUS</vendor>
                      <product>ASUS VG289</product>
                      <serial>0x0002ad32</serial>
                    </monitorspec>
                    <mode>
                      <width>3840</width>
                      <height>2160</height>
                      <rate>59.997</rate>
                    </mode>
                  </monitor>
                </logicalmonitor>
              </configuration>
            </monitors>
        ''}"
  ];

  environment.gnome.excludePackages = (with pkgs; [
    gedit
    gnome-photos
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    cheese
    epiphany
    geary
    gnome-contacts
    gnome-maps
    gnome-music
    gnome-weather
    totem
  ]);
}

