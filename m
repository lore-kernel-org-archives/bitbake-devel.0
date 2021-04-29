Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web12.7442.1619705489697257304
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 29 Apr 2021 07:11:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Khx/MU6Y;
 spf=pass (domain: konsulko.com, ip: 209.85.128.46, mailfrom: pbarker@konsulko.com)
Received: by mail-wm1-f46.google.com with SMTP id i21-20020a05600c3555b029012eae2af5d4so11436749wmq.4
        for <bitbake-devel@lists.openembedded.org>; Thu, 29 Apr 2021 07:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l3VQdvfTMBOb5INlHBGHByoiTF3Pp+jQEgwTKmRVJKk=;
        b=Khx/MU6YbEmVNaBDQHJNrXI1MqEyiEcZnjfeg9e9glWlrOl75tUtjZL/hPiTnLhO5P
         qR5rfu/mWQVV4Ot0W8DAogHJ4pgFpzfh2jEd0JIDbYfxnbNgjSDMN0LgRceDDbfA+bii
         zri9ZQ2ez0tVGwgZxs3PIT1143ZfOHENk+Oy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l3VQdvfTMBOb5INlHBGHByoiTF3Pp+jQEgwTKmRVJKk=;
        b=D9K2Eqd7KU0tIada9vgk1jYL0iVE1cN0MBZ+JXQPwTljJix7ttFjoZshNlqLPOVpF0
         +6zEVbGIvmJQ+rxa9CoS/fs4JNMwxpy6x+j0bM/DbIjuR8DDCyAaEYtx71IdLBacQSBW
         0M5KS3CknDW00zwgVlJ7Ms8djV68yYPC1Vw9cvPyHKUm7c1F+mJwalmcEce+Tb98XYf4
         BSfMywoN+xdcIwTLpOPinW5pOFJlFzNs5W2Fi6EA1V65MvVclk2e8G1qybb4qEffF/0F
         bYYZKldg9DJ4e8xbxdLqLhXlI2FQyvDL33HtrefOxWs29Eee6RxFRuwT2mI96hr2GFfv
         TABg==
X-Gm-Message-State: AOAM531wjfVWQcozUWJnNfOipW0fbvS/XR2tBDDyT5F62OnHbjyZ46s0
	NbbZx0l8syyro57CUeQX1rErwqs33Gqwtw==
X-Google-Smtp-Source: ABdhPJwRC+L9xnPDDEgxaGo3DnqBPhVr6IMWLDPpBvQXX92M+aTa+W+Ai0xK6LZ6VgFG0p949fWFbw==
X-Received: by 2002:a7b:c003:: with SMTP id c3mr174496wmb.59.1619705487950;
        Thu, 29 Apr 2021 07:11:27 -0700 (PDT)
Return-Path: <pbarker@konsulko.com>
Received: from alpha.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id y16sm5282636wrp.78.2021.04.29.07.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 07:11:27 -0700 (PDT)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [PATCH 2/4] prserv: Extract daemonization from PRServer class
Date: Thu, 29 Apr 2021 15:11:11 +0100
Message-Id: <20210429141113.27974-3-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210429141113.27974-1-pbarker@konsulko.com>
References: <20210429141113.27974-1-pbarker@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code to start the prservice process as a daemon is extracted out of
the PRServer class and simplified. This makes the PRServer class easier
to modernise as it no longer needs to worry about process management.

Signed-off-by: Paul Barker <pbarker@konsulko.com>
---
 lib/prserv/serv.py | 175 +++++++++++++++++++--------------------------
 1 file changed, 72 insertions(+), 103 deletions(-)

diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index 5d6520da8..24a8c4bac 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -34,7 +34,7 @@ singleton = None
 
 
 class PRServer(SimpleXMLRPCServer):
-    def __init__(self, dbfile, logfile, interface, daemon=True):
+    def __init__(self, dbfile, logfile, interface):
         ''' constructor '''
         try:
             SimpleXMLRPCServer.__init__(self, interface,
@@ -47,7 +47,6 @@ class PRServer(SimpleXMLRPCServer):
             raise PRServiceConfigError
 
         self.dbfile=dbfile
-        self.daemon=daemon
         self.logfile=logfile
         self.working_thread=None
         self.host, self.port = self.socket.getsockname()
@@ -176,106 +175,6 @@ class PRServer(SimpleXMLRPCServer):
         os.close(self.quitpipein)
         return
 
-    def start(self):
-        if self.daemon:
-            pid = self.daemonize()
-        else:
-            pid = self.fork()
-            self.pid = pid
-
-        # Ensure both the parent sees this and the child from the work_forever log entry above
-        logger.info("Started PRServer with DBfile: %s, IP: %s, PORT: %s, PID: %s" %
-                     (self.dbfile, self.host, self.port, str(pid)))
-
-    def delpid(self):
-        os.remove(self.pidfile)
-
-    def daemonize(self):
-        """
-        See Advanced Programming in the UNIX, Sec 13.3
-        """
-        try:
-            pid = os.fork()
-            if pid > 0:
-                os.waitpid(pid, 0)
-                #parent return instead of exit to give control 
-                return pid
-        except OSError as e:
-            raise Exception("%s [%d]" % (e.strerror, e.errno))
-
-        os.setsid()
-        """
-        fork again to make sure the daemon is not session leader, 
-        which prevents it from acquiring controlling terminal
-        """
-        try:
-            pid = os.fork()
-            if pid > 0: #parent
-                os._exit(0)
-        except OSError as e:
-            raise Exception("%s [%d]" % (e.strerror, e.errno))
-
-        self.cleanup_handles()
-        os._exit(0)
-
-    def fork(self):
-        try:
-            pid = os.fork()
-            if pid > 0:
-                self.socket.close() # avoid ResourceWarning in parent
-                return pid
-        except OSError as e:
-            raise Exception("%s [%d]" % (e.strerror, e.errno))
-
-        bb.utils.signal_on_parent_exit("SIGTERM")
-        self.cleanup_handles()
-        os._exit(0)
-
-    def cleanup_handles(self):
-        os.chdir("/")
-
-        sys.stdout.flush()
-        sys.stderr.flush()
-
-        # We could be called from a python thread with io.StringIO as
-        # stdout/stderr or it could be 'real' unix fd forking where we need
-        # to physically close the fds to prevent the program launching us from
-        # potentially hanging on a pipe. Handle both cases.
-        si = open('/dev/null', 'r')
-        try:
-            os.dup2(si.fileno(),sys.stdin.fileno())
-        except (AttributeError, io.UnsupportedOperation):
-            sys.stdin = si
-        so = open(self.logfile, 'a+')
-        try:
-            os.dup2(so.fileno(),sys.stdout.fileno())
-        except (AttributeError, io.UnsupportedOperation):
-            sys.stdout = so
-        try:
-            os.dup2(so.fileno(),sys.stderr.fileno())
-        except (AttributeError, io.UnsupportedOperation):
-            sys.stderr = so
-
-        # Clear out all log handlers prior to the fork() to avoid calling
-        # event handlers not part of the PRserver
-        for logger_iter in logging.Logger.manager.loggerDict.keys():
-            logging.getLogger(logger_iter).handlers = []
-
-        # Ensure logging makes it to the logfile
-        streamhandler = logging.StreamHandler()
-        streamhandler.setLevel(logging.DEBUG)
-        formatter = bb.msg.BBLogFormatter("%(levelname)s: %(message)s")
-        streamhandler.setFormatter(formatter)
-        logger.addHandler(streamhandler)
-
-        # write pidfile
-        pid = str(os.getpid())
-        with open(self.pidfile, 'w') as pf:
-            pf.write("%s\n" % pid)
-
-        self.work_forever()
-        self.delpid()
-
 class PRServSingleton(object):
     def __init__(self, dbfile, logfile, interface):
         self.dbfile = dbfile
@@ -324,6 +223,76 @@ class PRServerConnection(object):
     def getinfo(self):
         return self.host, self.port
 
+def run_as_daemon(func, pidfile, logfile):
+    """
+    See Advanced Programming in the UNIX, Sec 13.3
+    """
+    try:
+        pid = os.fork()
+        if pid > 0:
+            os.waitpid(pid, 0)
+            #parent return instead of exit to give control
+            return pid
+    except OSError as e:
+        raise Exception("%s [%d]" % (e.strerror, e.errno))
+
+    os.setsid()
+    """
+    fork again to make sure the daemon is not session leader,
+    which prevents it from acquiring controlling terminal
+    """
+    try:
+        pid = os.fork()
+        if pid > 0: #parent
+            os._exit(0)
+    except OSError as e:
+        raise Exception("%s [%d]" % (e.strerror, e.errno))
+
+    os.chdir("/")
+
+    sys.stdout.flush()
+    sys.stderr.flush()
+
+    # We could be called from a python thread with io.StringIO as
+    # stdout/stderr or it could be 'real' unix fd forking where we need
+    # to physically close the fds to prevent the program launching us from
+    # potentially hanging on a pipe. Handle both cases.
+    si = open('/dev/null', 'r')
+    try:
+        os.dup2(si.fileno(),sys.stdin.fileno())
+    except (AttributeError, io.UnsupportedOperation):
+        sys.stdin = si
+    so = open(logfile, 'a+')
+    try:
+        os.dup2(so.fileno(),sys.stdout.fileno())
+    except (AttributeError, io.UnsupportedOperation):
+        sys.stdout = so
+    try:
+        os.dup2(so.fileno(),sys.stderr.fileno())
+    except (AttributeError, io.UnsupportedOperation):
+        sys.stderr = so
+
+    # Clear out all log handlers prior to the fork() to avoid calling
+    # event handlers not part of the PRserver
+    for logger_iter in logging.Logger.manager.loggerDict.keys():
+        logging.getLogger(logger_iter).handlers = []
+
+    # Ensure logging makes it to the logfile
+    streamhandler = logging.StreamHandler()
+    streamhandler.setLevel(logging.DEBUG)
+    formatter = bb.msg.BBLogFormatter("%(levelname)s: %(message)s")
+    streamhandler.setFormatter(formatter)
+    logger.addHandler(streamhandler)
+
+    # write pidfile
+    pid = str(os.getpid())
+    with open(pidfile, 'w') as pf:
+        pf.write("%s\n" % pid)
+
+    func()
+    os.remove(pidfile)
+    os._exit(0)
+
 def start_daemon(dbfile, host, port, logfile):
     ip = socket.gethostbyname(host)
     pidfile = PIDPREFIX % (ip, port)
@@ -339,7 +308,7 @@ def start_daemon(dbfile, host, port, logfile):
         return 1
 
     server = PRServer(os.path.abspath(dbfile), os.path.abspath(logfile), (ip,port))
-    server.start()
+    run_as_daemon(server.work_forever, pidfile, os.path.abspath(logfile))
 
     # Sometimes, the port (i.e. localhost:0) indicated by the user does not match with
     # the one the server actually is listening, so at least warn the user about it
-- 
2.26.2

