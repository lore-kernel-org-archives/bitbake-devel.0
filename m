Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12932CD4F24
	for <webhook@archiver.kernel.org>; Wed, 13 May 2026 13:39:55 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7899.1778679589760677894
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 May 2026 06:39:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=pCMRgZ3F;
 spf=pass (domain: gmail.com, ip: 209.85.128.47, mailfrom: martin.jansa@gmail.com)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so60800775e9.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 13 May 2026 06:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778679588; x=1779284388; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vx+WKFMfDuahEL2CVHb/2LPYX8PmX0GLWpi6vn7gATs=;
        b=pCMRgZ3FVkfFF7D+cF3bDl0PPGCJFMO4Mzsu1CNMD6AH3h8Jxf0pdTZiO/tPQX0H+R
         TF/u7nZ/SoN6C6WLs8P7BtVTovnf7eVNmnhD2Y8CxDoL1Ucm58Mikmck4jKDFuDTg4nh
         bu3TztznunHpL20v1/pEDhfG+JLg/zwmrdJT3zJek/m6lNd41h9hAydn/unCvzpgfgyk
         Mwz7QAGyt12PvkebaPuN9fMjrVI7u8cPkqBBnyS2+vM67x8PuhUrub/XrrKQ/FLwf0gT
         Cs0OTipNS/K6LB7ExiklLxUTW0no9hYZCDABKZIGOh9ywXAOkta9dBnwwQFV1l5Kbu1p
         UmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778679588; x=1779284388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vx+WKFMfDuahEL2CVHb/2LPYX8PmX0GLWpi6vn7gATs=;
        b=Ek1GwtGXV9lPbZmRCep7a9AEXAjMesa9ooAwpDpAe39rGwy0OmCXy+igTDPc1PsAX7
         Jb+buwEirG6YSYyurI2BCYIdnwfK+hNj0aDAO2swUH/NCmddgfASSMs0mmL086nCb7ZH
         tFPoUMZH9lthgO0VIqobir5WHi8ia+UVyCeGh7ZItCvwRj4CnAsexrdATAkxY6NjedKQ
         5wIzRovQMY3iFh207+rUIbuqsxa60tkj6Q+PhgH35E2+bRiQqyzBdJV2RrV0HKmyvPxd
         k0n3T9pySWKerbdq8aIWQplqeLa0iNmCeE47GG/64HdVug76mvkSY2dib5DxJHcgnY+c
         88kQ==
X-Gm-Message-State: AOJu0Yxo8btgWc6bw4UkeF8cFlOrXpfmFuh9qhXkVkPGI5d78iw8zrKG
	qUHwcI9ntateJ4zHWnEqDsqjXZnxuUFhqPBV0CZZN8O5J4KMoIGaDxNgyuUQMQ==
X-Gm-Gg: Acq92OEdDmAci3vWfkkZTi6EsOTFJWb2DJwR2cjR2yCC+RyPOaglboJLtpYVOMbmw2c
	ygmySmoJEbXam/V1kw6RJS0BcLsmeFwMUFthXZYB57ymziHszW3/yRytNpRnKxHib8USLDjY44q
	sVQFa2QQsfvsA5SXs9QvsjVdUbXQQQaRKwXgL98JJlYFQFALNAtXq16LsCVd+PRJAX1DDTfD74X
	dLl3u9grVV345K/CRAk9rVQeAZfJMYIiqCmliB1rk8Q+RgYwtKFP8N7MJcXabKNQaE5j0hmdz1p
	wURaFuIXRnu1FSHP3unTgeaSiAGdCdjjEI3qfblst6+kWLY50XmyugdR1SMmyRcSVtHQVaRtXBq
	zqqGVezNdgZCNp9ihvuQlyISeZX8SOMJaEmpXhajmqjGcUmrHtizRa4tH0xD9xEe5UIo+yFbrCg
	F15o6McgGPDsn5gWvJ09WH5vZuMbxdtICjNMwNcEARM4DpxA0+4aKtkyuTZfAifZZv2Tzw1LiPl
	Klu9bTlRN4UWkXEJWnE
X-Received: by 2002:a05:600c:8b45:b0:489:1ba8:5bf0 with SMTP id 5b1f17b1804b1-48fce9f4aeamr42046995e9.21.1778679587790;
        Wed, 13 May 2026 06:39:47 -0700 (PDT)
Received: from localhost ([109.238.218.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fce05f41csm84715225e9.5.2026.05.13.06.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 06:39:43 -0700 (PDT)
From: martin.jansa@gmail.com
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [2.18][PATCH 1/2] fetch/git: Fix leaking of temporary directory
Date: Wed, 13 May 2026 15:39:34 +0200
Message-ID: <20260513133935.814961-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 May 2026 13:39:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19510

From: Richard Purdie <richard.purdie@linuxfoundation.org>

We create a temporary directory for holding a clone but we never clean it
up. Fix this by using a context manager areound the temporary directory.

This resolves a buildup of tmp directories in DL_DIR in builds.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/git.py | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 21f5f28a0..17cb38cf3 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -392,14 +392,14 @@ class Git(FetchMethod):
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

