Return-Path: <corentin.guillevic@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F8FD11704
	for <webhook@archiver.kernel.org>; Tue,  2 Dec 2025 16:04:25 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.709.1764691459552248463
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Dec 2025 08:04:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=t6S7JeVE;
 spf=pass (domain: smile.fr, ip: 209.85.128.43, mailfrom: corentin.guillevic@smile.fr)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47789cd2083so33772885e9.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 02 Dec 2025 08:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1764691458; x=1765296258; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbmgJBqrC/HweE///oP+n62BK3ye22WG5ftnwV/25Gg=;
        b=t6S7JeVEiXeCHH6/9k/3bRXIUFCAMMk0cmewxmIhMHA6yHsGaW/nL8TiJZs5cswp45
         h3juIK4ziWnLPkPAZZhPqvdRTTiyBCVJDe2Ngvgi6E55nckYQewQHkzZlrvZuzCRzx/8
         +Unyr+BMWSVRjw2az8ueFFoOlGHjqhKwZVw2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764691458; x=1765296258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FbmgJBqrC/HweE///oP+n62BK3ye22WG5ftnwV/25Gg=;
        b=pRdoxIwb60zdtX1BBYTT6dkOjaHG0UvNBpib8ReAOe9S1n26Tj/V+r8wLRUlPeE+5s
         0HOhNB3foVD4STyJ5Duacjn2IzqPTm8ntxMUmJznwLHMd9LOtGvvfNRyw1OWjLoMnZjm
         st3zNSI7MiNJHWK94G1TGuggYV8ExaEECyVgk5yTMp0L9XoAZZubkpn4K1vrJVJthyHY
         uRSBXxZJsrieXA8pEqRvxH4GOK9/vLh30/LWY2fq86f8IlXSkiC5C6Ja/pd6nINkZnFr
         6hvDBa8UC7FU3gjyq5OZcjhdydVLwbMsnGdZgzBBa8hO0tGVpAYlekMb8zXwQkEJbTG7
         iSmA==
X-Gm-Message-State: AOJu0YxSSvtqqknoqw3ClJDENAcC0SOL9GB3cV3xq04dxbY2f0iOWDBI
	EGdGb02cKkQZpTEuhTJd+YHiRlWsdUdnkdhr0FYTk6rG9AcUcSHCqOsxAntTtJjuzjlQNgSH98L
	pFfFjAuso2Q==
X-Gm-Gg: ASbGncsdJYML/H1o6g3dkGEyBg5Ir/b+MBFLAfLgB57HW1tbiIH+zKNswsr9XZZ1W4g
	rWEoI4GmqRO+QQhM3+8FFkH0z4bC9Ki19obbKCMYffMZQg049Hit0iIYqhd+CNAru/gAxbXqSdk
	saCg6254Lrndhp3qzUfVMMhHyJIxyw6S+I9AW98KzrZ7DsObqqDul0gN0whZenjeUaoPoQYZZxz
	UhI0bJTEQObhaMOti4ghoOxhOp4MjVpb9D+Y5SvzsFi9ROSzUXjv1EvIqBYnio1p8IknlaMWACQ
	qHWuFqT+QSueJ1pPjbdQxbM8d6LProlAWO9aRetkw8tDQ+36Wi6d1TLg55KXLwQiSQjTr0k7s0T
	P55aptm0Ww4vamZrM1HZIC2jZYSsWLCeMHD7g0bY2AEE8GQaOb2kskXjIpT75lXxW/+eiq0QVwU
	8oiG9JDrPSeLThWEcabN2clw==
X-Google-Smtp-Source: AGHT+IGgfAEeLJ0wl/LHkdykBaTehC+cm0XxcW0dWnEqXM1LCNnNZcIXD2wozYLoXNPEF3rq++Abmg==
X-Received: by 2002:a05:600c:35d0:b0:477:1ae1:fa5d with SMTP id 5b1f17b1804b1-4792a4b4c91mr802235e9.20.1764691457785;
        Tue, 02 Dec 2025 08:04:17 -0800 (PST)
Received: from heaven.lan ([2001:861:3080:b0f0:3dbf:6e88:6b4c:feb7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca1a396sm33461990f8f.22.2025.12.02.08.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 08:04:17 -0800 (PST)
From: Corentin Guillevic <corentin.guillevic@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Corentin Guillevic <corentin.guillevic@smile.fr>
Subject: [PATCH 2/2] layers.schema.json: support 'uri', make this and 'remotes' mutually exclusive
Date: Tue,  2 Dec 2025 17:04:02 +0100
Message-ID: <20251202160402.819060-2-corentin.guillevic@smile.fr>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251202160402.819060-1-corentin.guillevic@smile.fr>
References: <20251202160402.819060-1-corentin.guillevic@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Dec 2025 16:04:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18508

The property 'uri', which is a shortcut for 'remotes/origin/uri', is now
supported under 'git-remote'. However, this is mutually exclusive with 'remotes'.

Signed-off-by: Corentin Guillevic <corentin.guillevic@smile.fr>
---
 setup-schema/layers.schema.json | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/setup-schema/layers.schema.json b/setup-schema/layers.schema.json
index 144ea6d9f..68befa08a 100644
--- a/setup-schema/layers.schema.json
+++ b/setup-schema/layers.schema.json
@@ -46,8 +46,12 @@
                                         "description": "The output of 'git describe' (human readable description of the revision using tags in revision history).",
                                         "type": "string"
                                     },
+                                    "uri": {
+                                        "description": "The URI for the remote 'origin'. Mutually exclusive with 'remotes'",
+                                        "type": "string"
+                                    },
                                     "remotes": {
-                                        "description": "The dict of git remotes to add to this repository",
+                                        "description": "The dict of git remotes to add to this repository. Mutually exclusive with 'uri'",
                                         "type": "object",
                                         "patternProperties": { ".*" : {
                                             "description": "A git remote",
@@ -64,7 +68,19 @@
                                             }
                                         }}
                                     }
-                                }
+                                },
+                                "oneOf": [
+                                    {
+                                        "required": [
+                                            "uri"
+                                        ]
+                                    },
+                                    {
+                                        "required": [
+                                            "remotes"
+                                        ]
+                                    }
+                                ]
                     }
                 }
             }
-- 
2.49.0


