Return-Path: <riemensjesse@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F945D18125
	for <webhook@archiver.kernel.org>; Mon, 14 Oct 2024 15:11:07 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
 by mx.groups.io with SMTP id smtpd.web11.57387.1728918657960067872
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 14 Oct 2024 08:10:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=nphKVX2/;
 spf=pass (domain: gmail.com, ip: 209.85.218.48, mailfrom: riemensjesse@gmail.com)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9a14cb0147so117624466b.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 14 Oct 2024 08:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728918655; x=1729523455; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1hhYOD0Y1BJ5ZllNJVQV5JfEk8yfAnAPbwjX0aLwQV8=;
        b=nphKVX2/VQrbPFU31FoohztYOzJYyW0E58h4BGbjmvopAj42bNdmAyBvlWsLJ0JoVL
         BePjuKM7pzjAFcqlJ/lmfE9Tnj5Jzxl5uhhVfZEeEj2l7kdpNqKG4FellZecuumORyVo
         5chIqwO+CAlxaVg2BIzlpXDLLw+LhvyHCCnQD/cFUhX6csxwhPFFQKG5t/YwnMm19adL
         9hWpqny19AlB2snUfs/7/aMPKEVOI+8dDMGLZe4Jx5jJUVMkI1eTpoXlBvDmP7vCvdmu
         s7Z5a5lZYsVv4A/c/JtmjWtwtN6qUUoFGFT66+ecmLShiYnbU5GiLb8O+vTdFiECX/Pa
         +gEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728918655; x=1729523455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1hhYOD0Y1BJ5ZllNJVQV5JfEk8yfAnAPbwjX0aLwQV8=;
        b=fvpR44SG1Iy8tSj5YJ0zSHZbDlvZGTfdU7ogMcLOt98wVFJBvjRBdZIEooytqsqk+H
         3+PcEBgn17ySXd6q+QcBSxqVnV0QUUoTlteIYAiGvzwfnje6EW3Xf4vWnYkd2eXnvxZw
         9vsNi0e6gBb52kdS84j/uZscy6ix9WgioIRMxKWkVP/ACMjcHorSqbz7ZrSdDtSV5cjP
         Mwi1f1Qq+A0VvpvgTG2QouP0wH7jLow7EgGvsRWu3gJGnDDkCTz/MlZ/G8IW6cA5+pPT
         ZJNeBvl7NRmKJH9/IkglU8s8ILljw9XTItFXNbs7rv56gxbKwygCs/pAPwuHr+mTr8ou
         6olw==
X-Gm-Message-State: AOJu0YzOr4yrug9f63ujVLU19geIyJug4qpKUVQkW/CKWXIpCR6ZJpUY
	ABNHryIZ0dZXWhO84Q+z2K9DNnvohT8dQ/GLJgBlbPBkAJN4L8ehauAb0uRL
X-Google-Smtp-Source: AGHT+IG4ODGj8BzAl+vXiKfUCIvMyGUnZykyzlWggN6LBWkHpVVRgDPJDQMXIGcaVUAOJ8k4NvIgbA==
X-Received: by 2002:a17:907:9288:b0:a9a:1739:91e9 with SMTP id a640c23a62f3a-a9a17399666mr148051466b.24.1728918655416;
        Mon, 14 Oct 2024 08:10:55 -0700 (PDT)
Received: from jesse-hp.localdomain (216-130-172-081.dynamic.caiway.nl. [81.172.130.216])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99ef8c4d50sm356671066b.11.2024.10.14.08.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 08:10:54 -0700 (PDT)
From: Jesse Riemens <riemensjesse@gmail.com>
X-Google-Original-From: Jesse Riemens <j.riemens@alvatechnology.nl>
To: bitbake-devel@lists.openembedded.org
Cc: Jesse Riemens <riemensjesse@gmail.com>
Subject: [PATCH] contrib/hashserv/Dockerfile: Add libgcc as dependency
Date: Mon, 14 Oct 2024 17:10:52 +0200
Message-ID: <20241014151052.866580-1-j.riemens@alvatechnology.nl>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 14 Oct 2024 15:11:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16681

From: Jesse Riemens <riemensjesse@gmail.com>

---
 contrib/hashserv/Dockerfile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/hashserv/Dockerfile b/contrib/hashserv/Dockerfile
index 74b4a3be1..aec1f86fc 100644
--- a/contrib/hashserv/Dockerfile
+++ b/contrib/hashserv/Dockerfile
@@ -11,7 +11,7 @@
 
 FROM alpine:3.13.1
 
-RUN apk add --no-cache python3
+RUN apk add --no-cache python3 libgcc
 
 COPY bin/bitbake-hashserv /opt/bbhashserv/bin/
 COPY lib/hashserv /opt/bbhashserv/lib/hashserv/
-- 
2.43.0


