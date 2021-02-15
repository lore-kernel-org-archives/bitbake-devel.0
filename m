Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
 by mx.groups.io with SMTP id smtpd.web11.32081.1613400440396262847
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Feb 2021 06:47:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=ahn2J3jo;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.54, mailfrom: steve@sakoman.com)
Received: by mail-ot1-f54.google.com with SMTP id b8so1602424oti.7
        for <bitbake-devel@lists.openembedded.org>; Mon, 15 Feb 2021 06:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=dd1FJS9O5RIWIFSiWQiDvy6kdkv0cu1i84aHrv1qUME=;
        b=ahn2J3jo+NxhUbFkuXSyvkwXoy0bny9EBFt9ZCIDenuBDclBZ9TnFHUIFqWuTkYdUI
         rAGm7C+gJxCV5022D01BYQW4a0X+aiSQuntZrHl8knMzeBsy0cRlK6299p/xAOOeem5m
         dJXtj0GAaL578hp7Qz7ue1zZsygr1PKSnleZGHYqrvH1odbj2NM/O2ZgEzK9iiJoxkSf
         pCJ7fmtgbsHsjXwKZHd2e9j5GixWvLAnLT6JIcNkzcvS671+Gm25xna1QzVNKe+ItDtM
         W8MRgsIjtj09dUbyJJUmoxvghBKftmSb3tuc8XHdge3wEA+XV2IuV5NYkuAW4Yv/S3P4
         eFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dd1FJS9O5RIWIFSiWQiDvy6kdkv0cu1i84aHrv1qUME=;
        b=sHSTu+JHP7S0JbEd5hbZ4rM0bsyqIOd7aK0e1j8ZrNwu68WRuh78c0Vu0g0WzBW9Rt
         rm2Vx+EB+52CkAzUb9CQ5rkKebGk2RInrX3S3SMbWNHOtaJjfJfHVM6MyNfrLpsZaD1m
         j3z3ghinO6nZMHdff1v+Ed2k4mtru10sFQbCuQdwGfx+ss16MfbxZbHbtpKoU+lHq50U
         WZow0/FU7Ym1tZr1JUc9RZcKdlmdlvnJnyOHLA6idBJASvo23eAv1Hkx0y0UE7C9IbOE
         +ztN+jnExhUiJKUQVTaNlRGWl4G00O9dYp2WaJ+8qfs0m9s0c1h3BGpNzQAkQZBCzZic
         Hr4A==
X-Gm-Message-State: AOAM533vnzioC4Fsg7RshWv/I6JS5Rrztc6CWU4nCREkF1x+6/w5pdON
	iu6LoS5SetTGxARc9K5gA38lCQP8375BSdpV
X-Google-Smtp-Source: ABdhPJyWU2pmEJha3Guq9zEBB6SGNhlRN4gSSJyTPnSbjlIClJ4F1vUgFtbSrR2BKEowA090Mlw52w==
X-Received: by 2002:a05:6830:2106:: with SMTP id i6mr11451234otc.260.1613400439351;
        Mon, 15 Feb 2021 06:47:19 -0800 (PST)
Return-Path: <steve@sakoman.com>
Received: from hexa.router0800d9.com ([72.173.249.164])
        by smtp.gmail.com with ESMTPSA id i23sm3785995oik.10.2021.02.15.06.47.16
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 06:47:18 -0800 (PST)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 1/1] lib/bb/fetch2/__init__.py: drop _PYTHON_SYSCONFIGDATA_NAME unsetting
Date: Mon, 15 Feb 2021 04:46:52 -1000
Message-Id: <4a6057d4c0462b0e7acf5d25d3c2026fb81f2ede.1613400108.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1613400108.git.steve@sakoman.com>
References: <cover.1613400108.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Kanavin <alex.kanavin@gmail.com>

With introduction of python3targetconfig class in core this is no longer
needed.

Signed-off-by: Alexander Kanavin <alex.kanavin@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 47b64cfacd7c498ef9ed5486d117f2d69a39f225)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/fetch2/__init__.py | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index eb112f06..dc99914c 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -853,11 +853,6 @@ def runfetchcmd(cmd, d, quiet=False, cleanup=None, log=None, workdir=None):
         if val:
             cmd = 'export ' + var + '=\"%s\"; %s' % (val, cmd)
 
-    # Ensure that a _PYTHON_SYSCONFIGDATA_NAME value set by a recipe
-    # (for example via python3native.bbclass since warrior) is not set for
-    # host Python (otherwise tools like git-make-shallow will fail)
-    cmd = 'unset _PYTHON_SYSCONFIGDATA_NAME; ' + cmd
-
     # Disable pseudo as it may affect ssh, potentially causing it to hang.
     cmd = 'export PSEUDO_DISABLED=1; ' + cmd
 
-- 
2.25.1

