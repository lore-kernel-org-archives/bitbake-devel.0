Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9254DD31769
	for <webhook@archiver.kernel.org>; Tue,  5 Nov 2024 16:52:43 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web11.24912.1730825556376208682
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 Nov 2024 08:52:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=g+zMxxfE;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43152b79d25so48929515e9.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 05 Nov 2024 08:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730825554; x=1731430354; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=T2vuHOuyDk42vyVKAa5VyPXFWQWm8O3xA+2djCQCRSM=;
        b=g+zMxxfEFFjEKsgHfwapzwUAr4nNI3ng/DpgbVfS6e5eSK7XmQgPRjlELCDrArmCot
         cBDu1wMz270b3nVZmA4R9zh7bVsgrWHI6vEJnDsuTctJ8M82EKceIUSAGpZJv8SI6Jan
         ueom1TCaoI6AnGiizq8HtFVN0AVou+jcPizQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730825554; x=1731430354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T2vuHOuyDk42vyVKAa5VyPXFWQWm8O3xA+2djCQCRSM=;
        b=P0dcQ2Zy9MMVZ9AEtjy/HeE1+oqzk5DvU5GfSzCFut/cGxIsTO2Dm0Ohpk2Oj1w7lj
         tl/cC4/lAkuIpkrNMRV+DZd31b/YO0q5b5jWW+zk3nNmVuOHrMTNVpCxcTtAJlggTIa3
         zur9hnU3vXpMLW3O/83ToBXmnhrSAiQZizoIbp070SYTHUfLqXegqpfkSBe/oGf0WYhz
         JZoRA3JwGd4wvPW50Z+2ed2yJigKg06RQmRWKpI77l9eW88hndrHV0SiWXmOLuiWbphy
         Oeh7zI6J8ljB9IMajoKrpuDQ2cU9t9Cc6qQIga4wlTQHWxzLrpOo93XG137QvGka7PdP
         9Pug==
X-Gm-Message-State: AOJu0Yyv/0Ve38lmGBo5TG2Tzx+wAXFZgv0lO/K/0zH6eHLWJHfDMGKZ
	/2V+0mM/LZU9w86OtQlPY6yHHEsIyiNgmpxezxywRpBYLMI6HziMb5YfvHVLeMxsKnSGkrzoZaw
	XrjU=
X-Google-Smtp-Source: AGHT+IFBQpIAzNgFTHYb1xXpRxm0/c9s33SaaoSM2j2odOX6Wh7fIl/2xXnNXgGTMxZHYK/Z/DrHDQ==
X-Received: by 2002:a05:600c:4688:b0:431:5957:27e8 with SMTP id 5b1f17b1804b1-4327b7ea52dmr160026785e9.28.1730825554327;
        Tue, 05 Nov 2024 08:52:34 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:7614:7622:3cf4:a240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d685308sm191738305e9.33.2024.11.05.08.52.33
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 08:52:33 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] server/process: Merge a function to simplfy code
Date: Tue,  5 Nov 2024 16:52:33 +0000
Message-ID: <20241105165233.2842065-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 05 Nov 2024 16:52:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16780

Keeping this code separate just makes the code harder to understand,
merge them.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 42 +++++++++++++++-------------------------
 1 file changed, 16 insertions(+), 26 deletions(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 76b189291d..ad4035a738 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -321,7 +321,22 @@ class ProcessServer():
                     bb.warn('Ignoring invalid BB_SERVER_TIMEOUT=%s, must be a float specifying seconds.' % self.timeout)
                 seendata = True
 
-            ready = self.idle_commands(.1, fds)
+            if not self.idle:
+                self.idle = threading.Thread(target=self.idle_thread)
+                self.idle.start()
+            elif self.idle and not self.idle.is_alive():
+                serverlog("Idle thread terminated, main thread exiting too")
+                bb.error("Idle thread terminated, main thread exiting too")
+                self.quit = True
+
+            nextsleep = 0.1
+            if self.xmlrpc:
+                nextsleep = self.xmlrpc.get_timeout(nextsleep)
+            try:
+                ready = select.select(fds,[],[],nextsleep)[0]
+            except InterruptedError:
+                # Ignore EINTR
+                ready = []
 
         if self.idle:
             self.idle.join()
@@ -485,31 +500,6 @@ class ProcessServer():
             if nextsleep is not None:
                 select.select(fds,[],[],nextsleep)[0]
 
-    def idle_commands(self, delay, fds=None):
-        nextsleep = delay
-        if not fds:
-            fds = []
-
-        if not self.idle:
-            self.idle = threading.Thread(target=self.idle_thread)
-            self.idle.start()
-        elif self.idle and not self.idle.is_alive():
-            serverlog("Idle thread terminated, main thread exiting too")
-            bb.error("Idle thread terminated, main thread exiting too")
-            self.quit = True
-
-        if nextsleep is not None:
-            if self.xmlrpc:
-                nextsleep = self.xmlrpc.get_timeout(nextsleep)
-            try:
-                return select.select(fds,[],[],nextsleep)[0]
-            except InterruptedError:
-                # Ignore EINTR
-                return []
-        else:
-            return select.select(fds,[],[],0)[0]
-
-
 class ServerCommunicator():
     def __init__(self, connection, recv):
         self.connection = connection

