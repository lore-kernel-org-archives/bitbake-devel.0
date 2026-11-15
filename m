Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5871.1794742428939566346
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 15 Nov 2026 03:33:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=AeEoDy4z;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 424F11A1670
	for <bitbake-devel@lists.openembedded.org>; Sun, 15 Nov 2026 11:33:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 18CA660238
	for <bitbake-devel@lists.openembedded.org>; Sun, 15 Nov 2026 11:33:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 376DD11BC0C78;
	Sun, 15 Nov 2026 12:33:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794742426; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=BPI1boXRsi+aaNwyctXWaDwj3Y5vNjyk2HPL4DgItFE=;
	b=AeEoDy4zgGpdG6MIn3MSiQQS+chZm7KiDD54lZC6iwFsX4S5cH+g7c81DwQDfYmhMDlLK3
	/DdvPqvI0RU7/jDf2ymq4RIVOoTLU5B+qpUD6nAooULMrXocaMMaDVcOrJb+tCZp8lidDy
	3/APqtHtHn2cA5Ht6SsgIkzSj0OW6b7gcQFNvhsK+S9jH4SVT2YEh1zmGQZROw92GEHgVl
	sHIGq3sC6Dc3J4FNGG3MeO8BnWtk0y6xMk3ZCoGFfULUeU/Rdd8Z70rBuGP7hEqVHYtnM2
	0e2GsLyCGObIZ+6SoDfsUBUuO+IqxHkzdyO+uAhzljbh/niML4sCXb4jpK8Ehg==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Sun, 15 Nov 2026 12:33:39 +0100
Subject: [PATCH RFC v2 1/3] utils: Extend LogCatcher to record raw messages
 and levels
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261115-mathieu-debug-replay-v4-v2-1-ad7d3c5cc213@bootlin.com>
References: <20261115-mathieu-debug-replay-v4-v2-0-ad7d3c5cc213@bootlin.com>
In-Reply-To: <20261115-mathieu-debug-replay-v4-v2-0-ad7d3c5cc213@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794742425; l=3537;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=zn4aA6JzVFz39faIO4Fd9j6OZcfvz5Am6gIM0CJdChI=;
 b=/mBYp1gVBwCqg0CvGunSUZrU4Krez+mImOhBjBjGinV7TmDbFZFqBNNmHuCYeqDQkXAM6vcm+
 kzyEAgEP3ZKDlir6wjc5zSrm3iAAas5P3TSAYuFtC6k0Q6mXC6ZhmWr
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Sun, 15 Nov 2026 11:33:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20434

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

