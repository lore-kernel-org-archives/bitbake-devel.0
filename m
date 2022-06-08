Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106DDCCA47B
	for <webhook@archiver.kernel.org>; Wed,  8 Jun 2022 16:54:50 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web10.8984.1654707279794759745
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Jun 2022 09:54:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Y9elVOY9;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id n185so11219220wmn.4
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Jun 2022 09:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oymIh3MVNrKmL7njfVxR8U4iCSTBiq+W4xPDpyRJWLw=;
        b=Y9elVOY9k4qqBQcZekzTsslqI/AiA3z40kDGbn3EYamzECQooMZ1Nbc5V0n5f7YaUz
         h8N1OsGuIudEecv37zSIEyMJk5PESS9k8gVO/+34zgnpJ/ldHqp4esq6rX+i76k/NvbV
         7a4LQ/DYYeSHCPfZRVew9ypooHMqlulVMhoe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oymIh3MVNrKmL7njfVxR8U4iCSTBiq+W4xPDpyRJWLw=;
        b=W4pA4U9P/cVvc/+Nh9VFfT67L4HB+YGwLmJ76eEqdGxZ1t0h0j/8rB1qkNyVlT5TCf
         cuATH6BVZY6R8f3KwPdGBYI+8UJ03PjrGJbsxWepxgqHGPZ5KNW+0S70vjTrMwwGQrvC
         eI9AFRlMfHGzJniKFhWFpm+BbU4g1FMvyr1Gyl7apYSxXM3EAmTyfZspvK0pGo0H8FGe
         3zY/FdktncR8TvgoqT1fUl9XLH1fttzBUtjPzMgI2qlNKjH+KCEtDh+J32lejnkfKz2M
         AkrUO664m1BVL5aNeKWnrMBleu+KfuTPze9XHl5fSbz+InmeCBO30mwSaBYVQKg2JtIT
         WJrQ==
X-Gm-Message-State: AOAM532WQg9FagC2WSV2BJFugq6p6JJmaEw3w/kV1JfuSR5wIweJHjON
	S4b1SUEPL4Mfph46t1197UeC4Gd32UaAsA==
X-Google-Smtp-Source: 
 ABdhPJzWh3Bp3In5ivRLrY4Ofx04zHJ+DOyfksW3McSg8ccCD8KWPoEOBhaqCWbzfvFu7Mo3HoZgoA==
X-Received: by 2002:a05:600c:4e04:b0:39c:66bc:46d2 with SMTP id
 b4-20020a05600c4e0400b0039c66bc46d2mr126402wmq.71.1654707278019;
        Wed, 08 Jun 2022 09:54:38 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:2793:ec22:da5d:8e52])
        by smtp.gmail.com with ESMTPSA id
 k26-20020a05600c1c9a00b0039740903c39sm23411156wms.7.2022.06.08.09.54.37
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 09:54:37 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] cooker: Drop sre_constants usage
Date: Wed,  8 Jun 2022 17:54:37 +0100
Message-Id: <20220608165437.394767-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 08 Jun 2022 16:54:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13742

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
index 701e49339a..77ddd440a2 100644
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
@@ -1926,7 +1925,7 @@ class CookerCollectFiles(object):
                 try:
                     re.compile(mask)
                     bbmasks.append(mask)
-                except sre_constants.error:
+                except re.error:
                     collectlog.critical("BBMASK contains an invalid regular expression, ignoring: %s" % mask)
 
             # Then validate the combined regular expressions. This should never
@@ -1934,7 +1933,7 @@ class CookerCollectFiles(object):
             bbmask = "|".join(bbmasks)
             try:
                 bbmask_compiled = re.compile(bbmask)
-            except sre_constants.error:
+            except re.error:
                 collectlog.critical("BBMASK is not a valid regular expression, ignoring: %s" % bbmask)
                 bbmask = None
 
-- 
2.34.1


