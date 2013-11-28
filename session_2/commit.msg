Fix false negative ssh connection check.

  Tempest usually start the ssh connection attempts before the
  sshd is fully configured. If tempest does do an authentication atempt when      the cloud image reconfiguring the sshd or setting up the public key, we
  can see not handled SSH exception within the timeout period.
  The not handled SSH exception leads to false negative connection check.

  This change extending the set of the not fatal exceptions during
  connection wait to SSH exception which includes the already accepted            authentication exception family.

  The RemoteClient can authenticate become obsolete, when the
  test_connection_auth become the part of it __init__ metod.
  Removing all usage of the can authenticate and the method itself.
  
  test_connection_auth method changed to exception raiser method, in order
  to avoid the unwanted catch-and-raise-new-exception code from the               RemoteClient.
  
  Removing test_can_log_into_created_server because it does not test
  anything new, all test cases which uses ssh does the same job.
  
  Use similar ssh connectivity check with the test_network_basic_ops,
  as with all other test cases, so using the implicit conection validation of     the RemoteClient.
  
  Change-Id: Ia2599f7f2c2fdc6fcbf7ad3337d82adcc50e4d16
