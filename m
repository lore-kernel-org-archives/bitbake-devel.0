Return-Path: <cristiana.voicu@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 72D5E6B1D2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 22 Jul 2013 10:51:52 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 22 Jul 2013 03:49:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,718,1367996400"; d="scan'208";a="349542101"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.72])
	by orsmga001.jf.intel.com with ESMTP; 22 Jul 2013 03:51:52 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 22 Jul 2013 13:54:11 +0300
Message-Id: <1374490451-8079-2-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1374490451-8079-1-git-send-email-cristiana.voicu@intel.com>
References: <1374490451-8079-1-git-send-email-cristiana.voicu@intel.com>
Subject: [PATCH 2/2] hob: sstatemirror is standard also for file://.* regex
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
X-List-Received-Date: Mon, 22 Jul 2013 10:51:52 -0000

Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 .../lib/bb/ui/crumbs/hig/simplesettingsdialog.py   |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py b/bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py
index e43080a..de924b1 100644
--- a/bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py
+++ b/bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py
@@ -322,8 +322,8 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
                 for sstatemirror in sstatemirrors:
                     sstatemirror_fields = [x for x in sstatemirror.split(' ') if x.strip()]
                     if len(sstatemirror_fields) == 2:
-                        if sstatemirror_fields[0] == "file://(.*)":
-                            sm_list = ["Standard", sstatemirror_fields[1], "file://(.*)"]
+                        if sstatemirror_fields[0] == "file://(.*)" or sstatemirror_fields[0] == "file://.*":
+                            sm_list = ["Standard", sstatemirror_fields[1], sstatemirror_fields[0]]
                         else:
                             sm_list = ["Custom", sstatemirror_fields[1], sstatemirror_fields[0]]
                         self.sstatemirrors_list.append(sm_list)
-- 
1.7.9.5


