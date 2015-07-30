Return-Path: <olof.johansson@axis.com>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id 6E3D1763F2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 30 Jul 2015 15:03:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id CFC4F2E53D
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 30 Jul 2015 17:03:51 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id UsQFJ3hILVp9 for <bitbake-devel@lists.openembedded.org>;
	Thu, 30 Jul 2015 17:03:51 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bes.se.axis.com (Postfix) with ESMTP id D8A3B2E536
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 30 Jul 2015 17:03:50 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id BEF481254
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 30 Jul 2015 17:03:50 +0200 (CEST)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id ADE70100C
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 30 Jul 2015 17:03:50 +0200 (CEST)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by thoth.se.axis.com (Postfix) with ESMTP id ABD3234005
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 30 Jul 2015 17:03:50 +0200 (CEST)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.3.342.0; Thu, 30 Jul 2015
	17:03:50 +0200
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id 425209C68B; 
	Thu, 30 Jul 2015 17:03:50 +0200 (CEST)
From: Olof Johansson <olof.johansson@axis.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 30 Jul 2015 17:03:50 +0200
Message-ID: <1438266455-sup-7263@axis.com>
User-Agent: Sup/0.20.0
MIME-Version: 1.0
Subject: Variable key replaces original warnings
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
X-List-Received-Date: Thu, 30 Jul 2015 15:03:57 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hi all,

We've started to see issues on master like

   WARNING:
     Variable key          USERADD_PARAM_${PN}             (; --system --home / --no-create-home --comment 'Storage manager daemon' --gid storage storage)
     replaces original key USERADD_PARAM_recording-indexer (--system --home / --no-create-home --comment 'apache httpd' --gid www www).

(my alignment...)

The warning happens when doing

 WWWUSER_PACKAGE ?= "${PN}"
 USERADD_PARAM_${WWWUSER_PACKAGE} := "--system --home / --no-create-home --gid www www"

 USERADD_PARAM_${PN}_append = "; --system --home / --no-create-home --gid username username"

(in reality, the first two lines are inherited from a class, and the third in
the recipe itself.)

With bitbake -e I see what looks like the expected value, with both users being
created. If I change USERADD_PARAM_${WWWUSER_PACKAGE} (second line) to
USERADD_PARAM_${PN} no warning is printed, so this only seems to be a problem
in cases where multiple unique non-expanded vars expand to the same expanded
var.

I made a unit test that should demonstrate the problem (I think), and it fails
because of the warnings:

diff --git a/bitbake/lib/bb/tests/data.py b/bitbake/lib/bb/tests/data.py
index e9aab57..e7716cc 100644
--- a/bitbake/lib/bb/tests/data.py
+++ b/bitbake/lib/bb/tests/data.py
@@ -386,6 +386,15 @@ class TestKeyExpansion(unittest.TestCase):
             self.assertTrue(logContains("Variable key VAL_${FOO} (A) replaces original key VAL_foo (B)", logs))
         self.assertEqual(self.d.getVar("VAL_foo", True), "A")
 
+    def test_append(self):
+        self.d.setVar("TEST_${BAR}", "Bar")
+        self.d.setVar("TEST_${FOO}_append", "Foo")
+        with LogRecord() as logs:
+            bb.data.expandKeys(self.d)
+            self.assertFalse(logContains("Variable key TEST_${FOO} (Foo) replaces original key TEST_foo (Bar)", logs))
+        self.assertEqual(self.d.getVar("TEST_${FOO}", True), "BarFoo")


If you have any ideas on what this issue can be or how to fix it, please
let me know :)

-- 
olof johansson

