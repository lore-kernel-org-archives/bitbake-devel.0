Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F979C6FA82
	for <webhook@archiver.kernel.org>; Fri, 23 Sep 2022 10:16:22 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web10.5959.1663928179517273005
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 23 Sep 2022 03:16:20 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@axis.com
 header.s=axis-central1 header.b=Y+EvnB8u;
 spf=pass (domain: axis.com, ip: 195.60.68.17,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1663928179;
  x=1695464179;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VZLaBKzeCXHyb6yJ2K4m3EpJtzgyXTXn3FPZVZmBSoQ=;
  b=Y+EvnB8u98grx4Vvfl5LAO74f5Vj03yK3fLnqBpSDJiUxwzeGWWaY+tV
   4ZcWhhb4+INcMV20t1FU09XjcfSbeSY4g2q3wrbU4Z2+llIxV3Vx3rUy5
   F7BBZ6BmqO+M/4wBXv706D97gWN0+Bh+tk0RIZlThhb+gA+n4f+zH8ScV
   ppSiSR/NERZccUCsEud9gMCr3W3al9VXecJSm0mBRmGvel+cTSN11i+Pl
   pVA9cXAUxzOTkHXgSv39/yf389jqEjhJdFUhilL14nwEpne1O8WDfb9JJ
   npeHE6MIRRCsJuAGi127nCgpzeoBlk7EzJqPH6hXRqRLuYqNE50jwO0VD
   A==;
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] utils: Enable the loopback interface in disable_network()
Date: Fri, 23 Sep 2022 12:16:13 +0200
Message-ID: <20220923101613.1096056-1-pkj@axis.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 23 Sep 2022 10:16:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13989

From: Mattias Jernberg <mattiasj@axis.com>

This allows, e.g., gRPC within the host to be used even when
networking is disabled.

Signed-off-by: Mattias Jernberg <mattias.jernberg@axis.com>
Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---

In our case, we have a wrapper for make (bear from
https://github.com/rizsotto/Bear) that is automatically enabled when
externalsrc is used. This creates a compile_commands.json file, which,
e.g., VS Code can make use of. The problem here is that bear uses gRPC
to communicate with itself and this does not work when all network
communications are disabled. Enabling the loopback interface resolves
this problem.

 bitbake/lib/bb/utils.py | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index 92d44c5260..2d37c50bac 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -29,6 +29,8 @@ import collections
 import copy
 import ctypes
 import random
+import socket
+import struct
 import tempfile
 from subprocess import getstatusoutput
 from contextlib import contextmanager
@@ -1603,6 +1605,41 @@ def set_process_name(name):
     except:
         pass
 
+def loopback_up():
+    # From bits/ioctls.h
+    SIOCGIFFLAGS = 0x8913
+    SIOCSIFFLAGS = 0x8914
+    SIOCSIFADDR = 0x8916
+    SIOCSIFNETMASK = 0x891C
+
+    # if.h
+    IFF_UP = 0x1
+    IFF_RUNNING = 0x40
+
+    # bits/socket.h
+    AF_INET = 2
+
+    # char ifr_name[IFNAMSIZ=16]
+    ifr_name = struct.pack("@16s", b"lo")
+    def netdev_req(fd, req, data = b""):
+        # Pad and add interface name
+        data = ifr_name + data + (b'\x00' * (16 - len(data)))
+        # Return all data after interface name
+        return fcntl.ioctl(fd, req, data)[16:]
+
+    with socket.socket(socket.AF_INET, socket.SOCK_DGRAM, socket.IPPROTO_IP) as sock:
+        fd = sock.fileno()
+        # struct sockaddr_in ifr_addr { unsigned short family; uint16_t sin_port ; uint32_t in_addr; }
+        req = struct.pack("@H", AF_INET) + struct.pack("=H4B", 0, 127, 0, 0, 1)
+        netdev_req(fd, SIOCSIFADDR, req)
+        # short ifr_flags
+        flags = struct.unpack_from('@h', netdev_req(fd, SIOCGIFFLAGS))[0]
+        flags |= IFF_UP | IFF_RUNNING
+        netdev_req(fd, SIOCSIFFLAGS, struct.pack('@h', flags))
+        # struct sockaddr_in ifr_netmask
+        req = struct.pack("@H", AF_INET) + struct.pack("=H4B", 0, 255, 0, 0, 0)
+        netdev_req(fd, SIOCSIFNETMASK, req)
+
 def disable_network(uid=None, gid=None):
     """
     Disable networking in the current process if the kernel supports it, else
@@ -1626,6 +1663,10 @@ def disable_network(uid=None, gid=None):
     if ret != 0:
         logger.debug("System doesn't suport disabling network without admin privs")
         return
+
+    # Enable the loopback interface
+    loopback_up()
+
     with open("/proc/self/uid_map", "w") as f:
         f.write("%s %s 1" % (uid, uid))
     with open("/proc/self/setgroups", "w") as f:

