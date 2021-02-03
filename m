Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web09.9803.1612362170633084694
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Feb 2021 06:22:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=WFfVXt6l;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.176, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f176.google.com with SMTP id q131so16706967pfq.10
        for <bitbake-devel@lists.openembedded.org>; Wed, 03 Feb 2021 06:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QlR8acgDD0m+un2+KiWyRjB/nKY6WpVwHlCaJlhH8u0=;
        b=WFfVXt6lOGFiFVdbJy0mivvIg104qFfTBW+mY3lFmsh2HIulzd9E+ocszmPAXZnXDA
         fGYPm05FPtfywv3im9kTrM+IxVjyQ4PnE558fU9wN1IMbqSBtfznoRHy2QPycSzd4MSP
         QyFa76iGLeUOZqQJkabGOgbZtmCefkvTowoOe/Gf3IMOdeJ6/y48HpwHhRlUVotqa1GQ
         RnK2J9LLa8Rd+iRt0WVAu6IHpOrMzB2HB3YtEx9jD01/qU3Tyo7M+11d1UTif2D50KKB
         uMPVVy4aKiOLk1y7GPxWBHKspAFmbZyT0KjR4RO32evMFIHIVE61ziTB3dCTR4Lddz+7
         FUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QlR8acgDD0m+un2+KiWyRjB/nKY6WpVwHlCaJlhH8u0=;
        b=tE8ZYKquS8a+ucW8pq6Sqiopg9p1zBg1x/Lg1WzFfPYDWxFszJYdoacNqw32ShXmiB
         SgUYpGSaqaB8BkLEquF/wNPIu4bfoZmwo8fhHIVP1RHKcc2fycKkCZKcDt0w5BQr+M4R
         mdMzWJxCP0l54srUvxPPNMInFJhuM1sf2v6y/w94HqBrvAey1kL1mbaM4BvYzHL14/jJ
         O2dkPXxfdmB619pi5yAijw8uyuOEfoyw4sTrWx0ayXWon2Udj2IfBqBTQy1JYklyGaXL
         OSQRrDKAtGocs4WnbJIaymCivbSDh1CkveeHujXwmKwD7CPO/tKURz24Dag6s81vv+qg
         A1Kw==
X-Gm-Message-State: AOAM533HPD3mkW/PwRPkUynOlMkOSUwUzPZ+I7Vc/yWZUkjN6l1eX5OY
	z51adAXxbxsdvEb/J7k1tmq6C4qBzhMW2Vj7CbA=
X-Google-Smtp-Source: ABdhPJwC7lIkm3csexjwnJSJ71xYueNnryZNt2XvbC9mqOw08DdaKQVLC0w6ES+/ZqjFnmrUwJeHxA==
X-Received: by 2002:a63:da46:: with SMTP id l6mr4025447pgj.134.1612362169751;
        Wed, 03 Feb 2021 06:22:49 -0800 (PST)
Return-Path: <steve@sakoman.com>
Received: from hexa.router0800d9.com ([72.173.249.164])
        by smtp.gmail.com with ESMTPSA id t129sm2882713pfc.16.2021.02.03.06.22.46
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 06:22:49 -0800 (PST)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 3/4] git.py: Use the correct branch to check if the repository has LFS objects.
Date: Wed,  3 Feb 2021 04:22:08 -1000
Message-Id: <9b916a7f98fd9970d4a81546e454b1a00bc6ecb7.1612361853.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1612361853.git.steve@sakoman.com>
References: <cover.1612361853.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mauro Queirós <maurofrqueiros@gmail.com>

Function "contains_lfs" was only looking at the master branch when searching for LFS
content. LFS may be configured in specific branches only, so we need to use the
correct branch.

Signed-off-by: Mauro Queiros <maurofrqueiros@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 4fa67c2af830035a1ddedc14592ee25a15ebff22)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/fetch2/git.py | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index bdbfe5c0..07064c69 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -566,8 +566,15 @@ class Git(FetchMethod):
         """
         Check if the repository has 'lfs' (large file) content
         """
-        cmd = "%s grep lfs HEAD:.gitattributes | wc -l" % (
-                ud.basecmd)
+
+        if not ud.nobranch:
+            branchname = ud.branches[ud.names[0]]
+        else:
+            branchname = "master"
+
+        cmd = "%s grep lfs origin/%s:.gitattributes | wc -l" % (
+            ud.basecmd, ud.branches[ud.names[0]])
+
         try:
             output = runfetchcmd(cmd, d, quiet=True, workdir=wd)
             if int(output) > 0:
-- 
2.25.1

