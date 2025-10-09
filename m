Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BBBCCD184
	for <webhook@archiver.kernel.org>; Thu,  9 Oct 2025 22:36:08 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
 by mx.groups.io with SMTP id smtpd.web11.3225.1760049365859786837
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Oct 2025 15:36:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=WftArM3d;
 spf=pass (domain: smile.fr, ip: 209.85.218.48, mailfrom: yoann.congal@smile.fr)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b3c2c748bc8so199424666b.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 09 Oct 2025 15:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1760049364; x=1760654164; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A1Zqwj25xhXTTp1kl3dW8ievzylOaG3Ekugae9xcc7I=;
        b=WftArM3diBvESLx8GlFM49MNynLro8NB35qCp7MF3Z1AsQk8GAoF37CLXVa3BLBWij
         rektX+Enx7+VtQluiVIkSaB2vOQRHyjhL7OOqX5KvLmJXiN64PIzsFUCmZdYW2HtDNxJ
         XQd7KgOA2F3dnUp4+A6CNPYDFtp24iz5l+r10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760049364; x=1760654164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A1Zqwj25xhXTTp1kl3dW8ievzylOaG3Ekugae9xcc7I=;
        b=sYRoFjlT8+N88GZbHeYBZoRaTNn0eCauW64KBrIjevBmk0sL/xD2AHfQOu7ExHoBMP
         RvrtHiKh8LniNf47MOKsSdp4y1bfujI3cmEDckvIe9s8aKhuIhpku4FPVKgo+0qUTwid
         tFyQklNT7xkijTWdTK9KYrW47WQYk4f7VMbAoOFgtOMz/dV/LQ/4CtzzpSmHfLKkWwR3
         4HAaRncYjgHvTM00rB3lOvGb/56jxIK86hz0ju2qdBqGv67BFk+4VBhAMpC7qgqtK5V9
         tUrsm1a5jXwY0r7XxcwaSRI6c4ao+PCxJS32Qd7n5IPO/Sw6votw4uLfmewHRLIE+9IC
         QTmQ==
X-Gm-Message-State: AOJu0YyglOQnh0Kj74k3ptN98ZUvRhPp0QLpprUSa5Qlwkba6+tfkBym
	KrmsvvVzBcStXWRl4nQoFjufjQysHyNe3+tQmIMUApSXGRBSeU4NObWtHagy0IikB1/C2FlkH2X
	lHICs/6U=
X-Gm-Gg: ASbGncu0ZF5KvvqC3QNXPtKT0HFd3rYyKXxVLpyNdf04fh85arN9GaJOdaYllayYCpN
	eyLeT4Po6PLZsmukaKFn/ImDDlZV1O4OMOWX+5go+VkGvN4yfnribmqoH3e45z5eIzRULZfm8Hr
	ftzBwkEKRRyhMIko2b8fc8CgfXO2/AoBD560g/KWj8yiF8Ddnb5WHSHot9jpvgcGHEYUx4DdxE4
	0ssjj1i4eal028vinBWxlU//KHt8F8TmYzyQ63Vuv+YkYmob5QOCL8t3/x1SORwM10yVAk2XA/+
	DFdccL7OCnLhz5C8djVQtBe9hm5CzdbCss9yZFquuRH8EezX4q0Qu6uF6DW3TzLABe1N87SLR8e
	P2aJAJm2PSKmCaWMAVYt8wXi0ucwpYcYx/6sKv8Ybtdrz+T/o4J38XqJuDwiSvTAEeNZXY/++E0
	uyrMVE78QlXdep0ZSMYzOh2lfWwuNmY+c/+0i6tXiu5+Nb9sJPexq0YHST4v76ZNzpYQ==
X-Google-Smtp-Source: AGHT+IF3JmiFzeoOflHXq2id3+ICy7u2uFg/zX3Szmvm8Tol0LU4WKBqCjHavmHwSIQf/4hlPig7lw==
X-Received: by 2002:a17:906:7313:b0:b09:2331:f150 with SMTP id a640c23a62f3a-b50aaa9bc9fmr993188066b.16.1760049363546;
        Thu, 09 Oct 2025 15:36:03 -0700 (PDT)
Received: from P-ASN-ECS-830T8C3.local (2a01cb001331aa0017b58d8bf04048c3.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:17b5:8d8b:f040:48c3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d9920ec0sm75493666b.86.2025.10.09.15.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 15:36:03 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [PATCH] ast: Warn on multiple builtin config fragments for the same variable
Date: Fri, 10 Oct 2025 00:35:52 +0200
Message-Id: <20251009223552.2648331-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Oct 2025 22:36:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18160

From: Yoann Congal <yoann.congal@smile.fr>

Having multiple builtin config fragments for the same variable
(eg OE_FRAGMENTS = "... machine/A ... machine/B") is not supported.
Warn the user to make them fix this but continue with the normal
variable evaluation : the last affectation "wins".

Added warning looks like:
WARNING: OE_FRAGMENTS has multiple builtin fragments for machine: machine/qemux86-64 machine/test machine/qemux86-64. This is not supported but build will continue using the last value.

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/parse/ast.py | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index cb06e8917..6262d9ca1 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -376,6 +376,26 @@ class AddFragmentsNode(AstNode):
 
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
+                    ("%s has multiple builtin fragments for %s: %s. "
+                     "This is not supported but build will continue using the last value.")
+                    % (
+                        self.fragments_variable,
+                        builtin_fragment_key,
+                        " ".join(builtin_fragments_list),
+                    )
+                )
+
         for f in fragments.split():
             if check_and_set_builtin_fragment(f, data, builtin_fragments):
                 continue

