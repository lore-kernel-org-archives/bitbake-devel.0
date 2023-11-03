Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEABC4332F
	for <webhook@archiver.kernel.org>; Fri,  3 Nov 2023 20:44:39 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web10.65085.1699044279211143390
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Nov 2023 13:44:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ITTiofgY;
 spf=pass (domain: gmail.com, ip: 209.85.128.54, mailfrom: martin.jansa@gmail.com)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40859dee28cso18327005e9.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 03 Nov 2023 13:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699044277; x=1699649077; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tr2aelZSVbsDKl8W63Sg4KGRTs2lbbvYTfTJI2dh2Nw=;
        b=ITTiofgYbApqtjwHM+qxI4Rz581cPOYP4HH2+negIIbjEFtgxStzbyVV+BK7DzT77H
         sLdVa/JKXZzkCx69zk3tMNQlMGxwNrgC+FlR4r5xmvssM2ThYL4VtEDhBiX+jB1LykcC
         NYbNTM4Weqn9l1UXwl5m8MiKgb5YKU1TNt/OeV6U+9dYdFm4td38L5b9qYtaa9fbVy/f
         8pkZwF/IsrD31PWDJwRYk2uor66goyZLpBdFUj1V2i+m4y3/KVx61s9Xd+402sTquBHC
         v+wrGZDieVJkxHQUvI+ySW5P7dTyVvmdUgkvtk4vmt/OmbB/ZG5zTiX7bMmQEf1A3AFL
         MO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699044277; x=1699649077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tr2aelZSVbsDKl8W63Sg4KGRTs2lbbvYTfTJI2dh2Nw=;
        b=mVJq/r3qIM+15v1dhdoCKAqniA2NX0gBbTWHfbYn4ez82rRR0lKWPA3mat/3hVOdYw
         e0HMgVilcSBFw5HrnKfwkT815CW8s/ZtWTlQm1aCXA5MXgYIpkyBtukiC55bmOM+Y8MF
         IlxNb6RPhMrqdi9VymKpbqVsvdW4lOX8/aaAXynZ7HR/Sg5557aEol6rtZjqOBnmslqg
         cSmLGIISshuBEjHdiwC+FtZ1VbJHBTOPQs5ZF9cz+d86WWDaf4BQLmyz9kLaurcBJmTN
         om/0gbuZTgeGl9XO8pqHzj2MwvMFbc9wla3FnAEFS4y6jkeGdBWpnPX1qHFLTQtOqpgX
         v80w==
X-Gm-Message-State: AOJu0YyGhYhGCWDskpIEveBwvIG+KdmbPuph0RPmalspK7bdY0aC1PCj
	zlwecg835sE+hjahsduKAUki9uaXtJQ=
X-Google-Smtp-Source: AGHT+IFrawW6KtiHF5+KuKJcsDvYSYOB9ti6ZqRip9gxb/EkTtNKbt6eO58DrYBUR97zVlggKTrTPQ==
X-Received: by 2002:a05:600c:450f:b0:408:3918:1bc1 with SMTP id t15-20020a05600c450f00b0040839181bc1mr19518559wmo.8.1699044277301;
        Fri, 03 Nov 2023 13:44:37 -0700 (PDT)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id h19-20020a05600c30d300b004063c9f68f2sm3517714wmn.26.2023.11.03.13.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 13:44:36 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: steve@sakoman.com,
	Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [2.0][PATCH 1/2] bitbake-getvar: Make --quiet work with --recipe
Date: Fri,  3 Nov 2023 21:44:24 +0100
Message-ID: <20231103204425.2011257-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 03 Nov 2023 20:44:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15446

From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>

Initializing Tinfoil with setup_logging = False only has an effect when
recipe parsing is not needed. To make it work regardless of if --recipe
is used, manipulate the quiet parameter to Tinfoil.prepare() instead.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-getvar | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake-getvar b/bin/bitbake-getvar
index 4a9eb4f31..13a317e1d 100755
--- a/bin/bitbake-getvar
+++ b/bin/bitbake-getvar
@@ -36,9 +36,10 @@ if __name__ == "__main__":
         print("--flag only makes sense with --value")
         sys.exit(1)
 
-    with bb.tinfoil.Tinfoil(tracking=True, setup_logging=not args.quiet) as tinfoil:
+    quiet = args.quiet
+    with bb.tinfoil.Tinfoil(tracking=True, setup_logging=not quiet) as tinfoil:
         if args.recipe:
-            tinfoil.prepare(quiet=2)
+            tinfoil.prepare(quiet=3 if quiet else 2)
             d = tinfoil.parse_recipe(args.recipe)
         else:
             tinfoil.prepare(quiet=2, config_only=True)
-- 
2.42.0


