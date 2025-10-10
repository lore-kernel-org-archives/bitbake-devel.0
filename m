Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B0FCCA476
	for <webhook@archiver.kernel.org>; Fri, 10 Oct 2025 08:06:45 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
 by mx.groups.io with SMTP id smtpd.web11.4150.1760083594841382760
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Oct 2025 01:06:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=CrNKjOx7;
 spf=pass (domain: smile.fr, ip: 209.85.218.50, mailfrom: yoann.congal@smile.fr)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b472842981fso221135866b.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Oct 2025 01:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1760083593; x=1760688393; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qMB463r7yiG1EDXTma5YlXPUHqs58rcrzdY6Q5MLg4k=;
        b=CrNKjOx74THTr8MZvNP13JV4Cp9V033AUwhLaxaRHir0rmsiQThq7d3DRjN5Hj4ZLB
         nQxqN6rP8lTlzbrzjF36qDBv2CuHJJV4fT2ldmLcHHJbSBhh33SiPIa4OYHtskfnM+ne
         TGBST1Lerif78/8No6pYBwmoqAXJrBPjRdoaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760083593; x=1760688393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qMB463r7yiG1EDXTma5YlXPUHqs58rcrzdY6Q5MLg4k=;
        b=e3jV+lFFXTXUieRcnlhCnd3CA9DneIiSZHuL3O5rx9/PvA9+Dz6irmwHJJpatHMD2N
         cTl3soJFPbgrthfFq97vIXJnF3Hcf/jogZGgSiN7z4zBYQYFXJf6xhWGrS8oZwi+YJav
         hMZp7K8LIz2dSsVvNJ4dfPrdJNexjxUBlWdGww8GadUenGs0WwpZBuoJymQvhWeEiJN1
         Mnk88hLiQ9SM48BkHt1ZJfyiEGjyl5X4GRZmIrmcrLLQX2bX7v2/AvxECeuIXKXz+AeG
         VmW8aoTd02HFDRpD9VgEoxZbQsbaCogJ2Ot/1BE+Yjk1dV4R5pKEIWSPTUPr2njXAhhO
         L6dg==
X-Gm-Message-State: AOJu0YyRDr4rlqUuizSq4bjplfOXlWZRBCD8fUpXLNHVUyxQFhN2HvDu
	Z9zbeOCoimGJSfZOWkkLUz+n+rd1M49zmeRio2EZtr5KQbaxyPzz043yUSbzz+QJujnGFC/RtvZ
	Tw6knMq0=
X-Gm-Gg: ASbGncuG8dHD3oAfxSdxbVqh7FC77XhqKWPkpBhDcEUCAN2sJoEseBPhiALCNg5RQt/
	CFB8PITCMMSpTrfa19hA924M+Fd0zBcPST/NQ9y57p5kiyLycTMmJEygCBhg8lBhMapwEKEY4ZA
	MYwrTn3JWtTC3Gko+FxUF4Km4004UODnnHco+PdpixgyntSllLkrH6i8T6WeSp+MaSVbCw8GT4c
	3HGmeCiwkiwUSFxqvAxaOtVxpGo955KUbY6OSPqT2idEidY4whixSCfUVJoi5oXa0+5M0uITBv8
	K6cvfDQVAKLAMNan/Pjf82APj33CnwrG4OW9enLfocKHKlpGyURXzwErIsJtulSF4yDVmU5lVT0
	JRdpp4dj6ZrCQtOCMZDjdxTLNY0nSHghCFYJIgrRiI/Zj4eVu69/wY70wjMWNMtPo0d8dpkG3Xe
	1brA9uvL4c2y/EoamI82OFqc5O02tsUd+2utcnrh38hEb7DLR01g==
X-Google-Smtp-Source: AGHT+IEZIn4VwH8hu19M/7M8KgrfsAcAwrB8Mdn0afFiq31c6ikj0yhcE4vxi1rO3uwluAnJbZ36FA==
X-Received: by 2002:a17:907:6ea8:b0:b24:7806:b59 with SMTP id a640c23a62f3a-b50ac9f86f9mr1092465366b.55.1760083592830;
        Fri, 10 Oct 2025 01:06:32 -0700 (PDT)
Received: from P-ASN-ECS-830T8C3.local (2a01cb001331aa0017b58d8bf04048c3.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:17b5:8d8b:f040:48c3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d952a273sm180287366b.83.2025.10.10.01.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 01:06:32 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [PATCH v2] ast: Warn on multiple builtin config fragments for the same variable
Date: Fri, 10 Oct 2025 10:06:19 +0200
Message-Id: <20251010080619.2688482-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Oct 2025 08:06:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18163

From: Yoann Congal <yoann.congal@smile.fr>

Having multiple builtin config fragments for the same variable
(eg OE_FRAGMENTS = "... machine/A ... machine/B") is not supported.
Warn the user to make them fix this but continue with the normal
variable evaluation : the last affectation "wins".

Added warning looks like:
WARNING: Multiple builtin fragments are enabled for OE_FRAGMENTS via variable machine: machine/qemux86-64 machine/test machine/qemux86-64. This likely points to a mis-configuration in the metadata, as only one of them should be set. The build will use the last value.

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>

---
v2: Updated warning message with Alexander Kanavin's suggestion
---
 lib/bb/parse/ast.py | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index cb06e8917..895c020ce 100644
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
+                        self.fragments_variable,
+                        builtin_fragment_key,
+                        " ".join(builtin_fragments_list),
+                    )
+                )
+
         for f in fragments.split():
             if check_and_set_builtin_fragment(f, data, builtin_fragments):
                 continue

