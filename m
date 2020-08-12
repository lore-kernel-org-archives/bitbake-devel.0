Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web12.700.1597270231739931085
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Aug 2020 15:10:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=NXNud5AK;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id t14so3321540wmi.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 12 Aug 2020 15:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+E87fMi48oWRjbBk3Hg6+9h4lZio1SbNN4tqc/nm1Vk=;
        b=NXNud5AKlYnH5aZj747c7O3cfH/Axp8dut7midX/dpVyRp/bq8qu/xcbdqvmIaLlwd
         owY21yZRrhpuUgF7k0yfTJa38+jgrvyroAoR6Ny4j5A0QzcJj/B6Fx04yle+DXFZb+V/
         ZRxnDlzWZbn+vMsfm+7+nlgLVfsf9mb5TfSPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+E87fMi48oWRjbBk3Hg6+9h4lZio1SbNN4tqc/nm1Vk=;
        b=Uni4plRoX5kiEb2JDRHa8ov3eXPOh9RSYVIkUxk9/xXP1vK5LwmiupVkcy1kHwVjoB
         ZzTnvZBv4T0n1Cy2O11sAYVPoF4Wg036AFkm0dWmfL1YvVArzHAlXU/z/ISEl2Cd3poj
         Vxw1c1gW9KE2Ma8WBLgJV200P5XFrug+EusTzgnmcTjWuFiqKamUXLzSZd9hRBp5YhuV
         DcTJSGC4kCU2Csyy5OUxy1ZUozA7L3ejLXWhvMTvMYgXorI1Pb/vhzo3Tzr1Hi3WNMQv
         ljk9onehr0X1eOPwZzkOwX2IpieG3pqpb50FrtCCgviGYmXTz8nEzj08IZe6YQ+zgUux
         bkTw==
X-Gm-Message-State: AOAM533K78cm9f3K9jGsLI+YvPZ8zxt2y9wfqG275ZdYDY4yA3KLHvDv
	EybpuCePnz4Krl17V+elKPrazWIC8a0lqg==
X-Google-Smtp-Source: ABdhPJwaHHZW9Vj/RG12CBqPBPYF9TUbwLk3oBOzUAMdc3uWfKNUHxTMSG7DXJ1m0BtJJUtBG5d3ug==
X-Received: by 2002:a7b:c74b:: with SMTP id w11mr1415379wmk.81.1597270230079;
        Wed, 12 Aug 2020 15:10:30 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (3.4.a.8.2.9.1.2.1.e.3.5.0.0.0.3.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:3000:53e1:2192:8a43])
        by smtp.gmail.com with ESMTPSA id h7sm6189823wmf.43.2020.08.12.15.10.29
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 15:10:29 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] server/process: Add extra logfile flushing
Date: Wed, 12 Aug 2020 23:10:29 +0100
Message-Id: <20200812221029.936201-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is the possibility data is being lost from the logfile due to
data buffering. Add in a couple of extra flush calls to ensure data
is being written out before the lock file is dropped.

Possible fix for [YOCTO #14000]?

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 7ee427b51c..65e1eab527 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -247,6 +247,10 @@ class ProcessServer():
 
         self.cooker.post_serve()
 
+        # Flush logs before we release the lock
+        sys.stdout.flush()
+        sys.stderr.flush()
+
         # Finally release the lockfile but warn about other processes holding it open
         lock = self.bitbake_lock
         lockfile = lock.name
@@ -469,20 +473,25 @@ class BitBakeServer(object):
         print(self.start_log_format % (os.getpid(), datetime.datetime.now().strftime(self.start_log_datetime_format)))
         sys.stdout.flush()
 
-        server = ProcessServer(self.bitbake_lock, self.sock, self.sockname, self.configuration.server_timeout, self.configuration.xmlrpcinterface)
-        os.close(self.readypipe)
-        writer = ConnectionWriter(self.readypipein)
         try:
-            self.cooker = bb.cooker.BBCooker(self.configuration, self.featureset, server.register_idle_function)
-        except bb.BBHandledException:
-            return None
-        writer.send("r")
-        writer.close()
-        server.cooker = self.cooker
-        print("Started bitbake server pid %d" % os.getpid())
-        sys.stdout.flush()
-
-        server.run()
+            server = ProcessServer(self.bitbake_lock, self.sock, self.sockname, self.configuration.server_timeout, self.configuration.xmlrpcinterface)
+            os.close(self.readypipe)
+            writer = ConnectionWriter(self.readypipein)
+            try:
+                self.cooker = bb.cooker.BBCooker(self.configuration, self.featureset, server.register_idle_function)
+            except bb.BBHandledException:
+                return None
+            writer.send("r")
+            writer.close()
+            server.cooker = self.cooker
+            print("Started bitbake server pid %d" % os.getpid())
+            sys.stdout.flush()
+
+            server.run()
+        finally:
+            # Flush any ,essages/errors to the logfile before exit
+            sys.stdout.flush()
+            sys.stderr.flush()
 
 def connectProcessServer(sockname, featureset):
     # Connect to socket
-- 
2.25.1

