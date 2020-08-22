Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web11.155505.1598105822355311870
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 22 Aug 2020 07:17:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=YpTpIU+Y;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id 83so4346633wme.4
        for <bitbake-devel@lists.openembedded.org>; Sat, 22 Aug 2020 07:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A2atlJ4RtKnH0iNz8sGanHYgPEl5OQYnr4y5+q3Wczc=;
        b=YpTpIU+Ybst4gNiu6+1NpNSC75UkkI0W5Jp8XJRwZBJreAZdsI+p6itffS7uIf/TNA
         rm5nceQJu+ke2DEcKgynWOOPh6CZ3RW9fPiRMxwBgQtu/vYtiYWCJLdPfCWuT7AIFdvE
         6Iv0WVD7W1eRgIFdUVEbWJyNKF9BbuoaHjuno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A2atlJ4RtKnH0iNz8sGanHYgPEl5OQYnr4y5+q3Wczc=;
        b=QsWBea+3Hphm1JH+reB/DFW6hSQC8iENq3qYuspDapdsXnXL+1T+S2wSg+frQqS0r+
         ELro3xCVhfX4aripTfbMXR7YH+sjHgQr2BZKmkJDBZoZWKZGnoEYHPEYN4Z4VIi7AHpw
         tNDDF3ZGVCg34VLqnz4UtdaPpkRknRPFRFtb4b4tRxrTVwSZtzsXLsqdes32QnmZrnRN
         42naAvaYJKyNdxCgRji4K1vTBpYG33oYeB0/QscgGxK+dJGDQlHkM3APoJB584i4e1tx
         3aizswaqW7YolJyPt1pAe5bx15kjYvyjhguYpeYyX/zKrnYX4ZqY+0rX+dek7GZTlCBV
         l7Bw==
X-Gm-Message-State: AOAM533PxmpT2w2L6+BtNFIeY4JbQHnj7KYfA9g+3k2Rf2UvtnJIAdQJ
	fLzTO+xahTe/sp23p9NUfxQDC/Z7fpW/WY/I
X-Google-Smtp-Source: ABdhPJxSo7Lkuij7sPA/HHvBP88D6SZWFsUsTPL/m2uFk80aZfM/Zh0WS6cDEghXdiOfNAhH5GCO3g==
X-Received: by 2002:a1c:f70a:: with SMTP id v10mr7783468wmh.39.1598105820348;
        Sat, 22 Aug 2020 07:17:00 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (d.d.0.9.8.0.3.8.5.d.6.d.5.a.5.4.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:45a5:d6d5:8308:90dd])
        by smtp.gmail.com with ESMTPSA id l81sm12640281wmf.4.2020.08.22.07.16.59
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2020 07:16:59 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/3] server/process/daemonize: Use sys.exit(), not os._exit() for server
Date: Sat, 22 Aug 2020 15:16:56 +0100
Message-Id: <20200822141658.1312549-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By using os._exit() in the server, we confuse python programmers no end
since atexit calls, along with threading cleanup calls are skipped. We're
careful about the environment the server is created within so we should
be able to use sys.exit() here and have things behave as the python devs
intend.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/daemonize.py      | 4 +---
 lib/bb/server/process.py | 1 +
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/bb/daemonize.py b/lib/bb/daemonize.py
index f01e6ec7cc..0ec5ef3986 100644
--- a/lib/bb/daemonize.py
+++ b/lib/bb/daemonize.py
@@ -89,9 +89,7 @@ def createDaemon(function, logfile):
         traceback.print_exc()
     finally:
         bb.event.print_ui_queue()
-        # os._exit() doesn't flush open files like os.exit() does. Manually flush
-        # stdout and stderr so that any logging output will be seen, particularly
+        # Manually flush stdout and stderr so that any logging output will be seen, particularly
         # exception tracebacks.
         sys.stdout.flush()
         sys.stderr.flush()
-        os._exit(0)
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 65e1eab527..b03d64391b 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -492,6 +492,7 @@ class BitBakeServer(object):
             # Flush any ,essages/errors to the logfile before exit
             sys.stdout.flush()
             sys.stderr.flush()
+        sys.exit(0)
 
 def connectProcessServer(sockname, featureset):
     # Connect to socket
-- 
2.25.1

