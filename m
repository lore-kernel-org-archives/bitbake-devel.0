Return-Path: <rudolf.streif@ibeeto.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390AAC27C52
	for <webhook@archiver.kernel.org>; Thu,  6 Jun 2024 20:17:15 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web10.25182.1717705030135356239
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Jun 2024 13:17:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ibeeto-com.20230601.gappssmtp.com header.s=20230601 header.b=wvafuBvO;
 spf=pass (domain: ibeeto.com, ip: 209.85.214.173, mailfrom: rudolf.streif@ibeeto.com)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f6559668e1so12577495ad.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 06 Jun 2024 13:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ibeeto-com.20230601.gappssmtp.com; s=20230601; t=1717705029; x=1718309829; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=73OYZHAd3Ny7foBxysC5orEIjQ2g9mtIXprr6XJJJt8=;
        b=wvafuBvO29lxv4255dqaHTq7Rn5inUBuAFKIIGZPTtQ8blBWoXLoksVlFpzbd+vDF5
         KGY9NXvEQjzmYfYHsIOsYviLGCR91BSX4ulzdHFYBU8rPN+aT14kSk3axrXx0XePwqVZ
         +cSM8ztnFOTc/8k6OKSI8PllgbgGHmKxLbioZV6Phej60cnAF4JQLT8umOBk/AT7pAS0
         BsB+51OChI4sO32mpbnSTsjzbdsS6SjCwMChZXJxHo/DT6t8usPkfksVQat0RPgOBBGh
         5BMx36vP3bJopR2pM+lV65QEa4t+D6eQGDxBGtTNMFPkkv+nlne9/5H8cAVjLOulThmC
         0oAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717705029; x=1718309829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=73OYZHAd3Ny7foBxysC5orEIjQ2g9mtIXprr6XJJJt8=;
        b=V6anNO7B7BqjfVnWtBTNZ2Tmai0nEHk7A9JnfPF+nva8k7ZKzLjjIGUFmo8dvM+AXB
         1YrgQsVwNEci4EOZqDA2+trR56OHK/BOr5Ko62DLZ5boeQTToUpCf7A6jcRr30Schl1c
         WneQLGd3fLmyRhH4VT2vA5yFC8NtRHyzOagwxQqsu3opI9ISkS8TqtiEb3JeI7QiAUCh
         ag7CExBJNtAiMcOazXUFTHmgFA5/PPMPDwcMkDZOu4TYxRWgohcVOItzh3WUPGdRgGOH
         79OD8xyA0OYFwI2ozJjB//1TW1dNrbNT9Cz4KaH4VsaK+QWblmCDwcx1J65YDtQ6LyP+
         CY9Q==
X-Gm-Message-State: AOJu0Yxw+FXIhSjqEe398fCG2Y5JF7Al4jkEy3YFqbvJQB96MmnQ5ZO6
	CUeTc3iiJFwRpQnuW2E91Z0y+Thq5DBPyUZaHl2TswFq9mI5S5pj9Ol1oHijFqCOO7F6s79Ro5A
	Q
X-Google-Smtp-Source: AGHT+IFrEALObIf5mdFX+QlYfosr2noWqo2/9tSktptPrhQ7Z9Z57SqI65eSw878Ogq+qqmPZHxerg==
X-Received: by 2002:a17:902:da89:b0:1f6:7e02:7ab8 with SMTP id d9443c01a7336-1f6d03e70ddmr6589975ad.68.1717705028916;
        Thu, 06 Jun 2024 13:17:08 -0700 (PDT)
Received: from threaddy.. ([2600:8801:8d00:d804:cd39:5769:28bb:21e2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7e3e5bsm19651925ad.193.2024.06.06.13.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 13:17:08 -0700 (PDT)
From: Rudolf J Streif <rudolf.streif@ibeeto.com>
To: bitbake-devel@lists.openembedded.org
Cc: Rudolf J Streif <rudolf.streif@ibeeto.com>
Subject: [PATCH] Canonicalize DL_DIR for wget
Date: Thu,  6 Jun 2024 13:17:00 -0700
Message-ID: <20240606201700.2660174-1-rudolf.streif@ibeeto.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Jun 2024 20:17:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16323

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
---
 bitbake/lib/bb/fetch2/wget.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index d76b1d0d38..2e92117634 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
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
2.45.2


