Return-Path: <ptsneves@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BCFC433F5
	for <webhook@archiver.kernel.org>; Fri, 21 Jan 2022 15:39:34 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web08.13316.1642779573837140580
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Jan 2022 07:39:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=PFjRhi9h;
 spf=pass (domain: gmail.com, ip: 209.85.221.42, mailfrom: ptsneves@gmail.com)
Received: by mail-wr1-f42.google.com with SMTP id q22so381406wrc.5
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Jan 2022 07:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GnrtgtGIPgGeaZ36L6CL6SgR09f75q1ffO+R4kLSz8M=;
        b=PFjRhi9hlpWgbFjo8Z8r/Dxb9iyLtH70dBi2Tuyi0yB/ft/Usr2CmCESlIIRaQd+M0
         LYTY+/cLlslvqxmsC68HijjT5pxWS7eskEHwSsQFl8Wwlrw2coyCacrZaO1LDPRIyyNC
         lY1VR8xNmOGDfYxVw6L0l2hvg848O83kmjOZRSrzjp+vSSKBg9u2V+POnBQBJE4w3B+p
         nSpuV3J9nOZ1n9L0I8JYPojDXWW6aOfdntB8ljjfzjYRA69klhKtdQ3pQkMQSkPpKG6q
         jSn7AwA9U4EE1qi6jTT3t1/9YI51nxX5Mxw3CzGt2mae1SSjmH5XJpiQzqs2ZYhZ4Fhk
         tVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GnrtgtGIPgGeaZ36L6CL6SgR09f75q1ffO+R4kLSz8M=;
        b=nIhkhJPelsvkt12cU+a25+/JX+FsV1dFq/ui3XEQBFvjcY0WxOekqezKxgKupeLUcz
         9XGaDiXSViCBb+SIbUwBd9mcnl63P2qiljzITJIef6Ekhl72DzsmGCaRZ97fvCxsxF7D
         OTI9tRNXcPFfqxCVVXJWoCKErOKkZ16hAxx+RSOpz/thsh1VPh4rXRZoNUhqsJCe/d0N
         +BMXZ2kSg8yYihuig+W+1yjsTNVn6krOTrofX7HBxjNZRyR0ee+H1e1Rq9sbEpALtAFC
         8HL+ZUJrh4awSmgpvDQflMZFEHfibwm32dBdBSTPfh0ulV8hRF+c3IYn700phndmITVN
         xcZA==
X-Gm-Message-State: AOAM530ruIhoCRvXtM/Ncc3nXuCpiWdFowxR4o9bANK620AcqNba/t/6
	HYtvJ5j9I+C2wIDoKgrjDTNiaGTyQw==
X-Google-Smtp-Source: 
 ABdhPJyvQy3yeKhYdBcAITDtmjjDWFTPZyNa9QzAPJfoIWIYyYcR8oa79KE2109NMUihGq/iba8Tng==
X-Received: by 2002:a05:6000:186b:: with SMTP id
 d11mr4195251wri.461.1642779572137;
        Fri, 21 Jan 2022 07:39:32 -0800 (PST)
Received: from localhost.localdomain (85-128-83-172.static.ip.netia.com.pl.
 [85.128.83.172])
        by smtp.gmail.com with ESMTPSA id
 n15sm2304400wrf.37.2022.01.21.07.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 07:39:31 -0800 (PST)
From: Paulo Neves <ptsneves@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Paulo Neves <ptsneves@gmail.com>
Subject: [PATCH]] checksum: Support uri formatted file list
Date: Fri, 21 Jan 2022 16:39:05 +0100
Message-Id: <20220121153905.1701521-1-ptsneves@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Jan 2022 15:39:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13271

Before this commit, if the file list for checksumming had
files names with spaces there would be a crash. This happened
due to filelist.split breaking on the file names instead of
on k:v boundaries. Now we validate this case and emit a fatal
error if such case is found. This needs to be fatal as the split
will generate broken k:v from then on.

Instead of putting literal spaces in the file list the user
should urlencode the file names and if they contain coded spaces
they will be decoded. This is consistent with the current
practice where file names are urlencoded. A reproducer of the
issue this commit fixes, was to pass a do_compile[file-checksums]
list with files containing spaces in their names, urlencoded or
literal.

Change-Id: I6ac4f1cffbb86e913883491d46e8cc69a028e992
Signed-off-by: Paulo Neves <ptsneves@gmail.com>
---
 bitbake/lib/bb/checksum.py | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/checksum.py b/bitbake/lib/bb/checksum.py
index fb8a77f6ab..97cf10825e 100644
--- a/bitbake/lib/bb/checksum.py
+++ b/bitbake/lib/bb/checksum.py
@@ -8,6 +8,7 @@
 import glob
 import operator
 import os
+import urllib.parse
 import stat
 import bb.utils
 import logging
@@ -110,10 +111,14 @@ class FileChecksumCache(MultiProcessCache):
 
         checksums = []
         for pth in filelist.split():
-            exist = pth.split(":")[1]
+            spl = pth.split(':')
+            if len(spl) != 2:
+                bb.fatal("found unformatted path in filelist " + pth)
+
+            exist = spl[1]
             if exist == "False":
                 continue
-            pth = pth.split(":")[0]
+            pth = urllib.parse.unquote(spl[0])
             if '*' in pth:
                 # Handle globs
                 for f in glob.glob(pth):
-- 
2.25.1


