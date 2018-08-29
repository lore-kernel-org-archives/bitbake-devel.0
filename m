Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
	[209.85.221.47])
	by mail.openembedded.org (Postfix) with ESMTP id 043BE74F9D
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 29 Aug 2018 09:43:15 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id a108-v6so4139301wrc.13
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 29 Aug 2018 02:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id;
	bh=rwYzsLLJpo0U6jPgPEgWqY4r2sG/G3Bes7PJPnkxRlo=;
	b=UzftJX4sXpMNet0vE6dCqBxCsZkkLZ83is3mBXYeSmNv5Utp0AKTKPrRQTKsA+IMj3
	4hFzoMfk4Sp2Td44b0CYCe1930nU3ztV2O+VuUakewYzpP2p7JgZnx0AZ+7q+HCfIIei
	EjhHFIe4TUwgbb6vyYjovOdmvwqeSgw3q0hhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=rwYzsLLJpo0U6jPgPEgWqY4r2sG/G3Bes7PJPnkxRlo=;
	b=HbxYykIOWu1T7RRm2d8tru94H7Dm6Tj0hTiMeIlPpfsm1G+0QumoyT1gZ+05vR5lW5
	dwLmt8HvWGzCVBCDvdV9bA/icpI5FOQehGs7trWcLpTzh0g86GRd6x/UtXTVgqkx0xwY
	5q5zio8hMV/3dEMJpuG6/WMPZE2FYzUX+4z0+heR5VvLPRVCq3UbkoyMSsktb1DYJo73
	1KScV2YcXa0t5wGOrJ0fBWm7Jya0g6WkMPhx2qXioasljY66A+4Q0I63p91Dv68TuGi8
	4mrhVMSkl5GiKn01LZCmL2T2eXbW7vI6J8XD5ZPNKVDsxY0DaO4crcBJil3ERufHh3jR
	QidA==
X-Gm-Message-State: APzg51C4RWiz3wBEA8m2nDtM7wTWE/K2NIpWFkFVAf5P4f12fJtQl298
	xsKJUs0opr7H0BHAaY4/rJXk91xi3ZE=
X-Google-Smtp-Source: ANB0VdYprTvgh1gUzRu+SYU7Dl+m7o57JYTw0p8SRlE9HARR1BTkR90+r9Dq6os7fWnejf6ven70vQ==
X-Received: by 2002:adf:e44e:: with SMTP id
	t14-v6mr3641645wrm.96.1535535796443; 
	Wed, 29 Aug 2018 02:43:16 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	34-v6sm5718156wra.20.2018.08.29.02.43.13
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 29 Aug 2018 02:43:15 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 29 Aug 2018 10:43:11 +0100
Message-Id: <20180829094311.20766-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
Subject: [PATCH] tests/fetch: Update gnome.org urls after upstream changes
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 29 Aug 2018 09:43:16 -0000

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/fetch.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 4af0ac550c..e1c856f117 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -867,12 +867,12 @@ class FetchLatestVersionTest(FetcherTest):
         ("dtc", "git://git.qemu.org/dtc.git", "65cc4d2748a2c2e6f27f1cf39e07a5dbabd80ebf", "")
             : "1.4.0",
         # combination version pattern
-        ("sysprof", "git://git.gnome.org/sysprof", "cd44ee6644c3641507fb53b8a2a69137f2971219", "")
+        ("sysprof", "git://gitlab.gnome.org/GNOME/sysprof;protocol=https", "cd44ee6644c3641507fb53b8a2a69137f2971219", "")
             : "1.2.0",
         ("u-boot-mkimage", "git://git.denx.de/u-boot.git;branch=master;protocol=git", "62c175fbb8a0f9a926c88294ea9f7e88eb898f6c", "")
             : "2014.01",
         # version pattern "yyyymmdd"
-        ("mobile-broadband-provider-info", "git://git.gnome.org/mobile-broadband-provider-info", "4ed19e11c2975105b71b956440acdb25d46a347d", "")
+        ("mobile-broadband-provider-info", "git://gitlab.gnome.org/GNOME/mobile-broadband-provider-info;protocol=https", "4ed19e11c2975105b71b956440acdb25d46a347d", "")
             : "20120614",
         # packages with a valid UPSTREAM_CHECK_GITTAGREGEX
         ("xf86-video-omap", "git://anongit.freedesktop.org/xorg/driver/xf86-video-omap", "ae0394e687f1a77e966cf72f895da91840dffb8f", "(?P<pver>(\d+\.(\d\.?)*))")
-- 
2.17.1


