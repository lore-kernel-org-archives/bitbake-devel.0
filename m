Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0360EC61DE0
	for <webhook@archiver.kernel.org>; Fri, 28 Aug 2026 15:59:57 +0000 (UTC)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4134.1787932787026584300
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Aug 2026 08:59:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=QuXcRA1Q;
 spf=pass (domain: gmail.com, ip: 209.85.210.49, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7f3ece23165so1346233a34.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 28 Aug 2026 08:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787932786; x=1788537586; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3fYbe3oErlV0YggmLkEPdbvl0hPmAFAJegxZ6Vj/yjo=;
        b=QuXcRA1QDifAPRqqrXQa/KnGQsw5jSKlXYRS/4Rn3yVVnpDCYL1eCYfKbKm1SEuFow
         kOHpcavb3oLUTsZpRTgNVx/tGlhpYkIvU4pQ/GDovm+dyyAldUj82OHfK+56FZjBGLSn
         69FI3laFS54e5MqyDeQW5x++LnyPT8USy9XX+Dr6oIrQnfTZNvXGDWG9Fzxi1xJFCAfM
         fhpl0a9bQB0aBILaXikS76b74ojDEuhBa+WMMUOzdFcmcL/pocSiNArOczNDtktVGGKG
         BvIPuSXwXW5ovQY/inyObrF3hAVA5V8DDgSd3cJWEvRFMSOoT7KuJRF3zG8Rqm0vAOrU
         9nJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787932786; x=1788537586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3fYbe3oErlV0YggmLkEPdbvl0hPmAFAJegxZ6Vj/yjo=;
        b=Gy4y9yHpjrO/jStT74AGl64TCWZMtgdlaR8GPqx457Z9yxXbB04ouRzN7uqQOSy5G+
         EccPGL4pIsdu2dMJGnVHtam/iRTQfR4v3dCfns/WFXDjurwaN7V9Of/H7CEYqnFnsD4M
         zbFquNvjwYa1jI9zwxPka1IKggjQWq5MMxgBD4FhiKJ+Am6vh98My1F5ibkDyJkzSjsg
         2YYcja3Fc8czm26sbXxh8AXn7cvsW+PDreDftyNn/4im+Cwp3fjGQwz8SqZSNIBcm4Uo
         wMzjbLzggwEVhL7yUJMeOZO98+BQCrD0nq0ScGjM3OUbWlbtHqFjjNpSAH2kwScwEOsM
         J6TQ==
X-Gm-Message-State: AFuF++lAqxnj+sKNnG9HwFAi2vzUihGXRQyJXZCnlcVUrv9AG/gWbnVC
	ViOsc4HL4SFFKtCjqX8i+k6ZXiAPehZ2jS3cKQLZC9WYf0oHKoDB+q5hF/D1LQ==
X-Gm-Gg: AR+sD13Kh1HqRQEUExx51mJgwi5i2/ak8VSb6UjQtlOTm9/IishoTvfI7uO7yvmvWOq
	XV3981EYoiioeeXT/d6vj+tKJ6Od3Aq3eZ3La93mx5p+W6gPagklEGX0w/aB0jXvL13L3YHtWbX
	ZBxQa/6KSq5YsUilXcm8x83x/wLnXaoYQbCj2gkSyMrL/R24IYEJ+nzu/qtiXDzHNsnLvgRjfyf
	XFWlqFo9EfJS9zmLMUuJzGkeMJVGEenSsNS38jQQwtqlEw4HIQXmxbnhY5DOmxc2VxMpDewJe8F
	dPtDHXqyM7VFjcNjI/8/fUWmATwxYsHKEwFzs8eM7fE0zW1mMkJx/9IYj1etyXRVMzL4Ym8bNgQ
	tDOxaiWUDHOERSyZ0m/XSsI8I5Xx0rtMOYcA/iJt2DGU3lQgrIpWG08VyZgWuoBL8MefeoZXjUT
	1wFZIggXVFf7v0HSQCzaHelF5ZF/cU/6BoT+Xk/OYJOkk/79EUhbvNWBVGioD6kic/AZkI
X-Received: by 2002:a05:6830:230c:b0:7e6:f2dd:93c3 with SMTP id 46e09a7af769-7f4f24e3adbmr8422055a34.15.1787932785886;
        Fri, 28 Aug 2026 08:59:45 -0700 (PDT)
Received: from localhost.localdomain ([2601:283:4b01:ba50::50d4])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f4fa96ce0dsm1506165a34.13.2026.08.28.08.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 08:59:45 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v3 01/11] asyncrpc: Add Task Group
Date: Fri, 28 Aug 2026 09:58:08 -0600
Message-ID: <20260828155942.1219468-2-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828155942.1219468-1-JPEWhacker@gmail.com>
References: <20260730183254.793698-1-JPEWhacker@gmail.com>
 <20260828155942.1219468-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 28 Aug 2026 15:59:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20107

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
2.55.0


