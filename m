Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A73C4829C
	for <webhook@archiver.kernel.org>; Sat, 10 Feb 2024 23:04:54 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web10.26809.1707606286314131364
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 10 Feb 2024 15:04:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=b1whuSUS;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-410ad88f70dso2270625e9.2
        for <bitbake-devel@lists.openembedded.org>; Sat, 10 Feb 2024 15:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1707606284; x=1708211084; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HCb61MBqDhSCNaMbcc3iLJzLzdtRAHA1oR3P+oojRG8=;
        b=b1whuSUSLs3UZsOycSbEgt7RJ/shb1vY0KWs04gBn9hN+QZHnEsSWIbCXDvVbVWikd
         jQPeoEEAJ618EUydt0ewl5CleQ3Cha607EdQFladzpWGKo1h5sDgIi1MGkKXBULCMeYq
         VRa5C33T4kjV3TNgn8jKtRFAUK37zTXMgUhvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707606284; x=1708211084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HCb61MBqDhSCNaMbcc3iLJzLzdtRAHA1oR3P+oojRG8=;
        b=jTN6auP0bfqbkeYFtnRY0bC76LaQLHUvIxUPrq0a4uprCgsfRJ3ibw5aSFy4hFsvAp
         tUZ4Tpl8mnhHV3TW+zTI4xCYcpMi/7EgVhk0f/PA6hIjREqNmgoFJk1QL62DmX29muSc
         4skqN7lcRyAS0nMA83WZoZHx2EYwqH4ooIG0tnTdaJ6QikPunmjB1XK+p0bOD1PzL4qz
         m8k6weTUB2nHSJvm1K/xPGj9HKLfvpl8s6SQsHHTxQVxhx8rywRAhFveO7fF1WbYpCfA
         Ow/Zc15iqAXgSr+sOIeT/SkAiWiqjfDBP8bVlYKgOkhArL6JzcVmVF5m7UUh89CafXWu
         6Bdw==
X-Gm-Message-State: AOJu0YwFQ92Fnf+4yoDzWSfZYDn2lqbrDlRr0eZhALgO9MyiZxvyi/X0
	NVRE4ZGYCUAZOn/sRCej7JzMWkx701MdOqfoP91MqDdjCs2JjDzPDcrTKKnlwFavQK6GwYFFxe5
	u
X-Google-Smtp-Source: AGHT+IEnwspF4CZ1kVnuZk1m5xPdkeE4zfBKfOBaLLK9WSTlVZrAFd8ODGon2N2fhoQ6G9HVm/xdqA==
X-Received: by 2002:a05:600c:3ac7:b0:410:88d2:c7a with SMTP id d7-20020a05600c3ac700b0041088d20c7amr2279713wms.7.1707606284029;
        Sat, 10 Feb 2024 15:04:44 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:c350:b3c8:3bca:cef1])
        by smtp.gmail.com with ESMTPSA id n11-20020a05600c3b8b00b004105017f83fsm4486793wms.31.2024.02.10.15.04.43
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 15:04:43 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] runqueue: Optimise taskname lookups in next_buildable_task
Date: Sat, 10 Feb 2024 23:04:41 +0000
Message-Id: <20240210230442.3633663-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 10 Feb 2024 23:04:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15876

A quick profile of bitbake world showed 147 million calls to taskname_from_tid().
The next_buildable_task function is performance senstive so move the call
inside the if block to reduce the number of calls and speed the code up.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index c8392346a8..95cab5132f 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -270,11 +270,11 @@ class RunQueueScheduler(object):
         best = None
         bestprio = None
         for tid in buildable:
-            taskname = taskname_from_tid(tid)
-            if taskname in skip_buildable and skip_buildable[taskname] >= int(self.skip_maxthread[taskname]):
-                continue
             prio = self.rev_prio_map[tid]
             if bestprio is None or bestprio > prio:
+                taskname = taskname_from_tid(tid)
+                if taskname in skip_buildable and skip_buildable[taskname] >= int(self.skip_maxthread[taskname]):
+                    continue
                 stamp = self.stamps[tid]
                 if stamp in self.rq.build_stamps.values():
                     continue
-- 
2.40.1


