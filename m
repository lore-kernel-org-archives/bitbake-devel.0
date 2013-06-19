Return-Path: <cristiana.voicu@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 6D51B6ABED
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Jun 2013 14:14:59 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 19 Jun 2013 07:12:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,896,1363158000"; d="scan'208";a="332146626"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.72])
	by orsmga001.jf.intel.com with ESMTP; 19 Jun 2013 07:14:58 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 19 Jun 2013 17:16:24 +0300
Message-Id: <1371651387-20886-3-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1371651387-20886-1-git-send-email-cristiana.voicu@intel.com>
References: <1371651387-20886-1-git-send-email-cristiana.voicu@intel.com>
Subject: [PATCH 2/5] bitbake: add a new command and modify others
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
X-List-Received-Date: Wed, 19 Jun 2013 14:14:59 -0000

This patch adds a new command to create an extra configuration
file, in order to create it from Hob.
Also, it removes 2 commands used to enable and disable the tracking
history for variables, because it will be called in the body of each
command when needed.
Modified the prefiles and postfiles variables because the cooker
expects some lists.

Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/command.py |   30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index 5f696c2..9ddb96d 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -174,18 +174,6 @@ class CommandsSync:
         value = str(params[1])
         setattr(command.cooker.configuration, varname, value)
 
-    def enableDataTracking(self, command, params):
-        """
-        Enable history tracking for variables
-        """
-        command.cooker.enableDataTracking()
-
-    def disableDataTracking(self, command, params):
-        """
-        Disable history tracking for variables
-        """
-        command.cooker.disableDataTracking()
-
     def initCooker(self, command, params):
         """
         Init the cooker to initial state with nothing parsed
@@ -217,10 +205,22 @@ class CommandsSync:
         return command.cooker.generateNewImage(image, base_image, package_queue)
 
     def setVarFile(self, command, params):
+        """
+        Save a variable in a file; used for saving in a configuration file
+        """
         var = params[0]
         val = params[1]
         default_file = params[2]
+        command.cooker.enableDataTracking()
         command.cooker.saveConfigurationVar(var, val, default_file)
+        command.cooker.disableDataTracking()
+
+    def createConfigFile(self, command, params):
+        """
+        Create an extra configuration file
+        """
+        name = params[0]
+        command.cooker.createConfigFile(name)
 
 class CommandsAsync:
     """
@@ -390,11 +390,11 @@ class CommandsAsync:
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
 
-- 
1.7.9.5


