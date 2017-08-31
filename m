Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 59BEB78424
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 31 Aug 2017 16:38:42 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v7VGcf2F028722
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Thu, 31 Aug 2017 17:38:42 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1dnSUL-0003Fb-8x; Thu, 31 Aug 2017 17:38:41 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 31 Aug 2017 17:38:35 +0100
Message-Id: <1504197520-12428-5-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1504197520-12428-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1504197520-12428-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Thu, 31 Aug 2017 17:38:42 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH 05/10] cooker: Allow changes in PRSERV_HOST to be responded to
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
X-List-Received-Date: Thu, 31 Aug 2017 16:38:45 -0000

When we reload the configuration, PRSERV_HOST can change. Therefore
restart the PR Server depending on the new configuration at reparse.

Note that the server has to be started from the right process, it
can't be in the UI which shuts down as that shutdown triggers a shutdown
of its children and the PR Server shuts down too. This is why we need
pre_serve() which ensures its executed in the right context.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 5ee1c0a..a2c1b40 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -379,6 +379,13 @@ class BBCooker:
         self.baseconfig_valid = True
         self.parsecache_valid = False
 
+    def handlePRServ(self):
+        # Setup a PR Server based on the new configuration
+        try:
+            self.prhost = prserv.serv.auto_start(self.data)
+        except prserv.serv.PRServiceConfigError as e:
+            bb.fatal("Unable to start PR Server, exitting")
+
     def enableDataTracking(self):
         self.configuration.tracking = True
         if hasattr(self, "data"):
@@ -1468,6 +1475,7 @@ class BBCooker:
         if not self.baseconfig_valid:
             logger.debug(1, "Reloading base configuration data")
             self.initConfigurationData()
+            self.handlePRServ()
 
     # This is called for all async commands when self.state != running
     def updateCache(self):
@@ -1571,14 +1579,9 @@ class BBCooker:
         return pkgs_to_build
 
     def pre_serve(self):
-        # Empty the environment. The environment will be populated as
-        # necessary from the data store.
-        #bb.utils.empty_environment()
-        try:
-            self.prhost = prserv.serv.auto_start(self.data)
-        except prserv.serv.PRServiceConfigError:
-            bb.event.fire(CookerExit(), self.data)
-            self.state = state.error
+        # We now are in our own process so we can call this here.
+        # PRServ exits if its parent process exits
+        self.handlePRServ()
         return
 
     def post_serve(self):
-- 
2.7.4


