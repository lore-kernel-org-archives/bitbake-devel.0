Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id E926A739C9
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Mar 2015 10:30:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t2AAU05e028815; Tue, 10 Mar 2015 10:30:00 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id oQlbiQaAVj-1; Tue, 10 Mar 2015 10:30:00 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t2AATkT7028806
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 10 Mar 2015 10:29:57 GMT
Message-ID: <1425983386.9701.47.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 10 Mar 2015 10:29:46 +0000
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Subject: cooker/server: Fix up 100% CPU usage at idle
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 10 Mar 2015 10:30:04 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The recent inotify changes are causing a 100% cpu usage issue in the
idle handlers. To avoid this, we update the idle functions to optionally
report a float value which is the delay before the function needs to be
called again. 1 second is fine for the inotify handler, in reality its
more like 0.1s due to the default idle function sleep.

This reverts performance regressions of 1.5 minutes on a kernel build
and ~4-5 minutes on a image from scratch.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 47dc8a3..68aa532 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -142,7 +142,7 @@ class BBCooker:
                     # read notified events and enqeue them
                     n.read_events()
                     n.process_events()
-            return True
+            return 1.0
 
         self.configuration.server_register_idlecallback(_process_inotify_updates, [self.confignotifier, self.notifier])
 
diff --git a/bitbake/lib/bb/server/process.py b/bitbake/lib/bb/server/process.py
index 7671b26..c9286dd 100644
--- a/bitbake/lib/bb/server/process.py
+++ b/bitbake/lib/bb/server/process.py
@@ -135,6 +135,9 @@ class ProcessServer(Process, BaseImplServer):
                     nextsleep = None
                 elif retval is True:
                     nextsleep = None
+                elif isinstance(retval, float):
+                    if (retval < nextsleep):
+                        nextsleep = retval
                 elif nextsleep is None:
                     continue
                 else:
diff --git a/bitbake/lib/bb/server/xmlrpc.py b/bitbake/lib/bb/server/xmlrpc.py
index 17f3d9d..75ec855 100644
--- a/bitbake/lib/bb/server/xmlrpc.py
+++ b/bitbake/lib/bb/server/xmlrpc.py
@@ -242,6 +242,9 @@ class XMLRPCServer(SimpleXMLRPCServer, BaseImplServer):
                         del self._idlefuns[function]
                     elif retval is True:
                         nextsleep = 0
+                    elif isinstance(retval, float):
+                        if (retval < nextsleep):
+                            nextsleep = retval
                     else:
                         fds = fds + retval
                 except SystemExit:



