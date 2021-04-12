Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web12.31213.1618227723078556335
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Apr 2021 04:42:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=lF4e8IeR;
 spf=pass (domain: konsulko.com, ip: 209.85.128.42, mailfrom: pbarker@konsulko.com)
Received: by mail-wm1-f42.google.com with SMTP id k128so6609083wmk.4
        for <bitbake-devel@lists.openembedded.org>; Mon, 12 Apr 2021 04:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r01aWa9994X8fWktihsK75f8b+9wTBxbyF57VOvNDC4=;
        b=lF4e8IeRhivcpasiMpuDXW3jgZsQRYWYoQMCx8Gs0AZpWbbEeSmcdzYSmU+wg2taT6
         l2aEqlOfYShB1iJUd8ZcspIaACY9j2IwgljK+lDBjHdCQm9KxX3n8MhZjfbUTted4RS2
         jwG6/JzM6hmKjxMKPDi2YPRcNHgeK9FILek78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r01aWa9994X8fWktihsK75f8b+9wTBxbyF57VOvNDC4=;
        b=ICm4kRN7oa4QhuNnctLjon32Y9/kQlh6YqbPGWS2aKzAyVXiNb7duO6hgfz6LTt+Pe
         iVXoxIQvyx3yGsKaqs9l1rT8DOVw+jY4Zw0uaQ0AlY53ZkXkO/KyKkarAM8xiKV+1pUZ
         2pca3b8uNSGInopnNbzSvcxbtMYhOnPBsDyAZO8Y8U9woKfmLQ/n4DQmq2sOtZa260TC
         3gT6Ft3ERySU5Id8cpAkKAlPVMZVgJWi0v9gwTc9TCYWxvMOY+zCSl4PMYoKWz4MNRN3
         DTZo+BdYNNrfSCIC6zeHLhMFp4o8PAhL4IRxX2Xa5+SzZdOQXMcw2r7OiFTHZtmZMVxY
         0EKQ==
X-Gm-Message-State: AOAM533RQo3WRo+xqrqKLu+K3YeA/GAwlUUTZBHircE4joP/DubBYrDN
	Rkm6TlnBqBlpy8vHmFtKLNsp99j25S5Dxg==
X-Google-Smtp-Source: ABdhPJxbikQKvZanG2lFI24oG8ethndctlhezGyZY1Ig/OP9UlleVP+zmQNR8lz8KSABYiPa1PxI5A==
X-Received: by 2002:a05:600c:224e:: with SMTP id a14mr26176674wmm.57.1618227721499;
        Mon, 12 Apr 2021 04:42:01 -0700 (PDT)
Return-Path: <pbarker@konsulko.com>
Received: from alpha.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id 3sm17931294wma.45.2021.04.12.04.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 04:42:01 -0700 (PDT)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [RFC PATCH 06/11] prserv: Use multiprocessing to auto start prserver
Date: Mon, 12 Apr 2021 12:41:44 +0100
Message-Id: <20210412114149.4750-7-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210412114149.4750-1-pbarker@konsulko.com>
References: <20210412114149.4750-1-pbarker@konsulko.com>
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
index 1cfbba864..d58b859d8 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -15,6 +15,7 @@ import prserv
 import prserv.db
 import errno
 import select
+import multiprocessing
 
 logger = logging.getLogger("BitBake.PRserv")
 
@@ -170,6 +171,9 @@ class PRServer(SimpleXMLRPCServer):
         # if there is data there.
         self.timeout = 0.01
 
+        signal.signal(signal.SIGINT, self.sigint_handler)
+        signal.signal(signal.SIGTERM, self.sigterm_handler)
+
         bb.utils.set_process_name("PRServ")
 
         # DB connection must be created after all forks
@@ -249,8 +253,6 @@ class PRServer(SimpleXMLRPCServer):
         os._exit(0)
 
     def cleanup_handles(self):
-        signal.signal(signal.SIGINT, self.sigint_handler)
-        signal.signal(signal.SIGTERM, self.sigterm_handler)
         os.chdir("/")
 
         sys.stdout.flush()
@@ -304,8 +306,10 @@ class PRServSingleton(object):
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

