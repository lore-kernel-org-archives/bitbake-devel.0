Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1BECCD1AA
	for <webhook@archiver.kernel.org>; Fri, 17 Oct 2025 23:15:25 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web11.5849.1760742917846864206
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Oct 2025 16:15:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=QAmnhWbg;
 spf=pass (domain: smile.fr, ip: 209.85.221.51, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-426f1574a14so1476201f8f.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 17 Oct 2025 16:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1760742916; x=1761347716; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FihqOw83/3BqydENvAtKluDIncNWS15FK1Evg7jj5Oo=;
        b=QAmnhWbg1W2MSWwauQqSer02KM+lB95y/03fAzb4wJRnHN0XfihzAEJmxDfGeq2Fu+
         oTMYi8dUO+XnTU3NL8r8s/tvNp8ZLcuooph76YNxJkJj2hPvguf5NqG/pf24Ep1rvr/l
         G/YN/xa2a4+Yq+s7D0NHA6yaq51botnv/Iaa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760742916; x=1761347716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FihqOw83/3BqydENvAtKluDIncNWS15FK1Evg7jj5Oo=;
        b=mXhhB2efXTxHh4h+NC1ZJjgCz1OjJonnnJkaChR4ItVCn4OF3q+RgZ2rLV6e4/KR9K
         0brXIsBEo8rI1FotFAPZAwOoJGMQJ8Jlp+cHrFb5WIqzfXh0xLGOykW2Jjx6EJlkCHXB
         Yvn6Fz8O1+eovI3+WWLGI7vkOwpECZG9hTIMfW67FJaj69tiugSJA1o/QY7JO+Q4trRw
         oADQ3hX3lWdeVihMvTDyS0Q2Os6X85CTEISwFJn67cvVKmN8c5d47HVJYuxYC2Clve4e
         HRmdPdiYTglUhkWgGdxpnsPdrE9jNSvMzH3fJU0V+LdRyt7NA4xG2VLwY68GRMXxiq2B
         WmaA==
X-Gm-Message-State: AOJu0YwNIhfsKpg/YNPudNjj9h88zTcDj24QEn80HgBLA/W52MaBtVte
	/zurjmFb/oUifoU2yT9Y03tVTpdx7b8wk2pE/xpD7exJkjICOXVsfIQhl4BpwCD7lLckQzlr2s/
	RD4HTe9s=
X-Gm-Gg: ASbGncuwz2cZQfJBtP8JRCR1fyX4XCzqqXETaMHpkK2o+IcI6+WRZCAFzSBBuunNDzH
	iL9Nj5hrySe8mKmEFNoQhILn9S5E2ZhL9wIDe8Z+/cMZQigb1pGtTNBdYPKavNOaolsKdP4uAGv
	lptWyASKurqBlI5zmi/Ih/rDmv3noGDoYLVdi9XXzgn3AjScSHSkpvygLSb90XPptj8d+3f8ZjK
	ycqa8EJb6phWdcEeCrdlCKIakc+Rq7BYMeiYduweG1ZtSw2DJGreTo1FJ5PLUodsUaT3om4apDu
	chsdTw8INeKDJjnICd37JayELpNMLUPLxwKlU6dByFUMargjQYHpNTQJemggzxUBVmXmTq8Y2Z8
	patJhXvP+Jyukq/DBy7Fv8eB+crpZdhk1SDOExMAcwGIj2IZJsvzam3QbWw61n9KM8SMsxaGXKd
	XlVoHeTcLH0pwNv9O0eoJcL+JC6HgzQj6zzAv+q4GnliNvnMXdzPNMQ+BIJy85qSQa5XFdphJuz
	3sC3fn2gT0TaHTWaZi+z/8=
X-Google-Smtp-Source: AGHT+IFC6y5CL6V91WeQdQtd+B+OScSturcQzCI18DNinJsj8P0wC6N5RvNHpmK8+kWZng14C3gKzg==
X-Received: by 2002:a05:6000:2303:b0:427:6c7:66f8 with SMTP id ffacd0b85a97d-42706c76a55mr2840623f8f.52.1760742915912;
        Fri, 17 Oct 2025 16:15:15 -0700 (PDT)
Received: from P-ASN-ECS-830T8C3.local (2a01cb001331aa0017b58d8bf04048c3.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:17b5:8d8b:f040:48c3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5b3d4csm1638330f8f.19.2025.10.17.16.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 16:15:15 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [RFC PATCH 3/5] schemas: Add bitbake-setup JSON schema
Date: Sat, 18 Oct 2025 01:14:42 +0200
Message-Id: <20251017231444.374436-4-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251017231444.374436-1-yoann.congal@smile.fr>
References: <20251017231444.374436-1-yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Oct 2025 23:15:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18189

From: Yoann Congal <yoann.congal@smile.fr>

This schema validates configurations in default-registry as well as the
configurations used in bitbake-setup selftests.

Note: it uses a reference to the layers schema for the "sources"
section.

One can validate a bitbake-setup configuration with:
  pip install check-jsonschema
  check-jsonschema --schemafile ./schemas/bitbake-setup.schema.json --base-uri=file://. $BB_SETUP_CONF

RFC: I don't know how strict/loose I should make the schema. I've tried to match
what does accept/reject the current bitbake-setup:
* If present, a "bb-layer" can be an empty array.
* bb-setup accepts "configurations = []" but it results in a impossible
  choice in interactive mode. I rejected that in the schema and plan to
  fix that in bb-setup as well.
* In each configuration, "name" and "description" are optional but the
  flatten configuration must have them. I don't know if we can/want to
  represent that in the schema.
* bb-setup need at least one of "bb-layers" or "oe-template", that is
  not enforced in the current schema.
* '"additionalProperties": false' makes "comments":"..." impossible
  right now, I plan to add them later.

Also, I'm not sure this is the right path to store schemas.

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 schemas/bitbake-setup.schema.json | 108 ++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)
 create mode 100644 schemas/bitbake-setup.schema.json

diff --git a/schemas/bitbake-setup.schema.json b/schemas/bitbake-setup.schema.json
new file mode 100644
index 000000000..a5cef7633
--- /dev/null
+++ b/schemas/bitbake-setup.schema.json
@@ -0,0 +1,108 @@
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
+            "$ref": "/schemas/layers.schema.json#/properties/sources"
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
+                                "description": "List of BitBake layers to include",
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

