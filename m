Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SIKbL-00076x-2X
	for bitbake-devel@lists.openembedded.org;
	Thu, 12 Apr 2012 16:02:19 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 12 Apr 2012 06:52:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="130088908"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by azsmga001.ch.intel.com with ESMTP; 12 Apr 2012 06:52:57 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 12 Apr 2012 22:22:44 +0800
Message-Id: <7c149ef6bdd51f91462d60c4aee756badefc032f.1334240256.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <66452ccd9200e82222920bfda51158a4c7e09fb2.1334240256.git.shane.wang@intel.com>
References: <66452ccd9200e82222920bfda51158a4c7e09fb2.1334240256.git.shane.wang@intel.com>
In-Reply-To: <cover.1334240256.git.shane.wang@intel.com>
References: <cover.1334240256.git.shane.wang@intel.com>
Subject: [PATCH 2/2] Hob: forbid users to exit Hob directly when Hob is busy
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
X-List-Received-Date: Thu, 12 Apr 2012 14:02:19 -0000

When Hob is busy with generating data, exiting Hob is not allowed.
That should be reasonable because at that time the mouse cursor is not a pointer.
If users want to exit, they can click "Stop" first and then do exit.

That is also a walkaround for [Yocto #2142]

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 10b9a77..e3f2d40 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -274,6 +274,9 @@ class Builder(gtk.Window):
         # Indicate whether user has customized the image
         self.customized = False
 
+        # Indicate whether the UI is working
+        self.sensitive = True
+
         # create visual elements
         self.create_visual_elements()
 
@@ -584,6 +587,7 @@ class Builder(gtk.Window):
             self.get_root_window().set_cursor(gtk.gdk.Cursor(gtk.gdk.LEFT_PTR))
         else:
             self.get_root_window().set_cursor(gtk.gdk.Cursor(gtk.gdk.WATCH))
+        self.sensitive = sensitive
 
 
     def handler_generating_data_cb(self, handler):
@@ -738,6 +742,8 @@ class Builder(gtk.Window):
         self.build_details_page.show_issues()
 
     def destroy_window_cb(self, widget, event):
+        if not self.sensitive:
+            return True
         lbl = "<b>Do you really want to exit the Hob image creator?</b>"
         dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
         button = dialog.add_button("Cancel", gtk.RESPONSE_NO)
-- 
1.7.6



