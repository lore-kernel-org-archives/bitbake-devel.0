Return-Path: <ross.burton@intel.com>
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
	by mail.openembedded.org (Postfix) with ESMTP id 28C4C60017
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Jan 2016 16:25:07 +0000 (UTC)
Received: by mail-wm0-f52.google.com with SMTP id b14so83068135wmb.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Jan 2016 08:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id;
	bh=T5SiBJMK/Bvg0ClFvis438Vt8YxiwHuBXVrXhc0elhg=;
	b=ylF+qjyi1w8obuVaeNOI7ZZywUwDC4WeOKgeh8I7Ru51KWXV6psb7Ho6LiYprA7XPC
	qiKE72iMRKE+1wuQ/PyEnCOtSphmXajpNV6vJ98HBf4pHPHBs8JMjNh70MzzD+KNplKP
	Phi1VdEBoGupBigECjZ0m4tW7NNatz5bMvbXUJBUeb1R8KQYk/ro9CX32AoinD+xLz+L
	Cx0JdrFRiGcKWsc9PqT7SkInVOT4uqvMeEF5C+ChxmuPTsWVrXay+Sy3PNQZ6gw4+y5v
	yam/z+MDGQ1GFlSySl5EVOWNkeCDyf9Z7ZETnuGTMsNHYQ+kcVzDyHpzvuGNvGeFl5ke
	cpCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=T5SiBJMK/Bvg0ClFvis438Vt8YxiwHuBXVrXhc0elhg=;
	b=S5mw5Wi1RT9Xdfe12cCdajfZnSDb81t9qQqB7v7yEh2bXn90cLf+4ev95DEUhOK1Ub
	a2bUlE9X+/ag23dfCz3q+lHZUt7Z6kMnEWzfDxOXURcUcwfmEiEOXYFiKQqJReVk0Pvj
	5Xk/zqXhaO1ilhuoJDJi6dY4Z1NoTD+WzsrVX4yKCr5LANjOTnea4jYLUAWfFRtAaNbf
	GM6nsRyRm/gdOD0PfMHKKEFMMbKyboAIomJ1vEMoIRu+O3N7Ce7HFtuyioKBAxyH8iYc
	aR9OXdVmTk/DBqCktL6RY3rQ7sDUjpb/0Lzsjj2e9TkiTlShuY4VCFQ1hbcrnLenZao+
	+sBA==
X-Gm-Message-State: ALoCoQkRS3zu2sybZJbx+tT3/NVBMZTLGcCoXfbJyzezzX4s3vQTdJgdcCHhy5MWFE4aWHOtqkvkyZI4+CZNBWfhznPzRadEXA==
X-Received: by 10.194.86.166 with SMTP id q6mr85772351wjz.69.1452097507185;
	Wed, 06 Jan 2016 08:25:07 -0800 (PST)
Received: from flashheart.burtonini.com (35.106.2.81.in-addr.arpa.
	[81.2.106.35]) by smtp.gmail.com with ESMTPSA id
	x10sm62475514wjx.8.2016.01.06.08.25.06
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 06 Jan 2016 08:25:06 -0800 (PST)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Jan 2016 16:25:00 +0000
Message-Id: <1452097500-18426-1-git-send-email-ross.burton@intel.com>
X-Mailer: git-send-email 2.6.4
Subject: [PATCH][RFC] bitbake-worker: set the process name when starting a task
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
X-List-Received-Date: Wed, 06 Jan 2016 16:25:09 -0000

If the setproctitle module is present then use it to change the process name
when the worker starts a task.  This results in each worker showing what task it
is executing in a process listing.

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/bin/bitbake-worker | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
index 3390f63..15b0f10 100755
--- a/bitbake/bin/bitbake-worker
+++ b/bitbake/bin/bitbake-worker
@@ -371,6 +371,12 @@ class BitbakeWorker(object):
         fn, task, taskname, quieterrors, appends, taskdepdata = pickle.loads(data)
         workerlog_write("Handling runtask %s %s %s\n" % (task, fn, taskname))
 
+        try:
+            import setproctitle
+            setproctitle.setproctitle("bitbake-worker: %s:%s" % (os.path.basename(fn), taskname))
+        except ImportError:
+            pass
+
         pid, pipein, pipeout = fork_off_task(self.cookercfg, self.data, self.workerdata, fn, task, taskname, appends, taskdepdata, quieterrors)
 
         self.build_pids[pid] = task
-- 
2.6.4


