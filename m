Return-Path: <olof.johansson@axis.com>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id 4DA9260043
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Jan 2016 15:04:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id 57FD42E141
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Jan 2016 16:04:20 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id Q2uIPd3cIrRc for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Jan 2016 16:04:12 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bes.se.axis.com (Postfix) with ESMTP id 88A1C2E125
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Jan 2016 16:04:12 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 63CD2F7E
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Jan 2016 16:04:12 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id 55EF9117
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Jan 2016 16:04:12 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by seth.se.axis.com (Postfix) with ESMTP id 50C463E12F
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Jan 2016 16:04:12 +0100 (CET)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.3.342.0; Tue, 19 Jan 2016
	16:04:11 +0100
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id F1DAC9C724; 
	Tue, 19 Jan 2016 16:04:11 +0100 (CET)
From: Olof Johansson <olof.johansson@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 19 Jan 2016 16:04:11 +0100
Message-ID: <1453215851-19422-1-git-send-email-olof.johansson@axis.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Subject: [PATCH] tests/codeparser.py: Add filename/lineno flags to test variable
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
X-List-Received-Date: Tue, 19 Jan 2016 15:04:20 -0000
Content-Type: text/plain

A recent change in bitbake added filename/lineno information to the
parameters of bb.data.build_dependencies(). The codeparser tests
required a little adaption to the changes, adding the flags to the FOO
variable used in the tests.

The error seen when running the tests is a TypeError exception raised
in bb.codeparser:

  TypeError: int() argument must be a string or a number, not 'NoneType'

Signed-off-by: Olof Johansson <olof.johansson@axis.com>
---
 bitbake/lib/bb/tests/codeparser.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/tests/codeparser.py b/bitbake/lib/bb/tests/codeparser.py
index 4454bc5..bb820e4 100644
--- a/bitbake/lib/bb/tests/codeparser.py
+++ b/bitbake/lib/bb/tests/codeparser.py
@@ -293,7 +293,12 @@ bb.data.getVar(a(), d, False)
     def test_python(self):
         self.d.setVar("FOO", self.pydata)
         self.setEmptyVars(["inexpand", "a", "test2", "test"])
-        self.d.setVarFlags("FOO", {"func": True, "python": True})
+        self.d.setVarFlags("FOO", {
+            "func": True,
+            "python": True,
+            "lineno": 1,
+            "filename": "example.bb",
+        })
 
         deps, values = bb.data.build_dependencies("FOO", set(self.d.keys()), set(), set(), self.d)
 
-- 
2.1.4


