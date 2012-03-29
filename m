Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SDEDg-0007Oa-Tp
	for bitbake-devel@lists.openembedded.org;
	Thu, 29 Mar 2012 14:12:49 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 29 Mar 2012 05:03:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="126516852"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by orsmga002.jf.intel.com with ESMTP; 29 Mar 2012 05:03:44 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 29 Mar 2012 20:01:07 +0800
Message-Id: <96009f44249a4257dd7f7cd422fabf43d7d3988d.1333022081.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1333022081.git.dongxiao.xu@intel.com>
References: <cover.1333022081.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1333022081.git.dongxiao.xu@intel.com>
References: <cover.1333022081.git.dongxiao.xu@intel.com>
Subject: [PATCH 01/14] Hob: Remove un-used signal and functions
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
X-List-Received-Date: Thu, 29 Mar 2012 12:12:49 -0000

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/builder.py         |    4 ----
 lib/bb/ui/crumbs/hobeventhandler.py |    9 +--------
 2 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
index 2af14dc..6b16ac8 100755
--- a/lib/bb/ui/crumbs/builder.py
+++ b/lib/bb/ui/crumbs/builder.py
@@ -245,7 +245,6 @@ class Builder(gtk.Window):
         self.package_model.connect("package-selection-changed", self.packagelist_changed_cb)
         self.handler.connect("config-updated",           self.handler_config_updated_cb)
         self.handler.connect("package-formats-updated",  self.handler_package_formats_updated_cb)
-        self.handler.connect("layers-updated",           self.handler_layers_updated_cb)
         self.handler.connect("parsing-started",          self.handler_parsing_started_cb)
         self.handler.connect("parsing",                  self.handler_parsing_cb)
         self.handler.connect("parsing-completed",        self.handler_parsing_completed_cb)
@@ -452,9 +451,6 @@ class Builder(gtk.Window):
     def handler_package_formats_updated_cb(self, handler, formats):
         self.parameters.all_package_formats = formats
 
-    def handler_layers_updated_cb(self, handler, layers):
-        self.parameters.all_layers = layers
-
     def handler_command_succeeded_cb(self, handler, initcmd):
         if initcmd == self.handler.PARSE_CONFIG:
             # settings
diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index 9c5dc77..f189553 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -30,9 +30,6 @@ class HobHandler(gobject.GObject):
     This object does BitBake event handling for the hob gui.
     """
     __gsignals__ = {
-         "layers-updated"          : (gobject.SIGNAL_RUN_LAST,
-                                      gobject.TYPE_NONE,
-                                     (gobject.TYPE_PYOBJECT,)),
          "package-formats-updated" : (gobject.SIGNAL_RUN_LAST,
                                       gobject.TYPE_NONE,
                                      (gobject.TYPE_PYOBJECT,)),
@@ -152,7 +149,7 @@ class HobHandler(gobject.GObject):
             self.package_model.populate(event._pkginfolist)
             self.run_next_command()
 
-        elif(isinstance(event, logging.LogRecord)):
+        elif isinstance(event, logging.LogRecord):
             if event.levelno >= logging.ERROR:
                 self.error_msg += event.msg + '\n'
 
@@ -160,10 +157,6 @@ class HobHandler(gobject.GObject):
             self.current_phase = "data generation"
             if event._model:
                 self.recipe_model.populate(event._model)
-        elif isinstance(event, bb.event.CoreBaseFilesFound):
-            self.current_phase = "configuration lookup"
-            paths = event._paths
-            self.emit('layers-updated', paths)
         elif isinstance(event, bb.event.ConfigFilesFound):
             self.current_phase = "configuration lookup"
             var = event._variable
-- 
1.7.4.1



