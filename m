Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E4EC43219
	for <webhook@archiver.kernel.org>; Sat, 19 Nov 2022 17:51:38 +0000 (UTC)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
 by mx.groups.io with SMTP id smtpd.web10.26410.1668880293506211173
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 19 Nov 2022 09:51:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=tssVU8RU;
 spf=softfail (domain: sakoman.com, ip: 209.85.215.178, mailfrom: steve@sakoman.com)
Received: by mail-pg1-f178.google.com with SMTP id b62so7722297pgc.0
        for <bitbake-devel@lists.openembedded.org>; Sat, 19 Nov 2022 09:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dzwDLAZd6YsQmMvIuwjFYZo76aE8WYxabAs/7Ko8vVE=;
        b=tssVU8RUk+zXCyh8TqxQ4PRhL6pY+4iNtDPSLQ/7k+8icI7C/Y0nqC1dhOwCDLWMwh
         Pi06jeTyQla42CO+t8jKDyEvP1RuhZrCpp0tkzB7ewQPRNqGklT8+J2oKihx82B5+WKs
         WXbHXSW+ITnrv7H/fI84+vDxHqF/URxF2gMW5ZhSXoV5ZXUgFr9xM+/PztcxUnRAdXUm
         3xhm0ul8W/o2zNmoR4PuPeXupGUqBit0nqexEyo58WtIrJ4UFrPjzfxysYIThGqK5RHj
         Ykr+P1ggBylaV+IjxF1jDO/pyGPUP7WKgMj42XemIKe5SQF8N7KOnU50PoRxGSUPww54
         9+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzwDLAZd6YsQmMvIuwjFYZo76aE8WYxabAs/7Ko8vVE=;
        b=pEwpEAiK1GwKgbbM/OaGnzRa9onKlnEEl0kcbw6rqAWwmsfM6Nq1dzJLxMcSqUaLXI
         4t9dSVwQnErIP7RSXXy297WjJaJ88sZrVCc2jncIuF/GBi51r5NABvwnchrMwNGAKe+5
         4FCnKlTAIdK0+bAvHl0j/hSyAuHbL0ApZ03s3gAHCMxMtbvoicYY7VyjZ9RivptWDJEY
         Z8PBng7xHUGBmoqMgsQI5f9K2ovvIJ1LbPQJ4LjVxn66uzvs0yCiXIOMMQwRZu69zvL7
         vVhHEWNfcr5tWv6OWxe/UR6wlw/he9FUVjJI+Bjyp8XdiNus5L8vueMDAW/06uMNbWUh
         RS8A==
X-Gm-Message-State: ANoB5pnf/HO39TK0st+HfNlBhijGGNpCZCk5y/j6kM14F9t0q10Wk6se
	holZ9eb8VzF4mL1VJ4VJFr41J8IleuhXmhNQ6uQ=
X-Google-Smtp-Source: AA0mqf5I2ivTBLogywsUkALb7xaqD09e9uW2RUFaR+aDca6Uwn+lzLEv8zLsSr0AYbYyeWBjQAcovA==
X-Received: by 2002:a63:e811:0:b0:46f:1e8e:dadc with SMTP id s17-20020a63e811000000b0046f1e8edadcmr11182999pgh.561.1668880292550;
        Sat, 19 Nov 2022 09:51:32 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net. [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id a16-20020a170902ecd000b0017f49b41c12sm6083789plh.173.2022.11.19.09.51.31
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 09:51:32 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 2/2] utils: Fix lockfile path length issues
Date: Sat, 19 Nov 2022 07:51:14 -1000
Message-Id: <e3db9c2e9eded3c5cb6040714a6054b44f6b3880.1668880159.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1668880159.git.steve@sakoman.com>
References: <cover.1668880159.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 19 Nov 2022 17:51:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14094

From: Richard Purdie <richard.purdie@linuxfoundation.org>

If the path to bitbake.lock is in a deep directory, bitbake will hang. The
reason was that the max file length limiting code (to 255 chars) was including
the directory name and it should only act on the filename within the directory.
Fix it to just use the base filename.

[YOCTO #14766]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 89d70e7b71eecfe06592202f326e566c579ba01d)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/utils.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 210e535f..82602466 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -461,13 +461,16 @@ def lockfile(name, shared=False, retry=True, block=False):
     consider the possibility of sending a signal to the process to break
     out - at which point you want block=True rather than retry=True.
     """
-    if len(name) > 255:
-        root, ext = os.path.splitext(name)
-        name = root[:255 - len(ext)] + ext
+    basename = os.path.basename(name)
+    if len(basename) > 255:
+        root, ext = os.path.splitext(basename)
+        basename = root[:255 - len(ext)] + ext
 
     dirname = os.path.dirname(name)
     mkdirhier(dirname)
 
+    name = os.path.join(dirname, basename)
+
     if not os.access(dirname, os.W_OK):
         logger.error("Unable to acquire lock '%s', directory is not writable",
                      name)
-- 
2.25.1


