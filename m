Return-Path: <skandigraun@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A17C83F17
	for <webhook@archiver.kernel.org>; Mon, 28 Jul 2025 14:35:47 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web10.82719.1753713346289678227
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Jul 2025 07:35:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=LyIUJ9dO;
 spf=pass (domain: gmail.com, ip: 209.85.221.42, mailfrom: skandigraun@gmail.com)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b78b2c6ecfso512079f8f.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 28 Jul 2025 07:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753713344; x=1754318144; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=oISAuqXkUzyEoDcPy7PeOVVIoAGQEqecuNJf6iflGjc=;
        b=LyIUJ9dO5BZvz3QoE1cbHg97t4n+MhNuW35vawLPyg09zqTRZNGkrW5dixmaD69/L2
         53JUpW2ThjCKCyR0/izVfynmeNo5f8QEXe8paACQgnC52w/EQlENTX7WKu4OGTLWogQR
         VMKm8RJ9PQH9iUJjlHgw82clZYKd4uwSsqgVo+7RdGS5E+VImUUH9G/SMKzBLrxbZAgP
         hXltGwd4zCded72qA2csqWAHFvnSo9PL/PEVRtbbtRybugMFCFiT8xKK44wnLjdA/dTU
         1+VXEK7+I7z86HtKqSy4LdYhkLZstGNE5/EU5E+OxBDVrdTwRUj/SVW+9xHJY9ArwiTJ
         +tvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753713344; x=1754318144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oISAuqXkUzyEoDcPy7PeOVVIoAGQEqecuNJf6iflGjc=;
        b=crJyJ5Xc7j+rf/DnJcfQv+UkqLfRYdDX2q5dIptZLR6V/tn7dhd2Hr8dVm/J3P1Dzt
         XdZOgwVfZqK4SOTMfQkwT/y815Gp6tW7B9aNk+/vPa6+rQbUFuETyU+8W9uTobBz24k/
         i9HFAC6ZR1vrP2UnFTO4uNjSCIprUshZHFcnxpGPH+cdgI9pbPfUXk74PlXLsFbciyt9
         iQKufdPpIiTx7hUJJEleoIozxTp8rt3BEn8Zj4VCRJR4FhN/kBdLj7R3kENNduNnMbSz
         aSBq2JV4tI0n6UVYZ96ucVC5FeJ5f0sHUv2IKF5sGaVxYba/J7bPEu86xsKeaUSBs/7R
         YAUg==
X-Gm-Message-State: AOJu0YyBJo57qZmEpMZfReNpApRBE1ZuuWBz8B3XUy7npXGA1he6XPN/
	ymwA3NARaxVl8VTdBudYD2THMhsbKArpRPoz8Bwve8pP+3xp6LlvS8vHbZwCsg==
X-Gm-Gg: ASbGncvk003PFfk17B4kI3cev4bGnGW0lBQ5lpEhUSldtyjtub+gmYVWqGyPBMJJhdT
	TMX82VrP6zNclDUG3tC/roUf5jxazY6ZfWUcHOdJyKetx+5CIvfRXg0koqE4F79gw3Y5oLkfmLG
	o+MicR0c1XjY3D0nPmp0kf+Gpmt+STuW/ZNYyVw3R94RCWCLwB0Fy74y455YH2Hr/LLC92KJSvg
	7/ZZzeaoVT4ZTNne4INxjKwTeB6KcSHU2TjaIvkSmFdctCG8baeLTxzLYjMN2BU/WAXfZWqwafp
	vTDOMDmZTHX74AwVeEVjeJywk+efKSL+BklxWB3b25pVkfsPl+VUCFjIibeEy/Wbiqr2rxi3Q3Q
	qdlh2PL2u7o1qKyUH8dU=
X-Google-Smtp-Source: AGHT+IE1qmvaifJDRTbjvrPmwYzzIXgwodQJd8Dx0lVB0f2yCXKaltw8Kh8fkSxLQCuPBg210R1SCA==
X-Received: by 2002:a05:6000:2284:b0:3a4:f520:8bfc with SMTP id ffacd0b85a97d-3b77675ff55mr9312567f8f.36.1753713344078;
        Mon, 28 Jul 2025 07:35:44 -0700 (PDT)
Received: from desktop ([51.154.145.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587abc13b3sm105303365e9.6.2025.07.28.07.35.43
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 07:35:43 -0700 (PDT)
From: Gyorgy Sarvari <skandigraun@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch2/git: ignore comments in .gitattributes when detecting LFS
Date: Mon, 28 Jul 2025 16:35:43 +0200
Message-ID: <20250728143543.2896652-1-skandigraun@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 28 Jul 2025 14:35:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17814

Fixes [YOCTO 15917]

When fetching a git repository the .gitattributes file is scanned, checking if LFS
support is required for the repository. This scan checks if the word "lfs" is present
in the file, however the used regex doesn't account for comments, which makes some
repositories[1] be to misidentified as requiring LFS support (which fails fetching, in case
lfs support isn't installed on the build host).

To avoid it, change the used regex to ignore lines starting with "#".

[1]: e.g. https://github.com/MicrochipTech/cryptoauthlib

Signed-off-by: Gyorgy Sarvari <skandigraun@gmail.com>
---
 bitbake/lib/bb/fetch2/git.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 14ec45a3f6..ecaf0a49af 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -829,7 +829,7 @@ class Git(FetchMethod):
         """
         Check if the repository has 'lfs' (large file) content
         """
-        cmd = "%s grep lfs %s:.gitattributes | wc -l" % (
+        cmd = "%s grep '^[^#].*lfs' %s:.gitattributes | wc -l" % (
             ud.basecmd, ud.revision)
 
         try:

