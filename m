Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE9BD41D42
	for <webhook@archiver.kernel.org>; Thu, 11 Dec 2025 14:25:53 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10335.1765463152263359657
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Dec 2025 06:25:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=VYbuUKml;
 spf=pass (domain: gmail.com, ip: 209.85.128.48, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-477a1c28778so1586845e9.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 11 Dec 2025 06:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765463151; x=1766067951; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=88DyCTX7gk9ZmFdeorby2vwHd0QBXf1c0H62zPiJ+u8=;
        b=VYbuUKml2ie31cBV92bXjAPRur1lyDE02/4Ly1yufQSLw+39fOJgt7sueV/a0Ip9Dj
         bfZLISZEOHipWzthJaoAiZ43KDsAS1c9uLqUZqKKu9JDL4A+hspjUGMI5JVxwSXCNDUQ
         iMKo1ZM6d2mprn++Oi0mDcgZ3tE/XPDddkEfH4dH343v5rb+ApQjma/2Rfj/lwdUQ5Fa
         jVo/M+bQWfZpN6Sq8KywvPjpuxDcG+4XvEehr9xzBCYLXDzPfO84jHpl+2ZgB2faynST
         fOhUCwVCZdkNWJI9tpUXdTxP1Rz4wt7iNf3omQDqQITCeCp4hTqSEdkHc61/NqhAoWio
         NzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765463151; x=1766067951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88DyCTX7gk9ZmFdeorby2vwHd0QBXf1c0H62zPiJ+u8=;
        b=d3T7AmO/oypmqDXYLgOyq3jcsbw70vDccm9gpzxpxQ8LjfCFHBerP6ClXEUS2dVXUF
         yVL06L7kJztW/rPhF1lHgg7ag8RpX9BaZcU5OddwXuNKYDIDFq0n7X/azHnOci5a4axl
         cKwA4Wytl9Ggf2aUR3jnKaQV7TAcvVf1YWz0jqKxzxHYr+BWy6GuskDmZ0Mmn+1ugtB7
         WjvXvRyLqvYl6mUlr6YjH/83uMLfpzqh1fB/WHijhrYLRDXpOxi0UB/KhtNQRbInpQlc
         /vnBpb1YUoc2qytN7NVeMt6umBGSpYLlH6M7UU/30QKHM2o6hLrehzuDmSPgQkW2Gw1p
         H+zQ==
X-Gm-Message-State: AOJu0Yw06IBQH3xiQtSuEkJ4LS2PCzE1RiWxXaUJaGSxUM9mpA3asahM
	yD4bXMPFvrmVip3m61UGkUwoWoOjnLBVR6tMbvG5hlo7lmrIj763IwrmdcrdDA==
X-Gm-Gg: AY/fxX5Zy/Fk5LomsmW02J1FO/DDLrK5UkjMWL5XIf6gk5APmVDMvQgA94Yev3EH4II
	nm6hF1W3zP3vm9N3c8BlIcVnDjXKDNwQxuwfn9qs51aiprk+rnqNkMscfJOx6A45eZtNolOiNYN
	pVTK0u/ManNSGWOMKLmzNC6SreKNfRmMoInxU8bIdIkoaaPw0+Gi9ZMTi43i9X6BS1MbuXjqK6K
	0MnhhyCAoWuV8ntKDm99RxUmkJSANV8+3lEJ3/9CrUyOlDN3PrlXNbOUHUAyfB6T11iW5kM1/Pd
	7yxIU3zr/yI1vu0PXIiXiXVsCvWdDFTbWyXDpY6UcAV0oPf5OoRcRKsEb77j2CD70M1Id2fC/k7
	PXtJRnc2FYCKovCDavIVbIhU1D5odlLbos3xgL+FSw+LDTE/1UyWc/Toa7m0U1dAxAgQV1s4G7T
	OgB+yxDc3mRCuKgOozuAisbZhQDchA+zgPSFggDemGHHNDmT8=
X-Google-Smtp-Source: AGHT+IEUcXi5psMFgoVHkfivOTUIfrIDJ7PuVUfFewg2vwPdy5gE+4mz2Tu7zdmtObhbSYpM1vcIRg==
X-Received: by 2002:a05:600c:4e15:b0:479:3a87:2090 with SMTP id 5b1f17b1804b1-47a837a0478mr56927415e9.37.1765463150290;
        Thu, 11 Dec 2025 06:25:50 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8a70394sm6214200f8f.14.2025.12.11.06.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 06:25:49 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: paul@pbarker.dev,
	Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 1/4] setup-schema/layers.schema.json: correct indentation
Date: Thu, 11 Dec 2025 15:25:29 +0100
Message-ID: <20251211142532.983960-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Dec 2025 14:25:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18567

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


