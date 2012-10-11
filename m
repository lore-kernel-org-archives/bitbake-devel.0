Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <bogdan.a.marinescu@intel.com>) id 1TMHMk-0004vL-2g
	for bitbake-devel@lists.openembedded.org;
	Thu, 11 Oct 2012 13:55:51 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 11 Oct 2012 04:42:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,571,1344236400"; d="scan'208";a="232667788"
Received: from bogdanm (HELO localhost.localdomain) ([10.237.105.62])
	by fmsmga001.fm.intel.com with ESMTP; 11 Oct 2012 04:42:37 -0700
From: Bogdan Marinescu <bogdan.a.marinescu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Oct 2012 14:45:07 +0300
Message-Id: <1349955907-6440-1-git-send-email-bogdan.a.marinescu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH 2/2] Add a button for network tests in the proxy settings
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
X-List-Received-Date: Thu, 11 Oct 2012 11:55:51 -0000

This patch allows the user to check the network connectivity in
the "Proxy" page ("Settings" dialog) by adding a button which provides
this functionality. It also disables retrigerring sanity checks if the
proxy values are changed, since now the proxy checks are explicit.
Note that this patch depends on a patch in oe-core
("sanity.bbclass: trigger network tests explicitly"). It will
not work properly if the patch in oe-core is not merged.

[YOCTO #3026]

Signed-off-by: Bogdan Marinescu <bogdan.a.marinescu@intel.com>
---
 bitbake/lib/bb/event.py                     |   16 ++
 bitbake/lib/bb/ui/crumbs/builder.py         |   47 +++--
 bitbake/lib/bb/ui/crumbs/hig.py             |  258 +++++++++++++++++++++------
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |   23 ++-
 4 files changed, 273 insertions(+), 71 deletions(-)

diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
index 1889d09..e41455d 100644
--- a/bitbake/lib/bb/event.py
+++ b/bitbake/lib/bb/event.py
@@ -566,3 +566,19 @@ class SanityCheckFailed(Event):
         Event.__init__(self)
         self._msg = msg
         self._network_error = network_error
+
+class NetworkTest(Event):
+    """
+    Event to start network test
+    """
+
+class NetworkTestPassed(Event):
+    """
+    Event to indicate network test has passed
+    """
+
+class NetworkTestFailed(Event):
+    """
+    Event to indicate network test has failed
+    """
+
diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 6ddc5b6..44e2aa5 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -51,10 +51,10 @@ class Configuration:
 
     @classmethod
     def parse_proxy_string(cls, proxy):
-        pattern = "^\s*((http|https|ftp|git|cvs)://)?((\S+):(\S+)@)?(\S+):(\d+)/?"
+        pattern = "^\s*((http|https|ftp|git|cvs)://)?((\S+):(\S+)@)?([^\s:]+)(:(\d+))?/?"
         match = re.search(pattern, proxy)
         if match:
-            return match.group(2), match.group(4), match.group(5), match.group(6), match.group(7)
+            return match.group(2), match.group(4), match.group(5), match.group(6), match.group(8)
         else:
             return None, None, None, "", ""
 
@@ -82,10 +82,10 @@ class Configuration:
 
     @classmethod
     def make_proxy_string(cls, prot, user, passwd, host, port, default_prot=""):
-        if host == None or host == "" or port == None or port == "":
+        if host == None or host == "":# or port == None or port == "":
             return ""
 
-        return Configuration.make_host_string(prot, user, passwd, host, default_prot) + ":" + Configuration.make_port_string(port)
+        return Configuration.make_host_string(prot, user, passwd, host, default_prot) + (":" + Configuration.make_port_string(port) if port else "")
 
     def __init__(self):
         self.curr_mach = ""
@@ -746,6 +746,20 @@ class Builder(gtk.Window):
         self.previous_step = self.current_step
         self.current_step = next_step
 
+    def set_user_config_proxies(self):
+        if self.configuration.enable_proxy == True:
+            self.handler.set_http_proxy(self.configuration.combine_proxy("http"))
+            self.handler.set_https_proxy(self.configuration.combine_proxy("https"))
+            self.handler.set_ftp_proxy(self.configuration.combine_proxy("ftp"))
+            self.handler.set_git_proxy(self.configuration.combine_host_only("git"), self.configuration.combine_port_only("git"))
+            self.handler.set_cvs_proxy(self.configuration.combine_host_only("cvs"), self.configuration.combine_port_only("cvs"))
+        elif self.configuration.enable_proxy == False:
+            self.handler.set_http_proxy("")
+            self.handler.set_https_proxy("")
+            self.handler.set_ftp_proxy("")
+            self.handler.set_git_proxy("", "")
+            self.handler.set_cvs_proxy("", "")
+
     def set_user_config(self):
         self.handler.init_cooker()
         # set bb layers
@@ -767,19 +781,7 @@ class Builder(gtk.Window):
         self.handler.set_extra_config(self.configuration.extra_setting)
         self.handler.set_extra_inherit("packageinfo")
         self.handler.set_extra_inherit("image_types")
-        # set proxies
-        if self.configuration.enable_proxy == True:
-            self.handler.set_http_proxy(self.configuration.combine_proxy("http"))
-            self.handler.set_https_proxy(self.configuration.combine_proxy("https"))
-            self.handler.set_ftp_proxy(self.configuration.combine_proxy("ftp"))
-            self.handler.set_git_proxy(self.configuration.combine_host_only("git"), self.configuration.combine_port_only("git"))
-            self.handler.set_cvs_proxy(self.configuration.combine_host_only("cvs"), self.configuration.combine_port_only("cvs"))
-        elif self.configuration.enable_proxy == False:
-            self.handler.set_http_proxy("")
-            self.handler.set_https_proxy("")
-            self.handler.set_ftp_proxy("")
-            self.handler.set_git_proxy("", "")
-            self.handler.set_cvs_proxy("", "")
+        self.set_user_config_proxies()
 
     def update_recipe_model(self, selected_image, selected_recipes):
         self.recipe_model.set_selected_image(selected_image)
@@ -1310,7 +1312,8 @@ class Builder(gtk.Window):
             parent = self,
             flags = gtk.DIALOG_MODAL
                     | gtk.DIALOG_DESTROY_WITH_PARENT
-                    | gtk.DIALOG_NO_SEPARATOR)
+                    | gtk.DIALOG_NO_SEPARATOR,
+            handler = self.handler)
         button = dialog.add_button("Cancel", gtk.RESPONSE_NO)
         HobAltButton.style_button(button)
         button = dialog.add_button("Save", gtk.RESPONSE_YES)
@@ -1323,6 +1326,14 @@ class Builder(gtk.Window):
             self.configuration = dialog.configuration
             self.save_defaults() # remember settings
             settings_changed = dialog.settings_changed
+            if dialog.proxy_settings_changed:
+                self.set_user_config_proxies()
+        elif dialog.proxy_test_ran:
+            # The user might have modified the proxies in the "Proxy"
+            # tab, which in turn made the proxy settings modify in bb.
+            # If "Cancel" was pressed, restore the previous proxy
+            # settings inside bb.
+            self.set_user_config_proxies()
         dialog.destroy()
         return response == gtk.RESPONSE_YES, settings_changed
 
diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index ccd9f39..b3aea92 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -319,9 +319,16 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
      PROXIES_PAGE_ID,
      OTHERS_PAGE_ID) = range(4)
 
+    (TEST_NETWORK_NONE,
+     TEST_NETWORK_INITIAL,
+     TEST_NETWORK_RUNNING,
+     TEST_NETWORK_PASSED,
+     TEST_NETWORK_FAILED,
+     TEST_NETWORK_CANCELED) = range(6)
+
     def __init__(self, title, configuration, all_image_types,
             all_package_formats, all_distros, all_sdk_machines,
-            max_threads, parent, flags, buttons=None):
+            max_threads, parent, flags, handler, buttons=None):
         super(SimpleSettingsDialog, self).__init__(title, parent, flags, buttons)
 
         # class members from other objects
@@ -348,7 +355,11 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
         self.image_types_checkbuttons = {}
 
         self.md5 = self.config_md5()
+        self.proxy_md5 = self.config_proxy_md5()
         self.settings_changed = False
+        self.proxy_settings_changed = False
+        self.handler = handler
+        self.proxy_test_ran = False
 
         # create visual elements on the dialog
         self.create_visual_elements()
@@ -357,12 +368,15 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
     def _get_sorted_value(self, var):
         return " ".join(sorted(str(var).split())) + "\n"
 
-    def config_md5(self):
-        data = ""
-        data += ("ENABLE_PROXY: "         + self._get_sorted_value(self.configuration.enable_proxy))
+    def config_proxy_md5(self):
+        data = ("ENABLE_PROXY: "         + self._get_sorted_value(self.configuration.enable_proxy))
         if self.configuration.enable_proxy:
             for protocol in self.configuration.proxies.keys():
                 data += (protocol + ": " + self._get_sorted_value(self.configuration.combine_proxy(protocol)))
+        return hashlib.md5(data).hexdigest()
+
+    def config_md5(self):
+        data = ""
         for key in self.configuration.extra_setting.keys():
             data += (key + ": " + self._get_sorted_value(self.configuration.extra_setting[key]))
         return hashlib.md5(data).hexdigest()
@@ -383,28 +397,25 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
             self.refresh_proxy_components()
         dialog.destroy()
 
-    def gen_proxy_entry_widget(self, protocol, parent, need_button=True):
-        hbox = gtk.HBox(False, 12)
-
+    def gen_proxy_entry_widget(self, protocol, parent, need_button=True, line=0):
         label = gtk.Label(protocol.upper() + " proxy")
-        hbox.pack_start(label, expand=True, fill=False, padding=24)
+        self.proxy_table.attach(label, 0, 1, line, line+1, xpadding=24)
 
         proxy_entry = gtk.Entry()
         proxy_entry.set_size_request(300, -1)
-        hbox.pack_start(proxy_entry, expand=False, fill=False)
+        self.proxy_table.attach(proxy_entry, 1, 2, line, line+1, ypadding=4)
 
-        hbox.pack_start(gtk.Label(":"), expand=False, fill=False)
+        self.proxy_table.attach(gtk.Label(":"), 2, 3, line, line+1, xpadding=12, ypadding=4)
 
         port_entry = gtk.Entry()
         port_entry.set_size_request(60, -1)
-        hbox.pack_start(port_entry, expand=False, fill=False)
+        self.proxy_table.attach(port_entry, 3, 4, line, line+1, ypadding=4)
 
         details_button = HobAltButton("Details")
         details_button.connect("clicked", self.details_cb, parent, protocol)
-        hbox.pack_start(details_button, expand=False, fill=False)
+        self.proxy_table.attach(details_button, 4, 5, line, line+1, xpadding=4, yoptions=gtk.EXPAND)
 
-        hbox.show_all()
-        return hbox, proxy_entry, port_entry, details_button
+        return proxy_entry, port_entry, details_button
 
     def refresh_proxy_components(self):
         self.same_checkbox.set_sensitive(self.configuration.enable_proxy)
@@ -449,18 +460,53 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
         self.cvs_proxy_port.set_sensitive(self.configuration.enable_proxy and (not self.configuration.same_proxy))
         self.cvs_proxy_details.set_sensitive(self.configuration.enable_proxy and (not self.configuration.same_proxy))
 
+        if self.configuration.same_proxy:
+            if self.http_proxy.get_text():
+                [w.set_text(self.http_proxy.get_text()) for w in self.same_proxy_addresses]
+            if self.http_proxy_port.get_text():
+                [w.set_text(self.http_proxy_port.get_text()) for w in self.same_proxy_ports]
+
     def proxy_checkbox_toggled_cb(self, button):
         self.configuration.enable_proxy = self.proxy_checkbox.get_active()
         if not self.configuration.enable_proxy:
             self.configuration.same_proxy = False
             self.same_checkbox.set_active(self.configuration.same_proxy)
+        self.save_proxy_data()
         self.refresh_proxy_components()
 
     def same_checkbox_toggled_cb(self, button):
         self.configuration.same_proxy = self.same_checkbox.get_active()
+        self.save_proxy_data()
         self.refresh_proxy_components()
 
-    def response_cb(self, dialog, response_id):        
+    def save_proxy_data(self):
+        self.configuration.split_proxy("http", self.http_proxy.get_text() + ":" + self.http_proxy_port.get_text())
+        if self.configuration.same_proxy:
+            self.configuration.split_proxy("https", self.http_proxy.get_text() + ":" + self.http_proxy_port.get_text())
+            self.configuration.split_proxy("ftp", self.http_proxy.get_text() + ":" + self.http_proxy_port.get_text())
+            self.configuration.split_proxy("git", self.http_proxy.get_text() + ":" + self.http_proxy_port.get_text())
+            self.configuration.split_proxy("cvs", self.http_proxy.get_text() + ":" + self.http_proxy_port.get_text())
+        else:
+            self.configuration.split_proxy("https", self.https_proxy.get_text() + ":" + self.https_proxy_port.get_text())
+            self.configuration.split_proxy("ftp", self.ftp_proxy.get_text() + ":" + self.ftp_proxy_port.get_text())
+            self.configuration.split_proxy("git", self.git_proxy.get_text() + ":" + self.git_proxy_port.get_text())
+            self.configuration.split_proxy("cvs", self.cvs_proxy.get_text() + ":" + self.cvs_proxy_port.get_text())       
+
+    def response_cb(self, dialog, response_id):
+        if response_id == gtk.RESPONSE_YES:
+            # Check that all proxy entries have a corresponding port
+            for proxy, port in zip(self.all_proxy_addresses, self.all_proxy_ports):
+                if proxy.get_text() and not port.get_text():
+                    lbl = "<b>Enter all port numbers</b>\n\n"
+                    msg = "Proxy servers require a port number. Please make sure you have entered a port number for each proxy server."
+                    dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_WARNING, msg)
+                    button = dialog.add_button("Close", gtk.RESPONSE_OK)
+                    HobButton.style_button(button)
+                    response = dialog.run()
+                    dialog.destroy()
+                    self.emit_stop_by_name("response")
+                    return
+
         self.configuration.dldir = self.dldir_text.get_text()
         self.configuration.sstatedir = self.sstatedir_text.get_text()
         self.configuration.sstatemirror = ""
@@ -473,19 +519,7 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
                 self.configuration.sstatemirror += smirror
         self.configuration.bbthread = self.bb_spinner.get_value_as_int()
         self.configuration.pmake = self.pmake_spinner.get_value_as_int()
-                
-        self.configuration.split_proxy("http", self.http_proxy.get_text() + ":" + self.http_proxy_port.get_text())
-        if self.configuration.same_proxy:
-            self.configuration.split_proxy("https", self.http_proxy.get_text() + ":" + self.http_proxy_port.get_text())
-            self.configuration.split_proxy("ftp", self.http_proxy.get_text() + ":" + self.http_proxy_port.get_text())
-            self.configuration.split_proxy("git", self.http_proxy.get_text() + ":" + self.http_proxy_port.get_text())
-            self.configuration.split_proxy("cvs", self.http_proxy.get_text() + ":" + self.http_proxy_port.get_text())
-        else:
-            self.configuration.split_proxy("https", self.https_proxy.get_text() + ":" + self.https_proxy_port.get_text())
-            self.configuration.split_proxy("ftp", self.ftp_proxy.get_text() + ":" + self.ftp_proxy_port.get_text())
-            self.configuration.split_proxy("git", self.git_proxy.get_text() + ":" + self.git_proxy_port.get_text())
-            self.configuration.split_proxy("cvs", self.cvs_proxy.get_text() + ":" + self.cvs_proxy_port.get_text())
-
+        self.save_proxy_data()
         self.configuration.extra_setting = {}
         it = self.setting_store.get_iter_first()
         while it:
@@ -496,6 +530,7 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
 
         md5 = self.config_md5()
         self.settings_changed = (self.md5 != md5)
+        self.proxy_settings_changed = (self.proxy_md5 != self.config_proxy_md5())
 
     def create_build_environment_page(self):
         advanced_vbox = gtk.VBox(False, 6)
@@ -608,10 +643,91 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
         self.show_all()
         self.nb.set_current_page(page_num)
 
+    def test_proxy_ended(self, passed):
+        self.proxy_test_running = False
+        self.set_test_proxy_state(self.TEST_NETWORK_PASSED if passed else self.TEST_NETWORK_FAILED)
+        self.set_sensitive(True)
+        self.refresh_proxy_components()
 
-    def create_proxy_page(self):
+    def timer_func(self):
+        self.test_proxy_progress.pulse()
+        return self.proxy_test_running
+
+    def test_network_button_cb(self, b):
+        self.set_test_proxy_state(self.TEST_NETWORK_RUNNING)
+        self.set_sensitive(False)
+        self.save_proxy_data()
+        if self.configuration.enable_proxy == True:
+            self.handler.set_http_proxy(self.configuration.combine_proxy("http"))
+            self.handler.set_https_proxy(self.configuration.combine_proxy("https"))
+            self.handler.set_ftp_proxy(self.configuration.combine_proxy("ftp"))
+            self.handler.set_git_proxy(self.configuration.combine_host_only("git"), self.configuration.combine_port_only("git"))
+            self.handler.set_cvs_proxy(self.configuration.combine_host_only("cvs"), self.configuration.combine_port_only("cvs"))
+        elif self.configuration.enable_proxy == False:
+            self.handler.set_http_proxy("")
+            self.handler.set_https_proxy("")
+            self.handler.set_ftp_proxy("")
+            self.handler.set_git_proxy("", "")
+            self.handler.set_cvs_proxy("", "")
+        self.proxy_test_ran = True
+        self.proxy_test_running = True
+        gobject.timeout_add(100, self.timer_func)
+        self.handler.trigger_network_test()
+
+    def test_proxy_focus_event(self, w, direction):
+        if self.test_proxy_state in [self.TEST_NETWORK_PASSED, self.TEST_NETWORK_FAILED]:
+            self.set_test_proxy_state(self.TEST_NETWORK_INITIAL)
+        return False
+
+    def http_proxy_changed(self, e):
+        if not self.configuration.same_proxy:
+            return
+        if e == self.http_proxy:
+            [w.set_text(self.http_proxy.get_text()) for w in self.same_proxy_addresses]
+        else:
+            [w.set_text(self.http_proxy_port.get_text()) for w in self.same_proxy_ports]
+
+    def proxy_address_focus_out_event(self, w, direction):
+        text = w.get_text()
+        if not text:
+            return False
+        if text.find("//") == -1:
+            w.set_text("http://" + text)
+        return False
+
+    def set_test_proxy_state(self, state):
+        if self.test_proxy_state == state:
+            return
+        [self.proxy_table.remove(w) for w in self.test_gui_elements]
+        if state == self.TEST_NETWORK_INITIAL:
+            self.proxy_table.attach(self.test_network_button, 1, 2, 5, 6)
+            self.test_network_button.show()
+        elif state == self.TEST_NETWORK_RUNNING:
+            self.test_proxy_progress.set_rcstyle("running")
+            self.test_proxy_progress.set_text("Testing network configuration")
+            self.proxy_table.attach(self.test_proxy_progress, 0, 5, 5, 6, xpadding=4)
+            self.test_proxy_progress.show()
+        else: # passed or failed
+            self.dummy_progress.update(1.0)
+            if state == self.TEST_NETWORK_PASSED:
+                self.dummy_progress.set_text("Your network is properly configured")
+                self.dummy_progress.set_rcstyle("running")
+            else:
+                self.dummy_progress.set_text("Network test failed")
+                self.dummy_progress.set_rcstyle("fail")
+            self.proxy_table.attach(self.dummy_progress, 0, 4, 5, 6)
+            self.proxy_table.attach(self.retest_network_button, 4, 5, 5, 6, xpadding=4)
+            self.dummy_progress.show()
+            self.retest_network_button.show()
+        self.test_proxy_state = state
+
+    def create_network_page(self):
         advanced_vbox = gtk.VBox(False, 6)
         advanced_vbox.set_border_width(6)
+        self.same_proxy_addresses = []
+        self.same_proxy_ports = []
+        self.all_proxy_ports = []
+        self.all_proxy_addresses = []
 
         sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
@@ -623,42 +739,77 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
         hbox.pack_start(info, expand=False, fill=False)
         sub_vbox.pack_start(hbox, expand=False, fill=False)
 
-        self.direct_checkbox = gtk.RadioButton(None, "Direct internet connection")
+        proxy_test_focus = []
+        self.direct_checkbox = gtk.RadioButton(None, "Direct network connection")
+        proxy_test_focus.append(self.direct_checkbox)
         self.direct_checkbox.set_tooltip_text("Check this box to use a direct internet connection with no proxy")
         self.direct_checkbox.set_active(not self.configuration.enable_proxy)
         sub_vbox.pack_start(self.direct_checkbox, expand=False, fill=False)
 
         self.proxy_checkbox = gtk.RadioButton(self.direct_checkbox, "Manual proxy configuration")
+        proxy_test_focus.append(self.proxy_checkbox)
         self.proxy_checkbox.set_tooltip_text("Check this box to manually set up a specific proxy")
         self.proxy_checkbox.set_active(self.configuration.enable_proxy)
         sub_vbox.pack_start(self.proxy_checkbox, expand=False, fill=False)
 
-        self.same_checkbox = gtk.CheckButton("Use the same proxy for all protocols")
+        self.same_checkbox = gtk.CheckButton("Use the HTTP proxy for all protocols")
+        proxy_test_focus.append(self.same_checkbox)
         self.same_checkbox.set_tooltip_text("Check this box to use the HTTP proxy for all five proxies")
         self.same_checkbox.set_active(self.configuration.same_proxy)
         hbox = gtk.HBox(False, 12)
         hbox.pack_start(self.same_checkbox, expand=False, fill=False, padding=24)
         sub_vbox.pack_start(hbox, expand=False, fill=False)
 
-        proxy_widget, self.http_proxy, self.http_proxy_port, self.http_proxy_details = self.gen_proxy_entry_widget(
-            "http", self, True)
-        sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
-
-        proxy_widget, self.https_proxy, self.https_proxy_port, self.https_proxy_details = self.gen_proxy_entry_widget(
-            "https", self, True)
-        sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
-
-        proxy_widget, self.ftp_proxy, self.ftp_proxy_port, self.ftp_proxy_details = self.gen_proxy_entry_widget(
-            "ftp", self, True)
-        sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
-
-        proxy_widget, self.git_proxy, self.git_proxy_port, self.git_proxy_details = self.gen_proxy_entry_widget(
-            "git", self, True)
-        sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
-
-        proxy_widget, self.cvs_proxy, self.cvs_proxy_port, self.cvs_proxy_details = self.gen_proxy_entry_widget(
-            "cvs", self, True)
-        sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
+        self.proxy_table = gtk.Table(6, 5, False)
+        self.http_proxy, self.http_proxy_port, self.http_proxy_details = self.gen_proxy_entry_widget(
+            "http", self, True, 0)
+        proxy_test_focus +=[self.http_proxy, self.http_proxy_port]
+        self.http_proxy.connect("changed", self.http_proxy_changed)
+        self.http_proxy_port.connect("changed", self.http_proxy_changed)
+
+        self.https_proxy, self.https_proxy_port, self.https_proxy_details = self.gen_proxy_entry_widget(
+            "https", self, True, 1)
+        proxy_test_focus += [self.https_proxy, self.https_proxy_port]
+        self.same_proxy_addresses.append(self.https_proxy)
+        self.same_proxy_ports.append(self.https_proxy_port)
+
+        self.ftp_proxy, self.ftp_proxy_port, self.ftp_proxy_details = self.gen_proxy_entry_widget(
+            "ftp", self, True, 2)
+        proxy_test_focus += [self.ftp_proxy, self.ftp_proxy_port]
+        self.same_proxy_addresses.append(self.ftp_proxy)
+        self.same_proxy_ports.append(self.ftp_proxy_port)
+
+        self.git_proxy, self.git_proxy_port, self.git_proxy_details = self.gen_proxy_entry_widget(
+            "git", self, True, 3)
+        proxy_test_focus += [self.git_proxy, self.git_proxy_port]
+        self.same_proxy_addresses.append(self.git_proxy)
+        self.same_proxy_ports.append(self.git_proxy_port)
+
+        self.cvs_proxy, self.cvs_proxy_port, self.cvs_proxy_details = self.gen_proxy_entry_widget(
+            "cvs", self, True, 4)
+        proxy_test_focus += [self.cvs_proxy, self.cvs_proxy_port]
+        self.same_proxy_addresses.append(self.cvs_proxy)
+        self.same_proxy_ports.append(self.cvs_proxy_port)
+        self.all_proxy_ports = self.same_proxy_ports + [self.http_proxy_port]
+        self.all_proxy_addresses = self.same_proxy_addresses + [self.http_proxy]
+        sub_vbox.pack_start(self.proxy_table, expand=False, fill=False)
+        self.proxy_table.show_all()
+
+        # Create the graphical elements for the network test feature, but don't display them yet
+        self.test_network_button = HobAltButton("Test network configuration")
+        self.test_network_button.connect("clicked", self.test_network_button_cb)
+        self.test_proxy_progress = HobProgressBar()
+        self.dummy_progress = HobProgressBar()
+        self.retest_network_button = HobAltButton("Retest")
+        self.retest_network_button.connect("clicked", self.test_network_button_cb)
+        self.test_gui_elements = [self.test_network_button, self.test_proxy_progress, self.dummy_progress, self.retest_network_button]
+        # Initialize the network tester
+        self.test_proxy_state = self.TEST_NETWORK_NONE
+        self.set_test_proxy_state(self.TEST_NETWORK_INITIAL)
+        self.proxy_test_passed_id = self.handler.connect("network-passed", lambda h:self.test_proxy_ended(True))
+        self.proxy_test_failed_id = self.handler.connect("network-failed", lambda h:self.test_proxy_ended(False))
+        [w.connect("focus-in-event", self.test_proxy_focus_event) for w in proxy_test_focus]
+        [w.connect("focus-out-event", self.proxy_address_focus_out_event) for w in self.all_proxy_addresses]
 
         self.direct_checkbox.connect("toggled", self.proxy_checkbox_toggled_cb)
         self.proxy_checkbox.connect("toggled", self.proxy_checkbox_toggled_cb)
@@ -840,7 +991,7 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
         self.nb.set_show_tabs(True)        
         self.nb.append_page(self.create_build_environment_page(), gtk.Label("Build environment"))
         self.nb.append_page(self.create_shared_state_page(), gtk.Label("Shared state"))
-        self.nb.append_page(self.create_proxy_page(), gtk.Label("Proxies"))        
+        self.nb.append_page(self.create_network_page(), gtk.Label("Network"))        
         self.nb.append_page(self.create_others_page(), gtk.Label("Others"))
         self.nb.set_current_page(0)
         self.vbox.pack_start(self.nb, expand=True, fill=True)
@@ -848,6 +999,11 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
 
         self.show_all()
 
+    def destroy(self):
+        self.handler.disconnect(self.proxy_test_passed_id)
+        self.handler.disconnect(self.proxy_test_failed_id)
+        super(SimpleSettingsDialog, self).destroy()
+
 
 #
 # AdvancedSettings Dialog
diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index 5d038f4..7d3af6c 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -65,10 +65,17 @@ class HobHandler(gobject.GObject):
          "package-populated"       : (gobject.SIGNAL_RUN_LAST,
                                       gobject.TYPE_NONE,
                                      ()),
+         "network-passed"          : (gobject.SIGNAL_RUN_LAST,
+                                      gobject.TYPE_NONE,
+                                     ()),
+         "network-failed"          : (gobject.SIGNAL_RUN_LAST,
+                                      gobject.TYPE_NONE,
+                                     ()),
     }
 
-    (GENERATE_CONFIGURATION, GENERATE_RECIPES, GENERATE_PACKAGES, GENERATE_IMAGE, POPULATE_PACKAGEINFO, SANITY_CHECK) = range(6)
-    (SUB_PATH_LAYERS, SUB_FILES_DISTRO, SUB_FILES_MACH, SUB_FILES_SDKMACH, SUB_MATCH_CLASS, SUB_PARSE_CONFIG, SUB_SANITY_CHECK, SUB_GNERATE_TGTS, SUB_GENERATE_PKGINFO, SUB_BUILD_RECIPES, SUB_BUILD_IMAGE) = range(11)
+    (GENERATE_CONFIGURATION, GENERATE_RECIPES, GENERATE_PACKAGES, GENERATE_IMAGE, POPULATE_PACKAGEINFO, SANITY_CHECK, NETWORK_TEST) = range(7)
+    (SUB_PATH_LAYERS, SUB_FILES_DISTRO, SUB_FILES_MACH, SUB_FILES_SDKMACH, SUB_MATCH_CLASS, SUB_PARSE_CONFIG, SUB_SANITY_CHECK,
+     SUB_GNERATE_TGTS, SUB_GENERATE_PKGINFO, SUB_BUILD_RECIPES, SUB_BUILD_IMAGE, SUB_NETWORK_TEST) = range(12)
 
     def __init__(self, server, recipe_model, package_model):
         super(HobHandler, self).__init__()
@@ -146,6 +153,8 @@ class HobHandler(gobject.GObject):
             self.runCommand(["triggerEvent", "bb.event.RequestPackageInfo()"])
         elif next_command == self.SUB_SANITY_CHECK:
             self.runCommand(["triggerEvent", "bb.event.SanityCheck()"])
+        elif next_command == self.SUB_NETWORK_TEST:
+            self.runCommand(["triggerEvent", "bb.event.NetworkTest()"])
         elif next_command == self.SUB_BUILD_RECIPES:
             self.clear_busy()
             self.building = True
@@ -254,6 +263,12 @@ class HobHandler(gobject.GObject):
             message["total"] = event.total
             message["title"] = "Parsing recipes: "
             self.emit("parsing-completed", message)
+        elif isinstance(event, bb.event.NetworkTestFailed):
+            self.emit("network-failed")
+            self.run_next_command()
+        elif isinstance(event, bb.event.NetworkTestPassed):
+            self.emit("network-passed")
+            self.run_next_command()
 
         if self.error_msg and not self.commands_async:
             self.display_error()
@@ -348,6 +363,10 @@ class HobHandler(gobject.GObject):
         self.commands_async.append(self.SUB_SANITY_CHECK)
         self.run_next_command(self.SANITY_CHECK)
 
+    def trigger_network_test(self):
+        self.commands_async.append(self.SUB_NETWORK_TEST)
+        self.run_next_command(self.NETWORK_TEST)
+
     def generate_configuration(self):
         self.commands_async.append(self.SUB_PARSE_CONFIG)
         self.commands_async.append(self.SUB_PATH_LAYERS)
-- 
1.7.9.5



