Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
 by mx.groups.io with SMTP id smtpd.web10.1091.1598288022806143083
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Aug 2020 09:53:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=dLCfCDgJ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.66, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f66.google.com with SMTP id a65so5492387wme.5
        for <bitbake-devel@lists.openembedded.org>; Mon, 24 Aug 2020 09:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mBqKiVZKynmAotZurP4sUJPj7vENFl/QzQpKpfUEojY=;
        b=dLCfCDgJPydZp/y68GgzsQjmdQqGeG0+HV7HNYwEluiLgXmkuFwGNy7T6nlpby+PKy
         bi0KcljeJOZUNYfsF+pTepiTPtxLdnorlUpPUzwfYcCzeLlGln7dZcVCe/jNdPas6HtO
         htuMoez9E2X4TxN3sgfta0jOnxRltE9n9TvVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mBqKiVZKynmAotZurP4sUJPj7vENFl/QzQpKpfUEojY=;
        b=HALpFGUzNBbcixuHBB7UBIJNoIVgsEda+m0wQIC1por1XAT9X+NQsNsS63474N09Is
         dD9phpEQN5WcjutGXbi1//AGSpplWTyvdcW8KGMyWvidsVP1uj2RltHDd9kJvaNTmD6w
         F0e75R/fldT9IBniy0D7PIDFg7cm2eyud4yHuV3tlbNKM2UUi/6mCsjLjDhfApvowzwr
         5oB8GrQU4KjV4IfKI1eYg+XY6XZZivLaRUrofadoMybWfssruH6VeA2a9P1BIjk9alO+
         ksF811P7WNJ02xeKGhK/ayByWLBM5/YubAKTZ4vMCxq6SlBE42gzRhr5AUN8WAKUHYAT
         K+CQ==
X-Gm-Message-State: AOAM533ZoVKg5WL4RAQqUqPDRDjaAWWMVlWk6bY5i6KL0pNb+NubXLrw
	aref4AtLXb3SEajCJEQfF0+V5gFYPNbcImDY
X-Google-Smtp-Source: ABdhPJyr+b6QlSPu/WYzoqRLqW9Dtas+d0ydEocp/r4oEwDksVAdp+YSbQ3m5Zvy1GDylDzVcGBHhw==
X-Received: by 2002:a1c:492:: with SMTP id 140mr159696wme.97.1598288016960;
        Mon, 24 Aug 2020 09:53:36 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (d.d.0.9.8.0.3.8.5.d.6.d.5.a.5.4.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:45a5:d6d5:8308:90dd])
        by smtp.gmail.com with ESMTPSA id f19sm182127wmh.44.2020.08.24.09.53.36
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 09:53:36 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 06/10] server/process: Move the socket code to server process only
Date: Mon, 24 Aug 2020 17:53:27 +0100
Message-Id: <20200824165331.1373725-6-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824165331.1373725-1-richard.purdie@linuxfoundation.org>
References: <20200824165331.1373725-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sock object isn't used client side so we can just created it in
the server process and save passing around the fd/object.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index b037e0fb6c..8f5abb32bf 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -402,27 +402,11 @@ class BitBakeServer(object):
         self.bitbake_lock = lock
         self.readypipe, self.readypipein = os.pipe()
 
-        # Create server control socket
-        if os.path.exists(sockname):
-            os.unlink(sockname)
-
         # Place the log in the builddirectory alongside the lock file
         logfile = os.path.join(os.path.dirname(self.bitbake_lock.name), "bitbake-cookerdaemon.log")
 
-        self.sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
-        # AF_UNIX has path length issues so chdir here to workaround
-        cwd = os.getcwd()
-        try:
-            os.chdir(os.path.dirname(sockname))
-            self.sock.bind(os.path.basename(sockname))
-        finally:
-            os.chdir(cwd)
-        self.sock.listen(1)
-
-        os.set_inheritable(self.sock.fileno(), True)
         startdatetime = datetime.datetime.now()
         bb.daemonize.createDaemon(self._startServer, logfile)
-        self.sock.close()
         self.bitbake_lock.close()
         os.close(self.readypipein)
 
@@ -478,7 +462,21 @@ class BitBakeServer(object):
         sys.stdout.flush()
 
         try:
-            server = ProcessServer(self.bitbake_lock, self.sock, self.sockname, self.configuration.server_timeout, self.configuration.xmlrpcinterface)
+            # Create server control socket
+            if os.path.exists(self.sockname):
+                os.unlink(self.sockname)
+
+            sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
+            # AF_UNIX has path length issues so chdir here to workaround
+            cwd = os.getcwd()
+            try:
+                os.chdir(os.path.dirname(self.sockname))
+                sock.bind(os.path.basename(self.sockname))
+            finally:
+                os.chdir(cwd)
+            sock.listen(1)
+
+            server = ProcessServer(self.bitbake_lock, sock, self.sockname, self.configuration.server_timeout, self.configuration.xmlrpcinterface)
             os.close(self.readypipe)
             writer = ConnectionWriter(self.readypipein)
             try:
-- 
2.25.1

