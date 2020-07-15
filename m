Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
 by mx.groups.io with SMTP id smtpd.web10.7817.1594823249532528462
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Jul 2020 07:27:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=vzVXmw5U;
 spf=softfail (domain: sakoman.com, ip: 209.85.215.194, mailfrom: steve@sakoman.com)
Received: by mail-pg1-f194.google.com with SMTP id w2so3151681pgg.10
        for <bitbake-devel@lists.openembedded.org>; Wed, 15 Jul 2020 07:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=0rW+EuBoKnMjO4rH+u/RScqrzKZ1ifwZik80gf27Prg=;
        b=vzVXmw5UwiTPdA/ih48LnzXqkRWr/cbaasA15I6w5QfqGCDh6u6bm64NSloWplQy5S
         GxnwFvv1y9VAaWIMWjM+PeDhJ2TsJ/mbp3IlvjO2v4gY4ggKCsEB+MwkH/RQ8cw6idqY
         tXYZYgtJRqDjSnjGlewhgBiAIOS7YfETSDvLm0MttjRt+fG8n/dJNNBIoU6WTapx12NH
         rLd3+v8fHTUSnQwpBdJsa8IxN3m0/gdmjq6Kc3X1wq6CpfH27pm+9g1adTnM1Ry765HE
         qryu+HxntpdM/cxvv7mObXuRucJ88xFDHO6RxipOxO6OPnwQlqCqrf2POc1nNn1qQEhL
         hpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=0rW+EuBoKnMjO4rH+u/RScqrzKZ1ifwZik80gf27Prg=;
        b=FcmfxZ9NukMG6bvhLKkAIDqgrN9+BZPlC0+jajWPBAPWqCVRgNOqXKW8uyNKU7ZyvQ
         n7jcrYl8Kjj2v7uLtzyVsF73EbAMv6jfMtcUf9ze9B9/2Pc9Bec/c8vbA4htfPrVSJIM
         HzAgSKbZSdXf9xVJbLDyAgV3M0GaDRad1yh1+2Rsn4mUkoULTdVVcf9EBcSu4yO4T4WP
         gJiUVgTnpyoakYcctNzNSAYtKK/7Vig/AUl37pOCTYtoz2eIlrPOX6R2Q0GUN8+j+lxn
         pRxbCdSLzYa+YYJCAlwnRfIBweAwryJ4h3kFtMdzYLAa4DC7/xb6wpG/Ax8kmL6iUI1w
         5DXA==
X-Gm-Message-State: AOAM533NVxdog8ZnStHfRw0pSarZU+w6Xfi27i3nhwHySYw9E9NcKhAY
	D4GMuLk6OktuIWBS9cs7ubMZa4zEC9+ROA==
X-Google-Smtp-Source: ABdhPJwr51geJOesURyTJmkEEoRa8o8kcJ861kFh/hq/HU7PqblpaV+2JuTFX4RPa7I5HYXuyXvahQ==
X-Received: by 2002:a62:1d52:: with SMTP id d79mr4702818pfd.106.1594823248449;
        Wed, 15 Jul 2020 07:27:28 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from octo.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id i125sm2423915pgd.21.2020.07.15.07.27.26
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 07:27:27 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 3/8] ui/teamcity: don't use removed logging classes
Date: Wed, 15 Jul 2020 04:26:45 -1000
Message-Id: <cea130b238e874bae30e13b3242a00eaff7f853b.1594822992.git.steve@sakoman.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1594822992.git.steve@sakoman.com>
References: <cover.1594822992.git.steve@sakoman.com>

From: Chris Laplante <mostthingsweb@gmail.com>

Allows the TeamCity frontend to be used again.

Signed-off-by: Chris Laplante <mostthingsweb@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit c5477ba79fcad4a887808dd0df9cfe3554e2c17a)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/ui/teamcity.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/bb/ui/teamcity.py b/lib/bb/ui/teamcity.py
index 1854292f..fca46c28 100644
--- a/lib/bb/ui/teamcity.py
+++ b/lib/bb/ui/teamcity.py
@@ -167,8 +167,6 @@ def main(server, eventHandler, params):
         forcelevel = bb.msg.BBLogFormatter.ERROR
     else:
         forcelevel = bb.msg.BBLogFormatter.WARNING
-    bb.msg.addDefaultlogFilter(console, bb.msg.BBLogFilterStdOut, forcelevel)
-    bb.msg.addDefaultlogFilter(errconsole, bb.msg.BBLogFilterStdErr)
     console.setFormatter(format)
     errconsole.setFormatter(format)
     if not bb.msg.has_console_handler(logger):
-- 
2.17.1

