Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web11.5754.1594590076802523530
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 12 Jul 2020 14:41:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Go1gS65w;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id q5so12149649wru.6
        for <bitbake-devel@lists.openembedded.org>; Sun, 12 Jul 2020 14:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D/kVA49OA+4XhqhtgiA1ttZkgQHsnEJnuMpjthNInQ0=;
        b=Go1gS65w68rI2oUEXbrt/7sjGUDAl8f+QpS4JBV/tXbbXonmbi41ZQhlfRpBb7tO/Z
         V3pqJZ2kg8ccLHpJN9HjyDYc3yInWojaDQfXdo6YDnsPaNGxLgLj1IW9/aYQJtRpOKs7
         eDwbWnfzZqT828tzjCMdZImooPiKGnLCKcrw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D/kVA49OA+4XhqhtgiA1ttZkgQHsnEJnuMpjthNInQ0=;
        b=TXsEZ4BZKQvDC8GWszaHw3xDu/JjN4nupOtZ85t75pZJsFcKyBbTFNeJJ8r0RjBHzR
         +GSZDpTJcuNxvEiAFSvGA8xxUUXCbMNGK4tvFPYmb3o0gUzlAL6WJIv4+FWOwksb6dRw
         4aOZmuCi158A72uqN8Dg/RHkIO3H+lk/ajsZkAxyV1nC8O875FaGtxw1vd69pyGMO0CP
         xKlgBW/eE1PG4iv9ZoG9nv9OWTx6qqoYzTOoRMya2brVG7Z87WF85t/f5UfA8hWEwHNY
         vw3J0Ej2YP1ArvcLLDxrtfyC9pHbvQoq5edMWMDAdjh9xAm3sa5HV1ZDZhz+PbfAkHZm
         M3Ow==
X-Gm-Message-State: AOAM5307qkegJUkg2E2bWKSpWOudi2QpPgOiCQcGOOS9JfzyvgP0w2Z8
	FNGZ/wIs0y3taut6EnwfTf90+Bsi6+ZdNw==
X-Google-Smtp-Source: ABdhPJxhiLg7IOn4p1ioXQyzm88+RT3/EwAmwlb6l2sZPLNdAhC4wT6MAdlUPH8BGx4w8tKiBktHog==
X-Received: by 2002:a05:6000:1143:: with SMTP id d3mr64271832wrx.235.1594590074920;
        Sun, 12 Jul 2020 14:41:14 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id a22sm19074542wmj.9.2020.07.12.14.41.13
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 14:41:14 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] server/process: Ensure UI-less servers don't sit in infinite loops
Date: Sun, 12 Jul 2020 22:41:13 +0100
Message-Id: <20200712214113.531729-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If server startup is broken for some reason (e.g. lockfile issues)
and no UI connection is made, the server will just sit inifinitely
waiting.

Add a timeout upon startup in the non-memory resident case so that
such infinite waits are avoided. In the memory resident case, the
server wouldn't have shut down in the first place or will timeout
according to configuration.

Since any race may mean the socket file is no longer present, ensure
the unlink doesn't fault upon exit, thus ensuring any hashequiv or
PRServ is removed from memory, allowing all processes to exit
cleanly in such scenarios.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 475931a728..d4beac4379 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -48,7 +48,7 @@ class ProcessServer(multiprocessing.Process):
 
         self.event_handle = None
         self.haveui = False
-        self.lastui = False
+        self.maxuiwait = 30
         self.xmlrpc = False
 
         self._idlefuns = {}
@@ -155,6 +155,7 @@ class ProcessServer(multiprocessing.Process):
                 print("No timeout, exiting.")
                 self.quit = True
 
+        self.lastui = time.time()
         while not self.quit:
             if self.sock in ready:
                 while select.select([self.sock],[],[],0)[0]:
@@ -191,11 +192,18 @@ class ProcessServer(multiprocessing.Process):
                 except (EOFError, OSError):
                     disconnect_client(self, fds)
 
-            if not self.timeout == -1.0 and not self.haveui and self.lastui and self.timeout and \
+            if not self.timeout == -1.0 and not self.haveui and self.timeout and \
                     (self.lastui + self.timeout) < time.time():
                 print("Server timeout, exiting.")
                 self.quit = True
 
+            # If we don't see a UI connection within maxuiwait, its unlikely we're going to see
+            # one. We have had issue with processes hanging indefinitely so timing out UI-less
+            # servers is useful.
+            if not self.haveui and not self.timeout and (self.lastui + self.maxuiwait) < time.time():
+                print("No UI connection within max timeout, exiting to avoid infinite loop.")
+                self.quit = True
+
             if self.command_channel in ready:
                 try:
                     command = self.command_channel.get()
@@ -220,10 +228,13 @@ class ProcessServer(multiprocessing.Process):
 
         print("Exiting")
         # Remove the socket file so we don't get any more connections to avoid races
-        os.unlink(self.sockname)
+        try:
+            os.unlink(self.sockname)
+        except:
+            pass
         self.sock.close()
 
-        try: 
+        try:
             self.cooker.shutdown(True)
             self.cooker.notifier.stop()
             self.cooker.confignotifier.stop()
-- 
2.25.1

