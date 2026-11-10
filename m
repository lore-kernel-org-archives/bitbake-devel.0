Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.19037.1794314387859591257
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 Nov 2026 04:39:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google2 header.b=AEmDt0GT;
 spf=pass (domain: smile.fr, ip: 209.85.128.43, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso19063595e9.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 10 Nov 2026 04:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google2; t=1794314386; x=1794919186; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2D2q57emV3JoymYlR2NJoUTJckXGnky+Kjqt/r+s2vE=;
        b=AEmDt0GTMiJ7IiInBXlZ+HUY7bwLuXjtM7TzDhWEQqEsdycVAR5j00W25yVPPzkLaM
         kOItBRR81IQCiJtCLLtgeAA6Jz9tKaOJI7zl1SfPBRv5W07CMrOhyZoPNsYtYXaSVIPy
         NSmOOQLgPCon8lXSNHYwLz7FfahbdSOrxcSvmwpNIIO509Jri5D6F0JNetVJvbrHv7I4
         PqNeteCv6tNr9TB4tPoQNwkb8OirUTAm2R//M9m9PuvCmWGSvlmkAm0hqf7eges+uHCT
         O9wCeqdjEe/9N/l6CA1kse4GAjc3pGUPTWwnuAggDMGJ/tIUq+wBQshFtw5UeSHvK8SK
         G4EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794314386; x=1794919186;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2D2q57emV3JoymYlR2NJoUTJckXGnky+Kjqt/r+s2vE=;
        b=2XFpNqK7dvZUgtIzgKnz78JjJzAjs8Uq7xv7gjw1pW+TVnX32jCwLY9eMihPHKEC1S
         p9HUc5drby/aWJeIJH7e3g3m6cM4Cy9c8h0RTMIcJK0BtfufN+5x6vfgi4PbqjLMh1tV
         m18WundzNXiCBZEeNTkpTRuRkha9nbjZcvLHNDji/PKEqL1nIMl43RAIUym2xxjdQ+4j
         i3KQD82uUOnVSpdBT4CuxMvCmxGKeupIgEzZkvt4Zuxu6qrpodpMzGTU/NmOim/i9mcq
         VcrLJaGQkj1GSflbH3rKTM63v/u+EwuyDlk4hh+eZNdt7kB2A9SMcBkUNIhovWEptCsF
         /kFA==
X-Gm-Message-State: APuU4Z9rqPdCK1z/W0LTijP6qLOgmrGoxZ2yPcOCrwy5NN3qBjgw6UYJ
	5zym0sSZq5Q4gi++vPl7D7VG8RpZhwA+I/IruReFZq09BCZSS8J2BJdPfpI0sBnziTiuw358aGx
	V9D51A/4=
X-Gm-Gg: AYBFou2tKaLlwg3448+Zog67tE4Skr8Rs89t23lNwYBnJ7HywemZlwH5MLrtiROCGMR
	Xu+lsdimHTQaieWB1+sUrgu1au7VcFofZweg5E3CySEvritxfAiQVXs7KwvRJUc5k4srqi6z2hD
	yqkL4zrKufRMAKN1JUEu7O9Aalx2Rlg7jd0GGX8UTvx+njLpNQxbWGanvoheRTSiO5UHfilzLRy
	XuR+h9JQ0MQED6XxcD7tqvJfQn+T4Zuert7QfB8Fwj7WaJmdste+N1Ul1qJyltD3betpT7w0Cjb
	gO4o0p47INBrXHFCEQ2YC+QBC8+glmX8be7ZM3r6UJlyIE3WP88T/jM7mliYuTRDc999jSrS2xx
	YahwkVHrGUyp1CYEq++eisNxdXNqpoGtkl0rEPpjWcoBaOpXOM/uYL+2Bnl4x/9jVBRbhU/shBm
	1PcN52zZxgX9qL3jo3yHy8kDzgvm4ZymyMT8rV/edrp/BjYoFl45jmgl+TOLZMUGr+xrPxmaaX/
	qsbaR91/TdRaiVURhhC+KM5vOVhsh/G+rfq4ob/J+hmiydQpro7tnrtcfC4s+45VezJiHHJcWnE
	t/8kkwzBRucF9yHtVJLf0FCuHMhYDFMmaP2EFlEPXzV0jhwXJzqVP3wfYHGaQugiJwoIU/CI9ZS
	clxW8g2KdOzmb/Mbigor4aB8NkEC6pTz2ISep
X-Received: by 2002:a05:600c:3e85:b0:4a2:1655:87db with SMTP id 5b1f17b1804b1-4ba022c9b4bmr40744325e9.0.1794314385942;
        Tue, 10 Nov 2026 04:39:45 -0800 (PST)
Return-Path: <yoann.congal@smile.fr>
Received: from FRSMI25-LASER.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba022fe1absm42551425e9.0.2026.11.10.04.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 04:39:45 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [bitbake][blacksail][2.20][PATCH 0/1] Pull request (cover letter only)
Date: Tue, 10 Nov 2026 13:39:28 +0100
Message-ID: <cover.1794314292.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Tue, 10 Nov 2026 12:39:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20412
Content-Type: text/plain; charset="utf-8"

Those are the patches from the last patch review:
https://lore.kernel.org/all/cover.1793868515.git.yoann.congal@smile.fr/
(No review, no change)

Passed a-full on autobuilder:
https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/5060

The following changes since commit 634f8dede6b9d71b5a6691499fd05a8678b46eae:

   bitbake: Bump to version 2.20.0 (2026-09-29 14:04:37 +0100)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.20-next
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.20-next

for you to fetch changes up to 7f7ae8cd58993a389adbd130b07ea5de8415d2f9:

  server/process: Fix lock owner prefix check during shutdown (2026-11-04 22:23:28 +0100)

----------------------------------------------------------------

Reda Maher (1):
  server/process: Fix lock owner prefix check during shutdown

 bin/bitbake-selftest     |  1 +
 lib/bb/server/process.py |  2 +-
 lib/bb/tests/server.py   | 57 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 1 deletion(-)
 create mode 100644 lib/bb/tests/server.py

