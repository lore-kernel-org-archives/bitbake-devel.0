Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35898C8303C
	for <webhook@archiver.kernel.org>; Sat,  5 Jul 2025 06:26:22 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web11.12851.1751696772794391187
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 04 Jul 2025 23:26:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=CnVHFWyz;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a6e2d85705so617787f8f.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 04 Jul 2025 23:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1751696770; x=1752301570; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=tqDlY69O3W1oC0UFLr65XGVQsPqGhosVs0Lex141aNE=;
        b=CnVHFWyzw5/PqGArFhXpr1Eurj3eDpP6aqNeRpkPJJ2KTYfYzZOlNkPBIm7w+O0Y/G
         ts0Fjro+if/oLutVZOpa0A1mwWVHVjhtU2n0jN0cWtDE6wclApubzag6c3vd0EWmL1cg
         t07WbtKRRl0+eLFXvoS7UkHDKHqrwf9Iz1v/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751696770; x=1752301570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tqDlY69O3W1oC0UFLr65XGVQsPqGhosVs0Lex141aNE=;
        b=bAYXneIIqRPxIE+Y1iaPt8/VASeNK4VhMSE6BbfveT6RiAvyEM/U5g/PZoYdYCYQdr
         cSluptfxpC1y4vPKbFMsxiERk22Kr1AJ1GsQRrQOydWdxN9DkUYh4uC0u8rcFTRLcN1T
         Dqj5QcIE9+YGzve5K46C6mvemWsgRfsrN9pl0DE3EYZXV8ArWwlben7ZHwxrMWbpa74m
         uJ8PvIlwuF61xtquR0Ys7qY4YbRgGHD9g4MCazneXdPF0BZFjYnOjJgSdk/+TGmXtDZm
         9cEocKmPTAFle1PYHlompfGxJKA5sY4iWS2xoChDWdsnyUnrHYe1GOzhUN2e4XHW01t8
         ubIg==
X-Gm-Message-State: AOJu0Yx0ZH76MwR/GhsVN00mFiU09iOSDCNOqh9sSxi80LrPugNKVFRo
	tilU3fYdLSB3z1gc/ixZ0Kquq/XP07pwI9fSAmdZALia2FUFi5KWyqfMVht0aYE19pgwSQLzSUR
	qPCyS
X-Gm-Gg: ASbGncsVGlUJ72xPRb0FKiB8aolx4tqHG7XUtiabAHhuJaYoAdq2n214cBlXhTEFtmk
	OiyZNYc1OdQtcjYYrLBSu/scwMQmvdUKccsFUImlRO0c7z9rmtfSizcfY4Z0WunrGsLUgn4kGSL
	v4JCHz3/jxiP+ecmbc1PzQHONvVEP7Fq4VdcFbGFgZy6OfWIN2zMDSjUQRupnPNHQ4dbKHVIsR+
	FMlvScgM9ZAksbHS79umFfMLR26ZuzHqYXDzsjx1FI05r8UNDRXjaK3/OxW9AyXRx339EHXqFiJ
	DwtyHmW+wqcxcP5qfPYHffgVR+Fcgq+sHAB3jU5bathnVqW18grBxHQH58BdkTZYyFu8X+l9ruz
	+84ZvrEV5Rfb8lYOaxbE1RouM
X-Google-Smtp-Source: AGHT+IF/RHywLLJuLQqQdVO1L+gA58OHtmZvBuFj4GMG9f1A8egDoo3QmnApOXwkjfzDX9pQDAMziw==
X-Received: by 2002:a05:6000:2284:b0:3a6:f2c1:5191 with SMTP id ffacd0b85a97d-3b49aa099d3mr543792f8f.4.1751696770533;
        Fri, 04 Jul 2025 23:26:10 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:af5:483d:7f18:d9ce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454b1698f54sm45270065e9.33.2025.07.04.23.26.09
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 23:26:09 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] cooker: Add better parse debug
Date: Sat,  5 Jul 2025 07:26:08 +0100
Message-ID: <20250705062608.3875788-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 05 Jul 2025 06:26:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17749

If parsing ends early and unexpectedly, add some internal values
to better understand why/how it failed.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 8b959cc942e..d46e1eb62bb 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -2291,7 +2291,7 @@ class CookerParser(object):
                 yield result
 
         if not (self.parsed >= self.toparse):
-            raise bb.parse.ParseError("Not all recipes parsed, parser thread killed/died? Exiting.", None)
+            raise bb.parse.ParseError("Not all recipes parsed, parser thread killed/died? (%s %s of %s) Exiting." % (len(self.processes), self.parsed, self.toparse), None)
 
 
     def parse_next(self):

