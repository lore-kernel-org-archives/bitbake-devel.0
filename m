Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E593CC433EF
	for <webhook@archiver.kernel.org>; Tue, 21 Jun 2022 18:21:25 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web09.47105.1655835675999463112
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Jun 2022 11:21:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=bNj4R24p;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.169,
 mailfrom: steve@sakoman.com)
Received: by mail-pl1-f169.google.com with SMTP id o18so6194693plg.2
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Jun 2022 11:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=k1x4vw8yHkic5ZcHlK8FUyQKYpvGk1aOXSLZ2F9R2IA=;
        b=bNj4R24pCDJyRAaP2hTaH1+A7MB2i2Dj3JiTJerkyIRnuN+iAMQlgM2lN7oiRCzNyM
         +tycHQC+nL8/hLVe1AuQdd3yb2CKZ+nT+rjey1wY4ih0pv8ArW0j6eGNcYe+dQmmHMXH
         bI9SZN2PmW5U+Tt1xMN6h4oVzejNu93ErLA3iBlWG/BRadyrKKbqz9W6scZXfji0MB0a
         v/lHmuWODryzTLdFKtH0xAnnpOPIffxSMTi0AP/8h99BISJ4K861nRDtckHN+pZKTvVF
         zqjth+84lwrCT5CIGAZvd4gEK4mCgyCCR325gfXmmC//zVdwJYBST52sRPqdIG0ohtDQ
         L3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k1x4vw8yHkic5ZcHlK8FUyQKYpvGk1aOXSLZ2F9R2IA=;
        b=tawkGdMBeJmM6ngA5Fay5W7TnH/QQxyn4P83ujL+n+QxvlQyfn9yrhjNzJh3uCKmcM
         uzEGbYWHIrtNq1RxIZOijnssROVlkfKpTT0o2kgEXCMDbrDXTgMq9Niq8aQAIZc68j93
         EwZvDSbb2ItGqqCsZwBpTA1hIlGEfWNO0kbyq1J8arNwnv/9uXG8kArxJV2lxsRAYKnG
         QK+qkXdqci+eRlTbWdXbWOECSDrbT9lmDKbPvP5hzGL7HvhP9OQKFHKEl2efwWYnI8sT
         mdS0wMwikUGjZvhgXBTJ8pDS3cHsUam29AqaCXDMCFODXoI/24jCHaLRVN1xl/6+W/Wn
         iLlw==
X-Gm-Message-State: AJIora881nH1r9bNrh/rUT2CZNA0DG1yc/0gGQmhJ5YyV5PGxgyq5G43
	oULrd7bOVlOMZtMkn/brJfsvcwjkXPb7aWJA
X-Google-Smtp-Source: 
 AGRyM1sIcNd2El4s7CwxC9lKmPfViCgVd+bOE6GELUZzaL/ZCVDq2Xb5i2xduY7xkLxrUkowEInWjQ==
X-Received: by 2002:a17:90b:18b:b0:1ec:b259:a6af with SMTP id
 t11-20020a17090b018b00b001ecb259a6afmr10878529pjs.237.1655835674853;
        Tue, 21 Jun 2022 11:21:14 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 t13-20020a1709027fcd00b0016392bd5060sm9755503plb.142.2022.06.21.11.21.13
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 11:21:14 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 1/5] server/process: Disable gc around
 critical section
Date: Tue, 21 Jun 2022 08:20:57 -1000
Message-Id: 
 <0784db7dd0fef6f0621ad8d74372f44e87fef950.1655835530.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1655835530.git.steve@sakoman.com>
References: <cover.1655835530.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Jun 2022 18:21:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13779

From: Richard Purdie <richard.purdie@linuxfoundation.org>

The python gc can trigger whilst we're holding the event stream lock
and when cleaning up objects, they can trigger warnings. This translates
into a new event which would then need the lock and we can deadlock.

Disable gc whilst we hold that lock to avoid this unfortunate and
problematic situation.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 96a6303949cefd469bcf5ed250ff512271354357)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
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


