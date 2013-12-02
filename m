Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 09EAE6DEDF
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  2 Dec 2013 18:58:56 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 02 Dec 2013 10:58:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,812,1378882800"; d="scan'208";a="443340784"
Received: from pmcgurk-mobl.ger.corp.intel.com (HELO
	helios.ger.corp.intel.com) ([10.252.121.184])
	by fmsmga002.fm.intel.com with ESMTP; 02 Dec 2013 10:58:53 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  2 Dec 2013 18:58:45 +0000
Message-Id: <0cf16a793511878360110577fabd391ef8a2effe.1386010573.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1386010573.git.paul.eggleton@linux.intel.com>
References: <cover.1386010573.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1386010573.git.paul.eggleton@linux.intel.com>
References: <cover.1386010573.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/3] lib/bb/ui: handle PKGSIZE change to bytes
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
X-List-Received-Date: Mon, 02 Dec 2013 18:58:56 -0000

PKGSIZE is now in bytes in pkgdata, so we need to treat it as such in
the UI code for Hob / Toaster.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/ui/buildinfohelper.py     | 2 +-
 lib/bb/ui/crumbs/hoblistmodel.py | 7 +++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 2c9d77a..61149fa 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -188,7 +188,7 @@ class ORMWrapper(object):
                                        revision = package_info['PKGR'],
                                        summary = package_info['SUMMARY'],
                                        description = package_info['DESCRIPTION'],
-                                       size = int(package_info['PKGSIZE']) * 1024,
+                                       size = int(package_info['PKGSIZE']),
                                        section = package_info['SECTION'],
                                        license = package_info['LICENSE'],
                                        )
diff --git a/lib/bb/ui/crumbs/hoblistmodel.py b/lib/bb/ui/crumbs/hoblistmodel.py
index 79e909c..cffe6e1 100644
--- a/lib/bb/ui/crumbs/hoblistmodel.py
+++ b/lib/bb/ui/crumbs/hoblistmodel.py
@@ -251,7 +251,7 @@ class PackageListModel(gtk.ListStore):
             pkgv = getpkgvalue(pkginfo, 'PKGV', pkg)
             pkgr = getpkgvalue(pkginfo, 'PKGR', pkg)
             # PKGSIZE is artificial, will always be overridden with the package name if present
-            pkgsize = pkginfo.get('PKGSIZE_%s' % pkg, "0")
+            pkgsize = int(pkginfo.get('PKGSIZE_%s' % pkg, "0"))
             # PKG_%s is the renamed version
             pkg_rename = pkginfo.get('PKG_%s' % pkg, "")
             # The rest may be overridden or not
@@ -268,11 +268,10 @@ class PackageListModel(gtk.ListStore):
 
             allow_empty = getpkgvalue(pkginfo, 'ALLOW_EMPTY', pkg, "")
 
-            if pkgsize == "0" and not allow_empty:
+            if pkgsize == 0 and not allow_empty:
                 continue
 
-            # pkgsize is in KB
-            size = HobPage._size_to_string(HobPage._string_to_size(pkgsize + ' KB'))
+            size = HobPage._size_to_string(pkgsize)
             self.set(self.append(), self.COL_NAME, pkg, self.COL_VER, pkgv,
                      self.COL_REV, pkgr, self.COL_RNM, pkg_rename,
                      self.COL_SEC, section, self.COL_SUM, summary,
-- 
1.8.1.2


