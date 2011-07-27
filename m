Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qlw4p-0004Bm-Ko
	for bitbake-devel@lists.openembedded.org;
	Wed, 27 Jul 2011 06:50:35 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 26 Jul 2011 21:46:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,273,1309762800"; d="scan'208";a="30529120"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.163])
	by orsmga002.jf.intel.com with ESMTP; 26 Jul 2011 21:46:19 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 26 Jul 2011 21:46:11 -0700
Message-Id: <ed06102ba830afe3bc6e608781fc11a7aa8f81dd.1311741742.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1311741742.git.josh@linux.intel.com>
References: <cover.1311741742.git.josh@linux.intel.com>
In-Reply-To: <cover.1311741742.git.josh@linux.intel.com>
References: <cover.1311741742.git.josh@linux.intel.com>
Subject: [RFC PATCH 3/3] ui/crumbs/[hobeventhandler|configurator]: don't use unparsed files
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 27 Jul 2011 04:50:35 -0000

Use the new field in the ConfigFilePathFound event to track whether the
hob.local.conf file was parsed when BitBake was launched.

Fixes [YOCTO #1246]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/configurator.py    |    8 ++++----
 lib/bb/ui/crumbs/hobeventhandler.py |    6 ++++--
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/lib/bb/ui/crumbs/configurator.py b/lib/bb/ui/crumbs/configurator.py
index ec48a4f..f5eae28 100644
--- a/lib/bb/ui/crumbs/configurator.py
+++ b/lib/bb/ui/crumbs/configurator.py
@@ -115,9 +115,9 @@ class Configurator(gobject.GObject):
         self.enabled_layers = copy.deepcopy(self.loaded_layers)
         self.emit("layers-loaded")
 
-    def _addConfigFile(self, path):
+    def _addConfigFile(self, path, additional):
         pref, sep, filename = path.rpartition("/")
-        if filename == "local.conf" or filename == "hob.local.conf":
+        if filename == "local.conf" or (filename == "hob.local.conf" and additional):
             self._loadLocalConf(path)
         elif filename == "bblayers.conf":
             self._loadLayerConf(path)
@@ -293,8 +293,8 @@ class Configurator(gobject.GObject):
 
         self.emit("layers-changed")
 
-    def configFound(self, handler, path):
-        self._addConfigFile(path)
+    def configFound(self, handler, path, additional):
+        self._addConfigFile(path, additional)
 
     def loadConfig(self, path):
         self._addConfigFile(path)
diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index 4897bcc..9cfa7c2 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -42,7 +42,8 @@ class HobHandler(gobject.GObject):
                                   (gobject.TYPE_PYOBJECT,)),
          "config-found"        : (gobject.SIGNAL_RUN_LAST,
                                   gobject.TYPE_NONE,
-                                  (gobject.TYPE_STRING,)),
+                                  (gobject.TYPE_STRING,
+                                   gobject.TYPE_BOOLEAN)),
          "generating-data"     : (gobject.SIGNAL_RUN_LAST,
                                   gobject.TYPE_NONE,
                                   ()),
@@ -150,7 +151,8 @@ class HobHandler(gobject.GObject):
                 self.emit("sdk-machines-updated", sdk_machines)
         elif isinstance(event, bb.event.ConfigFilePathFound):
             path = event._path
-            self.emit("config-found", path)
+            extraconf = event._extraconf
+            self.emit("config-found", path, extraconf)
         elif isinstance(event, bb.event.FilesMatchingFound):
             # FIXME: hard coding, should at least be a variable shared between
             # here and the caller
-- 
1.7.6



