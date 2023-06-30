Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A978C001B0
	for <webhook@archiver.kernel.org>; Fri, 30 Jun 2023 16:58:49 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web11.19032.1688144321828355766
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 30 Jun 2023 09:58:42 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@linuxfoundation.org header.s=google header.b=dD2UUgau;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-3fbc0981743so19691615e9.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 30 Jun 2023 09:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1688144320; x=1690736320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=c4Syuyo9ayb1lgWEm+3p6idII6KJ12Uheuvo2uQu2wg=;
        b=dD2UUgau4+vp2bp5bGlmawF1+jqkCVXiee4LSQQC/U47NoHO4GqPIzuhi146UYT0HC
         7EQERMQZF8TQdabVvtSYb/uXiv1/ITaEAmsUSw9edSrzWkYTMlug3DdPetvxBG5B8U+m
         xxz25mH+yTbw4gzS9Y2luahHPCjrWIq68QlaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688144320; x=1690736320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c4Syuyo9ayb1lgWEm+3p6idII6KJ12Uheuvo2uQu2wg=;
        b=dItpMBQTLzc31nFT3OCPMiX6kaoEoYijo9cpD2GTh06c0N7J3un4aFkvxVq5GtmH7P
         W2I7eou6CilalYsIiKfvj3U5sZ+7vAX4Gvc25qMPHaUxmZ9DsR9JBbblC+xPpEmaH4/R
         8PG2V/ayJ25a5VU935NAAuU58ryl2V5aKKLzYCKxcoaCT5t90DtO3XfHVobc90Hdnjgd
         5MKnb76wIqxrJrLP/HunQJLxBMmXTOJhfdY17qZ9mApr05hx/IEm1b3KjGKuz6kOCHvS
         ruf94yAUB3y5Sq/irOfEZoDc7dwXL7MFM51mUN4B2tHx5sAQ9ZgNIYKWRtvM9VqVsJ6Q
         Nz1Q==
X-Gm-Message-State: AC+VfDyTwMIQ/t/wiZ3jcsmRyDvZj1UYN3r+zTK/HZMD/474LdgWmt4q
	19/8QT/8/2C/9v23x1lwl/2Fl5M+g3rLA8ffQa8=
X-Google-Smtp-Source: ACHHUZ5S3l0DhMaPsULuomgU4hC7YL9/g+Z4kdnT75QeMUMoadhlmHXtcKMe+QyUcLqHV8FbdP7NVA==
X-Received: by 2002:a05:600c:364f:b0:3f9:ba2:5d19 with SMTP id y15-20020a05600c364f00b003f90ba25d19mr2351120wmq.33.1688144319780;
        Fri, 30 Jun 2023 09:58:39 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:6269:f4b4:b452:51cc])
        by smtp.gmail.com with ESMTPSA id v2-20020a5d6102000000b003127a21e986sm18459211wrt.104.2023.06.30.09.58.39
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 09:58:39 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] server/process: Show command in timeout message
Date: Fri, 30 Jun 2023 17:58:38 +0100
Message-Id: <20230630165838.2764067-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 30 Jun 2023 16:58:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14870

To learn more about the server timeout issues, be clear in the error
message about which command is showing the timeout. It is currently
unclear if this is the original command or a ping to the server.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 7616ef53c8..4d4fa6d1be 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -502,7 +502,7 @@ class ServerCommunicator():
     def runCommand(self, command):
         self.connection.send(command)
         if not self.recv.poll(30):
-            logger.info("No reply from server in 30s")
+            logger.info("No reply from server in 30s (for command %s)" % command[0])
             if not self.recv.poll(30):
                 raise ProcessTimeout("Timeout while waiting for a reply from the bitbake server (60s)")
         ret, exc = self.recv.get()
-- 
2.39.2


