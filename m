Return-Path: <Martin.Jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96453C43334
	for <webhook@archiver.kernel.org>; Wed,  8 Jun 2022 08:57:47 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44])
 by mx.groups.io with SMTP id smtpd.web12.4225.1654678658562821608
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Jun 2022 01:57:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=nRcYLS6c;
 spf=pass (domain: gmail.com, ip: 209.85.218.44,
 mailfrom: martin.jansa@gmail.com)
Received: by mail-ej1-f44.google.com with SMTP id m20so40027791ejj.10
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Jun 2022 01:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QyyfMkKLAn2EXEnLwCEEhfshmrC7ZSA1Wl6bChOIbcI=;
        b=nRcYLS6cWLPi96bBW9Mk1qTsKb3WgduT1iDliqNiMmpS1I8eLtd8CGUEvvPRbLYDzi
         uAMVc4gYvLic8hMteJl3ObOcmWOs0A63kI7xxXy+87bYdfHhSJ7io4YuaIkJ6+QC5oag
         O3tTHlqzDcvnS0JTOS2tSAwB2K+ETdqdoum/wMEpbfyjtoJVPnc1eEg522f7b65aHe8J
         2jcKb8LuzYT43opW+fukAG+YpXENnwJ8wdlDbxmB3huwsHE74dNOadHb0m9WdF0BGVUM
         P/gD8b6jUiKkCXcZTnqpqDw+C3dVteTUpHq9xu6NfrO1hNJHgxu+fLCRfJSTfo4y840A
         gwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QyyfMkKLAn2EXEnLwCEEhfshmrC7ZSA1Wl6bChOIbcI=;
        b=XMMfZHKlNicl7uqrEyYs797Pvy80vsK1+kGAe3cd5ImdbK/jcQTYWYObAvXrTrWtQB
         06BssFmoPUrwOtyMnB1O5QdkkZEuwU7zs6+b+7xJzp8AlC9a+8a1ooe4ddYiAW+hgzmG
         CFKCXzFbuGv72WsGJVYJ0G2X9H2UBTpGiCoB+qppBVRLT0x76e2fZ7GbbEzYhGkeVxqI
         AYWHV3Q/ZHNtSna6UGh+a3n+vgssSevI8yplOYwArDv8qXean62tMG0rusJGFqYRjBOp
         0q1ajAjgXKBAEze5nKMv2GK3GX4O4xJ2l2E30eW/8JMyryK38kEE1cHDqn8mUgVKm7m/
         EGkA==
X-Gm-Message-State: AOAM530p1fT++/VhYxm95AVvPQzVSyiT1ILSj5B+0CKuV5UyGCW571xH
	zUYytiGmi9iomXTsQXF00ehwVmZBCJY=
X-Google-Smtp-Source: 
 ABdhPJwvvo01+NhutOVzuEDTP++9JEi9clqBhgZlKyn58ECd4R3YB26S333RLpTOMILkulJ7Gy/CrA==
X-Received: by 2002:a17:907:72d5:b0:6fe:c343:1ace with SMTP id
 du21-20020a17090772d500b006fec3431acemr30619233ejc.563.1654678657045;
        Wed, 08 Jun 2022 01:57:37 -0700 (PDT)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id
 rn13-20020a170906d92d00b006f3ef214df2sm8717641ejb.88.2022.06.08.01.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 01:57:36 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Martin Jansa <Martin.Jansa@gmail.com>
Subject: [PATCH] cooker: avoid DeprecationWarning with python-3.11
Date: Wed,  8 Jun 2022 10:57:33 +0200
Message-Id: <20220608085733.73997-1-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 08 Jun 2022 08:57:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13739

* fixes:
  bitbake/lib/bb/cooker.py:16: DeprecationWarning: module 'sre_constants' is deprecated
  import sre_constants

  it's deprecated since 3.11 with:
  https://github.com/python/cpython/issues/91308

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 lib/bb/cooker.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 6da9291f..e417d0e1 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -13,7 +13,10 @@ import sys, os, glob, os.path, re, time
 import itertools
 import logging
 import multiprocessing
-import sre_constants
+if sys.version_info >= (3, 11):
+    import re._constants as sre_constants
+else:
+    import sre_constants
 import threading
 from io import StringIO, UnsupportedOperation
 from contextlib import closing
-- 
2.35.1


