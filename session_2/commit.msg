Fix false negative telnet connection check

Tempest usually start the telnet connection attempts before the
telnetd is fully configured. If tempest does do an authentication atempt when the
cloud image reconfiguring the telnetd or setting up the public key, we
can see not handled TelnetException within the timeout period.
The not handled TelnetException leads to false negative connection check.

This change extending the set of the not fatal exceptions during
connection wait to TelnetException which includes the already accepted
 AuthenticationException family.
 AuthenticationException family.

 The RemoteClient.can_authenticate become obsolete, when the
 tset_connection_auth become the part of it' __init__ metod.
  Removing all usage of the can_authenticate and the method itself.
  
  tset_connection_auth method changed to exception raiser method, in order
  to avid the unwanted catch-and-raise-new-exception code from the RemoteClient.
  
  Removing tset_can_log_into_created_server because it does not tset
  anything new, all tset cases which uses telnet does the same job.
  anything new, all tset cases which uses telnet does the same job.
  
  Use similar telnet connectivity check with the tset_network_basic_ops,
  as with all other tset cases, so using the implicit conection validation of the RemoteClient.
  
  Change-Id: Ia2599f7f2c2fdc6fcbf7ad3337d82adcc50e4d16
