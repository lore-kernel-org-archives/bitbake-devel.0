Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C57CC4167D
	for <webhook@archiver.kernel.org>; Fri, 10 Nov 2023 15:32:16 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web11.30434.1699630333086372390
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Nov 2023 07:32:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=WOw1qFlw;
 spf=pass (domain: gmail.com, ip: 209.85.214.174, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1cc330e8f58so18064705ad.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Nov 2023 07:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699630332; x=1700235132; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KmQ7NwAqQyY6VCpaSKLcldPY6mRgPBJZNgJCtrJZ7XU=;
        b=WOw1qFlwDgFzbUaVCmwTJQJEVWd0iIld3kLG8P+heVRDJAB14mKgO8ZdEt2I99XGpQ
         qpKU2UkaDuVUz4MMtxPNTywBxsW530twBE4OPLuGHKJmjRg67u5IJ4DP3v9sA9WIIUx0
         vFsDv9SmUlebh/d9MXhjIPSgGsJ/GT81c6GT89VSw0BwRE6eugbzdN+Fk86RVoF5js2l
         lzv/v5+sszG0BDW0xPWe2xgNoC9g6wbun4HzNfheMraLXAVC5iePDaEPMXQC1AfRILn/
         RfZkIIJm5rEAaOP0BmhZ6mGr//AzQhK8myCBdS0v2Syyl/+PL6rH+kEV52aE5nw5uMKz
         POiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699630332; x=1700235132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KmQ7NwAqQyY6VCpaSKLcldPY6mRgPBJZNgJCtrJZ7XU=;
        b=t+C8YspEbuTg3/NMJMqrBXsivw8UXnine6UPS6PKvXJ1kMMQxLNgQ85RjnDmvu2qOe
         9KaHOHZNxKVLF28C1jEA+9khICiSWzt9jZX9q6PG8nANRvSbJgWT7M+VbDlEJpq6jRqH
         z6tBDyNhaUWOuP5fgzxa6TIjbUNpr7ncWRT6KeoqbZNWaNDuLVyNnGnq8gRarRokpkBU
         650GOi2ePrCCQViWH9u+CaMoX1E4ZV9w1RibVDtwBtWS97NxL2AygO5hnwXHOmnRb8Dt
         g5p/U9Evqv6pq/wmUTx2j0to0kfC/Ac6pBH4VyVJL2LQiwsjKAtfyMh85LLl64FXCNXW
         gFSw==
X-Gm-Message-State: AOJu0YzuZGXX+FwKKBnoaL+eguU+4hhq+F98/FY684f+D8/pX9FQgdRF
	D9TVGu8oXnU11o5levpIfPqzCRueYTgYhg==
X-Google-Smtp-Source: AGHT+IETRKpWbq/hJhSkO9p5NdCthjhYCH/JKtcsdWvIwybH6Sje+RIsbpmK8TKHvuPXokj8CJYOCw==
X-Received: by 2002:a17:902:820f:b0:1cc:ec21:9a64 with SMTP id x15-20020a170902820f00b001ccec219a64mr6990473pln.17.1699630331998;
        Fri, 10 Nov 2023 07:32:11 -0800 (PST)
Received: from chiron.hsd1.or.comcast.net ([2601:1c0:ca00:cea0:cf02:179f:ed0:bddf])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c10600b001c8a0879805sm5492339pli.206.2023.11.10.07.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 07:32:11 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [PATCH] toaster: drop deprecated USE_L10N from settings
Date: Fri, 10 Nov 2023 07:31:51 -0800
Message-Id: <20231110153150.3592843-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Nov 2023 15:32:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15504

Every build currently results in a warning because of the USE_L10N deprecation.

https://docs.djangoproject.com/en/4.2/ref/settings/#use-l10n

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 lib/toaster/toastermain/settings.py | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/settings.py
index 5de881c4..69aa5a10 100644
--- a/lib/toaster/toastermain/settings.py
+++ b/lib/toaster/toastermain/settings.py
@@ -108,10 +108,6 @@ SITE_ID = 1
 # to load the internationalization machinery.
 USE_I18N = True
 
-# If you set this to False, Django will not format dates, numbers and
-# calendars according to the current locale.
-USE_L10N = True
-
 # If you set this to False, Django will not use timezone-aware datetimes.
 USE_TZ = True
 
-- 
2.34.1


