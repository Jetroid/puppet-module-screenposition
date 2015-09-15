# xrandr_output.rb
# Fact to get the output of xrandr to find out the monitor details

    Facter.add('xrandr_output') do  
      setcode do
        # Make cache directory and file just in case
        Facter::Core::Execution.exec('mkdir -p /var/lib/lightdm/.config/ && touch /var/lib/lightdm/.config/xrandr-cache;')

        # Try to get xrandr verbose output by asking lightdm (will work when nobody is logged in and the x greeter is shown.)
        local=Facter::Core::Execution.exec('su -c "DISPLAY=:0 xrandr -q --verbose" -s /bin/sh lightdm')
        # Also get the latest cached version, which will work assuming we have ever been successful in the past.
        cached=Facter::Core::Execution.exec('cat /var/lib/lightdm/.config/xrandr-cache')
      
        # 00ffffffffffff00 should be found in the EDID in a correct output 
        # If local attempt worked (ie: edid found), use that and update the cache
        if local =~ /.*00ffffffffffff00/
          Facter::Core::Execution.exec("echo '#{local}' > /var/lib/lightdm/.config/xrandr-cache;")
          local
        # Else, check the cache is fine (edid found) and use that,
        elsif cached =~ /.*00ffffffffffff00/
          cached
        # else fail, logging to syslog
        else
          Facter::Util::Resolution.exec('logger -t "XRANDR-Fact (Screen-Rotation-Puppet-Module)" Failed to retrieve xrandr verbose output!')
          ""
        end     
      end
    end
