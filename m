Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A62EC00140
	for <webhook@archiver.kernel.org>; Wed, 24 Aug 2022 14:43:13 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web09.11711.1661352182659721472
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 24 Aug 2022 07:43:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=VTrc/moa;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id h1so8882701wmd.3
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 24 Aug 2022 07:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc;
        bh=Kew1LjInkhGT2bQ4zpX4XvaMNzCUnaiFrPc5OS0cDsQ=;
        b=VTrc/moavfQUyoXavEZfaVhcjKVdhH6sLdDJITQ5nt853qwgQ7e/T+JwWcW0iXth88
         0fI9r+Uvw1D/vdW0FgQkXdgHoa5adnbySd09AXkH3rVTQxIK2otBsfpsbhHBeuzwk2YZ
         8uwfAAun7DLDBLF2YEoVw+WHJybHUfBXG/FOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=Kew1LjInkhGT2bQ4zpX4XvaMNzCUnaiFrPc5OS0cDsQ=;
        b=LAx/d0Dqa3Hn1I+N2s+aipWbd7piVTxVkofQHhWrlitGtRD7JJoEqlxL0QL6mmZmoG
         voIl77gvIaIpPqveKHNtk5CQ5GviHFlYNTFnrwJuke97/1sqsoXfymYYS/0PLfO1j9Bq
         85Vs7yUmnjlZvY/mIg4FQtaafMHeSfBROoHpmE9M0jor86Ml2WfloiCcZ/gdfCeO67VR
         CtOmok1WfmGaRET9Srw+hPI3JIw2HMMTe8Jq3X1bGPJKD0TbCbCjbvswK1J6ulZh0yGO
         oJrPiQfA/zj68FO3Y5rO72Oql5zG7ljPzXZMzF64IpaRt0y7scGwKiWcy/Az3pYK1PLt
         cwNw==
X-Gm-Message-State: ACgBeo1OofwT/VKEjUtEM9cJUNDGwYPNoDoYVLokQ5hAGCHd2hWl8hFl
	755f9jzNy1n0+08EBtoE+8/fOP1KYavaqw==
X-Google-Smtp-Source: 
 AA6agR5WntG9GIKzV8vGQnpq3b4VqCYY/qmyz51sSj5XcIr4+q3DqyoCPPJfghqQgJXledoNzpqEVA==
X-Received: by 2002:a05:600c:418a:b0:3a5:168e:a918 with SMTP id
 p10-20020a05600c418a00b003a5168ea918mr5537770wmh.31.1661352180683;
        Wed, 24 Aug 2022 07:43:00 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:4e4:9da0:6de0:5e33])
        by smtp.gmail.com with ESMTPSA id
 u11-20020a05600c19cb00b003a5c7a942edsm2200527wmq.28.2022.08.24.07.42.59
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 07:42:59 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] runqueue: Change pressure file warning to a note
Date: Wed, 24 Aug 2022 15:42:59 +0100
Message-Id: <20220824144259.3110779-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 24 Aug 2022 14:43:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13932

The user does need to be told about this but it isn't really a warning,
just something they may need to be aware of. Drop the level accordingly.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index d0ffe3932c..48e25401ba 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -180,7 +180,7 @@ class RunQueueScheduler(object):
                     self.prev_pressure_time = time.time()
                 self.check_pressure = True
             except:
-                bb.warn("The /proc/pressure files can't be read. Continuing build without monitoring pressure")
+                bb.note("The /proc/pressure files can't be read. Continuing build without monitoring pressure")
                 self.check_pressure = False
         else:
             self.check_pressure = False
-- 
2.34.1


