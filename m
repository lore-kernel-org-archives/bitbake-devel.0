Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei.adrianx.dinu@intel.com>) id 1UKnqV-0005Ib-HB
	for bitbake-devel@lists.openembedded.org;
	Wed, 27 Mar 2013 11:44:47 +0100
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 27 Mar 2013 03:27:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,917,1355126400"; d="scan'208";a="219373140"
Received: from adinu-vostro-460.rb.intel.com ([10.237.105.146])
	by AZSMGA002.ch.intel.com with ESMTP; 27 Mar 2013 03:27:14 -0700
From: Andrei Dinu <andrei.adrianx.dinu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 27 Mar 2013 12:27:53 +0200
Message-Id: <1364380074-16382-6-git-send-email-andrei.adrianx.dinu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1364380074-16382-1-git-send-email-andrei.adrianx.dinu@intel.com>
References: <1364380074-16382-1-git-send-email-andrei.adrianx.dinu@intel.com>
Subject: [PATCH 5/6] hoblistmodel.py : passing the package information to hob
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
X-List-Received-Date: Wed, 27 Mar 2013 10:44:53 -0000

Added a new column to the model and also populating
it with the information brought in from the
packageinfo.bbclass.

Signed-off-by: Andrei Dinu <andrei.adrianx.dinu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hoblistmodel.py |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
index 0f37a06..778eb85 100644
--- a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
+++ b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
@@ -35,7 +35,7 @@ class PackageListModel(gtk.ListStore):
     provide filtered views of the data.
     """
 
-    (COL_NAME, COL_VER, COL_REV, COL_RNM, COL_SEC, COL_SUM, COL_RDEP, COL_RPROV, COL_SIZE, COL_RCP, COL_BINB, COL_INC, COL_FADE_INC, COL_FONT) = range(14)
+    (COL_NAME, COL_VER, COL_REV, COL_RNM, COL_SEC, COL_SUM, COL_RDEP, COL_RPROV, COL_SIZE, COL_RCP, COL_BINB, COL_INC, COL_FADE_INC, COL_FONT, COL_FLIST) = range(15)
 
     __gsignals__ = {
         "package-selection-changed" : (gobject.SIGNAL_RUN_LAST,
@@ -61,6 +61,7 @@ class PackageListModel(gtk.ListStore):
                                 gobject.TYPE_STRING,
                                 gobject.TYPE_BOOLEAN,
                                 gobject.TYPE_BOOLEAN,
+                                gobject.TYPE_STRING,
                                 gobject.TYPE_STRING)
 
     """
@@ -166,6 +167,8 @@ class PackageListModel(gtk.ListStore):
             rdep = getpkgvalue(pkginfo, 'RDEPENDS', pkg, "")
             rrec = getpkgvalue(pkginfo, 'RRECOMMENDS', pkg, "")
             rprov = getpkgvalue(pkginfo, 'RPROVIDES', pkg, "")
+            files_list = getpkgvalue(pkginfo, 'FILES_INFO', pkg, "")
+            
             for i in rprov.split():
                 self.rprov_pkg[i] = pkg
 
@@ -185,7 +188,7 @@ class PackageListModel(gtk.ListStore):
                      self.COL_RDEP, rdep + ' ' + rrec,
                      self.COL_RPROV, rprov, self.COL_SIZE, size,
                      self.COL_RCP, recipe, self.COL_BINB, "",
-                     self.COL_INC, False, self.COL_FONT, '10')
+                     self.COL_INC, False, self.COL_FONT, '10', self.COL_FLIST, files_list)
 
         self.pn_path = {}
         it = self.get_iter_first()
-- 
1.7.9.5



