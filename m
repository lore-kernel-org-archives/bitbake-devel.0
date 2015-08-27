Return-Path: <elliot.smith@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 6887976C0B
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Aug 2015 13:35:20 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga102.jf.intel.com with ESMTP; 27 Aug 2015 06:35:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,422,1437462000"; d="scan'208";a="792057150"
Received: from mozel-mobl1.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.17.173])
	by fmsmga002.fm.intel.com with ESMTP; 27 Aug 2015 06:35:19 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 27 Aug 2015 14:34:51 +0100
Message-Id: <1440682491-10255-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Cc: Sujith Haridasan <Sujith_Haridasan@mentor.com>
Subject: [PATCH] toaster: Remove Log column from All builds page
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
X-List-Received-Date: Thu, 27 Aug 2015 13:35:21 -0000

From: Sujith Haridasan <Sujith_Haridasan@mentor.com>

This patch removes Log from All build table.

[YOCTO #8010]

Signed-off-by: Sujith H <sujith.h@gmail.com>
Signed-off-by: Sujith Haridasan <Sujith_Haridasan@mentor.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/toastergui/views.py | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/bitbake/lib/toaster/toastergui/views.py b/bitbake/lib/toaster/toastergui/views.py
index 98d21f4..c8ff693 100755
--- a/bitbake/lib/toaster/toastergui/views.py
+++ b/bitbake/lib/toaster/toastergui/views.py
@@ -2072,14 +2072,6 @@ if True:
                                              ]
                                 }
                     },
-                    {'name': 'Log',
-                     'dclass': "span4",
-                     'qhelp': "Path to the build main log file",
-                     'clclass': 'log', 'hidden': 1,
-                     'orderfield': _get_toggle_order(request, "cooker_log_path"),
-                     'ordericon':_get_toggle_order_icon(request, "cooker_log_path"),
-                     'orderkey' : 'cooker_log_path',
-                    },
                     {'name': 'Time', 'clclass': 'time', 'hidden' : 1,
                      'qhelp': "How long it took the build to finish",
                      'orderfield': _get_toggle_order(request, "timespent", True),
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


