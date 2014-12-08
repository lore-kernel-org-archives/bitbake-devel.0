Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 70BB6724B3
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Dec 2014 21:39:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	sB8LcfVK018314
	for <bitbake-devel@lists.openembedded.org>; Mon, 8 Dec 2014 21:38:41 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id jHSfxHuZUECk for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Dec 2014 21:38:41 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	sB8LcPoJ018298
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 8 Dec 2014 21:38:36 GMT
Message-ID: <1418074742.22903.30.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 08 Dec 2014 21:39:02 +0000
X-Mailer: Evolution 3.12.7-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] bitbake-worker: Use setsid() rather than setpgid()
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
X-List-Received-Date: Mon, 08 Dec 2014 21:39:18 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The bug has a long discussion of this. Basically, in some environments,
the exact details of which aren't understood, a Ctrl+C signal to the
UI is being transmitted to all the process children. Looking at the output
of "ps ax -O tpgid", its clear the main process is still the terminal
owner of these processes.

stty -a on a problematic system shows: "-ignbrk brkint"
and on a working system shows: "-ignbrk -brkint"

The description of brkint would suggest this is the problem, setting up
that terminal environment wasn't able to reproduce the problem though.
It was confirmed that using setsid() caused the problem to be resolved
and is probably the right thing to be doing anyway, so lets do it.

[YOCTO #6949]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
index 371c99a..8a24161 100755
--- a/bitbake/bin/bitbake-worker
+++ b/bitbake/bin/bitbake-worker
@@ -156,8 +156,11 @@ def fork_off_task(cfg, data, workerdata, fn, task, taskname, appends, taskdepdat
             bb.event.worker_fire = worker_child_fire
             worker_pipe = pipeout
 
-            # Make the child the process group leader
-            os.setpgid(0, 0)
+            # Make the child the process group leader and ensure no
+            # child process will be controlled by the current terminal
+            # This ensures signals sent to the controlling terminal like Ctrl+C
+            # don't stop the child processes.
+            os.setsid()
             # No stdin
             newsi = os.open(os.devnull, os.O_RDWR)
             os.dup2(newsi, sys.stdin.fileno())



