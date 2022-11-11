Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77CCC4332F
	for <webhook@archiver.kernel.org>; Fri, 11 Nov 2022 18:59:25 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web11.633.1668193159632338191
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 11 Nov 2022 10:59:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=ZRwqWJiM;
 spf=pass (domain: gmail.com, ip: 209.85.128.45, mailfrom: quaresma.jose@gmail.com)
Received: by mail-wm1-f45.google.com with SMTP id v7so3440038wmn.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 11 Nov 2022 10:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qsJ1tOxngCsNTNcwtkv1SyaRZEeejdCx+zvV/Np4ZCM=;
        b=ZRwqWJiMZjdfOqpEX2qHjFSP4NoGKo0jDhIr9zZnTnOIocT13ZIvnk1jMq9/szT22z
         CNDMkt81bAEgM0/mMXfdI2IDBnEn7kEIyxKok66tog7i4Uw+MiaDvaFrnZzRLGWYosOw
         kCJ4e+id4DIo2MeZLAwaoI22HtuaUY9liAeBVeMPuiHVWzTQ3v8BzKt8pEWcP7FQvlgY
         FIhtdMpl0FWNjrtIIBwLetuZwYYKCVfXbYb+l5+OibPGT3g1JLTZ5bKV8TTgZTYXmVuf
         BR/nij5Zcu78H/4iWkj1DQhy0HcBA8Cx4sK8+SjfI0SF9bduKp9PRcrn9FeVUTVATOLe
         tc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qsJ1tOxngCsNTNcwtkv1SyaRZEeejdCx+zvV/Np4ZCM=;
        b=ldkCalXqImL/hHp5viRb04QhWZSkhoNN878uwdiITfMifseV2iePqtuEC/sW8LXtdI
         4al6q6fE3Bl+Fi+z+LHooXCJNMZFcFBH3S5lXViCTvZFk5KHGRJW4WFlM9wDK433M9o5
         jLbdl+DWFKQ4ys8YE5be2U8MlplwKH5F/uAaE0PNXqBrFtnnjQ6NDrtKV0viulZ7Esth
         b7XsGOWPq054ahV8CmY7pFXzfpNZROtW7NtxgMNb9Jcbbot1BL/PKQGLRoYRE2qNGJEV
         9iBLusmmxO6BLKvpyi1DnDkF1Ae1pWI5pG0QrabAU9aSN7Ss6KFoWdE6McmoOthct3bz
         leCg==
X-Gm-Message-State: ANoB5pk1FLgSbU4gl1D0WA4OlCnRKyUogH3idZ9hv6QvFbbLNtoLFYql
	JDCyobTIFVg88j23wlc5mkl9IRXjhS+8kzC2
X-Google-Smtp-Source: AA0mqf6XkA9pjVdDvCyqTYq/wIrG0Oath7KW+dbWV0WKq66cQCv1OcPc+8V57lmWEyYKKosAZUgHJw==
X-Received: by 2002:a05:600c:3b26:b0:3cf:61a3:464e with SMTP id m38-20020a05600c3b2600b003cf61a3464emr2208835wms.111.1668193157769;
        Fri, 11 Nov 2022 10:59:17 -0800 (PST)
Received: from og-worker-dev-01.infra.foundries.io.net (51-159-19-113.rev.poneytelecom.eu. [51.159.19.113])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c024300b003c6b874a0dfsm4265034wmj.14.2022.11.11.10.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 10:59:16 -0800 (PST)
From: Jose Quaresma <quaresma.jose@gmail.com>
X-Google-Original-From: Jose Quaresma <jose.quaresma@foundries.io>
To: bitbake-devel@lists.openembedded.org
Cc: ricardo@foundries.io,
	daiane.angolini@foundries.io,
	Jose Quaresma <jose.quaresma@foundries.io>
Subject: [bitbake-devel][PATCH 1/2] build: log the lockfiles in use with debug
Date: Fri, 11 Nov 2022 18:58:48 +0000
Message-Id: <20221111185849.2458457-1-jose.quaresma@foundries.io>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 11 Nov 2022 18:59:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14072

Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
---
 lib/bb/build.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index b8c1099e..ae781c8c 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -217,7 +217,9 @@ def exec_func(func, d, dirs = None):
 
     lockflag = flags.get('lockfiles')
     if lockflag:
-        lockfiles = [f for f in d.expand(lockflag).split()]
+        expandlockfiles = d.expand(lockflag)
+        bb.debug(2, "Task lock files: %s" % expandlockfiles)
+        lockfiles = [f for f in expandlockfiles.split()]
     else:
         lockfiles = None
 
-- 
2.34.1


