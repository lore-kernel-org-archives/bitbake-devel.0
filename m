Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id D00D47DA7C
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Apr 2019 08:13:14 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x3T8Cthg011270
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Apr 2019 01:13:06 -0700
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.439.0; Mon, 29 Apr 2019 01:12:45 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 29 Apr 2019 16:12:00 +0800
Message-ID: <a8c7d2e3f56778157c889e0a9686668f61f2c333.1556525357.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1556525357.git.liezhi.yang@windriver.com>
References: <cover.1556525357.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH V2 3/3] bitbake: tests/parse.py: Add testcase for addtask and deltask
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
X-List-Received-Date: Mon, 29 Apr 2019 08:13:14 -0000
Content-Type: text/plain

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/tests/parse.py | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/bitbake/lib/bb/tests/parse.py b/bitbake/lib/bb/tests/parse.py
index 1bc4740..4467d17 100644
--- a/bitbake/lib/bb/tests/parse.py
+++ b/bitbake/lib/bb/tests/parse.py
@@ -187,3 +187,21 @@ python () {
         self.assertEqual(d1.getVar("VAR_var"), "B")
         self.assertEqual(d2.getVar("VAR_var"), None)
 
+    addtask_deltask = """
+addtask do_patch after do_foo after do_unpack before do_configure before do_compile
+addtask do_fetch do_patch
+
+deltask do_fetch do_patch
+"""
+    def test_parse_addtask_deltask(self):
+        import sys
+        f = self.parsehelper(self.addtask_deltask)
+        d = bb.parse.handle(f.name, self.d)['']
+
+        stdout = sys.stdout.getvalue()
+        self.assertTrue("addtask contained multiple 'before' keywords" in stdout)
+        self.assertTrue("addtask contained multiple 'after' keywords" in stdout)
+        self.assertTrue('addtask ignored: " do_patch"' in stdout)
+        self.assertTrue('deltask ignored: " do_patch"' in stdout)
+        self.assertTrue('dependent task do_foo does not exist' in stdout)
+
-- 
2.7.4


