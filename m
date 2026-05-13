Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E5DCD4F21
	for <webhook@archiver.kernel.org>; Wed, 13 May 2026 13:40:34 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7811.1778679626404708033
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 May 2026 06:40:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=ZIguOJ20;
 spf=pass (domain: gmail.com, ip: 209.85.221.45, mailfrom: martin.jansa@gmail.com)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d7645adbdso3723945f8f.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 13 May 2026 06:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778679625; x=1779284425; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rPlELwZaZgDXzyZebH0kVvzjIYQWD44pLKuk2S9qPw8=;
        b=ZIguOJ20HmiKfZwd+QOlzYL+skrsizeIEbkd0fRye3s6s4cqC53v9LLmUdNK8CqWY2
         U0VGIeUt0RUDIWWokgJRqZL1TyJHecgi86b8zx//etNbO2oWrnWhDqoZplG7sukYAbzT
         zeZ6ahsrCOAUbX8LcHGpmkn7eGwBvzAM8121md0XCav6W/aqsxFCliTinh1IkQfbvygb
         TEzPp9dX3C5ONysB0mzFwPQvBR8gQ/UATWSXboUs8ySf5uujaS+DhVdZ3YSx8tZYcdKY
         5iSvlrD3P56vUg9nsufRIbTtIsv0czRkRNM0kGMNDp2RwRp2EYVfzXRkbQ938s79BjHk
         oV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778679625; x=1779284425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rPlELwZaZgDXzyZebH0kVvzjIYQWD44pLKuk2S9qPw8=;
        b=Vm58ctiI9aekMEVM2j0hJVahPheH1z7NjEBHLCsA68HmknJ/7w4q40WpsYFRooXTr6
         LOJnPd7i/5XmIUmKuqXtH3Ep4o3+fshfI59uvt6+OmMBr8+nqhhCcTe5ojcVJ8oJWBey
         iI5vjSnQefxUirhwJSKtTl3754C3KbQMzQ2zfhnBAUHEm7e/N0b/KlfMrZBRIH1umkr1
         rTxLvdRMX12iWEFs7aauvAidRGmayvVpeDx8I48CRH1cfluf/tf0SUrgYk2Xoa00/UkC
         Mrf3cuGEwa8idu7Xy6oh6gritEZRH+YQVhhuwav/uLmmT0RStDS8eHGbbej5gIffy7o4
         5N4w==
X-Gm-Message-State: AOJu0YxaJWTtfdYhZnw2NKEj4F7U3NbjcJ/KN1718gZSDK6vjaJV9Ugq
	GWadGcxuzjjn6D/RxNT36R8FljrV1wTaN+qno4EJ3wwpUWtAmuAe6zXDVxl9xA==
X-Gm-Gg: Acq92OHS5XSyS4b31Of4titmWThE5Fz3eC310cvWCyse/h0mKaaGWLGPqQ0fNtR9EEw
	nX0n2jo1xN+WgzFXmQWB9CFRm5QQ/wFurD7GXl+hoTyId9rH8KtFaScKjwik3EMr289dAlxr2o2
	f7/TAGbyrKUjecVmU4GGzAqp5tih6ZjWKQSt1LnI52A0930wGHE3Dyp9Bre83BGSYZhDoFmQv7i
	GpflBpJPlo8fI8r07SEcjjuX6PR8PJTyIjCN60lcQQM/l7v/vpUrjZ7oIoE7ng6b1d7jlfGRBEJ
	A1oJr04nW7kFiN95O5Z2DCtUfiygL1lo0B0EMYnoYb9Eh4A8XAaRwKrkZAaqXwwCBp+GeX066wh
	8+mF1zI9MMHGEauch33VujYQSr1f9r8p5My9Q/KP+KDJEsmQAZHudlH9li+zMC6RFNrHkHzrH0I
	IEXyaIcBW1jZPTiybBC285GNA3focVzyCm/pK1o+BzDMR4xEWt/T+hGPiHaILCwczJbgZN7aD8T
	nyqzDmXYeJNIVhBqKTj
X-Received: by 2002:a5d:64e3:0:b0:455:51ee:7afb with SMTP id ffacd0b85a97d-45c5859f1efmr5430655f8f.2.1778679624784;
        Wed, 13 May 2026 06:40:24 -0700 (PDT)
Received: from localhost ([109.238.218.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45c7f2775desm5891146f8f.30.2026.05.13.06.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 06:40:23 -0700 (PDT)
From: martin.jansa@gmail.com
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [2.8][PATCH] fetch/git: Fix leaking of temporary directory
Date: Wed, 13 May 2026 15:40:18 +0200
Message-ID: <20260513134018.856954-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 May 2026 13:40:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19512

From: Richard Purdie <richard.purdie@linuxfoundation.org>

We create a temporary directory for holding a clone but we never clean it
up. Fix this by using a context manager areound the temporary directory.

This resolves a buildup of tmp directories in DL_DIR in builds.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/git.py | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 602914460..a3b1a2ada 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -399,14 +399,14 @@ class Git(FetchMethod):
                 bb.utils.mkdirhier(ud.clonedir)
                 runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdir=ud.clonedir)
             else:
-                tmpdir = tempfile.mkdtemp(dir=d.getVar('DL_DIR'))
-                runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdir=tmpdir)
-                output = runfetchcmd("%s remote" % ud.basecmd, d, quiet=True, workdir=ud.clonedir)
-                if 'mirror' in output:
-                    runfetchcmd("%s remote rm mirror" % ud.basecmd, d, workdir=ud.clonedir)
-                runfetchcmd("%s remote add --mirror=fetch mirror %s" % (ud.basecmd, tmpdir), d, workdir=ud.clonedir)
-                fetch_cmd = "LANG=C %s fetch -f --update-head-ok  --progress mirror " % (ud.basecmd)
-                runfetchcmd(fetch_cmd, d, workdir=ud.clonedir)
+                with tempfile.TemporaryDirectory(dir=d.getVar('DL_DIR')) as tmpdir:
+                    runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdir=tmpdir)
+                    output = runfetchcmd("%s remote" % ud.basecmd, d, quiet=True, workdir=ud.clonedir)
+                    if 'mirror' in output:
+                        runfetchcmd("%s remote rm mirror" % ud.basecmd, d, workdir=ud.clonedir)
+                    runfetchcmd("%s remote add --mirror=fetch mirror %s" % (ud.basecmd, tmpdir), d, workdir=ud.clonedir)
+                    fetch_cmd = "LANG=C %s fetch -f --update-head-ok  --progress mirror " % (ud.basecmd)
+                    runfetchcmd(fetch_cmd, d, workdir=ud.clonedir)
         repourl = self._get_repo_url(ud)
 
         needs_clone = False

