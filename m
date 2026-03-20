Return-Path: <zhangfei.gao@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F09108B8E3
	for <webhook@archiver.kernel.org>; Fri, 20 Mar 2026 09:44:17 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9105.1773999853080358634
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Mar 2026 02:44:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=dLGKJKlV;
 spf=pass (domain: linaro.org, ip: 209.85.221.47, mailfrom: zhangfei.gao@linaro.org)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43b44c0bcdbso1559885f8f.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 20 Mar 2026 02:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773999851; x=1774604651; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4bE0vnYm8peH9c6Ns66/fhiFau+t2d6qXBWQm2/OTV4=;
        b=dLGKJKlVOljx2xVhMlYp8JytIIjM7LFy7PT59RnMVNgsuFAhB3CWPSZy/s3KRIW4dn
         YmHAF9W7n2tFTJJlg60UYN1PJjL+aFQMC+G7XPDiFKDPIMuijTACCqRo0+bDqKtDTba9
         GvAWVuYKVIFNJ7X+Hqxg0Qj6d42qEZbAQsuxyApeHJc6Or8a/OqOXx//S78IFSKUV9HJ
         DlrMbEbkwiP44mNnCWZ49Yj+TPweLaIjccqmU+Y8RxkQCebBELbncqjHWS0/y30UUC/4
         TZTRdD/u4HckX2aoaYkTyZVpib6YPtekZVRX+g2ePg4ruOQvdLyPuJFSorw2EMwqTV9j
         Qsfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773999851; x=1774604651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bE0vnYm8peH9c6Ns66/fhiFau+t2d6qXBWQm2/OTV4=;
        b=ZR8XRVJXrcza03OKH0Ase36mBR5jIxYYl++D2fo3HXHxXiJRgzXanvQ5aRRDGlHKzD
         zXRskpaaKjiAIcF08pu3IQ4KE+2Ga3W4RhBc1yAIXH02FY4dayNBuFKZ1s7+ugGumKP6
         D43JYMuCfmrvHM6WzGT+9ilcy3Rt0ViCP4uxV+USAv8ul51rPmMmrv2ga83SZXWubo9i
         jC8cSLVsZwi8/H25XpsIRA38PTGP9pCgTdjg8n16dw2BCFMdq+rSvDo5pVO/jlsq6DKM
         W7tVhzrPMRIug46+Kmbgz+fS1CQBokj9mzvPZgW6k6E2n3o87vIj0s+0R9Dqagb+UE9j
         rh9A==
X-Gm-Message-State: AOJu0Yy1Gsvwykti8ys78lhzGW1h5eNjk+ycXj3nwM1esvhw4phYTMWs
	0j42I4dHEywi5fHMmWvc8PiwLvqXeKmh/R+S9ylP4d/LlIXNIAANb4XGP+0CZ3cDYdB2KZRXNnF
	H+EUemaDUAw==
X-Gm-Gg: ATEYQzzH2C0lut53Tm5d7DVa34gdRJvVARep11QzLZei7YtzioQ6/ovXXg5KfFIRSyG
	maoAZK07MUsOyCScKA5Jpv/6I4FSMaUWBMyBPDieQMLR8b4re9kaVWHoKmYkDWqNTF8W5NXc3/q
	Ik0AP19ARQQemTzXLDl8w7qlUbotvhmFTfxl/OMz3UZKYqjAjJ1F009V8rPAbveo7PzRvpbmw2S
	+QcgMUOOqcOScj5nWAoKJhzwP4af8hmzOx4Zi2F36+EGsmuYADgzighZcpjSGySCZVMHNqMrklq
	HbRYXl+nNsItiWGRqPh9ASiZ6FqFesCS/81Qc4L2gSwJZo06cJWUS/KtI0H/TAdhR5vKqT+SZjk
	kydLk+163Q1Bho/nr3WyPvr9XLjWeI5Tq917tlwZagYAbzONoCYz0lIbRvl6jPQHqpEo2bEZPTr
	1+waYLpw61P8S57g1eIIMAT0zAQ/Q4mfcp8+PWKPsycDfrzdNlLGTa7+ebMrw8EsMkCrTzYhfx
X-Received: by 2002:a05:6000:220b:b0:43b:436d:782c with SMTP id ffacd0b85a97d-43b64232947mr4040858f8f.4.1773999850991;
        Fri, 20 Mar 2026 02:44:10 -0700 (PDT)
Received: from hackbox2.linaro.org ([2a00:2381:fd67:101:f4c1:e8ff:fe8f:2fb2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64717e97sm5221557f8f.35.2026.03.20.02.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 02:44:10 -0700 (PDT)
From: Zhangfei Gao <zhangfei.gao@linaro.org>
To: bitbake-devel@lists.openembedded.org
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH] bitbake-setup: make DL_DIR in site.conf overridable by env
Date: Fri, 20 Mar 2026 09:44:07 +0000
Message-Id: <20260320094407.4169544-1-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Mar 2026 09:44:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19184

Use '?=' instead of '=' when writing DL_DIR to site.conf, so an
exported DL_DIR can be reused across environments.

This keeps a default value while allowing environment-based cache
configuration in mixed workflows (e.g. container/host).

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 bin/bitbake-setup | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 53dbb6221..9d08f3a1b 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -947,7 +947,7 @@ def create_siteconf(top_dir, non_interactive, settings):
                     # wiping and rebuilding you can preserve this directory to speed up this part of
                     # subsequent builds. This directory is safe to share between multiple builds on
                     # the same machine too.
-                    DL_DIR = "{dl_dir}"
+                    DL_DIR ?= "{dl_dir}"
                     """.format(
                         dl_dir=settings["default"]["dl-dir"],
                     )
-- 
2.34.1


