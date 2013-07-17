Return-Path: <cristiana.voicu@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id C27116B27A
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 17 Jul 2013 10:33:50 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga102.jf.intel.com with ESMTP; 17 Jul 2013 03:31:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,683,1367996400"; d="scan'208";a="366550009"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.72])
	by fmsmga001.fm.intel.com with ESMTP; 17 Jul 2013 03:33:50 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 17 Jul 2013 13:35:44 +0300
Message-Id: <1374057344-19708-15-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1374057344-19708-1-git-send-email-cristiana.voicu@intel.com>
References: <1374057344-19708-1-git-send-email-cristiana.voicu@intel.com>
Subject: [PATCH 14/14] hob: set focus on entry name when the name is not correct
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 17 Jul 2013 10:33:50 -0000

[YOCTO #4193]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py |    1 +
 1 file changed, 1 insertion(+)

diff --git a/bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py b/bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py
index f8bf39f..e9e8dd5 100644
--- a/bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py
+++ b/bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py
@@ -147,4 +147,5 @@ class SaveImageDialog (CrumbsDialog):
         HobButton.style_button(button)
 
         res = dialog.run()
+        self.name_entry.grab_focus()
         dialog.destroy()
-- 
1.7.9.5


