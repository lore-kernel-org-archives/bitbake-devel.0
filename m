Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1TDrTl-0007Ts-MP
	for bitbake-devel@lists.openembedded.org;
	Tue, 18 Sep 2012 08:40:18 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 17 Sep 2012 23:27:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,441,1344236400"; d="scan'208";a="206768681"
Received: from irsmsx104.ger.corp.intel.com ([163.33.3.159])
	by orsmga002.jf.intel.com with ESMTP; 17 Sep 2012 23:27:35 -0700
Received: from irsmsx101.ger.corp.intel.com ([169.254.1.138]) by
	IRSMSX104.ger.corp.intel.com ([169.254.5.154]) with mapi id
	14.01.0355.002; Tue, 18 Sep 2012 07:27:35 +0100
From: "Voicu, Cristiana" <cristiana.voicu@intel.com>
To: "Marinescu, Bogdan A" <bogdan.a.marinescu@intel.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH] [hob] Fix settings
Thread-Index: AQHNkoNaYn7iQ7SqDkWmrc334TpXnJePp/ew
Date: Tue, 18 Sep 2012 06:27:34 +0000
Message-ID: <BE68E9C8E0850C43B0F0B0B7D57FA5AE19394B95@IRSMSX101.ger.corp.intel.com>
References: <1347632233-22080-1-git-send-email-bogdan.a.marinescu@intel.com>
In-Reply-To: <1347632233-22080-1-git-send-email-bogdan.a.marinescu@intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [163.33.239.182]
MIME-Version: 1.0
Subject: Re: [PATCH] [hob] Fix settings
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
X-List-Received-Date: Tue, 18 Sep 2012 06:40:18 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

Can you please merge this patch? I have another bug, depending on this one.

Thank you,
Cristiana

-----Original Message-----
From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-devel-bo=
unces@lists.openembedded.org] On Behalf Of Bogdan Marinescu
Sent: Friday, September 14, 2012 5:17 PM
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake-devel] [PATCH] [hob] Fix settings

Fix some issues with the settings dialog that were introduced as a result o=
f merging the fix for #2162.

[YOCTO #3117]

Signed-off-by: Bogdan Marinescu <bogdan.a.marinescu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hig.py              |  234 +++++++++++++---------=
----
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py |    2 +-
 2 files changed, 118 insertions(+), 118 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig=
.py index ff0ad17..e043f93 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -352,6 +352,123 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIH=
elper):
         md5 =3D self.config_md5()
         self.settings_changed =3D (self.md5 !=3D md5)
=20
+    def create_build_environment_page(self):
+        advanced_vbox =3D gtk.VBox(False, 6)
+        advanced_vbox.set_border_width(6)
+
+        sub_vbox =3D gtk.VBox(False, 6)
+        advanced_vbox.pack_start(sub_vbox, expand=3DFalse, fill=3DFalse)
+        label =3D self.gen_label_widget("<span weight=3D\"bold\">Select di=
stro:</span>")
+        tooltip =3D "Selects the Yocto Project distribution you want"
+        distro_widget, self.distro_combo =3D self.gen_combo_widget(self.co=
nfiguration.curr_distro, self.all_distros, tooltip)
+        sub_vbox.pack_start(label, expand=3DFalse, fill=3DFalse)
+        sub_vbox.pack_start(distro_widget, expand=3DFalse, fill=3DFalse)
+
+        sub_vbox =3D gtk.VBox(False, 6)
+        advanced_vbox.pack_start(sub_vbox, expand=3DFalse, fill=3DFalse)
+        label =3D self.gen_label_widget("<span weight=3D\"bold\">BB number=
 threads:</span>")
+        tooltip =3D "Sets the number of threads that BitBake tasks can sim=
ultaneously run. See the <a href=3D\""
+        tooltip +=3D "http://www.yoctoproject.org/docs/current/poky-ref-ma=
nual/"
+        tooltip +=3D "poky-ref-manual.html#var-BB_NUMBER_THREADS\">Poky re=
ference manual</a> for information"
+        bbthread_widget, self.bb_spinner =3D self.gen_spinner_widget(self.=
configuration.bbthread, 1, self.max_threads, tooltip)
+        sub_vbox.pack_start(label, expand=3DFalse, fill=3DFalse)
+        sub_vbox.pack_start(bbthread_widget, expand=3DFalse, fill=3DFalse)
+
+        sub_vbox =3D gtk.VBox(False, 6)
+        advanced_vbox.pack_start(sub_vbox, expand=3DFalse, fill=3DFalse)
+        label =3D self.gen_label_widget("<span weight=3D\"bold\">Parallel =
make:</span>")
+        tooltip =3D "Sets the maximum number of threads the host can use d=
uring the build. See the <a href=3D\""
+        tooltip +=3D "http://www.yoctoproject.org/docs/current/poky-ref-ma=
nual/"
+        tooltip +=3D "poky-ref-manual.html#var-PARALLEL_MAKE\">Poky refere=
nce manual</a> for information"
+        pmake_widget, self.pmake_spinner =3D self.gen_spinner_widget(self.=
configuration.pmake, 1, self.max_threads, tooltip)
+        sub_vbox.pack_start(label, expand=3DFalse, fill=3DFalse)
+        sub_vbox.pack_start(pmake_widget, expand=3DFalse, fill=3DFalse)
+
+        sub_vbox =3D gtk.VBox(False, 6)
+        advanced_vbox.pack_start(sub_vbox, expand=3DFalse, fill=3DFalse)
+        label =3D self.gen_label_widget("<span weight=3D\"bold\">Select do=
wnload directory:</span>")
+        tooltip =3D "Select a folder that caches the upstream project sour=
ce code"
+        dldir_widget, self.dldir_text =3D self.gen_entry_widget(self.confi=
guration.dldir, self, tooltip)
+        sub_vbox.pack_start(label, expand=3DFalse, fill=3DFalse)
+        sub_vbox.pack_start(dldir_widget, expand=3DFalse, fill=3DFalse)
+
+        sub_vbox =3D gtk.VBox(False, 6)
+        advanced_vbox.pack_start(sub_vbox, expand=3DFalse, fill=3DFalse)
+        label =3D self.gen_label_widget("<span weight=3D\"bold\">Select SS=
TATE directory:</span>")
+        tooltip =3D "Select a folder that caches your prebuilt results"
+        sstatedir_widget, self.sstatedir_text =3D self.gen_entry_widget(se=
lf.configuration.sstatedir, self, tooltip)
+        sub_vbox.pack_start(label, expand=3DFalse, fill=3DFalse)
+        sub_vbox.pack_start(sstatedir_widget, expand=3DFalse, fill=3DFalse=
)
+
+        sub_vbox =3D gtk.VBox(False, 6)
+        advanced_vbox.pack_start(sub_vbox, expand=3DFalse, fill=3DFalse)
+        label =3D self.gen_label_widget("<span weight=3D\"bold\">Select SS=
TATE mirror:</span>")
+        tooltip =3D "Select the pre-built mirror that will speed your buil=
d"
+        sstatemirror_widget, self.sstatemirror_text =3D self.gen_entry_wid=
get(self.configuration.sstatemirror, self, tooltip)
+        sub_vbox.pack_start(label, expand=3DFalse, fill=3DFalse)
+        sub_vbox.pack_start(sstatemirror_widget, expand=3DFalse,=20
+ fill=3DFalse)
+
+        return advanced_vbox
+
+    def create_proxy_page(self):
+        advanced_vbox =3D gtk.VBox(False, 6)
+        advanced_vbox.set_border_width(6)
+
+        sub_vbox =3D gtk.VBox(False, 6)
+        advanced_vbox.pack_start(sub_vbox, expand=3DFalse, fill=3DFalse)
+        label =3D self.gen_label_widget("<span weight=3D\"bold\">Set the p=
roxies used when fetching source code</span>")
+        tooltip =3D "Set the proxies used when fetching source code.  A bl=
ank field uses a direct internet connection."
+        info =3D HobInfoButton(tooltip, self)
+        hbox =3D gtk.HBox(False, 12)
+        hbox.pack_start(label, expand=3DTrue, fill=3DTrue)
+        hbox.pack_start(info, expand=3DFalse, fill=3DFalse)
+        sub_vbox.pack_start(hbox, expand=3DFalse, fill=3DFalse)
+
+        self.direct_checkbox =3D gtk.RadioButton(None, "Direct internet co=
nnection")
+        self.direct_checkbox.set_tooltip_text("Check this box to use a dir=
ect internet connection with no proxy")
+        self.direct_checkbox.set_active(not self.configuration.enable_prox=
y)
+        sub_vbox.pack_start(self.direct_checkbox, expand=3DFalse,=20
+ fill=3DFalse)
+
+        self.proxy_checkbox =3D gtk.RadioButton(self.direct_checkbox, "Man=
ual proxy configuration")
+        self.proxy_checkbox.set_tooltip_text("Check this box to manually s=
et up a specific proxy")
+        self.proxy_checkbox.set_active(self.configuration.enable_proxy)
+        sub_vbox.pack_start(self.proxy_checkbox, expand=3DFalse,=20
+ fill=3DFalse)
+
+        self.same_checkbox =3D gtk.CheckButton("Use the same proxy for all=
 protocols")
+        self.same_checkbox.set_tooltip_text("Check this box to use the HTT=
P proxy for all five proxies")
+        self.same_checkbox.set_active(self.configuration.same_proxy)
+        hbox =3D gtk.HBox(False, 12)
+        hbox.pack_start(self.same_checkbox, expand=3DFalse, fill=3DFalse, =
padding=3D24)
+        sub_vbox.pack_start(hbox, expand=3DFalse, fill=3DFalse)
+
+        proxy_widget, self.http_proxy, self.http_proxy_port, self.http_pro=
xy_details =3D self.gen_proxy_entry_widget(
+            "http", self, True)
+        sub_vbox.pack_start(proxy_widget, expand=3DFalse, fill=3DFalse)
+
+        proxy_widget, self.https_proxy, self.https_proxy_port, self.https_=
proxy_details =3D self.gen_proxy_entry_widget(
+            "https", self, True)
+        sub_vbox.pack_start(proxy_widget, expand=3DFalse, fill=3DFalse)
+
+        proxy_widget, self.ftp_proxy, self.ftp_proxy_port, self.ftp_proxy_=
details =3D self.gen_proxy_entry_widget(
+            "ftp", self, True)
+        sub_vbox.pack_start(proxy_widget, expand=3DFalse, fill=3DFalse)
+
+        proxy_widget, self.git_proxy, self.git_proxy_port, self.git_proxy_=
details =3D self.gen_proxy_entry_widget(
+            "git", self, True)
+        sub_vbox.pack_start(proxy_widget, expand=3DFalse, fill=3DFalse)
+
+        proxy_widget, self.cvs_proxy, self.cvs_proxy_port, self.cvs_proxy_=
details =3D self.gen_proxy_entry_widget(
+            "cvs", self, True)
+        sub_vbox.pack_start(proxy_widget, expand=3DFalse, fill=3DFalse)
+
+        self.direct_checkbox.connect("toggled", self.proxy_checkbox_toggle=
d_cb)
+        self.proxy_checkbox.connect("toggled", self.proxy_checkbox_toggled=
_cb)
+        self.same_checkbox.connect("toggled",=20
+ self.same_checkbox_toggled_cb)
+
+        self.refresh_proxy_components()
+        return advanced_vbox
+
+
     def create_visual_elements(self):
         self.nb =3D gtk.Notebook()
         self.nb.set_show_tabs(True)       =20
@@ -364,7 +481,6 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHel=
per):
         self.show_all()
=20
=20
-
 #
 # AdvancedSettings Dialog
 #
@@ -685,122 +801,6 @@ class AdvancedSettingDialog (CrumbsDialog, SettingsUI=
Helper):
=20
         return advanced_vbox
=20
-    def create_build_environment_page(self):
-        advanced_vbox =3D gtk.VBox(False, 6)
-        advanced_vbox.set_border_width(6)
-
-        sub_vbox =3D gtk.VBox(False, 6)
-        advanced_vbox.pack_start(sub_vbox, expand=3DFalse, fill=3DFalse)
-        label =3D self.gen_label_widget("<span weight=3D\"bold\">Select di=
stro:</span>")
-        tooltip =3D "Selects the Yocto Project distribution you want"
-        distro_widget, self.distro_combo =3D self.gen_combo_widget(self.co=
nfiguration.curr_distro, self.all_distros, tooltip)
-        sub_vbox.pack_start(label, expand=3DFalse, fill=3DFalse)
-        sub_vbox.pack_start(distro_widget, expand=3DFalse, fill=3DFalse)
-
-        sub_vbox =3D gtk.VBox(False, 6)
-        advanced_vbox.pack_start(sub_vbox, expand=3DFalse, fill=3DFalse)
-        label =3D self.gen_label_widget("<span weight=3D\"bold\">BB number=
 threads:</span>")
-        tooltip =3D "Sets the number of threads that BitBake tasks can sim=
ultaneously run. See the <a href=3D\""
-        tooltip +=3D "http://www.yoctoproject.org/docs/current/poky-ref-ma=
nual/"
-        tooltip +=3D "poky-ref-manual.html#var-BB_NUMBER_THREADS\">Poky re=
ference manual</a> for information"
-        bbthread_widget, self.bb_spinner =3D self.gen_spinner_widget(self.=
configuration.bbthread, 1, self.max_threads, tooltip)
-        sub_vbox.pack_start(label, expand=3DFalse, fill=3DFalse)
-        sub_vbox.pack_start(bbthread_widget, expand=3DFalse, fill=3DFalse)
-
-        sub_vbox =3D gtk.VBox(False, 6)
-        advanced_vbox.pack_start(sub_vbox, expand=3DFalse, fill=3DFalse)
-        label =3D self.gen_label_widget("<span weight=3D\"bold\">Parallel =
make:</span>")
-        tooltip =3D "Sets the maximum number of threads the host can use d=
uring the build. See the <a href=3D\""
-        tooltip +=3D "http://www.yoctoproject.org/docs/current/poky-ref-ma=
nual/"
-        tooltip +=3D "poky-ref-manual.html#var-PARALLEL_MAKE\">Poky refere=
nce manual</a> for information"
-        pmake_widget, self.pmake_spinner =3D self.gen_spinner_widget(self.=
configuration.pmake, 1, self.max_threads, tooltip)
-        sub_vbox.pack_start(label, expand=3DFalse, fill=3DFalse)
-        sub_vbox.pack_start(pmake_widget, expand=3DFalse, fill=3DFalse)
-
-        sub_vbox =3D gtk.VBox(False, 6)
-        advanced_vbox.pack_start(sub_vbox, expand=3DFalse, fill=3DFalse)
-        label =3D self.gen_label_widget("<span weight=3D\"bold\">Select do=
wnload directory:</span>")
-        tooltip =3D "Select a folder that caches the upstream project sour=
ce code"
-        dldir_widget, self.dldir_text =3D self.gen_entry_widget(self.confi=
guration.dldir, self, tooltip)
-        sub_vbox.pack_start(label, expand=3DFalse, fill=3DFalse)
-        sub_vbox.pack_start(dldir_widget, expand=3DFalse, fill=3DFalse)
-
-        sub_vbox =3D gtk.VBox(False, 6)
-        advanced_vbox.pack_start(sub_vbox, expand=3DFalse, fill=3DFalse)
-        label =3D self.gen_label_widget("<span weight=3D\"bold\">Select SS=
TATE directory:</span>")
-        tooltip =3D "Select a folder that caches your prebuilt results"
-        sstatedir_widget, self.sstatedir_text =3D self.gen_entry_widget(se=
lf.configuration.sstatedir, self, tooltip)
-        sub_vbox.pack_start(label, expand=3DFalse, fill=3DFalse)
-        sub_vbox.pack_start(sstatedir_widget, expand=3DFalse, fill=3DFalse=
)
-
-        sub_vbox =3D gtk.VBox(False, 6)
-        advanced_vbox.pack_start(sub_vbox, expand=3DFalse, fill=3DFalse)
-        label =3D self.gen_label_widget("<span weight=3D\"bold\">Select SS=
TATE mirror:</span>")
-        tooltip =3D "Select the pre-built mirror that will speed your buil=
d"
-        sstatemirror_widget, self.sstatemirror_text =3D self.gen_entry_wid=
get(self.configuration.sstatemirror, self, tooltip)
-        sub_vbox.pack_start(label, expand=3DFalse, fill=3DFalse)
-        sub_vbox.pack_start(sstatemirror_widget, expand=3DFalse, fill=3DFa=
lse)
-
-        return advanced_vbox
-
-    def create_proxy_page(self):
-        advanced_vbox =3D gtk.VBox(False, 6)
-        advanced_vbox.set_border_width(6)
-
-        sub_vbox =3D gtk.VBox(False, 6)
-        advanced_vbox.pack_start(sub_vbox, expand=3DFalse, fill=3DFalse)
-        label =3D self.gen_label_widget("<span weight=3D\"bold\">Set the p=
roxies used when fetching source code</span>")
-        tooltip =3D "Set the proxies used when fetching source code.  A bl=
ank field uses a direct internet connection."
-        info =3D HobInfoButton(tooltip, self)
-        hbox =3D gtk.HBox(False, 12)
-        hbox.pack_start(label, expand=3DTrue, fill=3DTrue)
-        hbox.pack_start(info, expand=3DFalse, fill=3DFalse)
-        sub_vbox.pack_start(hbox, expand=3DFalse, fill=3DFalse)
-
-        self.direct_checkbox =3D gtk.RadioButton(None, "Direct internet co=
nnection")
-        self.direct_checkbox.set_tooltip_text("Check this box to use a dir=
ect internet connection with no proxy")
-        self.direct_checkbox.set_active(not self.configuration.enable_prox=
y)
-        sub_vbox.pack_start(self.direct_checkbox, expand=3DFalse, fill=3DF=
alse)
-
-        self.proxy_checkbox =3D gtk.RadioButton(self.direct_checkbox, "Man=
ual proxy configuration")
-        self.proxy_checkbox.set_tooltip_text("Check this box to manually s=
et up a specific proxy")
-        self.proxy_checkbox.set_active(self.configuration.enable_proxy)
-        sub_vbox.pack_start(self.proxy_checkbox, expand=3DFalse, fill=3DFa=
lse)
-
-        self.same_checkbox =3D gtk.CheckButton("Use the same proxy for all=
 protocols")
-        self.same_checkbox.set_tooltip_text("Check this box to use the HTT=
P proxy for all five proxies")
-        self.same_checkbox.set_active(self.configuration.same_proxy)
-        hbox =3D gtk.HBox(False, 12)
-        hbox.pack_start(self.same_checkbox, expand=3DFalse, fill=3DFalse, =
padding=3D24)
-        sub_vbox.pack_start(hbox, expand=3DFalse, fill=3DFalse)
-
-        proxy_widget, self.http_proxy, self.http_proxy_port, self.http_pro=
xy_details =3D self.gen_proxy_entry_widget(
-            "http", self, True)
-        sub_vbox.pack_start(proxy_widget, expand=3DFalse, fill=3DFalse)
-
-        proxy_widget, self.https_proxy, self.https_proxy_port, self.https_=
proxy_details =3D self.gen_proxy_entry_widget(
-            "https", self, True)
-        sub_vbox.pack_start(proxy_widget, expand=3DFalse, fill=3DFalse)
-
-        proxy_widget, self.ftp_proxy, self.ftp_proxy_port, self.ftp_proxy_=
details =3D self.gen_proxy_entry_widget(
-            "ftp", self, True)
-        sub_vbox.pack_start(proxy_widget, expand=3DFalse, fill=3DFalse)
-
-        proxy_widget, self.git_proxy, self.git_proxy_port, self.git_proxy_=
details =3D self.gen_proxy_entry_widget(
-            "git", self, True)
-        sub_vbox.pack_start(proxy_widget, expand=3DFalse, fill=3DFalse)
-
-        proxy_widget, self.cvs_proxy, self.cvs_proxy_port, self.cvs_proxy_=
details =3D self.gen_proxy_entry_widget(
-            "cvs", self, True)
-        sub_vbox.pack_start(proxy_widget, expand=3DFalse, fill=3DFalse)
-
-        self.direct_checkbox.connect("toggled", self.proxy_checkbox_toggle=
d_cb)
-        self.proxy_checkbox.connect("toggled", self.proxy_checkbox_toggled=
_cb)
-        self.same_checkbox.connect("toggled", self.same_checkbox_toggled_c=
b)
-
-        self.refresh_proxy_components()
-        return advanced_vbox
-
     def create_others_page(self):
         advanced_vbox =3D gtk.VBox(False, 6)
         advanced_vbox.set_border_width(6) diff --git a/bitbake/lib/bb/ui/c=
rumbs/imagedetailspage.py b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
index ed8c7ac..5a6cb21 100755
--- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
@@ -587,7 +587,7 @@ class ImageDetailsPage (HobPage):
=20
     def settings_button_clicked_cb(self, button):
         # Create an advanced settings dialog
-        response, settings_changed =3D self.builder.show_adv_settings_dial=
og()
+        response, settings_changed =3D=20
+ self.builder.show_simple_settings_dialog()
         if not response:
             return
         if settings_changed:
--
1.7.9.5


_______________________________________________
bitbake-devel mailing list
bitbake-devel@lists.openembedded.org
http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel


