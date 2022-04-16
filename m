Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326C9C63705
	for <webhook@archiver.kernel.org>; Mon, 18 Apr 2022 14:25:59 +0000 (UTC)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by mx.groups.io with SMTP id smtpd.web08.22134.1650136652504373115
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 16 Apr 2022 12:17:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=W9tyutny;
 spf=softfail (domain: sakoman.com, ip: 209.85.215.176,
 mailfrom: steve@sakoman.com)
Received: by mail-pg1-f176.google.com with SMTP id k14so11971473pga.0
        for <bitbake-devel@lists.openembedded.org>;
 Sat, 16 Apr 2022 12:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ntbEBgEoRRUyWCfh4d/C4laqmkbKxqO/Ee36POy1LYg=;
        b=W9tyutnyVQeYnktBghojpKFRfRMvoC8EmxYTAcCkFTIpoHObihnjazAVq1TElUxB3k
         KGVJU+whIQTUSdDDKdbSD2Y8TyVhENtQLUl1dljO0/M+KNKAHgTNhRile1AROcNjkRB5
         A9K63NQUVjIk/dQjic8lnm9KOT0Ts4vsJfbhtxAsydEaHUvxb04hvgzovNfrw+ZJgJyc
         7Dmk+76lfIOfMewZCCXX3s7kbnrkXOrZjhvGWzI1M1KjQQxvczFOcO/94dP6tyBcWXTi
         pKJ7vbKfLbbMVQBcyexGI20vaSVH5ak9lWWkZmPaqdGIjCSwYmEBS3cL3eZvH4c+N2bL
         r7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ntbEBgEoRRUyWCfh4d/C4laqmkbKxqO/Ee36POy1LYg=;
        b=E1I6765j6N8sYXZPt0ehe7Vj5YtjBdsFKR6BXdM0F2ZBuFYM18Yt+smz18vapDJF7n
         MCHN6vvntMExDSRsu4WbQifY47+9ADh27Lx1bfTFulZlw8L2J/covQ5H6fIwqokBc9A6
         EiSM6NrtwtwPIDIF/UiZKxaud+s8Pv+2nC/2CS0v06ANAnU+bEQfpJ55hwVz+fVQAaqC
         GTPBNDC/WQdlaZDZFySQ+eyVNXjg2tc2RIm/cuMrAvRU5eTZrNER/WyxYRKlIUYZrO+0
         3RFi6fQDGz/wainykMfCT8X2SBgPO5wv1LRAaJJwVxI/tb4R5fQn71bVwwPKBH520+Mq
         Erdg==
X-Gm-Message-State: AOAM5319cDpBEDAwGTk6MDrKOTHhYO4Y82Sgh49pjwwemjOPcn7tGj3L
	nSUlZuxSnb87XMqw6rnYQi6+5C+/POFOhLLMn2g=
X-Google-Smtp-Source: 
 ABdhPJyME5W2Of2xvWhOQTM0DoGT9q76LaNFXinmZxaKWX/rVDn/8SBTzmg2sBVYuZTIK0+99AMejw==
X-Received: by 2002:a05:6a00:850:b0:50a:4f33:5fcc with SMTP id
 q16-20020a056a00085000b0050a4f335fccmr4390115pfk.76.1650136651609;
        Sat, 16 Apr 2022 12:17:31 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 h5-20020a17090a648500b001cd5137217fsm8324996pjj.47.2022.04.16.12.17.30
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 12:17:30 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH] server/process: Disable gc around
 critical section
Date: Sat, 16 Apr 2022 09:17:10 -1000
Message-Id: 
 <1543c163b7b57e8f5147b556873c19efbc048d0b.1650136542.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1650136542.git.steve@sakoman.com>
References: <cover.1650136542.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 Apr 2022 14:25:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13638

From: Richard Purdie <richard.purdie@linuxfoundation.org>

The python gc can trigger whilst we're holding the event stream lock
and when cleaning up objects, they can trigger warnings. This translates
into a new event which would then need the lock and we can deadlock.

Disable gc whilst we hold that lock to avoid this unfortunate and
problematic situation.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 96a6303949cefd469bcf5ed250ff512271354357)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/server/process.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 3c9ed706..4bdb84ae 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -25,6 +25,7 @@ import subprocess
 import errno
 import re
 import datetime
+import gc
 import bb.server.xmlrpcserver
 from bb import daemonize
 from multiprocessing import queues
@@ -671,8 +672,10 @@ class ConnectionWriter(object):
 
     def send(self, obj):
         obj = multiprocessing.reduction.ForkingPickler.dumps(obj)
+        gc.disable()
         with self.wlock:
             self.writer.send_bytes(obj)
+        gc.enable()
 
     def fileno(self):
         return self.writer.fileno()
-- 
2.25.1


