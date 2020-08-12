Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.346.1597264988696051488
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Aug 2020 13:43:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=LsYYzO4y;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id k8so3167868wma.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 12 Aug 2020 13:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=s5FYcOYg4MZhMdcpIWJ2Cb4zFhrT4MiSyQLov3syluc=;
        b=LsYYzO4yJffjziKaxnjmlKDBnRFP1W9ol4w1vrekP6MLe8lnMsVxNNo6I25+6sSn12
         C+iEgsKPb5YNbDRJQF9hj27r+wLVlx6U06DeH+PfBQqHMovZb6clG1gZ3mB2DF/ViRhs
         7Huzoor6HSE0rqS0nVkurnGUStC0vQMGCj1u4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s5FYcOYg4MZhMdcpIWJ2Cb4zFhrT4MiSyQLov3syluc=;
        b=JOiIkh200B5fXJI8Z/bDHhmZFUyrAC8f8WFoESYWIR+sak5IIfJ9quUd67ekIP5H8L
         ojOyhhVD3IZZOA00bYZPfsy7i+GaJQ+9SYhHRcLZ8BDy0ORbFWNppMjcIV81I0VVVYey
         CbZ760s2CsNC9C8BAAWLEvgyc8ck3Astuc/fJVQtjzTI96rdVRTOwZiPH7ze+4y8T1oM
         4xv+iRAWwFGDy11H9VWXqc9OMGMHjJYrkwVB8pBZ3bfF2Rtv5pCNtZKJKbB3mQDul53r
         r5A1IckukRYWj2j0Eqxe9R2qDhyZiaBgqetmX0XKThR+fOMk1SyQYvCU5Dw5kBpItIMs
         vFPw==
X-Gm-Message-State: AOAM533Qv06KHec0+ukwRWMpe+YK5+zvnAFyFjJVQwdFCgsYfI10US5V
	8RZD29azwMFWNtgiIhYNOujvdApS6ueCbQ==
X-Google-Smtp-Source: ABdhPJwzcqMx9j7gKzYuoTfkGd1Yayfrn4g3+A1kpYsj2cPcxDn0azX94HxJK0NzXZX5iZDsA8bKOg==
X-Received: by 2002:a7b:c941:: with SMTP id i1mr1233400wml.73.1597264987237;
        Wed, 12 Aug 2020 13:43:07 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (9.a.c.c.d.f.6.e.e.7.9.e.9.0.c.e.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:ec09:e97e:e6fd:cca9])
        by smtp.gmail.com with ESMTPSA id p25sm5408479wma.39.2020.08.12.13.43.05
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 13:43:06 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/3] server/process: Pass timeout/xmlrpc parameters directly to the server
Date: Wed, 12 Aug 2020 21:43:04 +0100
Message-Id: <20200812204304.931893-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200812204304.931893-1-richard.purdie@linuxfoundation.org>
References: <20200812204304.931893-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Further cleanup, just pass these settings directly.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index a3ef10753d..7ee427b51c 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -38,7 +38,7 @@ class ProcessServer():
     profile_filename = "profile.log"
     profile_processed_filename = "profile.log.processed"
 
-    def __init__(self, lock, sock, sockname):
+    def __init__(self, lock, sock, sockname, server_timeout, xmlrpcinterface):
         self.command_channel = False
         self.command_channel_reply = False
         self.quit = False
@@ -57,6 +57,9 @@ class ProcessServer():
         self.sock = sock
         self.sockname = sockname
 
+        self.server_timeout = server_timeout
+        self.xmlrpcinterface = xmlrpcinterface
+
     def register_idle_function(self, function, data):
         """Register a function to be called while the server is idle"""
         assert hasattr(function, '__call__')
@@ -466,7 +469,7 @@ class BitBakeServer(object):
         print(self.start_log_format % (os.getpid(), datetime.datetime.now().strftime(self.start_log_datetime_format)))
         sys.stdout.flush()
 
-        server = ProcessServer(self.bitbake_lock, self.sock, self.sockname)
+        server = ProcessServer(self.bitbake_lock, self.sock, self.sockname, self.configuration.server_timeout, self.configuration.xmlrpcinterface)
         os.close(self.readypipe)
         writer = ConnectionWriter(self.readypipein)
         try:
@@ -476,8 +479,6 @@ class BitBakeServer(object):
         writer.send("r")
         writer.close()
         server.cooker = self.cooker
-        server.server_timeout = self.configuration.server_timeout
-        server.xmlrpcinterface = self.configuration.xmlrpcinterface
         print("Started bitbake server pid %d" % os.getpid())
         sys.stdout.flush()
 
-- 
2.25.1

