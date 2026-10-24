Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5388.1792845244692549176
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 24 Oct 2026 05:34:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=AJ1NFBvv;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A74321A1315
	for <bitbake-devel@lists.openembedded.org>; Sat, 24 Oct 2026 12:34:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7C5E660769
	for <bitbake-devel@lists.openembedded.org>; Sat, 24 Oct 2026 12:34:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AE26B10328EDB;
	Sat, 24 Oct 2026 14:34:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792845242; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=BPI1boXRsi+aaNwyctXWaDwj3Y5vNjyk2HPL4DgItFE=;
	b=AJ1NFBvv8EhIgHd6Rm8P03/kKEMErjg3Lu5STZeKIAVhIwYX12h9+JE6r3ID0N/28AdKHr
	3u0RJRrnv90Bbod/dM7jS8qB0LMcp06RgYAkJArGUoTVfERAjtv1ewMZl3B9KC+qMYA5iF
	dYGZnDG8+xBMSvvLlXbpl+46UhCiNH+gPBEHwA+9XL8D1AAVN5JTDhiGyHrwshOgX8t8rM
	sj8LQeJtpGcUTAoXwjh0ATxCw/QsuhYA4kHEAhjTHSab8VyVPKJ5tlo0TfPyg22N8wYm2L
	/zQCfVgxI7lZRRdeV8D6Eqfo2QNHRPHx1qkaUNbay896zhAxPTUf3rwpy9T+FA==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Sat, 24 Oct 2026 14:33:32 +0200
Subject: [PATCH RFC 1/3] utils: Extend LogCatcher to record raw messages
 and levels
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-mathieu-debug-replay-v4-v1-1-3f7f52a3b8e6@bootlin.com>
References: <20261024-mathieu-debug-replay-v4-v1-0-3f7f52a3b8e6@bootlin.com>
In-Reply-To: <20261024-mathieu-debug-replay-v4-v1-0-3f7f52a3b8e6@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792845239; l=3537;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=zn4aA6JzVFz39faIO4Fd9j6OZcfvz5Am6gIM0CJdChI=;
 b=DASbHu5cJhgIAOCnPkDip0m5VfnITObfOuCBfBq+hHjLwFRGh4t6nX+bFAwU3B9Mk2pvCOCQP
 xMTWwbsnxuLCpvkheiPRldPbGHit5aKAfvMpZL2kLa24MuDBONQcGOw
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Sat, 24 Oct 2026 12:34:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20376

LogCatcher stores only formatted messages, which strips the severity. Also
record each log record's raw message and level, so callers can later
replay them with their original severity. Lower the handler minimum level
to WARNONCE so warnonce and erroronce messages are captured too.

Add unit tests covering the captured levels and raw messages, the
formatted output and the level filtering.

AI-Generated: Uses opencode (DeepSeek V4 Flash)
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 lib/bb/tests/utils.py | 42 ++++++++++++++++++++++++++++++++++++++++++
 lib/bb/utils.py       |  4 +++-
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/lib/bb/tests/utils.py b/lib/bb/tests/utils.py
index 52b7bf85bf47..a34f6d698225 100644
--- a/lib/bb/tests/utils.py
+++ b/lib/bb/tests/utils.py
@@ -8,9 +8,11 @@
 
 import unittest
 import bb
+import bb.build
 import os
 import tempfile
 import re
+import logging
 
 class VerCmpString(unittest.TestCase):
 
@@ -693,6 +695,46 @@ class EnvironmentTests(unittest.TestCase):
         self.assertEqual(os.environ["A"], "this is A")
         self.assertNotIn("B", os.environ)
 
+class LogCatcherTests(unittest.TestCase):
+    def setUp(self):
+        self.logger = logging.getLogger("BitBake")
+        self.oldlevel = self.logger.level
+        self.logger.setLevel(logging.DEBUG)
+        self.catcher = bb.utils.LogCatcher()
+        self.logger.addHandler(self.catcher)
+
+    def tearDown(self):
+        self.logger.removeHandler(self.catcher)
+        self.logger.setLevel(self.oldlevel)
+
+    def test_records_capture_level_and_raw_message(self):
+        bb.warn("a warning")
+        bb.warnonce("a warn once")
+        bb.error("an error")
+        bb.erroronce("an error once")
+
+        self.assertEqual(self.catcher.records, [
+            (logging.WARNING, "a warning"),
+            (bb.msg.BBLogFormatter.WARNONCE, "a warn once"),
+            (logging.ERROR, "an error"),
+            (bb.msg.BBLogFormatter.ERRORONCE, "an error once"),
+        ])
+
+    def test_messages_are_formatted(self):
+        bb.warn("a warning")
+        self.assertEqual(self.catcher.messages, ["WARNING: a warning"])
+        self.assertTrue(self.catcher.contains("WARNING: a warning"))
+
+    def test_below_minimum_level_is_ignored(self):
+        bb.debug(1, "a debug")
+        bb.plain("a plain")
+        bb.note("a note")
+        bb.verbnote("a verb note")
+
+        self.assertEqual(self.catcher.records, [])
+        self.assertEqual(self.catcher.messages, [])
+
+
 class FilemodeTests(unittest.TestCase):
     def test_filemode_convert(self):
         self.assertEqual(0o775, bb.utils.to_filemode("0o775"))
diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index ec6eb2181aa8..4a4e911b0f8a 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -2154,9 +2154,11 @@ class LogCatcher(logging.Handler):
     """Logging handler for collecting logged messages so you can check them later"""
     def __init__(self):
         self.messages = []
-        logging.Handler.__init__(self, logging.WARNING)
+        self.records = []
+        logging.Handler.__init__(self, bb.msg.BBLogFormatter.WARNONCE)
     def emit(self, record):
         self.messages.append(bb.build.logformatter.format(record))
+        self.records.append((record.levelno, record.getMessage()))
     def contains(self, message):
         return (message in self.messages)
 

-- 
2.47.3

