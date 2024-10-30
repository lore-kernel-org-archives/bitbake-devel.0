Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DCDD6B6AD
	for <webhook@archiver.kernel.org>; Wed, 30 Oct 2024 16:49:50 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web10.20169.1730306987354459599
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 30 Oct 2024 09:49:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=krSEvCwJ;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.176, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71e592d7f6eso3628b3a.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 30 Oct 2024 09:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1730306986; x=1730911786; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oEmNp48jwIokQyGOsgMCrjHCxCJ5KgEqQJeFY2zvVhI=;
        b=krSEvCwJajRhmTyNR9gMtV3phNRUGBZDjH+8h7EHqQgCvFvffFmvfyDk2CmYSgJqOA
         t3jgBfj/gl6qkAEn5f4figUcdoIOpfs7/wiJFMuRLlf8MF4TYVwKrThsdOgivLqh6kZZ
         ELj6T+jMwo6PiD8914IaDSTBy0AIBvgZgQ6Mtp0ecmQ0YpBeHTrHCCV/dFGnhbmHyyza
         00Cu8V0/wqsRyZtLe2Mq+ii+2iPttOwS4NL2NulGrWo2GPBlo8wBMvn8TjFBcBrJ3Zkt
         Rgcdlw3k+T2IeISn+bh1mLh6uOklBJBA1MzbdDyLyzIN1cSiGXURWwXUBDiCJixVyDz5
         CZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730306986; x=1730911786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oEmNp48jwIokQyGOsgMCrjHCxCJ5KgEqQJeFY2zvVhI=;
        b=B5Fjd5sExnFNKejeg/oovO47vgzzaS7NbJyUpLU+yJ7goCAD8XXIpd5EWOuprCfu+h
         owBfmsQwZSJFct4PyWh8R9z7+KYlI9Xv+RWUcZF3o7p0//1atWg29F7BexAuqItbFN7o
         D3o52ePzZXQ2FstNNtWixWqcJQ+pZmn4XZYw/smfuGzbJvbMiyJp/FA8kYeCksfh6dYj
         +dnl+PQOG2U46/NYvyCteB5vMEpSw45GRQYC0APez4CyJ+T97RrOiJNLPFbJS/g0HLT5
         Hwra/gS73oLMpLM2CTModXn2xhNZ55DSz7V+aqoKOqYnR9NBF/iZjtSRQrFnFaVlM9L7
         C01Q==
X-Gm-Message-State: AOJu0Yy64Q7OJiS68U8tszvfIIEIBJpYFTaawt7TBGz/JpKGX/f1A+I/
	UaAYO2WfhFcuFKOBYWitFQWlDhslMV9Q+35zOd2SnvcgRUQzOzOsUOxAn0Lh8YUdD9cLRpEsZBq
	C
X-Google-Smtp-Source: AGHT+IFf5Tr7CF4WEjlF+TPivyIO7vv1cTputVkS+CA7fP9WUcDlAD1aB9oRrlu2Vyu7UzAoJPg9Dw==
X-Received: by 2002:a05:6a21:2d8a:b0:1d9:4837:ad95 with SMTP id adf61e73a8af0-1d9a84dd7bamr20380315637.37.1730306986491;
        Wed, 30 Oct 2024 09:49:46 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205791e49asm9466200b3a.32.2024.10.30.09.49.45
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 09:49:46 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 5/5]  bitbake-user-manual-ref-variables: update BB_HASHSERVE_UPSTREAM for new infrastructure
Date: Wed, 30 Oct 2024 09:49:29 -0700
Message-Id: <a9b36f2431ed478e41d07ef83fb0db02685dc742.1730306845.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1730306845.git.steve@sakoman.com>
References: <cover.1730306845.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 30 Oct 2024 16:49:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16755

Public hashserver is now at hashserv.yoctoproject.org:8686

Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 12aef3cbb..ad22de4de 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -401,7 +401,7 @@ overview of their function and contents.
 
       Example usage::
 
-         BB_HASHSERVE_UPSTREAM = "hashserv.yocto.io:8687"
+         BB_HASHSERVE_UPSTREAM = "hashserv.yoctoproject.org:8686"
 
    :term:`BB_INVALIDCONF`
       Used in combination with the ``ConfigParsed`` event to trigger
-- 
2.34.1


