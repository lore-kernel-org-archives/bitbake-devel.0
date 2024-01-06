Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3E0C47073
	for <webhook@archiver.kernel.org>; Sun,  7 Jan 2024 12:28:11 +0000 (UTC)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
 by mx.groups.io with SMTP id smtpd.web11.1711.1704571837594500602
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 06 Jan 2024 12:10:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=lPoEzsyG;
 spf=pass (domain: gmail.com, ip: 209.85.167.54, mailfrom: vvavrychuk@gmail.com)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50e4e3323a6so1514304e87.0
        for <bitbake-devel@lists.openembedded.org>; Sat, 06 Jan 2024 12:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704571835; x=1705176635; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RspbsAxp+mC8f7j95gljDrHR6V1JKjYCGnZ6Wwtzsak=;
        b=lPoEzsyGEXK3Vn/oTKXmCjMNhl1w40v5ylcj534IkSTEilfApB3PeOUfoHL0BqSxmq
         tv+0xY3Tp7hGIPprvWLINkg4m94xeytwz4f8lh2BDWghrxN4yObb6ZQN6iubY/oP0Dg9
         yW1WUEgiX31Y5Yfh9i41yA9F9Lva7CmZGVRmXj7bG49Jl5Sdhdipe12bTPgIPznTpoIm
         TXWZ47WCBC0tOm2+4WRwSaRbA01kdCfoZCirGSo5fSw82L3mcgUBdXH1/RQOfjKgI5DU
         HyjE7B5aOt30eP5omPIY2u9Fl9g1ndv5g8RHgdFcfy1Zv9oDDynSZcVP44Y87Ieyj7WG
         3J2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704571835; x=1705176635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RspbsAxp+mC8f7j95gljDrHR6V1JKjYCGnZ6Wwtzsak=;
        b=E5+Nll5kVUAB+fnXJ+uPyFR0+zHuec0SAxc8RB5XYmEZPzgJxSae8DYQpyJj93XDew
         8fPOeuUj3mXzyhclF1PZ3Mjp9dDF3ddE4kjc3NPUSHYwBc//I3I9eONAdSE5p7T6gGNs
         sAdLs0Sak+dkc+tC4V2OU4vCmrkhJkGsqyFrIGK++p0I1Y1J6IKp3XjWwU6GrIPQNerq
         ZC74saF5KnLW6hSKf/ouSz21NN3CBNrc+Ca4n94+iFuyb6HlwT4vcgktVMELIPnRMUPX
         sjODSEvF0vtbksmbGlvnMt6pOyJ394HHuoQKXMYwHIjdn2VPm0RY8jiGJ8mjYHxBh1WR
         0QlA==
X-Gm-Message-State: AOJu0YxI8ktlZmg6NXx/i3uGBDd8msZxNcqfb7lhmRiV04ylKjh/f2FX
	yDtNQkP/g0Vnts1dswhTSPMKNC4718RzTw==
X-Google-Smtp-Source: AGHT+IHElaCoGRw72NXR/OWMnpTfIQqHG/WbNuw9L9bc3D01b5DXQNSGC8LWFoM9AodfosPjxMxf8Q==
X-Received: by 2002:ac2:5d47:0:b0:50e:765b:1ea3 with SMTP id w7-20020ac25d47000000b0050e765b1ea3mr1866050lfd.22.1704571834746;
        Sat, 06 Jan 2024 12:10:34 -0800 (PST)
Received: from LWO1-LHP-A10856.synapse.com ([185.219.78.170])
        by smtp.gmail.com with ESMTPSA id u30-20020a05651c141e00b002ccf414d47csm771048lje.24.2024.01.06.12.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 12:10:34 -0800 (PST)
From: "Vasyl Vavrychuk" <vvavrychuk@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Vasyl Vavrychuk <vvavrychuk@gmail.com>
Subject: [PATCH] bitbake.conf: add missing CACHE setting
Date: Sat,  6 Jan 2024 22:09:51 +0200
Message-Id: <20240106200951.695281-1-vvavrychuk@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 07 Jan 2024 12:28:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15747

Without it bitbake fails with

  ERROR: Please ensure CACHE is set to the cache directory for BitBake to use

Signed-off-by: Vasyl Vavrychuk <vvavrychuk@gmail.com>
---
 conf/bitbake.conf | 1 +
 1 file changed, 1 insertion(+)

diff --git a/conf/bitbake.conf b/conf/bitbake.conf
index 2c1d8be2..f5a5a333 100644
--- a/conf/bitbake.conf
+++ b/conf/bitbake.conf
@@ -23,6 +23,7 @@ DEPENDS = ""
 DEPLOY_DIR = "${TMPDIR}/deploy"
 DEPLOY_DIR_IMAGE = "${DEPLOY_DIR}/images"
 DL_DIR = "${TMPDIR}/downloads"
+CACHE = "${TMPDIR}/cache"
 FILESPATH = "${FILE_DIRNAME}/${PF}:${FILE_DIRNAME}/${P}:${FILE_DIRNAME}/${PN}:${FILE_DIRNAME}/files:${FILE_DIRNAME}"
 FILE_DIRNAME = "${@os.path.dirname(d.getVar('FILE', False))}"
 IMAGE_CMD = "_NO_DEFINED_IMAGE_TYPES_"
-- 
2.34.1


