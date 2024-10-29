Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3946D3A699
	for <webhook@archiver.kernel.org>; Tue, 29 Oct 2024 20:14:54 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web10.3917.1730232889640882449
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Oct 2024 13:14:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=hjWIvPMa;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d4ac91d97so4861724f8f.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 29 Oct 2024 13:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730232887; x=1730837687; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=eEvVnUUdC0VFplp6NZaJClaaWGZcTf9HnEJMof2m/u4=;
        b=hjWIvPMaoiVznMhOJQKSYfiTwvgwk4N2EG7O5Med6ESvP7A6B9PXHvStN51+WDpK1t
         gTa8N3LmConI39G6OLj18xyEZDx+YBomliB6d2wk/hoXw98SiSY7cRAtSAn1UG5sTGIj
         ZC7xsMrRkZq1QgXlDfOfQagn+sgBg/MQVmSI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730232887; x=1730837687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eEvVnUUdC0VFplp6NZaJClaaWGZcTf9HnEJMof2m/u4=;
        b=UcYDm3VCPNtRHmWjc5nFFRF6+xaTiisvTiPgKAcRy930OrHSZntF0YkP+a5Ld0GA04
         Xe4ZhDQkx+aKqvJJcnfrdFvQ0OX3VBbpTSxBatIvtVuT55upvi1hBFCXrVeRUfN10b8r
         0V90ggY0mcqjCKueH324ACOdp2sqNKnnum3f3M/ALsdvFd/aFDmBVqKoFCxGX9sr/ywn
         Vb8ji/8n8CblIaaAnJ5S98kLaOjP2L58xOVbJDUIiYTbD86e6WMzzdvYuBZIrUENpDp/
         tqMX1NAML7DMF1DhFDsJa8vqaq8rwJTg1H07Kbe/F3X/F/kyWT7eOD4Teu6deNQZAP0x
         xigg==
X-Gm-Message-State: AOJu0YzD1r2QHMcNfKmKNutT1y5mdulqLREZazA7YYfoeXEr40ARWKoR
	EtdhE9T47ZQPK6qfi2/3zsCruLE0j3hRxWK/eZEmxKc8CshDPhZlTp0CbxJkASzqtJJPWyWGEME
	AMqc=
X-Google-Smtp-Source: AGHT+IEs/lXUWaHsf1erUdMC6IOBjc7GYXld54cr169r8lGrZgp0kw7Hlaj6VIkGSf6g4QcOpq/YJg==
X-Received: by 2002:adf:fb06:0:b0:37d:4eeb:7366 with SMTP id ffacd0b85a97d-3806114195cmr12190876f8f.4.1730232887247;
        Tue, 29 Oct 2024 13:14:47 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:bbb2:5c44:fa05:1e5f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431935a4acdsm154891985e9.26.2024.10.29.13.14.45
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 13:14:46 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] tests/fetch: Use our own mirror of mobile-broadband-provider to decouple from gnome gitlab
Date: Tue, 29 Oct 2024 20:14:44 +0000
Message-ID: <20241029201444.281473-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 29 Oct 2024 20:14:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16739

GNOME gitlab has occasional downtime which impacts bitbake-selftest
and causes autobuilder failures. Switch to our own mirror for test
purposes to avoid those issues.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/fetch.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index d9883e12a8..363f3a2185 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1432,7 +1432,7 @@ class FetchLatestVersionTest(FetcherTest):
         ("u-boot-mkimage", "git://source.denx.de/u-boot/u-boot.git;branch=master;protocol=https", "62c175fbb8a0f9a926c88294ea9f7e88eb898f6c", "", "")
             : "2014.01",
         # version pattern "yyyymmdd"
-        ("mobile-broadband-provider-info", "git://gitlab.gnome.org/GNOME/mobile-broadband-provider-info.git;protocol=https;branch=master", "4ed19e11c2975105b71b956440acdb25d46a347d", "", "")
+        ("mobile-broadband-provider-info", "git://git.yoctoproject.org/mobile-broadband-provider-info.git;protocol=https;branch=master", "4ed19e11c2975105b71b956440acdb25d46a347d", "", "")
             : "20120614",
         # packages with a valid UPSTREAM_CHECK_GITTAGREGEX
                 # mirror of git://anongit.freedesktop.org/xorg/driver/xf86-video-omap since network issues interfered with testing

