Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76929CCA471
	for <webhook@archiver.kernel.org>; Fri,  3 Oct 2025 15:14:31 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web11.10167.1759504469350855969
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Oct 2025 08:14:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=KnVTfB2H;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e2e6a708fso15782625e9.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 03 Oct 2025 08:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1759504467; x=1760109267; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fnhiu6XmYFqzQMfKmxuRHguRIshezhikmsKNiG3Xzvo=;
        b=KnVTfB2H3J7nbh4GEWXFQeQTkwsQgieZpDedMOBQIcLOxUVWfb3NhTd2YttMUu9Jgd
         ThdR0fAHnqmdaW5/SP0fBx+S8HzFTlf27eBh73LECJff9Bq5hUR2GH6EE5NVEmdtX+bY
         4NPB6vk0WZQmySWb30CydfStHWx9m3LDx2dkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759504467; x=1760109267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fnhiu6XmYFqzQMfKmxuRHguRIshezhikmsKNiG3Xzvo=;
        b=Q5EBQckD1YwD26ZLJ6T807V1k1lpfMC9dLbIoqiJEDm5w+IPQ0eTWU3OhctxJCKNAC
         luHl1Ml83rot5F5PeeGhEWGC1JGFjBJlF13g8Eho6OlCoKpv5OKCLsoMSCsCVTveFXKy
         4CERO4R998ZsqgCTDVk+vUlWPQsJrgbEPOEuVjpylWoLA7DDIoSRJeDeVfCjoDuXJvke
         XUgC/kH5e8BKuCShYaxgwAn125Xctrma6AN2TR37jRykAhqQh2S7nkgto2Dsnji7RFEk
         LNV9bn2xsCfH+HOsL7MSq4Pvy2BdtSIyyHTqjhXPpF3OeninoG47LOaaExNCq+29bMRD
         qeBQ==
X-Gm-Message-State: AOJu0YxecsLtNzp8VF/DDnTYXZSLRt4Hy9GQ50EU9bpZ2HLseWOQE5EG
	gJWyQDJQQ/Gpgf9fX5UB5zei5x5cZ0r2dy/EJ0q03NBc2ZDIiCBS3ikV0+DO61T8y1Y1BVEsE/I
	FUPIx
X-Gm-Gg: ASbGnct7bkdfjj3eLvYdWvL0oEmaECYyC6WkMXXTC3HCPlx7T+B3skbD/02iltJE9RP
	PaGeQrSEC0+OT1rhRxsuGloiHgAsYSZ3V/XlEK8jGtMyCokXFYZvLktUtaUepMbIwsRt54gl26C
	2u0UEvrLioFf4kc5rGsH/6a8uehYFvsWS0e8ADRinu+OVm5nRynOpA585+guIa8dL009SHmiLHp
	Lb4NHgDBZYpL5WOedWhmUfEWXHylmW3gRJtE2GA8CRtEoIaczRklp0C5hwwMTArhcAhvkvaARS6
	ogsvVrscUiMxno22VYC9HSKNHI0kDL+HvNXaeutAo21Rf5cdb6skD65HWuXyUcMA4R6yK9NvjkJ
	QWFPTqowpMJIH7V74ZqhUK8FMJoP8UECbiCO1m/4w5u7mFLZkn3gwOJ+ubpqd1jKw33AcZ4Q1cL
	bgbCae+3h0
X-Google-Smtp-Source: AGHT+IEg7jWNF4EFyJndMTD17uilmewO2qf0vD8J01/HBpdmSCH57FVUGRehRjEhbhq6gDtOBS2icQ==
X-Received: by 2002:a05:600c:4689:b0:46e:440f:144b with SMTP id 5b1f17b1804b1-46e7110a1e8mr23121795e9.14.1759504467035;
        Fri, 03 Oct 2025 08:14:27 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:67c:cc8a:4a49:c12a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e723624b3sm34437435e9.17.2025.10.03.08.14.26
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 08:14:26 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] ast: Fix fragment behaviour with overrides
Date: Fri,  3 Oct 2025 16:14:25 +0100
Message-ID: <20251003151425.487245-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 03 Oct 2025 15:14:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18133

Imagine a machine fragment machine/A and a configuration which sets:

MACHINE = "B"
MACHINE:forcevariable = "C"

As I understand it, the fragment behaviour was intended to replace the
MACHINE = "B", so the override would still be active. The current code
replaces all variable overrides.

parsing=True, switches to the other behaviour, which I believe was the
design intent and the behaviour users would expect.

This is useful to allow test configurations to override a MACHINE setting
without change the fragments which would complicate the test code.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/parse/ast.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index 3250211e607..2a98809fa5b 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -363,7 +363,8 @@ class AddFragmentsNode(AstNode):
         def check_and_set_builtin_fragment(fragment, data, builtin_fragments):
             prefix, value = fragment.split('/', 1)
             if prefix in builtin_fragments.keys():
-                data.setVar(builtin_fragments[prefix], value)
+                # parsing=True since we want to emulate X=Y and allow X:override=Z to continue to exist
+                data.setVar(builtin_fragments[prefix], value, parsing=True)
                 return True
             return False
 

