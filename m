Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BEDC55196
	for <webhook@archiver.kernel.org>; Mon,  3 Aug 2026 21:20:37 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3462.1785792034333740344
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 03 Aug 2026 14:20:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=B16XAKfc;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4954df200ddso17033615e9.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 03 Aug 2026 14:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1785792032; x=1786396832; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2bYVXj8Hqf8KcP1xg8EECS+lmIn6y1BS2U/062PTBMg=;
        b=B16XAKfcGR0rDYGvirVwJfiGkN+Z863FPs/czltkERQr6eOjpXuZOwqGEewXqBS42E
         4tXu9wXgYEeERNqISR31kE6osCtDCz4aiW3l+Ka/hWnaSqSg3MFko3XwGRF+d5SO84nl
         LlEp1uireVP8wQFczPgFwEx9uwc8jcGUmRMkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785792032; x=1786396832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2bYVXj8Hqf8KcP1xg8EECS+lmIn6y1BS2U/062PTBMg=;
        b=bqJ3rrwjW6Xjoeve1rD9tnihdqSTpd51YvIRxgCNY5EEZ9xhCyoC4qbFBnzoW4WDpW
         TYPDAGSAT+Uq5YbLN6WjLiiYEvnYfHfYbDFtrSuc91CSzxSRO6tNKkfkl0jrH0kqhkOP
         Vfo6GSDJY1Qbz8LYhsR2KnumQTiX9+OpTieXmUltHXz51daSplHCD5vDwxb1w/PvMkUw
         Uj9CLTHvSYQZ8Ld2GKvyQfvPex88VWMq4olm1S+L3b2ED3HdtSxaZKV8LuiSdgHrZPPZ
         wgCWLRNKNdRpHGrh+eCmm8gNSP9jBgzrA415m+zJIJ0Gnf1gEI8B9Xiiw5ZnpmTXKlit
         hC6Q==
X-Gm-Message-State: AOJu0YzgTQFijwEVWKG0T3J/lfl+XDcN81J9FiviTvA0swSF2EzKTrAN
	uFseMhgR+7/emir++EMQR+0RC1JekXsCwDOvdhTmeCaf1eUMqub7GTan22Fh+CN282KxPlLrbzP
	hyDiSigk=
X-Gm-Gg: AR+sD13i40Z05TOLw4ws1SPfrcPRxV6v/NK7d7EF7uuPWIF/hVFEPIkL+i3aYAdmBJc
	QAX2lTcYB5D1at6ijMKeK3y+KWxj2Iw1lM3MohU1m2dM89zdiYunelOC7jM8G/xBQlyPkwuzEOb
	rWC8XL2d1Ot6SPAiFNYVDn9359XY0QU+UAF+IOfbFBf0kBtQdN8T3c/L/Ye8n/BSattuv6iIiW1
	XhyYlP+KQhrPZszqucMDHx5GtWIdrp3lJ/HrqC/SSlTqvapavuBVCTQW2TADeWadVZF5oy4LAIE
	ZopijP9dTcqi8857aBB0rQpwE6ccGrmTXwos50jhfDNpZLQ8VHIkWaCRpbII7mfBum4pqu8c1Lt
	mKLnla04RI+J03xfq6o3xy0wCC2owHb+Quy3ChJOFnpSFAOWqLEQNXD/m/HHyghVRSKmo7AOxxR
	/cx8RF8JKrfl9Up6istW4kwVIM8jkrlHOaRcfFGj/x2mSEVRwntGvcZgjbWQG5drPhIBsaFptzn
	GIjGGCEJj/R2CFkpw==
X-Received: by 2002:a05:600c:1548:b0:498:ff3:71ed with SMTP id 5b1f17b1804b1-4980ff372a8mr237852085e9.17.1785792032301;
        Mon, 03 Aug 2026 14:20:32 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:c231:bb8c:3cc5:6216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949fcb46esm31878635e9.5.2026.08.03.14.20.31
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 14:20:31 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] bitbake-setup: Allow overrides to add sources
Date: Mon,  3 Aug 2026 22:20:29 +0100
Message-ID: <20260803212029.1921860-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 03 Aug 2026 21:20:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19896

It would be useful to be able to add extra sources to setup to an
existing setup config. If we could do this on the autobuilder, it means
we can move all the layer fetching into bitbake-setup's control
and minimise the other fetching code in autobuilder-helper.

To to this, we need a small tweak to the way the overrides file is
merged in.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-setup | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 34260139c2d..92ed563c277 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -466,8 +466,7 @@ def get_registry_config(registry_path, id):
 def merge_overrides_into_sources(sources, overrides):
     layers = copy.deepcopy(sources)
     for k,v in overrides.items():
-        if k in layers:
-            layers[k] = v
+        layers[k] = v
     return layers
 
 def update_build(config, confdir, setupdir, layerdir, d, update_bb_conf="prompt", init_vscode=False, rebase_conflicts_strategy='abort'):

