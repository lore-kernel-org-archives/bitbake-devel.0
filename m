Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83992C83F25
	for <webhook@archiver.kernel.org>; Mon, 21 Jul 2025 19:41:45 +0000 (UTC)
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
 by mx.groups.io with SMTP id smtpd.web10.50732.1753126900247883744
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 21 Jul 2025 12:41:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=HzG0OXCt;
 spf=pass (domain: gmail.com, ip: 209.85.160.42, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-302fdd379faso720118fac.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 21 Jul 2025 12:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753126899; x=1753731699; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cnfWsob/l3Ls4fNBf0tGuvWoIF4w4ZRop87Xn0fD3Zg=;
        b=HzG0OXCt960FzuoFcBrvx1HN7/peQNZyOPipDLEQ4tPclSCDFWvqpI0pja47He1/Z4
         6rj2aqbNo+xINF/5vYGMY7/+MJnJToIVLtHnsimwEl5gnc7uLDezuhgTs4ofyDi0+q+N
         QdT0V+iKPMwAnG3Q5AAsYLWa4o12mzrPcQkuycIkimoU5hzsz3jCadxtVe+/8IZ0CCNu
         7allAyYP9ZskC68hxVdrhG+LRw6ZqR34lw+edtg4m0m0Jlupb31udUe7hvxA4jeNsCpu
         RuFpS5CX53FhOu8BIRQaIrWYVLQOSg8huwInV5+Me4UuE7AsZ9eeYHVESR5zUMHfgzUh
         ASXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753126899; x=1753731699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cnfWsob/l3Ls4fNBf0tGuvWoIF4w4ZRop87Xn0fD3Zg=;
        b=TPSwtFXAKRz50bBI6yRjhjoUIr5kFFL4pJm1xavua0du/Z8P6yhIS9gDx+kLp3oGA9
         kkdKT4SxNl9WRXj+Cpcs+Og22BirW7Jrky/6MLk0zQP6LYutslQ1dVyt8PQ8gwCmqreg
         EYpiRWIjWfH4rG57WzWgfg53SrFgmUKIBT8sc+WcTu2Le/OVyFdhlWQ9GqfqQuqpHMPP
         C1/5i1zAu2ovZox4Xkp46lT5D3hkarCMn5qV5VQfHgAIL6w73RTtZIG+Nkz3D35JSVmG
         uVU95aVr6utFohfpyTJX7FBTmzEtmaPkO+L7VVOksS6mFwpkkXi06F8PJfHx4xF2uFJj
         w7pA==
X-Gm-Message-State: AOJu0YziFbvHK3S3lYA7twkGQKeVSeqKUVRhV/g+tlnaw2RSQqbQuWNh
	XASDoQFrN8sYiNQh81FEAI3WGzfV8pGDYIcpp8o/brUoNqAq7GeA3w34Hrn+IA==
X-Gm-Gg: ASbGncusa7Cx0feBf6TkCLIxdwKHb9XLqX4hjlr1TLtrW6roTHCztiQkEj3bBRTYXKB
	Ydb/osnviTHGRLqx4nYoDOZsSI5cTVziDZFnIOQJSmStxcheF5Rqce1w+atgfDT7RB1yJvNGEjE
	VJI51fg3gienRPCelUFcGcqqkIpafZvuVvoDZ01IYCc/1V3pe5fMcE5GZfec2FefpClZW857fU9
	sHLtvH/cl/u/yBFiLB4kIkEkoGV5IvxO6AwJFl6vWkEsc+/PREp7USYTqdNoDSDV42rpIy86hHQ
	ujWdPUh4n8foRSBy2Mrw5DMVB+1wYsO4sl57TCoxfKE6pABAYtWFJTAiUOtWVUrQ8ZOJNZsSom1
	ciK9csksmd1MNRh/iOgGOBVrTk9I341I=
X-Google-Smtp-Source: AGHT+IEHkeUCzXhqdSo+v3Rgo2S/55qnJolGJ02WUVeYrr3tVgF3v07LmSmXSMD71rO/sYCHpMB3yw==
X-Received: by 2002:a05:6871:bc05:b0:2f7:840d:fe9 with SMTP id 586e51a60fabf-2ffb244a6damr17548896fac.22.1753126898778;
        Mon, 21 Jul 2025 12:41:38 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::bc4c])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-30101cd81b0sm3881373fac.16.2025.07.21.12.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 12:41:38 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] utils: Remove multiprocessingpool
Date: Mon, 21 Jul 2025 13:41:35 -0600
Message-ID: <20250721194135.883763-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 21 Jul 2025 19:41:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17801

This API is no longer used and bitbake has moved beyond Python 2.7.3 as
the minimum version, so remove it.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/utils.py | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index 6afc4be34d7..52fd3360268 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -1465,22 +1465,6 @@ def process_profilelog(fn, pout = None):
 
         pout.flush()
 
-#
-# Was present to work around multiprocessing pool bugs in python < 2.7.3
-#
-def multiprocessingpool(*args, **kwargs):
-
-    #multiprocessing.util.log_to_stderr(10)
-    # Deal with a multiprocessing bug where signals to the processes would be delayed until the work
-    # completes. Putting in a timeout means the signals (like SIGINT/SIGTERM) get processed.
-    def wrapper(func):
-        def wrap(self, timeout=None):
-            return func(self, timeout=timeout if timeout is not None else 1e100)
-        return wrap
-    multiprocessing.pool.IMapIterator.next = wrapper(multiprocessing.pool.IMapIterator.next)
-
-    return multiprocessing.Pool(*args, **kwargs)
-
 def exec_flat_python_func(func, *args, **kwargs):
     """Execute a flat python function (defined with ``def funcname(args): ...``)
 
-- 
2.49.0


