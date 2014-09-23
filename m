Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 813AD60167
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 23 Sep 2014 11:58:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	s8NBwLPb016641 for <bitbake-devel@lists.openembedded.org>;
	Tue, 23 Sep 2014 12:58:21 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 5Cmx7ioU48pZ for <bitbake-devel@lists.openembedded.org>;
	Tue, 23 Sep 2014 12:58:21 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	s8NBwJqW016638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 23 Sep 2014 12:58:20 +0100
Message-ID: <1411473502.15825.31.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 23 Sep 2014 12:58:22 +0100
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Subject: [PATCH] knotty: Ensure commandline parameters are updated in memres server
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
X-List-Received-Date: Tue, 23 Sep 2014 11:58:26 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

When using options like -k, -f, -v and so on with the memory resident
server, they'd currently only be set on the initial values passed to
the original command. This ensures they now match those specified
on the commandline for the options where this makes sense.

To make this work, a command to update the options on the server side
is required so this is added.

[YOCTO #5292]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index 0cfed0a..60f9ac0 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -271,6 +271,10 @@ class CommandsSync:
     # we always take and leave the cooker in state.initial
     setFeatures.readonly = True
 
+    def updateConfig(self, command, params):
+        options = params[0]
+        command.cooker.updateConfigOpts(options)
+
 class CommandsAsync:
     """
     A class of asynchronous commands
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index f463603..c6c69c3 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -371,6 +371,10 @@ class BBCooker:
 
         self.handleCollections( self.data.getVar("BBFILE_COLLECTIONS", True) )
 
+    def updateConfigOpts(self,options):
+        for o in options:
+            setattr(self.configuration, o, options[o])
+
     def runCommands(self, server, data, abort):
         """
         Run any queued asynchronous command
diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
index 60a6d51..470d538 100644
--- a/bitbake/lib/bb/cookerdata.py
+++ b/bitbake/lib/bb/cookerdata.py
@@ -69,6 +69,17 @@ class ConfigParameters(object):
             if bbpkgs:
                 self.options.pkgs_to_build.extend(bbpkgs.split())
 
+    def updateToServer(self, server):
+        options = {}
+        for o in ["abort", "tryaltconfigs", "force", "invalidate_stamp", 
+                  "verbose", "debug", "dry_run", "dump_signatures", 
+                  "debug_domains", "extra_assume_provided", "profile"]:
+            options[o] = getattr(self.options, o)
+
+        ret, error = server.runCommand(["updateConfig", options])
+        if error:
+                raise Exception("Unable to update the server configuration with local parameters: %s" % error)
+
     def parseActions(self):
         # Parse any commandline into actions
         action = {'action':None, 'msg':None}
diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 33d78fc..ebb9331 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -284,6 +284,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
 
     if not params.observe_only:
         params.updateFromServer(server)
+        params.updateToServer(server)
         cmdline = params.parseActions()
         if not cmdline:
             print("Nothing to do.  Use 'bitbake world' to build everything, or run 'bitbake --help' for usage information.")



