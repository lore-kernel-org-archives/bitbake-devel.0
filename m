Return-Path: <Martin.Jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7746AC636D4
	for <webhook@archiver.kernel.org>; Fri, 17 Feb 2023 12:28:13 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web10.5264.1676636887809088597
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Feb 2023 04:28:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=H1BrN9W8;
 spf=pass (domain: gmail.com, ip: 209.85.128.45, mailfrom: martin.jansa@gmail.com)
Received: by mail-wm1-f45.google.com with SMTP id t6-20020a7bc3c6000000b003dc57ea0dfeso810837wmj.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 17 Feb 2023 04:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zgw+bve2VqpP9lJVEPCnxr0diunocoCOH0D37tUaiO0=;
        b=H1BrN9W85sXCiMQlpukxKyt23aUROTaLBdBHQ5t3UOTpir7eOQ/vWqv7nztu6W7GkD
         ivxaVry4x8ilORCN27GSbBIPWis6L3qIZfkRBt+bjesH5W8fqJ9tNbD/Lh2Moj7Tu/tw
         RjeB+/wqOWm+eStBv9wBt5bPDqI8vZMQ+8MZnkf+ovJjIxQKIKLu2eli/i79xTf1nNrA
         okIVtYkH/elMvj+fMPz2E9yy/uYW//MnGzavq2wLsexYRhO6UTy7Te/LTgTFW8lIzY72
         NqXKcejfRjGcwmwJggkkaYxzqLfQ5lBRcBXJw0NQpw75Q7YxZo50cAHWU5y6bYNwbGXz
         1xKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zgw+bve2VqpP9lJVEPCnxr0diunocoCOH0D37tUaiO0=;
        b=Z2/DMrDw/yc/KqzfHWzlW/0nYTMVxAfDYY8MNLiwZ9VkrlPl5FCrBWfCFCddZdlvaT
         DRwCJRC9DxbIbyzpRj4srqI9iGkZgL5CHo/+h9MAjlx4wpW8SVyW8msQW8u0AR4/269o
         +tB1fXUf0XwN7AApVg38teyh231iFPxoXvgeb6DoCRE0M2SNxRZpoNXLtz8whRi8vsrT
         fUlBVxezMK0tPbjTpYocQWMPy4GZYG4w7zBwZzzx36y+LVO7eY/XTKvSPw8IBBbytknx
         gwAwCMMzDCLiO4ajvGdODTfGaFja1VtRsQEnxaNwjFXsJRFljnNNP5oX+hDlZfUO5Mr1
         +3Zg==
X-Gm-Message-State: AO0yUKUtyaRWw/0KLO8Guz9V5ahPwQ1vU0TrShc8lstRKdou8HJDsHsx
	n4bijQ2pM2dYIzp09wBgW3JuWYuxBhM=
X-Google-Smtp-Source: AK7set8e0I82Rwx5I5seZj+Pph8LeUIjZy8ivGXcn849uF7C/hL/AYpDYKujEK1e2N1GshniwEPajA==
X-Received: by 2002:a05:600c:4388:b0:3e2:10ef:51c8 with SMTP id e8-20020a05600c438800b003e210ef51c8mr4256810wmn.18.1676636886239;
        Fri, 17 Feb 2023 04:28:06 -0800 (PST)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id o2-20020a05600c4fc200b003e2059c7978sm5577588wmq.36.2023.02.17.04.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 04:28:05 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [1.46][PATCH] cooker: Drop sre_constants usage
Date: Fri, 17 Feb 2023 13:27:58 +0100
Message-Id: <20230217122758.3639957-1-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Feb 2023 12:28:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14451

From: Richard Purdie <richard.purdie@linuxfoundation.org>

As reported by Martin Jansa <Martin.Jansa@gmail.com>:

bitbake/lib/bb/cooker.py:16: DeprecationWarning: module 'sre_constants' is deprecated
  import sre_constants

it's deprecated since 3.11 with:

  https://github.com/python/cpython/issues/91308

The correct replacement for our usage is re.error so use that instead.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index ac54d4378..6743bce58 100644
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
2.39.2


