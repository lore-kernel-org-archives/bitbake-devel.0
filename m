Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
 by mx.groups.io with SMTP id smtpd.web11.4236.1622066962226124047
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 26 May 2021 15:09:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=JXCzOyNg;
 spf=pass (domain: gmail.com, ip: 209.85.210.42, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f42.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so2514013otl.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 26 May 2021 15:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8IFgRQ1dBUauudluo/LxvF+atEluKKDyq7TUT5riDXo=;
        b=JXCzOyNgiElQefjrwt/57IW7g3A6sGgq92J4Z8CtipT/z4kdudsXR7XBs6HFCW8jn1
         wXR3pn0K/jTYfElMjFrMO+Bdagd3jSK7F719fMYWQmHMbe7DasXrGzFfJTirackIXoJy
         vLnH86lADFO4FC089mpgmAYIHrnak/Z8kNEgdnihJrum4IEovWMHx4fu0Wd+YcCi5Zxx
         iW7A7oTf6M0lHP1w5Wb0ajGeuDrEpEjJ4BaymJ9s8dfKhNpzYGHoI2ckd35sIkrn8ZE8
         oc1jpSV/5k9JsJ8NJae+CdczTE7XiU7otu2PAqdzUzMqMFEdrZVtt8Od2CJjlyZ8qIWR
         eSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8IFgRQ1dBUauudluo/LxvF+atEluKKDyq7TUT5riDXo=;
        b=d6Mb8RrmIdYiEaMOd7ENP11+ETQqDiD0PJRQmS6EIE3MC2l9OUFgx92/WUwJdIg+lP
         DhZXeJwlYn6xNC+AZtsk/jT5P+s+Bwr4xRCuaMSEikKI/JQk/Ioq2BiskGtfjTzuQ5Z6
         udBYvw3PrOUMop1uEDUfjclb5G+8t9W+cVjJ8iJnRLsNZqGAIXJBtw/TMjAUUrwum5aK
         rI2oSVcy9yyRV/qPKLmFUoWiupycbyJvjvqbPA9/WB+DWaG7RUMyciph0kbXaRbnojqo
         mn37RlZQiZEXlKX20En4ApJCu2zmBJCqe/0xmpfqhDcDMJZMI4pYcAa7rpg7mAL9rV6o
         l2Kw==
X-Gm-Message-State: AOAM533RZMPFVTonNIRIy8GSsPIKcoZqyMl9NwAU4BpqVsFTFsaJESwn
	HodkZSIwvd7R7l5BHMyJGNY5Sx+qsiY=
X-Google-Smtp-Source: ABdhPJzgkQDLSzNVHcDZUNX/OTixOov9qNhtgAjuS0kNBDAdwCIYsYWSJ6PAYcgRWr6LevxPcTMEHw==
X-Received: by 2002:a9d:600d:: with SMTP id h13mr352160otj.259.1622066961326;
        Wed, 26 May 2021 15:09:21 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:e3e8:d9:3a56:e27d])
        by smtp.gmail.com with ESMTPSA id r7sm65204oom.46.2021.05.26.15.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 15:09:20 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] server: Fix early parsing errors preventing zombie bitbake
Date: Wed, 26 May 2021 17:09:02 -0500
Message-Id: <20210526220902.35029-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the client process never sends cooker data, the server timeout will
be 0.0, not None. This will prevent the server from exiting, as it is
waiting for a new client. In particular, the client will disconnect with
a bad "INHERIT" line, such as:

    INHERIT += "this-class-does-not-exist"

Instead of checking explicitly for None, check for a false value, which
means either 0.0 or None.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/server/process.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/server/process.py b/bitbake/lib/bb/server/process.py
index 155e8d131f..a0955722e3 100644
--- a/bitbake/lib/bb/server/process.py
+++ b/bitbake/lib/bb/server/process.py
@@ -147,7 +147,7 @@ class ProcessServer():
                 conn = newconnections.pop(-1)
                 fds.append(conn)
                 self.controllersock = conn
-            elif self.timeout is None and not ready:
+            elif not self.timeout and not ready:
                 serverlog("No timeout, exiting.")
                 self.quit = True
 
-- 
2.31.1

