Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jessica.zhang@intel.com>) id 1TBaLO-0008EF-KT
	for bitbake-devel@lists.openembedded.org;
	Wed, 12 Sep 2012 01:58:14 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 11 Sep 2012 16:44:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,407,1344236400"; d="scan'208";a="201849395"
Received: from jzhang-desktop.jf.intel.com (HELO localhost) ([10.7.201.69])
	by orsmga002.jf.intel.com with ESMTP; 11 Sep 2012 16:44:38 -0700
From: Jessica Zhang <jessica.zhang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 11 Sep 2012 16:55:52 -0700
Message-Id: <86f332ba650054d8bfa6fc538ebc8c159f84efd1.1347407412.git.jessica.zhang@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1347407412.git.jessica.zhang@intel.com>
References: <cover.1347407412.git.jessica.zhang@intel.com>
In-Reply-To: <cover.1347407412.git.jessica.zhang@intel.com>
References: <cover.1347407412.git.jessica.zhang@intel.com>
Subject: [PATCH 1/1] Fixed hob proxy tab tooltip text per review suggestions [YOCTO #2499]
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
X-List-Received-Date: Tue, 11 Sep 2012 23:58:14 -0000

Signed-off-by: Jessica Zhang <jessica.zhang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hig.py |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index 3695fa0..b879e6d 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -567,8 +567,8 @@ class AdvancedSettingDialog (CrumbsDialog):
 
         sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
-        label = self.gen_label_widget("<span weight=\"bold\">Set the proxies that will be used during fetching source code</span>")
-        tooltip = "Set the proxies that will be used during fetching source code or set none for direct the Internet connection"
+        label = self.gen_label_widget("<span weight=\"bold\">Set the proxies used when fetching source code</span>")
+        tooltip = "Set the proxies used when fetching source code.  A blank field uses a direct internet connection."
         info = HobInfoButton(tooltip, self)
         hbox = gtk.HBox(False, 12)
         hbox.pack_start(label, expand=True, fill=True)
@@ -576,17 +576,17 @@ class AdvancedSettingDialog (CrumbsDialog):
         sub_vbox.pack_start(hbox, expand=False, fill=False)
 
         self.direct_checkbox = gtk.RadioButton(None, "Direct internet connection")
-        self.direct_checkbox.set_tooltip_text("Check this box to connect the Internet directly without any proxy")
+        self.direct_checkbox.set_tooltip_text("Check this box to use a direct internet connection with no proxy")
         self.direct_checkbox.set_active(not self.configuration.enable_proxy)
         sub_vbox.pack_start(self.direct_checkbox, expand=False, fill=False)
 
         self.proxy_checkbox = gtk.RadioButton(self.direct_checkbox, "Manual proxy configuration")
-        self.proxy_checkbox.set_tooltip_text("Check this box to setup the proxy you specified")
+        self.proxy_checkbox.set_tooltip_text("Check this box to manually set up a specific proxy")
         self.proxy_checkbox.set_active(self.configuration.enable_proxy)
         sub_vbox.pack_start(self.proxy_checkbox, expand=False, fill=False)
 
         self.same_checkbox = gtk.CheckButton("Use the same proxy for all protocols")
-        self.same_checkbox.set_tooltip_text("Use the same proxy as the first proxy i.e. http proxy for all protocols")
+        self.same_checkbox.set_tooltip_text("Check this box to use the HTTP proxy for all five proxies")
         self.same_checkbox.set_active(self.configuration.same_proxy)
         hbox = gtk.HBox(False, 12)
         hbox.pack_start(self.same_checkbox, expand=False, fill=False, padding=24)
-- 
1.7.9.5



