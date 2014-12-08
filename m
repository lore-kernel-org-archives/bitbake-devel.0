Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id A580A72477
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Dec 2014 10:50:33 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 08 Dec 2014 02:50:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.07,537,1413270000"; d="scan'208";a="644158894"
Received: from apwitke-mobl2.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.30.33])
	by fmsmga002.fm.intel.com with ESMTP; 08 Dec 2014 02:50:31 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  8 Dec 2014 10:50:23 +0000
Message-Id: <97fc210386c1f5b497c53e7749bf73a343538e0b.1418034514.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1418034514.git.paul.eggleton@linux.intel.com>
References: <cover.1418034514.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1418034514.git.paul.eggleton@linux.intel.com>
References: <cover.1418034514.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/4] fetch2: add means of disabling SRC_URI checksums
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
X-List-Received-Date: Mon, 08 Dec 2014 10:50:33 -0000

If we're fetching outside of the context of a recipe, it's handy to be
able to disable checksum functionality so you don't get a meaningless
warning about the signatures being missing.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/fetch2/__init__.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 3696e24..5b26524 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -535,7 +535,7 @@ def verify_checksum(ud, d):
 
     """
 
-    if not ud.method.supports_checksum(ud):
+    if ud.ignore_checksums or not ud.method.supports_checksum(ud):
         return
 
     md5data = bb.utils.md5_file(ud.localpath)
@@ -1041,6 +1041,7 @@ class FetchData(object):
             self.sha256_expected = None
         else:
             self.sha256_expected = d.getVarFlag("SRC_URI", self.sha256_name)
+        self.ignore_checksums = False
 
         self.names = self.parm.get("name",'default').split(',')
 
-- 
1.9.3


