Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <ioanax.grigoropol@intel.com>) id 1T8TZT-0004y3-SG
	for bitbake-devel@lists.openembedded.org;
	Mon, 03 Sep 2012 12:08:04 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 03 Sep 2012 02:53:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,359,1344236400"; d="scan'208";a="140926633"
Received: from ideapad (HELO localhost.localdomain) ([10.237.105.40])
	by AZSMGA002.ch.intel.com with ESMTP; 03 Sep 2012 02:53:54 -0700
From: Ioana Grigoropol <ioanax.grigoropol@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  3 Sep 2012 12:51:06 +0300
Message-Id: <1346665866-12697-1-git-send-email-ioanax.grigoropol@intel.com>
X-Mailer: git-send-email 1.7.9.5
Cc: Ioana Grigoropol <ioanax.grigoropol@intel.com>
Subject: [PATCH] [Yocto #3011] - Button theme is taken from host
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
X-List-Received-Date: Mon, 03 Sep 2012 10:08:06 -0000
X-List-Received-Date: Mon, 03 Sep 2012 10:08:06 -0000

-All buttons in the interface inherit a BaseHobButton that use the gtk settings for buttons from the host;
-Removed 'or' label between actions on image details page

Signed-off-by: Ioana Grigoropol <ioanax.grigoropol@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hobwidget.py        |   36 ++++++++++++++------------
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py |    8 +++---
 2 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
index d10c56b..3951dc1 100644
--- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
+++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
@@ -243,7 +243,7 @@ def soften_color(widget, state=gtk.STATE_NORMAL):
     color.blue = color.blue * blend + style.base[state].blue * (1.0 - blend)
     return color.to_string()
 
-class HobButton(gtk.Button):
+class BaseHobButton(gtk.Button):
     """
     A gtk.Button subclass which follows the visual design of Hob for primary
     action buttons
@@ -257,24 +257,33 @@ class HobButton(gtk.Button):
     @staticmethod
     def style_button(button):
         style = button.get_style()
-        button_color = gtk.gdk.Color(HobColors.ORANGE)
-        button.modify_bg(gtk.STATE_NORMAL, button_color)
-        button.modify_bg(gtk.STATE_PRELIGHT, button_color)
-        button.modify_bg(gtk.STATE_SELECTED, button_color)
+        style = gtk.rc_get_style_by_paths(gtk.settings_get_default(), 'gtk-button', 'gtk-button', gobject.TYPE_NONE)
 
         button.set_flags(gtk.CAN_DEFAULT)
         button.grab_default()
 
-        label = "<span size='x-large'><b>%s</b></span>" % gobject.markup_escape_text(button.get_label())
+#        label = "<span size='x-large'><b>%s</b></span>" % gobject.markup_escape_text(button.get_label())
+        label = button.get_label()
         button.set_label(label)
         button.child.set_use_markup(True)
 
-class HobAltButton(gtk.Button):
+class HobButton(BaseHobButton):
+    """
+    A gtk.Button subclass which follows the visual design of Hob for primary
+    action buttons
+
+    label: the text to display as the button's label
+    """
+    def __init__(self, label):
+        BaseHobButton.__init__(self, label)
+        HobButton.style_button(self)
+
+class HobAltButton(BaseHobButton):
     """
     A gtk.Button subclass which has no relief, and so is more discrete
     """
     def __init__(self, label):
-        gtk.Button.__init__(self, label)
+        BaseHobButton.__init__(self, label)
         HobAltButton.style_button(self)
 
     """
@@ -300,14 +309,6 @@ class HobAltButton(gtk.Button):
         button.set_label("<span size='large' color='%s'><b>%s</b></span>" % (colour, gobject.markup_escape_text(button.text)))
         button.child.set_use_markup(True)
 
-    @staticmethod
-    def style_button(button):
-        button.text = button.get_label()
-        button.connect("state-changed", HobAltButton.desensitise_on_state_change_cb)
-        HobAltButton.set_text(button)
-        button.child.set_use_markup(True)
-        button.set_relief(gtk.RELIEF_NONE)
-
 class HobImageButton(gtk.Button):
     """
     A gtk.Button with an icon and two rows of text, the second of which is
@@ -360,7 +361,8 @@ class HobInfoButton(gtk.EventBox):
     def __init__(self, tip_markup, parent=None):
         gtk.EventBox.__init__(self)
         self.image = gtk.Image()
-        self.image.set_from_file(hic.ICON_INFO_DISPLAY_FILE)
+        self.image.set_from_file(
+        hic.ICON_INFO_DISPLAY_FILE)
         self.image.show()
         self.add(self.image)
 
diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
index 40eb7a4..c1a309d 100755
--- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
@@ -485,8 +485,8 @@ class ImageDetailsPage (HobPage):
         if name in buttonlist and self.test_type_runnable(image_name) and self.test_mach_runnable(image_name):
             if created == True:
                 # separator
-                label = gtk.Label(" or ")
-                self.details_bottom_buttons.pack_end(label, expand=False, fill=False)
+                #label = gtk.Label(" or ")
+                #self.details_bottom_buttons.pack_end(label, expand=False, fill=False)
 
                 # create button "Run image"
                 run_button = HobAltButton("Run image")
@@ -507,8 +507,8 @@ class ImageDetailsPage (HobPage):
         if name in buttonlist:
             if created == True:
                 # separator
-                label = gtk.Label(" or ")
-                self.details_bottom_buttons.pack_end(label, expand=False, fill=False)
+                #label = gtk.Label(" or ")
+                #self.details_bottom_buttons.pack_end(label, expand=False, fill=False)
 
                 # create button "Save as template"
                 save_button = HobAltButton("Save as template")
-- 
1.7.9.5



