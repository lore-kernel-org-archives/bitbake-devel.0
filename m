Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei.adrianx.dinu@intel.com>) id 1UCuBg-0003eQ-17
	for bitbake-devel@lists.openembedded.org;
	Tue, 05 Mar 2013 16:53:59 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 05 Mar 2013 07:34:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,787,1355126400"; d="scan'208";a="271343683"
Received: from adinu-vostro-460 (HELO localhost.localdomain) ([10.237.105.45])
	by orsmga001.jf.intel.com with ESMTP; 05 Mar 2013 07:36:20 -0800
From: Andrei Dinu <andrei.adrianx.dinu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  5 Mar 2013 17:36:27 +0200
Message-Id: <1362497791-30020-8-git-send-email-andrei.adrianx.dinu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1362497791-30020-1-git-send-email-andrei.adrianx.dinu@intel.com>
References: <1362497791-30020-1-git-send-email-andrei.adrianx.dinu@intel.com>
Subject: [PATCH 07/11] added information columns needed for prop dialogs
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
X-List-Received-Date: Tue, 05 Mar 2013 15:54:00 -0000

in order to display all the information gathered in the
backend, new columns needed to be added in the hoblistmodel.

Signed-off-by: Andrei Dinu <andrei.adrianx.dinu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hoblistmodel.py |   23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
index 06c90d3..0f37a06 100644
--- a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
+++ b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
@@ -381,7 +381,8 @@ class RecipeListModel(gtk.ListStore):
     providing convenience functions to access gtk.TreeModel subclasses which
     provide filtered views of the data.
     """
-    (COL_NAME, COL_DESC, COL_LIC, COL_GROUP, COL_DEPS, COL_BINB, COL_TYPE, COL_INC, COL_IMG, COL_INSTALL, COL_PN, COL_FADE_INC) = range(12)
+    (COL_NAME, COL_DESC, COL_LIC, COL_GROUP, COL_DEPS, COL_BINB, COL_TYPE, COL_INC, COL_IMG, COL_INSTALL, COL_PN, COL_FADE_INC, COL_SUMMARY, COL_VERSION,
+     COL_REVISION, COL_HOMEPAGE, COL_BUGTRACKER) = range(17)
 
     __custom_image__ = "Create your own image"
 
@@ -406,7 +407,12 @@ class RecipeListModel(gtk.ListStore):
                                 gobject.TYPE_BOOLEAN,
                                 gobject.TYPE_STRING,
                                 gobject.TYPE_STRING,
-                                gobject.TYPE_BOOLEAN)
+                                gobject.TYPE_BOOLEAN,
+                                gobject.TYPE_STRING,
+                                gobject.TYPE_STRING,
+                                gobject.TYPE_STRING,
+                                gobject.TYPE_STRING,
+                                gobject.TYPE_STRING)
 
     """
     Find the model path for the item_name
@@ -505,7 +511,9 @@ class RecipeListModel(gtk.ListStore):
                  self.COL_LIC, "", self.COL_GROUP, "",
                  self.COL_DEPS, "", self.COL_BINB, "",
                  self.COL_TYPE, "image", self.COL_INC, False,
-                 self.COL_IMG, False, self.COL_INSTALL, "", self.COL_PN, self.__custom_image__)
+                 self.COL_IMG, False, self.COL_INSTALL, "", self.COL_PN, self.__custom_image__,
+                 self.COL_SUMMARY, "", self.COL_VERSION, "", self.COL_REVISION, "",
+                 self.COL_HOMEPAGE, "", self.COL_BUGTRACKER, "")
 
         for item in event_model["pn"]:
             name = item
@@ -513,6 +521,11 @@ class RecipeListModel(gtk.ListStore):
             lic = event_model["pn"][item]["license"]
             group = event_model["pn"][item]["section"]
             inherits = event_model["pn"][item]["inherits"]
+            summary = event_model["pn"][item]["summary"]
+            version = event_model["pn"][item]["version"]
+            revision = event_model["pn"][item]["revision"]
+            homepage = event_model["pn"][item]["homepage"]
+            bugtracker = event_model["pn"][item]["bugtracker"]
             install = []
 
             depends = event_model["depends"].get(item, []) + event_model["rdepends-pn"].get(item, [])
@@ -534,7 +547,9 @@ class RecipeListModel(gtk.ListStore):
                      self.COL_LIC, lic, self.COL_GROUP, group,
                      self.COL_DEPS, " ".join(depends), self.COL_BINB, "",
                      self.COL_TYPE, atype, self.COL_INC, False,
-                     self.COL_IMG, False, self.COL_INSTALL, " ".join(install), self.COL_PN, item)
+                     self.COL_IMG, False, self.COL_INSTALL, " ".join(install), self.COL_PN, item,
+                     self.COL_SUMMARY, summary, self.COL_VERSION, version, self.COL_REVISION, revision,
+                     self.COL_HOMEPAGE, homepage, self.COL_BUGTRACKER, bugtracker)
 
         self.pn_path = {}
         it = self.get_iter_first()
-- 
1.7.9.5



