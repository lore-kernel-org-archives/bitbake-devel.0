Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id E87E76013D
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Mar 2015 10:35:14 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga103.fm.intel.com with ESMTP; 16 Mar 2015 03:29:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.11,407,1422950400"; d="scan'208";a="692711641"
Received: from sgconnee-mobl2.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.8.217])
	by fmsmga002.fm.intel.com with ESMTP; 16 Mar 2015 03:35:15 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 16 Mar 2015 10:35:10 +0000
Message-Id: <1426502110-2528-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH] bitbake-layers: use stdout instead of stderr for logging
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
X-List-Received-Date: Mon, 16 Mar 2015 10:35:17 -0000

We use logger.plain() to produce actual output which needs to go to
stdout. We could use more advanced filtering (and probably should in
future) but for the moment let's just fix the regression.

Fixes [YOCTO #7458].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bin/bitbake-layers | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index 89662c7..c1c65aa 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -52,7 +52,7 @@ def logger_create(name, output=sys.stderr):
     logger.setLevel(logging.INFO)
     return logger
 
-logger = logger_create('bitbake-layers')
+logger = logger_create('bitbake-layers', sys.stdout)
 
 
 class Commands():
-- 
1.9.3


