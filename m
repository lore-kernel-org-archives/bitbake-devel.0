Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1212EC433FE
	for <webhook@archiver.kernel.org>; Sat, 13 Nov 2021 16:25:54 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web10.476.1636820752440552057
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 13 Nov 2021 08:25:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=hqbgY5lk;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id i5so21320352wrb.2
        for <bitbake-devel@lists.openembedded.org>;
 Sat, 13 Nov 2021 08:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=10tqX30b1r6m3u48GYWCmHxF5eby0XyY/Q9rLadSs7E=;
        b=hqbgY5lkZgd11gNvKRCKgNiegIVml/ZIxev2B/JstMyPy/96k4QGpb4I0bgnGyHdPk
         x8mZu4mPNSr/wVsfgRRT0o7HZ+UjJeTblFJTLGgp84rzKZRfbeaPZ33gyiuuPiczjTzy
         c7Ix+osTzqH/Wsu6InwKrLmmj+ZWahWACCMcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=10tqX30b1r6m3u48GYWCmHxF5eby0XyY/Q9rLadSs7E=;
        b=mRlSXZ4wCJmtuqO9iEQDwVWyeVVQrWZH0qc0Luy5aE2kSOiEBEGmttDRy3vFd+E5/m
         GDXlj3npeSwAWQiBh9iZ4u1ncV14yYwf4Yv1ayc5nlJ9MiaPvuHkmI5kgL8wjvpkWexU
         sbUGozPi1ygwpul0yjCJSHLgK4kdUKu8Yy9kDVlj+vCbGUL1U5zPvoxgbvFmmbYXEXTo
         Z4kWkzoi5oyUYT3t5EpJzmhdlUTxqwRy72aN7wk/o1Bh+60BH5dLSj3IxkJ3zPPiAjyk
         xkDn7J2rE6j0oFKBa27fHeUhBSz4ySU89u65CgXHXILVmFrVyVzErsgz6p9kmvGcAYLQ
         Io9g==
X-Gm-Message-State: AOAM532OWh4kRfn2wG8KWt2iYA7NTASRFAJ+7/2U5q2uHt8Fr4X7HSlY
	hHIkGKohVVEYecOuBhv92OD4MNTE+vHAqQ==
X-Google-Smtp-Source: 
 ABdhPJyk3DY4uk4oOWAKmyP5aK/V/hURQX5BAHJfVJ6Menw9vaW53gbf1ESni6zCItM2u9jHikJjFw==
X-Received: by 2002:adf:ecce:: with SMTP id s14mr29108401wro.98.1636820750714;
        Sat, 13 Nov 2021 08:25:50 -0800 (PST)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:4f1d:7b2:7d47:57f5])
        by smtp.gmail.com with ESMTPSA id
 b14sm11331714wrd.24.2021.11.13.08.25.50
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Nov 2021 08:25:50 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/3] tests/runqueue: Set TOPDIR in test
Date: Sat, 13 Nov 2021 16:25:47 +0000
Message-Id: <20211113162549.3931833-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 13 Nov 2021 16:25:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13038

It was clear with testing that we're asuming bitbake sets TOPDIR correctly
when running these tests. Remove that implict assumption and make it
explicit.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/runqueue.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/tests/runqueue.py b/lib/bb/tests/runqueue.py
index 5b6ada886a..2bf00dc62a 100644
--- a/lib/bb/tests/runqueue.py
+++ b/lib/bb/tests/runqueue.py
@@ -29,9 +29,10 @@ class RunQueueTests(unittest.TestCase):
     def run_bitbakecmd(self, cmd, builddir, sstatevalid="", slowtasks="", extraenv=None, cleanup=False):
         env = os.environ.copy()
         env["BBPATH"] = os.path.realpath(os.path.join(os.path.dirname(__file__), "runqueue-tests"))
-        env["BB_ENV_EXTRAWHITE"] = "SSTATEVALID SLOWTASKS"
+        env["BB_ENV_EXTRAWHITE"] = "SSTATEVALID SLOWTASKS TOPDIR"
         env["SSTATEVALID"] = sstatevalid
         env["SLOWTASKS"] = slowtasks
+        env["TOPDIR"] = builddir
         if extraenv:
             for k in extraenv:
                 env[k] = extraenv[k]
-- 
2.32.0


