Return-Path: <markus.lehtonen@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 9457873BB8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Sep 2015 13:03:10 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga101.jf.intel.com with ESMTP; 24 Sep 2015 06:02:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,580,1437462000"; d="scan'208";a="812027212"
Received: from marquiz.fi.intel.com ([10.237.72.155])
	by fmsmga002.fm.intel.com with ESMTP; 24 Sep 2015 06:02:25 -0700
From: Markus Lehtonen <markus.lehtonen@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 24 Sep 2015 16:02:23 +0300
Message-Id: <1443099743-17231-1-git-send-email-markus.lehtonen@linux.intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH] utils: only add layer once in edit_bblayers_conf()
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
X-List-Received-Date: Thu, 24 Sep 2015 13:03:12 -0000

Prevent edit_bblayers_conf() from adding layer(s) multiple times. This
happened when BBLAYERS variable was "listed" multiple times in
bblayer.conf - i.e. the configuration was split into multiple separate
assignments.

[YOCTO #8316]

Signed-off-by: Markus Lehtonen <markus.lehtonen@linux.intel.com>
---
 lib/bb/utils.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 91faa49..9b550ef 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1249,6 +1249,7 @@ def edit_bblayers_conf(bblayers_conf, add, remove):
                     bblayers.append(addlayer)
                 else:
                     notadded.append(addlayer)
+            del addlayers[:]
 
         if updated:
             return (bblayers, None, 2, False)
-- 
2.1.4


