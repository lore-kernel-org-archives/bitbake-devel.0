Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AF1CD8C85
	for <webhook@archiver.kernel.org>; Sat,  6 Jun 2026 21:20:06 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23174.1780780803381087874
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 06 Jun 2026 14:20:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=yPd+ra2z;
 spf=pass (domain: smile.fr, ip: 209.85.128.51, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490aebf33e9so16778995e9.3
        for <bitbake-devel@lists.openembedded.org>; Sat, 06 Jun 2026 14:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1780780802; x=1781385602; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvDQi7YbCH6y0AL6xHuestWEttdw0jIbjoT1fSuyMDw=;
        b=yPd+ra2zTU/a5iEgvEEK2VS8/3sRD1bCIJpYzHeLG/AZYlYaHOV/tif0NavV++YwIW
         8yZoDoE0lsEoQQUUU/Ms6r5ZbPy6uUYnDBzMtT6x/2NtbiEnrIoDOcDYcSkFaF4gXlV3
         bCmMncakrk1u4k7cxX1H7Py5cuu+IKOb00H2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780780802; x=1781385602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cvDQi7YbCH6y0AL6xHuestWEttdw0jIbjoT1fSuyMDw=;
        b=ohBzZebamCOAEKyYOqVk+ZunblPkvNpoucsw9zP918F9Dqfk7Cv7kJDMXH5iqSHCwT
         T7UbXnriFxr0BIY2A78OgM1PeTiYjEkBlQ2H1Lq5jv3zdFiYUMV0WVHipaVpZIih2Iv3
         DuCtCwKLGVFeW7T7mZG5CbEfsu5uupgA8jIu6VcQjGNVcaODvHtgkOsvcR9JNyFWxecL
         OXr6jz+TobMol7IZ5jQmDLqGkfohoFA9dFZsNYWQcPf92Uwrd5mK79vuUmDAnM8TaKy5
         nAhw6tu2wa2llQTjA3k+9fdO2vN2pg9JlQtxjoal4ZcJEwtHP6iSCiaprLbZRK6gln4H
         DfhQ==
X-Gm-Message-State: AOJu0YwlTrHSikMgCx+Q9YQ2FeelePiE7VVTKD/h7Oix30sFxR70tRz9
	K/h45l/EVRuEv7vbzsWPkULezq9SOgMuFzWo6C6gYQQmhpFLQ+EPbTrcN+KTMlLp87b9xGeO8gP
	YMr18
X-Gm-Gg: Acq92OEMge5cMJmYDpFcsV+209BSKCSttVPGT8SU2h7AwlXzd8NBvAAQYLmfYqX7DQP
	9gR1YmuAWqZRvZWyB1wcH0dxUYA2h/uNsXTQN8dfr+3ib1oKXk8QrrAOBlAr8L8qiAMN4u6tNoH
	hbHKKnqhWUgRW4bSvpuVNoJoIS56Am8zPzGxDUFlztlJq7iid0NNu2GtZxe4LXP+aKaXjuaK4kA
	DKMBOfhaZHA8WCi8m4LJ5V/gZSevQPRCLE5CFRY55TSrktkQDuSajMADcnh/AHWHjV8PKWUCCvk
	Zwr/YG1Wjmf5WWdvwcHyey/FpHlDRqHG8ijuiZbnfa8eS86sytuBriQq7pVoUcV+GvBlWFVT1qN
	hVrJjp2RWbMaRHsoV2r0mumrB3oxJn/UQ9YKme2h6aFqLoGJQpSWYRzomTkjQuT4Z+7urzioTkz
	fdttoSnsUNpeFbxslEsV/4FYfAGiuP1MLbCRZSXMKVJiqeFU+ThVhhrN4dS1HaBYjLpfRVbJg0w
	Rhlz26I6/Sx/vZa74kzUTByzcmw9f2H1HW1cQ==
X-Received: by 2002:a05:600c:8705:b0:488:ac01:72de with SMTP id 5b1f17b1804b1-490c25898efmr189313805e9.5.1780780801684;
        Sat, 06 Jun 2026 14:20:01 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa000f4f58971dfc8e81.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:f4f:5897:1dfc:8e81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3cc140sm314340625e9.9.2026.06.06.14.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 14:20:01 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [bitbake][wrynose][2.18][PATCH 1/3] hashserv/tests: use valid 64-character unihashes
Date: Sat,  6 Jun 2026 23:19:37 +0200
Message-ID: <b6070b5c23fbee20e13d710b1b7b403c6fba31f0.1780780690.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1780780690.git.yoann.congal@smile.fr>
References: <cover.1780780690.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 06 Jun 2026 21:20:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19630

From: Anders Heimer <anders.heimer@est.tech>

Signed-off-by: Anders Heimer <anders.heimer@est.tech>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 16ef07c851f3438c0e6034b9a2fe2c708b766aa2)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/hashserv/tests.py | 163 ++++++++++++++++++++++++++++--------------
 1 file changed, 109 insertions(+), 54 deletions(-)

diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
index 124d8aa00..9993fc9f3 100644
--- a/lib/hashserv/tests.py
+++ b/lib/hashserv/tests.py
@@ -124,7 +124,7 @@ class HashEquivalenceTestSetup(object):
         # Simple test that hashes can be created
         taskhash = '35788efcb8dfb0a02659d81cf2bfd695fb30faf9'
         outhash = '2765d4a5884be49b28601445c2760c5f21e7e5c0ee2b7e3fce98fd7e5970796f'
-        unihash = 'f46d3fbb439bd9b921095da657a4de906510d2cd'
+        unihash = 'a69ec97f5af2e21e1a1f9cc8896965515d5559425666f734e245a3d40cee33d9'
 
         self.assertClientGetHash(client, taskhash, None)
 
@@ -178,7 +178,7 @@ class HashEquivalenceCommonTests(object):
         # assigned the same unihash
         taskhash = '53b8dce672cb6d0c73170be43f540460bfc347b4'
         outhash = '5a9cb1649625f0bf41fc7791b635cd9c2d7118c7f021ba87dcd03f72b67ce7a8'
-        unihash = 'f37918cc02eb5a520b1aff86faacbc0a38124646'
+        unihash = '46edb5140d2613049332d0bf3745d9fafec9c559dac8cc61813739a28007fcdf'
 
         result = self.client.report_unihash(taskhash, self.METHOD, outhash, unihash)
         self.assertEqual(result['unihash'], unihash, 'Server returned bad unihash')
@@ -186,7 +186,7 @@ class HashEquivalenceCommonTests(object):
         # Report a different task with the same outhash. The returned unihash
         # should match the first task
         taskhash2 = '3bf6f1e89d26205aec90da04854fbdbf73afe6b4'
-        unihash2 = 'af36b199320e611fbb16f1f277d3ee1d619ca58b'
+        unihash2 = 'bf6e81926066f770e960f9f777cd088c62bea9addb7745f3e77deaa81a645747'
         result = self.client.report_unihash(taskhash2, self.METHOD, outhash, unihash2)
         self.assertEqual(result['unihash'], unihash, 'Server returned bad unihash')
 
@@ -196,19 +196,19 @@ class HashEquivalenceCommonTests(object):
         # taskhash
         taskhash = '8aa96fcffb5831b3c2c0cb75f0431e3f8b20554a'
         outhash = 'afe240a439959ce86f5e322f8c208e1fedefea9e813f2140c81af866cc9edf7e'
-        unihash = '218e57509998197d570e2c98512d0105985dffc9'
+        unihash = '5b521d8a12683086cc08bc2c6d94a7a2dcff17eba53b9911e145d51164689380'
         self.client.report_unihash(taskhash, self.METHOD, outhash, unihash)
 
         self.assertClientGetHash(self.client, taskhash, unihash)
 
         outhash2 = '0904a7fe3dc712d9fd8a74a616ddca2a825a8ee97adf0bd3fc86082c7639914d'
-        unihash2 = 'ae9a7d252735f0dafcdb10e2e02561ca3a47314c'
+        unihash2 = 'a37541b54fd22440e292f617eb30ba07455e88fb0b9f0952eca229b6356290e3'
         self.client.report_unihash(taskhash, self.METHOD, outhash2, unihash2)
 
         self.assertClientGetHash(self.client, taskhash, unihash)
 
         outhash3 = '77623a549b5b1a31e3732dfa8fe61d7ce5d44b3370f253c5360e136b852967b4'
-        unihash3 = '9217a7d6398518e5dc002ed58f2cbbbc78696603'
+        unihash3 = '6842f1f2daccd96ddef15c9154d4e41ac8a2300d781ac9a9db7f8afeb8a96808'
         self.client.report_unihash(taskhash, self.METHOD, outhash3, unihash3)
 
         self.assertClientGetHash(self.client, taskhash, unihash)
@@ -268,7 +268,7 @@ class HashEquivalenceCommonTests(object):
         # Simple test that hashes can be created
         taskhash = 'c665584ee6817aa99edfc77a44dd853828279370'
         outhash = '3c979c3db45c569f51ab7626a4651074be3a9d11a84b1db076f5b14f7d39db44'
-        unihash = '90e9bc1d1f094c51824adca7f8ea79a048d68824'
+        unihash = '06f89b8f329ba8124ff73c56d09ef921b42624747c421277bddaf5e23f136e57'
 
         self.assertClientGetHash(self.client, taskhash, None)
 
@@ -361,7 +361,7 @@ class HashEquivalenceCommonTests(object):
         # Basic report
         taskhash = '8aa96fcffb5831b3c2c0cb75f0431e3f8b20554a'
         outhash = 'afe240a439959ce86f5e322f8c208e1fedefea9e813f2140c81af866cc9edf7e'
-        unihash = '218e57509998197d570e2c98512d0105985dffc9'
+        unihash = '5b521d8a12683086cc08bc2c6d94a7a2dcff17eba53b9911e145d51164689380'
         self.client.report_unihash(taskhash, self.METHOD, outhash, unihash)
 
         check_hash(taskhash, unihash, None)
@@ -369,7 +369,7 @@ class HashEquivalenceCommonTests(object):
         # Duplicated taskhash with multiple output hashes and unihashes.
         # All servers should agree with the originally reported hash
         outhash2 = '0904a7fe3dc712d9fd8a74a616ddca2a825a8ee97adf0bd3fc86082c7639914d'
-        unihash2 = 'ae9a7d252735f0dafcdb10e2e02561ca3a47314c'
+        unihash2 = 'a37541b54fd22440e292f617eb30ba07455e88fb0b9f0952eca229b6356290e3'
         self.client.report_unihash(taskhash, self.METHOD, outhash2, unihash2)
 
         check_hash(taskhash, unihash, unihash)
@@ -377,7 +377,7 @@ class HashEquivalenceCommonTests(object):
         # Report an equivalent task. The sideload will originally report
         # no unihash until backfilled
         taskhash3 = "044c2ec8aaf480685a00ff6ff49e6162e6ad34e1"
-        unihash3 = "def64766090d28f627e816454ed46894bb3aab36"
+        unihash3 = "aca636d800aef40e6ddcea4b2262cc4ea0d1180a6783e5b4653a20c7dd73458d"
         self.client.report_unihash(taskhash3, self.METHOD, outhash, unihash3)
 
         check_hash(taskhash3, unihash, None)
@@ -386,7 +386,7 @@ class HashEquivalenceCommonTests(object):
         # propagating to the upstream server
         taskhash4 = "e3da00593d6a7fb435c7e2114976c59c5fd6d561"
         outhash4 = "1cf8713e645f491eb9c959d20b5cae1c47133a292626dda9b10709857cbe688a"
-        unihash4 = "3b5d3d83f07f259e9086fcb422c855286e18a57d"
+        unihash4 = "7aebef07d66a8c0f92d0c4f65ec8b1fbb850a3693c53827b8774b64fa9a8a9fe"
         down_client.report_unihash(taskhash4, self.METHOD, outhash4, unihash4)
         down_client.backfill_wait()
 
@@ -398,18 +398,18 @@ class HashEquivalenceCommonTests(object):
         # match which was previously reported to the upstream server
         taskhash5 = '35788efcb8dfb0a02659d81cf2bfd695fb30faf9'
         outhash5 = '2765d4a5884be49b28601445c2760c5f21e7e5c0ee2b7e3fce98fd7e5970796f'
-        unihash5 = 'f46d3fbb439bd9b921095da657a4de906510d2cd'
+        unihash5 = 'a69ec97f5af2e21e1a1f9cc8896965515d5559425666f734e245a3d40cee33d9'
         result = self.client.report_unihash(taskhash5, self.METHOD, outhash5, unihash5)
 
         taskhash6 = '35788efcb8dfb0a02659d81cf2bfd695fb30fafa'
-        unihash6 = 'f46d3fbb439bd9b921095da657a4de906510d2ce'
+        unihash6 = 'eabc7a98e0c12bbeb8394dbdf055eb81aac60e4a14cca5c1f069d36efc933b23'
         result = down_client.report_unihash(taskhash6, self.METHOD, outhash5, unihash6)
         self.assertEqual(result['unihash'], unihash5, 'Server failed to copy unihash from upstream')
 
         # Tests read through from server with
         taskhash7 = '9d81d76242cc7cfaf7bf74b94b9cd2e29324ed74'
         outhash7 = '8470d56547eea6236d7c81a644ce74670ca0bbda998e13c629ef6bb3f0d60b69'
-        unihash7 = '05d2a63c81e32f0a36542ca677e8ad852365c538'
+        unihash7 = '7521a98a0c645341bc51559b234ef37a097e8f3a01665e0303a317925ab7b4d5'
         self.client.report_unihash(taskhash7, self.METHOD, outhash7, unihash7)
 
         result = down_client.get_taskhash(self.METHOD, taskhash7, True)
@@ -420,7 +420,7 @@ class HashEquivalenceCommonTests(object):
 
         taskhash8 = '86978a4c8c71b9b487330b0152aade10c1ee58aa'
         outhash8 = 'ca8c128e9d9e4a28ef24d0508aa20b5cf880604eacd8f65c0e366f7e0cc5fbcf'
-        unihash8 = 'd8bcf25369d40590ad7d08c84d538982f2023e01'
+        unihash8 = '83386d9385b0bf3ba25693127ddcaaadeaa1c4bf8cb0baecfb5314b9a20072a1'
         self.client.report_unihash(taskhash8, self.METHOD, outhash8, unihash8)
 
         result = down_client.get_outhash(self.METHOD, outhash8, taskhash8)
@@ -431,7 +431,7 @@ class HashEquivalenceCommonTests(object):
 
         taskhash9 = 'ae6339531895ddf5b67e663e6a374ad8ec71d81c'
         outhash9 = 'afc78172c81880ae10a1fec994b5b4ee33d196a001a1b66212a15ebe573e00b5'
-        unihash9 = '6662e699d6e3d894b24408ff9a4031ef9b038ee8'
+        unihash9 = 'cc74784b2c0ad5b378a6b783c74c518d2c46b8b52fba29cb39a8430d742440d7'
         self.client.report_unihash(taskhash9, self.METHOD, outhash9, unihash9)
 
         result = down_client.get_taskhash(self.METHOD, taskhash9, False)
@@ -454,7 +454,7 @@ class HashEquivalenceCommonTests(object):
         # Report a hash via the read-write server
         taskhash = '35788efcb8dfb0a02659d81cf2bfd695fb30faf9'
         outhash = '2765d4a5884be49b28601445c2760c5f21e7e5c0ee2b7e3fce98fd7e5970796f'
-        unihash = 'f46d3fbb439bd9b921095da657a4de906510d2cd'
+        unihash = 'a69ec97f5af2e21e1a1f9cc8896965515d5559425666f734e245a3d40cee33d9'
 
         result = rw_client.report_unihash(taskhash, self.METHOD, outhash, unihash)
         self.assertEqual(result['unihash'], unihash, 'Server returned bad unihash')
@@ -465,7 +465,7 @@ class HashEquivalenceCommonTests(object):
         # Ensure that reporting via the read-only server fails
         taskhash2 = 'c665584ee6817aa99edfc77a44dd853828279370'
         outhash2 = '3c979c3db45c569f51ab7626a4651074be3a9d11a84b1db076f5b14f7d39db44'
-        unihash2 = '90e9bc1d1f094c51824adca7f8ea79a048d68824'
+        unihash2 = '06f89b8f329ba8124ff73c56d09ef921b42624747c421277bddaf5e23f136e57'
 
         result = ro_client.report_unihash(taskhash2, self.METHOD, outhash2, unihash2)
         self.assertEqual(result['unihash'], unihash2)
@@ -554,15 +554,43 @@ class HashEquivalenceCommonTests(object):
     def test_get_unihash_batch(self):
         TEST_INPUT = (
             # taskhash                                   outhash                                                            unihash
-            ('8aa96fcffb5831b3c2c0cb75f0431e3f8b20554a', 'afe240a439959ce86f5e322f8c208e1fedefea9e813f2140c81af866cc9edf7e','218e57509998197d570e2c98512d0105985dffc9'),
+            (
+                '8aa96fcffb5831b3c2c0cb75f0431e3f8b20554a',
+                'afe240a439959ce86f5e322f8c208e1fedefea9e813f2140c81af866cc9edf7e',
+                '5b521d8a12683086cc08bc2c6d94a7a2dcff17eba53b9911e145d51164689380',
+            ),
             # Duplicated taskhash with multiple output hashes and unihashes.
-            ('8aa96fcffb5831b3c2c0cb75f0431e3f8b20554a', '0904a7fe3dc712d9fd8a74a616ddca2a825a8ee97adf0bd3fc86082c7639914d', 'ae9a7d252735f0dafcdb10e2e02561ca3a47314c'),
+            (
+                '8aa96fcffb5831b3c2c0cb75f0431e3f8b20554a',
+                '0904a7fe3dc712d9fd8a74a616ddca2a825a8ee97adf0bd3fc86082c7639914d',
+                'a37541b54fd22440e292f617eb30ba07455e88fb0b9f0952eca229b6356290e3',
+            ),
             # Equivalent hash
-            ("044c2ec8aaf480685a00ff6ff49e6162e6ad34e1", '0904a7fe3dc712d9fd8a74a616ddca2a825a8ee97adf0bd3fc86082c7639914d', "def64766090d28f627e816454ed46894bb3aab36"),
-            ("e3da00593d6a7fb435c7e2114976c59c5fd6d561", "1cf8713e645f491eb9c959d20b5cae1c47133a292626dda9b10709857cbe688a", "3b5d3d83f07f259e9086fcb422c855286e18a57d"),
-            ('35788efcb8dfb0a02659d81cf2bfd695fb30faf9', '2765d4a5884be49b28601445c2760c5f21e7e5c0ee2b7e3fce98fd7e5970796f', 'f46d3fbb439bd9b921095da657a4de906510d2cd'),
-            ('35788efcb8dfb0a02659d81cf2bfd695fb30fafa', '2765d4a5884be49b28601445c2760c5f21e7e5c0ee2b7e3fce98fd7e5970796f', 'f46d3fbb439bd9b921095da657a4de906510d2ce'),
-            ('9d81d76242cc7cfaf7bf74b94b9cd2e29324ed74', '8470d56547eea6236d7c81a644ce74670ca0bbda998e13c629ef6bb3f0d60b69', '05d2a63c81e32f0a36542ca677e8ad852365c538'),
+            (
+                "044c2ec8aaf480685a00ff6ff49e6162e6ad34e1",
+                '0904a7fe3dc712d9fd8a74a616ddca2a825a8ee97adf0bd3fc86082c7639914d',
+                "aca636d800aef40e6ddcea4b2262cc4ea0d1180a6783e5b4653a20c7dd73458d",
+            ),
+            (
+                "e3da00593d6a7fb435c7e2114976c59c5fd6d561",
+                "1cf8713e645f491eb9c959d20b5cae1c47133a292626dda9b10709857cbe688a",
+                "7aebef07d66a8c0f92d0c4f65ec8b1fbb850a3693c53827b8774b64fa9a8a9fe",
+            ),
+            (
+                '35788efcb8dfb0a02659d81cf2bfd695fb30faf9',
+                '2765d4a5884be49b28601445c2760c5f21e7e5c0ee2b7e3fce98fd7e5970796f',
+                'a69ec97f5af2e21e1a1f9cc8896965515d5559425666f734e245a3d40cee33d9',
+            ),
+            (
+                '35788efcb8dfb0a02659d81cf2bfd695fb30fafa',
+                '2765d4a5884be49b28601445c2760c5f21e7e5c0ee2b7e3fce98fd7e5970796f',
+                'eabc7a98e0c12bbeb8394dbdf055eb81aac60e4a14cca5c1f069d36efc933b23',
+            ),
+            (
+                '9d81d76242cc7cfaf7bf74b94b9cd2e29324ed74',
+                '8470d56547eea6236d7c81a644ce74670ca0bbda998e13c629ef6bb3f0d60b69',
+                '7521a98a0c645341bc51559b234ef37a097e8f3a01665e0303a317925ab7b4d5',
+            ),
         )
         EXTRA_QUERIES = (
             "6b6be7a84ab179b4240c4302518dc3f6",
@@ -578,28 +606,56 @@ class HashEquivalenceCommonTests(object):
         )
 
         self.assertListEqual(result, [
-            "218e57509998197d570e2c98512d0105985dffc9",
-            "218e57509998197d570e2c98512d0105985dffc9",
-            "218e57509998197d570e2c98512d0105985dffc9",
-            "3b5d3d83f07f259e9086fcb422c855286e18a57d",
-            "f46d3fbb439bd9b921095da657a4de906510d2cd",
-            "f46d3fbb439bd9b921095da657a4de906510d2cd",
-            "05d2a63c81e32f0a36542ca677e8ad852365c538",
+            "5b521d8a12683086cc08bc2c6d94a7a2dcff17eba53b9911e145d51164689380",
+            "5b521d8a12683086cc08bc2c6d94a7a2dcff17eba53b9911e145d51164689380",
+            "5b521d8a12683086cc08bc2c6d94a7a2dcff17eba53b9911e145d51164689380",
+            "7aebef07d66a8c0f92d0c4f65ec8b1fbb850a3693c53827b8774b64fa9a8a9fe",
+            "a69ec97f5af2e21e1a1f9cc8896965515d5559425666f734e245a3d40cee33d9",
+            "a69ec97f5af2e21e1a1f9cc8896965515d5559425666f734e245a3d40cee33d9",
+            "7521a98a0c645341bc51559b234ef37a097e8f3a01665e0303a317925ab7b4d5",
             None,
         ])
 
     def test_unihash_exists_batch(self):
         TEST_INPUT = (
             # taskhash                                   outhash                                                            unihash
-            ('8aa96fcffb5831b3c2c0cb75f0431e3f8b20554a', 'afe240a439959ce86f5e322f8c208e1fedefea9e813f2140c81af866cc9edf7e','218e57509998197d570e2c98512d0105985dffc9'),
+            (
+                '8aa96fcffb5831b3c2c0cb75f0431e3f8b20554a',
+                'afe240a439959ce86f5e322f8c208e1fedefea9e813f2140c81af866cc9edf7e',
+                '5b521d8a12683086cc08bc2c6d94a7a2dcff17eba53b9911e145d51164689380',
+            ),
             # Duplicated taskhash with multiple output hashes and unihashes.
-            ('8aa96fcffb5831b3c2c0cb75f0431e3f8b20554a', '0904a7fe3dc712d9fd8a74a616ddca2a825a8ee97adf0bd3fc86082c7639914d', 'ae9a7d252735f0dafcdb10e2e02561ca3a47314c'),
+            (
+                '8aa96fcffb5831b3c2c0cb75f0431e3f8b20554a',
+                '0904a7fe3dc712d9fd8a74a616ddca2a825a8ee97adf0bd3fc86082c7639914d',
+                'a37541b54fd22440e292f617eb30ba07455e88fb0b9f0952eca229b6356290e3',
+            ),
             # Equivalent hash
-            ("044c2ec8aaf480685a00ff6ff49e6162e6ad34e1", '0904a7fe3dc712d9fd8a74a616ddca2a825a8ee97adf0bd3fc86082c7639914d', "def64766090d28f627e816454ed46894bb3aab36"),
-            ("e3da00593d6a7fb435c7e2114976c59c5fd6d561", "1cf8713e645f491eb9c959d20b5cae1c47133a292626dda9b10709857cbe688a", "3b5d3d83f07f259e9086fcb422c855286e18a57d"),
-            ('35788efcb8dfb0a02659d81cf2bfd695fb30faf9', '2765d4a5884be49b28601445c2760c5f21e7e5c0ee2b7e3fce98fd7e5970796f', 'f46d3fbb439bd9b921095da657a4de906510d2cd'),
-            ('35788efcb8dfb0a02659d81cf2bfd695fb30fafa', '2765d4a5884be49b28601445c2760c5f21e7e5c0ee2b7e3fce98fd7e5970796f', 'f46d3fbb439bd9b921095da657a4de906510d2ce'),
-            ('9d81d76242cc7cfaf7bf74b94b9cd2e29324ed74', '8470d56547eea6236d7c81a644ce74670ca0bbda998e13c629ef6bb3f0d60b69', '05d2a63c81e32f0a36542ca677e8ad852365c538'),
+            (
+                "044c2ec8aaf480685a00ff6ff49e6162e6ad34e1",
+                '0904a7fe3dc712d9fd8a74a616ddca2a825a8ee97adf0bd3fc86082c7639914d',
+                "aca636d800aef40e6ddcea4b2262cc4ea0d1180a6783e5b4653a20c7dd73458d",
+            ),
+            (
+                "e3da00593d6a7fb435c7e2114976c59c5fd6d561",
+                "1cf8713e645f491eb9c959d20b5cae1c47133a292626dda9b10709857cbe688a",
+                "7aebef07d66a8c0f92d0c4f65ec8b1fbb850a3693c53827b8774b64fa9a8a9fe",
+            ),
+            (
+                '35788efcb8dfb0a02659d81cf2bfd695fb30faf9',
+                '2765d4a5884be49b28601445c2760c5f21e7e5c0ee2b7e3fce98fd7e5970796f',
+                'a69ec97f5af2e21e1a1f9cc8896965515d5559425666f734e245a3d40cee33d9',
+            ),
+            (
+                '35788efcb8dfb0a02659d81cf2bfd695fb30fafa',
+                '2765d4a5884be49b28601445c2760c5f21e7e5c0ee2b7e3fce98fd7e5970796f',
+                'eabc7a98e0c12bbeb8394dbdf055eb81aac60e4a14cca5c1f069d36efc933b23',
+            ),
+            (
+                '9d81d76242cc7cfaf7bf74b94b9cd2e29324ed74',
+                '8470d56547eea6236d7c81a644ce74670ca0bbda998e13c629ef6bb3f0d60b69',
+                '7521a98a0c645341bc51559b234ef37a097e8f3a01665e0303a317925ab7b4d5',
+            ),
         )
         EXTRA_QUERIES = (
             "6b6be7a84ab179b4240c4302518dc3f6",
@@ -939,14 +995,14 @@ class HashEquivalenceCommonTests(object):
     def test_gc(self):
         taskhash = '53b8dce672cb6d0c73170be43f540460bfc347b4'
         outhash = '5a9cb1649625f0bf41fc7791b635cd9c2d7118c7f021ba87dcd03f72b67ce7a8'
-        unihash = 'f37918cc02eb5a520b1aff86faacbc0a38124646'
+        unihash = '46edb5140d2613049332d0bf3745d9fafec9c559dac8cc61813739a28007fcdf'
 
         result = self.client.report_unihash(taskhash, self.METHOD, outhash, unihash)
         self.assertEqual(result['unihash'], unihash, 'Server returned bad unihash')
 
         taskhash2 = '3bf6f1e89d26205aec90da04854fbdbf73afe6b4'
         outhash2 = '77623a549b5b1a31e3732dfa8fe61d7ce5d44b3370f253c5360e136b852967b4'
-        unihash2 = 'af36b199320e611fbb16f1f277d3ee1d619ca58b'
+        unihash2 = 'bf6e81926066f770e960f9f777cd088c62bea9addb7745f3e77deaa81a645747'
 
         result = self.client.report_unihash(taskhash2, self.METHOD, outhash2, unihash2)
         self.assertClientGetHash(self.client, taskhash2, unihash2)
@@ -972,21 +1028,21 @@ class HashEquivalenceCommonTests(object):
     def test_gc_stream(self):
         taskhash = '53b8dce672cb6d0c73170be43f540460bfc347b4'
         outhash = '5a9cb1649625f0bf41fc7791b635cd9c2d7118c7f021ba87dcd03f72b67ce7a8'
-        unihash = 'f37918cc02eb5a520b1aff86faacbc0a38124646'
+        unihash = '46edb5140d2613049332d0bf3745d9fafec9c559dac8cc61813739a28007fcdf'
 
         result = self.client.report_unihash(taskhash, self.METHOD, outhash, unihash)
         self.assertEqual(result['unihash'], unihash, 'Server returned bad unihash')
 
         taskhash2 = '3bf6f1e89d26205aec90da04854fbdbf73afe6b4'
         outhash2 = '77623a549b5b1a31e3732dfa8fe61d7ce5d44b3370f253c5360e136b852967b4'
-        unihash2 = 'af36b199320e611fbb16f1f277d3ee1d619ca58b'
+        unihash2 = 'bf6e81926066f770e960f9f777cd088c62bea9addb7745f3e77deaa81a645747'
 
         result = self.client.report_unihash(taskhash2, self.METHOD, outhash2, unihash2)
         self.assertClientGetHash(self.client, taskhash2, unihash2)
 
         taskhash3 = 'a1117c1f5a7c9ab2f5a39cc6fe5e6152169d09c0'
         outhash3 = '7289c414905303700a1117c1f5a7c9ab2f5a39cc6fe5e6152169d09c04f9a53c'
-        unihash3 = '905303700a1117c1f5a7c9ab2f5a39cc6fe5e615'
+        unihash3 = 'f5966c8588a69948a89131d3aa63b914c5a63a8cb4820cb1c58694135ba77f0b'
 
         result = self.client.report_unihash(taskhash3, self.METHOD, outhash3, unihash3)
         self.assertClientGetHash(self.client, taskhash3, unihash3)
@@ -1014,14 +1070,14 @@ class HashEquivalenceCommonTests(object):
     def test_gc_switch_mark(self):
         taskhash = '53b8dce672cb6d0c73170be43f540460bfc347b4'
         outhash = '5a9cb1649625f0bf41fc7791b635cd9c2d7118c7f021ba87dcd03f72b67ce7a8'
-        unihash = 'f37918cc02eb5a520b1aff86faacbc0a38124646'
+        unihash = '46edb5140d2613049332d0bf3745d9fafec9c559dac8cc61813739a28007fcdf'
 
         result = self.client.report_unihash(taskhash, self.METHOD, outhash, unihash)
         self.assertEqual(result['unihash'], unihash, 'Server returned bad unihash')
 
         taskhash2 = '3bf6f1e89d26205aec90da04854fbdbf73afe6b4'
         outhash2 = '77623a549b5b1a31e3732dfa8fe61d7ce5d44b3370f253c5360e136b852967b4'
-        unihash2 = 'af36b199320e611fbb16f1f277d3ee1d619ca58b'
+        unihash2 = 'bf6e81926066f770e960f9f777cd088c62bea9addb7745f3e77deaa81a645747'
 
         result = self.client.report_unihash(taskhash2, self.METHOD, outhash2, unihash2)
         self.assertClientGetHash(self.client, taskhash2, unihash2)
@@ -1059,14 +1115,14 @@ class HashEquivalenceCommonTests(object):
     def test_gc_switch_sweep_mark(self):
         taskhash = '53b8dce672cb6d0c73170be43f540460bfc347b4'
         outhash = '5a9cb1649625f0bf41fc7791b635cd9c2d7118c7f021ba87dcd03f72b67ce7a8'
-        unihash = 'f37918cc02eb5a520b1aff86faacbc0a38124646'
+        unihash = '46edb5140d2613049332d0bf3745d9fafec9c559dac8cc61813739a28007fcdf'
 
         result = self.client.report_unihash(taskhash, self.METHOD, outhash, unihash)
         self.assertEqual(result['unihash'], unihash, 'Server returned bad unihash')
 
         taskhash2 = '3bf6f1e89d26205aec90da04854fbdbf73afe6b4'
         outhash2 = '77623a549b5b1a31e3732dfa8fe61d7ce5d44b3370f253c5360e136b852967b4'
-        unihash2 = 'af36b199320e611fbb16f1f277d3ee1d619ca58b'
+        unihash2 = 'bf6e81926066f770e960f9f777cd088c62bea9addb7745f3e77deaa81a645747'
 
         result = self.client.report_unihash(taskhash2, self.METHOD, outhash2, unihash2)
         self.assertClientGetHash(self.client, taskhash2, unihash2)
@@ -1089,7 +1145,7 @@ class HashEquivalenceCommonTests(object):
     def test_gc_new_hashes(self):
         taskhash = '53b8dce672cb6d0c73170be43f540460bfc347b4'
         outhash = '5a9cb1649625f0bf41fc7791b635cd9c2d7118c7f021ba87dcd03f72b67ce7a8'
-        unihash = 'f37918cc02eb5a520b1aff86faacbc0a38124646'
+        unihash = '46edb5140d2613049332d0bf3745d9fafec9c559dac8cc61813739a28007fcdf'
 
         result = self.client.report_unihash(taskhash, self.METHOD, outhash, unihash)
         self.assertEqual(result['unihash'], unihash, 'Server returned bad unihash')
@@ -1106,7 +1162,7 @@ class HashEquivalenceCommonTests(object):
 
         taskhash2 = '3bf6f1e89d26205aec90da04854fbdbf73afe6b4'
         outhash2 = '77623a549b5b1a31e3732dfa8fe61d7ce5d44b3370f253c5360e136b852967b4'
-        unihash2 = 'af36b199320e611fbb16f1f277d3ee1d619ca58b'
+        unihash2 = 'bf6e81926066f770e960f9f777cd088c62bea9addb7745f3e77deaa81a645747'
 
         result = self.client.report_unihash(taskhash2, self.METHOD, outhash2, unihash2)
         self.assertClientGetHash(self.client, taskhash2, unihash2)
@@ -1405,14 +1461,14 @@ class TestHashEquivalenceClient(HashEquivalenceTestSetup, unittest.TestCase):
     def test_gc(self):
         taskhash = '53b8dce672cb6d0c73170be43f540460bfc347b4'
         outhash = '5a9cb1649625f0bf41fc7791b635cd9c2d7118c7f021ba87dcd03f72b67ce7a8'
-        unihash = 'f37918cc02eb5a520b1aff86faacbc0a38124646'
+        unihash = '46edb5140d2613049332d0bf3745d9fafec9c559dac8cc61813739a28007fcdf'
 
         result = self.client.report_unihash(taskhash, self.METHOD, outhash, unihash)
         self.assertEqual(result['unihash'], unihash, 'Server returned bad unihash')
 
         taskhash2 = '3bf6f1e89d26205aec90da04854fbdbf73afe6b4'
         outhash2 = '77623a549b5b1a31e3732dfa8fe61d7ce5d44b3370f253c5360e136b852967b4'
-        unihash2 = 'af36b199320e611fbb16f1f277d3ee1d619ca58b'
+        unihash2 = 'bf6e81926066f770e960f9f777cd088c62bea9addb7745f3e77deaa81a645747'
 
         result = self.client.report_unihash(taskhash2, self.METHOD, outhash2, unihash2)
         self.assertClientGetHash(self.client, taskhash2, unihash2)
@@ -1455,7 +1511,7 @@ class TestHashEquivalenceUnixServerLongPath(HashEquivalenceTestSetup, unittest.T
         # Simple test that hashes can be created
         taskhash = '35788efcb8dfb0a02659d81cf2bfd695fb30faf9'
         outhash = '2765d4a5884be49b28601445c2760c5f21e7e5c0ee2b7e3fce98fd7e5970796f'
-        unihash = 'f46d3fbb439bd9b921095da657a4de906510d2cd'
+        unihash = 'a69ec97f5af2e21e1a1f9cc8896965515d5559425666f734e245a3d40cee33d9'
 
         self.assertClientGetHash(self.client, taskhash, None)
 
@@ -1542,4 +1598,3 @@ class TestHashEquivalenceExternalServer(HashEquivalenceTestSetup, HashEquivalenc
 
     def test_auth_get_all_users(self):
         self.skipTest("Cannot test all users with external server")
-

