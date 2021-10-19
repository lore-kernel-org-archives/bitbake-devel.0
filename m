Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0421C433F5
	for <webhook@archiver.kernel.org>; Tue, 19 Oct 2021 20:06:33 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web09.15499.1634673993523537161
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 19 Oct 2021 13:06:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=bft34R3O;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.50,
 mailfrom: steve@sakoman.com)
Received: by mail-pj1-f50.google.com with SMTP id gn3so846880pjb.0
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 19 Oct 2021 13:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=G06EE2U9a7hAygxMpP8doEUkwrrG/YqhqCqVClnNjyA=;
        b=bft34R3Ovvs5zkoH4Vl58+a9nIYOkVbxLW3TcaozCWodYyjU9JBNBl+v+Muken5q7U
         yMcLLMd+HuooXCL42Qjem8P5Hzw+EZkVUwdh2o7Z/rK1pfTgrC6XoCzxPzoXckKLddH2
         PjyKlpunLKH9WqJDG/MFdtD+MO2Pfh8p56xtGP46XAYLhKynpTKblgwG0TbBJb1AVBCD
         dzgBiF04wavkAPfYdghOAMc+D/XHfp+zEzKX3KbYDG75dU/YUGDb9PkN35aiCaexY3Tl
         c7ub9DdUTE4kneYqG/AJjqC1jdu4wcFRmBMW3iWkz2aNt3UAQE3TVG3Zj0OOncsKr6YU
         dcIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G06EE2U9a7hAygxMpP8doEUkwrrG/YqhqCqVClnNjyA=;
        b=kdSnMlWXcHiIAHICY7VZlOP8hoMNp9Bot7aY1TX8JylDtEvnhjbtRb109ZzEYxO/45
         VVB+v+tiamyFQzBfn96nlDUmT14dbFwuyQUY3blThLXQHc67uYOBwTh57jJ4F0k7WMyy
         ZXQbSw/KbLHeDbUYXzVd48tppLAI1RrjMdmnxqgpxJ8sU5WW/ey2yKFlIwcq5aAJlnjk
         uJIfbR5HlyULKfZeW4KaPjUoOf4s7zb/hzdAtiuku6aK7aNK0jcYAfQc+JrtkNtvTT1O
         aaJCtPL/RavUs8QLl0/01C9qkp56w4V6gp66s9xZ86e7rqEfWCYpwXJLrzbHxZ1My4Dm
         y6fQ==
X-Gm-Message-State: AOAM532BFkH1GMqau1dj0G0rzC0BjdYOk3BT7kvMs7NK8VtI4oh2QTs6
	+tPi8d+XJlrdIpEHLyS9+4Qbi2mUQhQoRkdCozI=
X-Google-Smtp-Source: 
 ABdhPJxG3eI2s+807hth4eCw+fyPIGVyUiLPmyY8Jt6jZeS7Scj3/HJnV6KX9Cy7fX5vYlzrItRmzg==
X-Received: by 2002:a17:902:d4cd:b0:13f:50d:d89 with SMTP id
 o13-20020a170902d4cd00b0013f050d0d89mr35626193plg.18.1634673992650;
        Tue, 19 Oct 2021 13:06:32 -0700 (PDT)
Received: from hexa.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com.
 [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id
 l6sm3533562pjy.23.2021.10.19.13.06.31
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 13:06:32 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 2/8] bitbake: correct the collections
 vs collections.abc deprecation
Date: Tue, 19 Oct 2021 10:06:10 -1000
Message-Id: 
 <655e53d7639fd17e8cc306dcee024222aa1effad.1634673786.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634673786.git.steve@sakoman.com>
References: <cover.1634673786.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 19 Oct 2021 20:06:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12804

From: Alexander Kanavin <alex.kanavin@gmail.com>

This becomes a hard error in python 3.10.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit ae219e1f7460077f4492b31ac91cef4cf9b17277)
Signed-off-by: Justin Bronder <jsbronder@cold-front.org>
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/data_smart.py   | 2 +-
 lib/bb/persist_data.py | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 68770832..c8d2a437 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -17,7 +17,7 @@ BitBake build tools.
 # Based on functions from the base bb module, Copyright 2003 Holger Schurig
 
 import copy, re, sys, traceback
-from collections import MutableMapping
+from collections.abc import MutableMapping
 import logging
 import hashlib
 import bb, bb.codeparser
diff --git a/lib/bb/persist_data.py b/lib/bb/persist_data.py
index 5f4fbe35..56c983f8 100644
--- a/lib/bb/persist_data.py
+++ b/lib/bb/persist_data.py
@@ -12,6 +12,7 @@ currently, providing a key/value store accessed by 'domain'.
 #
 
 import collections
+import collections.abc
 import contextlib
 import functools
 import logging
@@ -19,7 +20,7 @@ import os.path
 import sqlite3
 import sys
 import warnings
-from collections import Mapping
+from collections.abc import Mapping
 
 sqlversion = sqlite3.sqlite_version_info
 if sqlversion[0] < 3 or (sqlversion[0] == 3 and sqlversion[1] < 3):
@@ -29,7 +30,7 @@ if sqlversion[0] < 3 or (sqlversion[0] == 3 and sqlversion[1] < 3):
 logger = logging.getLogger("BitBake.PersistData")
 
 @functools.total_ordering
-class SQLTable(collections.MutableMapping):
+class SQLTable(collections.abc.MutableMapping):
     class _Decorators(object):
         @staticmethod
         def retry(*, reconnect=True):
-- 
2.25.1


