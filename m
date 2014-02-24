Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 6C6406EA4A
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Feb 2014 18:50:27 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 24 Feb 2014 10:50:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,536,1389772800"; d="scan'208";a="487258424"
Received: from mmckenna-mobl2.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.123.143])
	by fmsmga002.fm.intel.com with ESMTP; 24 Feb 2014 10:50:18 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 24 Feb 2014 18:50:04 +0000
Message-Id: <e0a136f92f574f0405733ebca6219ce6b7b79207.1393267755.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <cover.1393267755.git.paul.eggleton@linux.intel.com>
References: <cover.1393267755.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1393267755.git.paul.eggleton@linux.intel.com>
References: <cover.1393267755.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 3/4] tests: add missing import
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
X-List-Received-Date: Mon, 24 Feb 2014 18:50:28 -0000

This was found when trying to run the data tests individually.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/tests/data.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/tests/data.py b/lib/bb/tests/data.py
index f281a35..6ec2736 100644
--- a/lib/bb/tests/data.py
+++ b/lib/bb/tests/data.py
@@ -23,6 +23,7 @@
 import unittest
 import bb
 import bb.data
+import bb.parse
 
 class DataExpansions(unittest.TestCase):
     def setUp(self):
-- 
1.8.5.3


