Return-Path: <brendan.le.foll@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id CF909771A2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Feb 2016 16:39:01 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga101.fm.intel.com with ESMTP; 29 Feb 2016 08:39:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,521,1449561600"; d="scan'208";a="661246996"
Received: from jupiter.iwi.intel.com ([172.28.33.51])
	by FMSMGA003.fm.intel.com with ESMTP; 29 Feb 2016 08:39:01 -0800
From: brendan.le.foll@intel.com
To: bitbake-devel@lists.openembedded.org
Date: Mon, 29 Feb 2016 16:39:49 +0000
Message-Id: <1456763989-31016-1-git-send-email-brendan.le.foll@intel.com>
X-Mailer: git-send-email 2.7.1
Subject: [PATCH] fetch2/npm: Add missing ParameterError import
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
X-List-Received-Date: Mon, 29 Feb 2016 16:39:04 -0000

From: Brendan Le Foll <brendan.le.foll@intel.com>

Signed-off-by: Brendan Le Foll <brendan.le.foll@intel.com>
---
 lib/bb/fetch2/npm.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index 7d5e891..0998277 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -32,6 +32,7 @@ from   bb.fetch2 import ChecksumError
 from   bb.fetch2 import runfetchcmd
 from   bb.fetch2 import logger
 from   bb.fetch2 import UnpackError
+from   bb.fetch2 import ParameterError
 from   distutils import spawn
 
 def subprocess_setup():
-- 
2.7.1


