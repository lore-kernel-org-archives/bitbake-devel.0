Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 14415605BD
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 22 Sep 2014 14:52:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	s8MEq28I002433 for <bitbake-devel@lists.openembedded.org>;
	Mon, 22 Sep 2014 15:52:02 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id R_ZnemkFcsjZ for <bitbake-devel@lists.openembedded.org>;
	Mon, 22 Sep 2014 15:52:02 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	s8MEpukj002429
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 22 Sep 2014 15:51:57 +0100
Message-ID: <1411397519.15825.20.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 22 Sep 2014 15:51:59 +0100
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Subject: [PATCH] bitbake-worker: Fix bitbake -n
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
X-List-Received-Date: Mon, 22 Sep 2014 14:52:13 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Without this you see:

File "bitbake/bin/bitbake-worker", line 201, in fork_off_task
    os._exit(child())
TypeError: an integer is required

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
index b2935f6..dde2c9c 100755
--- a/bitbake/bin/bitbake-worker
+++ b/bitbake/bin/bitbake-worker
@@ -193,8 +193,9 @@ def fork_off_task(cfg, data, workerdata, fn, task, taskname, appends, taskdepdat
                     logger.critical(str(exc))
                 os._exit(1)
             try:
-                if not cfg.dry_run:
-                    return bb.build.exec_task(fn, taskname, the_data, cfg.profile)
+                if cfg.dry_run:
+                    return 0
+                return bb.build.exec_task(fn, taskname, the_data, cfg.profile)
             except:
                 os._exit(1)
         if not profiling:



