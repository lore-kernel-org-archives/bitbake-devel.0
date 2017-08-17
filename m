Return-Path: <jussi.kukkonen@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 295427841B
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Aug 2017 10:15:11 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	17 Aug 2017 03:14:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.41,387,1498546800"; d="scan'208";a="1183805474"
Received: from linux.intel.com ([10.54.29.200])
	by fmsmga001.fm.intel.com with ESMTP; 17 Aug 2017 03:14:58 -0700
Received: from theory.fi.intel.com (theory.fi.intel.com [10.237.72.53])
	by linux.intel.com (Postfix) with ESMTP id C24E458061A;
	Thu, 17 Aug 2017 03:14:57 -0700 (PDT)
From: Jussi Kukkonen <jussi.kukkonen@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 17 Aug 2017 13:14:54 +0300
Message-Id: <1502964894-40713-1-git-send-email-jussi.kukkonen@intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH] bitbake: ui: Sort 'Dependent tasks' in taskexp
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
X-List-Received-Date: Thu, 17 Aug 2017 10:15:14 -0000

The underlying model is already sorted for use in the other view,
add a sorting model for the 'Dependent Tasks' view.

Signed-off-by: Jussi Kukkonen <jussi.kukkonen@intel.com>
---
 bitbake/lib/bb/ui/taskexp.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/taskexp.py b/bitbake/lib/bb/ui/taskexp.py
index 0d0f9f5..0e8e9d4 100644
--- a/bitbake/lib/bb/ui/taskexp.py
+++ b/bitbake/lib/bb/ui/taskexp.py
@@ -63,7 +63,9 @@ class PackageReverseDepView(Gtk.TreeView):
         self.current = None
         self.filter_model = model.filter_new()
         self.filter_model.set_visible_func(self._filter)
-        self.set_model(self.filter_model)
+        self.sort_model = self.filter_model.sort_new_with_model()
+        self.sort_model.set_sort_column_id(COL_DEP_PARENT, Gtk.SortType.ASCENDING)
+        self.set_model(self.sort_model)
         self.append_column(Gtk.TreeViewColumn(label, Gtk.CellRendererText(), text=COL_DEP_PARENT))
 
     def _filter(self, model, iter, data):
-- 
2.1.4


