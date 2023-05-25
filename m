Return-Path: <michalwsieron@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EF0C77B7E
	for <webhook@archiver.kernel.org>; Thu, 25 May 2023 10:21:28 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
 by mx.groups.io with SMTP id smtpd.web11.8360.1685010078472591987
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 25 May 2023 03:21:18 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@gmail.com header.s=20221208 header.b=eZ9io5da;
 spf=pass (domain: gmail.com, ip: 209.85.218.50, mailfrom: michalwsieron@gmail.com)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-97000a039b2so77292766b.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 25 May 2023 03:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685010077; x=1687602077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7PAzFDRCTl01gKJLFGjXzFUUJPNy/gtcy2mQfBLs2kM=;
        b=eZ9io5da+zwB3sdBO7Lq7PILzIQJy51s+CWWqO0cfnKZy5E3yQ8RfqBZQCJRXr7Y8C
         lHBnnqhl2i40xRjEsKaFr4uCafOc0wtoT9H1qveDWdIUo7q8xsQjjP1ExYWGqtacKo7j
         W/Ve5yrq66rGERM3/h5rP8OZm+gcq9fVuy2wWgSFcxUIHwDUviF5eUw3bDZ0ELNDPHbs
         IqGcMB4a5xa8zipCz7IuGsI+l9XCd1aGKZFUhiPxWJILx8RaaFY1+pos0Ep45toWW7fK
         3l5gZalBskyfzf9ZgDT7UUHjs9BUfab2v+bPzaoWQjwP/PsSc4xw5awSfuwDV5O042F7
         Szbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685010077; x=1687602077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7PAzFDRCTl01gKJLFGjXzFUUJPNy/gtcy2mQfBLs2kM=;
        b=IVGAXvCLzaptH9Oz+R49XOxRPfoswho0ZD92oB/7uVMAciQu2ftMxH9FBjVCezQiT/
         Bb5rXZ1HHl1xGARRHP/SQIGFgZwOf6ggQmD8be+7bG9Q/hkU6tUmWwVlyJ5N5vk8OpOq
         i6IBK8eVwDQuEqoaX6g3gO3ZGN0Gf9YkPg8E0X+1o150KD9hRDTjmgtaXND6WhUZUfJc
         UxKOAongbXIQqmjCadEehJgfmvm5cYuu0iko5bbAg/EvKzffc2H6YHwPQPhEEhjwwcIL
         NGVpF928Kh/w7KR7gkxRnawDokKCGbXpF8jhEs3WKfvXJtZrQCXjSHNZBmJu+7nLPR+6
         zWSg==
X-Gm-Message-State: AC+VfDyvKw8Wcod9M4eaEoC2ru/u46NQfj5Ngz121DvZR6WKRHKsqUrX
	wfJc5D/Fe56VOsUh9QizrQO28kvDKepH/YsMjxxrlw==
X-Google-Smtp-Source: ACHHUZ4UBQ50hH6AQyrAzgWaZSgWjPOFVFjDpePBKWZQzSnbcHiVXPoQL7tnv6Fd5COjBeXCDR0Bcg==
X-Received: by 2002:a17:907:97cc:b0:965:f8b7:b0cd with SMTP id js12-20020a17090797cc00b00965f8b7b0cdmr1243314ejc.25.1685010076582;
        Thu, 25 May 2023 03:21:16 -0700 (PDT)
Received: from elitebook.emea.nsn-net.net (77-254-244-102.adsl.inetia.pl. [77.254.244.102])
        by smtp.gmail.com with ESMTPSA id rv3-20020a17090710c300b0096f7b7b6f11sm649299ejb.106.2023.05.25.03.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 03:21:16 -0700 (PDT)
From: Michal Sieron <michalwsieron@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Michal Sieron <michalwsieron@gmail.com>,
	Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>,
	Mateusz Marciniec <mateuszmar2@gmail.com>
Subject: [PATCH] bitbake: Add task timeout support
Date: Thu, 25 May 2023 12:21:05 +0200
Message-Id: <20230525102105.1480610-1-michalwsieron@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 25 May 2023 10:21:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14806

By setting `BB_TASK_TIMEOUT` you can control timeout of for tasks.
Using flags `BB_TASK_TIMEOUT[do_mytask]` you can override timeout
settings for specific tasks.

This is especially useful when some server doesn't work properly and
`do_fetch` task takes too long. We may want to kill it early instead
of waiting for a fetch that won't happen.

Signed-off-by: Michal Sieron <michalwsieron@gmail.com>
Signed-off-by: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
Signed-off-by: Mateusz Marciniec <mateuszmar2@gmail.com>
---
 .../bitbake-user-manual-ref-variables.rst     |  7 +++
 bitbake/lib/bb/build.py                       | 43 ++++++++++++++++++-
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 01d4f8d14a..eaaa307960 100644
--- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -686,6 +686,13 @@ overview of their function and contents.
       in images is given a higher priority as compared to build tasks to
       ensure that images do not suffer timeouts on loaded systems.
 
+   :term:`BB_TASK_TIMEOUT`
+      Specifies time after which still running tasks will be terminated.
+
+      Time is provided as an integer number of seconds.
+      You can set timeout for specific task using ``BB_TASK_TIMEOUT[do_mytask]``.
+      To remove timeout use an empty value ``BB_TASK_TIMEOUT = ""``.
+
    :term:`BB_TASKHASH`
       Within an executing task, this variable holds the hash of the task as
       returned by the currently enabled signature generator.
diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index 44d08f5c55..2057dd9415 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -17,6 +17,7 @@ import sys
 import logging
 import glob
 import itertools
+import multiprocessing
 import time
 import re
 import stat
@@ -594,7 +595,7 @@ def _task_data(fn, task, d):
     bb.data.expandKeys(localdata)
     return localdata
 
-def _exec_task(fn, task, d, quieterr):
+def __exec_task(fn, task, d, quieterr):
     """Execute a BB 'task'
 
     Execution of a task involves a bit more setup than executing a function,
@@ -761,6 +762,46 @@ def _exec_task(fn, task, d, quieterr):
 
     return 0
 
+def get_task_timeout(d, task):
+    # task specific timeout
+    timeout = d.getVarFlag("BB_TASK_TIMEOUT", task)
+
+    if timeout is None:
+        # any task timeout
+        timeout = d.getVar("BB_TASK_TIMEOUT")
+
+    if timeout is None or timeout == "":
+        return None
+    else:
+        try:
+            return int(timeout)
+        except ValueError as e:
+            raise ValueError("invalid `BB_TASK_TIMEOUT` value '%s'" % timeout)
+
+def _exec_task(fn, task, d, quieterr):
+    """Intermediate function between exec_task and __exec_task, to support task timeouts."""
+
+    def targetFunc(func):
+        def inner(*args, **kwargs):
+            sys.exit(func(*args, **kwargs))
+
+        return inner
+
+    try:
+        timeout = get_task_timeout(d, task)
+    except ValueError as e:
+        logger.error("%s: %s" % (d.getVar("PF"), e.args[0]))
+        return 1
+
+    task_proc = multiprocessing.Process(target=targetFunc(__exec_task), args=(fn, task, d, quieterr))
+    task_proc.start()
+    task_proc.join(timeout)
+    if task_proc.exitcode is None:
+        logger.error("timeout exceeded (%s s)" % (str(timeout)))
+        return 1
+    else:
+        return task_proc.exitcode
+
 def exec_task(fn, task, d, profile = False):
     try:
         quieterr = False
-- 
2.40.1


