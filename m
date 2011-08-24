Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QwK1I-00010b-DB
	for bitbake-devel@lists.openembedded.org;
	Wed, 24 Aug 2011 22:25:52 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 24 Aug 2011 13:21:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="41542778"
Received: from vorpal.jf.intel.com ([10.7.199.155])
	by orsmga002.jf.intel.com with ESMTP; 24 Aug 2011 13:21:01 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 24 Aug 2011 13:26:00 -0700
Message-Id: <d06b74ba9c8804f262ac80868f9d936be7192498.1314217450.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1314217450.git.josh@linux.intel.com>
References: <cover.1314217450.git.josh@linux.intel.com>
In-Reply-To: <cover.1314217450.git.josh@linux.intel.com>
References: <cover.1314217450.git.josh@linux.intel.com>
Subject: [PATCH 3/3] hob: disable some menu entries whilst build is in progress
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
X-List-Received-Date: Wed, 24 Aug 2011 20:25:52 -0000

It doesn't make sense to be able to modify the preferences and add/remove
layers whilst a build is in progress - disable the relevant menu items once
the build has started and re-enable them once the user has returned to the
creation view.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/hob.py |   30 ++++++++++++++++++++++++------
 1 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index 7278643..c2acada 100644
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -469,12 +469,21 @@ class MainWindow (gtk.Window):
         else:
             self.handler.build_packages(self.model.get_selected_pn())
 
+        # Disable parts of the menu which shouldn't be used whilst building
+        self.set_menus_sensitive(False)
         self.nb.set_current_page(1)
 
+    def set_menus_sensitive(self, sensitive):
+        self.add_layers_action.set_sensitive(sensitive)
+        self.layers_action.set_sensitive(sensitive)
+        self.prefs_action.set_sensitive(sensitive)
+        self.open_action.set_sensitive(sensitive)
+
     def back_button_clicked_cb(self, button):
         self.toggle_createview()
 
     def toggle_createview(self):
+        self.set_menus_sensitive(True)
         self.build.model.clear()
         self.nb.set_current_page(0)
 
@@ -816,18 +825,27 @@ class MainWindow (gtk.Window):
 
         actions = gtk.ActionGroup('ImageCreator')
         self.actions = actions
-        actions.add_actions([('Quit', gtk.STOCK_QUIT, None, None,
-                              None, self.menu_quit,),
+        actions.add_actions([('Quit', gtk.STOCK_QUIT, None, None, None, self.menu_quit,),
                              ('File', None, '_File'),
                              ('Save', gtk.STOCK_SAVE, None, None, None, self.save_cb),
                              ('Save As', gtk.STOCK_SAVE_AS, None, None, None, self.save_as_cb),
-                             ('Open', gtk.STOCK_OPEN, None, None, None, self.open_cb),
-                             ('AddLayer', None, 'Add Layer', None, None, self.add_layer_cb),
                              ('Edit', None, '_Edit'),
                              ('Help', None, '_Help'),
-                             ('Layers', None, 'Layers', None, None, self.layers_cb),
-                             ('Preferences', gtk.STOCK_PREFERENCES, None, None, None, self.preferences_cb),
                              ('About', gtk.STOCK_ABOUT, None, None, None, self.about_cb)])
+
+        self.add_layers_action = gtk.Action('AddLayer', 'Add Layer', None, None)
+        self.add_layers_action.connect("activate", self.add_layer_cb)
+        self.actions.add_action(self.add_layers_action)
+        self.layers_action = gtk.Action('Layers', 'Layers', None, None)
+        self.layers_action.connect("activate", self.layers_cb)
+        self.actions.add_action(self.layers_action)
+        self.prefs_action = gtk.Action('Preferences', 'Preferences', None, None)
+        self.prefs_action.connect("activate", self.preferences_cb)
+        self.actions.add_action(self.prefs_action)
+        self.open_action = gtk.Action('Open', 'Open', None, None)
+        self.open_action.connect("activate", self.open_cb)
+        self.actions.add_action(self.open_action)
+
         uimanager.insert_action_group(actions, 0)
         uimanager.add_ui_from_string(menu_items)
 
-- 
1.7.6



