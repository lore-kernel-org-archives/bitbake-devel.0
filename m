Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B340C433F5
	for <webhook@archiver.kernel.org>; Sat, 26 Mar 2022 20:35:07 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web11.7497.1648326905963267575
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 26 Mar 2022 13:35:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=UbDEmM6s;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id
 r204-20020a1c44d5000000b0038ccb70e239so1408904wma.3
        for <bitbake-devel@lists.openembedded.org>;
 Sat, 26 Mar 2022 13:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=sCJXQcib2xVfthx29oldgdvWkCp+F9uW4uWrO2ERy3o=;
        b=UbDEmM6sJnNpeu2w99e+8FWqBk9rjZ54m6ACgKwtp3dAxoZQxNpk2gmH1M6skoqKeN
         rbHfBMa6Nj+tJ7a2Mk3tAxWlHm8c6U9SJmYwH6nYBrufUBlfmNdQ45K+52lls1GDmmJy
         g1SBPvwroeFN6QQ7jMZYGRVLhZ2WDA0PLuuA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sCJXQcib2xVfthx29oldgdvWkCp+F9uW4uWrO2ERy3o=;
        b=uyO2DuclH/kQ8oKsc/RDF9t55pPjzWnwwpxXKoQTomu7BaDlMXKLMpkJD44vtr/CcQ
         fCMBYAloO5giWvJXTXpFvqvboBGe5Wp3pIyRrxhvX3MICpR61HSyjJ7SRYSAuc54yz/w
         RmP/Qm1PUlD0JtnG0GibQ930iB3kN37sBW+j+Q0b9tiJFcJ0OeJinrTOqKKLIazMEKDt
         OjE9QpOL9MWAfwZxMB8ab1+LOZJ9w7QNaFJ90BCz8Nbg/0bjgWbPDtS0CMG6FP1Vunbv
         qfc+BCsCklPXc0b0itx95GdMYzOAdI3hbBkodRBp/HpfQ70tUDNA2G1iH3nt9FnMkDOW
         Qoyw==
X-Gm-Message-State: AOAM533s/cHsgOHeuDUlT2EabrrP6sv+HOsF0Y6+lgC4F3lkC7PLVGfW
	9G+6xCGQ6b+spRTxxhGjyDZo95GOW9zjznl6
X-Google-Smtp-Source: 
 ABdhPJwvEt358Aw7ceWNIsaahtUIMGrRCkGqI97aWH8MwnKlXb9mI7eKQti444TtFEBwe7Y9kkSdjg==
X-Received: by 2002:a7b:cb4b:0:b0:38c:8aa7:3f8a with SMTP id
 v11-20020a7bcb4b000000b0038c8aa73f8amr16930209wmj.37.1648326904232;
        Sat, 26 Mar 2022 13:35:04 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:3949:59d4:6f55:52f])
        by smtp.gmail.com with ESMTPSA id
 a18-20020a05600c349200b0038ca453a887sm12242586wmq.19.2022.03.26.13.35.03
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 13:35:03 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 4/6] server/process: Avoid hanging if a parser process is
 terminated
Date: Sat, 26 Mar 2022 20:34:56 +0000
Message-Id: <20220326203458.1391301-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220326203458.1391301-1-richard.purdie@linuxfoundation.org>
References: <20220326203458.1391301-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 26 Mar 2022 20:35:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13516

If a parser process is terminated while holding a write lock, then it
will lead to a deadlock (see
https://docs.python.org/3/library/multiprocessing.html#multiprocessing.Process.terminate).

With SIGTERM, we don't want to terminate holding the lock. We also don't
want a SIGINT to cause a partial write to the event stream.

Use signal masks to avoid this.

Some ideas from Peter Kjellerstedt <peter.kjellerstedt@axis.com>

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index efc3f04b4c..dc331b3957 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -20,6 +20,7 @@ import os
 import sys
 import time
 import select
+import signal
 import socket
 import subprocess
 import errno
@@ -739,8 +740,12 @@ class ConnectionWriter(object):
 
     def send(self, obj):
         obj = multiprocessing.reduction.ForkingPickler.dumps(obj)
+        # We must not terminate holding this lock. For SIGTERM, raising afterwards avoids this.
+        # For SIGINT, we don't want to have written partial data to the pipe.
+        signal.pthread_sigmask(signal.SIG_BLOCK, (signal.SIGINT, signal.SIGTERM))
         with self.wlock:
             self.writer.send_bytes(obj)
+        signal.pthread_sigmask(signal.SIG_UNBLOCK, (signal.SIGINT, signal.SIGTERM))
 
     def fileno(self):
         return self.writer.fileno()
-- 
2.32.0


