Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D697CE7B12
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 13:27:50 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17872.1763126863406434301
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Nov 2025 05:27:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=e4zlrYXp;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1B6BC1A1AA2
	for <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 13:27:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E693A6060E
	for <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 13:27:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 36FF310371C61;
	Fri, 14 Nov 2025 14:27:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763126861; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=xyIQSwiKmjfsfw4dCXJXo+l1G4SYujN93h22d5FwA6Q=;
	b=e4zlrYXpZFb3E1ZU5doGX+T/0kUCJ1J7cqgjRjUts8XbVMeb0Vwedjle2T1Lb73SEtt2EN
	zzfS9kexBScrpEnVIW4FmVA0MLZJX2v/Dal3wOez4Raoa1xvIPTk+UD+wceQn7UyqLMZD1
	1e84HSjhlaOg4gTgg2gAjos+ViYzfQ7Fh/A0rDSQD372TyeTqJ6PtelFK/eGFFVmVllLV7
	Q1s7KC4FroBodBuUqnGXK6dPuUE1MAWd1LO9FQ2zFY1CDtUvtuwdPUefr551nwX7fRq+/v
	+qsCOg6nvHyY4kddtXKuNNnnYDEQQKtkGzQ51NGYCjVKcpv1Lgo0ZNvv86tnag==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Fri, 14 Nov 2025 14:27:34 +0100
Subject: [PATCH 2/2] tests: data: Add tests on emitting environment
 variables
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-mathieu-back_quote_devshell-v1-2-45e83df2f362@bootlin.com>
References: <20251114-mathieu-back_quote_devshell-v1-0-45e83df2f362@bootlin.com>
In-Reply-To: <20251114-mathieu-back_quote_devshell-v1-0-45e83df2f362@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763126859; l=4753;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=lXP4/VHwiPh41gfmsGvEt85Wnq+o9SK4oTL7myMbq5c=;
 b=r46QP22JcgtEK0P2SAUX0M+W1x3SJelc9zWQnak355IqzCgOMoa1M/QhJEHH8VZubG8lkhS2e
 2vaxPBzCG7vC2bM295XWsho/j9/iQH/gw6OqACQxj7zmTXR+6+uHGkM
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 13:27:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18401

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 lib/bb/tests/data.py | 105 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/lib/bb/tests/data.py b/lib/bb/tests/data.py
index a895f6a58efb..fd690a9e24fb 100644
--- a/lib/bb/tests/data.py
+++ b/lib/bb/tests/data.py
@@ -11,6 +11,7 @@ import unittest
 import bb
 import bb.data
 import bb.parse
+import io
 import logging
 import os
 
@@ -617,4 +618,108 @@ class Serialize(unittest.TestCase):
         self.assertEqual(newd.getVar('HELLO'), 'world')
         self.assertEqual(newd.getVarFlag('HELLO', 'other'), 'planet')
 
+class EmitVar(unittest.TestCase):
+    def setUp(self):
+        self.d = bb.data.init()
+
+        self.d.setVar("foo", "value of foo")
+
+        self.d.setVar("foo_exported", "value of foo_exported")
+        self.d.setVarFlag("foo_exported", "export", "1")
+
+        self.d.setVar("foo_unexported", "value of foo_unexported")
+        self.d.setVarFlag("foo_unexported", "unexport", "1")
+
+        self.d.setVar("test_func", "echo test_func_l1\necho test_func_l2")
+        self.d.setVarFlag("test_func", "func", "1")
+
+        self.d.setVar("bad_chars", 'a"b\nc`d\ne$f')
+
+    @staticmethod
+    def get_output(out):
+        lines = [line for line in out.getvalue().splitlines()
+                 if len(line) == 0 or line[0] != '#'
+                 ]
+        out.truncate(0)
+        out.seek(0)
+        return lines
+
+    def test_simple_variable(self):
+        out = io.StringIO()
+
+        bb.data.emit_var('foo', out, self.d, all=True)
+        self.assertEqual(self.get_output(out), ['foo="value of foo"'])
+
+    def test_exported(self):
+        out = io.StringIO()
+
+        bb.data.emit_var('foo_exported', out, self.d)
+        self.assertEqual(self.get_output(out),
+                         ['export foo_exported="value of foo_exported"'])
+
+    def test_unexported(self):
+        out = io.StringIO()
+
+        bb.data.emit_var('foo_unexported', out, self.d)
+        self.assertEqual(self.get_output(out), ['unset foo_unexported'])
+
+    def test_function(self):
+        out = io.StringIO()
+
+        bb.data.emit_var('test_func', out, self.d)
+        self.assertEqual(self.get_output(out), ['test_func() {',
+                                                'echo test_func_l1',
+                                                'echo test_func_l2',
+                                                '}'])
+
+    def test_all(self):
+        out = io.StringIO()
+
+        bb.data.emit_var('foo', out, self.d, all=True)
+        self.assertEqual(self.get_output(out), ['foo="value of foo"'])
+
+        bb.data.emit_var('foo_exported', out, self.d, all=True)
+        self.assertEqual(self.get_output(out),
+                         ['export foo_exported="value of foo_exported"'])
+        bb.data.emit_var('foo_unexported', out, self.d, all=True)
+
+        self.assertEqual(self.get_output(out), ['unset foo_unexported'])
+
+        bb.data.emit_var('test_func', out, self.d, all=True)
+        self.assertEqual(self.get_output(out), ['test_func() {',
+                                                'echo test_func_l1',
+                                                'echo test_func_l2',
+                                                '}'])
+
+    def test_not_all(self):
+        out = io.StringIO()
+
+        bb.data.emit_var('foo', out, self.d)
+        self.assertEqual(self.get_output(out), [])
+
+        bb.data.emit_var('foo_exported', out, self.d)
+        self.assertEqual(self.get_output(out),
+                         ['export foo_exported="value of foo_exported"'])
+
+        bb.data.emit_var('foo_unexported', out, self.d)
+        self.assertEqual(self.get_output(out), ['unset foo_unexported'])
+
+        bb.data.emit_var('test_func', out, self.d)
+        self.assertEqual(self.get_output(out), ['test_func() {',
+                                                'echo test_func_l1',
+                                                'echo test_func_l2',
+                                                '}'])
+
+    def test_not_set(self):
+        out = io.StringIO()
+
+        bb.data.emit_var('random_name', out, self.d)
+        self.assertEqual(self.get_output(out), [])
+
+    def test_bad_chars(self):
+        out = io.StringIO()
 
+        bb.data.emit_var('bad_chars', out, self.d, all=True)
+        self.assertEqual(self.get_output(out), ['bad_chars="a\\"b \\',
+                                                'c\\`d \\',
+                                                'e\\$f"'])

-- 
2.47.3


