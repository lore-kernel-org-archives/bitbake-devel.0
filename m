Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
 by mx.groups.io with SMTP id smtpd.web11.3130.1595273351139674715
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 20 Jul 2020 12:29:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ZJXnY/TE;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.68, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f68.google.com with SMTP id c80so608546wme.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 20 Jul 2020 12:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mNWHWE9Tq+6kz29gWRTKKOYYWOHSPZCVexenWtHpmpY=;
        b=ZJXnY/TEPj9HYTOs853NKON33YAkRsWMMWgM31XsPRqev2Dx40zi/w0GIdtiiGsc7+
         pTKgu9tCMbft3toviVmGKCFTh5EmUb90FkX1I0nI1rjdia5x4rBxdye63ts9Y6GwfQVR
         a3EL+HozPgbeNzfQCDHgCfFdmVtKPanzuJGNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mNWHWE9Tq+6kz29gWRTKKOYYWOHSPZCVexenWtHpmpY=;
        b=efv6P0PzcEIsCNQn4EjMcT1Oj+JalHiQcX/kF48U+EsXz6Ydh+j21d2eoyDIQ4etRD
         mvrrv+qMLA8hdoGBir7E48rQbk4hQ9fh1A0WNhoXKriz1FA0EhG2ELXnf1TMZEcH8Li2
         sqzeV2XFOI6N7alxWbRiYSzFgzQ1AKLROPALLNUOhBGI9HXr7Vhsmm8iSNzlz8Hb9kCH
         L8Wgim3QgHu6ucpM3Cc9Nrbvn8jbi8eKdkCa9MJ9/ljARmqE40p2Fpn8ZhmUzpYk8KjZ
         t96duq9nDIb9rdYrT9rwODZFd7g2OwzmYYQ7ApOYZopb81LwJBBtJfSh0iAwdiuro+mA
         D4ng==
X-Gm-Message-State: AOAM532jbx4fnKaPfMD2z14eya1PxZAnMDXjj4YCquEFJ3osbZa/oXTc
	eP8PLCqMNuAvAJYu7Pz8YK0DnGYGo0WMjQ==
X-Google-Smtp-Source: ABdhPJw5M09+lKbt0HKdRdm/ypTDYWgu/TR+pwHE27Xp5RvuV1a3pP+ABUc8kIfEE/nxr/bysHq/5g==
X-Received: by 2002:a1c:1fc2:: with SMTP id f185mr756812wmf.0.1595273349059;
        Mon, 20 Jul 2020 12:29:09 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (5.f.a.a.6.6.c.6.8.7.0.3.0.b.c.1.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:1cb0:3078:6c66:aaf5])
        by smtp.gmail.com with ESMTPSA id l132sm695032wmf.6.2020.07.20.12.29.08
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 12:29:08 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] server/process: Fix note reference -> info
Date: Mon, 20 Jul 2020 20:29:07 +0100
Message-Id: <20200720192907.100482-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Its bb.note or logger.info, this avoids a backtrace.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index d4beac4379..9ec79f5b64 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -342,7 +342,7 @@ class ServerCommunicator():
     def runCommand(self, command):
         self.connection.send(command)
         if not self.recv.poll(30):
-            logger.note("No reply from server in 30s")
+            logger.info("No reply from server in 30s")
             if not self.recv.poll(30):
                 raise ProcessTimeout("Timeout while waiting for a reply from the bitbake server (60s)")
         return self.recv.get()
-- 
2.25.1

