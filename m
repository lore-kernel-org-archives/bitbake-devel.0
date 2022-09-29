Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75131C433FE
	for <webhook@archiver.kernel.org>; Thu, 29 Sep 2022 16:37:27 +0000 (UTC)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by mx.groups.io with SMTP id smtpd.web10.12466.1664469437698789576
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 29 Sep 2022 09:37:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=kEZgyhzp;
 spf=pass (domain: axis.com, ip: 195.60.68.18,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1664469438;
  x=1696005438;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AnLJppEhZl3H8RADzvf/RjneS8E87anxTVIdwOgfnCI=;
  b=kEZgyhzpdTcK9+ecztnavQK0UE6peP9M1INWi14voWsvAjGdIFkfzcvl
   8V1+t0hVkqQC1T9A65WnbSO1uS2TBCs0RR1XXvc00tcArVIA6J4fVb15J
   wDZncUrEbrCNFL/CuAr7t2ZhcqEqwWKMfF2jjglwKxDDeqfq/1pm2EvMC
   v9QmTdjcUZXM8bnCe9SsmEOwk62SJ5k5rXkEAdakMxDGa81w2wgc3C/Uk
   bizf9ZP4cVCP9DMVXS9UoYULnLr+JW9FbRdXZaJGjb+2bDbtJZq9CkRTQ
   acBXh9qFto2Mi5LDcKCzWRsqbAuypeOb908AwEARXsbP24M9yV6ZeXXhH
   g==;
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCHv2] utils: Add enable_loopback_networking()
Date: Thu, 29 Sep 2022 18:37:13 +0200
Message-ID: <20220929163713.3610263-1-pkj@axis.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 29 Sep 2022 16:37:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14000

From: Mattias Jernberg <mattiasj@axis.com>

It can be used to enable the loopback interface, typically after calling
disable_network().

Also correct a typo in a debug message.

Signed-off-by: Mattias Jernberg <mattias.jernberg@axis.com>
Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---

PATCHv2:
* Renamed loopback_up() to enable_loopback_networking().
* Do not call enable_loopback_networking() from disable_network().
* Corrected a typo in a debug message.

 bitbake/lib/bb/utils.py | 42 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index 92d44c5260..e6e21e20fe 100644
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
@@ -1603,6 +1605,44 @@ def set_process_name(name):
     except:
         pass
 
+def enable_loopback_networking():
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
+
+        # struct sockaddr_in ifr_addr { unsigned short family; uint16_t sin_port ; uint32_t in_addr; }
+        req = struct.pack("@H", AF_INET) + struct.pack("=H4B", 0, 127, 0, 0, 1)
+        netdev_req(fd, SIOCSIFADDR, req)
+
+        # short ifr_flags
+        flags = struct.unpack_from('@h', netdev_req(fd, SIOCGIFFLAGS))[0]
+        flags |= IFF_UP | IFF_RUNNING
+        netdev_req(fd, SIOCSIFFLAGS, struct.pack('@h', flags))
+
+        # struct sockaddr_in ifr_netmask
+        req = struct.pack("@H", AF_INET) + struct.pack("=H4B", 0, 255, 0, 0, 0)
+        netdev_req(fd, SIOCSIFNETMASK, req)
+
 def disable_network(uid=None, gid=None):
     """
     Disable networking in the current process if the kernel supports it, else
@@ -1624,7 +1664,7 @@ def disable_network(uid=None, gid=None):
 
     ret = libc.unshare(CLONE_NEWNET | CLONE_NEWUSER)
     if ret != 0:
-        logger.debug("System doesn't suport disabling network without admin privs")
+        logger.debug("System doesn't support disabling network without admin privs")
         return
     with open("/proc/self/uid_map", "w") as f:
         f.write("%s %s 1" % (uid, uid))

