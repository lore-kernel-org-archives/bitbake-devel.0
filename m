Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF24C83F2C
	for <webhook@archiver.kernel.org>; Tue,  5 Sep 2023 07:14:50 +0000 (UTC)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
 by mx.groups.io with SMTP id smtpd.web10.16044.1693898090110217968
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 Sep 2023 00:14:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=QWX9/Wkw;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.167.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5008faf4456so3367086e87.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 05 Sep 2023 00:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1693898088; x=1694502888; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qgY7dnjqnr+Cwhy/9xmSGfMqzEMqpoxDGCST2aPJcwg=;
        b=QWX9/WkwZg7OAlmhisqbW4UfpMoN8+5Zpe/JdhhiXlLHLv8D+yiTAKjWqRvyiKSnY0
         cfoJoi5U/9vHi7IZa1Fi06/JWb6nV4KnO2wWVvtTR6wgZIYvkTQwVQeJxlo93Ld1OICu
         YyES3/eHkjJfAoE6Rj7KxO6/RBJnchHrChbVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693898088; x=1694502888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qgY7dnjqnr+Cwhy/9xmSGfMqzEMqpoxDGCST2aPJcwg=;
        b=Q6GlFtZNfNbTWGBMl2qWbhbPwFmx4ntykFMOelmwLkFdtAJRnWZTL22tJtnvdlMz40
         qfJQugT0oYLJugyp7k/iPUbg56IDWly5dDHPSlKb7M+NLsWHiRfg3mcZAX/QZc96ODmE
         UEt+f7x4IiDeP09SzI3bp5nyrIG70W+0mRN3m3iZsl5Enqb1/u21R5+d2bgUkNwPuDR0
         fw/1mKj9Vj2S2CFtKhmRywkaaAp33HUrml3+SmlJ8Or36y/pj0WGUgrLRqg6Xpq1UL8E
         9ydHTBED3pniZRMOXWc5rrMpVsg8QpD0+xp76MPNmyVILPVhllPBY8KzoWlkUGKfGw2f
         AhEw==
X-Gm-Message-State: AOJu0Yy+h+fa6+IJwHLDnp4qyKKrIgRuGafYGyfHB+ayt+3EKfdMJ9K5
	BJVOYKgngMYaZjjoMbZY/+zaNXV0fm6UYlsu8oI=
X-Google-Smtp-Source: AGHT+IEaVBh0ApYymE1g3Renq7WvOBjZ+i/szFWF1x3Qy6FflWW4xxioaXwm5CwUxbdqAE9yCQGbDQ==
X-Received: by 2002:a05:6512:3083:b0:500:9524:f733 with SMTP id z3-20020a056512308300b005009524f733mr9568110lfd.20.1693898087620;
        Tue, 05 Sep 2023 00:14:47 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:9cbb:8ec6:1cb5:104e])
        by smtp.gmail.com with ESMTPSA id n23-20020a1c7217000000b003fee567235bsm19138161wmc.1.2023.09.05.00.14.47
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 00:14:47 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] server/process: Add more timing debug
Date: Tue,  5 Sep 2023 08:14:46 +0100
Message-Id: <20230905071446.2784798-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 05 Sep 2023 07:14:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15013

It is helpful to have timestamps on the ping failures so that they
can be matched against the bitbake logs. It is also useful to understand
how long the server takes for form a reply verses when it is sent.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index f62faed000..40cb99bc97 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -38,8 +38,11 @@ logger = logging.getLogger('BitBake')
 class ProcessTimeout(SystemExit):
     pass
 
+def currenttime():
+    return datetime.datetime.now().strftime('%H:%M:%S.%f')
+
 def serverlog(msg):
-    print(str(os.getpid()) + " " +  datetime.datetime.now().strftime('%H:%M:%S.%f') + " " + msg)
+    print(str(os.getpid()) + " " +  currenttime() + " " + msg)
     sys.stdout.flush()
 
 #
@@ -289,7 +292,9 @@ class ProcessServer():
                     continue
                 try:
                     serverlog("Running command %s" % command)
-                    self.command_channel_reply.send(self.cooker.command.runCommand(command, self))
+                    reply = self.cooker.command.runCommand(command, self)
+                    serverlog("Sending reply %s" % repr(reply))
+                    self.command_channel_reply.send(reply)
                     serverlog("Command Completed (socket: %s)" % os.path.exists(self.sockname))
                 except Exception as e:
                    stack = traceback.format_exc()
@@ -502,9 +507,9 @@ class ServerCommunicator():
     def runCommand(self, command):
         self.connection.send(command)
         if not self.recv.poll(30):
-            logger.info("No reply from server in 30s (for command %s)" % command[0])
+            logger.info("No reply from server in 30s (for command %s at %s)" % (command[0], currenttime()))
             if not self.recv.poll(30):
-                raise ProcessTimeout("Timeout while waiting for a reply from the bitbake server (60s)")
+                raise ProcessTimeout("Timeout while waiting for a reply from the bitbake server (60s at %s)" % currenttime())
         ret, exc = self.recv.get()
         # Should probably turn all exceptions in exc back into exceptions?
         # For now, at least handle BBHandledException
-- 
2.39.2


