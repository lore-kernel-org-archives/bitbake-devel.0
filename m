Return-Path: <robbinvandamme@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127ACC54F30
	for <webhook@archiver.kernel.org>; Fri, 30 May 2025 07:19:14 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web10.1339.1748589549160030387
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 30 May 2025 00:19:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ZQtoPhe1;
 spf=pass (domain: gmail.com, ip: 209.85.221.41, mailfrom: robbinvandamme@gmail.com)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a374f727dbso1416472f8f.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 30 May 2025 00:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748589547; x=1749194347; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4L9LUWHw/JrGT257xhH5AE8/I+KplJJZJgTeStH8Gtc=;
        b=ZQtoPhe1nVr1q2kR2ikHnRdeJp4fAOhhn3hqTywIMrdjEIsoYAlrr1QG0x6Y9940eY
         klYOHdkIoAgL1z8PMFd4MrQi8xn7EqFngzvBi6E7g4dnoXYabkgwH9ZFd+DX1x8rZ4lT
         hjSGLcIu4GrmY6Amf5IFmgWLhYkmmlkcVPI1Fc57N2NcQ/APgj/00KsN3Yf5yMKkV5DW
         KyYVXALOlr1ih6v7NSmgecDAZ2uBKjrHRsmKCTfG2FYz5BDR+Fc3+Ij9WcV05zqllzTT
         B9BFaLHChIx/kxVjexpMxPBTbt/NgiBEyS3+W0KKs1ELE5gwusWF5ViRemUciQBJQfRS
         SN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748589547; x=1749194347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4L9LUWHw/JrGT257xhH5AE8/I+KplJJZJgTeStH8Gtc=;
        b=Y05T7US6jsmL1ONa2nRLqI7N9TZxef3Kc7y3UjP+KuDGQxiZevI9fr40Ays6NU9ngn
         HzF1QeoFGo5EtxDy7bMuZXK7gC09m71O2dlGV5nwyCjP2DciF9F45i3piJiQ9/N0wt74
         qVmjpt85VjRnP294gxZZKBWfgAktBTcqZcZLoMSyWO+Ctw5btntQAs3NUsnQa29YJnjT
         rpxjAD60BtSGqEwozqBGQzUJPdBLSy9zFAfFnwNWgYQ7/xNNOpqPbZRdp+JDSY/oVeFF
         5h4EVgBwdGDe+D/mtwRgFiDXUYCNiSjIp2ukvPdlhrrJjF2AAA2qxGUzwlcxwt52+eiD
         AbGA==
X-Gm-Message-State: AOJu0YxVzf4wOis8fzAdC8vbmb/U75JqT0fwLYt31i/l5rDsCZa6Z9Dp
	wH5VNmJMvrV0EWjvPeiA28Po12UzkSvdzuhuOJzjoSr7WR3sVjbArCSu1Bke7Q==
X-Gm-Gg: ASbGncuq7rpSLW/CB+lV5NeHnIwLFKgOqlLUvCU4JgwRUemgC5xwbH2VEoG/nQO07W1
	qXjaJeoEO2yegqCMGYHljoR29Ii1jHMFqS29yyAtuvrNMoSl0NxAdXpj6hcpUJhFA6nUp9Sy5Hb
	O6tB5+NME2SzIIbbMoneQV1yu/N2dMJW1GLXTeIDX8umYjSy2rFUczSmaywCvc0Xv+g/2dLezet
	VqjyAFvAgbNaPb0qO4qsslGqzbeeEEqHxOSEcTLhU1xEniGktAAvsGq6AY3ppGUrQGv+Z7va3sa
	8f2lOLffMvOi4/LZ91w7ivoLrjgWoTOLcwxfMr2D1lfdvtuOVmVpyD9fN33Ax161D7RGozulZdL
	L2p4LBT+s9wZAuIyRsu8agQlr/zJk8OBvq8AzDQ==
X-Google-Smtp-Source: AGHT+IE92CkYCv+8CKakEXBbgb/8C/7dJ4s1lMmSC88XL+QQMY3l5yOdKIylLqIOeYknyzjQ4idgcw==
X-Received: by 2002:a05:6000:40df:b0:3a4:eeb5:21cb with SMTP id ffacd0b85a97d-3a4f89ad199mr767541f8f.26.1748589544509;
        Fri, 30 May 2025 00:19:04 -0700 (PDT)
Received: from PC-G502T14.localdomain (78-20-31-164.access.telenet.be. [78.20.31.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe6ca08sm4130265f8f.33.2025.05.30.00.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 00:19:04 -0700 (PDT)
From: Robbin Van Damme <robbinvandamme@gmail.com>
X-Google-Original-From: Robbin Van Damme <robbin.vandamme@renson.be>
To: bitbake-devel@lists.openembedded.org
Cc: Robbin Van Damme <robbinvandamme@gmail.com>
Subject: [PATCH] Update documentation az fetcher. AZ_SAS token should be prefixed with a question mark since this is not done automatically in the fetcher itself.
Date: Fri, 30 May 2025 09:19:00 +0200
Message-ID: <20250530071900.2217181-1-robbin.vandamme@renson.be>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 30 May 2025 07:19:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17657

From: Robbin Van Damme <robbinvandamme@gmail.com>

Signed-off-by: Robbin Van Damme <robbinvandamme@gmail.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-fetching.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index fb4f0a23d..eac3cbdfb 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -686,9 +686,9 @@ Such functionality is set by the variable:
    delegate access to resources, if this variable is set, the Az Fetcher will
    use it when fetching artifacts from the cloud.
 
-You can specify the AZ_SAS variable as shown below::
+You can specify the AZ_SAS variable prefixed with a ? as shown below::
 
-   AZ_SAS = "se=2021-01-01&sp=r&sv=2018-11-09&sr=c&skoid=<skoid>&sig=<signature>"
+   AZ_SAS = "?se=2021-01-01&sp=r&sv=2018-11-09&sr=c&skoid=<skoid>&sig=<signature>"
 
 Here is an example URL::
 
-- 
2.43.0


