Return-Path: <irina.patru@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id DA9E56E89D
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Jan 2014 15:56:30 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 21 Jan 2014 07:55:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.95,696,1384329600"; d="scan'208";a="442320762"
Received: from irina-vostro-460.rb.intel.com ([10.237.105.140])
	by orsmga001.jf.intel.com with ESMTP; 21 Jan 2014 07:55:51 -0800
From: Irina Patru <irina.patru@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 21 Jan 2014 17:59:37 +0200
Message-Id: <1390319978-31756-3-git-send-email-irina.patru@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1390319978-31756-1-git-send-email-irina.patru@intel.com>
References: <y>
 <1390319978-31756-1-git-send-email-irina.patru@intel.com>
Subject: [PATCH 3/4] hob: unsetting busy cursor after hitting Stop button
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
X-List-Received-Date: Tue, 21 Jan 2014 15:56:31 -0000

The busy cursor would never change after pressing Stop button.
It should be set after the possible return inside machine_combo_changed_cb()
method.

Signed-off-by: Irina Patru <irina.patru@intel.com>
---
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
index 79709d0..6372592 100644
--- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -304,14 +304,15 @@ class ImageConfigurationPage (HobPage):
         self.builder.window.set_cursor(None)
 
     def machine_combo_changed_cb(self, machine_combo):
-        self.builder.window.set_cursor(gtk.gdk.Cursor(gtk.gdk.WATCH))
-        self.builder.wait(0.1) #wait for combo and cursor to update
         self.stopping = False
         self.builder.parsing_warnings = []
         combo_item = machine_combo.get_active_text()
         if not combo_item or combo_item == self.__dummy_machine__:
             return
 
+        self.builder.window.set_cursor(gtk.gdk.Cursor(gtk.gdk.WATCH))
+        self.builder.wait(0.1) #wait for combo and cursor to update
+
         # remove __dummy_machine__ item from the store list after first user selection
         # because it is no longer valid
         combo_store = machine_combo.get_model()
-- 
1.7.9.5


