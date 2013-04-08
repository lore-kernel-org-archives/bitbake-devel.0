Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristian.iorga@intel.com>) id 1UPErk-0006kr-2o
	for bitbake-devel@lists.openembedded.org;
	Mon, 08 Apr 2013 18:24:23 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 08 Apr 2013 09:04:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,432,1363158000"; d="scan'208";a="291816945"
Received: from sentry.rb.intel.com ([10.237.105.54])
	by orsmga001.jf.intel.com with ESMTP; 08 Apr 2013 09:05:52 -0700
From: Cristian Iorga <cristian.iorga@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  8 Apr 2013 19:06:33 +0300
Message-Id: <1365437193-24074-1-git-send-email-cristian.iorga@intel.com>
X-Mailer: git-send-email 1.7.10.4
Cc: Cristian Iorga <ubik3000@gmail.com>
Subject: [PATCH] bitbake:hob: use a socks proxy mechanism for git
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
X-List-Received-Date: Mon, 08 Apr 2013 16:24:24 -0000

Instead of a custom git proxy mechanism, Hob now
uses a SOCKS proxy in order to work with external
repos via the oe-git-proxy helper script.

Fixes [YOCTO #4187]

Signed-off-by: Cristian Iorga <cristian.iorga@intel.com>
Signed-off-by: Cristian Iorga <ubik3000@gmail.com>
Signed-off-by: Cristian Iorga <cristian.iorga@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py                |   23 +++++++-------
 .../lib/bb/ui/crumbs/hig/simplesettingsdialog.py   |   32 ++++++++++----------
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py        |    9 ++----
 3 files changed, 30 insertions(+), 34 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 6f95f5b..b347f6d 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -56,7 +56,7 @@ class Configuration:
 
     @classmethod
     def parse_proxy_string(cls, proxy):
-        pattern = "^\s*((http|https|ftp|git|cvs)://)?((\S+):(\S+)@)?([^\s:]+)(:(\d+))?/?"
+        pattern = "^\s*((http|https|ftp|socks|cvs)://)?((\S+):(\S+)@)?([^\s:]+)(:(\d+))?/?"
         match = re.search(pattern, proxy)
         if match:
             return match.group(2), match.group(4), match.group(5), match.group(6), match.group(8)
@@ -124,7 +124,7 @@ class Configuration:
             "http"  : [None, None, None, "", ""],  # protocol : [prot, user, passwd, host, port]
             "https" : [None, None, None, "", ""],
             "ftp"   : [None, None, None, "", ""],
-            "git"   : [None, None, None, "", ""],
+            "socks" : [None, None, None, "", ""],
             "cvs"   : [None, None, None, "", ""],
         }
 
@@ -181,13 +181,13 @@ class Configuration:
         self.default_task = params["default_task"]
 
         # proxy settings
-        self.enable_proxy = params["http_proxy"] != "" or params["https_proxy"] != "" or params["ftp_proxy"] != "" \
-            or params["git_proxy_host"] != "" or params["git_proxy_port"] != ""                                    \
+        self.enable_proxy = params["http_proxy"] != "" or params["https_proxy"] != "" \
+            or params["ftp_proxy"] != "" or params["socks_proxy"] != "" \
             or params["cvs_proxy_host"] != "" or params["cvs_proxy_port"] != ""
         self.split_proxy("http", params["http_proxy"])
         self.split_proxy("https", params["https_proxy"])
         self.split_proxy("ftp", params["ftp_proxy"])
-        self.split_proxy("git", params["git_proxy_host"] + ":" + params["git_proxy_port"])
+        self.split_proxy("socks", params["socks_proxy"])
         self.split_proxy("cvs", params["cvs_proxy_host"] + ":" + params["cvs_proxy_port"])
 
     def load(self, template):
@@ -215,7 +215,7 @@ class Configuration:
         self.split_proxy("http", template.getVar("http_proxy"))
         self.split_proxy("https", template.getVar("https_proxy"))
         self.split_proxy("ftp", template.getVar("ftp_proxy"))
-        self.split_proxy("git", template.getVar("GIT_PROXY_HOST") + ":" + template.getVar("GIT_PROXY_PORT"))
+        self.split_proxy("socks", template.getVar("all_proxy"))
         self.split_proxy("cvs", template.getVar("CVS_PROXY_HOST") + ":" + template.getVar("CVS_PROXY_PORT"))
 
     def save(self, handler, template, defaults=False):
@@ -258,8 +258,7 @@ class Configuration:
         template.setVar("http_proxy", self.combine_proxy("http"))
         template.setVar("https_proxy", self.combine_proxy("https"))
         template.setVar("ftp_proxy", self.combine_proxy("ftp"))
-        template.setVar("GIT_PROXY_HOST", self.combine_host_only("git"))
-        template.setVar("GIT_PROXY_PORT", self.combine_port_only("git"))
+        template.setVar("all_proxy", self.combine_proxy("socks"))
         template.setVar("CVS_PROXY_HOST", self.combine_host_only("cvs"))
         template.setVar("CVS_PROXY_PORT", self.combine_port_only("cvs"))
 
@@ -274,8 +273,8 @@ class Configuration:
             (self.lconf_version, self.extra_setting, self.toolchain_build, self.image_fstypes, self.selected_image)
         s += "DEPENDS: '%s', IMAGE_INSTALL: '%s', enable_proxy: '%s', use_same_proxy: '%s', http_proxy: '%s', " % \
             (self.selected_recipes, self.user_selected_packages, self.enable_proxy, self.same_proxy, self.combine_proxy("http"))
-        s += "https_proxy: '%s', ftp_proxy: '%s', GIT_PROXY_HOST: '%s', GIT_PROXY_PORT: '%s', CVS_PROXY_HOST: '%s', CVS_PROXY_PORT: '%s'" % \
-            (self.combine_proxy("https"), self.combine_proxy("ftp"),self.combine_host_only("git"), self.combine_port_only("git"),
+        s += "https_proxy: '%s', ftp_proxy: '%s', all_proxy: '%s', CVS_PROXY_HOST: '%s', CVS_PROXY_PORT: '%s'" % \
+            (self.combine_proxy("https"), self.combine_proxy("ftp"), self.combine_proxy("socks"),
              self.combine_host_only("cvs"), self.combine_port_only("cvs"))
         return s
 
@@ -755,13 +754,13 @@ class Builder(gtk.Window):
             self.handler.set_http_proxy(self.configuration.combine_proxy("http"))
             self.handler.set_https_proxy(self.configuration.combine_proxy("https"))
             self.handler.set_ftp_proxy(self.configuration.combine_proxy("ftp"))
-            self.handler.set_git_proxy(self.configuration.combine_host_only("git"), self.configuration.combine_port_only("git"))
+            self.handler.set_socks_proxy(self.configuration.combine_proxy("socks"))
             self.handler.set_cvs_proxy(self.configuration.combine_host_only("cvs"), self.configuration.combine_port_only("cvs"))
         elif self.configuration.enable_proxy == False:
             self.handler.set_http_proxy("")
             self.handler.set_https_proxy("")
             self.handler.set_ftp_proxy("")
-            self.handler.set_git_proxy("", "")
+            self.handler.set_socks_proxy("")
             self.handler.set_cvs_proxy("", "")
 
     def set_user_config_extra(self):
diff --git a/bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py b/bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py
index 8ac82ed..c1bd45f 100644
--- a/bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py
+++ b/bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py
@@ -161,13 +161,13 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
         self.ftp_proxy_port.set_sensitive(self.configuration.enable_proxy and (not self.configuration.same_proxy))
         self.ftp_proxy_details.set_sensitive(self.configuration.enable_proxy and (not self.configuration.same_proxy))
 
-        self.git_proxy.set_text(self.configuration.combine_host_only("git"))
-        self.git_proxy.set_editable(self.configuration.enable_proxy and (not self.configuration.same_proxy))
-        self.git_proxy.set_sensitive(self.configuration.enable_proxy and (not self.configuration.same_proxy))
-        self.git_proxy_port.set_text(self.configuration.combine_port_only("git"))
-        self.git_proxy_port.set_editable(self.configuration.enable_proxy and (not self.configuration.same_proxy))
-        self.git_proxy_port.set_sensitive(self.configuration.enable_proxy and (not self.configuration.same_proxy))
-        self.git_proxy_details.set_sensitive(self.configuration.enable_proxy and (not self.configuration.same_proxy))
+        self.socks_proxy.set_text(self.configuration.combine_host_only("socks"))
+        self.socks_proxy.set_editable(self.configuration.enable_proxy and (not self.configuration.same_proxy))
+        self.socks_proxy.set_sensitive(self.configuration.enable_proxy and (not self.configuration.same_proxy))
+        self.socks_proxy_port.set_text(self.configuration.combine_port_only("socks"))
+        self.socks_proxy_port.set_editable(self.configuration.enable_proxy and (not self.configuration.same_proxy))
+        self.socks_proxy_port.set_sensitive(self.configuration.enable_proxy and (not self.configuration.same_proxy))
+        self.socks_proxy_details.set_sensitive(self.configuration.enable_proxy and (not self.configuration.same_proxy))
 
         self.cvs_proxy.set_text(self.configuration.combine_host_only("cvs"))
         self.cvs_proxy.set_editable(self.configuration.enable_proxy and (not self.configuration.same_proxy))
@@ -201,12 +201,12 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
         if self.configuration.same_proxy:
             self.configuration.split_proxy("https", self.http_proxy.get_text() + ":" + self.http_proxy_port.get_text())
             self.configuration.split_proxy("ftp", self.http_proxy.get_text() + ":" + self.http_proxy_port.get_text())
-            self.configuration.split_proxy("git", self.http_proxy.get_text() + ":" + self.http_proxy_port.get_text())
+            self.configuration.split_proxy("socks", self.http_proxy.get_text() + ":" + self.http_proxy_port.get_text())
             self.configuration.split_proxy("cvs", self.http_proxy.get_text() + ":" + self.http_proxy_port.get_text())
         else:
             self.configuration.split_proxy("https", self.https_proxy.get_text() + ":" + self.https_proxy_port.get_text())
             self.configuration.split_proxy("ftp", self.ftp_proxy.get_text() + ":" + self.ftp_proxy_port.get_text())
-            self.configuration.split_proxy("git", self.git_proxy.get_text() + ":" + self.git_proxy_port.get_text())
+            self.configuration.split_proxy("socks", self.socks_proxy.get_text() + ":" + self.socks_proxy_port.get_text())
             self.configuration.split_proxy("cvs", self.cvs_proxy.get_text() + ":" + self.cvs_proxy_port.get_text())       
 
     def response_cb(self, dialog, response_id):
@@ -555,13 +555,13 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
             self.handler.set_http_proxy(self.configuration.combine_proxy("http"))
             self.handler.set_https_proxy(self.configuration.combine_proxy("https"))
             self.handler.set_ftp_proxy(self.configuration.combine_proxy("ftp"))
-            self.handler.set_git_proxy(self.configuration.combine_host_only("git"), self.configuration.combine_port_only("git"))
+            self.handler.set_socks_proxy(self.configuration.combine_proxy("socks"))
             self.handler.set_cvs_proxy(self.configuration.combine_host_only("cvs"), self.configuration.combine_port_only("cvs"))
         elif self.configuration.enable_proxy == False:
             self.handler.set_http_proxy("")
             self.handler.set_https_proxy("")
             self.handler.set_ftp_proxy("")
-            self.handler.set_git_proxy("", "")
+            self.handler.set_socks_proxy("")
             self.handler.set_cvs_proxy("", "")
         self.proxy_test_ran = True
         self.proxy_test_running = True
@@ -673,11 +673,11 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
         self.same_proxy_addresses.append(self.ftp_proxy)
         self.same_proxy_ports.append(self.ftp_proxy_port)
 
-        self.git_proxy, self.git_proxy_port, self.git_proxy_details = self.gen_proxy_entry_widget(
-            "git", self, True, 3)
-        proxy_test_focus += [self.git_proxy, self.git_proxy_port]
-        self.same_proxy_addresses.append(self.git_proxy)
-        self.same_proxy_ports.append(self.git_proxy_port)
+        self.socks_proxy, self.socks_proxy_port, self.socks_proxy_details = self.gen_proxy_entry_widget(
+            "socks", self, True, 3)
+        proxy_test_focus += [self.socks_proxy, self.socks_proxy_port]
+        self.same_proxy_addresses.append(self.socks_proxy)
+        self.same_proxy_ports.append(self.socks_proxy_port)
 
         self.cvs_proxy, self.cvs_proxy_port, self.cvs_proxy_details = self.gen_proxy_entry_widget(
             "cvs", self, True, 4)
diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index c33fb74..d060bc0 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -367,9 +367,8 @@ class HobHandler(gobject.GObject):
     def set_ftp_proxy(self, ftp_proxy):
         self.runCommand(["setVariable", "ftp_proxy", ftp_proxy])
 
-    def set_git_proxy(self, host, port):
-        self.runCommand(["setVariable", "GIT_PROXY_HOST", host])
-        self.runCommand(["setVariable", "GIT_PROXY_PORT", port])
+    def set_socks_proxy(self, socks_proxy):
+        self.runCommand(["setVariable", "all_proxy", socks_proxy])
 
     def set_cvs_proxy(self, host, port):
         self.runCommand(["setVariable", "CVS_PROXY_HOST", host])
@@ -565,9 +564,7 @@ class HobHandler(gobject.GObject):
 
         params["default_task"] = self.runCommand(["getVariable", "BB_DEFAULT_TASK"]) or "build"
 
-        params["git_proxy_host"] = self.runCommand(["getVariable", "GIT_PROXY_HOST"]) or ""
-        params["git_proxy_port"] = self.runCommand(["getVariable", "GIT_PROXY_PORT"]) or ""
-
+        params["socks_proxy"] = self.runCommand(["getVariable", "all_proxy"]) or ""
         params["http_proxy"] = self.runCommand(["getVariable", "http_proxy"]) or ""
         params["ftp_proxy"] = self.runCommand(["getVariable", "ftp_proxy"]) or ""
         params["https_proxy"] = self.runCommand(["getVariable", "https_proxy"]) or ""
-- 
1.7.10.4



