Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1TxcAB-0008C9-3X
	for bitbake-devel@lists.openembedded.org;
	Tue, 22 Jan 2013 12:37:12 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 22 Jan 2013 03:20:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,513,1355126400"; d="scan'208";a="250646743"
Received: from irsmsx103.ger.corp.intel.com ([163.33.3.157])
	by orsmga001.jf.intel.com with ESMTP; 22 Jan 2013 03:21:38 -0800
Received: from irsmsx101.ger.corp.intel.com ([169.254.1.60]) by
	IRSMSX103.ger.corp.intel.com ([169.254.3.218]) with mapi id
	14.01.0355.002; Tue, 22 Jan 2013 11:21:37 +0000
From: "Voicu, Cristiana" <cristiana.voicu@intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Thread-Topic: [V2] hob: Hob should display warnings generated during parsing
Thread-Index: AQHN9+SppEwLdT37EEe882dwGy5c9ZhVNP3A
Date: Tue, 22 Jan 2013 11:21:37 +0000
Message-ID: <BE68E9C8E0850C43B0F0B0B7D57FA5AE193DE349@IRSMSX101.ger.corp.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [163.33.239.180]
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: FW: [V2] hob: Hob should display warnings generated during parsing
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
X-List-Received-Date: Tue, 22 Jan 2013 11:37:12 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello Richard,

This patch was not merged ok. The file lib/bb/ui/crumbs/hig/parsingwarnings=
dialog.py(added in this patch), is not in the repo now.
Thank you,
Cristiana

-----Original Message-----
From: Voicu, Cristiana=20
Sent: Monday, January 21, 2013 4:40 PM
To: bitbake-devel@lists.openembedded.org
Cc: Voicu, Cristiana
Subject: [V2] hob: Hob should display warnings generated during parsing

-now Hob catches the warnings generated during parsing, and after the parsi=
ng is completed, if there are any warnings, it shows a bar that contains a =
message with how many warnings has encountered, and a button "View warnings=
"
-when "View warnings" button is clicked, Hob shows a dialog with the warnin=
gs; if there more than 1 warning, you can use "Previous" and "Next" button =
to see them

[YOCTO #3215]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py                |   17 +++
 .../lib/bb/ui/crumbs/hig/parsingwarningsdialog.py  |  161 ++++++++++++++++=
++++
 bitbake/lib/bb/ui/crumbs/hobcolor.py               |    1 +
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py        |   13 ++
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |   54 ++++++-
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py   |    1 +
 6 files changed, 241 insertions(+), 6 deletions(-)  create mode 100644 bit=
bake/lib/bb/ui/crumbs/hig/parsingwarningsdialog.py

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs=
/builder.py
index b783dad..d57cf4c 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -46,6 +46,7 @@ from bb.ui.crumbs.hig.advancedsettingsdialog import Advan=
cedSettingsDialog  from bb.ui.crumbs.hig.deployimagedialog import DeployIma=
geDialog  from bb.ui.crumbs.hig.layerselectiondialog import LayerSelectionD=
ialog  from bb.ui.crumbs.hig.imageselectiondialog import ImageSelectionDial=
og
+from bb.ui.crumbs.hig.parsingwarningsdialog import=20
+ParsingWarningsDialog
=20
 hobVer =3D 20120808
=20
@@ -446,6 +447,9 @@ class Builder(gtk.Window):
         # Indicate whether the sanity check ran
         self.sanity_checked =3D False
=20
+        # save parsing warnings
+        self.parsing_warnings =3D []
+
         # create visual elements
         self.create_visual_elements()
=20
@@ -472,6 +476,7 @@ class Builder(gtk.Window):
         self.handler.connect("data-generated",           self.handler_data=
_generated_cb)
         self.handler.connect("command-succeeded",        self.handler_comm=
and_succeeded_cb)
         self.handler.connect("command-failed",           self.handler_comm=
and_failed_cb)
+        self.handler.connect("parsing-warning",          self.handler_pars=
ing_warning_cb)
         self.handler.connect("sanity-failed",            self.handler_sani=
ty_failed_cb)
         self.handler.connect("recipe-populated",         self.handler_reci=
pe_populated_cb)
         self.handler.connect("package-populated",        self.handler_pack=
age_populated_cb)
@@ -880,6 +885,15 @@ class Builder(gtk.Window):
         response =3D dialog.run()
         dialog.destroy()
=20
+    def show_warning_dialog(self):
+        dialog =3D ParsingWarningsDialog(title =3D "View warnings",
+                warnings =3D self.parsing_warnings,
+                parent =3D None,
+                flags =3D gtk.DIALOG_DESTROY_WITH_PARENT
+                       | gtk.DIALOG_NO_SEPARATOR)
+        response =3D dialog.run()
+        dialog.destroy()
+
     def show_network_error_dialog(self):
         lbl =3D "<b>Hob cannot connect to the network</b>\n"
         msg =3D "Please check your network connection. If you are using a =
proxy server, please make sure it is configured correctly."
@@ -903,6 +917,9 @@ class Builder(gtk.Window):
             self.show_error_dialog(msg)
         self.reset()
=20
+    def handler_parsing_warning_cb(self, handler, warn_msg):
+        self.parsing_warnings.append(warn_msg)
+
     def handler_sanity_failed_cb(self, handler, msg, network_error):
         self.reset()
         if network_error:
diff --git a/bitbake/lib/bb/ui/crumbs/hig/parsingwarningsdialog.py b/bitbak=
e/lib/bb/ui/crumbs/hig/parsingwarningsdialog.py
new file mode 100644
index 0000000..5cddd65
--- /dev/null
+++ b/bitbake/lib/bb/ui/crumbs/hig/parsingwarningsdialog.py
@@ -0,0 +1,161 @@
+#
+# BitBake Graphical GTK User Interface
+#
+# Copyright (C) 2011-2012   Intel Corporation
+#
+# Authored by Cristiana Voicu <cristiana.voicu@intel.com> # # This=20
+program is free software; you can redistribute it and/or modify # it=20
+under the terms of the GNU General Public License version 2 as #=20
+published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful, # but=20
+WITHOUT ANY WARRANTY; without even the implied warranty of #=20
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the # GNU=20
+General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License=20
+along # with this program; if not, write to the Free Software=20
+Foundation, Inc., # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301=
 USA.
+
+import gtk
+import gobject
+from bb.ui.crumbs.hobwidget import HobAltButton from=20
+bb.ui.crumbs.hig.crumbsdialog import CrumbsDialog
+
+"""
+The following are convenience classes for implementing GNOME HIG=20
+compliant BitBake GUI's In summary: spacing =3D 12px, border-width =3D 6px=
=20
+"""
+
+#
+# ParsingWarningsDialog
+#
+class ParsingWarningsDialog (CrumbsDialog):
+
+    def __init__(self, title, warnings, parent, flags, buttons=3DNone):
+        super(ParsingWarningsDialog, self).__init__(title, parent,=20
+ flags, buttons)
+
+        self.warnings =3D warnings
+        self.warning_on =3D 0
+        self.warn_nb =3D len(warnings)
+
+        # create visual elements on the dialog
+        self.create_visual_elements()
+
+    def cancel_button_cb(self, button):
+        self.destroy()
+
+    def previous_button_cb(self, button):
+        self.warning_on =3D self.warning_on - 1
+        self.refresh_components()
+
+    def next_button_cb(self, button):
+        self.warning_on =3D self.warning_on + 1
+        self.refresh_components()
+
+    def refresh_components(self):
+        lbl =3D self.warnings[self.warning_on]
+        #when the warning text has more than 400 chars, it uses a scroll b=
ar
+        if 0<=3D len(lbl) < 400:
+            self.warning_label.set_size_request(320, 230)
+            self.warning_label.set_use_markup(True)
+            self.warning_label.set_line_wrap(True)
+            self.warning_label.set_markup(lbl)
+            self.warning_label.set_property("yalign", 0.00)
+        else:
+            self.textWindow.set_shadow_type(gtk.SHADOW_IN)
+            self.textWindow.set_policy(gtk.POLICY_AUTOMATIC, gtk.POLICY_AU=
TOMATIC)
+            self.msgView =3D gtk.TextView()
+            self.msgView.set_editable(False)
+            self.msgView.set_wrap_mode(gtk.WRAP_WORD)
+            self.msgView.set_cursor_visible(False)
+            self.msgView.set_size_request(320, 230)
+            self.buf =3D gtk.TextBuffer()
+            self.buf.set_text(lbl)
+            self.msgView.set_buffer(self.buf)
+            self.textWindow.add(self.msgView)
+            self.msgView.show()
+
+        if self.warning_on=3D=3D0:
+            self.previous_button.set_sensitive(False)
+        else:
+            self.previous_button.set_sensitive(True)
+
+        if self.warning_on=3D=3Dself.warn_nb-1:
+            self.next_button.set_sensitive(False)
+        else:
+            self.next_button.set_sensitive(True)
+
+        if self.warn_nb>1:
+            self.heading =3D "Warning " + str(self.warning_on + 1) + " of =
" + str(self.warn_nb)
+            self.heading_label.set_markup('<span weight=3D"bold">%s</span>=
' % self.heading)
+        else:
+            self.heading =3D "Warning"
+            self.heading_label.set_markup('<span=20
+ weight=3D"bold">%s</span>' % self.heading)
+
+        self.show_all()
+
+        if 0<=3D len(lbl) < 400:
+            self.textWindow.hide()
+        else:
+            self.warning_label.hide()
+
+    def create_visual_elements(self):
+        self.set_size_request(350, 350)
+        self.heading_label =3D gtk.Label()
+        self.heading_label.set_alignment(0.1, 0)
+        self.warning_label =3D gtk.Label()
+        self.textWindow =3D gtk.ScrolledWindow()
+
+        table =3D gtk.Table(1, 10, False)
+
+        cancel_button =3D gtk.Button()
+        cancel_button.set_label("Close")
+        cancel_button.connect("clicked", self.cancel_button_cb)
+        cancel_button.set_size_request(110, 30)
+
+        self.previous_button =3D gtk.Button()
+        image1 =3D gtk.image_new_from_stock(gtk.STOCK_GO_BACK, gtk.ICON_SI=
ZE_BUTTON)
+        image1.show()
+        box =3D gtk.HBox(False, 6)
+        box.show()
+        self.previous_button.add(box)
+        lbl =3D gtk.Label("Previous")
+        lbl.show()
+        box.pack_start(image1, expand=3DFalse, fill=3DFalse, padding=3D3)
+        box.pack_start(lbl, expand=3DTrue, fill=3DTrue, padding=3D3)
+        self.previous_button.connect("clicked", self.previous_button_cb)
+        self.previous_button.set_size_request(110, 30)
+
+        self.next_button =3D gtk.Button()
+        image2 =3D gtk.image_new_from_stock(gtk.STOCK_GO_FORWARD, gtk.ICON=
_SIZE_BUTTON)
+        image2.show()
+        box =3D gtk.HBox(False, 6)
+        box.show()
+        self.next_button.add(box)
+        lbl =3D gtk.Label("Next")
+        lbl.show()
+        box.pack_start(lbl, expand=3DTrue, fill=3DTrue, padding=3D3)
+        box.pack_start(image2, expand=3DFalse, fill=3DFalse, padding=3D3)
+        self.next_button.connect("clicked", self.next_button_cb)
+        self.next_button.set_size_request(110, 30)
+
+        #when there more than one warning, we need "previous" and "next" b=
utton
+        if self.warn_nb>1:
+            self.vbox.pack_start(self.heading_label, expand=3DFalse, fill=
=3DFalse)
+            self.vbox.pack_start(self.warning_label, expand=3DFalse, fill=
=3DFalse)
+            self.vbox.pack_start(self.textWindow, expand=3DFalse, fill=3DF=
alse)
+            table.attach(cancel_button, 6, 7, 0, 1, xoptions=3Dgtk.SHRINK)
+            table.attach(self.previous_button, 7, 8, 0, 1, xoptions=3Dgtk.=
SHRINK)
+            table.attach(self.next_button, 8, 9, 0, 1, xoptions=3Dgtk.SHRI=
NK)
+            self.vbox.pack_end(table, expand=3DFalse, fill=3DFalse)
+        else:
+            self.vbox.pack_start(self.heading_label, expand=3DFalse, fill=
=3DFalse)
+            self.vbox.pack_start(self.warning_label, expand=3DFalse, fill=
=3DFalse)
+            self.vbox.pack_start(self.textWindow, expand=3DFalse, fill=3DF=
alse)
+            cancel_button =3D self.add_button("Cancel", gtk.RESPONSE_CANCE=
L)
+            HobAltButton.style_button(cancel_button)
+
+        self.refresh_components()
diff --git a/bitbake/lib/bb/ui/crumbs/hobcolor.py b/bitbake/lib/bb/ui/crumb=
s/hobcolor.py
index e10f546..3316542 100644
--- a/bitbake/lib/bb/ui/crumbs/hobcolor.py
+++ b/bitbake/lib/bb/ui/crumbs/hobcolor.py
@@ -30,6 +30,7 @@ class HobColors:
     BLACK        =3D "#000000"
     PALE_BLUE    =3D "#53b8ff"
     DEEP_RED     =3D "#aa3e3e"
+    KHAKI        =3D "#fff68f"
=20
     OK =3D WHITE
     RUNNING =3D PALE_GREEN
diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/u=
i/crumbs/hobeventhandler.py
index e690d4c..41022ef 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -41,6 +41,9 @@ class HobHandler(gobject.GObject):
          "command-failed"          : (gobject.SIGNAL_RUN_LAST,
                                       gobject.TYPE_NONE,
                                      (gobject.TYPE_STRING,)),
+         "parsing-warning"         : (gobject.SIGNAL_RUN_LAST,
+                                      gobject.TYPE_NONE,
+                                     (gobject.TYPE_STRING,)),
          "sanity-failed"           : (gobject.SIGNAL_RUN_LAST,
                                       gobject.TYPE_NONE,
                                      (gobject.TYPE_STRING, gobject.TYPE_IN=
T)), @@ -95,6 +98,7 @@ class HobHandler(gobject.GObject):
         self.server =3D server
         self.error_msg =3D ""
         self.initcmd =3D None
+        self.parsing =3D False
=20
     def set_busy(self):
         if not self.generating:
@@ -207,6 +211,11 @@ class HobHandler(gobject.GObject):
                     formatter =3D bb.msg.BBLogFormatter()
                     msg =3D formatter.format(event)
                     self.error_msg +=3D msg + '\n'
+                elif event.levelno >=3D logging.WARNING and self.parsing =
=3D=3D True:
+                    formatter =3D bb.msg.BBLogFormatter()
+                    msg =3D formatter.format(event)
+                    warn_msg =3D msg + '\n'
+                    self.emit("parsing-warning", warn_msg)
=20
         elif isinstance(event, bb.event.TargetsTreeGenerated):
             self.current_phase =3D "data generation"
@@ -249,6 +258,8 @@ class HobHandler(gobject.GObject):
             message["total"] =3D None
             message["title"] =3D "Parsing recipes"
             self.emit("parsing-started", message)
+            if isinstance(event, bb.event.ParseStarted):
+                self.parsing =3D True
         elif isinstance(event, (bb.event.ParseProgress,
                 bb.event.CacheLoadProgress,
                 bb.event.TreeDataPreparationProgress)):
@@ -267,6 +278,8 @@ class HobHandler(gobject.GObject):
             message["total"] =3D event.total
             message["title"] =3D "Parsing recipes"
             self.emit("parsing-completed", message)
+            if isinstance(event, bb.event.ParseCompleted):
+                self.parsing =3D False
         elif isinstance(event, bb.event.NetworkTestFailed):
             self.emit("network-failed")
             self.run_next_command()
diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/l=
ib/bb/ui/crumbs/imageconfigurationpage.py
index b94f35c..ff77350 100644
--- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -46,6 +46,7 @@ class ImageConfigurationPage (HobPage):
         # cleared.
         self.machine_combo_changed_by_manual =3D True
         self.stopping =3D False
+        self.warning_shift =3D 0
         self.create_visual_elements()
=20
     def create_visual_elements(self):
@@ -141,6 +142,37 @@ class ImageConfigurationPage (HobPage):
         if self.builder.recipe_model.get_selected_image() =3D=3D self.buil=
der.recipe_model.__custom_image__:
             self.just_bake_button.hide()
=20
+    def add_warnings_bar(self):
+        #create the warnings bar shown when recipes parsing generates warn=
ings
+        color =3D HobColors.KHAKI
+        warnings_bar =3D gtk.EventBox()
+        warnings_bar.modify_bg(gtk.STATE_NORMAL, gtk.gdk.color_parse(color=
))
+        warnings_bar.set_flags(gtk.CAN_DEFAULT)
+        warnings_bar.grab_default()
+
+        build_stop_tab =3D gtk.Table(10, 20, True)
+        warnings_bar.add(build_stop_tab)
+
+        icon =3D gtk.Image()
+        icon_pix_buffer =3D gtk.gdk.pixbuf_new_from_file(hic.ICON_INDI_ALE=
RT_FILE)
+        icon.set_from_pixbuf(icon_pix_buffer)
+        build_stop_tab.attach(icon, 0, 2, 0, 10)
+
+        label =3D gtk.Label()
+        label.set_alignment(0.0, 0.5)
+        warnings_nb =3D len(self.builder.parsing_warnings)
+        if warnings_nb =3D=3D 1:
+            label.set_markup("<span size=3D'x-large'><b>1 recipe parsing w=
arning</b></span>")
+        else:
+            label.set_markup("<span size=3D'x-large'><b>%s recipe parsing =
warnings</b></span>" % warnings_nb)
+        build_stop_tab.attach(label, 2, 12, 0, 10)
+
+        view_warnings_button =3D HobButton("View warnings")
+        view_warnings_button.connect('clicked', self.view_warnings_button_=
clicked_cb)
+        build_stop_tab.attach(view_warnings_button, 15, 19, 1, 9)
+
+        return warnings_bar
+
     def create_config_machine(self):
         self.machine_title =3D gtk.Label()
         self.machine_title.set_alignment(0.0, 0.5) @@ -187,6 +219,12 @@ cl=
ass ImageConfigurationPage (HobPage):
             #self.gtable.attach(self.progress_box, 0, 40, 15, 18)
             self.gtable.attach(self.progress_bar, 0, 37, 15, 18)
             self.gtable.attach(self.stop_button, 37, 40, 15, 18, 0, 0)
+        if self.builder.parsing_warnings:
+            self.warnings_bar =3D self.add_warnings_bar()
+            self.gtable.attach(self.warnings_bar, 0, 40, 14, 18)
+            self.warning_shift =3D 4
+        else:
+            self.warning_shift =3D 0
         self.gtable.attach(self.machine_separator, 0, 40, 13, 14)
=20
     def create_config_baseimg(self):
@@ -222,12 +260,12 @@ class ImageConfigurationPage (HobPage):
         self.image_separator =3D gtk.HSeparator()
=20
     def set_config_baseimg_layout(self):
-        self.gtable.attach(self.image_title, 0, 40, 15, 17)
-        self.gtable.attach(self.image_title_desc, 0, 40, 18, 22)
-        self.gtable.attach(self.image_combo, 0, 12, 23, 26)
-        self.gtable.attach(self.image_desc, 0, 12, 27, 33)
-        self.gtable.attach(self.view_adv_configuration_button, 14, 36, 23,=
 28)
-        self.gtable.attach(self.image_separator, 0, 40, 35, 36)
+        self.gtable.attach(self.image_title, 0, 40, 15+self.warning_shift,=
 17+self.warning_shift)
+        self.gtable.attach(self.image_title_desc, 0, 40, 18+self.warning_s=
hift, 22+self.warning_shift)
+        self.gtable.attach(self.image_combo, 0, 12, 23+self.warning_shift,=
 26+self.warning_shift)
+        self.gtable.attach(self.image_desc, 0, 12, 27+self.warning_shift, =
33+self.warning_shift)
+        self.gtable.attach(self.view_adv_configuration_button, 14, 36, 23+=
self.warning_shift, 28+self.warning_shift)
+        self.gtable.attach(self.image_separator, 0, 40,=20
+ 35+self.warning_shift, 36+self.warning_shift)
=20
     def create_config_build_button(self):
         # Create the "Build packages" and "Build image" buttons at the bot=
tom @@ -255,6 +293,9 @@ class ImageConfigurationPage (HobPage):
         self.progress_bar.set_rcstyle("stop")
         self.builder.cancel_parse_sync()
=20
+    def view_warnings_button_clicked_cb(self, button):
+        self.builder.show_warning_dialog()
+
     def machine_combo_changed_cb(self, machine_combo):
         self.stopping =3D False
         combo_item =3D machine_combo.get_active_text() @@ -435,6 +476,7 @@=
 class ImageConfigurationPage (HobPage):
             self.builder.reparse_post_adv_settings()       =20
=20
     def just_bake_button_clicked_cb(self, button):
+        self.builder.parsing_warnings =3D []
         self.builder.just_bake()
=20
     def edit_image_button_clicked_cb(self, button):
diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib=
/bb/ui/crumbs/packageselectionpage.py
index 2da9277..b3f2a05 100755
--- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
@@ -197,6 +197,7 @@ class PackageSelectionPage (HobPage):
         self.show_all()
=20
     def build_image_clicked_cb(self, button):
+        self.builder.parsing_warnings =3D []
         self.builder.build_image()
=20
     def back_button_clicked_cb(self, button):
--
1.7.9.5



