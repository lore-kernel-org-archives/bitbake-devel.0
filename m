Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
	[209.85.220.52])
	by mail.openembedded.org (Postfix) with ESMTP id 00EC176710
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Sep 2015 02:38:42 +0000 (UTC)
Received: by pacfv12 with SMTP id fv12so144947974pac.2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 08 Sep 2015 19:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=oZDjC7hMroip8UzJvnzTocyGzN8WOqWD2n1vI6w37Mg=;
	b=h2031DOp8RpYs5hRk0mnGw8iRCEXTbgsbsV7T95Rym8UkiyKTicjvB9aI7AqzIL2pU
	4Va/pi9hHE/ZaRrmQIDuuVkkwXr/7gThDlcmVQ2xnWmjTyVh6CVdXaz2Ls1lHqVFwX+f
	jTvxiYP5BJ8t9d1rn5vOTby6/sjcfEU/H86NLSjP25ol0KCAeKuTTyHsMFKPpUPc1dGV
	g46v9TL11qBeqpzLcNPX1XAzC9Sh5TN81hPWu2TK4cn6CQgSQp8GWtFNrCgTRlilyZHu
	EkJYlu8BZ5izp+i3HnKllAd9UOxoy5rk0cXLnxB9rlaXKTrsOG9Om6U6Qvn/zpio+Xan
	pAsw==
X-Received: by 10.68.232.104 with SMTP id tn8mr64684853pbc.155.1441766323132; 
	Tue, 08 Sep 2015 19:38:43 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	y15sm4981385pbt.90.2015.09.08.19.38.42
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 08 Sep 2015 19:38:42 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  8 Sep 2015 19:39:44 -0700
Message-Id: <ca14f0260d3fbf82b35c631d2e6da52fc62d3397.1441766166.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1441766166.git.avery.brian@gmail.com>
References: <cover.1441766166.git.avery.brian@gmail.com>
Subject: [PATCH 1/1] toaster: increase waiting time
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
X-List-Received-Date: Wed, 09 Sep 2015 02:38:43 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Increased waiting time for toasterUI from 10 to 25 seconds. Bitbake
takes longer time to start, so toaster should wait longer.

[YOCTO #8240]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/bldcontrol/localhostbecontroller.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 231a7d3..a9909b8 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -140,7 +140,7 @@ class LocalhostBEController(BuildEnvironmentController):
 
         retries = 0
         started = False
-        while not started and retries < 10:
+        while not started and retries < 50:
             started = _toaster_ui_started(toaster_ui_log_filepath, toaster_ui_log_filelength)
             import time
             logger.debug("localhostbecontroller: Waiting bitbake server to start")
@@ -150,7 +150,7 @@ class LocalhostBEController(BuildEnvironmentController):
         if not started:
             toaster_ui_log = open(os.path.join(self.be.builddir, "toaster_ui.log"), "r").read()
             toaster_server_log = open(os.path.join(self.be.builddir, "toaster_server.log"), "r").read()
-            raise BuildSetupException("localhostbecontroller: Bitbake server did not start in 5 seconds, aborting (Error: '%s' '%s')" % (toaster_ui_log, toaster_server_log))
+            raise BuildSetupException("localhostbecontroller: Bitbake server did not start in 25 seconds, aborting (Error: '%s' '%s')" % (toaster_ui_log, toaster_server_log))
 
         logger.debug("localhostbecontroller: Started bitbake server")
 
-- 
1.9.1


