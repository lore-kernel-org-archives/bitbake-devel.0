Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D35DD5B174
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 12:51:45 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.47585.1765803098268244679
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Dec 2025 04:51:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Cw2A4oko;
 spf=pass (domain: gmail.com, ip: 209.85.221.49, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-430f57cd471so736355f8f.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 15 Dec 2025 04:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765803097; x=1766407897; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=88DyCTX7gk9ZmFdeorby2vwHd0QBXf1c0H62zPiJ+u8=;
        b=Cw2A4okoesEiLM7OCHfBI2x4ZHhcPVT2y5JrC7Lipkc3kQnWWe4mHwutMRwUu/7zQp
         Ei4H4JF54r7fu+UrxIvR0IHMuHT6dhPTsSyrFAvzMCIID4R+QnrD7dwC6qJ7Cg1xJFcr
         0JHR3dWG01irycCinK4ewhYE7br4ZqAY8Bzm5LbWMwSN4OtqwxZS5jxg04eVO0JKP4JJ
         CrjyECzzJ/b+i5q2e0vccm9tHgH5kMZhE7TWLx5787r5CwmIJNDQ+oQlOPYDh1uurynU
         7kEvGrddbgAsQvEIZbZyUlM8vJYlVZY3hoRbTvFRblQseoMb2Z0tJ7w8MkVcoMetlRj7
         M4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765803097; x=1766407897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88DyCTX7gk9ZmFdeorby2vwHd0QBXf1c0H62zPiJ+u8=;
        b=KxYkWYMQ5D97Kf4SZ/DduBfbhphWEnmuBNoMChQaBFpUZYTqo7QqR3cI7VYKc7bkST
         kjkURiwXUz63xU67SqkB4D11BryiKac8QGH1p9/5VGVRkdHBnyb6eRIRsohexLksyV4x
         f9XKLvbprXL3XcduCIEEaFHc219dWX60iUMJ2neZ5PWHcEWtm2ozsODb7cJ1tGGRMq2m
         4AKkym295QhuylBFmaX27BEH05IS8m7MNUO4Pqj/TPaGWgSRGavStMfLkTDLeVQf5z5W
         T0ZJBW+O1Y0qk3qTjAH/ZTxPd9dsnmXbJucq7HVQyDT65ehpT60FfY6SnJDUMqP0udz0
         IeCA==
X-Gm-Message-State: AOJu0YwCJfim2VCgz1bdaELc22ETgXlXCBWwNb0ZvReWsywJVhleOBcd
	jNStG5LVQ6e55MDFZ3UV1A0sGhEaVFaWvrOmA4WGnj2ZvkxXQvPgIl62qIBsGA==
X-Gm-Gg: AY/fxX4HE3zHXo4f+0v1KYQOWzFkTWqH8gzgW5BYpnOkIFQXZz1qIPzOafXduwJCUmA
	QKNstvHdrLJ1cQCsthJQ0fKZE2sVzcHTXj/DxOuhhACVm+ejjVNfa4Qw1ThRJZUogRA5fIVXfP8
	hCeYDyjaaH+dcuBZtCbn1FYPYGIQA/cQaDOyElqiaJCgdeEg0HdrvTVx8zX4EnU/tUVWmkPQaA8
	LGEj05e0YwoLQkp+lCrjuXvMrsgWrCWEGS2yqvrcKZfA7fMUm2Gpn5Nm3RTpE4lO8my0Ou9wIwU
	kYyS/6LjFM+10mafzinTojUIraWVxd285QjA3KQICUCfcz+ABCC0Nso/uhXbj5t4lKs0spqIIC7
	rUfSuKE7gFfsnAyX7f/HWFOTFdTZIWlBFkqzvobIoYeNRX13w6MtZSlIpBUDbVQNIuzD/918ABg
	/7iewoHqn13cu85LzHojvZKFuWxVQidVgrr4XxGxJi0n0hBpo=
X-Google-Smtp-Source: AGHT+IGqj+2An4Cpb4NqNPtUpYP8Q+2i85RhMoYSJC+W+hZDP3rpukugTp9MpPYoT1hoqdlCJR1tBw==
X-Received: by 2002:a05:6000:2502:b0:430:f41f:bd42 with SMTP id ffacd0b85a97d-430f41fcb93mr7173029f8f.57.1765803096332;
        Mon, 15 Dec 2025 04:51:36 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8a09fbesm29303342f8f.0.2025.12.15.04.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 04:51:36 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: paul@pbarker.dev,
	antonin.godard@bootlin.com,
	Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH v2 1/5] setup-schema/layers.schema.json: correct indentation
Date: Mon, 15 Dec 2025 13:51:23 +0100
Message-ID: <20251215125127.2660714-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 15 Dec 2025 12:51:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18591

From: Alexander Kanavin <alex@linutronix.de>

Shift one of the inner blocks 8 spaces to the left, so that
everything is indented by 4 spaces.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 setup-schema/layers.schema.json | 72 ++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/setup-schema/layers.schema.json b/setup-schema/layers.schema.json
index 144ea6d9f..9a0b4ed61 100644
--- a/setup-schema/layers.schema.json
+++ b/setup-schema/layers.schema.json
@@ -27,44 +27,44 @@
                         "type": "boolean"
                     },
                     "git-remote": {
-                                "description": "A remote git source from which to fetch",
+                        "description": "A remote git source from which to fetch",
+                        "type": "object",
+                        "additionalProperties": false,
+                        "required": [
+                            "rev"
+                        ],
+                        "properties": {
+                            "branch": {
+                                "description": "The git branch to fetch (optional)",
+                                "type": "string"
+                            },
+                            "rev": {
+                                "description": "The git revision to checkout",
+                                "type": "string"
+                            },
+                            "describe": {
+                                "description": "The output of 'git describe' (human readable description of the revision using tags in revision history).",
+                                "type": "string"
+                            },
+                            "remotes": {
+                                "description": "The dict of git remotes to add to this repository",
                                 "type": "object",
-                                "additionalProperties": false,
-                                "required": [
-                                    "rev"
-                                ],
-                                "properties": {
-                                    "branch": {
-                                        "description": "The git branch to fetch (optional)",
-                                        "type": "string"
-                                    },
-                                    "rev": {
-                                        "description": "The git revision to checkout",
-                                        "type": "string"
-                                    },
-                                    "describe": {
-                                        "description": "The output of 'git describe' (human readable description of the revision using tags in revision history).",
-                                        "type": "string"
-                                    },
-                                    "remotes": {
-                                        "description": "The dict of git remotes to add to this repository",
-                                        "type": "object",
-                                        "patternProperties": { ".*" : {
-                                            "description": "A git remote",
-                                            "type": "object",
-                                            "addtionalProperties": false,
-                                            "required": [
-                                                "uri"
-                                            ],
-                                            "properties": {
-                                                "uri": {
-                                                    "description": "The URI for the remote, using git URL syntax",
-                                                    "type": "string"
-                                                }
-                                            }
-                                        }}
+                                "patternProperties": { ".*" : {
+                                    "description": "A git remote",
+                                    "type": "object",
+                                    "addtionalProperties": false,
+                                    "required": [
+                                        "uri"
+                                    ],
+                                    "properties": {
+                                        "uri": {
+                                            "description": "The URI for the remote, using git URL syntax",
+                                            "type": "string"
+                                        }
                                     }
-                                }
+                                }}
+                            }
+                        }
                     }
                 }
             }
-- 
2.47.3


