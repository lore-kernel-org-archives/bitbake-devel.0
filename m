Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com
	[209.85.166.48])
	by mail.openembedded.org (Postfix) with ESMTP id 3DE24798EA
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 22 Sep 2018 03:20:05 +0000 (UTC)
Received: by mail-io1-f48.google.com with SMTP id q5-v6so13917349iop.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 21 Sep 2018 20:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=ozRcsy6x5sP1KmG3i7TobSD0PqE2lG+n5zZ3qLVD7nU=;
	b=WXlgPaWwBYtj9ludQmuMMY22tPDRUomZ82awZB8G2lp94O41iytMGSz85+L1/oMO54
	6I+o1FLhoq1Hx4w12nNIltPVvcO0omOiaEjcHPac2wxY8lr0mbe1EUdoFwxoFur7Nw63
	4uKKeHP0SzOjBZwHS+L2UPyejrYWkPA9TL2b8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=ozRcsy6x5sP1KmG3i7TobSD0PqE2lG+n5zZ3qLVD7nU=;
	b=JZ/UMzrvcn7wIMfn3GNHGrwZ6LMmzgk2/rODtgCn4aUGy9WAyRdu2WSCpk6ZDmLSwP
	7YLqU6E+bKIfd8lPstDZ6BVJDjxsa2G/Wbn8Edi+/PUjhrL3FYXRaefDsWEfR12wLa7P
	DPlS+hwGwkDaXumdDgUYuq821A6YCKrgCBsqYwfz6BL/sFnerW5SWjhxuH+AwXU7u7Kn
	AB+KFzvIvUjTtAQKsebv1mk/6y1eJF7vhgAATEN7ptvYgbnMPNURiGfeQ+kQyvZfz+tN
	wHkkmQigDPGnN2dIK+ebTnaYFvrJISgwTDeE2NQ1wU2ktuEJ8ZaFJ6TQPeeQY92uTg8h
	2h4Q==
X-Gm-Message-State: ABuFfohTE8ZycYggZLlzgkMtkTAS6qG/Cw0/MaE5i+MUgY75G9Bj+YSi
	XclpvNP2cG38+AMIMxDWnJS1taH7E+oexg==
X-Google-Smtp-Source: ACcGV61Xw1w5pEqo0MJ+y6kLsGfpxKFuREUDzKMVM6bbuomuWv5CY4g3GQ4nIucS1Q6xwpYHetvnKA==
X-Received: by 2002:a6b:bd82:: with SMTP id
	n124-v6mr442474iof.244.1537586405527; 
	Fri, 21 Sep 2018 20:20:05 -0700 (PDT)
Received: from hex.int.rpsys.net ([209.82.80.116])
	by smtp.gmail.com with ESMTPSA id
	b195-v6sm3226232itc.42.2018.09.21.20.20.04
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 21 Sep 2018 20:20:04 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 21 Sep 2018 20:20:01 -0700
Message-Id: <20180922032001.19553-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180922032001.19553-1-richard.purdie@linuxfoundation.org>
References: <20180922032001.19553-1-richard.purdie@linuxfoundation.org>
Subject: [PATCH 2/2] daemonize/build: Clean up /dev/null fd handling
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
X-List-Received-Date: Sat, 22 Sep 2018 03:20:05 -0000

At the end of bitbake selftest we see:

sys:1: ResourceWarning: unclosed file <_io.TextIOWrapper name='/dev/null' mode='r+' encoding='UTF-8'>

Clean up the /dev/null handling to drop the unused entry in build.by and
ensure the other open() calls are cleaned up.

NULL was unused since http://git.yoctoproject.org/cgit.cgi/poky/commit/bitbake/lib/bb/build.py?id=4a081b5a52e3d27da8d4b062f3fda292e8d8fb0a
back in 2012.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/build.py     | 7 ++-----
 lib/bb/daemonize.py | 4 ++--
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index c79354b3f1..3e2a94edb1 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -41,8 +41,6 @@ from bb import data, event, utils
 bblogger = logging.getLogger('BitBake')
 logger = logging.getLogger('BitBake.Build')
 
-NULL = open(os.devnull, 'r+')
-
 __mtime_cache = {}
 
 def cached_mtime_noerror(f):
@@ -533,7 +531,6 @@ def _exec_task(fn, task, d, quieterr):
                 self.triggered = True
 
     # Handle logfiles
-    si = open('/dev/null', 'r')
     try:
         bb.utils.mkdirhier(os.path.dirname(logfn))
         logfile = open(logfn, 'w')
@@ -547,7 +544,8 @@ def _exec_task(fn, task, d, quieterr):
     ose = [os.dup(sys.stderr.fileno()), sys.stderr.fileno()]
 
     # Replace those fds with our own
-    os.dup2(si.fileno(), osi[1])
+    with open('/dev/null', 'r') as si:
+        os.dup2(si.fileno(), osi[1])
     os.dup2(logfile.fileno(), oso[1])
     os.dup2(logfile.fileno(), ose[1])
 
@@ -608,7 +606,6 @@ def _exec_task(fn, task, d, quieterr):
         os.close(osi[0])
         os.close(oso[0])
         os.close(ose[0])
-        si.close()
 
         logfile.close()
         if os.path.exists(logfn) and os.path.getsize(logfn) == 0:
diff --git a/lib/bb/daemonize.py b/lib/bb/daemonize.py
index 613fb35536..c937675eb6 100644
--- a/lib/bb/daemonize.py
+++ b/lib/bb/daemonize.py
@@ -65,8 +65,8 @@ def createDaemon(function, logfile):
     # The second child.
 
     # Replace standard fds with our own
-    si = open('/dev/null', 'r')
-    os.dup2(si.fileno(), sys.stdin.fileno())
+    with open('/dev/null', 'r') as si:
+        os.dup2(si.fileno(), sys.stdin.fileno())
 
     try:
         so = open(logfile, 'a+')
-- 
2.17.1


