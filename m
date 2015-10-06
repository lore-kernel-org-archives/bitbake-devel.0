Return-Path: <elliot.smith@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id C75B176660
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  6 Oct 2015 13:21:07 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga101.jf.intel.com with ESMTP; 06 Oct 2015 06:21:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,644,1437462000"; d="scan'208";a="575125685"
Received: from blynch-mobl1.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.3.31])
	by FMSMGA003.fm.intel.com with ESMTP; 06 Oct 2015 06:21:03 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  6 Oct 2015 14:20:44 +0100
Message-Id: <1444137644-31748-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH] toaster: Comment out broken sorting and filters
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
X-List-Received-Date: Tue, 06 Oct 2015 13:21:09 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

YOCTO #8131 records that the sorting by 'errors', 'warnings'
and 'time', and the filtering by 'errors' and 'warnings',
are broken in the 'all builds' and 'project builds' pages.

To avoid exposing broken functionality to users, comment
out the sorting and filtering in those columns until we
we have a fix for YOCTO #8131.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/toastergui/views.py | 49 +++++++++++++++++----------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/bitbake/lib/toaster/toastergui/views.py b/bitbake/lib/toaster/toastergui/views.py
index 3168cfa..e07f0e2 100755
--- a/bitbake/lib/toaster/toastergui/views.py
+++ b/bitbake/lib/toaster/toastergui/views.py
@@ -2103,35 +2103,38 @@ if True:
                     },
                     {'name': 'Errors', 'clclass': 'errors_no',
                      'qhelp': "How many errors were encountered during the build (if any)",
-                     'orderfield': _get_toggle_order(request, "errors_no", True),
-                     'ordericon':_get_toggle_order_icon(request, "errors_no"),
-                     'orderkey' : 'errors_no',
-                     'filter' : {'class' : 'errors_no',
-                                 'label': 'Show:',
-                                 'options' : [
-                                             ('Builds with errors', 'errors_no__gte:1', queryset_with_search.filter(errors_no__gte=1).count()),
-                                             ('Builds without errors', 'errors_no:0', queryset_with_search.filter(errors_no=0).count()),
-                                             ]
-                                }
+                     # Comment out sorting and filter until YOCTO #8131 is fixed
+                     #'orderfield': _get_toggle_order(request, "errors_no", True),
+                     #'ordericon':_get_toggle_order_icon(request, "errors_no"),
+                     #'orderkey' : 'errors_no',
+                     #'filter' : {'class' : 'errors_no',
+                     #            'label': 'Show:',
+                     #            'options' : [
+                     #                        ('Builds with errors', 'errors_no__gte:1', queryset_with_search.filter(errors_no__gte=1).count()),
+                     #                        ('Builds without errors', 'errors_no:0', queryset_with_search.filter(errors_no=0).count()),
+                     #                        ]
+                     #           }
                     },
                     {'name': 'Warnings', 'clclass': 'warnings_no',
                      'qhelp': "How many warnings were encountered during the build (if any)",
-                     'orderfield': _get_toggle_order(request, "warnings_no", True),
-                     'ordericon':_get_toggle_order_icon(request, "warnings_no"),
-                     'orderkey' : 'warnings_no',
-                     'filter' : {'class' : 'warnings_no',
-                                 'label': 'Show:',
-                                 'options' : [
-                                             ('Builds with warnings','warnings_no__gte:1', queryset_with_search.filter(warnings_no__gte=1).count()),
-                                             ('Builds without warnings','warnings_no:0', queryset_with_search.filter(warnings_no=0).count()),
-                                             ]
-                                }
+                     # Comment out sorting and filter until YOCTO #8131 is fixed
+                     #'orderfield': _get_toggle_order(request, "warnings_no", True),
+                     #'ordericon':_get_toggle_order_icon(request, "warnings_no"),
+                     #'orderkey' : 'warnings_no',
+                     #'filter' : {'class' : 'warnings_no',
+                     #            'label': 'Show:',
+                     #            'options' : [
+                     #                        ('Builds with warnings','warnings_no__gte:1', queryset_with_search.filter(warnings_no__gte=1).count()),
+                     #                        ('Builds without warnings','warnings_no:0', queryset_with_search.filter(warnings_no=0).count()),
+                     #                        ]
+                     #           }
                     },
                     {'name': 'Time', 'clclass': 'time', 'hidden' : 1,
                      'qhelp': "How long it took the build to finish",
-                     'orderfield': _get_toggle_order(request, "timespent", True),
-                     'ordericon':_get_toggle_order_icon(request, "timespent"),
-                     'orderkey' : 'timespent',
+                     # Comment out sorting until YOCTO #8131 is fixed
+                     #'orderfield': _get_toggle_order(request, "timespent", True),
+                     #'ordericon':_get_toggle_order_icon(request, "timespent"),
+                     #'orderkey' : 'timespent',
                     },
                     {'name': 'Image files', 'clclass': 'output',
                      'qhelp': "The root file system types produced by the build. You can find them in your <code>/build/tmp/deploy/images/</code> directory",
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


