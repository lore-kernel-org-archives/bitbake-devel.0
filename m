Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f178.google.com (mail-wi0-f178.google.com
	[209.85.212.178])
	by mail.openembedded.org (Postfix) with ESMTP id D2282735CB
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Feb 2015 19:11:05 +0000 (UTC)
Received: by mail-wi0-f178.google.com with SMTP id em10so4398422wid.5
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Feb 2015 11:11:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=x0SKDzpNJWaSWXSTKL3eEqPFDWNeggDgiHJLczTCuTE=;
	b=FO6r29htRNJ6OUn2sDcH6zQYpOp340Sn6O9b+dwAuWZv/lx7yUh2ql8MDfcrZoJLLx
	ojxaatCOWa1YsohP9BX2ERaEcbZUEjhtKF3D/aDOna+36QiCWuVV65wX3kAp0ohHEy5y
	9YeUkPHfLCfOaL4D399RxdXmWHmhtd9TnhbbDfEfNeQk8k3vZPvwiKZMyaeJirOhYlpC
	XqJS/52552J5Ykb7nMl4YaEECGDY1+rjqrPjOAJUfipPeLRvWYho8cH+XvzgEdz5ybH3
	VeQ6EkUiZC9OheR9/Zuau7j/i3RwmEMyJk+b5nf8pUcxR/rHxErXCEFqvPYRoFC2ENbv
	yeOw==
X-Gm-Message-State: ALoCoQnMVZ6QZbnKd+WufR/I1kkWXsxV78v+0tyDv4EOuMjYIYipvaHy3FP2kx9HqnwKHqhjmcWW
X-Received: by 10.180.8.10 with SMTP id n10mr2829615wia.79.1424286666182;
	Wed, 18 Feb 2015 11:11:06 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	e18sm33937993wjz.27.2015.02.18.11.11.04
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 18 Feb 2015 11:11:05 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 432625605A7; Wed, 18 Feb 2015 19:11:07 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 18 Feb 2015 19:10:56 +0000
Message-Id: <6da36cbf5eeb30b8352c22aed3e0ede35705e13c.1424286571.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <fad80e36c9da663b000cdf2cb3c75440c6431d84.1424286571.git.alexandru.damian@intel.com>
References: <fad80e36c9da663b000cdf2cb3c75440c6431d84.1424286571.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1424286571.git.alexandru.damian@intel.com>
References: <cover.1424286571.git.alexandru.damian@intel.com>
Subject: [PATCH 02/10] toaster: properly detect starting in rolling log file
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 18 Feb 2015 19:11:10 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch brings in properly detection of system start in
a rolling toaster_ui log file.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/bldcontrol/localhostbecontroller.py | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 6bd019a..25ce052 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -107,6 +107,13 @@ class LocalhostBEController(BuildEnvironmentController):
 
         logger.debug("localhostbecontroller: running the listener at %s" % own_bitbake)
 
+        toaster_ui_log_filepath = os.path.join(self.be.builddir, "toaster_ui.log")
+        # get the file length; we need to detect the _last_ start of the toaster UI, not the first
+        toaster_ui_log_filelength = 0
+        if os.path.exists(toaster_ui_log_filepath):
+            with open(toaster_ui_log_filepath, "r") as f:
+                f.seek(0, 2)    # jump to the end
+                toaster_ui_log_filelength = f.tell()
 
         cmd = "bash -c \"source %s/oe-init-build-env %s && bitbake --read conf/toaster-pre.conf --postread conf/toaster.conf --server-only -t xmlrpc -B 0.0.0.0:0 >toaster_server.log && DATABASE_URL=%s BBSERVER=0.0.0.0:-1 daemon -d -i -D %s -o toaster_ui.log -- %s --observe-only -u toasterui &\"" % (self.pokydirname, self.be.builddir,
                 self.dburl, self.be.builddir, own_bitbake)
@@ -117,10 +124,11 @@ class LocalhostBEController(BuildEnvironmentController):
                 port = i.split(" ")[-1]
                 logger.debug("localhostbecontroller: Found bitbake server port %s" % port)
 
-        def _toaster_ui_started(filepath):
+        def _toaster_ui_started(filepath, filepos = 0):
             if not os.path.exists(filepath):
                 return False
             with open(filepath, "r") as f:
+                f.seek(filepos)
                 for line in f:
                     if line.startswith("NOTE: ToasterUI waiting for events"):
                         return True
@@ -129,7 +137,7 @@ class LocalhostBEController(BuildEnvironmentController):
         retries = 0
         started = False
         while not started and retries < 10:
-            started = _toaster_ui_started(os.path.join(self.be.builddir, "toaster_ui.log"))
+            started = _toaster_ui_started(toaster_ui_log_filepath, toaster_ui_log_filelength)
             import time
             logger.debug("localhostbecontroller: Waiting bitbake server to start")
             time.sleep(0.5)
-- 
1.9.1


