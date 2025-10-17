Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E35BCCD199
	for <webhook@archiver.kernel.org>; Fri, 17 Oct 2025 23:15:25 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web11.5847.1760742916297769665
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Oct 2025 16:15:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=jtPX8xvB;
 spf=pass (domain: smile.fr, ip: 209.85.221.43, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4282fba734bso83602f8f.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 17 Oct 2025 16:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1760742914; x=1761347714; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzMMQHSugdmZyCp1JeztustF68R3ezVs71jCXstAZnY=;
        b=jtPX8xvBQFQU9hcCBnVRO8tH2O9UpV2SD7EtEmJwd0wGXRmtHWmSr4u1o1ZyIsfo9A
         v0gX3rSAMC6G6ENp6xdCe4NgK0HlCHIhWCMjqbH4BtQyFT8sUIElx43fbzZTHgL+dxTK
         028uY96AzNsjYFTTnx+yAgC9IaIsrsKYsLB8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760742914; x=1761347714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fzMMQHSugdmZyCp1JeztustF68R3ezVs71jCXstAZnY=;
        b=kovOjKKZUetnWcv1oRmISU1JEfus4Kl59WQACrb/fzCX7SeKwtOTFpgwsQ65v+qqai
         2EIycteT+KWblrubb2Estzqr0MjkmA4joShhR0jrUqIvia8LVImYYsMxcuK+wH0WfLra
         YDoV4+2rVmiac9DGYJtfgWmwIubO4nqKXINNq/MFo8ExzJDu28l9H7G5pl/gbc/m9hS9
         WpMyBRiZqm3gBT7cMfmqdo1tvmWMnbdPwmOBStf/ykBOz5v2YQCAlF5xxR8wy4ePcR89
         1csxJwvC41InX3Xe3JplerHYIv9eRy+60txCEamZo9V8nOMPNmnpwb3CRe9R3J133Mj+
         3Y7g==
X-Gm-Message-State: AOJu0YyNeiv0Hg5bYg3i/Gls92OWroVn5HF3cOMmjdWJa6Mk9X3d9h2p
	YazcLiraWVrq7I/zvXeDWEepIh8TxIPzI3Sc43NeiwQbyP7Clga5AS52k0KNB/CwGRpa7z1CC1r
	qqMKx4Ug=
X-Gm-Gg: ASbGncueOTc1wAj02CCrcB3YLDdAd8a9drv6pQjC9LmNFNnvE4LVm1VBS6rq9XrDKvO
	FlCQbMQlDfWvuZ9y5uUIt1DShzPyYctWCRctyY5+FFvN3pbPriytfrdmeMSxPwBKWjr93qtDyxz
	d756N+KEyfQzKi4A1VSv4FQfM2of5D3IgazTp5OXfgQzPBaFrP0cJ2fQxCba6hmJd9ZuEiUzab6
	wr5yAGjYjMfADFyi91sdP880i+weKz779imLbF9AllB43hz2hhqh5zZze3PPlPo6elsRzIjlwXy
	mt5FOrHRKQ6RrCdWJxPdWxQkxp4HuUsgK9we/QPJNUDt8OfkaqfmFEguWKJi7Oe5Hfm2ley2DY0
	PcGzD7Gw5R+Nrq9NCoaPx5cW09WDcXn0Cuba++UGSmWNFNXBLljTCZoDgHfWWYrQmrkKral4fAt
	ellbw/ZKJ65NxLsyAn4GYHIixCUP0twgbd+iMR2cV/xnKoCEvEBJ5Ze+mc49tsuQEgsr+901+St
	za1aKfOD9+e
X-Google-Smtp-Source: AGHT+IEZRRiB2i6317Jd5Y2JzDzV1fCUe5/TjugHwi0Q2Y/+Ogj1og1r/juQkhR7I5kJfdMPIuX3Wg==
X-Received: by 2002:a05:6000:2082:b0:425:7e40:1e02 with SMTP id ffacd0b85a97d-42704d49a0amr3190603f8f.7.1760742914486;
        Fri, 17 Oct 2025 16:15:14 -0700 (PDT)
Received: from P-ASN-ECS-830T8C3.local (2a01cb001331aa0017b58d8bf04048c3.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:17b5:8d8b:f040:48c3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5b3d4csm1638330f8f.19.2025.10.17.16.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 16:15:14 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [RFC PATCH 1/5] schemas: import layers.schema.json from OE-Core
Date: Sat, 18 Oct 2025 01:14:40 +0200
Message-Id: <20251017231444.374436-2-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251017231444.374436-1-yoann.congal@smile.fr>
References: <20251017231444.374436-1-yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Oct 2025 23:15:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18187

From: Yoann Congal <yoann.congal@smile.fr>

Import the current version of layers.schema.json
(as of 39ae9a1061fcfe8c30df511b6f00e407b80ffc4c)

layers.schema.json is used for the "sources" property of the
bitbake-setup configuration file.

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 schemas/layers.schema.json | 76 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 schemas/layers.schema.json

diff --git a/schemas/layers.schema.json b/schemas/layers.schema.json
new file mode 100644
index 000000000..659ee8da4
--- /dev/null
+++ b/schemas/layers.schema.json
@@ -0,0 +1,76 @@
+{
+    "description": "OpenEmbedder Layer Setup Manifest",
+    "type": "object",
+    "additionalProperties": false,
+    "required": [
+        "version"
+    ],
+    "properties": {
+        "version": {
+            "description": "The version of this document; currently '1.0'",
+            "enum": ["1.0"]
+        },
+        "sources": {
+            "description": "The dict of layer sources",
+            "type": "object",
+            "patternProperties": { ".*" : {
+                "type": "object",
+                "description": "The upstream source from which a set of layers may be fetched",
+                "additionalProperties": false,
+                "required": [
+                    "path"
+                ],
+                "properties": {
+                    "path": {
+                        "description": "The path where this layer source will be placed when fetching",
+                        "type": "string"
+                    },
+                    "contains_this_file": {
+                        "description": "Whether the directory with the layer source also contains this json description. Tools may want to skip the checkout of the source then.",
+                        "type": "boolean"
+                    },
+                    "git-remote": {
+                                "description": "A remote git source from which to fetch",
+                                "type": "object",
+                                "additionalProperties": false,
+                                "required": [
+                                    "rev"
+                                ],
+                                "properties": {
+                                    "branch": {
+                                        "description": "The git branch to fetch (optional)",
+                                        "type": "string"
+                                    },
+                                    "rev": {
+                                        "description": "The git revision to checkout",
+                                        "type": "string"
+                                    },
+                                    "describe": {
+                                        "description": "The output of 'git describe' (human readable description of the revision using tags in revision history).",
+                                        "type": "string"
+                                    },
+                                    "remotes": {
+                                        "description": "The dict of git remotes to add to this repository",
+                                        "type": "object",
+                                        "patternProperties": { ".*" : {
+                                            "description": "A git remote",
+                                            "type": "object",
+                                            "addtionalProperties": false,
+                                            "required": [
+                                                "uri"
+                                            ],
+                                            "properties": {
+                                                "uri": {
+                                                    "description": "The URI for the remote",
+                                                    "type": "string"
+                                                }
+                                            }
+                                        }}
+                                    }
+                                }
+                    }
+                }
+            }
+        }}
+    }
+}

