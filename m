Return-Path: <ddalex@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by mail.openembedded.org (Postfix) with ESMTP id 9F0FC6CB30
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:14 +0000 (UTC)
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 24 Sep 2013 09:53:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="298814645"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by AZSMGA002.ch.intel.com with ESMTP; 24 Sep 2013 09:53:14 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 7298D562D54; Tue, 24 Sep 2013 17:53:05 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:53:02 +0100
Message-Id: <320c4f7d07e29eff15c1865bb2261ac5c460e246.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 93/94] bitbake: dsi: fix typos
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:16 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Some copy-pasted code didn't get pasted right,
so we fix some of the typos which crepped out.

This fixes some bugs which aren't logged
in Bugzilla, which caused data transfer to fail
silently.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/ui/buildinfohelper.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index a3a50a3..8ead476 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -178,27 +178,27 @@ class ORMWrapper(object):
                 if not p.startswith("("):
                     Build_Package_Dependency.objects.get_or_create( package = bp_object,
                         depends_on = p, dep_type = Build_Package_Dependency.TYPE_RDEPENDS)
-        if package_info['RDEPENDS'] is not None:
+        if package_info['RPROVIDES'] is not None:
             for p in package_info['RPROVIDES'].split(" "):
                 if not p.startswith("("):
                     Build_Package_Dependency.objects.get_or_create( package = bp_object,
                         depends_on = p, dep_type = Build_Package_Dependency.TYPE_RPROVIDES)
-        if package_info['RDEPENDS'] is not None:
+        if package_info['RRECOMMENDS'] is not None:
             for p in package_info['RRECOMMENDS'].split(" "):
                 if not p.startswith("("):
                     Build_Package_Dependency.objects.get_or_create( package = bp_object,
                         depends_on = p, dep_type = Build_Package_Dependency.TYPE_RRECOMMENDS)
-        if package_info['RDEPENDS'] is not None:
+        if package_info['RSUGGESTS'] is not None:
             for p in package_info['RSUGGESTS'].split(" "):
                 if not p.startswith("("):
                     Build_Package_Dependency.objects.get_or_create( package = bp_object,
                         depends_on = p, dep_type = Build_Package_Dependency.TYPE_RSUGGESTS)
-        if package_info['RDEPENDS'] is not None:
+        if package_info['RREPLACES'] is not None:
             for p in package_info['RREPLACES'].split(" "):
                 if not p.startswith("("):
                     Build_Package_Dependency.objects.get_or_create( package = bp_object,
                         depends_on = p, dep_type = Build_Package_Dependency.TYPE_RREPLACES)
-        if package_info['RDEPENDS'] is not None:
+        if package_info['RCONFLICTS'] is not None:
             for p in package_info['RCONFLICTS'].split(" "):
                 if not p.startswith("("):
                     Build_Package_Dependency.objects.get_or_create( package = bp_object,
@@ -643,7 +643,7 @@ class BuildInfoHelper(object):
         if not 'package_files' in self.internal_state.keys():
             self.internal_state['package_files'] = {}
 
-        data = event._data
+        data = event.data
         self.internal_state['package_files'][data['PKG']] = data['FILES']
 
     def store_log_information(self, level, text):
-- 
1.8.1.2


