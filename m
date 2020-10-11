Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
 by mx.groups.io with SMTP id smtpd.web10.16906.1602420252782499526
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 11 Oct 2020 05:44:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=QDDe8SyK;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.66, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f66.google.com with SMTP id k18so14651963wmj.5
        for <bitbake-devel@lists.openembedded.org>; Sun, 11 Oct 2020 05:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=70qUqhfaSs3BrC6qFi3gV0O6BlOkrZRtw996bfnNIeY=;
        b=QDDe8SyKuE6XMsSj0+UL1kHuPBGnrhsI2xjAvdtY6N/6JHPM8FmL2slqB9VuLPtkOb
         4NOtHfauSZTqaXO04xxSX9yqUSSa7OZxMc6Mg2cilrrxmdsZGps65kafKSFw8SSYkiRg
         /KMNkQF9jKa7+yyvr0qafiuf0DC3LJUfd7krA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=70qUqhfaSs3BrC6qFi3gV0O6BlOkrZRtw996bfnNIeY=;
        b=h0ghyAeIElrs6+SKs37MJu7IljUdoxRH4rT2frFDBxOSclLVKiXXkx4C/XTgk8fEK6
         bZIGGKi48hf9sNc9OKauEj6YMFTEvP2MHp9RTn1M3i4aVD6+v/VujKHMQcW5Ob5z5l/x
         ERXaQ4phYO8dVAOo5uoWdHra8sSwUboo8MEldYt3g/YVafqKiPMB0VkSRY3xSqGZTnLW
         qcjbNbhtfzszufRBdLsZbRH4AfCQo0QYQ1YjX0Cq0HkO4eQAT5ZNfdHZj2BStj8e8kfk
         r32V4VbWVZbKSxdcuQaUvDT0jyIww52hVGwvw821WsOwrCdL2nir/CLzt7KURG2wdpX6
         a57Q==
X-Gm-Message-State: AOAM531nU9kf9OXMitd1GGUzKkId5bEnfup3yZAmzfUWsbR3i0N6mAqv
	udAuOrXxufS/eMmbo0pW2PF4R95uHdDKQg==
X-Google-Smtp-Source: ABdhPJwhQ4P0FC0EL3YCUTKnKWpUNqC4hsOdALwf3ysfckZxUMcamVM+5WDMIVhhuj6MaZ1U5A4YRw==
X-Received: by 2002:a1c:770e:: with SMTP id t14mr6625401wmi.34.1602420250810;
        Sun, 11 Oct 2020 05:44:10 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (0.6.6.4.7.a.b.4.4.1.e.0.e.3.c.2.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:2c3e:e14:4ba7:4660])
        by smtp.gmail.com with ESMTPSA id y5sm13165516wrw.52.2020.10.11.05.44.10
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2020 05:44:10 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] process: Show command exceptions in the server log as well
Date: Sun, 11 Oct 2020 13:44:09 +0100
Message-Id: <20201011124409.3347965-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are autobuilder logs where the server commands are failing
but we have no debug info in the server log. Improve this to try and
understand what is failing.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index c7cb34f0cc..b27b4aefe0 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -217,6 +217,7 @@ class ProcessServer():
                     self.command_channel_reply.send(self.cooker.command.runCommand(command))
                     serverlog("Command Completed")
                 except Exception as e:
+                   serverlog('Exception in server main event loop running command %s (%s)' % (command, str(e)))
                    logger.exception('Exception in server main event loop running command %s (%s)' % (command, str(e)))
 
             if self.xmlrpc in ready:
-- 
2.25.1

