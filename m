Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4487CD5BCF
	for <webhook@archiver.kernel.org>; Thu,  5 Sep 2024 15:59:18 +0000 (UTC)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
 by mx.groups.io with SMTP id smtpd.web11.13321.1725551954023757785
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Sep 2024 08:59:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=aS1ul0NJ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.167.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-533521cd1c3so1262318e87.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 05 Sep 2024 08:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725551952; x=1726156752; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PkK1Ub6DoOgnHejeHzioSHCIha/2iei8NTDx2q0FTMQ=;
        b=aS1ul0NJkLf28l0R8ZGExqElhEWiV30j8srJjKF2efJP0bQPdXrk4fdSZjGxVg9ZRl
         3+bP6bJA51rYzQPh+wgjalpR4G5u9exCbUJONpWmTfY1DsHnwULD/RCjc6WkjWm78Q7P
         1OlLXXJLrfRIwEf/rRlidFI3cUJNm3wR7sn0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725551952; x=1726156752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PkK1Ub6DoOgnHejeHzioSHCIha/2iei8NTDx2q0FTMQ=;
        b=q+K2G1o4cfZbF53oyrOdqGDvRWABMdjW62It4hTgeND5GgtQYO9ieW+Dmursee1Fae
         x8xCJqmxivSFcEaFdsoUIT2xr5ROFClOKwndA0Rg+zAl9DSEWiWY2AlQ2rVRWvfgu5ao
         BLmpVoYr6oblozquUWdb/SNNk4h02Wu6VEChcvZT5fjFEFBR7kQwbUqicghAzAKElCKF
         pRz2KC+RM1b8h1PaZKQBnYAaLtLTEN7wnBz03+e6CcteAfLmxT4vZlo/2L18zM1lK5r4
         zT7JIrrdTtbN5Bp15OH1fxnQewYlZ5cOJ7mHvEaziFbbfPYns1VHjeLX0rVkq20nRwRG
         gdlA==
X-Gm-Message-State: AOJu0Ywbed/h/UNgrtZoMF91MGW55KprxEOQn4K7WSmTQhwggOTQKFnU
	jtwxTCrpL9bUDZxWAgmvuFmWqC+fpl39gPC2vI4lS5QURauxmNoMRglWWtTgb8HRMneOJjLNfEE
	S
X-Google-Smtp-Source: AGHT+IGE26ukCRD4MtqaYYBqilvgvbvX7pWIdZ1VjMRWTKuIYmmdyZLOYEYcd/GuzMb93bjFQspTKg==
X-Received: by 2002:a05:6512:3b23:b0:536:553f:a6e7 with SMTP id 2adb3069b0e04-536553faaa4mr1085624e87.32.1725551951479;
        Thu, 05 Sep 2024 08:59:11 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:b438:ccaf:fc83:f321])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a61fbae00sm156324466b.10.2024.09.05.08.59.10
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 08:59:10 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] siggen: Fix rare file-checksum hash issue
Date: Thu,  5 Sep 2024 16:59:09 +0100
Message-ID: <20240905155909.1595157-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 05 Sep 2024 15:59:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16540

There is a subtle issue with full pathnames being included in the
file checksums since the sorting might be different depending upon
how layers are being setup causing hash mismatches for recipes appeneded
from other layers with differing directory layouts.

Avoid this by filtering out to the path basename which is what is written
into the sig data anyway later in the code.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/siggen.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 8f24535528..a6163b55ea 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -878,7 +878,7 @@ def clean_checksum_file_path(file_checksum_tuple):
     f, cs = file_checksum_tuple
     if "/./" in f:
         return "./" + f.split("/./")[1]
-    return f
+    return os.path.basename(f)
 
 def dump_this_task(outfile, d):
     import bb.parse

