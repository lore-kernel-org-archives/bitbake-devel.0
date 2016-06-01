Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 389EB77190
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  1 Jun 2016 12:37:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u51Cb3B2007479; Wed, 1 Jun 2016 13:37:03 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id M2KcZJJxkgdP; Wed,  1 Jun 2016 13:37:03 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u51CaxAn007449
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 1 Jun 2016 13:37:00 +0100
Received: from richard by hex with local (Exim 4.86)
	(envelope-from <richard@rpsys.net>)
	id 1b85ON-0000nn-94; Wed, 01 Jun 2016 13:36:59 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  1 Jun 2016 13:36:26 +0100
Message-Id: <1464784607-2985-7-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1464784607-2985-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1464784607-2985-1-git-send-email-richard.purdie@linuxfoundation.org>
Subject: [PATCH 07/28] image-writer/goggle: Disable pygtkcompat problems
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
X-List-Received-Date: Wed, 01 Jun 2016 12:37:05 -0000

Disable the problematic gtk usage for use with pygtkcompat. The following
commit removes these tools/UIs entirely but we may as well leave this
piece in the history in case anyone does want a starting point for reusing
them.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/image-writer                     |  3 ++-
 lib/bb/ui/crumbs/hig/crumbsdialog.py |  2 +-
 lib/bb/ui/crumbs/hobwidget.py        |  8 ++++----
 lib/bb/ui/crumbs/progressbar.py      | 15 ++++++++-------
 4 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/bin/image-writer b/bin/image-writer
index 7ab1d8c..40e284d 100755
--- a/bin/image-writer
+++ b/bin/image-writer
@@ -67,7 +67,8 @@ class DeployWindow(gtk.Window):
 
         self.deploy_dialog = DeployImageDialog(Title, image_path, self,
                                         gtk.DIALOG_MODAL | gtk.DIALOG_DESTROY_WITH_PARENT
-                                        | gtk.DIALOG_NO_SEPARATOR, None, standalone=True)
+                                        , None, standalone=True)
+#FIXME | gtk.DIALOG_NO_SEPARATOR
         close_button = self.deploy_dialog.add_button("Close", gtk.RESPONSE_NO)
         HobAltButton.style_button(close_button)
         close_button.connect('clicked', gtk.main_quit)
diff --git a/lib/bb/ui/crumbs/hig/crumbsdialog.py b/lib/bb/ui/crumbs/hig/crumbsdialog.py
index c679f9a..73b9234 100644
--- a/lib/bb/ui/crumbs/hig/crumbsdialog.py
+++ b/lib/bb/ui/crumbs/hig/crumbsdialog.py
@@ -36,7 +36,7 @@ class CrumbsDialog(gtk.Dialog):
     def __init__(self, title="", parent=None, flags=0, buttons=None):
         super(CrumbsDialog, self).__init__(title, parent, flags, buttons)
 
-        self.set_property("has-separator", False) # note: deprecated in 2.22
+        #FIXME self.set_property("has-separator", False) # note: deprecated in 2.22
 
         self.set_border_width(6)
         self.vbox.set_property("spacing", 12)
diff --git a/lib/bb/ui/crumbs/hobwidget.py b/lib/bb/ui/crumbs/hobwidget.py
index 1f51a3c..3f6138b 100644
--- a/lib/bb/ui/crumbs/hobwidget.py
+++ b/lib/bb/ui/crumbs/hobwidget.py
@@ -273,13 +273,13 @@ class BaseHobButton(gtk.Button):
         style = button.get_style()
         style = gtk.rc_get_style_by_paths(gtk.settings_get_default(), 'gtk-button', 'gtk-button', gobject.TYPE_NONE)
 
-        button.set_flags(gtk.CAN_DEFAULT)
+        #FIXME button.set_flags(gtk.CAN_DEFAULT)
         button.grab_default()
 
 #        label = "<span size='x-large'><b>%s</b></span>" % gobject.markup_escape_text(button.get_label())
         label = button.get_label()
         button.set_label(label)
-        button.child.set_use_markup(True)
+        #FIXME button.child.set_use_markup(True)
 
 class HobButton(BaseHobButton):
     """
@@ -399,8 +399,8 @@ class HobInfoButton(gtk.EventBox):
         self.dialog = PropertyDialog(title = '',
                     parent = self.my_parent,
                     information = self.tip_markup,
-                    flags = gtk.DIALOG_DESTROY_WITH_PARENT
-                        | gtk.DIALOG_NO_SEPARATOR)
+                    flags = gtk.DIALOG_DESTROY_WITH_PARENT)
+                        #FMXIE | gtk.DIALOG_NO_SEPARATOR
 
         button = self.dialog.add_button("Close", gtk.RESPONSE_CANCEL)
         HobAltButton.style_button(button)
diff --git a/lib/bb/ui/crumbs/progressbar.py b/lib/bb/ui/crumbs/progressbar.py
index 03230ae..ba3c7a0 100644
--- a/lib/bb/ui/crumbs/progressbar.py
+++ b/lib/bb/ui/crumbs/progressbar.py
@@ -28,13 +28,14 @@ class HobProgressBar (gtk.ProgressBar):
 
     def set_rcstyle(self, status):
         rcstyle = gtk.RcStyle()
-        rcstyle.fg[2] = gtk.gdk.Color(HobColors.BLACK)
-        if status == "stop":
-            rcstyle.bg[3] = gtk.gdk.Color(HobColors.WARNING)
-        elif status == "fail":
-            rcstyle.bg[3] = gtk.gdk.Color(HobColors.ERROR)
-        else:
-            rcstyle.bg[3] = gtk.gdk.Color(HobColors.RUNNING)
+#FIXME
+#        rcstyle.fg[2] = gtk.gdk.Color(HobColors.BLACK)
+#        if status == "stop":
+#            rcstyle.bg[3] = gtk.gdk.Color(HobColors.WARNING)
+#        elif status == "fail":
+#            rcstyle.bg[3] = gtk.gdk.Color(HobColors.ERROR)
+#        else:
+#            rcstyle.bg[3] = gtk.gdk.Color(HobColors.RUNNING)
         self.modify_style(rcstyle)
 
     def set_title(self, text=None):
-- 
2.5.0


