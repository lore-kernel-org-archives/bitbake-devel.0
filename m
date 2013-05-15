Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei.adrianx.dinu@intel.com>) id 1UcYle-0002Ov-1F
	for bitbake-devel@lists.openembedded.org;
	Wed, 15 May 2013 12:17:21 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 15 May 2013 02:58:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,675,1363158000"; d="scan'208";a="241841626"
Received: from adinu-vostro-460.rb.intel.com ([10.237.105.143])
	by AZSMGA002.ch.intel.com with ESMTP; 15 May 2013 02:58:47 -0700
From: Andrei Dinu <andrei.adrianx.dinu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 15 May 2013 12:59:26 +0300
Message-Id: <1368611966-14723-1-git-send-email-andrei.adrianx.dinu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] propertydialog.py : Scrollable windows for long tooltips
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
X-List-Received-Date: Wed, 15 May 2013 10:17:28 -0000

In some cases, the length of the description and the brought
in by field was too big. That led to the size of the property
dialog exceeding Hob's size. For long tooltips we use
scrollable windows now.

[HOB #4321]

Signed-off-by: Andrei Dinu <andrei.adrianx.dinu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hig/propertydialog.py |   63 ++++++++++++++----------
 1 file changed, 38 insertions(+), 25 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig/propertydialog.py b/bitbake/lib/bb/ui/crumbs/hig/propertydialog.py
index 1e7f5c9..5a41ae7 100644
--- a/bitbake/lib/bb/ui/crumbs/hig/propertydialog.py
+++ b/bitbake/lib/bb/ui/crumbs/hig/propertydialog.py
@@ -274,24 +274,23 @@ class PropertyDialog(CrumbsDialog):
                 binb_items_count = len(binb.split(','))
                 binb_items = binb.split(',')
                                		
-		vbox = gtk.VBox(True,spacing = 0)
-                
+		vbox = gtk.VBox(False,spacing = 0)
+
                 ######################################## SUMMARY LABEL #########################################                	                
                 
                 if summary != '':                
                         self.label_short = gtk.Label()
-                        self.label_short.set_size_request(300,-1)
+                        self.label_short.set_width_chars(37)
                         self.label_short.set_selectable(True)                
                         self.label_short.set_line_wrap(True)
                         self.label_short.set_markup("<b>" + summary + "</b>")
                         self.label_short.set_property("xalign", 0)
                         
-                        self.vbox.pack_start(self.label_short, expand=False, fill=False, padding=0)
+                        self.vbox.add(self.label_short)
                 
                 ########################################## NAME ROW + COL #######################################
                                 
                 self.label_short = gtk.Label()
-                self.label_short.set_size_request(300,-1)
                 self.label_short.set_selectable(True)
                 self.label_short.set_line_wrap(True)
                 self.label_short.set_markup("<span weight=\"bold\">Name: </span>" + name)
@@ -302,7 +301,6 @@ class PropertyDialog(CrumbsDialog):
                 ####################################### VERSION ROW + COL ####################################
                 
                 self.label_short = gtk.Label()
-                self.label_short.set_size_request(300,-1)
                 self.label_short.set_selectable(True)
                 self.label_short.set_line_wrap(True)
                 self.label_short.set_markup("<span weight=\"bold\">Version: </span>" + version)
@@ -313,7 +311,6 @@ class PropertyDialog(CrumbsDialog):
                 ##################################### REVISION ROW + COL #####################################
 
                 self.label_short = gtk.Label()
-                self.label_short.set_size_request(300,-1)
                 self.label_short.set_line_wrap(True)
                 self.label_short.set_selectable(True)
                 self.label_short.set_markup("<span weight=\"bold\">Revision: </span>" + revision)
@@ -324,7 +321,6 @@ class PropertyDialog(CrumbsDialog):
                 ################################## GROUP ROW + COL ############################################
                
                 self.label_short = gtk.Label()
-                self.label_short.set_size_request(300,-1)  
                 self.label_short.set_selectable(True)              
                 self.label_short.set_line_wrap(True)                                
                 self.label_short.set_markup("<span weight=\"bold\">Group: </span>" + group)
@@ -346,7 +342,6 @@ class PropertyDialog(CrumbsDialog):
                         self.label_info.set_property("xalign", 0)
                        
                         self.label_short = gtk.Label()
-                        self.label_short.set_size_request(300,-1)   
                         self.label_short.set_selectable(True)                     
                         self.label_short.set_line_wrap(True)                        
                         self.label_short.set_markup("<b>Homepage: </b>")                      
@@ -368,7 +363,6 @@ class PropertyDialog(CrumbsDialog):
                         self.label_info.set_property("xalign", 0)  
 
                         self.label_short = gtk.Label()
-                        self.label_short.set_size_request(300,-1)    
                         self.label_short.set_selectable(True)                    
                         self.label_short.set_line_wrap(True)
                         self.label_short.set_markup("<b>Bugtracker: </b>")                   
@@ -380,7 +374,6 @@ class PropertyDialog(CrumbsDialog):
                 ################################# LICENSE ROW + COL ############################################
                 
                 self.label_info = gtk.Label()
-                self.label_info.set_size_request(300,-1)
                 self.label_info.set_selectable(True)
                 self.label_info.set_line_wrap(True)
                 self.label_info.set_markup(license)
@@ -403,16 +396,25 @@ class PropertyDialog(CrumbsDialog):
                         self.label_short.set_line_wrap(True)
                         self.label_short.set_markup("<span weight=\"bold\">Brought in by: </span>")
                         self.label_short.set_property("xalign", 0)
-
+                        self.vbox.add(self.label_short)
                         self.label_info = gtk.Label()
-                        self.label_info.set_size_request(300,-1)
                         self.label_info.set_selectable(True)
-                        self.label_info.set_markup(binb)
-                        self.label_info.set_property("xalign", 0)
-                        self.label_info.set_line_wrap(True)
-                        
-                        self.vbox.add(self.label_short)
-                        self.vbox.add(self.label_info)
+                        self.label_info.set_width_chars(36)
+                        if len(binb) > 200:
+                            scrolled_window = gtk.ScrolledWindow()
+                            scrolled_window.set_policy(gtk.POLICY_NEVER,gtk.POLICY_ALWAYS)
+                            scrolled_window.set_size_request(100,100)
+                            self.label_info.set_markup(binb)
+                            self.label_info.set_padding(6,6)
+                            self.label_info.set_alignment(0,0)
+                            self.label_info.set_line_wrap(True)
+                            scrolled_window.add_with_viewport(self.label_info)
+                            self.vbox.add(scrolled_window)
+                        else:
+                            self.label_info.set_markup(binb)
+                            self.label_info.set_property("xalign", 0)
+                            self.label_info.set_line_wrap(True) 
+                            self.vbox.add(self.label_info)
 
                 ################################ DESCRIPTION TAG ROW #################################################
                 
@@ -427,11 +429,22 @@ class PropertyDialog(CrumbsDialog):
                 hbox = gtk.HBox(True,spacing = 0)
 
                 self.label_short = gtk.Label()
-                self.label_short.set_size_request(300,-1)
-                self.label_short.set_selectable(True)                
-                self.label_short.set_text(description)
-                self.label_short.set_line_wrap(True)
-                self.label_short.set_property("xalign", 0)
-                self.vbox.add(self.label_short)
+                self.label_short.set_selectable(True)
+                self.label_short.set_width_chars(36)
+                if len(description) > 200:
+                    scrolled_window = gtk.ScrolledWindow()
+                    scrolled_window.set_policy(gtk.POLICY_NEVER,gtk.POLICY_ALWAYS)
+                    scrolled_window.set_size_request(100,100)
+                    self.label_short.set_markup(description)
+                    self.label_short.set_padding(6,6)
+                    self.label_short.set_alignment(0,0)
+                    self.label_short.set_line_wrap(True)
+                    scrolled_window.add_with_viewport(self.label_short)
+                    self.vbox.add(scrolled_window)
+                else:    
+                    self.label_short.set_markup(description)
+                    self.label_short.set_property("xalign", 0)
+                    self.label_short.set_line_wrap(True)
+                    self.vbox.add(self.label_short)
 
                 self.vbox.show_all()
-- 
1.7.9.5



