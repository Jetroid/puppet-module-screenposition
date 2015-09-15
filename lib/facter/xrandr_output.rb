# xrandr_output.rb
# Fact to get the output of xrandr to find out the monitor details

    Facter.add('xrandr_output') do
      setcode do
        Facter::Util::Resolution.exec('su -c "DISPLAY=:0 xrandr -q --verbose" -s /bin/sh lightdm')
      end
    end
