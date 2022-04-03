Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4F8C38161
	for <webhook@archiver.kernel.org>; Mon,  4 Apr 2022 18:46:41 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web12.21494.1648981310211985793
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 03 Apr 2022 03:21:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=d9X8sg+y;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id
 c190-20020a1c35c7000000b0038e37907b5bso6029525wma.0
        for <bitbake-devel@lists.openembedded.org>;
 Sun, 03 Apr 2022 03:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1LdTSFwbDv/1zD8thlAkrEczrnjyegh5tLs5/tTtVvU=;
        b=d9X8sg+yZpaTfiERxzeVeCGZoqRmG0weJpuwzuS2y7VwDkN7unkbB7sgl+KYRqLxSZ
         l79UU3GIcoNAfCFP6GRHocNdQTN005bcRX5tKHv+TIM9kpMPoAYkSJf0qY51QjQ72que
         aS+BYL7fXteqcY4gxHyP/QCnB9+PLqkvTAnCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1LdTSFwbDv/1zD8thlAkrEczrnjyegh5tLs5/tTtVvU=;
        b=6IpN/YwwRieCiouQj9Uq4Q6ZMYafvXb+q1YNAW1B7/HwrhoAVZYKyUTVd394RDQQmk
         GYby4pyRXgaEz5aK5agRM379ewnZvdfBkdxhPQ1qqFXid2uUPYrydMzbItegBKVD7rXZ
         +sGx+WibsEdP3DN4VSFTKSemSkFHAt1pLmHYRM5rp5FAVTIZ6kda7MqC0XjrkCt2VYSS
         lZIAL4KA5g+/3aQHhpuYntnMcNr9McxkHoHutmWbqtnbxwwebljdVsrZqZpXvxzx5o31
         6aEookLSP6i24eIeK4h7fU8k09VyP4pf0u1GSOUma6tPc+tlCHNrt+oUNCkfI3mDqM4I
         xQkQ==
X-Gm-Message-State: AOAM531iOy5EWK/shqTKnlNOpB/kdsOxUaqJMB5R2x2jY10Fdp5veyD2
	wk6dtE4cVh9AtZwCpm3i9miSbqtiAiyQ/YX4
X-Google-Smtp-Source: 
 ABdhPJxc9NwC+97bob7vAB9uzOfu+uXtBuspQqSnAMbAMLyGuP0jTnx0s4OOShVtqYBCjNYWDv77zA==
X-Received: by 2002:a05:600c:3016:b0:38c:8786:d3b6 with SMTP id
 j22-20020a05600c301600b0038c8786d3b6mr15276043wmh.135.1648981308561;
        Sun, 03 Apr 2022 03:21:48 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:819:f853:3436:28c4])
        by smtp.gmail.com with ESMTPSA id
 z3-20020a1cf403000000b0037d1f4a2201sm6327981wma.21.2022.04.03.03.21.47
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 03:21:48 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/5] server/process: Disable gc around critical section
Date: Sun,  3 Apr 2022 11:21:42 +0100
Message-Id: <20220403102144.1679700-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220403102144.1679700-1-richard.purdie@linuxfoundation.org>
References: <20220403102144.1679700-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 04 Apr 2022 18:46:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13573

The python gc can trigger whilst we're holding the event stream lock
and when cleaning up objects, they can trigger warnings. This translates
into a new event which would then need the lock and we can deadlock.

Disable gc whilst we hold that lock to avoid this unfortunate and
problematic situation.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index ce53fdc678..19ef83980f 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -28,6 +28,7 @@ import re
 import datetime
 import pickle
 import traceback
+import gc
 import bb.server.xmlrpcserver
 from bb import daemonize
 from multiprocessing import queues
@@ -739,8 +740,10 @@ class ConnectionWriter(object):
         self.event = self
 
     def _send(self, obj):
+        gc.disable()
         with self.wlock:
             self.writer.send_bytes(obj)
+        gc.enable()
 
     def send(self, obj):
         obj = multiprocessing.reduction.ForkingPickler.dumps(obj)
-- 
2.32.0


