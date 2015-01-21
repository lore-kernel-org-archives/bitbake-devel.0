Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id AB92C65C7B
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 10:49:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t0LAmsX7016043 for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 10:49:16 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id RlnQiG5DpV7V for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 10:49:16 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t0LAn15p016097
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 10:49:12 GMT
Message-ID: <1421837341.1798.51.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 21 Jan 2015 10:49:01 +0000
X-Mailer: Evolution 3.12.7-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] command/cooker/knotty: Fix memres handling of command environment changes
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
X-List-Received-Date: Wed, 21 Jan 2015 10:49:24 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If the environment changes, we need memory resident bitbake to adapt to those
changes. This adds in functionality to handle this alongside the configuration
option handling code. This means that the common usage:

MACHINE=X bitbake Y

now works with the memory resident server.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index 60f9ac0..29b0a53 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -273,7 +273,8 @@ class CommandsSync:
 
     def updateConfig(self, command, params):
         options = params[0]
-        command.cooker.updateConfigOpts(options)
+        environment = params[1]
+        command.cooker.updateConfigOpts(options, environment)
 
 class CommandsAsync:
     """
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 95f65ac..9086f92 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -489,9 +489,29 @@ class BBCooker:
 
         self.handleCollections( self.data.getVar("BBFILE_COLLECTIONS", True) )
 
-    def updateConfigOpts(self,options):
+    def updateConfigOpts(self, options, environment):
         for o in options:
             setattr(self.configuration, o, options[o])
+        clean = True
+        for k in bb.utils.approved_variables():
+            if k in environment and k not in self.configuration.env:
+                logger.debug(1, "Updating environment variable %s to %s" % (k, environment[k]))
+                self.configuration.env[k] = environment[k]
+                clean = False
+            if k in self.configuration.env and k not in environment:
+                logger.debug(1, "Updating environment variable %s (deleted)" % (k))
+                del self.configuration.env[k]
+                clean = False
+            if k not in self.configuration.env and k not in environment:
+                 continue
+            if environment[k] != self.configuration.env[k]:
+                logger.debug(1, "Updating environment variable %s to %s" % (k, environment[k]))
+                self.configuration.env[k] = environment[k]
+                clean = False
+        if not clean:
+            logger.debug(1, "Base environment change, triggering reparse")
+            self.baseconfig_valid = False        
+            self.reset()
 
     def runCommands(self, server, data, abort):
         """
diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
index 2ceed2d..7eae761 100644
--- a/bitbake/lib/bb/cookerdata.py
+++ b/bitbake/lib/bb/cookerdata.py
@@ -69,14 +69,14 @@ class ConfigParameters(object):
             if bbpkgs:
                 self.options.pkgs_to_build.extend(bbpkgs.split())
 
-    def updateToServer(self, server):
+    def updateToServer(self, server, environment):
         options = {}
         for o in ["abort", "tryaltconfigs", "force", "invalidate_stamp", 
                   "verbose", "debug", "dry_run", "dump_signatures", 
                   "debug_domains", "extra_assume_provided", "profile"]:
             options[o] = getattr(self.options, o)
 
-        ret, error = server.runCommand(["updateConfig", options])
+        ret, error = server.runCommand(["updateConfig", options, environment])
         if error:
                 raise Exception("Unable to update the server configuration with local parameters: %s" % error)
 
diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index ebb9331..b986252 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -284,7 +284,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
 
     if not params.observe_only:
         params.updateFromServer(server)
-        params.updateToServer(server)
+        params.updateToServer(server, os.environ.copy())
         cmdline = params.parseActions()
         if not cmdline:
             print("Nothing to do.  Use 'bitbake world' to build everything, or run 'bitbake --help' for usage information.")



