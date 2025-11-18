Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BA0CED631
	for <webhook@archiver.kernel.org>; Tue, 18 Nov 2025 12:00:40 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10685.1763467237839205140
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 Nov 2025 04:00:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=iznYM6ee;
 spf=pass (domain: gmail.com, ip: 209.85.128.44, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4779a4fc95aso18820905e9.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 18 Nov 2025 04:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763467236; x=1764072036; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Wnqp7/TvujECyo045W3JKxv/5cixkkxRASlNf6g41s=;
        b=iznYM6eey2XQGFjz80wJ1Rn2p8z4OQRvQGXpgONmF1DdUmGQanR7C9E8XeVF9XJ6+0
         RTiacMDwlGVlg6DsP3zBQPs/1QXWAwUsiKMklB8r1gbvcflMstr6fLzoizRWXOD7T0kq
         SaSxyS3M21XSyyyTZlTEAGgJI49/rZhYjZ9/yZcwWPD15hWfg2kf6wj4aPQdFYVf+fb5
         /PPpt6cqOax27NuiGqhu6eqQLtRpxe5fYl/vZou7fILTmMZ0Wdt3R5Uqa3TIrWmlUEIy
         XHyrlzf3kSYn5mgtgThtqNXvhP6T8emSV25rJ+IKvx9CTQHL0VrkNdOttCMehD94Wcsb
         kOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763467236; x=1764072036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Wnqp7/TvujECyo045W3JKxv/5cixkkxRASlNf6g41s=;
        b=E7ki4sVZSvVHS4Vk0VYN9V8hjHYMKG6+xpJPyD4M7sIBRW9vf7pWb90k4v8pHj++pG
         bs3EJsJExriK0pyNiGwRsxdvuMWZ5Bb2hzjlt1awmc19SsdbU9TCMlPcYvCrSLxPJnjg
         gdCY0kL3t+L2+ZE5NOC80Hrky2DuWUAtPxtvQ/dvOZWvUg5JM+qsBmkULU26NnCPmyM0
         ikVXIvFeCc1PZAPlSK/Sgc6iiwcu0zhMGylUqV4l0AlYH/4X8GdwWteCSkiwu6stNYXg
         an/oxT8ppWVup1ld0is/BCay8OxO8M6IaoEzlzN/JaRQH2I0Q1uh8GRl2Ma8Rkiu/cGm
         Az7A==
X-Gm-Message-State: AOJu0YyAq5PANOaouwEwFXzzpfn45KgBHDakSEPXFYPepWDB0skcm/1v
	UG3wfsztNKgCNe9ggfbU3XAkPBBLbK4iFrjds+WymXghazQHTi18bKNcdD51wQ==
X-Gm-Gg: ASbGncvq73SZowcK9YtuqyfCNYoZLOeMSToXCzGDARjiI865ZGFeXi5xPMmL810ztVU
	mUgYtlu8n1Des5Yoc5jdmqbYDwnnZ8k2ChO2MrtIAJoSNwVnQvi8VuBIpUer8SiadZFAqesASgO
	9Yr+PbZOn5GXY3wnAdybcvPTSeFhfULHR59P87/o2PlQOpEXHRh5pPjK3/ZiA1FmwWqvCJSG1Ed
	wl+id1rD8UXwgE4hvHuy9sZ3FqkeHsAk28O6kTsUb9jq4+zjly5cV0OGG7yr3hfkTfz6pmL5f0D
	6hIkfU0hn9Qu2mxDzS7yLm6h2SMvtS1nsipBSgFnww8TenBSa5DesHXzB25901yCycgwQVpXH9Z
	MPDqtiEO0+afoXfpXIL01mA0ASNyFE6IPSXYMG5BZCKhwLbW9RAtDtviYmequQfVxQ5oenzCvSV
	DYMiFQYztUNBN5gBdeYkuKApv29DQpHMSmoNCm4+gbI2DkYIM=
X-Google-Smtp-Source: AGHT+IHmiK2PJi4gbwyvDr0WkDbTisPebzt2OffYPKm17lkVjLBfpUCxstrrb6Qq0wf4zRyaZvm65Q==
X-Received: by 2002:a05:600c:a0b:b0:477:bf1:8c82 with SMTP id 5b1f17b1804b1-477a94fd02amr27023785e9.15.1763467235494;
        Tue, 18 Nov 2025 04:00:35 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4779f44a0e4sm145540195e9.15.2025.11.18.04.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 04:00:34 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH] setup-schema/bitbake-setup.schema.json: move from oe-core repo
Date: Tue, 18 Nov 2025 13:00:32 +0100
Message-Id: <20251118120032.3627227-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 18 Nov 2025 12:00:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18448

From: Alexander Kanavin <alex@linutronix.de>

The schema for bitbake-setup configurations was provisionally
placed into oe-core, as it is an extension of an earlier
layer setup schema, but with bitbake-setup becoming the primary
way to set up layers, it makes sense to maintain both schemas
in bitbake, so that any updates and tweaks can be done in
lockstep in a single repository.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 setup-schema/bitbake-setup.schema.json | 115 +++++++++++++++++++++++++
 setup-schema/layers.schema.json        |  73 ++++++++++++++++
 2 files changed, 188 insertions(+)
 create mode 100644 setup-schema/bitbake-setup.schema.json
 create mode 100644 setup-schema/layers.schema.json

diff --git a/setup-schema/bitbake-setup.schema.json b/setup-schema/bitbake-setup.schema.json
new file mode 100644
index 000000000..7030f1d6d
--- /dev/null
+++ b/setup-schema/bitbake-setup.schema.json
@@ -0,0 +1,115 @@
+{
+    "$schema": "https://json-schema.org/draft/2020-12/schema",
+    "description": "Schema for bitbake-setup configuration files",
+    "type": "object",
+    "required": [
+        "description",
+        "bitbake-setup",
+        "version"
+    ],
+    "properties": {
+        "description": {
+            "type": "string",
+            "description": "Description of the bitbake-setup configuration file"
+        },
+        "sources": {
+            "$ref": "layers.schema.json#/properties/sources"
+        },
+        "bitbake-setup": {
+            "type": "object",
+            "description": "BitBake-setup configurations",
+            "required": [
+                "configurations"
+            ],
+            "properties": {
+                "configurations": {
+                    "type": "array",
+                    "minItems": 1,
+                    "$anchor": "configurations",
+                    "items": {
+                        "type": "object",
+                        "properties": {
+                            "name": {
+                                "type": "string",
+                                "description": "Name of the configuration"
+                            },
+                            "description": {
+                                "type": "string",
+                                "description": "Human-readable description of the configuration"
+                            },
+                            "bb-layers": {
+                                "type": "array",
+                                "description": "List of BitBake layer paths to include, relative to the layers download directory",
+                                "items": {
+                                    "type": "string"
+                                }
+                            },
+                            "bb-layers-file-relative": {
+                                "type": "array",
+                                "description": "List of BitBake layers paths to include, relative to the directory with the configuration file",
+                                "items": {
+                                    "type": "string"
+                                }
+                            },
+                            "oe-template": {
+                                "type": "string",
+                                "description": "OE-template configuration"
+                            },
+                            "oe-fragments": {
+                                "$anchor": "oe-fragments",
+                                "type": "array",
+                                "description": "List of BitBake configuration fragments to enable",
+                                "items": {
+                                    "type": "string"
+                                }
+                            },
+                            "oe-fragments-one-of": {
+                                "type": "object",
+                                "description": "Mutually exclusive bitbake configuration fragment",
+                                "patternProperties": {
+                                    ".*": {
+                                        "type": "object",
+                                        "required": [
+                                            "description",
+                                            "options"
+                                        ],
+                                        "properties": {
+                                            "description": {
+                                                "type": "string",
+                                                "description": "Human-readable description of the fragment category"
+                                            },
+                                            "options": {
+                                                "$ref": "#oe-fragments"
+                                            }
+                                        },
+                                        "additionalProperties": false
+                                    }
+                                },
+                                "additionalProperties": false
+                            },
+                            "configurations": {
+                                "$ref": "#configurations"
+                            },
+                            "bb-env-passthrough-additions": {
+                                "type": "array",
+                                "description": "List of environment variables to include in BB_ENV_PASSTHROUGH_ADDITIONS",
+                                "items": {
+                                    "type": "string"
+                                }
+                            }
+                        },
+                        "additionalProperties": false
+                    }
+                }
+            },
+            "additionalProperties": false
+        },
+        "version": {
+            "description": "The version of this document; currently '1.0'",
+            "enum": [
+                "1.0"
+            ]
+        }
+    },
+    "additionalProperties": false
+}
diff --git a/setup-schema/layers.schema.json b/setup-schema/layers.schema.json
new file mode 100644
index 000000000..b5c13fdb5
--- /dev/null
+++ b/setup-schema/layers.schema.json
@@ -0,0 +1,73 @@
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
-- 
2.39.5


