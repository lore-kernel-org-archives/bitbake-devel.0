Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947C7C4332F
	for <webhook@archiver.kernel.org>; Wed,  8 Nov 2023 22:57:40 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web11.107241.1699484251442201964
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Nov 2023 14:57:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=HkEQgf+K;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.176, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6b709048f32so202831b3a.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 08 Nov 2023 14:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1699484250; x=1700089050; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qYg9fv3tLieN0dx9Eik/95juA0EPVtwwmN3gy1bho4w=;
        b=HkEQgf+KftGWVtPM/+Pqz8d416IMxlexPSwW4boP37NpecyESRQO5AV9UqXETyxtNe
         dug6WhKN1fGxSyl7tnxguBceF9RXwP2iyITBgu+SelMiEz7YfVc1KIpQeTyCzVoO4Vsu
         DukEKpkXyFb8/Wtn0h/nMYUb1pe/u/8SSJe+KC046trn+zcEI39ThItJ+WhHi3Xp6mAu
         CZQsVtKNzc5ifF3/CBjyiwAyJIRvGn6YVy8rTtVG3Ctg9tXyjlaGxooMCUixoo4ZsdgZ
         qwVdS/wPJCeJXylgMnqQFR3CUPNyzXpco/glAXQ5K3MTi57+gMVpT7tN4zUYZ2BCyseZ
         65eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699484250; x=1700089050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qYg9fv3tLieN0dx9Eik/95juA0EPVtwwmN3gy1bho4w=;
        b=W/hbporqNpHjQoE0lxbwGTD8qBLUOilwSPkuix7qgiLWCzhyhTViSg/zttlLCLXrqu
         JhbKKX6vVViqXqKreIc+gGqNNwmgcJidrOHQM2JJCBU8qBo8/FDoxSV0UZb+C76Geswl
         cWK8kHaeYCTmFZUJdbc6cJ7l1GBenNLYZ0WPApQHmyv+tOEmnCAm0mjm4paI4NopzWb+
         TON9lFYFaKWFAbIWyHnmOHrfIHb6SXtJ0DuHKvc4f/A6Rcs0LT1CYASiSRIlBHhvD2nz
         Tf2iSNa0iaD3ipCo3xgF+ieww5vs4KvGPqshKotMrB3SX+rzIk+IHwoO3Wybm947wQXI
         p/OA==
X-Gm-Message-State: AOJu0YyTrV21tU7fQ6aASg5DPGs2hLCi60JL1ibwXtHm30dMfyQDGXSO
	jH+i1MyBQ4qm6eOQXOC7xnoeXtIq5Jh4GH2ac70/XQ==
X-Google-Smtp-Source: AGHT+IHEgb9skNCGSBVUAALVs8G6k2PUvIZ74s4wSTTqWcFUFo2i1ad5LtJhlYUNa2OcXl2N7fjYdw==
X-Received: by 2002:a05:6a00:134c:b0:6c3:4597:a936 with SMTP id k12-20020a056a00134c00b006c34597a936mr2994032pfu.30.1699484250495;
        Wed, 08 Nov 2023 14:57:30 -0800 (PST)
Received: from hexa.lan (dhcp-72-234-108-41.hawaiiantel.net. [72.234.108.41])
        by smtp.gmail.com with ESMTPSA id x6-20020a056a000bc600b006862b2a6b0dsm9798063pfu.15.2023.11.08.14.57.29
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 14:57:30 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 1/3] bitbake-getvar: Make --quiet work with --recipe
Date: Wed,  8 Nov 2023 12:57:19 -1000
Message-Id: <161ab0d5bab74732e12d490cee50e14295be0a9f.1699484095.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1699484095.git.steve@sakoman.com>
References: <cover.1699484095.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 08 Nov 2023 22:57:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15453

From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>

Initializing Tinfoil with setup_logging = False only has an effect when
recipe parsing is not needed. To make it work regardless of if --recipe
is used, manipulate the quiet parameter to Tinfoil.prepare() instead.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 71ee69a20f21f3d37f4f060a7d8e87d9f1dc6aa1)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 bin/bitbake-getvar | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake-getvar b/bin/bitbake-getvar
index 4a9eb4f3..13a317e1 100755
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
2.34.1


