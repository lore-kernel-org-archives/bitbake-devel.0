Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CED9C433F5
	for <webhook@archiver.kernel.org>; Thu, 18 Nov 2021 13:54:25 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web08.1780.1637243663842627162
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Nov 2021 05:54:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=igWI9On3;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id 133so5440569wme.0
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Nov 2021 05:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fo547w3uvdctVeWsn7nLAbRGyyIGVBcNbEnRDzUPIyg=;
        b=igWI9On3E3ZkTC8c9JdfFEYW23YnjtOELFmFOftx13EZMmekWh3wcPZAEdDs8G9CJy
         rGzx3NtvKr6qwDjUbKRjYH3bYjCcveMCnFvAS9gve4lyRhoiVm3Pj+GTciiAOnimIrdP
         /goMFfSkU0ftfQuxXAywY8QUxrLz6qD47Z3IY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fo547w3uvdctVeWsn7nLAbRGyyIGVBcNbEnRDzUPIyg=;
        b=OfkBtCtiN+S6V7ZzJlQQ/fA3e24+iPlCpMd4MgNdZoDb4J9auwl49M9kvs9H7lC340
         Xcp+Fsjqi3Bf8AEuHvrGd3VDBdBmJkmr/HiNuYpZ5ZUBgGXRjknFvs3ecLqP9oxNs8y3
         u6lbPMKI/NdmbkXf/e6fyF0VEIkZaCHYNbaum/FXnQabEyuwf0oVeoCeyHMI8YVJC46I
         9923Fq9IUMZbg7RPmM6r5DgGlud/+1wSmuhCf5X5O5qmzqJ7aMcfVoZ5svnH/3jPED5F
         q166r04dEjh3AQpcdTlbd4zwX0bdk/GXA/33LIS7bt1MX5EorHpzS6lQ7STA57X0e2Ic
         igpw==
X-Gm-Message-State: AOAM53217ruEeIIC7pp+u6BtaCpYd0wODDXMSpJIV7tHE/c4bgCM0ALS
	iLBUHNbJCpidLg+5DRJ+dBudAi3oCQ2amQ==
X-Google-Smtp-Source: 
 ABdhPJwybOY7grB8p2bbq+xsE4znrvK01Eo9NXoBQf11qp34nDAnmVKCuqcr0GioWQhPTG5iBN/g9g==
X-Received: by 2002:a7b:ce16:: with SMTP id m22mr9994625wmc.39.1637243661972;
        Thu, 18 Nov 2021 05:54:21 -0800 (PST)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:423a:6c9:d9d0:129f])
        by smtp.gmail.com with ESMTPSA id
 f7sm3991489wri.74.2021.11.18.05.54.21
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 05:54:21 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] utils: Handle lockfile filenames that are too long for
 filesystems
Date: Thu, 18 Nov 2021 13:54:21 +0000
Message-Id: <20211118135421.4068596-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 18 Nov 2021 13:54:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13067

The fetcher mirror code can go crazy creating lock filenames which exceed the
filesystem limits. When this happens, the code will loop/hang.

Handle the filename too long exception correctly but also truncate lockfile
lengths to under 256 since the worst case situation is lockfile overlap
and lack of parallelism.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/utils.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 70634910f7..23ff64df7a 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -451,6 +451,11 @@ def lockfile(name, shared=False, retry=True, block=False):
     consider the possibility of sending a signal to the process to break
     out - at which point you want block=True rather than retry=True.
     """
+    if len(name) > 255:
+        components = name.rsplit(".", 1)
+        components[0] = components[0][:255 - len(components[1]) - 1]
+        name = ".".join(components)
+
     dirname = os.path.dirname(name)
     mkdirhier(dirname)
 
@@ -487,7 +492,7 @@ def lockfile(name, shared=False, retry=True, block=False):
                     return lf
             lf.close()
         except OSError as e:
-            if e.errno == errno.EACCES:
+            if e.errno == errno.EACCES or e.errno == errno.ENAMETOOLONG:
                 logger.error("Unable to acquire lock '%s', %s",
                              e.strerror, name)
                 sys.exit(1)
-- 
2.32.0


