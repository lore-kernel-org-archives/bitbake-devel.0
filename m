Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16CAE6897F
	for <webhook@archiver.kernel.org>; Thu, 31 Oct 2024 12:08:06 +0000 (UTC)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
 by mx.groups.io with SMTP id smtpd.web11.10718.1730376478453241118
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 31 Oct 2024 05:07:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=PIGKgoXu;
 spf=pass (domain: gmail.com, ip: 209.85.208.182, mailfrom: quaresma.jose@gmail.com)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb5be4381dso7717761fa.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 31 Oct 2024 05:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730376476; x=1730981276; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=slsLChp4+Mw6yGefBbEeDXLFtMXHFp6OzTH4fSm6zxM=;
        b=PIGKgoXu2wXYGeV9u7o/aHgdspbT63lnF9bAI+bwbvg8qGBakHJuc0PAJjSV2rMSjH
         bmysOOcBdumvjNeTz22cnXAcP6tS6VgBiQ5Sd836/HAT7jcFOLgAGUf8eP6Y/eeWucQ/
         LvUy0BgYQxn6dZqVnxPttxQzW5ck1WGgo8SWoma12AGTsAKjZec+lnaNiSQZcT4whX1S
         DG/LMG19VT6jRp1NpMsP4ID2/uGW0gh8UmRuJCnzhITlkF1PIsOZR+Fzu1oU3VDUFnE2
         Bya0K/KglRMri9ozk1nAFrWF8qwaRNLMj42JJhyyDezWJhLiDxRCSQLEus2LSrR8QNTE
         AFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730376476; x=1730981276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=slsLChp4+Mw6yGefBbEeDXLFtMXHFp6OzTH4fSm6zxM=;
        b=SDEk6Q787SG21zupU1X5eaLnS5BPspf8jkexWQEg5c4AevXYBM5XLzW190XbtI9mVa
         Bgd4+MyXftupRLC1ws0F9bGzbMIbVAMOiiduY4FwjFx0jbQnpF5e6AZIfbsc1sw3TKqq
         DuZZaTy8O7fDz1JGpKA6g7etgZKwyGbnySd0k2g0HMcDRAN525gjJzZ9qESXRF76EJn8
         RVCMpTIglODcWPr95L5OpXrXq/PbVzzpkNGukHZ3J/Ol7twVxcmMjy9xpPd2OZubFCIU
         dRWATb6C/jhq7UwyVVuH3jONQaWjrzCU6OwC+cZqFXBSDzp6Zz8TeEJsbuoT5kc7f9KJ
         h3kQ==
X-Gm-Message-State: AOJu0YyzuTK6/q5Ni1uTdkOwO238sCqAxOs7exM/UHtReXciyaqeL8f7
	kNijSKTeXxO6hWQXYILCEXO2J76CCdZIlJI9YQiidNWFAMxRWBzWxeXbiNRhsVM=
X-Google-Smtp-Source: AGHT+IFEEZXPzw64rvPZv2tVq1lborAp6nuFn8ebKpERmGk5PvelKEdrXLMBwn7aAzdvp2287H523Q==
X-Received: by 2002:a05:651c:506:b0:2fb:4603:da13 with SMTP id 38308e7fff4ca-2fcbe0989bfmr85917971fa.39.1730376475993;
        Thu, 31 Oct 2024 05:07:55 -0700 (PDT)
Received: from fio.lan (bl15-243-112.dsl.telepac.pt. [188.80.243.112])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d6848b5sm23895675e9.32.2024.10.31.05.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 05:07:55 -0700 (PDT)
From: Jose Quaresma <quaresma.jose@gmail.com>
X-Google-Original-From: Jose Quaresma <jose.quaresma@foundries.io>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Jose Quaresma <jose.quaresma@foundries.io>
Subject: [OE-core][PATCH] bitbake: doc/user-manual: Update the BB_HASHSERVE_UPSTREAM
Date: Thu, 31 Oct 2024 12:07:48 +0000
Message-ID: <20241031120748.3652684-1-jose.quaresma@foundries.io>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 31 Oct 2024 12:08:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16763

Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
---
 .../bitbake-user-manual/bitbake-user-manual-ref-variables.rst   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 899e584f91..f23fb7f2a7 100644
--- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -424,7 +424,7 @@ overview of their function and contents.
 
       Example usage::
 
-         BB_HASHSERVE_UPSTREAM = "hashserv.yocto.io:8687"
+         BB_HASHSERVE_UPSTREAM = "hashserv.yoctoproject.org:8686"
 
    :term:`BB_INVALIDCONF`
       Used in combination with the ``ConfigParsed`` event to trigger
-- 
2.47.0


