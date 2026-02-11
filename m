Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F64EB5968
	for <webhook@archiver.kernel.org>; Wed, 11 Feb 2026 15:57:58 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22208.1770825473698854518
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 11 Feb 2026 07:57:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=W/+VNX/k;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4834826e5a0so23197025e9.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 11 Feb 2026 07:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1770825472; x=1771430272; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=grnn+QGwjqgNBeTfjeusHrPdsisvTWM75ialQ/5awd8=;
        b=W/+VNX/kctGh1J/l8CLGgNTbfqb555jh2vsD2BVh6ZzuUQNhwu0j8iMzjaL3lzGK8v
         QpaRU1KeniA9ddqbo0X6M0Af+JLAzt7ylKMQUaur09v45fu9wK/ZtFpXdpbxRVXfRDKd
         JRI5sZTdrAdT+Ed27NTmgnroPLZZDCISQUpPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770825472; x=1771430272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=grnn+QGwjqgNBeTfjeusHrPdsisvTWM75ialQ/5awd8=;
        b=r+ZXfwvgflS+2ARq/KMFGAyYJXxjSu8Li/xjWqdZjsanEEnVUvn22ThRJBwNXtQLA1
         mWACDiO71x0FGLvePzvI3CrCsuJ61u6JLW+EyiHjFCroxMLWCfuV6ULiJLAH5pMQSNLv
         w89Wd0VtVwntYkBT9TOmqVkvghI0pNb+GuSqWNUG3S1CGIimVFmJTH+E18i9Lp54t5PW
         XPFHPegahFi4OzozearU7HyrHqBDgS2OLm77fH/wqvk7m4Z2gton2tu134Ce2+7I4PXh
         XYR3Dh8RQd5GSc0AG20q9aDZ8TTqKd5P/WVlm2uhMCvka2ZwLIWvfm10S3SoUnBAsN2H
         G3Cw==
X-Gm-Message-State: AOJu0YzNXEG9pU1j4MyR6JatxLO6ymwWI0U2WLzuv2ao5a3EmGauezTp
	4EQNoGLHEbqC1rYGco4LxQhcksNGW+yv/WLbTzjCh+1lcOOcLWGRMcwwZWVcBrwYrENrDTMNHIt
	4HiXxse4=
X-Gm-Gg: AZuq6aJHK9BTSK4DGgZA8XVFLsLlJzSkeLveUiZbkws0Iu4Bv7Thd56oeSi1Ovr32lB
	K5WfpHmDp0ajd0FvIxPUgWb4Lgwc/T4V5QxNR2O4L3j/8qS/Qc4/qDDifxbhvaPQyxvLkg0Lckg
	bsZmTsgp2J6TzU0655YRRlvbHlPHxgFIzq3FbbFdDbcDz8kSi/kdG34M4uhTyTUBI3HcuMY7UWK
	ViGH28+T8hSsTUErd97h5wIIFWxnTSamBBQnUlFUp2JrUbWQxAHYJULSx8PVHJ/C1wjqtSiAMWZ
	3/wYabrdQUzQ8DMRFXqeRWJaibIEGaN7ZVIMCGtIbAZR5ta6KZ+4gyG404zTGjvfHPl1Afc9E/M
	ls+lalBCUXcU323xALEjR31iynS07un2jNo0d2ToJsOJ7lah8MUWusMrLVizbn+3dVGPltEk5Y0
	wR3rlWI9bpwl3okQ7fkrDqbV6wlIY95guP6RjpPtuTZumSUp29fw==
X-Received: by 2002:a05:600c:5253:b0:480:20f1:7aa6 with SMTP id 5b1f17b1804b1-4832021b53dmr294409055e9.21.1770825471373;
        Wed, 11 Feb 2026 07:57:51 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:cfe:c2d7:e79b:dfdf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835d994670sm41642515e9.4.2026.02.11.07.57.50
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 07:57:50 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch2/svn: Use server certificates going forward
Date: Wed, 11 Feb 2026 15:57:49 +0000
Message-ID: <20260211155749.1254390-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 11 Feb 2026 15:57:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19005

In the past, broken SSL certificates were common on subversion servers. As such,
the subversion fetcher used to ignore these issues.

Cert infrastructure has massively improved since that decision was made and things
like self signed certificates should no longer be common place.

We should follow good security practises and not have this as a default anymore,
remove the --trust-server-cert commandline option by default.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/svn.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/svn.py b/lib/bb/fetch2/svn.py
index 0852108e7d9..a097ffb76b5 100644
--- a/lib/bb/fetch2/svn.py
+++ b/lib/bb/fetch2/svn.py
@@ -34,7 +34,7 @@ class Svn(FetchMethod):
         if not "module" in ud.parm:
             raise MissingParameterError('module', ud.url)
 
-        ud.basecmd = d.getVar("FETCHCMD_svn") or "/usr/bin/env svn --non-interactive --trust-server-cert"
+        ud.basecmd = d.getVar("FETCHCMD_svn") or "/usr/bin/env svn --non-interactive"
 
         ud.module = ud.parm["module"]
 

