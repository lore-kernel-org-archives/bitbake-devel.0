Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
 by mx.groups.io with SMTP id smtpd.web11.1296.1595977161796570652
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 28 Jul 2020 15:59:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=zID9Kvdo;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.194, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f194.google.com with SMTP id d188so5822944pfd.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 28 Jul 2020 15:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=ogwhWyoAJWjXEsEpV9Zkjr5vBo0u+qJthXVpB4JyWJ0=;
        b=zID9KvdoybWHjIjuVUmZGpXR7ubd1wylHH4HYAWDn03JAEyeddJsWVAnkXJJ/R57CB
         uUWVinqp32WFANGAzHIzqd9uK3qna5ixeM6UyDCZ793Xve9eksy+7Mcs+jmyC9fdYVaG
         dzwB5QY5aRa+qlAGjTCIoHbMmiEUm67pebr3epeXQVih9JxNXcZqi7sUV8yP5vHgAKR7
         mglUwBCtewveRyN1qYPcc9hKX/kJb/JW5T7R23xS5S8iNuim/QuAysdgWqt0GCbgEfV3
         nfgtJOyguN3eJuWO+P6D5K2mk7keGzmTg7d510uIQXsP0Pa/tL7BXfr7T0t95HV/nqOX
         n3rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=ogwhWyoAJWjXEsEpV9Zkjr5vBo0u+qJthXVpB4JyWJ0=;
        b=XhlpURYWnoE+hIoX3je43bxDPnVFHuVglzLWjsmmXx50ELTZEhYRG8N59hf7C+bkqe
         l06YHNgFTXan2U0Wf3En41/I5OomnY84pinN9ReIjpUK543RzUk+GnGhrVjNwaWopYAe
         OFYeSMhLXhyGFbmr1v5EPDbzlXFLMQgUfUq+0Eqz/1N4O1mYKU+MWPNKanhJddzee12k
         /43PU0mf+Mr6F0LGPClS//C1vD1MEnBET1/XB3rCTY7r1y0WkFO/hGR3Xww8erQzI6Bj
         NBitdSPIeJ+pZ2rZfmjXO7A64njjINgQ1go6Z4IJUK6BryVBJX+WeWT59wBSrJzWDHvx
         B5fw==
X-Gm-Message-State: AOAM531xqtzUVkXQLAV1nweXLTzoKZOwKqGiLBVvBFvgDYg366XtX/cF
	fs1OqFjHzIXr+uUpzKvMG2uZ/2TY5fg=
X-Google-Smtp-Source: ABdhPJxgFyUKUw5HlkbYRCXnzKIlVmcXX1A4XSrWZKYdqxx1B+AsnDLQdeFGXnQd8iVedXaIlh4ugw==
X-Received: by 2002:a65:6089:: with SMTP id t9mr26983411pgu.236.1595977160957;
        Tue, 28 Jul 2020 15:59:20 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from octo.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id p11sm157658pjb.3.2020.07.28.15.59.19
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 15:59:20 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 2/2] server/process: Account for xmlrpc connections
Date: Tue, 28 Jul 2020 12:58:57 -1000
Message-Id: <f2b23d64f582adbc3417bd325b477a38152d1897.1595977046.git.steve@sakoman.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1595977046.git.steve@sakoman.com>
References: <cover.1595977046.git.steve@sakoman.com>

From: Richard Purdie <richard.purdie@linuxfoundation.org>

UI control can happen via the xmlrpc connection. Account for this when timing
out UI connections. This was causing issues for toaster on systems where it
couldn't parse the metadata within the timeout.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit fa85a8263971c25e67fa3b421c686a90e46acd87)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/server/process.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 5a87f082..b66fbe0a 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -202,7 +202,7 @@ class ProcessServer(multiprocessing.Process):
             # If we don't see a UI connection within maxuiwait, its unlikely we're going to see
             # one. We have had issue with processes hanging indefinitely so timing out UI-less
             # servers is useful.
-            if not self.hadanyui and not self.timeout and (self.lastui + self.maxuiwait) < time.time():
+            if not self.hadanyui and not self.xmlrpc and not self.timeout and (self.lastui + self.maxuiwait) < time.time():
                 print("No UI connection within max timeout, exiting to avoid infinite loop.")
                 self.quit = True
 
-- 
2.17.1

