Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 39CD17828A
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  9 Jun 2017 13:35:33 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	09 Jun 2017 06:35:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.39,317,1493708400"; d="scan'208";a="1180388591"
Received: from therfet-mobl.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.41.2])
	by fmsmga002.fm.intel.com with ESMTP; 09 Jun 2017 06:35:33 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  9 Jun 2017 15:34:46 +0200
Message-Id: <5bb13d36a4060a9df3c7fb614a34f45f4acd2811.1497014984.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1497014984.git.paul.eggleton@linux.intel.com>
References: <cover.1497014984.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 4/4] cooker: add BB_CMDLINE to enable access to UI command line with memres
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
X-List-Received-Date: Fri, 09 Jun 2017 13:35:33 -0000

In OpenEmbedded's buildhistory class we want access to the bitbake
command line that launched the build, and up to now we were simply using
sys.argv from within the event handler to get that. Unfortunately that
doesn't work in memory resident mode, since the event handler is
naturally executing within the server and thus will give you the command
that launched the bitbake server which is much less interesting. Add a
dynamic variable BB_CMDLINE to provide access to this, set from sys.argv
within the UI process in updateToServer().

(Note that BB_CMDLINE isn't currently passed through to the worker, so
this is only really readable from event handlers plus any explicit
getVariable calls - in theory an observe-only UI could read it for
example.)

Part of the fix for [YOCTO #11634].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/command.py    | 3 ++-
 lib/bb/cooker.py     | 7 ++++++-
 lib/bb/cookerdata.py | 2 +-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index ab51d8e..a919f58 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -310,7 +310,8 @@ class CommandsSync:
     def updateConfig(self, command, params):
         options = params[0]
         environment = params[1]
-        command.cooker.updateConfigOpts(options, environment)
+        cmdline = params[2]
+        command.cooker.updateConfigOpts(options, environment, cmdline)
     updateConfig.needconfig = False
 
     def parseConfiguration(self, command, params):
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 1283136..45b5a61 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -192,6 +192,8 @@ class BBCooker:
         bb.parse.__mtime_cache = {}
         bb.parse.BBHandler.cached_statements = {}
 
+        self.ui_cmdline = None
+
         self.initConfigurationData()
 
         # we log all events to a file if so directed
@@ -360,6 +362,8 @@ class BBCooker:
         if consolelog:
             self.data.setVar("BB_CONSOLELOG", consolelog)
 
+        self.data.setVar('BB_CMDLINE', self.ui_cmdline)
+
         #
         # Copy of the data store which has been expanded.
         # Used for firing events and accessing variables where expansion needs to be accounted for
@@ -539,7 +543,8 @@ class BBCooker:
 
         self.handleCollections(self.data.getVar("BBFILE_COLLECTIONS"))
 
-    def updateConfigOpts(self, options, environment):
+    def updateConfigOpts(self, options, environment, cmdline):
+        self.ui_cmdline = cmdline
         clean = True
         for o in options:
             if o in ['prefile', 'postfile']:
diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 6b850d3..62aa055 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -79,7 +79,7 @@ class ConfigParameters(object):
                   "prefile", "postfile", "tracking"]:
             options[o] = getattr(self.options, o)
 
-        ret, error = server.runCommand(["updateConfig", options, environment])
+        ret, error = server.runCommand(["updateConfig", options, environment, sys.argv])
         if error:
                 raise Exception("Unable to update the server configuration with local parameters: %s" % error)
 
-- 
2.9.4


