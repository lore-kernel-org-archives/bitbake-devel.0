Return-Path: <i.efimov@inango-systems.com>
X-Greylist: delayed 545 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 05 Nov 2019 14:16:51 UTC
Received: from mail.inango-sw.com (mail.inango-systems.com [213.136.71.184])
	by mail.openembedded.org (Postfix) with ESMTP id 8532B7CBDF
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  5 Nov 2019 14:16:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mail.inango-sw.com (Postfix) with ESMTP id D2B907A249C
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  5 Nov 2019 16:07:46 +0200 (IST)
Received: from mail.inango-sw.com ([127.0.0.1])
	by localhost (mail.inango-sw.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 05LsQzUJVn4O; Tue,  5 Nov 2019 16:07:44 +0200 (IST)
Received: from localhost (localhost [127.0.0.1])
	by mail.inango-sw.com (Postfix) with ESMTP id E5AB27A2491;
	Tue,  5 Nov 2019 16:07:43 +0200 (IST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.inango-sw.com E5AB27A2491
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inango-systems.com;
	s=45A440E0-D841-11E8-B985-5FCC721607E0; t=1572962863;
	bh=W6Y8Icw+kVs/YFqoFYHtNUC4Cj34PZhxEI+gNng01os=;
	h=From:To:Date:Message-Id;
	b=XM0PCHoTeavpBoZCztzTF+2J0Pb1jgF/MxaPaPyn0Lcri5b3U1HoGQWR/5iItUS4k
	8gemWOwb2EmKrBT1p5B5+NfySAYE9bFXyOlx1iwT+wQPDkbFSkbBAkCn/WnBap1w2R
	tvI3LA9ogi0FL7ztZNS2RDFV/VxUkKUbiENhM1CIGr9uKmqD+rK03veME+isAk9xZu
	Yg0ROpfcBxW/Fdx4dBUcbYTuV+SvPGManOkQIr5pZludhw5kvVkUb4STBAkg+Pv4uN
	O0HxDcqH6lWKy0JUzG7WJWtlR+xrwfRd/lX2HeKtYEGL3QntmYlPFeImxiPXLDRUBm
	28F3fSUhJas2w==
X-Virus-Scanned: amavisd-new at inango-sw.com
Received: from mail.inango-sw.com ([127.0.0.1])
	by localhost (mail.inango-sw.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2IFuw84nHcGi; Tue,  5 Nov 2019 16:07:43 +0200 (IST)
Received: from ivane-1.inango.loc (unknown [194.60.247.123])
	by mail.inango-sw.com (Postfix) with ESMTPSA id 564A17A12C1;
	Tue,  5 Nov 2019 16:07:43 +0200 (IST)
From: Ivan Efimov <i.efimov@inango-systems.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  5 Nov 2019 19:07:35 +0500
Message-Id: <20191105140735.8204-1-i.efimov@inango-systems.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Wed, 06 Nov 2019 11:07:36 +0000
Subject: [1.32][PATCH] bitbake-worker child process create group before registering SIGTERM handler
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
X-List-Received-Date: Tue, 05 Nov 2019 14:16:52 -0000

The bitbake-worker child on the SIGTERM signal handling send the SIGTERM to all
processes in it's process group. In cases when the bitbake-worker child got
SIGTERM after registering own SIGTERM handler and before the os.setsid() call
it can send SIGTERM to unwanted processes.

In the worst case during SIGTERM processing the bitbake-worker child can be in
the group of the process that started BitBake itself. As a result it can kill
processes that not related to BitBake at all.

Signed-off-by: Ivan Efimov <i.efimov@inango-systems.com>
---
 bin/bitbake-worker | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index db3c4b18..6a12a31c 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -189,9 +189,6 @@ def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, append
             global worker_pipe_lock
             pipein.close()
 
-            signal.signal(signal.SIGTERM, sigterm_handler)
-            # Let SIGHUP exit as SIGTERM
-            signal.signal(signal.SIGHUP, sigterm_handler)
             bb.utils.signal_on_parent_exit("SIGTERM")
 
             # Save out the PID so that the event can include it the
@@ -206,6 +203,11 @@ def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, append
             # This ensures signals sent to the controlling terminal like Ctrl+C
             # don't stop the child processes.
             os.setsid()
+
+            signal.signal(signal.SIGTERM, sigterm_handler)
+            # Let SIGHUP exit as SIGTERM
+            signal.signal(signal.SIGHUP, sigterm_handler)
+
             # No stdin
             newsi = os.open(os.devnull, os.O_RDWR)
             os.dup2(newsi, sys.stdin.fileno())
-- 
2.17.1


