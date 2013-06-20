Return-Path: <cristiana.voicu@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 11708608BE
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Jun 2013 10:18:06 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 20 Jun 2013 03:19:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,903,1363158000"; d="scan'208";a="356656111"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.72])
	by fmsmga002.fm.intel.com with ESMTP; 20 Jun 2013 03:18:05 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 20 Jun 2013 13:19:42 +0300
Message-Id: <1371723585-27966-3-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1371723585-27966-1-git-send-email-cristiana.voicu@intel.com>
References: <1371723585-27966-1-git-send-email-cristiana.voicu@intel.com>
Subject: [PATCH_V2 2/5] bitbake & hob: modify some commands and call them from hob
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 20 Jun 2013 10:18:06 -0000

This patch adds a new command to create an extra configuration
file, in order to create it from Hob.
Also, it calls the enable/disable data tracking when needed.
Modified the prefiles and postfiles variables because the cooker
expects some lists.

Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/command.py                   |   16 +++++++++++++---
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    2 ++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index 5f696c2..9dc38ec 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -217,11 +217,21 @@ class CommandsSync:
         return command.cooker.generateNewImage(image, base_image, package_queue)
 
     def setVarFile(self, command, params):
+        """
+        Save a variable in a file; used for saving in a configuration file
+        """
         var = params[0]
         val = params[1]
         default_file = params[2]
         command.cooker.saveConfigurationVar(var, val, default_file)
 
+    def createConfigFile(self, command, params):
+        """
+        Create an extra configuration file
+        """
+        name = params[0]
+        command.cooker.createConfigFile(name)
+
 class CommandsAsync:
     """
     A class of asynchronous commands
@@ -390,11 +400,11 @@ class CommandsAsync:
         """
         Parse the configuration files
         """
-        prefiles = params[0]
-        postfiles = params[1]
+        prefiles = params[0].split()
+        postfiles = params[1].split()
         command.cooker.configuration.prefile = prefiles
         command.cooker.configuration.postfile = postfiles
-        command.cooker.loadConfigurationData()
+        command.cooker.loadConfigurationData(tracking=True)
         command.finishAsyncCommand()
     parseConfigurationFiles.needcache = False
 
diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index d060bc0..8fd989b 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -454,7 +454,9 @@ class HobHandler(gobject.GObject):
         return " ".join(ret)
 
     def set_var_in_file(self, var, val, default_file=None):
+        self.runCommand(["enableDataTracking"])
         self.server.runCommand(["setVarFile", var, val, default_file])
+        self.runCommand(["disableDataTracking"])
 
     def get_parameters(self):
         # retrieve the parameters from bitbake
-- 
1.7.9.5


