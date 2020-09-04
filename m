Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web10.39612.1599230657174643623
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 04 Sep 2020 07:44:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=OjBjfSCT;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id u18so6305495wmc.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 04 Sep 2020 07:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VGIeKsl7nb/rSu9Njc1LRjibONPQdtTi5R2BtC7EjYE=;
        b=OjBjfSCTmJdxM7LQy46ZcVilYqASiOce2ZIDEwIrgI0I4k3juCZoKbuuBwry7rjBCn
         GOPRo/Dgm2QsbsM5aSFyFPttqS4bRbgzVnuJ/z2itwr/k/Z+/iEDnjHRex19RDyOY2p0
         /ZiATE4AnjcQuvlUmYURpx9u2XOfRCLgIrytw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VGIeKsl7nb/rSu9Njc1LRjibONPQdtTi5R2BtC7EjYE=;
        b=Rc/ylBjBrrw1jWRfmHE5qk6oZs8oVQBKRRta/L2OqvGK17oMIujfzPg5kGyWzfgneD
         /j3RrlBU/rjJyzP1rQRj+0NT3xJ2DqsSHMQNR9Txb/sz3FvyUM7W5jtSihlq5gXUhgvv
         0HuMdB3Uv1XgukgpVZ5NYzP8wjAE7iLxWXrCugrUNQDrONnEKemcV7yLDFx6MR1OjTEi
         jX+Ft//yOb6Tl6zt8IsBVLpubg2K4T4pskyKRZdUgvN3qd80jg0NVZMEQES6KKdj8FG6
         2vhNTvbuO//suWvXlYFTXRgM/qhfrRHpNH0pKsIE5q/d02unr/nGTNREFnmPig/Q9KUz
         q+pg==
X-Gm-Message-State: AOAM531Z30FoGYn/mAJ/Csfk5L8KbLGSwLRj3ze0IZrNG2jwPlKnyIUs
	uaW36SXmPMWS88CikDuEsulFM6MyDA/hWA==
X-Google-Smtp-Source: ABdhPJzYM4CaMQIGBIgPtk3O4O6PD0i5cHNx9Ca34soHgdwSNpp8+1LxQrhPOAvGqDsoiXwm/lXkYg==
X-Received: by 2002:a1c:6385:: with SMTP id x127mr8344493wmb.95.1599230655042;
        Fri, 04 Sep 2020 07:44:15 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (d.f.d.f.5.0.6.0.0.2.6.1.6.b.c.7.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:7cb6:1620:605:fdfd])
        by smtp.gmail.com with ESMTPSA id n124sm11798962wmn.29.2020.09.04.07.44.14
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 07:44:14 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/4] server/process: Ensure logging is flushed
Date: Fri,  4 Sep 2020 15:44:09 +0100
Message-Id: <20200904144411.1817481-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200904144411.1817481-1-richard.purdie@linuxfoundation.org>
References: <20200904144411.1817481-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cookerlog output goes to a file and its misleading to look at it and
not have it up to date with what the cooker is actually doing. Ensure
written data is flushed.

Ultimately this should be using python's logging but that is for another
day, we need simple fixes right now.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 44 +++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 5b4d92dc80..2be4588a4f 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -35,6 +35,10 @@ logger = logging.getLogger('BitBake')
 class ProcessTimeout(SystemExit):
     pass
 
+def serverlog(msg):
+    print(msg)
+    sys.stdout.flush()
+
 class ProcessServer():
     profile_filename = "profile.log"
     profile_processed_filename = "profile.log.processed"
@@ -73,7 +77,7 @@ class ProcessServer():
         if self.xmlrpcinterface[0]:
             self.xmlrpc = bb.server.xmlrpcserver.BitBakeXMLRPCServer(self.xmlrpcinterface, self.cooker, self)
 
-            print("Bitbake XMLRPC server address: %s, server port: %s" % (self.xmlrpc.host, self.xmlrpc.port))
+            serverlog("Bitbake XMLRPC server address: %s, server port: %s" % (self.xmlrpc.host, self.xmlrpc.port))
 
         try:
             self.bitbake_lock.seek(0)
@@ -84,7 +88,7 @@ class ProcessServer():
                 self.bitbake_lock.write("%s\n" % (os.getpid()))
             self.bitbake_lock.flush()
         except Exception as e:
-            print("Error writing to lock file: %s" % str(e))
+            serverlog("Error writing to lock file: %s" % str(e))
             pass
 
         if self.cooker.configuration.profile:
@@ -98,7 +102,7 @@ class ProcessServer():
 
             prof.dump_stats("profile.log")
             bb.utils.process_profilelog("profile.log")
-            print("Raw profiling information saved to profile.log and processed statistics to profile.log.processed")
+            serverlog("Raw profiling information saved to profile.log and processed statistics to profile.log.processed")
 
         else:
             ret = self.main()
@@ -118,10 +122,10 @@ class ProcessServer():
         if self.xmlrpc:
             fds.append(self.xmlrpc)
         seendata = False
-        print("Entering server connection loop")
+        serverlog("Entering server connection loop")
 
         def disconnect_client(self, fds):
-            print("Disconnecting Client")
+            serverlog("Disconnecting Client")
             if self.controllersock:
                 fds.remove(self.controllersock)
                 self.controllersock.close()
@@ -139,12 +143,12 @@ class ProcessServer():
                 self.haveui = False
             ready = select.select(fds,[],[],0)[0]
             if newconnections:
-                print("Starting new client")
+                serverlog("Starting new client")
                 conn = newconnections.pop(-1)
                 fds.append(conn)
                 self.controllersock = conn
             elif self.timeout is None and not ready:
-                print("No timeout, exiting.")
+                serverlog("No timeout, exiting.")
                 self.quit = True
 
         self.lastui = time.time()
@@ -153,17 +157,17 @@ class ProcessServer():
                 while select.select([self.sock],[],[],0)[0]:
                     controllersock, address = self.sock.accept()
                     if self.controllersock:
-                        print("Queuing %s (%s)" % (str(ready), str(newconnections)))
+                        serverlog("Queuing %s (%s)" % (str(ready), str(newconnections)))
                         newconnections.append(controllersock)
                     else:
-                        print("Accepting %s (%s)" % (str(ready), str(newconnections)))
+                        serverlog("Accepting %s (%s)" % (str(ready), str(newconnections)))
                         self.controllersock = controllersock
                         fds.append(controllersock)
             if self.controllersock in ready:
                 try:
-                    print("Processing Client")
+                    serverlog("Processing Client")
                     ui_fds = recvfds(self.controllersock, 3)
-                    print("Connecting Client")
+                    serverlog("Connecting Client")
 
                     # Where to write events to
                     writer = ConnectionWriter(ui_fds[0])
@@ -187,14 +191,14 @@ class ProcessServer():
 
             if not self.timeout == -1.0 and not self.haveui and self.timeout and \
                     (self.lastui + self.timeout) < time.time():
-                print("Server timeout, exiting.")
+                serverlog("Server timeout, exiting.")
                 self.quit = True
 
             # If we don't see a UI connection within maxuiwait, its unlikely we're going to see
             # one. We have had issue with processes hanging indefinitely so timing out UI-less
             # servers is useful.
             if not self.hadanyui and not self.xmlrpc and not self.timeout and (self.lastui + self.maxuiwait) < time.time():
-                print("No UI connection within max timeout, exiting to avoid infinite loop.")
+                serverlog("No UI connection within max timeout, exiting to avoid infinite loop.")
                 self.quit = True
 
             if self.command_channel in ready:
@@ -209,7 +213,7 @@ class ProcessServer():
                     self.quit = True
                     continue
                 try:
-                    print("Running command %s" % command)
+                    serverlog("Running command %s" % command)
                     self.command_channel_reply.send(self.cooker.command.runCommand(command))
                 except Exception as e:
                    logger.exception('Exception in server main event loop running command %s (%s)' % (command, str(e)))
@@ -236,9 +240,9 @@ class ProcessServer():
             ready = self.idle_commands(.1, fds)
 
         if len(threading.enumerate()) != 1:
-            print("More than one thread left?: " + str(threading.enumerate()))
+            serverlog("More than one thread left?: " + str(threading.enumerate()))
 
-        print("Exiting")
+        serverlog("Exiting")
         # Remove the socket file so we don't get any more connections to avoid races
         try:
             os.unlink(self.sockname)
@@ -296,7 +300,7 @@ class ProcessServer():
                 msg = "Delaying shutdown due to active processes which appear to be holding bitbake.lock"
                 if procs:
                     msg += ":\n%s" % str(procs.decode("utf-8"))
-                print(msg)
+                serverlog(msg)
 
     def idle_commands(self, delay, fds=None):
         nextsleep = delay
@@ -485,8 +489,7 @@ def execServer(lockfd, readypipeinfd, lockname, sockname, server_timeout, xmlrpc
     import bb.cookerdata
     import bb.cooker
 
-    print(start_log_format % (os.getpid(), datetime.datetime.now().strftime(start_log_datetime_format)))
-    sys.stdout.flush()
+    serverlog(start_log_format % (os.getpid(), datetime.datetime.now().strftime(start_log_datetime_format)))
 
     try:
         bitbake_lock = os.fdopen(lockfd, "w")
@@ -515,8 +518,7 @@ def execServer(lockfd, readypipeinfd, lockname, sockname, server_timeout, xmlrpc
         writer.send("r")
         writer.close()
         server.cooker = cooker
-        print("Started bitbake server pid %d" % os.getpid())
-        sys.stdout.flush()
+        serverlog("Started bitbake server pid %d" % os.getpid())
 
         server.run()
     finally:
-- 
2.25.1

