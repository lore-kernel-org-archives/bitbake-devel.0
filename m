Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E423CF887F
	for <webhook@archiver.kernel.org>; Sat,  5 Oct 2024 13:45:08 +0000 (UTC)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.web10.11707.1728135905494414693
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 05 Oct 2024 06:45:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=GZzyoBmv;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.54, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e192a2fe6cso2305174a91.3
        for <bitbake-devel@lists.openembedded.org>; Sat, 05 Oct 2024 06:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1728135905; x=1728740705; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TwtMT9yS/5nlgHmQ4IME4Ml4eV8R3WBGi0rV80Mz3f4=;
        b=GZzyoBmvxc+0lmLTxTr2tp5kLui6KuNIYPXtlBMtbzK9ttD1FNiCO70Pj+rcvt2vRu
         /8WSGu1Wsyq9/QAWQGW2vvIS/ltyxV1JqZkwDcUXJ8FGhO/phXQg7cKUxkwAzzn4lR6j
         nB3NHOCMvt82fI14LGGVOd2U39cp28dhlNFdLkmJ2m7GS13MHHS6CY54UWXb2zuVWOLC
         xnYTJcPppBzzw8UiMO2PMBRqct7jF2CjBz0uZzoFtlWoFKeMJnsevHKia0kewjl/F1Yx
         jpEmusfkNBGZ3gQEvydIiovrDFIETF3x9HwlDUPewcjI9QcfSjkYbdKN70wWWvegCvnW
         p6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728135905; x=1728740705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TwtMT9yS/5nlgHmQ4IME4Ml4eV8R3WBGi0rV80Mz3f4=;
        b=ql1eT8BhpmYAfhgF0TDJyerQBeX66bmRgzKbsoJnZ9l/bp/8O11cXZqkmEdO2maOi5
         zsqbnqNlr4kouecv+8v+tTOmhHjYIR94po1uPQfv4Ve/dCBFNDYuXzJuFfMa8IwUq4w4
         EWwrVqpYlJIB5W8vmXWF3/4oS7RzW2YhLPHXF6wEPcWourEO7ptcW78hS92SGVPj7STU
         cvEb4fJ/wEXFxuEFZQ6SQzktasJGmQ7MbTxnslMEF6Es4U1uYVrT9SYKpH2kd5D0cERh
         iX/6QcQ7+b+NKuLvLeSUZp7FQpSY4h/8bmJ3nhbimhHl8v20tNBzX0/bbxReObb+R+7y
         llSA==
X-Gm-Message-State: AOJu0YzpqUfmaBKL1LJ2TvkxdJRKYAzo5CKEoaMcOGR+kYDIYB7liOhO
	aYbvnQ3Qe7f9IEP8b2dG0SQCzFYvpz19unoqr9rezyAhb379/zPnnDQeRWKv0zYAYJFVIC4M38F
	szZg=
X-Google-Smtp-Source: AGHT+IEXPrEp+sBLf0axxSgPcWY8b0IC2wcoc9by7IXIDpnoPO9jcLOz0wjxz8ob919TcUt+5R06pw==
X-Received: by 2002:a17:90a:678d:b0:2e0:6c5f:4eb9 with SMTP id 98e67ed59e1d1-2e1e6227026mr7173739a91.12.1728135904702;
        Sat, 05 Oct 2024 06:45:04 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e20b0f919csm1831617a91.44.2024.10.05.06.45.04
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 06:45:04 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 4/4] fetch2/wget: Canonicalize DL_DIR paths for wget2 compatibility
Date: Sat,  5 Oct 2024 06:44:51 -0700
Message-Id: <07081a94997142746f7d345c27bc6805231d025d.1728135724.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1728135724.git.steve@sakoman.com>
References: <cover.1728135724.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 05 Oct 2024 13:45:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16644

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
(cherry picked from commit 47678142e26bb76d1351886060deff5e75039bc9)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/fetch2/wget.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 708f3a42e..3849c8a5a 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -109,7 +109,8 @@ class Wget(FetchMethod):
 
         fetchcmd = self.basecmd
 
-        localpath = os.path.join(d.getVar("DL_DIR"), ud.localfile) + ".tmp"
+        dldir = os.path.realpath(d.getVar("DL_DIR"))
+        localpath = os.path.join(dldir, ud.localfile) + ".tmp"
         bb.utils.mkdirhier(os.path.dirname(localpath))
         fetchcmd += " -O %s" % shlex.quote(localpath)
 
@@ -129,9 +130,9 @@ class Wget(FetchMethod):
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


