Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5001BCAC5BB
	for <webhook@archiver.kernel.org>; Fri, 10 Oct 2025 08:29:35 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
 by mx.groups.io with SMTP id smtpd.web10.4167.1760084970200048050
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Oct 2025 01:29:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=v1oRPjY9;
 spf=pass (domain: smile.fr, ip: 209.85.208.48, mailfrom: yoann.congal@smile.fr)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-62fc89cd68bso3622795a12.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Oct 2025 01:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1760084968; x=1760689768; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iaIxxaMECzNPXWI/hpiMTdrQDzTbhCE76k2Pq5C8iYQ=;
        b=v1oRPjY9Z/POjQA1x6GMPG7vPbgQm9yIrjFMtnLTzLp1lNSyiAZvRnCP83TBb7NzOJ
         rQo7s/mOGKtHIGcUyEg6JYA1N8O81/uBOx6arL3xIy7BGqqCs+iy+GWJ1ok/fYRPhcRu
         GkzgIMniKpEg9mJD4Rz1MpefiNf6aOpQr2AbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760084968; x=1760689768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iaIxxaMECzNPXWI/hpiMTdrQDzTbhCE76k2Pq5C8iYQ=;
        b=VX+6Xq56ZDZM2+PNVJT9ztQTTqukSgZyVOTAklxRpm4da2+6SSQyELQGKD9Mf9P3La
         30tu9uLVt1SDRH4IaKgukfeF11cT2qK06b2m1JxaV9o0a7zX4YWeXb3W+Q5MwfYfJIyQ
         nBgjUXbQPSTxyncMSWRRA4e3jZkKSykSc119jw7zP+y9YBBJTA7w37uA3+pEvTqQLqpX
         EujteZHjjgKPYISe6v+tQpsBWJmSc2//OqblWB16omfs6A3yxk3qGd0FeIc9HdhwXEkg
         8sCMHy8FP+QTppVbEJ5tC8z8AspRDerOyY5NEt2HErhxXYM0l6VqVSTfkTYIrHrcEaPm
         Cifg==
X-Gm-Message-State: AOJu0Yz5UFzO0crlXIaupaMh/p3FnrAZmlOPQ2bV1IuPwEsCZIPhhHmI
	C6Fljq7Ncd0JGjXmujbkkc305JUOTULM1bGDklW9I2smsgWWcwSiNODg4qvajIFioZXG1ORvk26
	38lOuitg=
X-Gm-Gg: ASbGncvJrzXAf8ltxtpP2NP606bp2FOALeXUodohFCGSKduRJZCtj+y5v9i8Xxa0YRo
	zVAuY1kefv6ocg+XSn+tN3EEVUD6dweXmtbo/tdp1Y4hHaLXbYhXb072BagxlU9TVMtrhk04wVo
	t7WMfEpB7RQ66CUy7xNzaGSQnGlshi+Vx6a5ud1Qzr8g821js0MLoKRJaHdZJpLvse+2ruCtOQB
	j1l+yuyw3MWh6mF7SD2+aG1kPaLlkhgyWGdqFS6zdCBIezdSM+hGT1ZrEWUfJKgrvSTR2YavDnZ
	IeaWqOAdSKpab5YzcoiqoxdSGlfVTtZ20n04pN537WmKW6hiIy/o0pOGp5hgD1WKRf2BMSWXkyq
	Nm0vThEv+f7hH9MoA+lo9UgDwWXfc54tfDXIHB5C94EcVEuGrK/Dj0lpgZLgn68cSbHWNFAF9W8
	2XeMKTTDymo/XExsTCrQfAV+Y3GAcY6ZAyWb/14TjKP0TGJqD6ruGWp2B0eXJ3
X-Google-Smtp-Source: AGHT+IH8j2nXFPWYd/YFzsuZrD5fIA+Ae7bNZY5b47BscqDi6+2PcdAwwxhARt2s1OKgD4zRxGLdBQ==
X-Received: by 2002:a05:6402:2812:b0:62e:e5b3:6388 with SMTP id 4fb4d7f45d1cf-639d5c3ec7emr11094197a12.19.1760084968368;
        Fri, 10 Oct 2025 01:29:28 -0700 (PDT)
Received: from P-ASN-ECS-830T8C3.local (2a01cb001331aa009af08a1246ddcfed.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:9af0:8a12:46dd:cfed])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a5235eb13sm1682794a12.5.2025.10.10.01.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 01:29:28 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [PATCH v3] ast: Warn on multiple builtin config fragments for the same variable
Date: Fri, 10 Oct 2025 10:29:19 +0200
Message-Id: <20251010082919.2694739-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Oct 2025 08:29:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18166

From: Yoann Congal <yoann.congal@smile.fr>

Having multiple builtin config fragments for the same variable
(eg OE_FRAGMENTS = "... machine/A ... machine/B") is not supported.
Warn the user to make them fix this but continue with the normal
variable evaluation : the last affectation "wins".

Added warning looks like:
WARNING: Multiple builtin fragments are enabled for machine via variable OE_FRAGMENTS: machine/qemux86-64 machine/test machine/qemux86-64. This likely points to a mis-configuration in the metadata, as only one of them should be set. The build will use the last value.

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
v3: Fix string parameters
v2: Updated warning message with Alexander Kanavin's suggestion
---
 lib/bb/parse/ast.py | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index cb06e8917..cfead466e 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -376,6 +376,27 @@ class AddFragmentsNode(AstNode):
 
         if not fragments:
             return
+
+        # Check for multiple builtin fragments setting the same variable
+        for builtin_fragment_key in builtin_fragments.keys():
+            builtin_fragments_list = list(
+                filter(
+                    lambda f: f.startswith(builtin_fragment_key + "/"),
+                    fragments.split(),
+                )
+            )
+            if len(builtin_fragments_list) > 1:
+                bb.warn(
+                    ("Multiple builtin fragments are enabled for %s via variable %s: %s. "
+                     "This likely points to a mis-configuration in the metadata, as only "
+                     "one of them should be set. The build will use the last value.")
+                    % (
+                        builtin_fragment_key,
+                        self.fragments_variable,
+                        " ".join(builtin_fragments_list),
+                    )
+                )
+
         for f in fragments.split():
             if check_and_set_builtin_fragment(f, data, builtin_fragments):
                 continue

