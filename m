Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33680C433F5
	for <webhook@archiver.kernel.org>; Tue, 29 Mar 2022 15:04:28 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web10.7946.1648566267280492288
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Mar 2022 08:04:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=E8lH1R2q;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id q20so10517707wmq.1
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Mar 2022 08:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CT5Pcj7KAapxLzCFmMvVoAF1aVI+eCWdPgq0tizzv4Y=;
        b=E8lH1R2qnQeqPicy5H1qKCm0d8UevlVVuIgNUVEZXBq/pfx0vv01OvZF+nw7xyz/BT
         66fb1dbHeS3W3+y/ZdfCz+OI26I7Xn3HSxL2U4xEu7iB4TeQjkx82ctaJ0Ip4IofWmgB
         d1wtfwreDyB9fb3PIVXWZ2Op/TA8arQTcW+AY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CT5Pcj7KAapxLzCFmMvVoAF1aVI+eCWdPgq0tizzv4Y=;
        b=of6VuCZ7dmT9L6ot7EuL+bs9VeF1vUPsXQsI4vzRJwLQeJ1nZUhDMb2CWGf+vMuCo6
         DyLQ/6V8y+zh1nioD3n8cXtPuai5w1NeeWjaNosG1S4nnee88zHglx7vpkM2zy2H28yI
         Yu4XNdRYBd4gTKY1uFX33YC2rlTy3XuIcUie61dYx9Zx51xas4ycwRIIN5ldVo1Q6eTD
         jTkYJAh1E4/fticGuPxsgdMhxI1yTUUmDcYqYrHcW316sJJPRU/j/jY08xbc6aN3SDLR
         Wp+mHQeGfVfl0T8NYCvx/W/68K8NSUEUojMa2HbwzTz6ew1m5kw+KtkLU91T1X/Zzr/4
         vJFw==
X-Gm-Message-State: AOAM530DSG2gXcaE4uN7rSztoshDo+CkyKRyvi+RbfJXRkRh9jfsOtiB
	CZEZLRby+5khCFOEguDE8VVMTuMqaLVbow9Z
X-Google-Smtp-Source: 
 ABdhPJz209TX4dRwO4BlkXJkOGsBFfRPTU4KZ6Jvff3MprOAZNj0yKdCivhyN5PuD34xHBvkwQIb9g==
X-Received: by 2002:a05:600c:1909:b0:38c:e8f3:8e3d with SMTP id
 j9-20020a05600c190900b0038ce8f38e3dmr90175wmq.152.1648566265215;
        Tue, 29 Mar 2022 08:04:25 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:a144:3266:4a07:b254])
        by smtp.gmail.com with ESMTPSA id
 bj26-20020a0560001e1a00b0020597757ebcsm14022933wrb.7.2022.03.29.08.04.24
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 08:04:24 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] build: Add missing parameter to TaskInvalid
Date: Tue, 29 Mar 2022 16:04:23 +0100
Message-Id: <20220329150423.1477640-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 29 Mar 2022 15:04:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13548

Fixes:

File "bitbake/lib/bb/build.py", line 585, in _exec_task
  event.fire(TaskInvalid(task, d), d)
TypeError: __init__() missing 1 required positional argument: 'metadata'

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/build.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 65b7fc000d..af60c3d8f5 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -582,7 +582,7 @@ def _exec_task(fn, task, d, quieterr):
     running it with its own local metadata, and with some useful variables set.
     """
     if not d.getVarFlag(task, 'task', False):
-        event.fire(TaskInvalid(task, d), d)
+        event.fire(TaskInvalid(task, fn, d), d)
         logger.error("No such task: %s" % task)
         return 1
 
-- 
2.32.0


