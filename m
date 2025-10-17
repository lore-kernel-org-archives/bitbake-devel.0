Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFE0CCD1A5
	for <webhook@archiver.kernel.org>; Fri, 17 Oct 2025 23:15:25 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web11.5848.1760742917300515683
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Oct 2025 16:15:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=MuYK+RvP;
 spf=pass (domain: smile.fr, ip: 209.85.221.45, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4282fba734bso83606f8f.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 17 Oct 2025 16:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1760742915; x=1761347715; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c0JingrpYfcCn9RgosdQhIaESi8TGd6IafPSLiMwi8A=;
        b=MuYK+RvPRrUOw2xe0ZnxifiYOq/OibBmORg9+hnz/U1YLy9ek1i7vAS1vcVWfoBpu0
         aKHaWqwkY8KLEnKoMwGJklt8EdeQnSSLm5ZISTdWh1uD1Sk7/OuGe+jcmmJKu4CThTMt
         PXQfeXrYVlzxfQGqM9jS3uWJfntVAmvtHN7KU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760742915; x=1761347715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c0JingrpYfcCn9RgosdQhIaESi8TGd6IafPSLiMwi8A=;
        b=qWXIdNo27reeIYRvim1BR7m0Ii5qsYfLgWqSTxKxWfxnaQCIlSa7wsfq8aT6TJ7VlH
         m2NOfhMDLhyo1AhRDaqf2z7dtit+KJzpsEbTvir5H0Yuno7bRXfMR16Pn0FS8/6on9tL
         VsqbkQuxuhOarbnTdeBf72OwD3FLHr/8SuBFpcLOFC/vg3EF2kSXEcdijfy8LSPmPpIU
         puzDTBjxzXFUIfTf6crARrJPe/dqsQVmV6SPwT+IuJmkX+L7idRJjRF3G0KtR56K5ST6
         fMsY26sOu2F/lAns+Atm8bvEZbWEYTkGj1uNE0sJGwqkuzo79D995Qioe8a5kXz2FFC0
         BqAg==
X-Gm-Message-State: AOJu0YxjmwX2YKOU9xTkZqQpm7e6DMLUtqo7b7MS+hZd2nhgQvH8MyR6
	kU666aZwBqunLhasoLCIAkXPLb0vJO6CaJ3sI8RDHwWrFHhCQv8m3Gbu+3Svz6bGcchnK7wrusb
	tNDQCXw4=
X-Gm-Gg: ASbGncuWzRWUPzvoeJLY8bn33OtSkWVAFLdjcb+lQdF2Hepq2LoDpwKlwXw7f/rRTLU
	vDk0Mi1LRNfCIBfE2daKgG6EeP1A22qT5UGxcyViEJy0BJEqwaNzOhDltgCTAKsMnA/DSttwIRK
	AdrbeOx3o+NAmz4doYfWCqQZFNTKbeF7I6gR4TZFMkvN/qkWSA+WDpSfoHUR7tWJdsVka4jljQR
	T+lBqL1H21VUnc1L5jmksrxdclDqXqCyRaUCjXzi2/rnJACJEla8IaHhlGU+kDkWjoUGeDLt2Yb
	f4E9rJokmsJlj7+qstLDRpG26YlBrb6hIem5aMbbVZLloSaZsJWcS/WHMbIIvkVHYH0aoPjgQwY
	eC+2FaH6PUk2jl0Ad+3jCLSX8P2cA1Squkw0KQiyvwVRM6iNLqX+UP+WkdU3m/RcokGJqfU/9/D
	G4WHcbAsN8ucnYeYGWZIzwa42p5+T6nUKC1502F+On5fLb+eegwDGfXDDkzbPAHCK5xYKZkeRcz
	nnfnjEJ/ze/8qk9tErdvqY=
X-Google-Smtp-Source: AGHT+IGq88gU9d5RN74BG1xKT4U0+V0QILbFMn3Wx3xy2diTwkXxfInUVI0gb4icMK7BjFykkk/lDg==
X-Received: by 2002:a5d:5d11:0:b0:425:825d:25d5 with SMTP id ffacd0b85a97d-42704d9e995mr3578248f8f.45.1760742915496;
        Fri, 17 Oct 2025 16:15:15 -0700 (PDT)
Received: from P-ASN-ECS-830T8C3.local (2a01cb001331aa0017b58d8bf04048c3.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:17b5:8d8b:f040:48c3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5b3d4csm1638330f8f.19.2025.10.17.16.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 16:15:14 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [RFC PATCH 2/5] schemas: add $schema specification to the layers schema
Date: Sat, 18 Oct 2025 01:14:41 +0200
Message-Id: <20251017231444.374436-3-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251017231444.374436-1-yoann.congal@smile.fr>
References: <20251017231444.374436-1-yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Oct 2025 23:15:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18188

From: Yoann Congal <yoann.congal@smile.fr>

JSON schemas exist in different iterations.
It is recommanded to specify which specification the schema follows with
"$schema"[0].

[0]: https://json-schema.org/understanding-json-schema/reference/schema

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 schemas/layers.schema.json | 1 +
 1 file changed, 1 insertion(+)

diff --git a/schemas/layers.schema.json b/schemas/layers.schema.json
index 659ee8da4..6d05a1f84 100644
--- a/schemas/layers.schema.json
+++ b/schemas/layers.schema.json
@@ -1,4 +1,5 @@
 {
+    "$schema": "https://json-schema.org/draft/2020-12/schema",
     "description": "OpenEmbedder Layer Setup Manifest",
     "type": "object",
     "additionalProperties": false,

