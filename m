Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111A7CD4F21
	for <webhook@archiver.kernel.org>; Wed, 13 May 2026 13:39:55 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7794.1778679591788415979
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 May 2026 06:39:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=iT9iEatg;
 spf=pass (domain: gmail.com, ip: 209.85.221.53, mailfrom: martin.jansa@gmail.com)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-44ce78ab5feso5820374f8f.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 13 May 2026 06:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778679590; x=1779284390; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNCLsKahIrG+DlUdexFIdwbxSudEjVmaazi6l/ZKis4=;
        b=iT9iEatgt+6VN5gENopyW+LnVO6pi45Li2CrKbc1EmeFkkeKua8ccFTlW80Nz+6j7D
         RwKdrxvFZD2+7NncCWR/HYF25WGaRmq1N1WdtfLiBc+DYBXgpI9SctE3bdNirdeXO18d
         vUGD7lG2m8QGnKRnKNvsyUT7/7LJTFecJZTRCmYBLguI1is/DjzsNAqt06fpVNDLMu4d
         cYuBZgsnChtij7j1Ptzhp1K8KNwziWdtwRRuJAhqZCR5sCQvxX4ppKOPjc9PqwFtK1mF
         gnZNkYlBeJH4ZU02s0h20EN8F9VuPN97ocq55QNFbCOU8AtciF44g/8Jjays2qaO2H5a
         sIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778679590; x=1779284390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nNCLsKahIrG+DlUdexFIdwbxSudEjVmaazi6l/ZKis4=;
        b=bYNBa93hhP4OTcbrsJjYQmCmyI8lQKifCRrgCXGLJPnT8xG1OaXikn+X3/KHnZHG5O
         s47MRpVdyTs4g12QwnXntlsb3QCZ0GUJnBDPtierBhMM7XC3aEerqjZTSRdTcn/arKPv
         +cVJuiiIrGnGMZ+XBDxqWa6HDGXn7BXFsKmsyTrZ0JFph/8OCebdMw2uR3ZO6tw6fF4I
         wv9GCUhSkEp8Tm0YKLzcvTibsrojwxhWXQ4dBCIv4/GBAneAGlUYPbGH5RjnS6hvStcx
         2tYc9bvu5JZW2TokfnWm7qHZooMkV/u+g8MZFxtLh5Ewka+oYcJWcba8OnmZOLbe8t3y
         ERWg==
X-Gm-Message-State: AOJu0YwRBgKXxLcClqujEPBYFE4itGgheWjJ3nSO8jPNpvby+AIoblPA
	SPmLuyIrE2vUv+NKLB4RrpWL2HqmYbpaa558HEtHmrj9OMCh2kHtsdeSscXMlA==
X-Gm-Gg: Acq92OGCOp2o54T+hC1VV8gvqbQTDjbQPDCxZ+HRo6LkpOb1HDTBBj8sD1aPd6SLo8l
	UnHX5bS7NYuQKcJUvqKXahsmyZHoLKZEUtY9yA+m/8H+bZu+8NDEKCHbvpYkZEiXQb3uwVv7Tc2
	POtsuAYZ23BthjRH1+47SDySLJ3XNpLkHuB/8skN1xCTF0mzahb3YUSF/ACKnffJsvkKSnLkQx3
	lspxQRP/0GL1fEDoPTF6dirzcEW0VAYjfA2JO0ZJnj6iAQIEe10uzPxldmOWbbkw0eVJp/12R0M
	F/dzcMdaazrQ4mqpD6iN4SEyESw8daHfMt0L8K2WztkhIvhGn8Upwol9dqtjq2BHNjbIBJf2kL1
	miMjGkgShXdHWSlSKfelcYG7IMy4DRF1G9BirUA6OjRDCPbWne3wCkBas989UL3KfkOHWM433i7
	2f3+Wgt8pNHg1KGC7vXoHuWF1rvGRPrDVO1Z7CO8vTWJSBv07011n1ALTk6+40O8yTDUogtMD5w
	jEQHrWkuw==
X-Received: by 2002:a05:6000:2c05:b0:449:c5e2:a8b7 with SMTP id ffacd0b85a97d-45c5a77ee62mr5537763f8f.30.1778679589563;
        Wed, 13 May 2026 06:39:49 -0700 (PDT)
Received: from localhost ([109.238.218.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-454917d57aesm41287929f8f.26.2026.05.13.06.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 06:39:48 -0700 (PDT)
From: martin.jansa@gmail.com
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [2.18][PATCH 2/2] fetch/git: Improve temporary directory handling
Date: Wed, 13 May 2026 15:39:35 +0200
Message-ID: <20260513133935.814961-2-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513133935.814961-1-martin.jansa@gmail.com>
References: <20260513133935.814961-1-martin.jansa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 May 2026 13:39:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19511

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Whilst this code doesn't leak a temporary directory, it is a little
unsafe around directory creation/reuse due to the cleanup and retry
logic.

Restructure the function so it can use tempfile.TemporaryDirectory
as a context manager with a context per loop iteration.

Behavour shouldn't be changed, the deletion/recreation is just removed.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/git.py | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 17cb38cf3..ecf4340b1 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -543,27 +543,23 @@ class Git(FetchMethod):
             runfetchcmd("touch %s.done" % ud.fullmirror, d)
 
     def clone_shallow_with_tarball(self, ud, d):
-        ret = False
-        tempdir = tempfile.mkdtemp(dir=d.getVar('DL_DIR'))
-        shallowclone = os.path.join(tempdir, 'git')
-        try:
-            try:
-                self.clone_shallow_local(ud, shallowclone, d)
-            except:
-                logger.warning("Fast shallow clone failed, try to skip fast mode now.")
-                bb.utils.remove(tempdir, recurse=True)
-                os.mkdir(tempdir)
-                ud.shallow_skip_fast = True
-                self.clone_shallow_local(ud, shallowclone, d)
-            logger.info("Creating tarball of git repository")
-            with self.create_atomic(ud.fullshallow) as tfile:
-                runfetchcmd("tar -czf %s ." % tfile, d, workdir=shallowclone)
-            runfetchcmd("touch %s.done" % ud.fullshallow, d)
-            ret = True
-        finally:
-            bb.utils.remove(tempdir, recurse=True)
-
-        return ret
+        for fast in [True, False]:
+            ud.shallow_skip_fast = not fast
+            with tempfile.TemporaryDirectory(dir=d.getVar('DL_DIR')) as tempdir:
+                shallowclone = os.path.join(tempdir, 'git')
+                try:
+                    self.clone_shallow_local(ud, shallowclone, d)
+                except:
+                    if not fast:
+                        raise
+                    logger.warning("Fast shallow clone failed, try to skip fast mode now.")
+                    continue
+                logger.info("Creating tarball of git repository")
+                with self.create_atomic(ud.fullshallow) as tfile:
+                    runfetchcmd("tar -czf %s ." % tfile, d, workdir=shallowclone)
+                runfetchcmd("touch %s.done" % ud.fullshallow, d)
+                return True
+        return False
 
     def clone_shallow_local(self, ud, dest, d):
         """

