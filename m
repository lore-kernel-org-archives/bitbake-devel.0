Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9CEC00140
	for <webhook@archiver.kernel.org>; Fri,  5 Aug 2022 09:49:19 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web11.5156.1659692958841544934
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Aug 2022 02:49:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=E2hTZpb3;
 spf=pass (domain: gmail.com, ip: 209.85.221.52,
 mailfrom: quaresma.jose@gmail.com)
Received: by mail-wr1-f52.google.com with SMTP id j7so2657673wrh.3
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Aug 2022 02:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=Q/mnAqoYi7oxgwFJLPXIomsmBCatzWPJFIvMIV/UMY4=;
        b=E2hTZpb3IZj3bphd/72CJ9LxY/8bhwYU5Up4zalmaMo43KoNTbVsJKoHVEFkTCCrR9
         dkvvTHen5H496vLQvIu5h0PHnBxoIM0CNjDaxW70XOxkW4y0IrL2aG7KYbZmw2QU+OoU
         u5obksZTbyGmNZyhevNtELkVtR44m2Kelfjd7Bm4lMy0mGJ1YOMpC1uFkcWQCOVGxlRj
         dnPfrdXBFtUDIBcbDkg2C0bH8aKZx52M5UAOStTeqg248A4EoK3elq/nqLuZbzoasmXh
         ot0Qm6nC6/aKVj2ct/vbFWVhk5EZqU1uCExz0rWuhEhw480rzuELFE2ZAwVqFIoT8+0E
         ItNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Q/mnAqoYi7oxgwFJLPXIomsmBCatzWPJFIvMIV/UMY4=;
        b=Kirge3Mn9TovHdJEHBSncmAW7vLMQ+ZxDPebaPXtSXXc2iWBBQDHqDzY3+E6UaNGya
         MzMWvSCQkXSvfQwm6MAIEQPTPKQaBbuJmd3mf8rT7kSlomgF75FX5GT0wOYDjDIhp8O8
         exIZBcpBmsL1YHQCfkoco2BHXOEm3B7pBdfnLADS9uHDd3O39imjoC+RTr1IVKXB2OIq
         z447xIJgRJDP0s0PU37//vj4JBSl+dVnN3ybjZX+FTBtsQubN4C0/hPj+7fuz0R9gH60
         QjFcQWZibvy4ggJiCscKUcYtmOfDU0dX9UW05ojI1jOrHblmRDg/IDTDsDL2P0YU+xjO
         EfdQ==
X-Gm-Message-State: ACgBeo272II+GFM7fbiOb5lEPTFGHDk1g9sV+zJFqMnODmSEJ2g6VoPV
	odesGEi8wA15PrSJRrCMh5pgxQeBBck=
X-Google-Smtp-Source: 
 AA6agR5XIF0e4GJ53iYhSNAL+fKclG6W+G6eTtVnhrHrmzO5RuNlp37wKS0LRkgKIKTamiJktUKhjA==
X-Received: by 2002:a5d:5986:0:b0:220:6871:de88 with SMTP id
 n6-20020a5d5986000000b002206871de88mr3758093wri.469.1659692956929;
        Fri, 05 Aug 2022 02:49:16 -0700 (PDT)
Received: from fio.lan (176.57.115.89.rev.vodafone.pt. [89.115.57.176])
        by smtp.gmail.com with ESMTPSA id
 r29-20020adfa15d000000b002206d5fded3sm3460156wrr.104.2022.08.05.02.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 02:49:16 -0700 (PDT)
From: Jose Quaresma <quaresma.jose@gmail.com>
X-Google-Original-From: Jose Quaresma <jose.quaresma@foundries.io>
To: bitbake-devel@lists.openembedded.org
Cc: ricardo@foundries.io,
	daiane.angolini@foundries.io,
	Jose Quaresma <jose.quaresma@foundries.io>
Subject: [bitbake-devel][PATCH v2] build: prefix the tasks with a timestamp in
 the log task_order
Date: Fri,  5 Aug 2022 10:47:51 +0100
Message-Id: <20220805094750.390489-1-jose.quaresma@foundries.io>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Aug 2022 09:49:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13872

This is useful when debugging as it helps understand possible
race conditions between tasks of diferent recipes.

Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
---

 V2: import full datetime module

 lib/bb/build.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 55f68b98..b8c1099e 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -20,6 +20,7 @@ import itertools
 import time
 import re
 import stat
+import datetime
 import bb
 import bb.msg
 import bb.process
@@ -618,7 +619,8 @@ def _exec_task(fn, task, d, quieterr):
     logorder = os.path.join(tempdir, 'log.task_order')
     try:
         with open(logorder, 'a') as logorderfile:
-            logorderfile.write('{0} ({1}): {2}\n'.format(task, os.getpid(), logbase))
+            timestamp = datetime.datetime.now().strftime("%Y%m%d-%H%M%S.%f")
+            logorderfile.write('{0} {1} ({2}): {3}\n'.format(timestamp, task, os.getpid(), logbase))
     except OSError:
         logger.exception("Opening log file '%s'", logorder)
         pass
-- 
2.37.1


