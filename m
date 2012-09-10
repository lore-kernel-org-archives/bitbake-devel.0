Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1TB5IW-0007cL-TP
	for bitbake-devel@lists.openembedded.org;
	Mon, 10 Sep 2012 16:49:13 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 10 Sep 2012 07:36:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,398,1344236400"; d="scan'208";a="200800795"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.193])
	by orsmga002.jf.intel.com with ESMTP; 10 Sep 2012 07:36:32 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 10 Sep 2012 15:36:29 +0100
Message-Id: <1347287789-25496-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: use correct semantics for dealing with pkgdata
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
X-List-Received-Date: Mon, 10 Sep 2012 14:49:13 -0000

Some of these values may or may not be overridden on a per-package
basis, so handle them accordingly.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/ui/crumbs/hoblistmodel.py |   35 +++++++++++++++++-------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
index 10b7c55..66b0efa 100644
--- a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
+++ b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
@@ -145,6 +145,12 @@ class PackageListModel(gtk.TreeStore):
         self.pkg_path = {}
         self.rprov_pkg = {}
 
+        def getpkgvalue(pkgdict, key, pkgname, defaultval = None):
+            value = pkgdict.get('%s_%s' % (key, pkgname), None)
+            if not value:
+                value = pkgdict.get(key, defaultval)
+            return value
+
         for pkginfo in pkginfolist:
             pn = pkginfo['PN']
             pv = pkginfo['PV']
@@ -157,25 +163,24 @@ class PackageListModel(gtk.TreeStore):
                                  self.COL_INC, False)
                 self.pn_path[pn] = self.get_path(pniter)
 
+            # PKG is always present
             pkg = pkginfo['PKG']
-            pkgv = pkginfo['PKGV']
-            pkgr = pkginfo['PKGR']
-            pkgsize = pkginfo['PKGSIZE_%s' % pkg] if 'PKGSIZE_%s' % pkg in pkginfo.keys() else "0"
-            pkg_rename = pkginfo['PKG_%s' % pkg] if 'PKG_%s' % pkg in pkginfo.keys() else ""
-            section = pkginfo['SECTION_%s' % pkg] if 'SECTION_%s' % pkg in pkginfo.keys() else ""
-            summary = pkginfo['SUMMARY_%s' % pkg] if 'SUMMARY_%s' % pkg in pkginfo.keys() else ""
-            rdep = pkginfo['RDEPENDS_%s' % pkg] if 'RDEPENDS_%s' % pkg in pkginfo.keys() else ""
-            rrec = pkginfo['RRECOMMENDS_%s' % pkg] if 'RRECOMMENDS_%s' % pkg in pkginfo.keys() else ""
-            rprov = pkginfo['RPROVIDES_%s' % pkg] if 'RPROVIDES_%s' % pkg in pkginfo.keys() else ""
+            pkgv = getpkgvalue(pkginfo, 'PKGV', pkg)
+            pkgr = getpkgvalue(pkginfo, 'PKGR', pkg)
+            # PKGSIZE is artificial, will always be overridden with the package name if present
+            pkgsize = pkginfo.get('PKGSIZE_%s' % pkg, "0")
+            # PKG_%s is the renamed version
+            pkg_rename = pkginfo.get('PKG_%s' % pkg, "")
+            # The rest may be overridden or not
+            section = getpkgvalue(pkginfo, 'SECTION', pkg, "")
+            summary = getpkgvalue(pkginfo, 'SUMMARY', pkg, "")
+            rdep = getpkgvalue(pkginfo, 'RDEPENDS', pkg, "")
+            rrec = getpkgvalue(pkginfo, 'RRECOMMENDS', pkg, "")
+            rprov = getpkgvalue(pkginfo, 'RPROVIDES', pkg, "")
             for i in rprov.split():
                 self.rprov_pkg[i] = pkg
 
-            if 'ALLOW_EMPTY_%s' % pkg in pkginfo.keys():
-                allow_empty = pkginfo['ALLOW_EMPTY_%s' % pkg]
-            elif 'ALLOW_EMPTY' in pkginfo.keys():
-                allow_empty = pkginfo['ALLOW_EMPTY']
-            else:
-                allow_empty = ""
+            allow_empty = getpkgvalue(pkginfo, 'ALLOW_EMPTY', pkg, "")
 
             if pkgsize == "0" and not allow_empty:
                 continue
-- 
1.7.9.5



