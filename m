Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web10.11830.1620736850898038124
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 May 2021 05:40:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=PXa784Dy;
 spf=pass (domain: gmail.com, ip: 209.85.214.178, mailfrom: akuster808@gmail.com)
Received: by mail-pl1-f178.google.com with SMTP id b21so10793057plz.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 11 May 2021 05:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZJNrquMOQRhxN5DpankgRU+6czyPbaLJ8AZc5aRdRD0=;
        b=PXa784Dy/BYzQQeNsUtrCBYd1k8/AUaN9Jik6zsfoZ+mtHn7QAQrgPH5EA+dBDQua1
         xvYD8HwMGTj0Tok5wkJUZm+JUqT/wPxoMM7coeHvSFXXYqomPPE1iSm1yjAZ2EzrFrvy
         Ae1Qbcqq4lYg3Q6/pTYQ9D/VRW7iw1Trca0tRx/CvqURWktj9Pn0yvaEnJ+tYUlqicP9
         Jzn2ijxyYc9KJgi94BpisvTv0h+V5qIwTGA47PkSxRYIr7C6ZF2Hi50gKFbs/x7/ppG8
         hCOr5BcMhQAFWMFuuGuTKSfoGLlFcXDluoQBjQrgPNM1D6vRLrutj+dahVrAGmjbZwfi
         zxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZJNrquMOQRhxN5DpankgRU+6czyPbaLJ8AZc5aRdRD0=;
        b=MOEk+EVu+j/OKzfASfp6lxprOL3vOELFnvlZ8lmhfCmJUKLFnsj4rFYnhKUQecZhnP
         oMBfl3jE7jzQ/tozAfyP5AwB03+9tyxWjNLa+zoUt5nVfZmryHAhSsEB7/ZHqRGxfJ+U
         JQSp5RFc1+GeiOc1SFc2VyTJ8D9jJFcHXPGJtfhVSS3Xq2epdjUdsCWltq5u+sTTMCLh
         3JvgX1KllHONIH+B4tLKGrm9kiQiwudw0FmMXsibdDMEKSa6+9nUD06ca4ImtB5W+rtF
         2qh8/jw4HJMXi9gV0rHQDOIZCbPhARG51+ohhRqZMKfF/FRSdY1pvIHcAxp+403JPLcK
         pwPA==
X-Gm-Message-State: AOAM531Ts6/Pr2lo6I0PfCABD7ijEuSEqdwS444DqapB5/zXnRwJDnJT
	6OmIN6wqQ4Ld/htpw8qhVLn5gauX1PM=
X-Google-Smtp-Source: ABdhPJwNUNIDRVdJ0BqdhXW17+e1PH3L+rzVMq79y9nTXHuYaKzoSb7eUHNn3hpig9mhGnO9nhrqUA==
X-Received: by 2002:a17:90b:8d5:: with SMTP id ds21mr4864774pjb.65.1620736849911;
        Tue, 11 May 2021 05:40:49 -0700 (PDT)
Return-Path: <akuster808@gmail.com>
Received: from hilo.hsdl.ca.comcast.net (c-67-181-203-136.hsd1.ca.comcast.net. [67.181.203.136])
        by smtp.gmail.com with ESMTPSA id x133sm14439043pfc.19.2021.05.11.05.40.48
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 05:40:49 -0700 (PDT)
From: "Armin Kuster" <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] hashserv/server.py: drop unused imports
Date: Tue, 11 May 2021 12:40:46 +0000
Message-Id: <20210511124047.2342984-1-akuster808@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

remove unused vars.

Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 bitbake/lib/hashserv/server.py | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/bitbake/lib/hashserv/server.py b/bitbake/lib/hashserv/server.py
index c941c0e9dde..8e849897371 100644
--- a/bitbake/lib/hashserv/server.py
+++ b/bitbake/lib/hashserv/server.py
@@ -6,13 +6,8 @@
 from contextlib import closing, contextmanager
 from datetime import datetime
 import asyncio
-import json
 import logging
 import math
-import os
-import signal
-import socket
-import sys
 import time
 from . import create_async_client, TABLE_COLUMNS
 import bb.asyncrpc
@@ -124,7 +119,6 @@ async def copy_from_upstream(client, db, method, taskhash):
     if d is not None:
         # Filter out unknown columns
         d = {k: v for k, v in d.items() if k in TABLE_COLUMNS}
-        keys = sorted(d.keys())
 
         with closing(db.cursor()) as cursor:
             insert_task(cursor, d)
@@ -137,7 +131,6 @@ async def copy_outhash_from_upstream(client, db, method, outhash, taskhash):
     if d is not None:
         # Filter out unknown columns
         d = {k: v for k, v in d.items() if k in TABLE_COLUMNS}
-        keys = sorted(d.keys())
 
         with closing(db.cursor()) as cursor:
             insert_task(cursor, d)
-- 
2.25.1

