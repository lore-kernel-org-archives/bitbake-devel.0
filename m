Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 55E2F732D1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Feb 2015 18:13:42 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 10 Feb 2015 10:13:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.09,551,1418112000"; d="scan'208";a="664422236"
Received: from mjbowe-mobl.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.18.120])
	by fmsmga001.fm.intel.com with ESMTP; 10 Feb 2015 10:13:36 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 10 Feb 2015 18:13:24 +0000
Message-Id: <1064fcab04a6f43a1b5c6e83f36910f2c8df3ac1.1423591698.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1423591698.git.paul.eggleton@linux.intel.com>
References: <cover.1423591698.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1423591698.git.paul.eggleton@linux.intel.com>
References: <cover.1423591698.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/3] tests: add tests for OE pre-release version formatting
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
X-List-Received-Date: Tue, 10 Feb 2015 18:13:44 -0000

This scheme is used for versioning recipes that are pre-release (alpha,
beta, etc.) within OpenEmbedded, so add some tests to ensure the
appropriate comparison results still hold true.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/tests/utils.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bb/tests/utils.py b/lib/bb/tests/utils.py
index 7c50b1d..cf145f0 100644
--- a/lib/bb/tests/utils.py
+++ b/lib/bb/tests/utils.py
@@ -35,6 +35,10 @@ class VerCmpString(unittest.TestCase):
         self.assertTrue(result < 0)
         result = bb.utils.vercmp_string('1.1', '1_p2')
         self.assertTrue(result < 0)
+        result = bb.utils.vercmp_string('1.0', '1.0+1.1-beta1')
+        self.assertTrue(result < 0)
+        result = bb.utils.vercmp_string('1.1', '1.0+1.1-beta1')
+        self.assertTrue(result > 0)
 
     def test_explode_dep_versions(self):
         correctresult = {"foo" : ["= 1.10"]}
-- 
1.9.3


