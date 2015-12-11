Return-Path: <elliot.smith@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id E05CF65CBF
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 Dec 2015 10:02:19 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga103.fm.intel.com with ESMTP; 11 Dec 2015 02:02:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,412,1444719600"; d="scan'208";a="616347110"
Received: from cclanc2-mobl2.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.16.100])
	by FMSMGA003.fm.intel.com with ESMTP; 11 Dec 2015 02:02:19 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 11 Dec 2015 10:01:59 +0000
Message-Id: <1449828119-23489-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Cc: Mihail Stanciu <stanciux.mihail@intel.com>
Subject: [PATCH] toaster: tests Remove symlinks from toasteruitest folder
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
X-List-Received-Date: Fri, 11 Dec 2015 10:02:21 -0000

From: Mihail Stanciu <stanciux.mihail@intel.com>

Remove symlinks in the UI tests folder as they are causing
problems for bitbake upstream.

[YOCTO #8787]

Signed-off-by: Mihail Stanciu <stanciux.mihail@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/contrib/tts/toasteruitest/toaster.sqlite   | 1 -
 bitbake/lib/toaster/contrib/tts/toasteruitest/toasterconf.json | 1 -
 2 files changed, 2 deletions(-)
 delete mode 120000 bitbake/lib/toaster/contrib/tts/toasteruitest/toaster.sqlite
 delete mode 120000 bitbake/lib/toaster/contrib/tts/toasteruitest/toasterconf.json

diff --git a/bitbake/lib/toaster/contrib/tts/toasteruitest/toaster.sqlite b/bitbake/lib/toaster/contrib/tts/toasteruitest/toaster.sqlite
deleted file mode 120000
index 656b8e8..0000000
--- a/bitbake/lib/toaster/contrib/tts/toasteruitest/toaster.sqlite
+++ /dev/null
@@ -1 +0,0 @@
-../../../../../../toaster.sqlite
\ No newline at end of file
diff --git a/bitbake/lib/toaster/contrib/tts/toasteruitest/toasterconf.json b/bitbake/lib/toaster/contrib/tts/toasteruitest/toasterconf.json
deleted file mode 120000
index 9b33bcc..0000000
--- a/bitbake/lib/toaster/contrib/tts/toasteruitest/toasterconf.json
+++ /dev/null
@@ -1 +0,0 @@
-../../../../../../meta-yocto/conf/toasterconf.json
\ No newline at end of file
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


