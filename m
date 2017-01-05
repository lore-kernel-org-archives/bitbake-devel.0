Return-Path: <anibal.limon@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 958A971998
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  5 Jan 2017 23:42:12 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga101.jf.intel.com with ESMTP; 05 Jan 2017 15:41:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,323,1477983600"; d="scan'208";a="805636911"
Received: from alimonb-mobl1.zpn.intel.com ([10.219.5.143])
	by FMSMGA003.fm.intel.com with ESMTP; 05 Jan 2017 15:41:59 -0800
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  5 Jan 2017 17:44:46 -0600
Message-Id: <1483659886-28280-1-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Cc: benjamin.esquivel@intel.com, jose.perez.carranza@intel.com
Subject: [PATCH] bb/cooker: BBCooker stops notifier at shutdown
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
X-List-Received-Date: Thu, 05 Jan 2017 23:42:13 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

At end of  BBCooker needs to release fd's associated with pyinotify
watchers to  avoid: Too many open files (EMFILE) error in different
scenarios like several instances of tinfoil.

[YOCTO #10873]

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 lib/bb/cooker.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 30131fb..182d044 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1731,6 +1731,8 @@ class BBCooker:
 
         if self.parser:
             self.parser.shutdown(clean=not force, force=force)
+        self.notifier.stop()
+        self.confignotifier.stop()
 
     def finishcommand(self):
         self.state = state.initial
-- 
2.1.4


