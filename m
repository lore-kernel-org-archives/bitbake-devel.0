Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC6AC28B22
	for <webhook@archiver.kernel.org>; Wed,  5 Mar 2025 22:09:56 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.web11.6380.1741212589423710936
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Mar 2025 14:09:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=VznjZF6h;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.43, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2feae794508so82247a91.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 05 Mar 2025 14:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1741212589; x=1741817389; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8QxXInYW13FxRcsNmm9q3w0pWz20qT7Xe+llWUdFlV4=;
        b=VznjZF6h4zLuDbXNp2EvyqyUv1uIbGUdiFB3RYVdqkdTwli57XU1I5q0gR5oaeK8YF
         rEA8Q+aePNZBVHLwNxuL2i6NlStkvszc+7CBYh5kleyJGHTsZpGQzWKtjpj9zhZ5RBHT
         dokc46Bf7+DI5LGmPgm5wUN1f2P9AbwS9VUdFdSS8ygdf+cN3PAfvl5GbFbgtd6FRph6
         rNFkMa08epiCUboqA6340ZoZI0gGnNVdad8B87yUHe6gfpAdkMdz+ncItYkXgv4WxTRM
         y2oJZb759OnDwCIY5ee5ybW2QqRqHSFlOEUxA9EBCAX2b2QBagFsKSzOmNEd+qQC5oDC
         EHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741212589; x=1741817389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8QxXInYW13FxRcsNmm9q3w0pWz20qT7Xe+llWUdFlV4=;
        b=ezwzNBLdNgs+h4YshM1b3kL/0P4yBnjB2nz0fhqH8YvKeB5T7TS+eRSnkXX9HI85pO
         RfMiDiTENqzDVgrrK++u/W1B1JLWtkLkBr0fkSASHxYDrDF9qPONmA+qA3HAIuQP/Ep5
         l8KLUFg+gsNhr5H5zgklqatLySfCF7oN3By13Z9MgUIef6gXwsvREz+8cahn4RIzMDyc
         HQ9Dz6z5n4t7C7Jr3z38pcKMnsaSKYMfVAW4G4TSDKnuirZ+Sly0Iqv/1DLraWN1IQS8
         K+eSkYlj0URzkAPuvWNJyFMn1ueMgftgYBxHggNeCLKLmu3Dc2fOuDpTfsjv8Oo45jMN
         kigg==
X-Gm-Message-State: AOJu0Yzu+QkQlRiIA3OXy+VHIrTyTXX7IR90SfesdiwzW+f1/QE7oQi0
	aEQoLhUREplbx7VmN9qvDmGYpWFL3rcIw+fr+vmvvi4CUowix4gM7n1gVcq3eBAc7aqiHvEnUm2
	w
X-Gm-Gg: ASbGncseiZfWWGNwNZQcmkXC8REkX5ypGrY5yMoMi2JAyIlDGQBeSwAV3oFenRI4NsR
	pYDRr3sNHeNHv4THAhfgz6ilgQdAagok9/GTmahZrqUisS1U3WhN8knAPs4iseFcxK4blf+CAEK
	WbCbnUfH6gpjo5mOD/9MuNCnrYtgRUIqWessssdeucUBzo2JGztqA8COY6jnhjxEVEF1H0CHMii
	GxaONLAF30usDY5Iw5n6BPq5xry4MC+A9jQI/1mMeWmq/hLDNOtFtQcKmOafZJF1deDtSKVTLri
	4cp2sEfgwTJ1wEEVZGkhYJjH+lDTfgc74Zc=
X-Google-Smtp-Source: AGHT+IFvqVH2sgTcHP3kbTfUnlnll30/G0MuVED/gOMKrB964dxvXQU4A5aNscMtF2JeEvdLB/vuKw==
X-Received: by 2002:a17:90b:38c7:b0:2ea:3f34:f194 with SMTP id 98e67ed59e1d1-2ff497a94d1mr7968462a91.10.1741212588603;
        Wed, 05 Mar 2025 14:09:48 -0800 (PST)
Received: from hexa.. ([2602:feb4:3b:2100:2308:d28:2350:a5eb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501d35a4sm118602405ad.35.2025.03.05.14.09.48
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 14:09:48 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 2/4] utils: Tweak lock_timeout logic
Date: Wed,  5 Mar 2025 14:09:27 -0800
Message-ID: <36e8e310faa4e5d572a13c0cf9ec82680cf8f5b9.1741206585.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741206585.git.steve@sakoman.com>
References: <cover.1741206585.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Mar 2025 22:09:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17389

From: Richard Purdie <richard.purdie@linuxfoundation.org>

We should really try and take the lock in the try/finally block so that
in some rare cases such as badly timed interrupt/signal, we always release
the lock.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit a9eb8bf7174b6962b5ba07192fe95b8c7112d9d2)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/utils.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 0dfe47dc5..83e832c33 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1859,8 +1859,8 @@ def path_is_descendant(descendant, ancestor):
 # we exit at some point than hang. 5 minutes with no progress means we're probably deadlocked.
 @contextmanager
 def lock_timeout(lock):
-    held = lock.acquire(timeout=5*60)
     try:
+        held = lock.acquire(timeout=5*60)
         if not held:
             bb.server.process.serverlog("Couldn't get the lock for 5 mins, timed out, exiting.\n%s" % traceback.format_stack())
             os._exit(1)
-- 
2.43.0


