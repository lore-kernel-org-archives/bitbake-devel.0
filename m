Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id AE42972D64
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 May 2015 16:33:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t4RGXUf3024950 for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 May 2015 17:33:30 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id VNTg4tzYTCMS for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 May 2015 17:33:30 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t4RGXGdN024947
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 May 2015 17:33:27 +0100
Message-ID: <1432744396.404.52.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 27 May 2015 17:33:16 +0100
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Subject: [PATCH v2] tests/data: Add log parsing test code
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
X-List-Received-Date: Wed, 27 May 2015 16:33:30 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This allows us to write tests which ensure a particular action generates
a particular log message.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/tests/data.py b/bitbake/lib/bb/tests/data.py
index 7994a88..b4fd2c5 100644
--- a/bitbake/lib/bb/tests/data.py
+++ b/bitbake/lib/bb/tests/data.py
@@ -24,6 +24,30 @@ import unittest
 import bb
 import bb.data
 import bb.parse
+import logging
+
+class LogRecord():
+    def __enter__(self):
+        logs = []
+        class LogHandler(logging.Handler):
+            def emit(self, record):
+                logs.append(record)
+        logger = logging.getLogger("BitBake")
+        handler = LogHandler()
+        self.handler = handler
+        logger.addHandler(handler)
+        return logs
+    def __exit__(self, type, value, traceback):
+        logger = logging.getLogger("BitBake")
+        logger.removeHandler(self.handler)
+        return
+
+def LogContains(item, logs):
+    for l in logs:
+        m = l.getMessage()
+        if item in m:
+            return True
+    return False
 
 class DataExpansions(unittest.TestCase):
     def setUp(self):



