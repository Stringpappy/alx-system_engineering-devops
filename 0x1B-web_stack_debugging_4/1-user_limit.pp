# This Puppet manifest addresses the issue of having a high number of open files by updating
# the file descriptor limits in the system's limits configuration.

# Update the 'nofile' limit for user processes in /etc/security/limits.conf
# Change 'nofile 5' to 'nofile 50000' to increase the limit
exec {'replace-1':
  provider => shell,
  command  => 'sudo sed -i "s/nofile 5/nofile 50000/" /etc/security/limits.conf',
  # Ensure this command runs before applying the second replacement
  before   => Exec['replace-2'],
}

# Update the 'nofile' limit for system-wide settings in /etc/security/limits.conf
# Change 'nofile 4' to 'nofile 40000' to increase the limit
exec {'replace-2':
  provider => shell,
  command  => 'sudo sed -i "s/nofile 4/nofile 40000/" /etc/security/limits.conf',
}
