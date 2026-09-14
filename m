Return-Path: <david.partain@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DF1C88E50
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 05:58:46 +0000 (UTC)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13158.1789361570089016228
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 13 Sep 2026 21:52:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=liP0n9Sx;
 spf=pass (domain: gmail.com, ip: 74.125.227.141, mailfrom: zhangqiang.zq307@gmail.com)
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747ed9866so18509165ad.2
        for <bitbake-devel@lists.openembedded.org>; Sun, 13 Sep 2026 21:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789361569; x=1789966369; darn=lists.openembedded.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BG5Ca5hLuzYMf0n94rBk8fU3BzYQcZZ8sUgFkKXyTKc=;
        b=liP0n9SxvSBueR/Yp67me5DGST5La4GgSsuHRRKtrGuw3uXaKeB/x3tK/xHcnyUwz0
         h6OppJyY+mfFXz60URBIweLOtm8SZdIbKYjYnmzCqUEfqSZ0+akp6qfwVUbF3GA2DpGO
         xgRhFN7nScXTXeN+xt+nfkFQad12MsPKR9l52Evwh9SHiXE/jF2goz4hZp8uj/Meqdyf
         BG+q1V2o+peNsJwiXAAzsfNVJlaxqW5kMcfmRgPqaRNznTBujV7zFX3gq9V5Qmm6Gd2T
         ObvmvxcwQv3En/FzaTD+2B/OLq8HRuFl5+23UPt2xX4OCWWB38LimRxRaiU0llIFc+WG
         9uCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789361569; x=1789966369;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BG5Ca5hLuzYMf0n94rBk8fU3BzYQcZZ8sUgFkKXyTKc=;
        b=WYmdTA0yHnzRK9bQ77hScnacgomTUfyCMFaTVH+0JUnC7KfbCKMtZb/wGVs32roFbc
         NBcu2Ma8nJOBcCiGmXQvdfeDKe4u/ajERGAXGuyZ03pipMk7kfa/g9zS5P1uUF2qB+KH
         +8IzDg0iIKwSEP82IX0IpQUKEHCmW4zCeRO6LjgBo5mnXrNZ0qTFzPmvzC7cRKO9q87p
         XcBPPMPcGXAJYjdtzFZIBGz6CUiRSUWPjQBh93mZQe6xt0qDOUaxonyVvH48vyt9ExJv
         u/k62120PV5FihGHIxJ8j0wppFWw14VIFvWiuDKY58XBWf5/evMCrEA22TpIzEs1Bmtd
         bDNQ==
X-Gm-Message-State: AFuF++maO0SQL1GLhuo5NalpqzYbN5lOYjGukuXixQbzfqONFHVo4whb
	peQg+2vXs1R9LlU+yJ4B7epCU9xi1oMRB3vwSpe++HM5JyHupKx0lGxfkDj8m1HeKhU=
X-Gm-Gg: AYBFou3YZXQmj7HU6U120ZA4nr1+C7qLrM0VFwA0Ayl4jOGHoyQLfhn/2bL3wt3v9Rx
	dpSFpr0f/ACMEIs0X8C9mfMVmDEjRTXJCpLvZ7V1xl166M/HuArnptHn8IN9QvI6uqEJgMpAnTF
	p7znGeg1Jv7cRhNitQBRyIbI4gxMmBV4SjSvByoN++V+6tYQOiJ7A21kqz20d5dvwB9Et8dNZ7I
	8v5iZVIUWUiGn9oyPBHUZC35IuZOk1XK9k9nDSLMDeocKJBQek+S5rdwBNeitpN+quyHqeuxY1f
	knTGDey+nznd9eSGYwYpgdTvNIMgT2agsqJRl1zIk6THXFqnlX9w8IKUqrMh15sraMuckuxOn58
	Qr8IIe6j3Z+AW6KGw1M7sC4DSPmMwHbtvPPevZ/7lc+Y9w2MPIx+zSe3oY/22sQJeAPRewMPcr6
	qT50OPsaEsXpFNnayA4kSgTb3D+o2Py1Xo12yR19HfE7meV+Nt90mVyyjCGEWFXH6QkIR+riV3+
	OcqzDPznyE104SbXkpHLA==
X-Received: by 2002:a17:903:2cd:b0:2c9:bf82:dd11 with SMTP id d9443c01a7336-2dd6c5d60f0mr21986585ad.7.1789361569259;
        Sun, 13 Sep 2026 21:52:49 -0700 (PDT)
Received: from PC-203689.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cea0362sm42342305ad.23.2026.09.13.21.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 21:52:48 -0700 (PDT)
From: zhangqiang.zq307@gmail.com
To: bitbake-devel@lists.openembedded.org
Cc: =?UTF-8?q?=E5=BC=A0=E5=BC=BA?= <zhangqiang.zq307@gmail.com>
Subject: [PATCH] fetch: Add log_errors parameter to Fetch.download()
Date: Mon, 14 Sep 2026 12:52:41 +0800
Message-Id: <20260914045241.1439135-1-zhangqiang.zq307@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 14 Sep 2026 05:58:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20189

From: 张强 <zhangqiang.zq307@gmail.com>

Fetching an sstate object from a mirror can fail transiently and is
recoverable when the caller falls back to running the real task.
The unconditional logger.error() in download() makes bitbake exit
non-zero even though every task ends up succeeding, as bitbake counts
any ERROR message towards its exit code.

Add a log_errors parameter so such callers can request the first
fetch failure to be logged at WARNING instead of ERROR. The default
(True) keeps the current behaviour for all existing callers.

Signed-off-by: 张强 <zhangqiang.zq307@gmail.com>
---
 lib/bb/fetch/__init__.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch/__init__.py b/lib/bb/fetch/__init__.py
index 55ab710f3..0c3a4a7d4 100644
--- a/lib/bb/fetch/__init__.py
+++ b/lib/bb/fetch/__init__.py
@@ -1884,9 +1884,12 @@ class Fetch(object):
 
         return local
 
-    def download(self, urls=None):
+    def download(self, urls=None, log_errors=True):
         """
         Fetch all urls
+
+        log_errors=False logs the first fetch failure at WARNING instead of
+        ERROR, for callers that treat a fetch failure as recoverable.
         """
         if not urls:
             urls = self.urls
@@ -1957,7 +1960,10 @@ class Fetch(object):
 
                 if not done or not m.done(ud, d):
                     if firsterr:
-                        logger.error(str(firsterr))
+                        if log_errors:
+                            logger.error(str(firsterr))
+                        else:
+                            logger.warning(str(firsterr))
                     raise FetchError("Unable to fetch URL from any source.", u)
 
                 m.update_donestamp(ud, d)
-- 
2.25.1


