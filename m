Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3815CC6FA8A
	for <webhook@archiver.kernel.org>; Tue, 13 Sep 2022 14:27:10 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web08.5352.1663079218165494293
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Sep 2022 07:27:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=6om15ikn;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.175,
 mailfrom: steve@sakoman.com)
Received: by mail-pl1-f175.google.com with SMTP id c2so12007596plo.3
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Sep 2022 07:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=CSnjAqQr4tSeG4hTXr4Ix8paO9n4qOx7CWvCqrDHrXM=;
        b=6om15iknz1XHhGIOxY5dI/PfniGwcd1Wmyi4M1pwK8g1VI/aUabG+SJKWvbhoigT42
         WfDvjO190jPLN4btAAo/cqBVNwjYN/s4PTT3cUvyDEaDz1HiMA5K7lcdDz7NZOMxYaBQ
         ngHsCtHjR5eeXw7xKC1mdJUfidv+YSFMKB3p2mmqnLU1kDbd5LCVC//08wq05Z55d8Bt
         ai3sZYv2CK+bbMvLQGDW3nt2Tkb0ZXpicsU4/7Np2tdgg5DOhXKkDMsCGBbl1MM1DADD
         FVgj5Ki86KwdZI6ABd/3XC8Y0qqp26KB8rpxqTDzsYtLThmSiQf0dH1I+YuUh45EaiSv
         cMRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=CSnjAqQr4tSeG4hTXr4Ix8paO9n4qOx7CWvCqrDHrXM=;
        b=xMakZsefZHtNSzcOWnU2ktTtNJ/Hrh5VTtvmvZYVUd7NHEStGwDwaNmXjZLTx/AK30
         xlWM4ER+uuWRd5padhR4KtoRTFOFf3QkFUU0qUYDjkNdAae8OX701quJi7QTmcpJvu9a
         +151cF853OjYgCLnyfknmV01w2b7fDs90CpPBhLjMUDdk1Z9F7xUsmlk5LrwLZK6RASq
         Jwpq+N+7rpbm7KH6LSsmJocLbmKneULkkQS3PyJibXfumdJe0Fn5QRefp7omtELb21Er
         3yfDIKJ2nPnZC+Rw7Dj3UVAYTMNGfyG0FsiyNRcAnYSD9Hzx5RriaeIylZGXg7r26FkN
         8l3w==
X-Gm-Message-State: ACgBeo1iZb7X2OXWvpk+oJ69lYyOjgydfmWyHeUSYq3/vb77AlLw5YGu
	mWeghFPOT6hNEPnrmqNam7rYWPn4+mJ1aIjn
X-Google-Smtp-Source: 
 AA6agR61wbT8PPmUJ+BniL4bl96leFaSAr/vH/U8Vw7t3INw68F9Xv9TSKqHXZittouHZf9g5gZABA==
X-Received: by 2002:a17:902:f64f:b0:172:a790:320a with SMTP id
 m15-20020a170902f64f00b00172a790320amr31867771plg.149.1663079224457;
        Tue, 13 Sep 2022 07:27:04 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 f196-20020a6238cd000000b00540de61c967sm7840286pfa.201.2022.09.13.07.27.02
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 07:27:03 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 02/14] cooker: Drop sre_constants
 usage
Date: Tue, 13 Sep 2022 04:26:32 -1000
Message-Id: 
 <03e1622c2e73eaefd15b762971dd23acfdef5e62.1663078873.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1663078873.git.steve@sakoman.com>
References: <cover.1663078873.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 13 Sep 2022 14:27:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13963

From: Richard Purdie <richard.purdie@linuxfoundation.org>

As reported by Martin Jansa <Martin.Jansa@gmail.com>:

bitbake/lib/bb/cooker.py:16: DeprecationWarning: module 'sre_constants' is deprecated
  import sre_constants

it's deprecated since 3.11 with:

  https://github.com/python/cpython/issues/91308

The correct replacement for our usage is re.error so use that instead.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 3c0cd401472ffee06d5a93bdba566cb033851fcf)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/cooker.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 6da9291f..2adf4d29 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -13,7 +13,6 @@ import sys, os, glob, os.path, re, time
 import itertools
 import logging
 import multiprocessing
-import sre_constants
 import threading
 from io import StringIO, UnsupportedOperation
 from contextlib import closing
@@ -1907,7 +1906,7 @@ class CookerCollectFiles(object):
                 try:
                     re.compile(mask)
                     bbmasks.append(mask)
-                except sre_constants.error:
+                except re.error:
                     collectlog.critical("BBMASK contains an invalid regular expression, ignoring: %s" % mask)
 
             # Then validate the combined regular expressions. This should never
@@ -1915,7 +1914,7 @@ class CookerCollectFiles(object):
             bbmask = "|".join(bbmasks)
             try:
                 bbmask_compiled = re.compile(bbmask)
-            except sre_constants.error:
+            except re.error:
                 collectlog.critical("BBMASK is not a valid regular expression, ignoring: %s" % bbmask)
                 bbmask = None
 
-- 
2.25.1


