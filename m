Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB33C433F5
	for <webhook@archiver.kernel.org>; Tue, 19 Oct 2021 20:06:40 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web11.15277.1634674000214623648
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 19 Oct 2021 13:06:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=l0FNgs9T;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.182,
 mailfrom: steve@sakoman.com)
Received: by mail-pl1-f182.google.com with SMTP id i5so8246504pla.5
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 19 Oct 2021 13:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=LcyNPw7+CjCqugkzGQhRv44Va1WsNwQBn/Js2L47iCw=;
        b=l0FNgs9TU6RECu/+nOt3jgFYZR1NgQE06N/L71EU2H7gN/1mPTU7wgPre+EbQ7kuPi
         drzErJQB/9Qj+upimpL1Ek5735J1ck+E7BKh2aTp4BRQgCZdG/Iunek14U27sqfUWyYK
         6EJIQ1nM8nTsZeOEXPefwAGgVe5gd3iyNFCtwMYKzu6kTWwqRXt4zynlV2ZAAfP7f8fT
         OmiEE0Uf+MPy8KDCuxgM3/un7kfSPWQtTK2BL22Zw4tFAyI8jZSMmLqESNH3S2A4IEW0
         te79x+LfEiXIwmBRaLqG0rg4TVeTHNVktq8nG3n7clPavREGs8Sq8sf7QIMl0YbT7brM
         hG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LcyNPw7+CjCqugkzGQhRv44Va1WsNwQBn/Js2L47iCw=;
        b=N4Ri5slp5XCH0llz57F5qqY3rsazUN4UNnAG2Z6XmYtgagZmIgHg6kUf+qPpy3gzmM
         QQ9m3QkHsxqSaM1BfT1c2k8AzlVu2AZqOhOECkO4ZEQQMF1J53kxm5w6zTAt314LzGmS
         38s6X8X/hMC6Xr6ugF9nl7ehEsxh247lIWHI0F+Fbeqcs0EUlsr5YM+2x5PNhQ8FmGKN
         webW2RfoUFLbbQkTH8ZHU4OJWUh579jNmnnNOo/wiyOyzw3Ig9wm4OhOGLZbTJ+re8mp
         oAs5eVQFqz/iAfG8nEOV2o+x1Jzm2LKkMWB5r+68GZCtqY+Mjo9SFDhRjYr+IH6PM+xQ
         AhWA==
X-Gm-Message-State: AOAM531zKt4BZph/wFJHG0yxASzy8+y/I25reJpNv1mqwi7waWh0O72A
	3NWUNA1oGU9JBvzzxVG0Nd4rEaoh27Y4mkkUZMc=
X-Google-Smtp-Source: 
 ABdhPJzWjVUD7xSFYKPfoivFApoK9nQGmK5pnFkahht/LwC0hw7s0O3Lw/9Pipvg6THtK4hPjHPuUw==
X-Received: by 2002:a17:903:2083:b0:13f:8baf:f805 with SMTP id
 d3-20020a170903208300b0013f8baff805mr29366189plc.42.1634673999309;
        Tue, 19 Oct 2021 13:06:39 -0700 (PDT)
Received: from hexa.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com.
 [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id
 l6sm3533562pjy.23.2021.10.19.13.06.38
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 13:06:38 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 5/8] bitbake: adjust parser error
 check for python 3.10 compatibility
Date: Tue, 19 Oct 2021 10:06:13 -1000
Message-Id: 
 <fd6f6c225a0eb1fd2166d93b343d4a5254a16721.1634673786.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634673786.git.steve@sakoman.com>
References: <cover.1634673786.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 19 Oct 2021 20:06:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12807

From: Alexander Kanavin <alex.kanavin@gmail.com>

The change was introduced in
https://github.com/python/cpython/commit/a698d52c3975c80b45b139b2f08402ec514dce75

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 8d3c6cbbe6ee734495713ae3b99c609527842506)
Signed-off-by: Justin Bronder <jsbronder@cold-front.org>
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/data_smart.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index c8d2a437..c46d3f0a 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -403,7 +403,7 @@ class DataSmart(MutableMapping):
                     s = __expand_python_regexp__.sub(varparse.python_sub, s)
                 except SyntaxError as e:
                     # Likely unmatched brackets, just don't expand the expression
-                    if e.msg != "EOL while scanning string literal":
+                    if e.msg != "EOL while scanning string literal" and not e.msg.startswith("unterminated string literal"):
                         raise
                 if s == olds:
                     break
-- 
2.25.1


