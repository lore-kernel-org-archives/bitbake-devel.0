Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1TGSap-000750-8o
	for bitbake-devel@lists.openembedded.org;
	Tue, 25 Sep 2012 12:42:19 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 25 Sep 2012 03:29:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,481,1344236400"; d="scan'208";a="197375486"
Received: from cvoicu-vostro-460 (HELO localhost.localdomain)
	([10.237.105.151])
	by orsmga001.jf.intel.com with ESMTP; 25 Sep 2012 03:29:28 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 25 Sep 2012 13:30:20 +0300
Message-Id: <1348569020-1266-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob/settings: implement a new tab in settings dialog to show SSTATE_MIRRORS
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
X-List-Received-Date: Tue, 25 Sep 2012 10:42:20 -0000

Add a new tab to show correctly SSTATE_MIRRORS variable. Now you can add new
mirrors or delete mirror. "info" image was also changed( it is smaller, so it
can be next to labels).
From "Build environment" tab, SSTATE_DIR and SSTATE_MIRRORS vars were removed.

[YOCTO #2893]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py           |    8 +-
 bitbake/lib/bb/ui/crumbs/hig.py               |  176 +++++++++++++++++++++++--
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py   |    6 +-
 bitbake/lib/bb/ui/crumbs/template.py          |    2 +-
 bitbake/lib/bb/ui/icons/info/info_display.png |  Bin 4558 -> 4117 bytes
 bitbake/lib/bb/ui/icons/info/info_hover.png   |  Bin 4650 -> 4167 bytes
 6 files changed, 171 insertions(+), 21 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 267fde1..555ba73 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -187,7 +187,7 @@ class Configuration:
         self.curr_distro = template.getVar("DISTRO")
         self.dldir = template.getVar("DL_DIR")
         self.sstatedir = template.getVar("SSTATE_DIR")
-        self.sstatemirror = template.getVar("SSTATE_MIRROR")
+        self.sstatemirror = template.getVar("SSTATE_MIRRORS")
         try:
             self.pmake = int(template.getVar("PARALLEL_MAKE").split()[1])
         except:
@@ -237,7 +237,7 @@ class Configuration:
         template.setVar("DISTRO", self.curr_distro)
         template.setVar("DL_DIR", self.dldir)
         template.setVar("SSTATE_DIR", self.sstatedir)
-        template.setVar("SSTATE_MIRROR", self.sstatemirror)
+        template.setVar("SSTATE_MIRRORS", self.sstatemirror)
         template.setVar("PARALLEL_MAKE", "-j %s" % self.pmake)
         template.setVar("BB_NUMBER_THREADS", self.bbthread)
         template.setVar("PACKAGE_CLASSES", " ".join(["package_" + i for i in self.curr_package_format.split()]))
@@ -326,7 +326,7 @@ def hob_conf_filter(fn, data):
 
         keys = ["MACHINE_HOB", "SDKMACHINE_HOB", "PACKAGE_CLASSES_HOB", \
                 "BB_NUMBER_THREADS_HOB", "PARALLEL_MAKE_HOB", "DL_DIR_HOB", \
-                "SSTATE_DIR_HOB", "SSTATE_MIRROR_HOB", "INCOMPATIBLE_LICENSE_HOB"]
+                "SSTATE_DIR_HOB", "SSTATE_MIRRORS_HOB", "INCOMPATIBLE_LICENSE_HOB"]
         for key in keys:
             var_hob = data.getVar(key)
             if var_hob:
@@ -697,7 +697,7 @@ class Builder(gtk.Window):
         self.handler.set_distro(self.configuration.curr_distro)
         self.handler.set_dl_dir(self.configuration.dldir)
         self.handler.set_sstate_dir(self.configuration.sstatedir)
-        self.handler.set_sstate_mirror(self.configuration.sstatemirror)
+        self.handler.set_sstate_mirrors(self.configuration.sstatemirror)
         self.handler.set_pmake(self.configuration.pmake)
         self.handler.set_bbthreads(self.configuration.bbthread)
         self.handler.set_rootfs_size(self.configuration.image_rootfs_size)
diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index f304a68..c9b0961 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -51,6 +51,14 @@ class SettingsUIHelper():
         label.show()
         return label
 
+    def gen_label_info_widget(self, content, tooltip):
+        table = gtk.Table(1, 10, False)
+        label = self.gen_label_widget(content)
+        info = HobInfoButton(tooltip, self)
+        table.attach(label, 0, 1, 0, 1, xoptions=gtk.FILL)
+        table.attach(info, 1, 2, 0, 1, xoptions=gtk.FILL, xpadding=10)
+        return table
+
     def gen_spinner_widget(self, content, lower, upper, tooltip=""):
         hbox = gtk.HBox(False, 12)
         adjust = gtk.Adjustment(value=content, lower=lower, upper=upper, step_incr=1)
@@ -117,12 +125,90 @@ class SettingsUIHelper():
         else:
             hbox.pack_start(entry, expand=True, fill=True)
 
-        info = HobInfoButton(tooltip, self)
-        hbox.pack_start(info, expand=False, fill=False)
+        if tooltip != "":
+            info = HobInfoButton(tooltip, self)
+            hbox.pack_start(info, expand=False, fill=False)
 
         hbox.show_all()
         return hbox, entry
 
+    def gen_mirror_entry_widget(self, content, index, match_content=""):
+        hbox = gtk.HBox(False, 12)
+        entry = gtk.Entry()
+        content = content[:-2]
+        entry.set_text(content)
+        entry_match = gtk.Entry()
+        entry_match.set_text(match_content)
+
+        table = gtk.Table(2, 6, True)
+        hbox.pack_start(table, expand=True, fill=True)
+        label_configuration = gtk.Label("Configuration")
+        label_mirror_url = gtk.Label("Mirror URL")
+        label_match = gtk.Label("Match")
+        label_replace_with = gtk.Label("Replace with")
+
+        combo = gtk.combo_box_new_text()
+        combo.append_text("Standard")
+        combo.append_text("Custom")
+        if match_content == "":
+            combo.set_active(0)
+        else:
+            combo.set_active(1)
+        combo.connect("changed", self.on_combo_changed, index)
+
+        delete_button = HobAltButton("Delete")
+        delete_button.connect("clicked", self.delete_cb, index, entry)
+        if content == "":
+            delete_button.set_sensitive(False)
+
+        entry.connect("changed", self.insert_entry_cb, index, delete_button)
+
+        if match_content == "":
+            table.attach(label_configuration, 0, 1, 0, 1)
+            table.attach(label_mirror_url, 1, 2, 0, 1)
+            table.attach(combo, 0, 1, 1, 2)
+            table.attach(entry, 1, 5, 1, 2)
+            table.attach(delete_button, 5, 6, 1, 2)
+        else:
+            table.attach(label_configuration, 0, 1, 0, 1)
+            table.attach(label_match, 1, 2, 0, 1)
+            table.attach(label_replace_with, 2, 3, 0, 1)
+            table.attach(combo, 0, 1, 1, 2)
+            table.attach(entry_match, 1, 2, 1, 2)
+            table.attach(entry, 2, 5, 1, 2)
+            table.attach(delete_button, 5, 6, 1, 2)
+
+        hbox.show_all()
+        return hbox
+
+    def insert_entry_cb(self, entry, index, button):
+        self.sstatemirrors_list[index][1] = entry.get_text()
+        if entry.get_text() == "":
+            button.set_sensitive(False)
+        else:
+            button.set_sensitive(True)
+
+    def on_combo_changed(self, combo, index):
+        if combo.get_active_text() == "Standard":
+            self.sstatemirrors_list[index][0] = 0
+        else:
+            self.sstatemirrors_list[index][0] = 1
+        self.refresh_shared_state_page()
+
+    def delete_cb(self, button, index, entry):
+        if index == 0 and len(self.sstatemirrors_list)==1:
+            entry.set_text("")
+        else:
+            self.sstatemirrors_list.pop(index)
+            self.refresh_shared_state_page()
+
+    def add_mirror(self, button):
+        tooltip = "Select the pre-built mirror that will speed your build"
+        index = len(self.sstatemirrors_list)
+        sm_list = [0, "", "file://(.*)"]
+        self.sstatemirrors_list.append(sm_list)
+        self.refresh_shared_state_page()
+
 #
 # CrumbsDialog
 #
@@ -197,7 +283,8 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
         # class members for internal use
         self.dldir_text = None
         self.sstatedir_text = None
-        self.sstatemirror_text = None
+        self.sstatemirrors_list = []
+        self.sstatemirrors_changed = 0
         self.bb_spinner = None
         self.pmake_spinner = None
         self.rootfs_size_spinner = None
@@ -331,7 +418,14 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
     def response_cb(self, dialog, response_id):        
         self.configuration.dldir = self.dldir_text.get_text()
         self.configuration.sstatedir = self.sstatedir_text.get_text()
-        self.configuration.sstatemirror = self.sstatemirror_text.get_text()
+        self.configuration.sstatemirror = ""
+        for mirror in self.sstatemirrors_list:
+            if mirror[1] != "" or len(self.sstatemirrors_list)==1:
+                if mirror[1].endswith("\\1"):
+                    smirror = mirror[2] + " " + mirror[1] + " \\n "
+                else:
+                    smirror = mirror[2] + " " + mirror[1] + "\\1 \\n "
+                self.configuration.sstatemirror += smirror
         self.configuration.bbthread = self.bb_spinner.get_value_as_int()
         self.configuration.pmake = self.pmake_spinner.get_value_as_int()
                 
@@ -382,24 +476,79 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(dldir_widget, expand=False, fill=False)
 
+        return advanced_vbox
+
+    def create_shared_state_page(self):
+        advanced_vbox = gtk.VBox(False, 6)
+        advanced_vbox.set_border_width(6)
+
         sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
-        label = self.gen_label_widget("<span weight=\"bold\">Select SSTATE directory:</span>")
+        content = "<span weight=\"bold\">Shared state directory</span>"
         tooltip = "Select a folder that caches your prebuilt results"
-        sstatedir_widget, self.sstatedir_text = self.gen_entry_widget(self.configuration.sstatedir, self, tooltip)
+        label = self.gen_label_info_widget(content, tooltip)
+        sstatedir_widget, self.sstatedir_text = self.gen_entry_widget(self.configuration.sstatedir, self)
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(sstatedir_widget, expand=False, fill=False)
 
         sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
-        label = self.gen_label_widget("<span weight=\"bold\">Select SSTATE mirror:</span>")
-        tooltip = "Select the pre-built mirror that will speed your build"
-        sstatemirror_widget, self.sstatemirror_text = self.gen_entry_widget(self.configuration.sstatemirror, self, tooltip)
-        sub_vbox.pack_start(label, expand=False, fill=False)
-        sub_vbox.pack_start(sstatemirror_widget, expand=False, fill=False)
+        content = "<span weight=\"bold\">Shared state mirrors</span>"
+        tooltip = "URLs pointing to pre-built mirrors that will speed your build. "
+        tooltip += "Select the \'Standard\' configuration if the structure of your "
+        tooltip += "mirror replicates the structure of your local shared state directory. "
+        tooltip += "For more information on shared state mirrors, check the <a href=\""
+        tooltip += "http://www.yoctoproject.org/docs/current/poky-ref-manual/"
+        tooltip += "poky-ref-manual.html#shared-state\">Yocto Project Reference Manual</a>."
+        table = self.gen_label_info_widget(content, tooltip)
+        sub_vbox.pack_start(table, expand=False, fill=False)
+
+        searched_string = "file://"
+
+        if self.sstatemirrors_changed == 0:
+            self.sstatemirrors_changed = 1
+            sstatemirrors = self.configuration.sstatemirror
+            while sstatemirrors.find(searched_string) != -1:
+                if sstatemirrors.find(searched_string,1) != -1:
+                    sstatemirror = sstatemirrors[:sstatemirrors.find(searched_string,1)]
+                    sstatemirrors = sstatemirrors[sstatemirrors.find(searched_string,1):]
+                else:
+                    sstatemirror = sstatemirrors
+                    sstatemirrors = sstatemirrors[1:]
+
+                sstatemirror_fields = [x for x in sstatemirror.split(' ') if x.strip()]
+                if sstatemirror_fields[0] == "file://(.*)":
+                    sm_list = [ 0, sstatemirror_fields[1], "file://(.*)"]
+                else:
+                    sm_list = [ 1, sstatemirror_fields[1], sstatemirror_fields[0]]
+                self.sstatemirrors_list.append(sm_list)
+
+        index = 0
+        for mirror in self.sstatemirrors_list:
+            if mirror[0] == 0:
+                sstatemirror_widget = self.gen_mirror_entry_widget(mirror[1], index)
+            else:
+                sstatemirror_widget = self.gen_mirror_entry_widget(mirror[1], index, mirror[2])
+            sub_vbox.pack_start(sstatemirror_widget, expand=False, fill=False)
+            index += 1
+
+        sub_vbox = gtk.VBox(False, 6)
+        advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
+        add_mirror_button = HobAltButton("Add another mirror")
+        add_mirror_button.set_size_request(100, -1)
+        add_mirror_button.connect("clicked", self.add_mirror)
+        sub_vbox.pack_start(add_mirror_button, expand=False, fill=False)
 
         return advanced_vbox
 
+    def refresh_shared_state_page(self):
+        page_num = self.nb.get_current_page()
+        self.nb.remove_page(page_num);
+        self.nb.insert_page(self.create_shared_state_page(), gtk.Label("Shared state"),page_num)
+        self.show_all()
+        self.nb.set_current_page(page_num)
+
+
     def create_proxy_page(self):
         advanced_vbox = gtk.VBox(False, 6)
         advanced_vbox.set_border_width(6)
@@ -461,9 +610,10 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
 
     def create_visual_elements(self):
         self.nb = gtk.Notebook()
-        self.nb.set_show_tabs(True)        
+        self.nb.set_show_tabs(True)
         self.nb.append_page(self.create_build_environment_page(), gtk.Label("Build environment"))
-        self.nb.append_page(self.create_proxy_page(), gtk.Label("Proxies"))        
+        self.nb.append_page(self.create_shared_state_page(), gtk.Label("Shared state"))
+        self.nb.append_page(self.create_proxy_page(), gtk.Label("Proxies"))
         self.nb.set_current_page(0)
         self.vbox.pack_start(self.nb, expand=True, fill=True)
         self.vbox.pack_end(gtk.HSeparator(), expand=True, fill=True)
diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index 49db2de..ed55acc 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -297,8 +297,8 @@ class HobHandler(gobject.GObject):
     def set_sstate_dir(self, directory):
         self.runCommand(["setVariable", "SSTATE_DIR_HOB", directory])
 
-    def set_sstate_mirror(self, url):
-        self.runCommand(["setVariable", "SSTATE_MIRROR_HOB", url])
+    def set_sstate_mirrors(self, url):
+        self.runCommand(["setVariable", "SSTATE_MIRRORS_HOB", url])
 
     def set_extra_size(self, image_extra_size):
         self.runCommand(["setVariable", "IMAGE_ROOTFS_EXTRA_SPACE", str(image_extra_size)])
@@ -421,7 +421,7 @@ class HobHandler(gobject.GObject):
         params["distro"] = self.runCommand(["getVariable", "DISTRO"]) or "defaultsetup"
         params["pclass"] = self.runCommand(["getVariable", "PACKAGE_CLASSES"]) or ""
         params["sstatedir"] = self.runCommand(["getVariable", "SSTATE_DIR"]) or ""
-        params["sstatemirror"] = self.runCommand(["getVariable", "SSTATE_MIRROR"]) or ""
+        params["sstatemirror"] = self.runCommand(["getVariable", "SSTATE_MIRRORS"]) or ""
 
         num_threads = self.runCommand(["getCpuCount"])
         if not num_threads:
diff --git a/bitbake/lib/bb/ui/crumbs/template.py b/bitbake/lib/bb/ui/crumbs/template.py
index 7309bb6..e303c3a 100644
--- a/bitbake/lib/bb/ui/crumbs/template.py
+++ b/bitbake/lib/bb/ui/crumbs/template.py
@@ -137,7 +137,7 @@ class RecipeFile(ConfigFile):
 
 class TemplateMgr(gobject.GObject):
 
-    __gLocalVars__ = ["MACHINE", "PACKAGE_CLASSES", "DISTRO", "DL_DIR", "SSTATE_DIR", "SSTATE_MIRROR", "PARALLEL_MAKE", "BB_NUMBER_THREADS", "CONF_VERSION"]
+    __gLocalVars__ = ["MACHINE", "PACKAGE_CLASSES", "DISTRO", "DL_DIR", "SSTATE_DIR", "SSTATE_MIRRORS", "PARALLEL_MAKE", "BB_NUMBER_THREADS", "CONF_VERSION"]
     __gBBLayersVars__ = ["BBLAYERS", "LCONF_VERSION"]
     __gRecipeVars__ = ["DEPENDS", "IMAGE_INSTALL"]
 
diff --git a/bitbake/lib/bb/ui/icons/info/info_display.png b/bitbake/lib/bb/ui/icons/info/info_display.png
index 6e2c44b2c9c794e7fe43859469d88605525ab3e2..5afbba29f578425ca337161130297daf47189e2a 100644
GIT binary patch
delta 1467
zcmV;s1w{JJBb6W_iBL{Q4GJ0x0000DNk~Le0000O0000O2nGNE0N{5$_>+zb7qKH;
z3V$GDNK#Dz0D2_=0Dyx40Qvs_0D$QL0Cg|`0P0`>06Lfe02gnPU&TfM00lrvL_t(|
z+O(EUXdTxT$A5G0%)I${U-R_*?8udkiKKv<6jQ6Rp-D{&5!9;^0yZ)3rUhjYu+w5g
z0$r3+TF9o|rJLaH3R$!mHJDPWRt|1bCx1{dc9dEzRE{F5FDrT<^Jebcxm`To%TuJZ
ztDfO(W)9~+=lsw8pKBRo_<x$^x!xCk6hah*5YI^|pA%A?v@FZTKyLEYT<0HXt$)+%
zwC?_Q0B0|NWmyOzeA}@vdj;=Rx8Rmt*Tr!hEXx7|I@hRFk)#PpH~DLtra#zi?|;7Y
zKLLag*tR|H2mbHEAe=0fON3!a5Cpgd7bzvi7?e^Z-Gp|#O{>+S)ojt}bY4%A<ke=U
zsSgAYLg2dYQ{_r|u~Mm2Yqc8Hs7kR|#Pd9C$3|EJgCW;BX_^wpF}u6FY;SL~y|qnq
zxB1(4yZyp$dv^e050V$$LnF13n}5})T5U8M)JAHQN+k+j0VyR>6m`y=IrH)6=B9t=
z&Ydx13`JF>SS%8TA)e>4;cR?c2=O}b{m%d_upOIPt@cJGs*FB1`WW>?bxNfYuIpl1
z7FugAT)6Ou@$vCDfurl|>pxmqS*iQJkK;JFuG_0n2y&CZ(x^9nzrMMC6Mw*#QsVpm
zsW1$mZ!{W=jEqn!l?J3{Sw_3v=H9(~KfZG1%KNsonVFfH>vp?!&-0K{;`ts`s+io6
zWf_j+`~r9az=|pn6O$8f`M&?c=;$a>Ey8tOgb)CvY0A!{9k#Z%Zf$LCz2-R16Gx65
z`DJaSCc`is#A&VRv^#8UY=7|Z;X~He*1od($?9FZP$(dT_*S`G#t;0#q-fpaDa$gn
z*2HoAjFj?C$8pMOno6B%wAKtCRL6A)iy@Utg}@KyfR{y~P&g!|41M3nw(UXkz8hn(
zEQ`69=Kg;BFSl<k{AuBjPd@eJmSJz4)*8#Qa9x)m2&hyl&j5(ir+-gR^vAGI=&<K`
zj=^yJ`0<}T{q?86d-fY=Up##H@ZDVJ2gde6gcJ<`d!#<{rJYZAuq>;W>~q?rlp;wI
z7XQ5Xw`Q}6l#=!J^?xU6g6-HyDG!nu01rS+eR(SG6J?Ac&+|R5Gfk2tBuPTE*`(EM
zk#rN%G(~56Uwpr%wSQWz3m|4^XYWZV^Us&tca<qrs!&Q1$1!mnld2SzDl(lN*e0E8
z%9ZjafIT@mxpMUA(Va(+9@YAjGi<|To7|9FIVLygy!XCe{cwDiWt{rzsXGAT@e_|{
z(_fqZKq)mC$vuChKP%lBL;pF5WUVzyDWsI@*>67kD*%zEDSwwPUHW-7s<xF<`+Az2
zysw~gh<H0U`F_5%CQ})+v$GGz#>U<S5Z$DU=Xp2JpFe*)O;dAV6((n4Vc~mN6tOsQ
z|Ni|mCf{F$Qi`Y+wJ%=0_){POu+uc<*s){z%F4=XtE;Og=I7_frIfwpGBkE^H=gr+
z?>kaTKaOL9Ab;q!D$fTK=s1qLcJ12RrBdnF12t8tqSNXyF+TDBgXIT5G{*d7et!Oh
z)iaDS*tSg=gjiU<kOI&1ddfMJyjrQoSFc^YJvljf8OR0;$F*G?*P&P}5=9XoE`9jo
z;^N}f>({SOZf|b~#`F|2NfI)Z4NmIthMSq0S(}@idw-{1uU`fJwP&L_(&=xrflw`d
zv^1S%+2tEIZcM-T?t6!pK3a;hEE6U-V1cj%)u`G%dGh4uxpU{%rlzLe0^R_c`*yM;
z9RQ@1IF3UQ1Qbg}mjAIVfLY)yFulCIT<&x_5@2j>tQ$qqDsT&U8~EoJ-75Yw0DA-;
V$U2m<77PFY002ovPDHLkV1jFy(lY=6

delta 1909
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

diff --git a/bitbake/lib/bb/ui/icons/info/info_hover.png b/bitbake/lib/bb/ui/icons/info/info_hover.png
index a05da56ae7c11143b1bf24da010e2d789dcf6d44..f9d294dfae2a3a74086018fbbf140a500a622d7f 100644
GIT binary patch
delta 1517
zcmV<J1rqwIB*!2jiBL{Q4GJ0x0000DNk~Le0000O0000O2nGNE0N{5$_>+zb7qKH;
z3V$GDNK#Dz0D2_=0Dyx40Qvs_0D$QL0Cg|`0P0`>06Lfe02gnPU&TfM00nYML_t(|
z+O(EUXk6D7$A9nMJMUxW&1mLnB#kt-K$aZ|8ADK=x+=tV7Y>vdV}f_7wJP-{5ZZ2<
z>{>6{G`KWbWtCE|YHDaV4W<MNsxem6K!3rF7a3ZxkZUQjW=5LHys!J-?Lr^5Ds|CC
zFPz2Y-FyD$od5aX^DJWw|IcNWoYK)BEDK9mzLM&qRPv&f@<m|@+ZaP`@+X<jKGj<P
zw%hMM{GR|U%R)-&*|z<rSM=WUT(9DKF1BqWguobs)|w<v2&0g25dJxeq91H-ZGYZ7
z5}@c5_cuZc?1FvL_x;~jhAJ-vLBP<^5ami4&-IW>VvHe45(a|-Tiq?X-7eium+kHC
zcf&AztJ~{lhX5?gLI{EDx@UqQSgMcItK;M2jEs&@tyU?ON)!qOgcM*vXPPLA==b`x
z+iljKuCcbZ#^&bc?|R$4tL?4!K7WYXD~s#7BV(gucN^o4>g41kjqwIS5a1O(lv0$-
z<-zRi?CRFmme*>vj^}w!5+npcK($)M_kA4Oxw0<S-vz$E4<LlVaUI6S#y%JyAD@^y
zF~zat$Eek6c%Fx4S!k^}fByW(&1UmMpxNnke$;Na>$Yv<xDKx8;y4aUDSr&+dy~z{
zKdd}ixeK7Al=!~?m0GR#+VRQbG@DI=Ai#B9gb*Z2!uIwyt<PIGZv6PhUka+g{Mq^I
zgTbI)EEZ8p;rl)o7I~hNqzO{W_kbAy<+?7@)6+k!kJM>28dPglY}*DP&vVi=rQhpw
z>(;HGudl7Y?KsX%!7iL0pMMy~aU7(S2qEx_9`$;iFbwJU`Y)WCK6R$`_tryIEEaJb
z=Uer9ol2!bp-{jWLzeCElx5itsbTc8km5tBWF?McskPoe^Bj-VYBlQhIzo!;z#Gad
zdLypqmdfQawqqY~4q%Ky3d!r=e*N=TFTHvX@ZNv#{Z|Hq!Em1E2Y-5A2!ZE$RE8=T
zV_pVO=gyrwr8AA=I0zy5&r5szX0!RztFK-CrBss3moNXZ*Y91>S|g=A7>ts5o<|f$
zqX25SK76dx=^&*%6g@ziri4+*g9i`(+UayqO7X?U7wb_J;kxdTPmEFusiX@aW@l$Z
zDJ57t5#)J(z;vn!2Y(@97}DNs({8s32O&`up|w7A-WY?Bf?BN>0f-CVyzrS2BG0p&
zEXxjAnx@2YOdQAb`aSynK5-P2#0h&uKW}?L<#PEMfSR73UKt%7?P{%qOlM#nO!>gY
zEGL&ax!DayXJqPNNp-48)0DZnxlaJZ{EPE??)2QJaT1g2^nY*``Hpi87!0}D0m$>5
zEI*uak|tPK>B83+egz=HDCEkOE59ffi(e*5a%7oy6)N|JlTNid%DL8>IF5Pgt1q=C
zCMF*201QGL$GLm);>G)M9GmCsxJMem{rmU7Bc$+!5L2yI>uY;0{Jf=UN~u)(^3tVC
zKLKI@H5d#ybAS3w{_wMhZ*OdDOf4@jpDYv#SeEtg-j<RyO|O^z@}g48OVbo#i34rD
ztC#fJwQC>wzW?hzPNWhFEVzC9_CIglyt&cu_2*YsR;ujMZE}OoG$u1Br3$|9Q>)eR
z%RaVkV_6nimf^Z?xVX4@@5G4{-vze!0i=+a+<<{QcYp5u?VX>!^DGF0>Bo;BSCS+t
z00>J^unUw*B`TH5&V=*4edW*0%sgFOT>N-qV&V;8^?>l)f{RiL*K-MifU&VLmhLT`
z&9dyxrKP2_j~+c5S$Vut)0q}|mhVhIDX5ey(aBRMpDipbJe``F`VH^_&^x4Tr{L^N
zo?VdYP(GF6;bE3PSr))6z&C)itE;P(FbpL?qtS@U<?<8YPrygOKmOZa#lHpsi{kXD
T-MSxi00000NkvXXu0mjfsA>7^

delta 2002
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

-- 
1.7.9.5



