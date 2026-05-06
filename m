Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A609DCD3436
	for <webhook@archiver.kernel.org>; Wed,  6 May 2026 11:25:44 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16198.1778066739064789960
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 May 2026 04:25:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=TFhyz+WQ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48d146705b4so23212995e9.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 06 May 2026 04:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1778066737; x=1778671537; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WnHO4On6AgP9UDy201rhTsPkQ1/fBejWtZn7Sm7pCFg=;
        b=TFhyz+WQR4ICLdth28tomEmpiFR/R913nFIEPXNIKv6N6te+5kHw3QhypsZjwpIXfY
         6WrNqs09Ne5W++yb7dBNjI7MimHKfObfZb9a3r/Kla+w/jXW+YLrSf1gqkKkq0oKU5tt
         L+l6Fr31zoWVePE3wS4qcXkUnlfg1LBPW2aes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778066737; x=1778671537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WnHO4On6AgP9UDy201rhTsPkQ1/fBejWtZn7Sm7pCFg=;
        b=U4/zasl4pHhRU7QP1XoL0aI41CqnjQhbqi52jA6eqb3FLC5XVyym+4ZlcG8DcSIj0l
         x8izhi2fn/0+72KesjgJD3wXBSFmeeNsZA0M3KMKaVVO2kM1hMomaRp/bOF9r9QkeGHq
         ujvxpI8EkJ4RlnmZhWXwz2yQHTX89iSKsGeANwQk2HmjRXkaw+6EtcimS0zPUSxV9t5h
         qK1qQv9GxYpaVaAfxEENWuQKxKo2J7Onj2+PzxU3JhX7E+jEpbKFFH+pK97Tp3dwCY1v
         M5ysDLrESwDFpCCv3i2O5y9ocRovPW5Fm5LqA0/gdLShWoRBZ4HwtJd7U9D9lyV8lTro
         5Qww==
X-Gm-Message-State: AOJu0YxD705U0qFvJW0Aje7nw9eqVfNOhUc8uGZhoWtHNP1ym6/BPD+Y
	Z2fXBTLyM+s22ONO/VWUxaKW0qa2NrPajMJdQDcaBBgELNG70QfzC5/ZN5ak8IsBgQ0spZ0M2cF
	HUqY6
X-Gm-Gg: AeBDieuBenXbZhkJ8vkH5d0ROGzEKWEVs7jl4ruiR7d1snOyq6ri1q18z/s5mgUcBQr
	z1JFJB9jnPZYzR3tHorQmpe1fMtUl19kja3qcDvH5hkmcgC77J2Fycab2Y/OHA7MABEBdxBAccu
	C7SNyAr46hphaPZ9aeHVDgbxmzYuSDC6xRc/q4iqsjsLjBySB68kpc9wRCt6o3TB+SppVABXihn
	79Kg3MUanYJLW/T74KhUF4mIz2J/tjJeYAxY9kRkLXWnO1pm98lsqVVh7k/2N2ov1oQps0idxhq
	rdQrx2bieOLQeVI/7PTvVk0KYKYSZiebraJcKyt/aPZtEe1/yKhyxTbAf5/VEMe/0omPvBP/7H8
	2F2OTUYaZEij4waxcL+JP5QOL/f09zl3nHsGTWyxJmzRxB1qPqeyp7z52uNxPi8rOwKa4I3FH71
	1VJqjOmVi5312JXwKSD6aXntRjUk92ZylNCZP4S/mLxZFdZIGiJl1vdiRHDZS8pms=
X-Received: by 2002:a05:600c:871b:b0:48a:592c:e655 with SMTP id 5b1f17b1804b1-48e51f45eddmr48551055e9.17.1778066736806;
        Wed, 06 May 2026 04:25:36 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:5409:94a2:bd3e:6c21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e5312de76sm14463775e9.21.2026.05.06.04.25.35
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 04:25:35 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] fetch/git: Improve temporary directory handling
Date: Wed,  6 May 2026 12:25:33 +0100
Message-ID: <20260506112533.3826658-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506112533.3826658-1-richard.purdie@linuxfoundation.org>
References: <20260506112533.3826658-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 May 2026 11:25:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19443

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
index fda7bf9faae..01bebb7648e 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -542,27 +542,23 @@ class Git(FetchMethod):
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

