Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B9BC3DA6E
	for <webhook@archiver.kernel.org>; Tue, 20 Dec 2022 15:16:14 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web10.52462.1671549368572209284
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Dec 2022 07:16:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=AJ9XqqzJ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id m14so12030556wrh.7
        for <bitbake-devel@lists.openembedded.org>; Tue, 20 Dec 2022 07:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LjHs9eTMVzPr08ed8b/HNdgt6n8GV7WJj79epKR6no8=;
        b=AJ9XqqzJsqrWRmuR8YAlBxanu6C3clRuZQ2GcCECZmi9NYg7JrKBAWrX8ak3DY0weD
         bo58L0u9rMV+FuSk8zBGfm/lgyhc0xm9KzIzpGW21BPHzXg7FoAvwXsRcrWQpGW2aZVD
         TVejJbquWGwKMQhmjUY+3dL8W1t4MFWl6bBw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LjHs9eTMVzPr08ed8b/HNdgt6n8GV7WJj79epKR6no8=;
        b=TWTp9b+LOcekI/BmZn/KPQf3corgu0FUw/TZ775nOaRQZR6kMbXD3SokhmhDVgUCoE
         Ne3sicrAWN6P59BwzAHdtHtLLUoFdIIY3L3zbEaAALnwPq9WDpbQG+FBgzuagCGQR7wp
         4Mow9rEqBHYIdBv9we61Z8l+TanH88bWvJUfcm0aH+QFgTzvueg6e93BFRasnqfTL3X6
         yNQtn+WK4/seg8TJ9c2ANILRqnJXRPnA/ncqmcCwpnv1/XEn5zB8wxUOU0LbxKoaYWgS
         zK81Vgyy1JkgNJJ3+JYOdo9yKAYoYV+iRuBK1qcEnS0sqJVsELbKtV8dTQmCLPNp1wTP
         FsyA==
X-Gm-Message-State: AFqh2kq0CE477X520WCGvb+I/JgRjT1T7KUVjvwgdEvOwroGyNqWkYar
	k5ABey4jBOAml+xM6pz3CF6a5QpKk5pK+Kec
X-Google-Smtp-Source: AMrXdXvUugRA1viWpjj7xTQYLhFLGGIxZ7c4Rfrd25nzoo+W+qgirAOBhNaFfarpUZuBjya5w0sVSw==
X-Received: by 2002:a5d:58f8:0:b0:241:ee8d:f818 with SMTP id f24-20020a5d58f8000000b00241ee8df818mr1927715wrd.46.1671549366867;
        Tue, 20 Dec 2022 07:16:06 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:1273:dbb7:632c:a9de])
        by smtp.gmail.com with ESMTPSA id k12-20020adff28c000000b0022e57e66824sm14896439wro.99.2022.12.20.07.16.06
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 07:16:06 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 4/6] event: builtins fix for 'd' deletion
Date: Tue, 20 Dec 2022 15:16:02 +0000
Message-Id: <20221220151604.415637-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221220151604.415637-1-richard.purdie@linuxfoundation.org>
References: <20221220151604.415637-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 20 Dec 2022 15:16:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14212

I've been seeing event handlers where 'd' seems to disappear half way through
event handler execution. This is problematic when multiple threads are active
since this code assumes single threading. Add in a recursive lock to avoid
d being deleted from a context it shouldn't be.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/event.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index 21e9a1b025..5df5b3a3ee 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -68,6 +68,7 @@ _catchall_handlers = {}
 _eventfilter = None
 _uiready = False
 _thread_lock = threading.Lock()
+_builtins_lock = threading.RLock()
 _thread_lock_enabled = False
 _heartbeat_enabled = False
 
@@ -93,6 +94,9 @@ def disable_heartbeat():
     _heartbeat_enabled = False
 
 def execute_handler(name, handler, event, d):
+    if _thread_lock_enabled:
+        _builtins_lock.acquire()
+
     event.data = d
     addedd = False
     if 'd' not in builtins:
@@ -115,6 +119,9 @@ def execute_handler(name, handler, event, d):
         del event.data
         if addedd:
             del builtins['d']
+        if _thread_lock_enabled:
+            _builtins_lock.release()
+
 
 def fire_class_handlers(event, d):
     if isinstance(event, logging.LogRecord):
-- 
2.37.2


