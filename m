Return-Path: <corentin.guillevic@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E50E95384
	for <webhook@archiver.kernel.org>; Wed,  4 Feb 2026 11:11:07 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18132.1770203461387165176
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Feb 2026 03:11:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=CbqY8c0R;
 spf=pass (domain: smile.fr, ip: 209.85.128.52, mailfrom: corentin.guillevic@smile.fr)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47ee76e8656so90315795e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 04 Feb 2026 03:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1770203460; x=1770808260; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jehs/+SvFYY5GvjC7H6J/zAgN0xaZG98RwtnE+BfuXo=;
        b=CbqY8c0RoF/issNclFxjUgY+AUJV38/UHByUI6dLH4MRBtm0ixrBO8Y2Oo0ObtimZ8
         Bj2yxC8AYgUeivRXJJq+8MEieqqTwcj8Rp2JxEiOyJDLW2eofkkl+wa9LeCNn4S0n9tM
         W7XPkk89u7ZsFdzS8V266r/Kfr5LPzWxTUC+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770203460; x=1770808260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jehs/+SvFYY5GvjC7H6J/zAgN0xaZG98RwtnE+BfuXo=;
        b=IomVa3GHqPIbx3rZKrAGwAevscYkwY9tMFeyHB/fSsE6FxYM397A7//uWZpI8tj28N
         x3SavPi4wJWksL1hTm2HSztKhU7/aKZi62Hkv3dOIRG8C6N6bTO5pUvLX04yaAKeouMB
         cQJy+eROfDRhc6XBsqm8Hu45mtJSaSOFPcPlelxvYZbVlhZCnGeeZnysfUEHq+ZgbvAz
         e57/GFrlGoxBkC7FOA4BgmEdlegJ5L/yTuh1do7meRQZHEvmSvMF9WawYB+CkKc9otdC
         f9E7eHsJyYHx5Z4q4KBguKZ/ZpNLpcwLmtA64Unv4OOomP2SAkhc82YMf7uUMjijZE5K
         lNDg==
X-Gm-Message-State: AOJu0YzTazuGmoFElCQBMKNn5DYRAB1OmcioAOknvNoXeIB/r9KwhfQP
	OH7IEBExqwtWBUE5R+FQi7V5ADGfSNbUHACOk4WftIiCzw3a/APUxtPGIqnS2lGJ2zOR6m9Kmg8
	1Nl0o
X-Gm-Gg: AZuq6aIJ3x2utiuJ9eAKwz/hK4kRiiyXSCBawlSqG8iGhpS5P+U0wEgDFMzG3dvlGn6
	xB3YdWYDzmIhi8hclumYGx8d4PGBEl+TKewZDhKBmADF+axRP6gfG5aTEgJlgvTSq6JQ7j3+4CG
	3aB5sr1FpavPOveooLuDfuOOCVC9PA8QjkISxilabktvVO8YI8RHW3k7hd3waHDhMTyYwf7ofkB
	jod4XTUhZ5t3pPfJ2bMnV3RSTMmJwX73zktPLQSsm6i5D1E0H2hSqAjZtoHYYfEP2u//JBAn4cY
	lLx+O7R+9cm/m9jgoLmZYUbo4SB7thaH9V+nTIHzzlOOb2weTkx3zwbF8inh5QowOmv0ZxUMEqY
	7sp3iQrpaojm4PxNr0xcW7Dc5+bym+KPzs0/zByCQFMPnqzDKmIoUtLictl0M9BRJq2H48Jgnv0
	xIXFfciWGE5GRsKn7Ho9OT
X-Received: by 2002:a05:600c:3488:b0:477:9986:5e6b with SMTP id 5b1f17b1804b1-4830e971353mr33902125e9.28.1770203459702;
        Wed, 04 Feb 2026 03:10:59 -0800 (PST)
Received: from heaven.lan ([2001:861:3080:b0f0:481f:fde1:912:228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830fc0a3bbsm28824395e9.1.2026.02.04.03.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 03:10:59 -0800 (PST)
From: Corentin Guillevic <corentin.guillevic@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Corentin Guillevic <corentin.guillevic@smile.fr>
Subject: [PATCH v7 2/4] layers.schema.json: support 'uri'
Date: Wed,  4 Feb 2026 12:10:49 +0100
Message-ID: <20260204111051.1444641-2-corentin.guillevic@smile.fr>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260204111051.1444641-1-corentin.guillevic@smile.fr>
References: <20260204111051.1444641-1-corentin.guillevic@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 04 Feb 2026 11:11:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18951

The property 'uri', which is a shortcut for 'remotes/origin/uri', is now
supported under 'git-remote'.

Signed-off-by: Corentin Guillevic <corentin.guillevic@smile.fr>
---
 setup-schema/layers.schema.json | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/setup-schema/layers.schema.json b/setup-schema/layers.schema.json
index 1a0255435..f42606941 100644
--- a/setup-schema/layers.schema.json
+++ b/setup-schema/layers.schema.json
@@ -46,6 +46,10 @@
                                 "description": "The output of 'git describe' (human readable description of the revision using tags in revision history).",
                                 "type": "string"
                             },
+                            "uri": {
+                                "description": "Specifies the git URI, can be used instead of the more elaborate 'remotes' property when there is only a single URI",
+                                "type": "string"
+                            },
                             "remotes": {
                                 "description": "The dict of git remotes to add to this repository",
                                 "type": "object",
-- 
2.51.0


