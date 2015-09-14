class screenposition::install (
  $ensure          = $screenposition::ensure,
  $rotationpattern = $screenposition::rotationpattern,
) {

  package{'x11-xserver-utils':
    ensure  => $ensure,
  }

  # Script to dynamically rotate the X session
  file{'/usr/local/bin/rotate-monitors':
    ensure  => $ensure,
    mode    => "0755",
    content => template('screenposition/rotate-monitors.erb'),
  } -> 

  # Autostart entry to execute the previous script
  file{'/etc/xdg/autostart/rotate.desktop':
    ensure  => $ensure,
    mode    => "0644",
    source  => 'puppet:///modules/screenposition/rotate.desktop',
  }

  include sudo ->
  
  # Hack to allow root to run our factscript as lightdm without asking for a password
  sudo::conf { 'screenrotatehack':
    priority => 10,
    content  => "root ALL=(lightdm) NOPASSWD: /usr/local/bin/xrandrfact.sh",
  } ->

  # The fact script to get xrandr info
  file{'/usr/local/bin/xrandrfact.sh':
    ensure  => $ensure,
    mode    => "0755",
    source  => 'puppet:///modules/screenposition/xrandrfact.sh',
  } 

  # Set the xml for the login greeter
  file{'/var/lib/lightdm/.config/monitors.xml':
    ensure  => $ensure,
    mode    => "0644",
    content => template('screenposition/monitors.xml.erb'),
  }

}
