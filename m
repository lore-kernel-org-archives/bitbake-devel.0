Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAD2C64ED9
	for <webhook@archiver.kernel.org>; Mon, 20 Feb 2023 22:25:52 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web11.28213.1676931948757938964
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 20 Feb 2023 14:25:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=i4xPqkyE;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.182, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f182.google.com with SMTP id e24so1461634pfn.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 20 Feb 2023 14:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OhIh0KZ6HH76BJ2iq/xQLWythhPNDltmlzcL8CupPAA=;
        b=i4xPqkyEzk8iOrz6i9TNtgrYQWVUhM0JxhqN268w+3K9B/xDlPXbnvAWBixH0jE7NW
         vbDkjp0kBM6YegJydC8Tyo1FRMvlnA1YsLpEy5F5uxMTU976DNXWBOLfpCyhUFfr8XN6
         au/NIk9sR6qg+vKoscwC7zl9qBpLLjjuyUhw7djOaujasSt4pwRt0N0S0mKpliOeyevT
         5vBAcBAJub9/em2Hg3OTe44x9CX5slwJkNXHHMa/heca/N/s+b0pYNnUCg+ILu1q9+Yd
         N5YOuJuZYSFGqRMoQLP/T6KCxGQEfVYZi76ASo8Kan+RL7CCSjKcWnE+UyRW2pZ4nfof
         AZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OhIh0KZ6HH76BJ2iq/xQLWythhPNDltmlzcL8CupPAA=;
        b=aupTSSnHuTB1nx1/9lYuEC+c4kClutWxksA6iahrFlWF3teqFpxNGarKVKOSURzm1Y
         /WPClX6ttBoZWIBcpE0h+QDHQrs+ovjVeHsWG67LfKtEA7MjKheg0A+YQrSF4XeSD9cF
         p+mFQRaLn01zi0S3zW7KoyYjbLOj3vZQ5uIMXw2hIOww6ElqKP/OVHDXgfWsajyMWoZY
         qmEoLRFf+rGJj3MsAn/FZdDecHOAXXNUz7nkID7IY7B7MUYwAKyCnYu87pg/FeZr5Mg5
         KbYlB0Wy6UY8C/n7voiPhnDhkfkTojsCF5gAY4e2uxn9s6H4mxoeXOGG49fn/3iFmkx4
         YH5g==
X-Gm-Message-State: AO0yUKX8G8Xkt9qedY5iClf5o2vRhcrVFfl3uQMFwP+FyLQxUEFshS/1
	IAHIk2U1LB6MWuD+5dRpKuHK+Zf0go/ay59EZCE=
X-Google-Smtp-Source: AK7set/pU2gta8cOqDJ9Jhi0FOCuEOAsf+bVEMXX1Ki/p1H4Z/BN/TXwYzngQKmDLbvyYtrHuEFRRw==
X-Received: by 2002:aa7:98c3:0:b0:5a8:4ba7:5840 with SMTP id e3-20020aa798c3000000b005a84ba75840mr1700082pfm.26.1676931947852;
        Mon, 20 Feb 2023 14:25:47 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-253-4-112.hawaiiantel.net. [72.253.4.112])
        by smtp.gmail.com with ESMTPSA id q21-20020a62ae15000000b005a9131b6668sm8191447pff.2.2023.02.20.14.25.46
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 14:25:47 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 7/7] cooker: Drop sre_constants usage
Date: Mon, 20 Feb 2023 12:25:23 -1000
Message-Id: <a4cd5b0b4b355b7b75fb48c61289700e3e908b2a.1676931822.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1676931822.git.steve@sakoman.com>
References: <cover.1676931822.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 20 Feb 2023 22:25:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14474

From: Richard Purdie <richard.purdie@linuxfoundation.org>

As reported by Martin Jansa <Martin.Jansa@gmail.com>:

bitbake/lib/bb/cooker.py:16: DeprecationWarning: module 'sre_constants' is deprecated
  import sre_constants

it's deprecated since 3.11 with:

  https://github.com/python/cpython/issues/91308

The correct replacement for our usage is re.error so use that instead.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/cooker.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index ac54d437..6743bce5 100644
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
@@ -1795,7 +1794,7 @@ class CookerCollectFiles(object):
                 try:
                     re.compile(mask)
                     bbmasks.append(mask)
-                except sre_constants.error:
+                except re.error:
                     collectlog.critical("BBMASK contains an invalid regular expression, ignoring: %s" % mask)
 
             # Then validate the combined regular expressions. This should never
@@ -1803,7 +1802,7 @@ class CookerCollectFiles(object):
             bbmask = "|".join(bbmasks)
             try:
                 bbmask_compiled = re.compile(bbmask)
-            except sre_constants.error:
+            except re.error:
                 collectlog.critical("BBMASK is not a valid regular expression, ignoring: %s" % bbmask)
                 bbmask = None
 
-- 
2.34.1


