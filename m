Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91484C00140
	for <webhook@archiver.kernel.org>; Fri,  5 Aug 2022 09:26:19 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web10.5123.1659691572792583529
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Aug 2022 02:26:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=PE2TET06;
 spf=pass (domain: gmail.com, ip: 209.85.221.47,
 mailfrom: quaresma.jose@gmail.com)
Received: by mail-wr1-f47.google.com with SMTP id bv3so2572095wrb.5
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Aug 2022 02:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=Gr7zQ1zI5fzpPzU/hHvJh9qwGnfIYgXD/+rjn5ZLn1s=;
        b=PE2TET06WjY5TaHoa/4mZ12La2uCIV2lpAtroeces2tGjX0gMGlw69SS+KlLuvuGtH
         dy24fK6aoOHIBkrkT+OyBNfghTpU3iui9Bk8N/Ccj+nglWKEM2n4l44xQi1ACcH8ENU5
         Qxj8sKNV+BpsyZ9Glho+ZvjNy+fNfQaM+z3m6zih+J5kt8xDvr7MML+VKq1+OZzEHzUo
         0LZvG7NdWjtdEd7FxvN3YTgJabFVZ9X3Foe8KwDjH5X35MN/8KYwg+9KRAX0N+iah9ha
         AQ8aKobGkatDdFnrnHjRpB88R2jhN0OTDbdSAkoN39jNB5sdKl6SsGIzMbKAZp9f9sxC
         S9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Gr7zQ1zI5fzpPzU/hHvJh9qwGnfIYgXD/+rjn5ZLn1s=;
        b=f0tN7aK37CV831Mo1EtVSGbNBRNGYmGuPzIsJfnVG6xQE+FjNOE37ATLZZFxH2vOnH
         RD2sg7NvM03pI1s1m47HjH9aRC30AplsAQpsn/dl7yuuJikw3gXSS7hwj+hiY9fblgmR
         0tJ7DY39YXHnuU75U0F7xdmiLtApDVktjpHctWwVeoCxIBQpYS9O3Pq2iVLz12r8f+6W
         hhoh/k/XHUKLbC1khi3I4v9JlQPoJz8806IXt0xEgbWNwMSCyFehJnCfc/Sikole5AJX
         7yxKUmzfdskXpQP9VNc6fIdggCzakceM6a1/3Aa4QhA8SDmS1iorfc/gDR4bI9lyWON5
         wMJA==
X-Gm-Message-State: ACgBeo1t1Xo+S8U5uRAXy60lbrP/CObioSg6ADKnKyzr5HZeaz2hEiDw
	vT1na7g5LlMIRw16paSymaT5/whZp78=
X-Google-Smtp-Source: 
 AA6agR6o04/A58A75UQ9Da/vWXpRNbhSzRh0AczGgK2XfbLsWCfDGcvAyvQYBa3/C2GH9HTON58Hkg==
X-Received: by 2002:a05:6000:711:b0:220:63a5:954c with SMTP id
 bs17-20020a056000071100b0022063a5954cmr3652376wrb.667.1659691570872;
        Fri, 05 Aug 2022 02:26:10 -0700 (PDT)
Received: from fio.lan (176.57.115.89.rev.vodafone.pt. [89.115.57.176])
        by smtp.gmail.com with ESMTPSA id
 h36-20020a05600c49a400b003a2c7bf0497sm3795403wmp.16.2022.08.05.02.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 02:26:09 -0700 (PDT)
From: Jose Quaresma <quaresma.jose@gmail.com>
X-Google-Original-From: Jose Quaresma <jose.quaresma@foundries.io>
To: bitbake-devel@lists.openembedded.org
Cc: ricardo@foundries.io,
	daiane.angolini@foundries.io,
	Jose Quaresma <jose.quaresma@foundries.io>
Subject: [bitbake-devel][PATCH] build: prefix the tasks with a timestamp in
 the log task_order
Date: Fri,  5 Aug 2022 10:26:01 +0100
Message-Id: <20220805092601.388389-1-jose.quaresma@foundries.io>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Aug 2022 09:26:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13871

This is useful when debugging as it helps understand possible
race conditions between tasks of diferent recipes.

Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
---
 lib/bb/build.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 55f68b98..d998a432 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -25,6 +25,7 @@ import bb.msg
 import bb.process
 import bb.progress
 from bb import data, event, utils
+from datetime import datetime, timezone
 
 bblogger = logging.getLogger('BitBake')
 logger = logging.getLogger('BitBake.Build')
@@ -618,7 +619,8 @@ def _exec_task(fn, task, d, quieterr):
     logorder = os.path.join(tempdir, 'log.task_order')
     try:
         with open(logorder, 'a') as logorderfile:
-            logorderfile.write('{0} ({1}): {2}\n'.format(task, os.getpid(), logbase))
+            timestamp = datetime.now().strftime("%Y%m%d-%H%M%S.%f")
+            logorderfile.write('{0} {1} ({2}): {3}\n'.format(timestamp, task, os.getpid(), logbase))
     except OSError:
         logger.exception("Opening log file '%s'", logorder)
         pass
-- 
2.37.1


