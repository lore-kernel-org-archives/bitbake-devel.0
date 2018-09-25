Return-Path: <mark.hatle@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id D894B7950E
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Sep 2018 15:07:41 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id w8PF7MlB022724
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Sep 2018 08:07:32 -0700
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.408.0;
	Tue, 25 Sep 2018 08:07:11 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 25 Sep 2018 11:07:06 -0400
Message-ID: <20180925150708.2983-2-mark.hatle@windriver.com>
X-Mailer: git-send-email 2.16.0.rc2
In-Reply-To: <20180925150708.2983-1-mark.hatle@windriver.com>
References: <20180925150708.2983-1-mark.hatle@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/3] lib/bb/tests/parse.py: Test case was changing chdir
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
X-List-Received-Date: Tue, 25 Sep 2018 15:07:42 -0000
Content-Type: text/plain

The test case was changing the current directory, but was never restoring it
to the original location.  This causes occasional failures in later test cases.

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 lib/bb/tests/parse.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bb/tests/parse.py b/lib/bb/tests/parse.py
index 8f16ba4..1bc4740 100644
--- a/lib/bb/tests/parse.py
+++ b/lib/bb/tests/parse.py
@@ -44,9 +44,13 @@ C = "3"
 """
 
     def setUp(self):
+        self.origdir = os.getcwd()
         self.d = bb.data.init()
         bb.parse.siggen = bb.siggen.init(self.d)
 
+    def tearDown(self):
+        os.chdir(self.origdir)
+
     def parsehelper(self, content, suffix = ".bb"):
 
         f = tempfile.NamedTemporaryFile(suffix = suffix)
-- 
1.8.3.1


