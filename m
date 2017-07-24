Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id B4BD578234
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Jul 2017 13:00:00 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v6OCxxWm019021
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Mon, 24 Jul 2017 14:00:00 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1dZcxr-0003rA-Jc; Mon, 24 Jul 2017 13:59:59 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 24 Jul 2017 13:59:57 +0100
Message-Id: <1500901197-14779-2-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1500901197-14779-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1500901197-14779-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Mon, 24 Jul 2017 14:00:00 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH 2/2] cooker/process: Drop server_main function
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
X-List-Received-Date: Mon, 24 Jul 2017 13:00:02 -0000

Now that there is only one server, this abstraction is no longer needed
and causes indrection/confusion. The server shutdown is also broken with
the cooker post_server calls happening too late, leading to "lock held"
warnings in the logs if PRServ is enabled.

Remove the abstraction and put the shutdown calls in the right order
with respect to the locking.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py         | 22 ----------------------
 lib/bb/server/process.py | 22 +++++++++++++++++++++-
 2 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 1625d3c..d6e6919 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1585,28 +1585,6 @@ class BBCooker:
         self.databuilder.reset()
         self.data = self.databuilder.data
 
-def server_main(cooker, func, *args):
-    cooker.pre_serve()
-
-    if cooker.configuration.profile:
-        try:
-            import cProfile as profile
-        except:
-            import profile
-        prof = profile.Profile()
-
-        ret = profile.Profile.runcall(prof, func, *args)
-
-        prof.dump_stats("profile.log")
-        bb.utils.process_profilelog("profile.log")
-        print("Raw profiling information saved to profile.log and processed statistics to profile.log.processed")
-
-    else:
-        ret = func(*args)
-
-    cooker.post_serve()
-
-    return ret
 
 class CookerExit(bb.event.Event):
     """
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 01d9f2f..85beaae 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -103,9 +103,27 @@ class ProcessServer(multiprocessing.Process):
         except:
             pass
 
-        bb.cooker.server_main(self.cooker, self.main)
+        if self.cooker.configuration.profile:
+            try:
+                import cProfile as profile
+            except:
+                import profile
+            prof = profile.Profile()
+
+            ret = profile.Profile.runcall(prof, self.main)
+
+            prof.dump_stats("profile.log")
+            bb.utils.process_profilelog("profile.log")
+            print("Raw profiling information saved to profile.log and processed statistics to profile.log.processed")
+
+        else:
+            ret = self.main()
+
+        return ret
 
     def main(self):
+        self.cooker.pre_serve()
+
         bb.utils.set_process_name("Cooker")
 
         ready = []
@@ -184,6 +202,8 @@ class ProcessServer(multiprocessing.Process):
         except:
             pass
 
+        self.cooker.post_serve()
+
         # Remove the socket file so we don't get any more connections to avoid races
         os.unlink(self.sockname)
         self.sock.close()
-- 
2.7.4


