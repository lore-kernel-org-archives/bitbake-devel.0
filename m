Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7886CD47CC3
	for <webhook@archiver.kernel.org>; Fri, 16 Jan 2026 09:57:55 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2684.1768557470025815781
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 16 Jan 2026 01:57:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=W4iMD/C/;
 spf=pass (domain: gmail.com, ip: 209.85.128.46, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47ee9817a35so10035955e9.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 16 Jan 2026 01:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768557468; x=1769162268; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VqgEmFFhoWtfdUEQaygrTrCLuf0rbC6Miu1guZvGFX8=;
        b=W4iMD/C/SNHdVpkcqb/4od6cUziPYEjMsG04eHjXqlc53BL7SGn3T2g82ZvM2+s2pa
         nYbjCMrSEmXBtGZUPvnOVplqRug63MYAM9lGVU8ww80NW8G2i85pN7QE/c3MzuGKrz/N
         TjGgMxXU1sb0MaCBrkFLTPYnM/wAmH37oCngekeG2YwLWpefoCMJsZbGbCd5iPva9DW1
         H5JDNt/8xfXI5RmXm1IFbyvhbsQLeiaeE494mhjAwkXcNgLMhMkl398uQlCyP0MjRKZ6
         82++XlSP2jEUHdvdDBlWwy7KWMge0itCAajZKpaupG3vudrPd/XbcNm2HD1TwotrnLPP
         3ddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768557468; x=1769162268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VqgEmFFhoWtfdUEQaygrTrCLuf0rbC6Miu1guZvGFX8=;
        b=HgP2ZsKplrzxydwjQvfDhkFrphhrPwRZcLO+gPlvxGHq9ng2tGUSDvlaC23JGClLKn
         hclDMyOvYEIeCEr5Wh3xrPerVPLnj7OmJA1khcglQaF/9/FbJHd9Mr6up95Rpc368law
         Vux7XHZ863qzQx8fppgIP8Cxo1hBc0ijVKbzJX3wivMcqy2LqqHDt9n3Pij//TA4EeUY
         U+3m+KTmM68agE1mShlb/S0qCiPyo+TBxWyMTeNgRhZhxjGy4TvSSs0yrgdmy/Acmlo7
         Y87AIfmfvc8QPAHxm4L4BkM3WhsKFolfag4xbnsGspJn7o+7L/P/OkxmleIV+gfsZK92
         zrqg==
X-Gm-Message-State: AOJu0Ywb/By1Vgs917B9lwThni3UasPAy1Te40mMuZ1WPdlHIPZSX2j3
	n5XJE5lXMeJcqwiAwXgTGaawxdnI+eR9WXyd0iERORFycM8vjQZKhib4I5gA1n+e
X-Gm-Gg: AY/fxX6AE2GMSm7D/mAL1XT3oga1v44u2nwEFhP8jAk0sGqvqZII5yIQE279uZI/9Rs
	LHZzC/CaJRKMBQso1FELkKhv5wtL2J+ImFqBpxjGWYer9ezl4y3yeGjG1It3DzJP6AT2112ofX1
	wOuj5lZ9AaNxzFgEtuVQPmRInGsrBLSP5Dck8Rq/p0Lm/Tnsh617Dh0BN+ZAtyN2r69BcYUdipt
	ykMaugblxSt0QyjPSHNch2KzrUocwyT4k5JUF5SUSi7Abr1Q4RpCzgu3KG/4A9aU+5TaRg/8K+R
	rSrU+FB/Yv7JrBPHl9JhNtpVBQOBXI/CBssZ0LpnU90SdZEM9Xy2pOByrKsqtg9VJmEbXr45JMp
	K/rtGNJ4LTEfzAqeId2lyyPmvzsTch1pKMlh/WsNdjjPoUy5DP2QdXVzGv66WdIe4WVBDlk2Dh4
	OqYxFb6S+kQ/NKSeOhYtsJHdi2G/4kPT40oggGp8FqJaN5Qk4=
X-Received: by 2002:a05:600c:8a0a:10b0:480:1e9e:f9b with SMTP id 5b1f17b1804b1-4801e9e109fmr19517025e9.16.1768557468249;
        Fri, 16 Jan 2026 01:57:48 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e86c1b2sm34188175e9.3.2026.01.16.01.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 01:57:47 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 2/7] bitbake-setup: use correct registry in status/update
Date: Fri, 16 Jan 2026 10:57:35 +0100
Message-ID: <20260116095741.3654153-2-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260116095741.3654153-1-alex.kanavin@gmail.com>
References: <20260116095741.3654153-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 16 Jan 2026 09:57:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18793

From: Alexander Kanavin <alex@linutronix.de>

status/update operations should be using the registry
that was used in initializing a setup, but they've
been using the registry from settings. This is now
corrected.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 4496cb61c..b61436272 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -708,7 +708,8 @@ def build_status(top_dir, settings, args, d, update=False):
     args.non_interactive = True
     args.skip_selection = current_upstream_config['skip-selection']
     source_overrides = current_upstream_config["source-overrides"]
-    new_upstream_config = obtain_config(top_dir, settings["default"]["registry"], args, source_overrides, d)
+    registry = current_upstream_config.get("registry")
+    new_upstream_config = obtain_config(top_dir, registry, args, source_overrides, d)
 
     write_upstream_config(confdir, new_upstream_config)
     config_diff = bb.process.run('git -C {} diff'.format(confdir))[0]
-- 
2.47.3


