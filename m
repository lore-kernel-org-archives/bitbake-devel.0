Return-Path: <ddalex@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id D82756D684
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Nov 2013 10:53:50 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 14 Nov 2013 02:53:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,535,1378882800"; d="scan'208";a="408673755"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by orsmga001.jf.intel.com with ESMTP; 14 Nov 2013 02:53:03 -0800
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 1FABC5604EC; Thu, 14 Nov 2013 10:53:03 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 14 Nov 2013 10:53:00 +0000
Message-Id: <1384426381-7869-5-git-send-email-alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1384426381-7869-1-git-send-email-alexandru.damian@intel.com>
References: <1384426381-7869-1-git-send-email-alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 4/5] toaster: fix path to buildstats file
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
X-List-Received-Date: Thu, 14 Nov 2013 10:53:50 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

The buildstats file path changes based on the
optional PE variable that may be defined for a
recipe.

The toasterui simply ignored the PE value, and
as such it didn't correctly reach buildstats files
for some of the tasks.

This patch fixes the issue.

    [YOCTO #5073]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index c1ffa26..92d6bbe 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -392,7 +392,11 @@ class BuildInfoHelper(object):
             target = t.target
             machine = self.internal_state['build'].machine
             buildname = self.internal_state['build'].build_name
-            package = task_object.recipe.name + "-" + task_object.recipe.version.strip(":")
+            pe, pv = task_object.recipe.version.split(":",1)
+            if len(pe) > 0:
+                package = task_object.recipe.name + "-" + pe + "_" + pv
+            else:
+                package = task_object.recipe.name + "-" + pv
 
             build_stats_path.append(build_stats_format.format(tmpdir=self.tmp_dir, target=target,
                                                      machine=machine, buildname=buildname,
-- 
1.8.3.2


