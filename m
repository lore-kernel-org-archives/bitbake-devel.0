Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web10.8873.1632493362549192908
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Sep 2021 07:22:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=ddNUoOfJ;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.47, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f47.google.com with SMTP id gj8-20020a17090b108800b0019e8deab37bso1282648pjb.5
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 Sep 2021 07:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=DS/jxayXAMVaUpPtkZrKl5+fgmtFJaKPxVg67xYFzro=;
        b=ddNUoOfJZZTZMhnwqjuVJVO6zO7fIjSmhGfOsJvekAA1hhUvBVrLuu7jyuUQW7WMJ3
         m6uSeb7uI54dhNkF25MCSN4MvzcTJoGAuR6S9wpcZCNtBI0sw4p+3A2f2XntC1N8Pihd
         4Jvx57zr4sqSs84x8g8UHUMexd2MEU+pbZbl+4XK/yHQcczCANvTefgvXuzy7qVAA0Pv
         sy9Loxk9O+FIVZ2YXpcVpRytacGlZteA0UWaujhou4S2uMNMAKNVbHTyiR3FKgKYJzsk
         7gNvfH5MsJwxkKuXTPQKne3UHhrVGsBkBpQVNisomj8E2fIAHAbyJC0XR6YNuzEjrj6z
         r6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DS/jxayXAMVaUpPtkZrKl5+fgmtFJaKPxVg67xYFzro=;
        b=B6/+0tTF8jF5pb4K/si2OAY711xJGK502yEQXnD4m7y2hP1hlsnpInzJ3rQrEwK+vD
         sthds0r4QBFKk4TBbgGtQbprszHNrTPEvyaiM94ezjOToLhBdYYDJG9xYltqc61qQC2i
         Wc+6PdcciTC6h7Q8y/4QM9RcbI1N6deUblEU2Si6x/7+z+o1Zq7ah01m692fF9WqVDom
         WmyqqOiVGimezePs4eHIbLeitEeCteISgi/NM/Rbvqu9mQVEjBm8YC7PPuyT5fKdAmHc
         J2qMexwGKeoJ3+ktXcro135bPvMJEcE4oQeWCX94nffK2uZxJ6JKoT3TYMLu/mJmVu/4
         6IlQ==
X-Gm-Message-State: AOAM533pCFvAhKHOVpdv4JwqFR9IySci0UQJNb1ntms4jCluSmgowKqm
	7htEp4qt+zGKzybfzU1PaKoius/iUxN9g/YAqfI=
X-Google-Smtp-Source: ABdhPJxHyPNhPG5MjucbkaBb2DqE3kgx7bH8iwFcZfQl4YpjgbqLDzw189BjtXg4NgNcU2Ew4dFvJg==
X-Received: by 2002:a17:90b:1e47:: with SMTP id pi7mr2535506pjb.135.1632493361623;
        Fri, 24 Sep 2021 07:22:41 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from localhost.localdomain (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id j20sm9907347pgb.2.2021.09.24.07.22.40
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 07:22:41 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 13/14] bitbake-worker: Improve error handling
Date: Fri, 24 Sep 2021 04:21:06 -1000
Message-Id: <406f4f3c6124a15cb2679c80e4eb2d6a881148f3.1632493110.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1632493110.git.steve@sakoman.com>
References: <cover.1632493110.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Purdie <richard.purdie@linuxfoundation.org>

If bitbake-worker fails, return an error code showing that. Also
make the thread cleanup code explict in a finally clause as it would
otherwise hang.

[YOCTO #14393]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 7e0af70fb53fb13f824ca954b8cc1dffee730233)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 bin/bitbake-worker | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 97cc0fd6..9ef0d5a6 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -505,9 +505,11 @@ except BaseException as e:
         import traceback
         sys.stderr.write(traceback.format_exc())
         sys.stderr.write(str(e))
+finally:
+    worker_thread_exit = True
+    worker_thread.join()
 
-worker_thread_exit = True
-worker_thread.join()
-
-workerlog_write("exitting")
+workerlog_write("exiting")
+if not normalexit:
+    sys.exit(1)
 sys.exit(0)
-- 
2.25.1

