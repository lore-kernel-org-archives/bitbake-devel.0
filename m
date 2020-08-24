Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web10.1094.1598288025676208700
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Aug 2020 09:53:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=AuAMzx3M;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id z9so23717wmk.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 24 Aug 2020 09:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=d5ul+sZhA5skjNvYkdUgYQxAFeyuMOCjv7t7lTAti1Y=;
        b=AuAMzx3M51ZmdzdIOhLdm5f4UO6TtqNIJOoLuTe0hc5dOjnmGgckmT0Qg19nWMUWKy
         acfTUN1jpRNESsBKLSYETnNw7jaTC2plRS9itV5H+pUZh9V2HLQ2Onj2fZ2il9Z8zv6c
         DLY8h2QcEoNPLHORG2OjSK0Q4/VIv7+MgkDWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d5ul+sZhA5skjNvYkdUgYQxAFeyuMOCjv7t7lTAti1Y=;
        b=O0qPQrHRWum5z0KmkoS9zFN3fMatZjgHPJDpNVZaq5WHbC+qGB0yjm5WXZF6iNQQuB
         pAWzuAiCKeJGvG3OEDl6BZpSR2YwHpGXwjsy6ZN2yozu7ATEXIlPTgIFIS1fdZREa2OW
         cifE1Zg3X25KMjy6GPdHK+YDcRB4o9+xmYsqITp8V/b5MBC2lZfstvmeLwIBWTD0cCne
         UwtslfeGOLch29iWvQJMNQJi80jreiLTD+veqr/hOOPNI06l+IXNcyCtByxfvHGcMzRW
         XFk2AWTUpXX6+FcXJ/sTiJgF6vZhkH3xCxSn612XSoF9qutwEYz7IBcKo8FQGSebnnJK
         L0oQ==
X-Gm-Message-State: AOAM531kusT5V6VOUxnU/LuNsEcn2f9QzD0crCeJsb5Xu+09QZ+pzCAx
	ZnJT/8bPMyTX9RYX2JnvStCAQ8fhChshU+vO
X-Google-Smtp-Source: ABdhPJyXybWfz+QUQZE2qMc/YNKOeOKSGiVXxLNlkNv9jN2/gi3+OlNxkLtjoeRojDiIlF2tIC0nhw==
X-Received: by 2002:a1c:ed15:: with SMTP id l21mr218400wmh.56.1598288019795;
        Mon, 24 Aug 2020 09:53:39 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (d.d.0.9.8.0.3.8.5.d.6.d.5.a.5.4.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:45a5:d6d5:8308:90dd])
        by smtp.gmail.com with ESMTPSA id f19sm182127wmh.44.2020.08.24.09.53.39
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 09:53:39 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 10/10] server/process: Add bitbake-server and exec() a new server process
Date: Mon, 24 Aug 2020 17:53:31 +0100
Message-Id: <20200824165331.1373725-10-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824165331.1373725-1-richard.purdie@linuxfoundation.org>
References: <20200824165331.1373725-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Trying to have a new python process forked off an original doesn't work
out well and ends up having race issues. To avoid this, exec() a new
bitbake server process. This starts with a fresh python interpreter
and resolves various atexit and other multiprocessing issues once
and for all.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 92 +++++++++++++++++++++++-----------------
 1 file changed, 53 insertions(+), 39 deletions(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 915651084e..d248570cd2 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -38,7 +38,7 @@ class ProcessServer():
     profile_filename = "profile.log"
     profile_processed_filename = "profile.log.processed"
 
-    def __init__(self, lock, sock, sockname, server_timeout, xmlrpcinterface):
+    def __init__(self, lock, lockname, sock, sockname, server_timeout, xmlrpcinterface):
         self.command_channel = False
         self.command_channel_reply = False
         self.quit = False
@@ -54,6 +54,7 @@ class ProcessServer():
         self._idlefuns = {}
 
         self.bitbake_lock = lock
+        self.bitbake_lock_name = lockname
         self.sock = sock
         self.sockname = sockname
 
@@ -259,7 +260,7 @@ class ProcessServer():
 
         # Finally release the lockfile but warn about other processes holding it open
         lock = self.bitbake_lock
-        lockfile = lock.name
+        lockfile = self.bitbake_lock_name
         lock.close()
         lock = None
 
@@ -393,9 +394,10 @@ class BitBakeProcessServerConnection(object):
         self.connection.recv.close()
         return
 
+start_log_format = '--- Starting bitbake server pid %s at %s ---'
+start_log_datetime_format = '%Y-%m-%d %H:%M:%S.%f'
+
 class BitBakeServer(object):
-    start_log_format = '--- Starting bitbake server pid %s at %s ---'
-    start_log_datetime_format = '%Y-%m-%d %H:%M:%S.%f'
 
     def __init__(self, lock, sockname, featureset, server_timeout, xmlrpcinterface):
 
@@ -429,7 +431,7 @@ class BitBakeServer(object):
             ready.close()
             bb.error("Unable to start bitbake server (%s)" % str(r))
             if os.path.exists(logfile):
-                logstart_re = re.compile(self.start_log_format % ('([0-9]+)', '([0-9-]+ [0-9:.]+)'))
+                logstart_re = re.compile(start_log_format % ('([0-9]+)', '([0-9-]+ [0-9:.]+)'))
                 started = False
                 lines = []
                 lastlines = []
@@ -441,7 +443,7 @@ class BitBakeServer(object):
                             lastlines.append(line)
                             res = logstart_re.match(line.rstrip())
                             if res:
-                                ldatetime = datetime.datetime.strptime(res.group(2), self.start_log_datetime_format)
+                                ldatetime = datetime.datetime.strptime(res.group(2), start_log_datetime_format)
                                 if ldatetime >= startdatetime:
                                     started = True
                                     lines.append(line)
@@ -462,42 +464,54 @@ class BitBakeServer(object):
         ready.close()
 
     def _startServer(self):
-        print(self.start_log_format % (os.getpid(), datetime.datetime.now().strftime(self.start_log_datetime_format)))
-        sys.stdout.flush()
+        os.close(self.readypipe)
+        os.set_inheritable(self.bitbake_lock.fileno(), True)
+        os.set_inheritable(self.readypipein, True)
+        os.execlp("bitbake-server", "bitbake-server", "decafbad", str(self.bitbake_lock.fileno()), str(self.readypipein), self.bitbake_lock.name, self.sockname,  str(self.server_timeout), str(self.xmlrpcinterface[0]), str(self.xmlrpcinterface[1]))
 
-        try:
-            # Create server control socket
-            if os.path.exists(self.sockname):
-                os.unlink(self.sockname)
+def execServer(lockfd, readypipeinfd, lockname, sockname, server_timeout, xmlrpcinterface):
 
-            sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
-            # AF_UNIX has path length issues so chdir here to workaround
-            cwd = os.getcwd()
-            try:
-                os.chdir(os.path.dirname(self.sockname))
-                sock.bind(os.path.basename(self.sockname))
-            finally:
-                os.chdir(cwd)
-            sock.listen(1)
-
-            server = ProcessServer(self.bitbake_lock, sock, self.sockname, self.server_timeout, self.xmlrpcinterface)
-            os.close(self.readypipe)
-            writer = ConnectionWriter(self.readypipein)
-            try:
-                self.cooker = bb.cooker.BBCooker(self.featureset, server.register_idle_function)
-            except bb.BBHandledException:
-                return None
-            writer.send("r")
-            writer.close()
-            server.cooker = self.cooker
-            print("Started bitbake server pid %d" % os.getpid())
-            sys.stdout.flush()
-
-            server.run()
+    import bb.cookerdata
+    import bb.cooker
+
+    print(start_log_format % (os.getpid(), datetime.datetime.now().strftime(start_log_datetime_format)))
+    sys.stdout.flush()
+
+    try:
+        bitbake_lock = os.fdopen(lockfd, "w")
+
+        # Create server control socket
+        if os.path.exists(sockname):
+            os.unlink(sockname)
+
+        sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
+        # AF_UNIX has path length issues so chdir here to workaround
+        cwd = os.getcwd()
+        try:
+            os.chdir(os.path.dirname(sockname))
+            sock.bind(os.path.basename(sockname))
         finally:
-            # Flush any ,essages/errors to the logfile before exit
-            sys.stdout.flush()
-            sys.stderr.flush()
+            os.chdir(cwd)
+        sock.listen(1)
+
+        server = ProcessServer(bitbake_lock, lockname, sock, sockname, server_timeout, xmlrpcinterface)
+        writer = ConnectionWriter(readypipeinfd)
+        try:
+            featureset = []
+            cooker = bb.cooker.BBCooker(featureset, server.register_idle_function)
+        except bb.BBHandledException:
+            return None
+        writer.send("r")
+        writer.close()
+        server.cooker = cooker
+        print("Started bitbake server pid %d" % os.getpid())
+        sys.stdout.flush()
+
+        server.run()
+    finally:
+        # Flush any ,essages/errors to the logfile before exit
+        sys.stdout.flush()
+        sys.stderr.flush()
 
 def connectProcessServer(sockname, featureset):
     # Connect to socket
-- 
2.25.1

