Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CC8C3DA7B
	for <webhook@archiver.kernel.org>; Wed, 21 Dec 2022 14:15:54 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web10.19682.1671632149060965338
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 21 Dec 2022 06:15:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=gY5qrw4B;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id h16so15030739wrz.12
        for <bitbake-devel@lists.openembedded.org>; Wed, 21 Dec 2022 06:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=39OlN7u74S++Nw0/Z5+rVwMlQgmgdTPicMxTDzI/Y/g=;
        b=gY5qrw4B87phdwu/36Wtd3Mt7beBEMoGBYYziC0gIpgBWZrJ7UmrSXCNTOCBHu6lmD
         mAWS5of0o/M4A7s5tP2d3CypdfZiRfLp4TKBP1c0EUKS9BN2CODO2VmbOeUHzhMcRyCE
         KcS/LrJPQ6xibNGopwJgIybZJMMDvrguYiFP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=39OlN7u74S++Nw0/Z5+rVwMlQgmgdTPicMxTDzI/Y/g=;
        b=ZSXzDfJi9M/JAT+Sb5rrfDNJHIBEsLMcWIhyMuH4bcqTksXCtu3wGtobzjoMSbxeSq
         KUk4sRIqEBeQRnt8WgcaYTLJ9OXt3ob6ev0ZfLCIZsGHN6xsnuZD+jG3myPuwRhMmVhv
         8mA2+H1m96FO9cfx+jeOxUu87Miuolw2Nr2DL1/psxsr57mbR6u2Qbvggai2uRE5SKiZ
         kO8wPrHzx5mkrJA9lQgoZ1kj4Bbz7Fs4sKEhRqCAUcjTJu/mQF0bYn8vU8PAi/smkLnt
         /tOtw6cFIRPGk5mD/gzkSkmqMNQKP0fdETFry5u/40S2O7dqinISk1Z3HD823hB+5Aej
         mnVw==
X-Gm-Message-State: AFqh2kqkWuMvXlkUV3WjzVxbt+v7fG697i1PZ1xreeIG/pCG2mZj502W
	IwI9RtqATOpidNnWRV7Mck+2YNrWuY95cLYU
X-Google-Smtp-Source: AMrXdXv7dPTGE62McYLs8efN1K6IU+U0XOeFLqFfjkGeKk9uukgZGuO26TmIIwCHkO4Lhx0upGvL4A==
X-Received: by 2002:a5d:5d11:0:b0:26c:aa9d:93f1 with SMTP id ch17-20020a5d5d11000000b0026caa9d93f1mr1123852wrb.25.1671632147419;
        Wed, 21 Dec 2022 06:15:47 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:e749:b020:2cdb:af31])
        by smtp.gmail.com with ESMTPSA id k12-20020adff28c000000b0022e57e66824sm17839412wro.99.2022.12.21.06.15.46
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 06:15:47 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 6/7] process: Improve client disconnect/idle sync
Date: Wed, 21 Dec 2022 14:15:42 +0000
Message-Id: <20221221141543.497904-6-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221221141543.497904-1-richard.purdie@linuxfoundation.org>
References: <20221221141543.497904-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 21 Dec 2022 14:15:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14223

When clients are disconnecting, we need to ensure things are in sync with
the idle thread. This patch is probably a little paranoid but it doesn't
really hurt to ensure things are properly in sync and nothing unexpected
will execute. A simple counter to show activity seems to easiest way to
synchronise.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index c9984539e8..12dfb6ea19 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -88,6 +88,7 @@ class ProcessServer():
         self.maxuiwait = 30
         self.xmlrpc = False
 
+        self.idle_count = 1
         self.idle = None
         self._idlefuns = {}
 
@@ -178,6 +179,13 @@ class ProcessServer():
                 del self.event_writer
                 self.lastui = time.time()
                 self.cooker.command.finishAsyncDisconnect()
+
+                # Wait for the idle loop to have executed (5s max)
+                count = self.idle_count
+                start = time.time()
+                while count == self.idle_count and time.time() < (start + 5):
+                    continue
+
                 self.cooker.clientComplete()
                 self.haveui = False
             ready = select.select(fds,[],[],0)[0]
@@ -360,6 +368,11 @@ class ProcessServer():
 
     def idle_thread(self):
         while not self.quit:
+            # Show activity
+            if self.idle_count > 100000000:
+                self.idle_count = 1
+            self.idle_count = self.idle_count + 1
+
             nextsleep = 0.1
             fds = []
             for function, data in list(self._idlefuns.items()):
-- 
2.37.2


