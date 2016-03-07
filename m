Return-Path: <elliot.smith@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 5A2596FFFB
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Mar 2016 12:01:53 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga103.fm.intel.com with ESMTP; 07 Mar 2016 04:01:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,551,1449561600"; d="scan'208";a="931287735"
Received: from vivienne-mobl3.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.18.236])
	by fmsmga002.fm.intel.com with ESMTP; 07 Mar 2016 04:01:53 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  7 Mar 2016 12:01:48 +0000
Message-Id: <1457352108-30665-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH] toaster: views api Package info return both kinds of RDEPENDS
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
X-List-Received-Date: Mon, 07 Mar 2016 12:01:54 -0000

From: Michael Wood <michael.g.wood@intel.com>

As we do with the popover snippet which shows dependencies inline in the
table also show dependencies which have both TYPE_TRDEPENDS and
TYPE_RDEPENDS.

Also remove obsolete comment

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/toastergui/views.py | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/toaster/toastergui/views.py b/bitbake/lib/toaster/toastergui/views.py
index f3b8d3c..bd11892 100755
--- a/bitbake/lib/toaster/toastergui/views.py
+++ b/bitbake/lib/toaster/toastergui/views.py
@@ -2577,9 +2577,6 @@ if True:
             else:
                 all_current_packages = recipe.get_all_packages()
 
-                # TODO currently we ignore packgegroups as we don't have a
-                # way to deal with them yet.
-
                 # Dependencies for package which aren't satisfied by the
                 # current packages in the custom image recipe
                 deps = package.package_dependencies_source.annotate(
@@ -2587,8 +2584,10 @@ if True:
                     pk=F('depends_on__pk'),
                     size=F('depends_on__size'),
                 ).values("name", "pk", "size").filter(
-                    ~Q(pk__in=all_current_packages) &
-                    Q(dep_type=Package_Dependency.TYPE_TRDEPENDS)
+                    # There are two depends types we don't know why
+                    (Q(dep_type=Package_Dependency.TYPE_TRDEPENDS) |
+                    Q(dep_type=Package_Dependency.TYPE_RDEPENDS)) &
+                    ~Q(pk__in=all_current_packages)
                 )
 
                 # Reverse dependencies which are needed by packages that are
-- 
1.9.3

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


