Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web12.8904.1632493340322630944
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Sep 2021 07:22:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=WsIGIcNA;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.53, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f53.google.com with SMTP id mv7-20020a17090b198700b0019c843e7233so7641361pjb.4
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 Sep 2021 07:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vaqEk/kMmRsSLoHLEStyPYmqRz1hjSrv45/C5dNBxVs=;
        b=WsIGIcNAeIEHVOpKFEu2fHc9f1ur5ypCtWYzDjWd0OW372t76BR+z6kzPIQZ9Cqwze
         x0MkSAX2TYAPTwTRT6m86ZcKSXgpba5VQNwFeV5rl6WWN7B9CqS/XG3uHMjeFj2ybplu
         gUaceKs2N10gwRiMqL5dghBEHEdxK9S/u4IeXEDJU6VuNKDruDqYtkZVObG5M2IJdOnV
         WamG+Y7kh1JfNdwlxEoSbYxW7urpiHn4AhWa31mOEAEj0MOUHbmkY09LqJ58bIani7i1
         ptJ7BUVfK5H8yq15z6FLr36xIcj377PJFXHGYrA1Jd/7nPECU7kuTBkQ/qEc+UbOEqcc
         K2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vaqEk/kMmRsSLoHLEStyPYmqRz1hjSrv45/C5dNBxVs=;
        b=gRFX1wekCDm1wphjExUUIjxsNzn07t8lKos3sWTsiV4PaIz4+/i1TKo53VautOK3ab
         yBsBpdRQVhY+0ebJtfrYJfrR0FW11WqeevAnTVgtIUiIfLEIWLmRqKNubzNS4kjyX4x0
         Cx8BcdQIxIYZjx3415Hrrmt1Bsfo/+fAGp95PEf4cWMPhw5v9cBDPOVBvw+oq94gtnBf
         VSXPJ5iUpOj4teCEO5FJMPZ1eSaUBEvLDCAO4BIXIvuwF6QJpVAog5Rw8O5hGNg6lhPZ
         AHEUwsMlCun+ANAXAel0bHaVt50e9CMnzxhR5D+btiNfA46rhTT9wPiXErjNsW/S8eHx
         WIAg==
X-Gm-Message-State: AOAM530hWHGQ3BSnfFgkqRB5KDaEH9duAktbxKkn6BCKmpINDqJ7WmNe
	NI4afZ5UKa+ajX5mVBapB0tCbvmRG/PNe0PWsiU=
X-Google-Smtp-Source: ABdhPJzLOq7iss6eIiCxgueU4jHYhra3Xy+L50cy1BhtjE+IyqIB2ZXs7CvVTlhzb6+pABb6oQ+9og==
X-Received: by 2002:a17:90b:1e4d:: with SMTP id pi13mr2611344pjb.96.1632493339359;
        Fri, 24 Sep 2021 07:22:19 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from localhost.localdomain (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id j20sm9907347pgb.2.2021.09.24.07.22.18
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 07:22:18 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 02/14] ui/taskexp: Improve startup exception handling
Date: Fri, 24 Sep 2021 04:20:55 -1000
Message-Id: <c368810741e78faa139db66128b46f242b9cf7cb.1632493110.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1632493110.git.steve@sakoman.com>
References: <cover.1632493110.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Purdie <richard.purdie@linuxfoundation.org>

When an exception occurs at startup, show it to the user.

[YOCTO #14408]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit cc1df1af67cfd3e223b39e2b7ea5f86b8cf78aee)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/ui/taskexp.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bb/ui/taskexp.py b/lib/bb/ui/taskexp.py
index 2b246710..81392977 100644
--- a/lib/bb/ui/taskexp.py
+++ b/lib/bb/ui/taskexp.py
@@ -8,6 +8,7 @@
 #
 
 import sys
+import traceback
 
 try:
     import gi
@@ -218,6 +219,9 @@ def main(server, eventHandler, params):
     except client.Fault as x:
         print("XMLRPC Fault getting commandline:\n %s" % x)
         return
+    except Exception as e:
+        print("Exception in startup:\n %s" % traceback.format_exc())
+        return
 
     if gtkthread.quit.isSet():
         return
-- 
2.25.1

