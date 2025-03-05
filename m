Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0FBC19F32
	for <webhook@archiver.kernel.org>; Wed,  5 Mar 2025 22:09:56 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web11.6379.1741212587818363669
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Mar 2025 14:09:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=s8uvVmPR;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.181, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-224019ad9edso21532125ad.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 05 Mar 2025 14:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1741212587; x=1741817387; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1PYdLohszhNbI+iRiz8oj88WoX5DPTVskhsI5Ioe/UQ=;
        b=s8uvVmPR9R+GdxUeUxQv2i/1fTfeM4ffkUf/ULAEwj0+CSCd0CQ65O9yquQkvaLdKn
         uAzWMR2LLrPD5nfa65nuTAtCvxRCiYPZpjUES8wCch2xmOLFppZlgOCAWr8PlF67nShz
         ycn2DgnuIk5h97jDAIj1m52rhziWxTo/8TJNAjFfBB7vEHcoqALdcNInn9gbxiKCij0a
         NgDCQK9yuY90rasxKonlrhqh9pvzzNTFjMkDc+SsrHq77x58beJ+7a9USTLNP/fzImi6
         cy4O3+/bLewiqXnSgp3Xm7apcxTtGFP8S6Z9EAqX8NV/tG9GcJSTwxdvDSHX4yDJWHi6
         ig7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741212587; x=1741817387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1PYdLohszhNbI+iRiz8oj88WoX5DPTVskhsI5Ioe/UQ=;
        b=XoDXog4IYv4W5YADqrDu3bzihQLn6cJJPM0UHnAbbYLqm3hV5S50tBe6nPFXCth0kn
         tG1sMsV3jSJd7nfAzRFNTq2JTqlz+vjpLK6teqnBkWDKTy9cSbXJD21ywVbVnfP/WZ+t
         NYjBRt//d0J8b82k38nNpnjuGhw+8Bs7hO7Im2Eb8w7htm6qb3aVmNm8BpawPPGwHGnE
         ZTN/k6bL2Ol48jg95+Uzq0ZOJBs2WVlUwMmr5W+2KnrzGFsrPrN5aQo2pfnvxj1UsHxm
         WPYHZSOq4xbOpenE8DXkQrygccxtYD+HmNxhQUmm+k68yU6+aayrrYJs+yckRnrdnrwQ
         FpEQ==
X-Gm-Message-State: AOJu0YyoXimptqdeocjyKd11qwNX66OP9Iiz8SV3hcUYTBiN1edbyO5+
	2tBrwXAmalBq0IiozT9aqCJRsvHgvzMn2rWx52X3IiFjtNMjk3D3nTByPepIaedDGheVjNVTMBq
	F
X-Gm-Gg: ASbGnct6stJcH6RUZTCouGJp3j+ME2GS3AjEsCGyajGqBGfwCPwmhzihmQB/G57iHB0
	AaUB+rLnA4eX7bGG3YiEfTSBCL2z7wKIuin9vkPxD9yI96Z99nZDA/UUh2Co0cZ2QYQcVcaJXYQ
	NXtb6f5p8Yq8ESqm2/QcgeVUC7el/KKxXccN1qtowGFX4/lnOjnza147FxlHrx+XoMjj3Rl04W+
	PtYTX68GEA9VEhNMMIhkfgWMGxTbuWY60EBIu92jp14nLXl1taPUnWZ+4/8kdBsrFY6z0TDevjE
	rzzJVmoiCq5DPOeoG3BvETxst9HmWp8yuhM=
X-Google-Smtp-Source: AGHT+IGoz708QgEh8NwktG/2axF473f7Z4Lc9cMZ21xgLcdtUHnMcfQrA0KDS4UfFIEp5ja1+wy99Q==
X-Received: by 2002:a17:902:d4c5:b0:220:ea90:1925 with SMTP id d9443c01a7336-223f1d20313mr82730475ad.35.1741212587025;
        Wed, 05 Mar 2025 14:09:47 -0800 (PST)
Received: from hexa.. ([2602:feb4:3b:2100:2308:d28:2350:a5eb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501d35a4sm118602405ad.35.2025.03.05.14.09.45
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 14:09:46 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 1/4] utils: Print information about lock issue before exiting
Date: Wed,  5 Mar 2025 14:09:26 -0800
Message-ID: <8d40d8cc319674e77dcf4560243feeeccf53bc51.1741206585.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741206585.git.steve@sakoman.com>
References: <cover.1741206585.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Mar 2025 22:09:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17388

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit cdf6c51a064f8f335c3262b7f102618996f1a229)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/utils.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index ebee65d3d..0dfe47dc5 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1862,6 +1862,7 @@ def lock_timeout(lock):
     held = lock.acquire(timeout=5*60)
     try:
         if not held:
+            bb.server.process.serverlog("Couldn't get the lock for 5 mins, timed out, exiting.\n%s" % traceback.format_stack())
             os._exit(1)
         yield held
     finally:
-- 
2.43.0


