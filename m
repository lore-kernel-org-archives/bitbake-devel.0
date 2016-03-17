Return-Path: <elliot.smith@intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id F255F6AC4B
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Mar 2016 11:49:24 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga104.fm.intel.com with ESMTP; 17 Mar 2016 04:49:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,349,1455004800"; d="scan'208";a="926152055"
Received: from wmalikow-mobl.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.20.136])
	by fmsmga001.fm.intel.com with ESMTP; 17 Mar 2016 04:49:21 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 17 Mar 2016 11:49:16 +0000
Message-Id: <1458215356-17938-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH] toasterui: Remove the excessive exception logging
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
X-List-Received-Date: Thu, 17 Mar 2016 11:49:25 -0000

From: Michael Wood <michael.g.wood@intel.com>

Remove the very verbose log dump from toasterui. This generates several
megabytes of not that useful debug information and actually hinders
finding the original exception.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/bb/ui/toasterui.py | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/bitbake/lib/bb/ui/toasterui.py b/bitbake/lib/bb/ui/toasterui.py
index ee40110..29aed2e 100644
--- a/bitbake/lib/bb/ui/toasterui.py
+++ b/bitbake/lib/bb/ui/toasterui.py
@@ -447,13 +447,6 @@ def main(server, eventHandler, params):
             exception_data = traceback.format_exc()
             logger.error("%s\n%s" , e, exception_data)
 
-            _, _, tb = sys.exc_info()
-            if tb is not None:
-                curr = tb
-                while curr is not None:
-                    logger.error("Error data dump %s\n%s\n" , traceback.format_tb(curr,1), pformat(curr.tb_frame.f_locals))
-                    curr = curr.tb_next
-
             # save them to database, if possible; if it fails, we already logged to console.
             try:
                 buildinfohelper.store_log_exception("%s\n%s" % (str(e), exception_data))
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


