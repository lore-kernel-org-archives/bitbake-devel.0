Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76DCC83F34
	for <webhook@archiver.kernel.org>; Tue, 22 Jul 2025 10:14:22 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web10.8873.1753179256780068419
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 22 Jul 2025 03:14:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=QfWn9B/T;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4563cfac19cso43046875e9.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 22 Jul 2025 03:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1753179255; x=1753784055; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=767/a5AAMowm5/iMpO5jN7h14lUKD8+c5Mqge8P4xVs=;
        b=QfWn9B/TzUKj8OBykypCTyLhQhV5oWzCybAEQcjZNG3mCrxFlBDW+VZKWTFMTXf4fM
         70o3JZ13N9skUwxTXWg9DMfZW+RCt9J8rjt7zmnX3eivRUqlf18Z26onGmClookLcu3W
         27ietH+Pu1mhHZemA/gc0BP64GonWlefcpexk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753179255; x=1753784055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=767/a5AAMowm5/iMpO5jN7h14lUKD8+c5Mqge8P4xVs=;
        b=rDQJIbI/DO14LPmLi0NxWH8YsSEsOPjeI3HX4PK3Q3S+9oYmhMMopd4liOvLwHjDRu
         DVqlcWrhFuStIQe4Q+picDeDkbenFg2dwF8w/VEDykHiA9Mtn2PBFmI47bIS89kP4n4D
         PpS87EdWGnebz3dMxtCd0D1RARJQlOTd40mlGh5PR2X7XExqFh040KUEC9qSH0gFNaVv
         aLHWUomry8YmdfhgxaR8qZJTVgjq8/JcNNVspcuiXu0VoNEi3eaDNuy9eHMbO7aifyCM
         prY0gg8WxJSJQACxKwo8Y3Pz9cJylbyGCb/+vBqMXjG1TFBPkbL1cBTzEqt3qeAEmwHb
         z94A==
X-Gm-Message-State: AOJu0YzSwZTu9v4dIULVP6wQh+l2VSCUp8cTUggUwH5RuPK8GpKxGRoi
	mMetlw6TpXg0/w4SftKr30WrbnmdCKvMGTPJlkMfYjDOTiHNesClmYHgPoSHET6ipI97HjBQNfS
	J4Tt5
X-Gm-Gg: ASbGncvdhiKIEoS7UZWDQZZ0qoRGj+LCnjx/WJQXebqn/uGf5gGor/dBOMsOTR32bgX
	ldyc3sk8uFCueqV7RkyVSbCTOb70uTqsMG4kTele9VXp8Kn5FoEDxXSw4jEGrxREZjaoC2OIgmx
	IVcza0cSKUyCD+o5bfQdTRRJx0ds4W96Om7YdDbyApMw+zW2/X2Cv6lP9r3ZsMdVAdXVwaeAGwy
	nbS1wj2ZXRKRHOgMW7LWYQXSkpzy0AqpXGzdLxIL7oM+oTcJrz6P5XGeDP+fSseXYcax39mOPIL
	Gj4jUktX8GBGKBGMRATIA64FHA4+xkNsGOiA/y6GF7ygB/knsMaK0LtfqZEMK0Ud8UuuvOCHota
	705xWv7GGxqveCJzgsJaj9PqqwvH1rO3oJuRTb6G/ml3fxs0ufQ==
X-Google-Smtp-Source: AGHT+IHQ55JS/rS+3fpIrOTeaoauxmnGl7qZMIDl9g3NfWlTU7fMFqgzIvX/z/Pe0sBkF/ytR8qzEw==
X-Received: by 2002:a05:600c:1ca9:b0:456:1ab0:d56d with SMTP id 5b1f17b1804b1-4562e039c45mr186680015e9.7.1753179254469;
        Tue, 22 Jul 2025 03:14:14 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:7d90:ed57:78f:a937])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e818525sm185360575e9.16.2025.07.22.03.14.13
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 03:14:13 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] test/fetch: Switch u-boot based test to use our own mirror
Date: Tue, 22 Jul 2025 11:14:12 +0100
Message-ID: <20250722101412.22905-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 22 Jul 2025 10:14:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17803

The upstream servers are having issues so switch to our own shadow copy
of the repo.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/fetch.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 077472b8b3a..cde1bf33906 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1465,7 +1465,7 @@ class FetchLatestVersionTest(FetcherTest):
         # combination version pattern
         ("sysprof", "git://git.yoctoproject.org/sysprof.git;protocol=https;branch=master", "cd44ee6644c3641507fb53b8a2a69137f2971219", "", "")
             : "1.2.0",
-        ("u-boot-mkimage", "git://source.denx.de/u-boot/u-boot.git;branch=master;protocol=https", "62c175fbb8a0f9a926c88294ea9f7e88eb898f6c", "", "")
+        ("u-boot-mkimage", "git://git.yoctoproject.org/bbfetchtests-u-boot.git;branch=master;protocol=https", "62c175fbb8a0f9a926c88294ea9f7e88eb898f6c", "", "")
             : "2014.01",
         # version pattern "yyyymmdd"
         ("mobile-broadband-provider-info", "git://git.yoctoproject.org/mobile-broadband-provider-info.git;protocol=https;branch=master", "4ed19e11c2975105b71b956440acdb25d46a347d", "", "")

