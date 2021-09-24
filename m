Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web08.9013.1632493338322853957
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Sep 2021 07:22:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=Y6J0JQUR;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.45, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f45.google.com with SMTP id lb1-20020a17090b4a4100b001993f863df2so7644394pjb.5
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 Sep 2021 07:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9rQxxxonuPr5xPd3FwPZN/cl34ULkBk8AueO3/DQtfQ=;
        b=Y6J0JQURw8vq9wfl/zga+J7TGGrz8Qi1PGYWesdolHVa3OgKwuPbqZAnwnw0u0vvsx
         wlCLsKPhgwcxNzTRcM9WBBhkoDhg8mqX+w8pgX+ZdzTvVIgdyQ1K9RBHIuZETyGTTYa3
         o+LT26npGhJZG96XBGPb9TUibBT3x5f9Xku5Uu5d2P8QseJmX8ECXCdCieDiUc5qJRgO
         sf5Dc8D8w77xEDfFKze9lKhpBKOToz0UGnI8BCUGz0oEkaE6B7klbrOf7qLsUFhWs+TF
         JSdto+yKeS/i6aIsj1uVnoXGFLwm8JED+UiaP+6BPZf8SGBECaYAQ8EIFt+Ve/lwpTzQ
         eGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9rQxxxonuPr5xPd3FwPZN/cl34ULkBk8AueO3/DQtfQ=;
        b=EhQampaFsgvZASgH7zjtFmpveuDOZDNeDeHonOO/d7w3Oo1scq57UcTGjTuUJxQJIX
         SVTsiMC2fnQlMvtgvGxClWFyrRq99CJA/XHr4cPBv5OX97Wl7JGMqBrqawnLpxyQi9sW
         F7ETeOP5j9/X0tvjN5nktneyhe3qfWiUIV/30BztDXiX6xSqLSLN4LgrFiP1QVpD1sBs
         tQDwtfph1tW/mr8Fbu22VIoCTfgfZmerbPQD/1qwhDG2K2ZkFv7tkFUMXiU+t03ytvr2
         rqTCQyKxzCWmCPNubhsXaS6tTKIjww42Xkl1tl/8zEppeAt/24BaLSDY4/+u6AVQl11n
         xtYA==
X-Gm-Message-State: AOAM532204hWBiM8Im1O1If2Vic9S6SpEWwltPsrcJ8MYuHC2SaGS+X8
	B1UaX0Jtxbg0CsX89bWTb8wfEt8TmYMsmADxQGg=
X-Google-Smtp-Source: ABdhPJw3luJlHIRWXq11S8V/izQP+Dns/tjILtYEah7jkoLkRtSOQXDPduSUkNccLt8dMjjYO0Mwog==
X-Received: by 2002:a17:90a:d516:: with SMTP id t22mr2566346pju.208.1632493337224;
        Fri, 24 Sep 2021 07:22:17 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from localhost.localdomain (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id j20sm9907347pgb.2.2021.09.24.07.22.16
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 07:22:16 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 01/14] server: Fix early parsing errors preventing zombie bitbake
Date: Fri, 24 Sep 2021 04:20:54 -1000
Message-Id: <a48dbb3fc88ad2f54f0e69f21429fcc4f90a5a6d.1632493110.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1632493110.git.steve@sakoman.com>
References: <cover.1632493110.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Watt <JPEWhacker@gmail.com>

If the client process never sends cooker data, the server timeout will
be 0.0, not None. This will prevent the server from exiting, as it is
waiting for a new client. In particular, the client will disconnect with
a bad "INHERIT" line, such as:

    INHERIT += "this-class-does-not-exist"

Instead of checking explicitly for None, check for a false value, which
means either 0.0 or None.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 13e2855bff6a6ead6dbd33c5be4b988aafcd4afa)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/server/process.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index b66fbe0a..45f2e863 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -152,7 +152,8 @@ class ProcessServer(multiprocessing.Process):
                 conn = newconnections.pop(-1)
                 fds.append(conn)
                 self.controllersock = conn
-            elif self.timeout is None and not ready:
+
+            elif not self.timeout and not ready:
                 print("No timeout, exiting.")
                 self.quit = True
 
-- 
2.25.1

