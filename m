Return-Path: <louis.rannou@syslinbit.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A4AC021A4
	for <webhook@archiver.kernel.org>; Thu, 13 Feb 2025 15:06:02 +0000 (UTC)
Received: from 2.mo560.mail-out.ovh.net (2.mo560.mail-out.ovh.net [188.165.53.149])
 by mx.groups.io with SMTP id smtpd.web11.12991.1739459154100446871
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Feb 2025 07:05:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@syslinbit.com header.s=ovhmo4479509-selector1 header.b=W+Qnc7UZ;
 spf=softfail (domain: syslinbit.com, ip: 188.165.53.149, mailfrom: louis.rannou@syslinbit.com)
Received: from director5.ghost.mail-out.ovh.net (unknown [10.108.2.10])
	by mo560.mail-out.ovh.net (Postfix) with ESMTP id 4Ytz5X0df4z1fY1
	for <bitbake-devel@lists.openembedded.org>; Thu, 13 Feb 2025 15:05:51 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-tfz7l (unknown [10.110.178.109])
	by director5.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 3FD511FE24;
	Thu, 13 Feb 2025 15:05:51 +0000 (UTC)
Received: from syslinbit.com ([37.59.142.104])
	by ghost-submission-5b5ff79f4f-tfz7l with ESMTPSA
	id MQGMAE4Krmfl8AAAvMEkeg:T3
	(envelope-from <louis.rannou@syslinbit.com>); Thu, 13 Feb 2025 15:05:51 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-104R0056af30a17-cc09-4f4e-a2d2-4ddf48233afd,
                    A3E930DA2C8C0F3093FF869A1907ED10BC64B092) smtp.auth=louis.rannou@syslinbit.com
X-OVh-ClientIp: 45.81.62.9
From: Louis Rannou <louis.rannou@syslinbit.com>
Date: Thu, 13 Feb 2025 16:05:43 +0100
Subject: [PATCH v2 2/2] bitbake: tests/data: add tests for variable flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-varflags-v2-2-884794e84e55@syslinbit.com>
References: <20250213-varflags-v2-0-884794e84e55@syslinbit.com>
In-Reply-To: <20250213-varflags-v2-0-884794e84e55@syslinbit.com>
To: bitbake-devel@lists.openembedded.org
Cc: Louis Rannou <louis.rannou@syslinbit.com>, pascal.eberhard@se.com, 
 yoann.congal@smile.fr, Louis Rannou <louis.rannou@non.se.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739459150; l=3905;
 i=louis.rannou@syslinbit.com; s=20230614; h=from:subject:message-id;
 bh=Dhur+lXPI7ACOOYVSi+jG/b75ddfsceJ9P/7+FD1OQk=;
 b=AAANTIhl2n+MOgkdII90kNS/jQ6PtlccywMhh5R1eoQkPOY3WMqdh7lZshLBSBdTjEBo5UNoe
 VCyVOuGxx/SCeQDqmgT7pbTnnE7At00qlvnXhh1BaVkKeDT/TvM15XD
X-Developer-Key: i=louis.rannou@syslinbit.com; a=ed25519;
 pk=QLSK64UNeqThVe2CiH917a68zTpexYuA7iXw6WQ0bbI=
X-Ovh-Tracer-Id: 742812464117767557
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegjedtlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefnohhuihhsucftrghnnhhouhcuoehlohhuihhsrdhrrghnnhhouhesshihshhlihhnsghithdrtghomheqnecuggftrfgrthhtvghrnhepvdetudetueduieeileejvefhjeeujeejkefgveehfedvjeffueffgeffteelteelnecuffhomhgrihhnpehtvghsthhsrdgurghtrgenucfkphepuddvjedrtddrtddruddpgeehrdekuddriedvrdelpdefjedrheelrddugedvrddutdegnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehlohhuihhsrdhrrghnnhhouhesshihshhlihhnsghithdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopegsihhtsggrkhgvqdguvghvvghlsehlihhsthhsrdhophgvnhgvmhgsvgguuggvugdrohhrghdpoffvtefjohhsthepmhhoheeitdgmpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=Q2QIEX9Eu5OXZowmCWHZD/GLWYvvsbQBQrCzTeNAons=;
 c=relaxed/relaxed; d=syslinbit.com; h=From; s=ovhmo4479509-selector1;
 t=1739459152; v=1;
 b=W+Qnc7UZN3vzpZxLbLKs4CzBjZvGqsvYb2ASXAH8iAPBt8dnqDx8qYMXJ47DUIruskTR28pq
 RppqWVRpyY9yilL568FgFpIt7g2M07wWpI0byFtfdniR7AOI2lV3vQmacgWiWkAlxpAKpzCj7ES
 NTDjaFiReURTvIyvYxqnSke1tMUGXHWjieracijqswaIlumhFcptLD2mRhtHKzpaGZ1c/zRHPFa
 cHQ4R6xfhH8BLjnuGR9icqxguvzl5zgqAkI2TZl+Ed1E+HQsYghqJhkGPHF2rc3XggaCPXpzyvn
 rmXoAxNLrCcLJeZDyBTP2AGfmML28cnenG3tpJ1lXmAEQ==
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Feb 2025 15:06:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17215

From: Louis Rannou <louis.rannou@non.se.com>

Check default flags are correctly returned by getVarFlags and check all flags
are returned when internalflags is True.

Check delVarFlags also removes default value.

Check all flags are removed after delVar.

Run the test with:
    $ bitbake-selftest -v bb.tests.data.TestFlags
    test_delflag (bb.tests.data.TestFlags.test_delflag) ... ok
    test_delvar (bb.tests.data.TestFlags.test_delvar) ... ok
    test_setflag (bb.tests.data.TestFlags.test_setflag) ... ok

    ----------------------------------------------------------------------
    Ran 3 tests in 0.000s

    OK

This is a test case for [YOCTO #15685]

Signed-off-by: Louis Rannou <louis.rannou@non.se.com>
---
 lib/bb/tests/data.py | 49 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/lib/bb/tests/data.py b/lib/bb/tests/data.py
index cbc7c1ecd4315b69b891564a1a3f111effee455c..a895f6a58efbbbdeba6f9c3f7ff0e43629f86fd1 100644
--- a/lib/bb/tests/data.py
+++ b/lib/bb/tests/data.py
@@ -450,17 +450,64 @@ class TestFlags(unittest.TestCase):
         self.d = bb.data.init()
         self.d.setVar("foo", "value of foo")
         self.d.setVarFlag("foo", "flag1", "value of flag1")
+        self.d.setVarFlag("foo", "_defaultval_flag_flag1", "default of flag1")
         self.d.setVarFlag("foo", "flag2", "value of flag2")
+        self.d.setVarFlag("foo", "_defaultval_flag_flag2", "default of flag2")
+        self.d.setVarFlag("foo", "flag3", "value of flag3")
+        self.d.setVarFlag("foo", "_defaultval_flag_flagnovalue", "default of flagnovalue")
 
     def test_setflag(self):
         self.assertEqual(self.d.getVarFlag("foo", "flag1", False), "value of flag1")
         self.assertEqual(self.d.getVarFlag("foo", "flag2", False), "value of flag2")
+        self.assertDictEqual(
+            self.d.getVarFlags("foo"),
+            {
+                "flag1": "value of flag1",
+                "flag2": "value of flag2",
+                "flag3": "value of flag3",
+                "flagnovalue": "default of flagnovalue",
+            }
+        )
+        self.assertDictEqual(
+            self.d.getVarFlags("foo", internalflags=True),
+            {
+                "_content": "value of foo",
+                "flag1": "value of flag1",
+                "flag2": "value of flag2",
+                "flag3": "value of flag3",
+                "_defaultval_flag_flag1": "default of flag1",
+                "_defaultval_flag_flag2": "default of flag2",
+                "_defaultval_flag_flagnovalue": "default of flagnovalue",
+            }
+        )
 
     def test_delflag(self):
         self.d.delVarFlag("foo", "flag2")
+        self.d.delVarFlag("foo", "flag3")
         self.assertEqual(self.d.getVarFlag("foo", "flag1", False), "value of flag1")
         self.assertEqual(self.d.getVarFlag("foo", "flag2", False), None)
-
+        self.assertDictEqual(
+            self.d.getVarFlags("foo"),
+            {
+                "flag1": "value of flag1",
+                "flagnovalue": "default of flagnovalue",
+            }
+        )
+        self.assertDictEqual(
+            self.d.getVarFlags("foo", internalflags=True),
+            {
+                "_content": "value of foo",
+                "flag1": "value of flag1",
+                "_defaultval_flag_flag1": "default of flag1",
+                "_defaultval_flag_flagnovalue": "default of flagnovalue",
+            }
+        )
+
+    def test_delvar(self):
+        self.d.delVar("foo")
+        self.assertEqual(self.d.getVarFlag("foo", "flag1", False), None)
+        self.assertEqual(self.d.getVarFlag("foo", "flag2", False), None)
+        self.assertEqual(self.d.getVarFlags("foo", internalflags=True), None)
 
 class Contains(unittest.TestCase):
     def setUp(self):

-- 
2.48.1


