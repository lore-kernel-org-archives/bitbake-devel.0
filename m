Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441F7C433FE
	for <webhook@archiver.kernel.org>; Sat, 19 Nov 2022 17:51:38 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web11.26140.1668880291461776522
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 19 Nov 2022 09:51:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=yVKSKo9u;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.170, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f170.google.com with SMTP id k22so7795816pfd.3
        for <bitbake-devel@lists.openembedded.org>; Sat, 19 Nov 2022 09:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hk3TdapQyh5NCDMza96Pa2UuUSjiSGvhou1Qy1d9LCo=;
        b=yVKSKo9uCTIIba9vjvGZUv4aZmwK30ATzReYI5cr/JSkooEdwggcA4QvF06n4Kx5V2
         agm+SP1Y0S4QH7GawFEF/0GQVZ9oVwWl8H29HCde583CHVPKeFWLDpsZLnANJ0Wfghgs
         p7d1vJdF4MRvUY3N37sKBpUxu/FTPba5Rg38JWcSSSadvwhPYq+h0i5yeJftthR1QMzQ
         AH0Q2uypAKY/xCd95lARRxWbLeNAeur+YsBvFVB0RgIbyzLiAFzkt7/PUOLp3GnAPp37
         E93pOAhLsvzl5s9nklQKKNcWGSauYOBtgOHQJE2D4/kugDnZOMbo7+0Vy9gypXenes9n
         T0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hk3TdapQyh5NCDMza96Pa2UuUSjiSGvhou1Qy1d9LCo=;
        b=yiwy+pZmxDiJbuY0gHdUy0hpGbkISUAFKWRg7Vwfcoe8KIiNmc22y+B0+SYv3RCFpz
         Qv9ReTIjxum6KIocKM+bopjdlb+vFfQ/1Xor/v5nWizhMolrf6ffxhC+Hg9aVS2jDL/f
         e685gfHgD7WINmSX+T5d5sNXxvrS3QIsfhGbBX+rx4/uG3hECdgMHBh2YW3dPtvorUSh
         Xi7X9zoxlpxoqQRJZlvOsoMVQXCs135JlBd7Ju0l7jNXlzBl+dFJm8+UZdCszegm9kck
         nr5Awbg36p2+CZI/L9NiVRTf5/RUm2ENqxAjL1ggD0eimh+5QCkDfGS7U0uOr2vV1rIv
         W/XA==
X-Gm-Message-State: ANoB5pnMAp3BDD1PArZLcTrR2V89/PmTD88iLn5eAcEhacnDPezAz5dx
	YGDfRD7wYoeYDD7AKyfHVKGy98W3pVN9gg9LdO8=
X-Google-Smtp-Source: AA0mqf6GfLWQPZYwhTQMXjI7hyKACvVVF2ThXt4g2amSExKj4qnuVE7FRCbCIbxe+jj+FwjiN2MfYQ==
X-Received: by 2002:a05:6a00:1893:b0:56b:8282:b165 with SMTP id x19-20020a056a00189300b0056b8282b165mr13355737pfh.69.1668880290522;
        Sat, 19 Nov 2022 09:51:30 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net. [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id a16-20020a170902ecd000b0017f49b41c12sm6083789plh.173.2022.11.19.09.51.29
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 09:51:30 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 1/2] utils: Handle lockfile filenames that are too long for filesystems
Date: Sat, 19 Nov 2022 07:51:13 -1000
Message-Id: <30d42ef030d03e11322b6b05ea7bbb64ab3d6f21.1668880159.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1668880159.git.steve@sakoman.com>
References: <cover.1668880159.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 19 Nov 2022 17:51:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14093

From: Richard Purdie <richard.purdie@linuxfoundation.org>

The fetcher mirror code can go crazy creating lock filenames which exceed the
filesystem limits. When this happens, the code will loop/hang.

Handle the filename too long exception correctly but also truncate lockfile
lengths to under 256 since the worst case situation is lockfile overlap
and lack of parallelism.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 63baf3440b16e41ac6601de21ced94a94bdf1509)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/utils.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 6592eb00..210e535f 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -461,6 +461,10 @@ def lockfile(name, shared=False, retry=True, block=False):
     consider the possibility of sending a signal to the process to break
     out - at which point you want block=True rather than retry=True.
     """
+    if len(name) > 255:
+        root, ext = os.path.splitext(name)
+        name = root[:255 - len(ext)] + ext
+
     dirname = os.path.dirname(name)
     mkdirhier(dirname)
 
@@ -497,7 +501,7 @@ def lockfile(name, shared=False, retry=True, block=False):
                     return lf
             lf.close()
         except OSError as e:
-            if e.errno == errno.EACCES:
+            if e.errno == errno.EACCES or e.errno == errno.ENAMETOOLONG:
                 logger.error("Unable to acquire lock '%s', %s",
                              e.strerror, name)
                 sys.exit(1)
-- 
2.25.1


