Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E14C2BA18
	for <webhook@archiver.kernel.org>; Mon, 17 Jun 2024 12:24:15 +0000 (UTC)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
 by mx.groups.io with SMTP id smtpd.web10.55383.1718627048961796561
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Jun 2024 05:24:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=js+n38SZ;
 spf=softfail (domain: sakoman.com, ip: 209.85.166.48, mailfrom: steve@sakoman.com)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7ebc67365e3so177497739f.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 17 Jun 2024 05:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1718627048; x=1719231848; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wEb3+/dsVp9s1EtByQmnzrZBdIUnEbdRrPYwGNfNrz8=;
        b=js+n38SZlHv/sesueJf0cikh91HpA9/WJn31qeeIRQouBI/h8SYPSe4tjL1ICrGDys
         sMVIgw4vMSD589TL6I2BDD4hyk2rCUYgkTxdOiTB4QcEdz0fIWmsXnYnbiu7wBz67uvp
         WwrQiBrhTFN1CEJid1AJvr8z+sEz7zYNvwX/Yk7wJ1HrEP65OmWgbuYp+YYrxE775PKg
         Yv/S8tTcpW0cKYulfI/DorR1gmJuUWF04xCKi481Fq4A9avVOqk2o1YjQ6FYqo02s3u1
         fRGIK/hmq35Ug20YHB/Pu4/LoEvUWmOLArwj7mMq5XJ/mwcmcmVrFftNbjfsxG/26Vg6
         mnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718627048; x=1719231848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wEb3+/dsVp9s1EtByQmnzrZBdIUnEbdRrPYwGNfNrz8=;
        b=wED42uuBL4nHquxhZaCvFUghSUcEiVLeuVf06yqLHsz/Kx5c/6WFMVsXB0pPXzJCS5
         wWZ3GYLduwcMdXCaTcIwjtxpZMWHRbowilxzNvzyjXlAWV9AmjceG/0/HTaarcfWocKx
         VxeUOO7RabyrYGg4iceHLrdkGcTE+CVlfeABy6PmoepU/1s4pT0rg9mKTYVqH5nJpkmU
         lCJ/X+elI9M9s864ECZDRAyuOFVbSZzBMBL4kFNl+hcMzEy2O8ekLIVoiBs6lFclXkNE
         wXv8jaNb86JCpjsftOwOQEOG8OBolhllJznV77ug+9+B20npKs+lZNXLR3Xvn78lkzFq
         XJvA==
X-Gm-Message-State: AOJu0Ywq1Imuht9bYUv01Q2lmp2V5LfGRTcchh8vACsgYCgFXq8NRiSl
	fsRTBwAZbtS7WYeizsSzPfhYSdlX0MU9xYWIKTFLr86aRS8K/75mYqBk7R1TH3NzhltLQk0tri5
	01BM=
X-Google-Smtp-Source: AGHT+IEH9yTrsuDMzfaqDHpBiNvC+5h2gecUmPwhslteCZnf/y3X8BGK1gVRS2lk44aZcN7MT46puw==
X-Received: by 2002:a05:6602:158a:b0:7eb:7e0c:d186 with SMTP id ca18e2360f4ac-7ebeb62a060mr1081916339f.16.1718627048020;
        Mon, 17 Jun 2024 05:24:08 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fedf39b75csm6608259a12.45.2024.06.17.05.24.07
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 05:24:07 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 1/3] fetch2/wget: Canonicalize DL_DIR paths for wget2 compatibility
Date: Mon, 17 Jun 2024 05:23:59 -0700
Message-Id: <47678142e26bb76d1351886060deff5e75039bc9.1718626914.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718626914.git.steve@sakoman.com>
References: <cover.1718626914.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Jun 2024 12:24:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16361

From: Rudolf J Streif <rudolf.streif@ibeeto.com>

Some distributions (namely Fedora Core 40) have started replacing
wget with wget2. There are some changes to wget2 that make it
incompatible with wget:

1. ftp/ftps is not supported anymore
2. progress 'dot' is not yet supported
3. Relative paths in -P and -O are not correctly dealt with

Item 1: Is already dealt with since Scarthgap by only adding the
option --passive-ftp when the URL specifies ftp/sftp. While that
won't help if ftp/sftp is actually required it at least does
not break http/https downloads.

Item 2: While not supported it at least does not break the operation.

Item 3: If there are relative path components in -P or -O then wget2
only deals with them correctly if there is one, and only one, relative
path component at the beginning of the path:

-P ./downloads     works
-P ../downloads    works
-P ../../downloads does not work
-P ./../downloads  does not work
-P /home/user/downloads/../downloads does not work

In cases where there are more than one relative path component at
the beginning of the path and/or one or more reltaive path
component somewhere in the middle or end of the path, wget2 aborts
with the message Internal error: Unexpected relative path: '<path>')

Such can happen if DL_DIR includes relative path components e.g.
DL_DIR = "${TOPDIR}/../../downloads".

This patch canonicalizes DL_DIR before it is passed to wget.

Signed-off-by: Rudolf J Streif <rudolf.streif@ibeeto.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 3e4208952b086adc510e78c1c5f9cf4550d79dc9)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/fetch2/wget.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index fbfa6938a..b41f53a9e 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -108,7 +108,8 @@ class Wget(FetchMethod):
 
         fetchcmd = self.basecmd
 
-        localpath = os.path.join(d.getVar("DL_DIR"), ud.localfile) + ".tmp"
+        dldir = os.path.realpath(d.getVar("DL_DIR"))
+        localpath = os.path.join(dldir, ud.localfile) + ".tmp"
         bb.utils.mkdirhier(os.path.dirname(localpath))
         fetchcmd += " -O %s" % shlex.quote(localpath)
 
@@ -128,9 +129,9 @@ class Wget(FetchMethod):
         uri = ud.url.split(";")[0]
         if os.path.exists(ud.localpath):
             # file exists, but we didnt complete it.. trying again..
-            fetchcmd += d.expand(" -c -P ${DL_DIR} '%s'" % uri)
+            fetchcmd += " -c -P " + dldir + " '" + uri + "'"
         else:
-            fetchcmd += d.expand(" -P ${DL_DIR} '%s'" % uri)
+            fetchcmd += " -P " + dldir + " '" + uri + "'"
 
         self._runwget(ud, d, fetchcmd, False)
 
-- 
2.34.1


