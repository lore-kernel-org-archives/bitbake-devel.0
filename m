Return-Path: <patrick.ohly@intel.com>
Received: from mail-io0-f171.google.com (mail-io0-f171.google.com
	[209.85.223.171])
	by mail.openembedded.org (Postfix) with ESMTP id 6F12F71B17
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Nov 2016 15:15:21 +0000 (UTC)
Received: by mail-io0-f171.google.com with SMTP id m5so96717090ioe.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Nov 2016 07:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=E4HCr+Y3blD+dsrqtfXgGXEM+lU9XTdKwPjZzSxACU4=;
	b=JjkbXEXiI3D93d9GbHHwmr21jYtwLoV5zLjJi232MEnWSGA1k6ckalC6Wj2qdzKlbJ
	0xuNUYzvILXBSkhqerdJaqkTHwzFjFmitH5+jRHcVt5zNsGL+C/X66fgl94a8BmN9fa8
	PaSwT0W+MlV50CbsvcjrOWcfqyeHFQ40tY9pz0oy1u/6JJ/SNGeLuJK5pGazPnjQSoL5
	mx8S2xR0Q7qynqA3HXWWroGYPhQ8LGDQuc3EL4X0XOwWV/+VP+m+ZbbDsgj/7OAd9rEP
	L8gTGP6UJ1UTN28uQSbhOqutge2qkvdGAxQhXPBRzat2I2D/g16PK3SqkwcWQgRZXes8
	d6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=E4HCr+Y3blD+dsrqtfXgGXEM+lU9XTdKwPjZzSxACU4=;
	b=PzbLLZuBxsXJGjLSPf0qmnrMu4/cpogkolrg3sshq4DYd5n5tmazUtP8CAu/2ojP/E
	stYOC7kRJfIZo92OKD7UZg/gxWI04musQZP5DCY4Lwl8lThzJ0bhw3j4UQCuhj1/uTj6
	OEXdgtTt1GzYfPrayPwp/43osluAtb8YIR/UHeTsPu4yFPsqLYOIknH5y7NxUewD28lA
	fk8p7sEiZ0jQJUWo4/NJ2jp3LZiFurEVXPkKQnmAj3CkHAoekbVP8ysTONr78TEnpEbr
	wUL9VVyRfubJgmfBp0HHFteFhxalhjYgBuh8zUE/Ll6VISO3fV4cPXQTChjfzjtkwt/9
	x8wg==
X-Gm-Message-State: AKaTC01hAfi0GdkXhMB3qVe082ZBV+12eiU94QQphweFk1m9GofrTDSfm7gnjmQswrnFqkCg
X-Received: by 10.107.163.6 with SMTP id m6mr17305757ioe.106.1480346122959;
	Mon, 28 Nov 2016 07:15:22 -0800 (PST)
Received: from pohly-desktop.fritz.box (p5DE8C83A.dip0.t-ipconnect.de.
	[93.232.200.58]) by smtp.gmail.com with ESMTPSA id
	i75sm9364092itf.10.2016.11.28.07.15.21
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 28 Nov 2016 07:15:21 -0800 (PST)
From: Patrick Ohly <patrick.ohly@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 28 Nov 2016 16:15:11 +0100
Message-Id: <4a82fef918264b2e74022e8ed95cb198f44300c7.1480345719.git.patrick.ohly@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <90660fc75cc3fedceabef02ac2ade99d7c26fbb2.1480345719.git.patrick.ohly@intel.com>
References: <90660fc75cc3fedceabef02ac2ade99d7c26fbb2.1480345719.git.patrick.ohly@intel.com>
In-Reply-To: <cover.1480345719.git.patrick.ohly@intel.com>
References: <cover.1480345719.git.patrick.ohly@intel.com>
Subject: [PATCH 2/4] runqueue.py: monitor disk space at regular time intervals
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
X-List-Received-Date: Mon, 28 Nov 2016 15:15:23 -0000

Hooking the disk monitor into the regular heatbeat event instead
of the runqueue solves two problems:

- When there is just one long running task which fills up the disk,
  the previous approach did not notice that until after the completion
  of the task because _execute_runqueue() only gets called on task
  state changes. As a result, aborting a build did not work in this
  case.

- When there are many short-lived tasks, disk space was getting
  checked very frequently. When the storage that is getting checked
  is on an NFS server, that can lead to noticable traffic to the
  server.

Signed-off-by: Patrick Ohly <patrick.ohly@intel.com>
---
 lib/bb/runqueue.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 84b2685..3772e2e 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -984,7 +984,12 @@ class RunQueue:
         self.state = runQueuePrepare
 
         # For disk space monitor
+        # Invoked at regular time intervals via the bitbake heartbeat event
+        # while the build is running.
         self.dm = monitordisk.diskMonitor(cfgData)
+        bb.event.register('_bb_diskmonitor',
+                          lambda x: self.dm.check(self) if self.state in [runQueueSceneRun, runQueueRunning, runQueueCleanUp] else False,
+                          ('bb.event.HeartbeatEvent',))
 
         self.rqexe = None
         self.worker = {}
@@ -1208,9 +1213,6 @@ class RunQueue:
                 self.rqdata.init_progress_reporter.next_stage()
                 self.rqexe = RunQueueExecuteScenequeue(self)
 
-        if self.state in [runQueueSceneRun, runQueueRunning, runQueueCleanUp]:
-            self.dm.check(self)
-
         if self.state is runQueueSceneRun:
             retval = self.rqexe.execute()
 
-- 
2.1.4


