# == Class: screenposition
#
# A module to rotate the orientation of the monitors
#
class screenposition (
  $ensure              = $screenposition::params::ensure,
  $rotationpattern     = $screenposition::params::rotationpattern,
) inherits screenposition::params {

  validate_re($ensure, '^(present|absent)$',"${ensure} is not allowed for the 'ensure' parameter. Allowed values are 'present' and 'absent'.")

  anchor { 'screenposition::begin': } ->
  class { '::screenposition::install': } ->
  anchor { 'screenposition::end': }

}
