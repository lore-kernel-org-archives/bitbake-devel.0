Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF22C433F5
	for <webhook@archiver.kernel.org>; Sat, 26 Mar 2022 05:22:02 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web11.629.1648272120503718275
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 25 Mar 2022 22:22:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=Y1DpHn6B;
 spf=pass (domain: axis.com, ip: 195.60.68.17,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1648272121;
  x=1679808121;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5igoMJTPmbZ/CnQd7PR9tl1nOqW8OQ9EraREJreCm1g=;
  b=Y1DpHn6BBRaoSN7cXtrQTLj6X4iYGen7AFD7/XLa6IPjEei5uIMIAWrQ
   Qts4gtBBEJYMde6+OYjVCUkOGB76L6AKXfMFmCkRco9YAGK0HzVvVy1qt
   xdQ6l6176JvHKuK5elRtG3puFu/KmWrDBKKs8514Ogp4kNCEm6JSkbO3R
   Z/fjb8vN0n5WO+CLwSdwINf4XHmj+36fPYptqE1hWT2aMgjXFPLsQqWIG
   dClH+M48SannzS0umcSinlHm4hTnUxVgkQ/dNlBm44OclhOHvjrtdRLSf
   FgJoZX3hdWuQyPTvgAXKF8c/4BQdxn4RgYZ4uV8e+YkswxiEa+IRXoU51
   Q==;
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [RFC][PATCH] server/process: Avoid hanging if a parser process is
 terminated
Date: Sat, 26 Mar 2022 06:21:55 +0100
Message-ID: <20220326052155.7659-1-pkj@axis.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 26 Mar 2022 05:22:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13511

If a parser process is terminated while holding a write lock, then it
will lead to a deadlock (see
https://docs.python.org/3/library/multiprocessing.html#multiprocessing.Process.terminate).

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---

After the discussion on IRC about the hanging parsing processes, I
just had to understand the code and what happens. This is a solution to
the problem, though I am not sure it is THE solution. It may also be
that the rlock in ConnectionReader should be handled the same way.
Anyway, even if this is not accepted as a solution to the problem, I now
at least know a lot more about how the parsing processes in bitbake
work... :)

 bitbake/lib/bb/server/process.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/bitbake/lib/bb/server/process.py b/bitbake/lib/bb/server/process.py
index 1636616660..544b00f2cd 100644
--- a/bitbake/lib/bb/server/process.py
+++ b/bitbake/lib/bb/server/process.py
@@ -20,6 +20,7 @@ import os
 import sys
 import time
 import select
+import signal
 import socket
 import subprocess
 import errno
@@ -728,6 +729,10 @@ class ConnectionReader(object):
     def close(self):
         return self.reader.close()
 
+terminated = False
+def catch_sigterm(signum, frame):
+    global terminated
+    terminated = True
 
 class ConnectionWriter(object):
 
@@ -739,8 +744,12 @@ class ConnectionWriter(object):
 
     def send(self, obj):
         obj = multiprocessing.reduction.ForkingPickler.dumps(obj)
+        oldsig = signal.signal(signal.SIGTERM, catch_sigterm)
         with self.wlock:
             self.writer.send_bytes(obj)
+        signal.signal(signal.SIGTERM, oldsig)
+        if terminated:
+            os.kill(os.getpid(), signal.SIGTERM)
 
     def fileno(self):
         return self.writer.fileno()

