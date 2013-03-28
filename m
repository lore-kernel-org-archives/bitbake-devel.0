Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei.adrianx.dinu@intel.com>) id 1UL8ND-0004iI-R6
	for bitbake-devel@lists.openembedded.org;
	Thu, 28 Mar 2013 09:39:52 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 28 Mar 2013 01:22:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,924,1355126400"; d="scan'208";a="313050648"
Received: from adinu-vostro-460.rb.intel.com ([10.237.105.146])
	by fmsmga002.fm.intel.com with ESMTP; 28 Mar 2013 01:22:38 -0700
From: Andrei Dinu <andrei.adrianx.dinu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 28 Mar 2013 10:23:20 +0200
Message-Id: <1364459002-4165-5-git-send-email-andrei.adrianx.dinu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1364459002-4165-1-git-send-email-andrei.adrianx.dinu@intel.com>
References: <1364459002-4165-1-git-send-email-andrei.adrianx.dinu@intel.com>
Subject: [PATCH 4/6] propertydialog.py : added 'Package files' functionality
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
X-List-Received-Date: Thu, 28 Mar 2013 08:39:53 -0000

Extended the packages page information with the
listing of the files brought in by every package.

Signed-off-by: Andrei Dinu <andrei.adrianx.dinu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hig/propertydialog.py |   94 +++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig/propertydialog.py b/bitbake/lib/bb/ui/crumbs/hig/propertydialog.py
index 4420f97..f4cf9a6 100644
--- a/bitbake/lib/bb/ui/crumbs/hig/propertydialog.py
+++ b/bitbake/lib/bb/ui/crumbs/hig/propertydialog.py
@@ -41,11 +41,11 @@ class PropertyDialog(CrumbsDialog):
 		
 		super(PropertyDialog, self).__init__(title, parent, flags, buttons)
                 
-                self.properties = information		
+                self.properties = information
 
                 if len(self.properties) == 10:
 		        self.create_recipe_visual_elements()
-                elif len(self.properties) == 4:
+                elif len(self.properties) == 5:
                         self.create_package_visual_elements()
                 else:
                         self.create_information_visual_elements()
@@ -56,6 +56,8 @@ class PropertyDialog(CrumbsDialog):
                 HOB_ICON_BASE_DIR = os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(__file__))), ("icons/"))
                 ICON_PACKAGES_DISPLAY_FILE    = os.path.join(HOB_ICON_BASE_DIR, ('info/info_display.png'))
 
+                self.set_resizable(False)
+
                 self.table = gtk.Table(1,1,False)
                 self.table.set_row_spacings(0)
                 self.table.set_col_spacings(0)
@@ -86,6 +88,19 @@ class PropertyDialog(CrumbsDialog):
         
                 self.vbox.add(self.table)
 
+        def treeViewTooltip( self, widget, e, tooltips, cell, emptyText="" ):
+                 try:
+                           (path,col,x,y) = widget.get_path_at_pos( int(e.x), int(e.y) )
+                           it = widget.get_model().get_iter(path)
+                           value = widget.get_model().get_value(it,cell)
+                           if value in self.tooltip_items:
+                                tooltips.set_tip(widget, self.tooltip_items[value])
+                                tooltips.enable()
+                           else:
+                                tooltips.set_tip(widget, emptyText)
+                 except:
+                           tooltips.set_tip(widget, emptyText)
+
                 
         def create_package_visual_elements(self):
 
@@ -93,7 +108,18 @@ class PropertyDialog(CrumbsDialog):
                 binb = self.properties['binb']
                 size = self.properties['size']
                 recipe = self.properties['recipe']
+                file_list = self.properties['files_list']
+
+                file_list = file_list.strip("{}'")
+                files_temp = ''
+                paths_temp = ''
+                files_binb = []
+                paths_binb = []
 
+                self.tooltip_items = {}
+
+                self.set_resizable(False)
+                
                 #cleaning out the recipe variable
                 recipe = recipe.split("+")[0]
 
@@ -151,9 +177,71 @@ class PropertyDialog(CrumbsDialog):
                         self.vbox.add(self.label_short)
                         self.vbox.add(self.label_info)
 
+                #################################### FILES BROUGHT BY PACKAGES ###################################
+
+                if file_list != '':
+                
+                        self.textWindow = gtk.ScrolledWindow()
+                        self.textWindow.set_shadow_type(gtk.SHADOW_IN)
+                        self.textWindow.set_policy(gtk.POLICY_AUTOMATIC, gtk.POLICY_AUTOMATIC)
+                        self.textWindow.set_size_request(100, 170)
+
+                        sstatemirrors_store = gtk.ListStore(str)
+
+                        self.sstatemirrors_tv = gtk.TreeView()
+                        self.sstatemirrors_tv.set_rules_hint(True)
+                        self.sstatemirrors_tv.set_headers_visible(True)
+                        self.textWindow.add(self.sstatemirrors_tv)
+
+                        self.cell1 = gtk.CellRendererText()
+                        col1 = gtk.TreeViewColumn('Package files', self.cell1)
+                        col1.set_cell_data_func(self.cell1, self.regex_field)
+                        self.sstatemirrors_tv.append_column(col1)
+
+                        for items in file_list.split(']]'):
+                            if len(items) > 1:
+                                paths_temp = items.split(":")[0]
+                                paths_binb.append(paths_temp.strip(" ,'"))
+                                files_temp = items.split(":")[1]
+                                files_binb.append(files_temp.strip(" ['"))
+
+                        unsorted_list = []
+                        
+                        for items in range(len(paths_binb)):
+                              if len(files_binb[items]) > 1:
+                                  for aduse in (files_binb[items].split(",")):
+                                        unsorted_list.append(paths_binb[items].split(name)[len(paths_binb[items].split(name))-1] + '/' + aduse.strip(" '"))
+                       
+                         
+                        unsorted_list.sort()
+                        for items in unsorted_list:
+                                temp = items
+                                while len(items) > 35:
+                                        items = items[:len(items)/2] + "" + items[len(items)/2+1:]
+                                if len(items) == 35:
+                                        items = items[:len(items)/2] + "..." + items[len(items)/2+3:]
+                                        self.tooltip_items[items] = temp
+
+                                sstatemirrors_store.append([str(items)])
+                                
+                                
+                        self.sstatemirrors_tv.set_model(sstatemirrors_store)
+
+                        tips = gtk.Tooltips()
+                        tips.set_tip(self.sstatemirrors_tv, "")
+                        self.sstatemirrors_tv.connect("motion-notify-event", self.treeViewTooltip, tips, 0)
+                        self.sstatemirrors_tv.set_events(gtk.gdk.POINTER_MOTION_MASK)
+                        
+                        self.vbox.add(self.textWindow)                                      
+
                 self.vbox.show_all()
 
 
+        def regex_field(self, column, cell, model, iter):
+                cell.set_property('text', model.get_value(iter, 0))
+                return
+
+
 	def create_recipe_visual_elements(self):
 
                 summary = self.properties['summary']
@@ -166,6 +254,8 @@ class PropertyDialog(CrumbsDialog):
 		homepage = self.properties['homepage']
 		bugtracker = self.properties['bugtracker']
 		description = self.properties['description']
+
+                self.set_resizable(False)
 		
                 #cleaning out the version variable and also the summary
                 version = version.split(":")[1]
-- 
1.7.9.5



