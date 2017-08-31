Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 5D2307842E
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 31 Aug 2017 16:38:42 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v7VGcf8p028719
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Thu, 31 Aug 2017 17:38:42 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1dnSUL-0003FL-6p; Thu, 31 Aug 2017 17:38:41 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 31 Aug 2017 17:38:32 +0100
Message-Id: <1504197520-12428-2-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1504197520-12428-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1504197520-12428-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Thu, 31 Aug 2017 17:38:42 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH 02/10] cooker: Handle datastore tracking for showEnvironment server side only
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
X-List-Received-Date: Thu, 31 Aug 2017 16:38:46 -0000

The current passing of "tracking" backwards and forwards, client to server
is ugly and complex and error prone. Instead, set this during showEnvironment
commands triggering a reset there if/as required.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py     | 11 ++++++++++-
 lib/bb/cookerdata.py |  7 +------
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 2ee349e..ad08c47 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -415,7 +415,7 @@ class BBCooker:
         self.ui_cmdline = cmdline
         clean = True
         for o in options:
-            if o in ['prefile', 'postfile', 'tracking']:
+            if o in ['prefile', 'postfile']:
                 server_val = getattr(self.configuration, "%s_server" % o, None)
                 if not options[o] and server_val:
                     # restore value provided on server start
@@ -486,6 +486,12 @@ class BBCooker:
         if not pkgs_to_build:
             pkgs_to_build = []
 
+        orig_tracking = self.configuration.tracking
+        if not orig_tracking:
+            self.enableDataTracking()
+            self.reset()
+
+
         if buildfile:
             # Parse the configuration here. We need to do it explicitly here since
             # this showEnvironment() code path doesn't use the cache
@@ -530,6 +536,9 @@ class BBCooker:
             if envdata.getVarFlag(e, 'func', False) and envdata.getVarFlag(e, 'python', False):
                 logger.plain("\npython %s () {\n%s}\n", e, envdata.getVar(e, False))
 
+        if not orig_tracking:
+            self.disableDataTracking()
+            self.reset()
 
     def buildTaskData(self, pkgs_to_build, task, abort, allowincomplete=False):
         """
diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 55c6ea8..197db62 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -41,10 +41,6 @@ class ConfigParameters(object):
 
         self.options.pkgs_to_build = targets or []
 
-        self.options.tracking = False
-        if hasattr(self.options, "show_environment") and self.options.show_environment:
-            self.options.tracking = True
-
         for key, val in self.options.__dict__.items():
             setattr(self, key, val)
 
@@ -76,7 +72,7 @@ class ConfigParameters(object):
         for o in ["abort", "tryaltconfigs", "force", "invalidate_stamp",
                   "verbose", "debug", "dry_run", "dump_signatures",
                   "debug_domains", "extra_assume_provided", "profile",
-                  "prefile", "postfile", "tracking", "server_timeout"]:
+                  "prefile", "postfile", "server_timeout"]:
             options[o] = getattr(self.options, o)
 
         ret, error = server.runCommand(["updateConfig", options, environment, sys.argv])
@@ -158,7 +154,6 @@ class CookerConfiguration(object):
             if key in parameters.options.__dict__:
                 setattr(self, key, parameters.options.__dict__[key])
         self.env = parameters.environment.copy()
-        self.tracking = parameters.tracking
 
     def setServerRegIdleCallback(self, srcb):
         self.server_register_idlecallback = srcb
-- 
2.7.4


