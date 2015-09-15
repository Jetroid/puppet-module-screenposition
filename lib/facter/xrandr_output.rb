# xrandr_output.rb
# Fact to get the output of xrandr to find out the monitor details

    Facter.add('xrandr_output') do
      setcode do
        Facter::Util::Resolution.exec('/usr/local/bin/xrandr-fact-script')
      end
    end
