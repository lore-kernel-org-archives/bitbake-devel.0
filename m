Return-Path: <anibal@limonsoftware.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625C4E6748F
	for <webhook@archiver.kernel.org>; Sun, 21 Dec 2025 00:48:10 +0000 (UTC)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.51702.1766278089656886144
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 20 Dec 2025 16:48:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@limonsoftware-com.20230601.gappssmtp.com header.s=20230601 header.b=zKBORL96;
 spf=pass (domain: limonsoftware.com, ip: 209.85.128.170, mailfrom: anibal@limonsoftware.com)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-78fb6c7874cso18437987b3.0
        for <bitbake-devel@lists.openembedded.org>; Sat, 20 Dec 2025 16:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=limonsoftware-com.20230601.gappssmtp.com; s=20230601; t=1766278089; x=1766882889; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VKEjgYtPEJAb/DLr43G2JfolyeLiGz3wmOm6v+QMlEY=;
        b=zKBORL96QkTcYK/067ASCKcKZm0PJZ1DHjfm86f1K7A5FGzx6X2SMXXce9R/7OO1X8
         1wRN208KP81+C79iDPnww8PoA8/N5Rn+tG5roxZyGppnWT+NyXkfiI4yE/PadYiYtO+j
         41vx7YEJJFWthNQfPitg/5mLj10O3GZsCiUivqmOgdspY+naPLV7v9rPRfJoLKdcmP0r
         cEHxdHQyVTtnYWLLD5VLMIJoWVZQ7xC7UCLuvzCeJ0g93CWNNaciX0Ulv1ybheWQvVLD
         GxuV1WtmBXCs0OGclFBMVYAM+J9z1291/gyB4xIHFJqZEhYzoBbWDA2cBDkGYM+UJGCr
         pgsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766278089; x=1766882889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKEjgYtPEJAb/DLr43G2JfolyeLiGz3wmOm6v+QMlEY=;
        b=XVC5b9uDrowtyHqO/7pM88bA4wle1iLDJtoFiQpbL8c7DR27QzkJlGak8RPfk9DWc4
         ij1zmpYAYDtOnZIq5bqjGJLuOSWSVZj/q9q24kx72FiZZtEOfTMx3iwIJZzt6Zo/pfba
         hTnWDxppiwMudrPTH/SW+opR3nGMgTZjZ0ZBN64AFGyr/+NpPRGe/3pKfY7w7pPLjiAi
         BZSZP58+ylhT3jueexbFIW9ZW5vgU+wBLgOzHtHsb5kkXZk8VhNAZqi3+54y74oHSRLM
         YuHhiz8JUN376WzilUIWDaAeX/eN67Z7BnSPW/JdLjMCJgk/SzhNz4UL4SaG5CSJKnpS
         aXdg==
X-Gm-Message-State: AOJu0Yxeab2UczAVHu9v1JREKz4+SyjpkHOCm5wCAacQDMcJcalcsqSM
	PWlGK9oQP4xysGSY5tLi2OJOz+QyQRAaKJKZn2f7B4litN7Nx8n1yYwa+o16lJr/QWOZqFAH1TA
	OVAuDvEE=
X-Gm-Gg: AY/fxX6KUlgVXgvs3u+IQP7G+t+HGBOFck37z3yqByqisf1nQ4pHW/Mhscxli78l3yW
	YS+wxbhDOys+252hJYNpFHADmuWRrUODdJbw8j8aFGscfZpJok7UisT0me7L+j0g7VvQqteR80C
	lmjDeFGbaVXqWfqj+xJHg6QDfzYkw99ZQo9f/FVxCtnWaGyEP8j1IMCGdprLqgZmVsDFgcdNuMb
	JZ0CHTSVAunUwEskdqwIThdU/nEW/kwaoiFSpo0hEHUMOm4OOOTJS6TYCywJx0tqPI8/Uy/1Sgh
	21byFE1TMzEUxjhmkG8eVj7fmoUGYJhBY4JLx3ydhhZK5CJ1eBDRdfr9QBUsK39HIAvbBA8Wm2+
	8C4NY99+QIZnLS9PKh/ubAkfbtG7dHTphe+Sdpkqur1WVk4heRuqPidhgrJA8FdfqQ90POkirDm
	AKYRhioCwKgR7tHuljoMm/G+dIriHdgx4gc0e6IsS3Gfu8giI/RV5e2iv6RaEn6V4iMYvvqdxY8
	R2q25LsG2dfdg4Ml+RF
X-Google-Smtp-Source: AGHT+IE74vfkR1G3ILBtc6XeSs9HSZgfJw9FqV6rh4blU4CFGP14rcuF1F85oPshUQABZEmjkVuFGg==
X-Received: by 2002:a05:690e:587:b0:644:60d9:8672 with SMTP id 956f58d0204a3-6466a8d74efmr4642001d50.87.1766278088727;
        Sat, 20 Dec 2025 16:48:08 -0800 (PST)
Received: from localhost.localdomain ([189.172.79.153])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb4372173sm27120757b3.6.2025.12.20.16.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 16:48:08 -0800 (PST)
From: Anibal Limon <anibal@limonsoftware.com>
To: bitbake-devel@lists.openembedded.org
Cc: antonin.godard@bootlin.com,
	richard.purdie@linuxfoundation.org,
	Anibal Limon <anibal@limonsoftware.com>
Subject: [PATCH][RFC] bitbake-setup: local sources add oe.path.expendvars
Date: Sun, 21 Dec 2025 00:47:50 +0000
Message-ID: <20251221004750.35128-1-anibal@limonsoftware.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 21 Dec 2025 00:48:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18630

Allow environment variables to be expanded on local sources, allow users
specify layers location using custom environment variables.

Signed-off-by: Anibal Limon <anibal@limonsoftware.com>
---
 bin/bitbake-setup | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 73f734e73..d19aee971 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -129,7 +129,7 @@ def checkout_layers(layers, layerdir, d):
         if r_remote:
             _checkout_git_remote(r_remote, repodir, layers_fixed_revisions)
         if r_local:
-            _symlink_local(os.path.expanduser(r_local["path"]), os.path.join(layerdir,repodir))
+            _symlink_local(os.path.expandvars(os.path.expanduser(r_local["path"])), os.path.join(layerdir,repodir))
 
         if os.path.exists(os.path.join(layerdir, repodir, 'scripts/oe-setup-build')):
             oesetupbuild = os.path.join(layerdir, repodir, 'scripts/oe-setup-build')
-- 
2.47.3


