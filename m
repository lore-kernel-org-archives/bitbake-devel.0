Return-Path: <mark.hatle@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id E37756003C
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Sep 2018 15:16:04 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w8PFG63c022171
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Sep 2018 08:16:06 -0700 (PDT)
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.408.0;
	Tue, 25 Sep 2018 08:15:53 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 25 Sep 2018 11:15:52 -0400
Message-ID: <20180925151552.3607-1-mark.hatle@windriver.com>
X-Mailer: git-send-email 2.16.0.rc2
MIME-Version: 1.0
Subject: [PATCH 2/3 v2] lib/layerindexlib/tests/cooker.py: Fix topdir to use an absolute (real) path
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
X-List-Received-Date: Tue, 25 Sep 2018 15:16:05 -0000
Content-Type: text/plain

The test case needs to access test case files.  Different versions of python
may return absolute or relative locations in __file__.  Use the same approach
as other test cases in determining the location of the test files.

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 lib/layerindexlib/tests/cooker.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/layerindexlib/tests/cooker.py b/lib/layerindexlib/tests/cooker.py
index 9ce6e8c..fdbf091 100644
--- a/lib/layerindexlib/tests/cooker.py
+++ b/lib/layerindexlib/tests/cooker.py
@@ -32,7 +32,7 @@ class LayerIndexCookerTest(LayersTest):
         # configure the test data.  But we can emulate the basics of the layer.conf
         # files, so that is what we will do.
 
-        new_topdir = os.path.join(os.path.dirname(__file__), "testdata")
+        new_topdir = os.path.join(os.path.dirname(os.path.realpath(__file__)), "testdata")
         new_bbpath = os.path.join(new_topdir, "build")
 
         self.d.setVar('TOPDIR', new_topdir)
-- 
1.8.3.1


