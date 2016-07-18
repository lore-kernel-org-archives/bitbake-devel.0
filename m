Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 3CCAD6FFD4
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Jul 2016 16:32:20 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga103.jf.intel.com with ESMTP; 18 Jul 2016 09:32:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,384,1464678000"; d="scan'208";a="997626032"
Received: from linux.intel.com ([10.54.29.200])
	by orsmga001.jf.intel.com with ESMTP; 18 Jul 2016 09:32:23 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.68])
	by linux.intel.com (Postfix) with ESMTP id 57F956A4080
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Jul 2016 09:32:12 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 18 Jul 2016 19:07:17 +0300
Message-Id: <59b38d7ae1e5393f2379ca76a960cebf73dac4e8.1468857803.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1468857803.git.ed.bartosh@linux.intel.com>
References: <cover.1468857803.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1468857803.git.ed.bartosh@linux.intel.com>
References: <cover.1468857803.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 2/3] bitbake: utils: add BBSERVER to the list of preserved variables
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
X-List-Received-Date: Mon, 18 Jul 2016 16:32:21 -0000

All environment variables that are not in the list returned by
preserved_envvars_exported are cleaned by bb.utils.clean_environment.

Added BBSERVER to the list as we need to access it in bb/main.py
after the call of bb.utils.clean_environment.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/bb/utils.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index 0a1bf68..00d6474 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -574,6 +574,7 @@ def preserved_envvars_exported():
         'TERM',
         'USER',
         'LC_ALL',
+        'BBSERVER',
     ]
 
 def preserved_envvars():
-- 
2.1.4


