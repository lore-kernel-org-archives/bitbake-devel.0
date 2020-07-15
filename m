Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
 by mx.groups.io with SMTP id smtpd.web11.7951.1594823251587081631
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Jul 2020 07:27:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=1aFxSq0G;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.196, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f196.google.com with SMTP id t6so2462654plo.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 15 Jul 2020 07:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=Z77m0hqTox0PhcIieMk5foJ9q9OMUtM6dtWod+UravA=;
        b=1aFxSq0GmM8UtaBkAvdcBLuQYiblPG1Mu6RBwgYEm/ZjMnVzSKT6gZRyxGH0iKl0y0
         GLtNnMF29ImlcmhkaBWZRKSG4k2vml3G1g1iIGx9D16YlHlUphRerOJX2Fvv2x5FXblN
         y5njBLL7fjF/lYkU21Q0prSojvKuEjfMKWxyaoZYEeUeL0GFUotflLgMVuwiyQw/ZbD3
         +WibEhPNWOE0jiz9ZGbtbxOE/r14v4LFCujeWziAYPEm2yPEKIGfVDBAVqQF+BYGLAnb
         u6+PhsabEKdAzyATv+U7+8CJ7Z2+PsTQRaZG6FVHTcu1hS5slbCANEA4QXalYqZCCyT/
         +J+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=Z77m0hqTox0PhcIieMk5foJ9q9OMUtM6dtWod+UravA=;
        b=sH9qqMo6nAvlgi7T3TOoS+WKz/dqQl0dtdcRvOVobGylRmjb9cw3gaWiDIFLDgcac/
         W1/tlQncW9oWzdypa/tx04oY5H6dI7EMx4dwZoHEf7Q06l8JX1rG6cUkA7d3T6eXV1tG
         JB0MaEINS+olk+moKyogWJDezNuBx8Jf2Bcrmcc+kEn8Bq3PskQOLMO5mx46msFZ4Hqg
         t0o9XrAjgQP79B/E5JFXpP2+H22c+/Jvb+Sxuyftx9soLmyXgXD3YCgjaf40LkqVXqqk
         Q+W7OyKFaN+HdhkVetd9cnW1J7pDST63Ce7m0LnCDn8Bqqe/o4BE0tmLrxw9TtShnaoD
         KlOg==
X-Gm-Message-State: AOAM531lISoLloBNk59SRpMWecsgTiwHiT9Hg5IAdtFeIYgIAoQpxYkp
	oT/+rd4JoudP+m4xmihF/lXB8pYMugQh6w==
X-Google-Smtp-Source: ABdhPJwEqL9uZCs5uuA8unHITagfY625Pnmvih8mcxxp/ZIdqJQq9hBLoKu9i98w0QjouQJwAYB3wQ==
X-Received: by 2002:a17:90a:ca86:: with SMTP id y6mr10602501pjt.40.1594823250747;
        Wed, 15 Jul 2020 07:27:30 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from octo.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id i125sm2423915pgd.21.2020.07.15.07.27.29
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 07:27:30 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 4/8] server/process: Increase timeout for commands
Date: Wed, 15 Jul 2020 04:26:46 -1000
Message-Id: <344d3006a243f5f7d8f551556bab721b2ac0a2aa.1594822992.git.steve@sakoman.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1594822992.git.steve@sakoman.com>
References: <cover.1594822992.git.steve@sakoman.com>

From: Richard Purdie <richard.purdie@linuxfoundation.org>

We're running into this timeout on loaded autobuilders in situations
where things should otherwise succeed. Log a note in these
cases and continue to try for longer.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit e567743e70f426786ae54dcb5ab550748d9266e4)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/server/process.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 69aae626..83385baf 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -331,7 +331,9 @@ class ServerCommunicator():
     def runCommand(self, command):
         self.connection.send(command)
         if not self.recv.poll(30):
-            raise ProcessTimeout("Timeout while waiting for a reply from the bitbake server")
+            logger.note("No reply from server in 30s")
+            if not self.recv.poll(30):
+                raise ProcessTimeout("Timeout while waiting for a reply from the bitbake server (60s)")
         return self.recv.get()
 
     def updateFeatureSet(self, featureset):
-- 
2.17.1

