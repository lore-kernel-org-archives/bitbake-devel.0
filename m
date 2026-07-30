Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0968CC55179
	for <webhook@archiver.kernel.org>; Thu, 30 Jul 2026 18:33:07 +0000 (UTC)
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18453.1785436377875696463
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Jul 2026 11:32:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=V0ar03f8;
 spf=pass (domain: gmail.com, ip: 209.85.167.177, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4a456e44e01so109744b6e.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 30 Jul 2026 11:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785436377; x=1786041177; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dIIcAB25BFKFt5slf26rijE6SlRoyuK/mAAVE1tb+Wk=;
        b=V0ar03f8HmMNeJMChXEmrO2ozy02iPptm8sv4v70ykH+WaeozAl6gzio4oYdQ1DfDn
         O4k+WhPoGLZwpWa/zc4TQQQXvVNZFNBPRcUNNQV1IzVDzmoY9PcheoKLiMNxhXbu0qEB
         Tkb2uopAwesuzauOVLsCMSIlZLouFwhokBep+5Ra42e1oZN2Rou2CLUghjIm8EZmD4Ki
         d3+0Gak6DWxkybUlnU65f/8fxPSEL8dM+MOM8aAS2wW68uAGF60LNVr60Z0Mg2NFQEQI
         uaDBlgJ+ASwLhmL0nBhy9AA4XTwLzj1oNpKJSNlGkm5sXm5aUq3aW0rYikwTNem+yQQs
         25yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785436377; x=1786041177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dIIcAB25BFKFt5slf26rijE6SlRoyuK/mAAVE1tb+Wk=;
        b=cqFLSd41R/FGwztmSoUmjfVa60Loo6UIx0K73K6CxyGdEdkLqlmklYVOVccRx2JPwY
         3JwsQlJWEp1o4mQuXdjaJkt+QOM9yhNeO9PKS8rQEA65GTJzYkDOe46yC5Ig94ZRRHC+
         goItt0+kCgnCu3SBW0aelyfenbHFjmJF2863W81q/y54+e6lImkkcrPIda6Isq49Zuvg
         w4GPNCfldmrgkkAoLvi2RCmduQ6tR89QqQuaJv8nYoNbwTOAgx/3FEJ63di3A6Mq/oZd
         iju4OP/kHnOarRPS1Cc+W4ptYpg9tmEL16y5wgaRigUng60cArw1dOeD4nHk3mqdo1II
         Ihdg==
X-Gm-Message-State: AOJu0Yw7Arf8GFbCEJXdKU1TqBXcHtOujBlSVmzPQDoOCz+ytkdbd6tV
	0FW0WxnSRvYT0vw5EX4n08iB7suHVtExCwaVuZmehNR7PF+xJl07dR8Gfpg85w==
X-Gm-Gg: AR+sD13QMO+ONL8yUYpCBT5fUN6H5DCBAWd8h6FIotBx4jLi67AAkYhlc19yKvIr30x
	CLuMTISZ5lidHHySWONI4hjPYNsapnquUpt2A4HJfWEpawDIBp+7u8EM8SaRY9bJniKDaEPrqQu
	AGRTmXXEUwz3sfTFEEvIrllhxXrkI0D0xTEs18wJ5pknnEv6JL97mFSf46yIBi7QwUaefzkveoM
	urkkI5f+hvI2bZxQbb8hZ/c/iPqt3CRwyKqCqakUfBdiv3BfJ1crBh4vDVkgY9dCZKoQAPKmLF+
	sq8Qc3KkGPE1vYuwxk80r8Ht3qnqHeKH5OzUMf6J+iSLNsk9afx32S3TvEMlKyXu/CEWlPi62JB
	hnN9IyEJFnaIW/0HrSek90W5n4IbsDv2QgDLZETGpb/x4B6Xhsw+loj4GixMiOCzQTInGgkliBp
	9IGDumWsrDpAP8dL+KA+03RyIKHvEedm4tOD3HKrVYm8ZLaflJK6sdVpCZiQ==
X-Received: by 2002:a05:6808:1687:b0:4a4:ed9a:e790 with SMTP id 5614622812f47-4ad9533b9b2mr1399100b6e.29.1785436376875;
        Thu, 30 Jul 2026 11:32:56 -0700 (PDT)
Received: from localhost.localdomain ([2601:283:4b02:22d0::10c9])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ad6efc5c3fsm4593047b6e.13.2026.07.30.11.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 11:32:56 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v2 01/10] asyncrpc: Add Task Group
Date: Thu, 30 Jul 2026 12:30:54 -0600
Message-ID: <20260730183254.793698-2-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730183254.793698-1-JPEWhacker@gmail.com>
References: <20260724212822.1165552-1-JPEWhacker@gmail.com>
 <20260730183254.793698-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 30 Jul 2026 18:33:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19881

Adds a Task Group object which can be used to manage multiple
asynchronous tasks and correctly cancel them if an exception is raised

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 lib/bb/asyncrpc/__init__.py  |  1 +
 lib/bb/asyncrpc/taskgroup.py | 52 ++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 lib/bb/asyncrpc/taskgroup.py

diff --git a/lib/bb/asyncrpc/__init__.py b/lib/bb/asyncrpc/__init__.py
index a4371643d..2f0956dfa 100644
--- a/lib/bb/asyncrpc/__init__.py
+++ b/lib/bb/asyncrpc/__init__.py
@@ -14,3 +14,4 @@ from .exceptions import (
     ConnectionClosedError,
     InvokeError,
 )
+from .taskgroup import TaskGroup
diff --git a/lib/bb/asyncrpc/taskgroup.py b/lib/bb/asyncrpc/taskgroup.py
new file mode 100644
index 000000000..b61f40385
--- /dev/null
+++ b/lib/bb/asyncrpc/taskgroup.py
@@ -0,0 +1,52 @@
+#
+# Copyright BitBake Contributors
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+import asyncio
+import logging
+
+logger = logging.getLogger("asyncio.TaskGroup")
+
+
+class TaskGroup(object):
+    def __init__(self):
+        self._tasks = []
+
+    def create_task(self, coro, **kwargs):
+        self._tasks.append(asyncio.create_task(coro, **kwargs))
+
+    async def __aenter__(self):
+        return self
+
+    async def __aexit__(self, exc_type, exc, tb):
+        try:
+            if exc is None:
+                while self._tasks:
+                    done, pending = await asyncio.wait(
+                        self._tasks, return_when=asyncio.FIRST_COMPLETED
+                    )
+                    self._tasks = pending
+
+                    for t in done:
+                        try:
+                            await t
+                        except asyncio.CancelledError:
+                            pass
+
+        finally:
+            for t in self._tasks:
+                t.cancel()
+                try:
+                    await t
+                except:
+                    # Ignore exceptions
+                    pass
+
+        return False
+
+    @classmethod
+    async def run(cls, *coros):
+        async with cls() as group:
+            for c in coros:
+                group.create_task(c)
-- 
2.54.0


