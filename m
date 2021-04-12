Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web10.31091.1618227723915166177
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Apr 2021 04:42:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=GNH8rs5m;
 spf=pass (domain: konsulko.com, ip: 209.85.128.46, mailfrom: pbarker@konsulko.com)
Received: by mail-wm1-f46.google.com with SMTP id 5-20020a05600c0245b029011a8273f85eso6694241wmj.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 12 Apr 2021 04:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tuwUS8/glp9KT6ef7llHOthziI0CFbWuNXwn82WaFZQ=;
        b=GNH8rs5mHQpf83Nbv8P6dXKcXpDmlwYIXPwcYuSzH7JUbIF9pKpH2yBNIv10sTDTYj
         QwElD3kr2zWpj+2CStVNmaEB7dL1tOqigBAw0oXtLPFpmIiH2Kktksism0ZsHB5/uSzP
         gB0eSlHyvIyRvR/UUi7Prhc8g/NVXpyJASOFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tuwUS8/glp9KT6ef7llHOthziI0CFbWuNXwn82WaFZQ=;
        b=cAG/ffgPTGiaxI3AT+86Xzyfknu8r4pn6Yf8BDIUXxcbVpQwM/XLfq855WoRD/+ffJ
         hKX0CMM1r56kBT5rPzS7dUPtk+AiVqEm2tQjfE8oRE4iHKKZ82ta9neLks2o8YEIEeut
         5ddW/38pW0SPaD0N8n/4C+GGGni4Lr3gt/LL93hJURBkshiRJqikQiYIjG0BTyt2jSDR
         UBzI5j+8DorE+QbGTkbdkesUt6qZxoUPIzRHXusqbf/2MaIjjo839p2TvrzjRKSMRHGd
         FhY083WR4guhXmnZYOTfyFjRwUjCz1KgVn4GdJFWI+JH+ZMLBcFTvEA9wl+y9lr8KZ3G
         vyWA==
X-Gm-Message-State: AOAM531NGxtlgcjF6FXnFuqKUiKMZZb+xIocTLLrbLDabm9MVgt9hYqV
	rpnEJDOiVHJgXANuSk7xWVcwdDE+YK/0yQ==
X-Google-Smtp-Source: ABdhPJxVqf8hcjmFXEViF95tF6AnOnbcYv3zWN1xFroaprTkS11ru8ag7jhe6dvidy4l3EMZBonSCA==
X-Received: by 2002:a05:600c:17c3:: with SMTP id y3mr7833605wmo.185.1618227722284;
        Mon, 12 Apr 2021 04:42:02 -0700 (PDT)
Return-Path: <pbarker@konsulko.com>
Received: from alpha.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id 3sm17931294wma.45.2021.04.12.04.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 04:42:01 -0700 (PDT)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [RFC PATCH 07/11] prserv: Extract daemonization from PRServer class
Date: Mon, 12 Apr 2021 12:41:45 +0100
Message-Id: <20210412114149.4750-8-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210412114149.4750-1-pbarker@konsulko.com>
References: <20210412114149.4750-1-pbarker@konsulko.com>
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
index d58b859d8..74bfdc1bb 100644
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
@@ -197,106 +196,6 @@ class PRServer(SimpleXMLRPCServer):
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
@@ -348,6 +247,76 @@ class PRServerConnection(object):
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
@@ -363,7 +332,7 @@ def start_daemon(dbfile, host, port, logfile):
         return 1
 
     server = PRServer(os.path.abspath(dbfile), os.path.abspath(logfile), (ip,port))
-    server.start()
+    run_as_daemon(server.work_forever, pidfile, os.path.abspath(logfile))
 
     # Sometimes, the port (i.e. localhost:0) indicated by the user does not match with
     # the one the server actually is listening, so at least warn the user about it
-- 
2.26.2

