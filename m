Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBACC4332F
	for <webhook@archiver.kernel.org>; Tue, 12 Dec 2023 11:35:05 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web10.16303.1702380897926031439
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 12 Dec 2023 03:34:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=iUlDLow1;
 spf=pass (domain: gmail.com, ip: 209.85.221.46, mailfrom: quaresma.jose@gmail.com)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-336346769faso271260f8f.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 12 Dec 2023 03:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702380896; x=1702985696; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mbNfy5WeKPyXiSlz384j6KshXzbzfH4BxqNJ6G9QmYg=;
        b=iUlDLow1U3OM6kd/7whb8nry11ZMhJ2cybtlf82y+ogn9sz6ounOa1GUTdBQ1NsuIM
         kwizMR0SwiM/cjQB7kjsJtVWwtTbfSxanf+orBltS2UHYBREFVcyg6ej4SU65Zby1Imy
         9Z+HOB+bllV/iqbWCqQy0F40uVRvWx2jMZjElbqedupC4McaAcJeSQnMUuOCIjNiCmcQ
         fZ1LLXfgUhHySSM5CVRs7CuagEfXRN6icL+BgTwrRiGu3gVhzE+SIeP2y5q7xvIii4w1
         5j4meE+zJw9J/QNKQIermLmS9Bx9LQB+ADmRLGA5CsjlT3HccWn5tPgzEg64hzlrdMLB
         b5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702380896; x=1702985696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mbNfy5WeKPyXiSlz384j6KshXzbzfH4BxqNJ6G9QmYg=;
        b=l4V4eNaA3C5KwJkf+lyeV/D6ZxaVydYqiFQhzppC0BAcfsFSpzKw/aECSp18ve01Zw
         LJxhzRCbKiFszZz7vJLKhf9obUuboBJH40O2mRCjhn2i55pXI4DY4x1zw7b3VL+pFBYF
         kQe11emoV9V9cxy7WebOov89tknbRN2QPzddvBKYdnUl0llOAKRl9vc1tFiDjGRxLosZ
         r6nabAHc5cTKAQmFu2+RB9wywCrKDiiWpVtpaz1261rdGh8ENADQSUZRS1udnqpwwMox
         H2eLcupesZnmoRrK/GODYjwJrGvVE3IshA3QrxBAfyUXsBvy0IqtL0geARKGQUelGDAM
         Eh6Q==
X-Gm-Message-State: AOJu0YwWTuqlQSOASTQWSzzw4lUZXIuKY/2Y4FXOXzNQRjNJvAaZE1kB
	95anLVh2D+hSM7R27GDH9MKN6lVhdIg=
X-Google-Smtp-Source: AGHT+IH80tdY0VhThm160KXNDK/N9HNW67TeGwjttP97X7YKoN/ZZd6LExqykOpXX9vBQ9GL1axdkQ==
X-Received: by 2002:a05:6000:90e:b0:336:b8d:6531 with SMTP id cw14-20020a056000090e00b003360b8d6531mr3027514wrb.100.1702380895793;
        Tue, 12 Dec 2023 03:34:55 -0800 (PST)
Received: from toster.lan (bl16-110-70.dsl.telepac.pt. [188.81.110.70])
        by smtp.gmail.com with ESMTPSA id d12-20020adfa40c000000b003333fa3d043sm10720425wra.12.2023.12.12.03.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 03:34:54 -0800 (PST)
From: Jose Quaresma <quaresma.jose@gmail.com>
X-Google-Original-From: Jose Quaresma <jose.quaresma@foundries.io>
To: bitbake-devel@lists.openembedded.org
Cc: Jose Quaresma <jose.quaresma@foundries.io>
Subject: [PATCH] bitbake.conf remove duplicate PERSISTENT_DIR
Date: Tue, 12 Dec 2023 11:34:36 +0000
Message-ID: <20231212113436.629700-1-jose.quaresma@foundries.io>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 12 Dec 2023 11:35:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15650

Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
---
 conf/bitbake.conf | 1 -
 1 file changed, 1 deletion(-)

diff --git a/conf/bitbake.conf b/conf/bitbake.conf
index baf0a76f..2c1d8be2 100644
--- a/conf/bitbake.conf
+++ b/conf/bitbake.conf
@@ -42,5 +42,4 @@ T = "${WORKDIR}/temp"
 TARGET_ARCH = "${BUILD_ARCH}"
 TMPDIR = "${TOPDIR}/tmp"
 WORKDIR = "${TMPDIR}/work/${PF}"
-PERSISTENT_DIR = "${TMPDIR}/cache"
 GITPKGV = "${@bb.fetch2.get_srcrev(d, 'gitpkgv_revision')}"
-- 
2.43.0


