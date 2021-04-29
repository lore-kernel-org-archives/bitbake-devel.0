Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web11.7453.1619705488756852613
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 29 Apr 2021 07:11:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=qIe5K6FN;
 spf=pass (domain: konsulko.com, ip: 209.85.128.54, mailfrom: pbarker@konsulko.com)
Received: by mail-wm1-f54.google.com with SMTP id n84so8764954wma.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 29 Apr 2021 07:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gjIEfXTQJLl3M7TZ+iIratMCsBsUQNRl1L0Zw4R3w5Q=;
        b=qIe5K6FNmB+1essA86mdtuCblMYKK0baLPR2laM2TABohsFOtkUXE+nM3Ss0JWaDlX
         8rM27/masgRbgTuSfQU9cnx49+r0RsJPzgy6hvSVQl9XiVhP/+DMiYAywUBQPahWN1Ku
         osp+ayF+ZslvMhGhIbQ+fppwwMPB52Ax+pW/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gjIEfXTQJLl3M7TZ+iIratMCsBsUQNRl1L0Zw4R3w5Q=;
        b=htd3RH9+NWuVDBQ1VhLVAEeHDRmSidIfkzV0pA3Fzgjd1Jc/r4JigNUXwMLtWtZ5Va
         Ncvf1KgZHCgLE7uM+grQZLX+C4GodES3ZDVPphE/IuG6KecFGu6ByAIzh9PZsJr+wCXL
         hgdb9iSEulvkDTvpu/SdZktohg4nPzr0sPOLLD0PBGTmR/EBTfyOqMkqB7SKHFbgfGh7
         mLvZVmVskOjgJZotgy91ryGdojH8ELnqRbXwGv+8LlSmlTETjZAw+o4UcDvC0gV+q5R0
         EeZ5iF5fwiXg1lMLqDWXKtTKPl6x2MjZnfm0c9XyTnBb6otIlayaU5O5iPVMpUeyiqt2
         JjNw==
X-Gm-Message-State: AOAM532xNARNOC4i19JfGVLo8Oidok0Vi+BfeMnis7zxATuRLnRVFAd8
	Mvlsj84UnM6VUZPr40/7UknhFrGR6gmewQ==
X-Google-Smtp-Source: ABdhPJxAs0gsapFR+1NkkBwL+x9NU/8Vd3Gt1z3OVgVAzwrFZbov2G4c2IGRAwiOBxiRd4jbKKLJjw==
X-Received: by 2002:a7b:cc83:: with SMTP id p3mr195218wma.170.1619705487019;
        Thu, 29 Apr 2021 07:11:27 -0700 (PDT)
Return-Path: <pbarker@konsulko.com>
Received: from alpha.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id y16sm5282636wrp.78.2021.04.29.07.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 07:11:26 -0700 (PDT)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [PATCH 1/4] prserv: Use multiprocessing to auto start prserver
Date: Thu, 29 Apr 2021 15:11:10 +0100
Message-Id: <20210429141113.27974-2-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210429141113.27974-1-pbarker@konsulko.com>
References: <20210429141113.27974-1-pbarker@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can use the modern multiprocessing support in Python instead of
manually using fork to start the prserver process. To do this we need
to set up the signal handlers for the prserver process in the
work_forever function (which is now used as the main function for this
process).

The old code to start the prserver process using fork is not removed in
this commit as it is tightly intertwined with the daemonization code
which will be refactored in a following commit.

Signed-off-by: Paul Barker <pbarker@konsulko.com>
---
 lib/prserv/serv.py | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index 4375d3e59..5d6520da8 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -15,6 +15,7 @@ import prserv
 import prserv.db
 import errno
 import select
+import multiprocessing
 
 logger = logging.getLogger("BitBake.PRserv")
 
@@ -149,6 +150,9 @@ class PRServer(SimpleXMLRPCServer):
         # if there is data there.
         self.timeout = 0.01
 
+        signal.signal(signal.SIGINT, self.sigint_handler)
+        signal.signal(signal.SIGTERM, self.sigterm_handler)
+
         bb.utils.set_process_name("PRServ")
 
         # DB connection must be created after all forks
@@ -228,8 +232,6 @@ class PRServer(SimpleXMLRPCServer):
         os._exit(0)
 
     def cleanup_handles(self):
-        signal.signal(signal.SIGINT, self.sigint_handler)
-        signal.signal(signal.SIGTERM, self.sigterm_handler)
         os.chdir("/")
 
         sys.stdout.flush()
@@ -283,8 +285,10 @@ class PRServSingleton(object):
         self.port = None
 
     def start(self):
-        self.prserv = PRServer(self.dbfile, self.logfile, self.interface, daemon=False)
-        self.prserv.start()
+        self.prserv = PRServer(self.dbfile, self.logfile, self.interface)
+        self.process = multiprocessing.Process(target=self.prserv.work_forever)
+        self.process.start()
+
         self.host, self.port = self.prserv.getinfo()
 
     def getinfo(self):
-- 
2.26.2

