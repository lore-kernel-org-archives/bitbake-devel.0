Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1Safst-0001xc-UF
	for bitbake-devel@lists.openembedded.org;
	Sat, 02 Jun 2012 06:24:16 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 01 Jun 2012 21:13:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="150661609"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by azsmga001.ch.intel.com with ESMTP; 01 Jun 2012 21:13:52 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat,  2 Jun 2012 12:54:38 +0800
Message-Id: <a83d5af816b9390f71165f5a2ccd51fe69799d04.1338612620.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <5b4c1d6a5c75f186454ed87614e4e9926f5b2d3a.1338612620.git.shane.wang@intel.com>
References: <5b4c1d6a5c75f186454ed87614e4e9926f5b2d3a.1338612620.git.shane.wang@intel.com>
In-Reply-To: <cover.1338612620.git.shane.wang@intel.com>
References: <cover.1338612620.git.shane.wang@intel.com>
Subject: [PATCH 3/3] Hob: Interpret some special characters for label markup
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
X-List-Received-Date: Sat, 02 Jun 2012 04:24:16 -0000

Interpret some special characters for label markup, such as &, <, >, etc.
Otherwise, the message dialog can't show them, and worsely, it makes the
whole message blank.

[Yocto #2492]

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index eaf18ab..ed6c6cf 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -374,6 +374,15 @@ class Builder(gtk.Window):
         END_NOOP              : None,
     }
 
+    @classmethod
+    def interpret_markup(cls, msg):
+        msg = msg.replace('&', '&amp;')
+        msg = msg.replace('<', '&lt;')
+        msg = msg.replace('>', '&gt;')
+        msg = msg.replace('"', '&quot;')
+        msg = msg.replace("'", "&acute;")
+        return msg
+
     def __init__(self, hobHandler, recipe_model, package_model):
         super(Builder, self).__init__()
 
@@ -729,7 +738,7 @@ class Builder(gtk.Window):
 
     def show_error_dialog(self, msg):
         lbl = "<b>Error</b>\n"
-        lbl = lbl + "%s\n\n" % msg
+        lbl = lbl + "%s\n\n" % Builder.interpret_markup(msg)
         dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_ERROR)
         button = dialog.add_button("Close", gtk.RESPONSE_OK)
         HobButton.style_button(button)
@@ -909,7 +918,7 @@ class Builder(gtk.Window):
         self.build_failed()
 
     def handler_no_provider_cb(self, running_build, msg):
-        dialog = CrumbsMessageDialog(self, msg, gtk.STOCK_DIALOG_INFO)
+        dialog = CrumbsMessageDialog(self, Builder.interpret_markup(msg), gtk.STOCK_DIALOG_INFO)
         button = dialog.add_button("Close", gtk.RESPONSE_OK)
         HobButton.style_button(button)
         dialog.run()
-- 
1.7.6



