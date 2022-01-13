Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DB2C433FE
	for <webhook@archiver.kernel.org>; Thu, 13 Jan 2022 14:10:32 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web09.9211.1642083030940078748
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Jan 2022 06:10:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=lvqNm0Mo;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.42,
 mailfrom: steve@sakoman.com)
Received: by mail-pj1-f42.google.com with SMTP id
 a1-20020a17090a688100b001b3fd52338eso10225828pjd.1
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Jan 2022 06:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mBx3dtMAJGoUa6MvhfdP0W0DmM1X8iuzdo9J1FvJ1n4=;
        b=lvqNm0MoijYrXF5XgRhAHnWdYd3MzdY4qkAtYDyPhbKy46UypzASrLt/robnj/E6u0
         jMjYkqYHMzO6IcawsGTFJHCG9aHJwPiXO1XD6ySEQWSGw4/LUtG4ABKlry1aGw2evZCh
         RMQqiTkg1EIFNi613oZMdQxdIYW1GxD9K4O0joCs0JQlapF7wgNtbDmc9tjWsHGPO65r
         xWUIjOu8yfAQQ21YZIZ52C4MeAyttRoo9G7i8oY48cRdOy0ZA1L80VNIIBiBWQXHg3wX
         vyHQyRkL4qBwywuCvEc0bfjNtEQfmyZDMx+95XSR4dPSXjYvYHnSSTa5yR8RSf+x0dqg
         lB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mBx3dtMAJGoUa6MvhfdP0W0DmM1X8iuzdo9J1FvJ1n4=;
        b=8OTciFSPvdatkdEF7dV6Y+aMUXMmyWnErqLbaqh/4edgfXVtzzmTIzu9LkQ29AYZwm
         mj5kCPo3CtxD01VC+ZdKLMF5rcjjI1HGmoURVIxpCpkYByARTC53whs9tR3+NNMvMmzp
         zIl1LXu/QrGGoUux4/gw+Jdf/bl+gTfWFAUVBzF7s/Gr46TgEL8jK4Pej4jYH54OehfA
         bBlQ2BpOj0YCazdyiJhTHxfVm9owygSj49WnffrWO1SfKxE+UCsUPchuYrd69LOmTlXZ
         W68CcbCsSf7JKuWRrpKzZNqthQ4yktHHIeybZsDKVXtkNvinkR7huVlbYVkfoCLIwXQz
         r4+A==
X-Gm-Message-State: AOAM530+Ekizy4NBskpUYe+wBHgcQUd8jaPEmqhdfwJgHeY+4ViiGO4c
	pPBE3u1lYXmv/xayGSLd1hcTv8svDWKliBcuL/4=
X-Google-Smtp-Source: 
 ABdhPJy/GnpRHwBMnnjHLsP1uo2tu1g4RMxQkWsDlqOc5lpBES4SzR0fyGmw+D/L63XVkH/HdAeaiA==
X-Received: by 2002:a63:7906:: with SMTP id u6mr4047129pgc.28.1642083029946;
        Thu, 13 Jan 2022 06:10:29 -0800 (PST)
Received: from hexa.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com.
 [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id
 go19sm8521033pjb.25.2022.01.13.06.10.28
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 06:10:29 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 1/2] utils: Update to use
 exec_module() instead of load_module()
Date: Thu, 13 Jan 2022 04:10:13 -1000
Message-Id: 
 <50aab1b733bc37c8f8c5517cc45bbfda24e8598c.1642082551.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1642082551.git.steve@sakoman.com>
References: <cover.1642082551.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Jan 2022 14:10:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13231

From: Richard Purdie <richard.purdie@linuxfoundation.org>

This is deprecated in python 3.12 and Fedora 35 is throwing warnings so
move to the new functions.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 68a18fbcb5959e334cf307d7fa8dc63832edb942)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/utils.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 5f5767c1..fab16ffc 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -16,7 +16,8 @@ import bb.msg
 import multiprocessing
 import fcntl
 import importlib
-from importlib import machinery
+import importlib.machinery
+import importlib.util
 import itertools
 import subprocess
 import glob
@@ -1584,7 +1585,9 @@ def load_plugins(logger, plugins, pluginpath):
         logger.debug(1, 'Loading plugin %s' % name)
         spec = importlib.machinery.PathFinder.find_spec(name, path=[pluginpath] )
         if spec:
-            return spec.loader.load_module()
+            mod = importlib.util.module_from_spec(spec)
+            spec.loader.exec_module(mod)
+            return mod
 
     logger.debug(1, 'Loading plugins from %s...' % pluginpath)
 
-- 
2.25.1


