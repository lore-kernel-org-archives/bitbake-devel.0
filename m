Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950FCC98302
	for <webhook@archiver.kernel.org>; Wed, 23 Sep 2026 17:09:46 +0000 (UTC)
Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.514.1790183383790151393
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Sep 2026 10:09:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=bM4KSg9h;
 spf=pass (domain: snapchat.com, ip: 74.125.229.170, mailfrom: ecordonnier@snapchat.com)
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144e32aaa1cso721926c88.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Sep 2026 10:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1790183383; x=1790788183; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GxEqHdGiFs1Tl5WYmZZIzf6pLNFT969g1CLnMkxxwn4=;
        b=bM4KSg9h1xY1eg2T3RAfRV6g9V9eLk/O+p1LEGPuZ/+fIu2v5ZJw9B/hsqb7FCpuxs
         taJk/HCOC3WcE169zuN63ikEZKofpMXDc6E83Yu12wWc6lmrnv+e0TWUL3gLf6Xu/DtA
         C3UNWxBgUKfT4uycRedny7xPKXG7dpNSUqe2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790183383; x=1790788183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GxEqHdGiFs1Tl5WYmZZIzf6pLNFT969g1CLnMkxxwn4=;
        b=tOvmNj51z66rox0zka915iECgyvhEDCYxETt35kN9LMxkEvkdpogxGPR11aXPpXJds
         uKBC381Qh4hSHiklAspD5N3RKTd+8DAfjgrB3KytRVyhqOubKMYZ7VJh027qM7mxLsWq
         yjMO4H9NqCnddMmiuohKjJEACHa7SmRpjM6qGCPToS5cdSddKPwA8WsfywdZ6Q6FIEDn
         6cziXmWmj0RYa4ebzNdkDTXZ7GPV9e/73HnGAE1wsIIFdm8XXc1XxvonyQiXhvp/1WPF
         ARv6X0n7KlKpaUMbGCXVdy6/aUa+mMsf8qkGzfbXyPzAF+gz5HLpGNAkF7ePQV2A9BGu
         vFew==
X-Gm-Message-State: AFuF++mxv+vvsAlOGzVuOwkctwNXEpCdT6rMXdR8ulQKUEq6rvUNKwy/
	erLfRgWYo+ii2hV/Y5GBto1S97LpfY6LuTmi66FvQiRJ+VBIVuWDfYD61Z6/3NDoD2NxuKivRjj
	ErqIgXRY=
X-Gm-Gg: AYBFou0UVbFq48JJhtpsHR+CdQ+BDL5u7mQZgHtGP8mkfkuxVyxUMWNWOMlDDodvL3L
	RCDhgR3SRRYL6B0pCYlt3m6iT7qQsscGn+P/qT2ofqxGFUGThE7MeNt5tiE8RdgYkkIXsk/UWJE
	QTOIRyyWBWVyWYJSJ4y6yASMWGYumLBJtLX+dE6sBNZOFcDDIe7avuEPb4ZT9biQORYGzcvfaKT
	zeriLgRzSgFL3SU30LHYKlZB/Guw6GXascOeO/B/56uRVuzQRlNQ2kmCMkkIxHssexT+AQzv6Zg
	XBwufGllV97CqdDJ6/fLvVD5Ciqp2R8kjlcMiuXnNwb6rUwSmkpHki8YuHfbOcuW/QotaxHvSe2
	CKV2FXcrxStGVz4do/8vFyxTj25gRmEL57boGa9KycqzCuv6s09NOqBakxDmKuuKxlIRxid7Mv+
	MBdGp+554gkkAQg7SYR0f/fqECWynMejOIdc7Pko5/iXsO8OY/JZlXKAitr3M2v7pApOXgaiz51
	EoUS1dPfLRUjK6nTCCjF7UhyhVptmSwVe0jP1HyuQaZ4+Ghuqrvew==
X-Received: by 2002:a05:7023:a5c:20b0:138:243e:ceb1 with SMTP id a92af1059eb24-144f9086f6dmr3036634c88.6.1790183382605;
        Wed, 23 Sep 2026 10:09:42 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([213.249.125.50])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f983d73fsm9253706c88.6.2026.09.23.10.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 10:09:42 -0700 (PDT)
From: ecordonnier@snap.com
To: bitbake-devel@lists.openembedded.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [PATCH] fetch: Avoid truth-testing the original environment
Date: Wed, 23 Sep 2026 19:09:36 +0200
Message-ID: <20260923170936.1362930-1-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Sep 2026 17:09:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20247

From: Etienne Cordonnier <ecordonnier@snap.com>

get_fetcher_environment() and runfetchcmd() check BB_ORIGENV with a truth
test for every export variable that is not set in the datastore. Truth
testing a DataSmart calls __len__(), which builds the set of all its keys,
so this repeatedly enumerates the whole original environment. BB_ORIGENV
is always a datastore when set, so compare it against None instead.

This reduces get_fetcher_environment(), called once per sstate object
checked on an HTTP mirror, from 753us to 24us. Checking 2,114 objects on
the Yocto sstate mirror with BB_NUMBER_THREADS = "8" reduced the time to
task execution from 26.6s to 24.5s on average.

AI-Generated: Uses Claude Code (Claude Opus 5.5)
Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 lib/bb/fetch/__init__.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch/__init__.py b/lib/bb/fetch/__init__.py
index 55ab710f3..fb6278439 100644
--- a/lib/bb/fetch/__init__.py
+++ b/lib/bb/fetch/__init__.py
@@ -928,7 +928,7 @@ def get_fetcher_environment(d):
     origenv = d.getVar("BB_ORIGENV")
     for name in bb.fetch.FETCH_EXPORT_VARS:
         value = d.getVar(name)
-        if not value and origenv:
+        if not value and origenv is not None:
             value = origenv.getVar(name)
         if value:
             newenv[name] = value
@@ -961,7 +961,7 @@ def runfetchcmd(cmd, d, quiet=False, cleanup=None, log=None, workdir=None, extra
     origenv = d.getVar("BB_ORIGENV", False)
     env = os.environ.copy()
     for var in exportvars:
-        val = d.getVar(var) or (origenv and origenv.getVar(var))
+        val = d.getVar(var) or (origenv is not None and origenv.getVar(var))
         if val:
             env[var] = val
 
-- 
2.43.0


