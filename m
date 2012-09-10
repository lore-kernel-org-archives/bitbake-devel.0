Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1TB7iA-0003DJ-Tv
	for bitbake-devel@lists.openembedded.org;
	Mon, 10 Sep 2012 19:23:51 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 10 Sep 2012 10:11:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,398,1344236400"; d="scan'208";a="143410544"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.193])
	by AZSMGA002.ch.intel.com with ESMTP; 10 Sep 2012 10:11:19 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 10 Sep 2012 18:11:17 +0100
Message-Id: <1347297077-29053-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: ensure error message text is properly escaped
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
X-List-Received-Date: Mon, 10 Sep 2012 17:23:51 -0000

Our poor implementation of markup escaping was causing invalid
markup, leading to the error dialog being blank. Use the glib markup
escaping function provided by PyGTK+ to do this properly and avoid the
blank error dialogs.

Partial fix for [YOCTO #2983].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py |   14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 833577f..a203a06 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -21,6 +21,7 @@
 # with this program; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
+import glib
 import gtk
 import copy
 import os
@@ -378,15 +379,6 @@ class Builder(gtk.Window):
         END_NOOP              : None,
     }
 
-    @classmethod
-    def interpret_markup(cls, msg):
-        msg = msg.replace('&', '&amp;')
-        msg = msg.replace('<', '&lt;')
-        msg = msg.replace('>', '&gt;')
-        msg = msg.replace('"', '&quot;')
-        msg = msg.replace("'", "&acute;")
-        return msg
-
     def __init__(self, hobHandler, recipe_model, package_model):
         super(Builder, self).__init__()
 
@@ -783,7 +775,7 @@ class Builder(gtk.Window):
 
     def show_error_dialog(self, msg):
         lbl = "<b>Error</b>\n"
-        lbl = lbl + "%s\n\n" % Builder.interpret_markup(msg)
+        lbl = lbl + "%s\n\n" % glib.markup_escape_text(msg)
         dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_ERROR)
         button = dialog.add_button("Close", gtk.RESPONSE_OK)
         HobButton.style_button(button)
@@ -971,7 +963,7 @@ class Builder(gtk.Window):
         self.build_failed()
 
     def handler_no_provider_cb(self, running_build, msg):
-        dialog = CrumbsMessageDialog(self, Builder.interpret_markup(msg), gtk.STOCK_DIALOG_INFO)
+        dialog = CrumbsMessageDialog(self, glib.markup_escape_text(msg), gtk.STOCK_DIALOG_INFO)
         button = dialog.add_button("Close", gtk.RESPONSE_OK)
         HobButton.style_button(button)
         dialog.run()
-- 
1.7.9.5



