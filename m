Return-Path: <ross.burton@intel.com>
Received: from mail-qa0-f48.google.com (mail-qa0-f48.google.com
	[209.85.216.48])
	by mail.openembedded.org (Postfix) with ESMTP id CE7336E766
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 13 Mar 2014 16:35:55 +0000 (UTC)
Received: by mail-qa0-f48.google.com with SMTP id m5so1262026qaj.7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 13 Mar 2014 09:35:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to
	:content-type;
	bh=g2c0N86JcmBE79HZIybTMjA5EfTSaWapy2deG6EkMT4=;
	b=ZWcUnleAEoZLqRUPl4eoQjoOUBknzN1V/FKN6JhRvF9g3vqfYhNKajKPd7tAU6dqS9
	UKFQJXSg1uMwWo+FNpl+dQAtGfsdXfMH+V67MzwdQFaZWEM31p4o/t4aSXsqOqMQe7Hk
	PXKpMLQvnMrcreZH1wbfu9NWaK9nPyQeXLurxPO+iT+2QkE4vMHLsB6+YO1UMaaa5WrM
	zNdLeLAqIG8WfWpktCi21FX2MlwEgXUW2etyjVCB78Ge/2hAE0hXHCyUfq+qEGA/9otP
	9o7g6q5xDjpAkWgQQukR5AmYtTHZtMJXiYjlzvhzLEDtg4pdHYMZED8t6+zxRoMxtuQ7
	Kq2w==
X-Gm-Message-State: ALoCoQmxPiWVAPDWJU+21s1q+762IOWy2xv1a8bTWiRWm4Wxrwv7tMR1h7RpXCY1d2XD67LXQCmS
X-Received: by 10.140.42.138 with SMTP id c10mr3565934qga.24.1394728555926;
	Thu, 13 Mar 2014 09:35:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.48.79 with HTTP; Thu, 13 Mar 2014 09:35:35 -0700 (PDT)
From: "Burton, Ross" <ross.burton@intel.com>
Date: Thu, 13 Mar 2014 16:35:35 +0000
Message-ID: <CAJTo0LZffXzAyhu23+phNpKTNbvRV5zYvwRQR5ssvG-t_isqnw@mail.gmail.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Exception on error
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
X-List-Received-Date: Thu, 13 Mar 2014 16:35:58 -0000
Content-Type: text/plain; charset=UTF-8

Hi,

Just got this error when bitbake was shutting down after a failed parse:

ERROR: An uncaught exception occured in runqueue, please see the failure below:
ERROR: Running idle function
Traceback (most recent call last):
  File "/home/ross/Yocto/poky/bitbake/lib/bb/server/process.py", line
128, in ProcessServer.idle_commands(delay=0.1, fds=[<read-only
Connection, handle 4>, <read-write Connection, handle 7>, <read-write
Connection, handle 12>]):
                 try:
    >                retval = function(self, data, False)
                     if retval is False:
  File "/home/ross/Yocto/poky/bitbake/lib/bb/cooker.py", line 1171, in
buildTargetsIdle(server=<ProcessServer(ProcessServer-1, started)>,
rq=<bb.runqueue.RunQueue instance at 0x16b8dd40>, abort=False):
                 try:
    >                retval = rq.execute_runqueue()
                 except runqueue.TaskFailure as exc:
  File "/home/ross/Yocto/poky/bitbake/lib/bb/runqueue.py", line 1122,
in RunQueue.execute_runqueue():
                 try:
    >                self.teardown_workers()
                 except:
  File "/home/ross/Yocto/poky/bitbake/lib/bb/runqueue.py", line 950,
in RunQueue.teardown_workers():
             self.teardown = True
    >        signal.signal(signal.SIGCHLD, self.oldsigchld)
             self._teardown_worker(self.worker, self.workerpipe)
TypeError: signal handler must be signal.SIG_IGN, signal.SIG_DFL, or a
callable object

I can look into this maybe tomorrow but hopefully someone will
recognise it as a simple fix and send a patch first.

Ross

