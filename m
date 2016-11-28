Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id E5CD271B59
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Nov 2016 15:58:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	uASFwu7K004100; Mon, 28 Nov 2016 15:58:56 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id niIxx8ub9EVc; Mon, 28 Nov 2016 15:58:56 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	uASFwoOY004097
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 28 Nov 2016 15:58:51 GMT
Message-ID: <1480348730.28508.185.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Patrick Ohly <patrick.ohly@intel.com>, bitbake-devel@lists.openembedded.org
Date: Mon, 28 Nov 2016 15:58:50 +0000
In-Reply-To: <4a82fef918264b2e74022e8ed95cb198f44300c7.1480345719.git.patrick.ohly@intel.com>
References: <90660fc75cc3fedceabef02ac2ade99d7c26fbb2.1480345719.git.patrick.ohly@intel.com>
	<4a82fef918264b2e74022e8ed95cb198f44300c7.1480345719.git.patrick.ohly@intel.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Subject: Re: [PATCH 2/4] runqueue.py: monitor disk space at regular time intervals
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
X-List-Received-Date: Mon, 28 Nov 2016 15:59:00 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Mon, 2016-11-28 at 16:15 +0100, Patrick Ohly wrote:
> Hooking the disk monitor into the regular heatbeat event instead
> of the runqueue solves two problems:
> 
> - When there is just one long running task which fills up the disk,
>   the previous approach did not notice that until after the
> completion
>   of the task because _execute_runqueue() only gets called on task
>   state changes. As a result, aborting a build did not work in this
>   case.
> 
> - When there are many short-lived tasks, disk space was getting
>   checked very frequently. When the storage that is getting checked
>   is on an NFS server, that can lead to noticable traffic to the
>   server.
> 
> Signed-off-by: Patrick Ohly <patrick.ohly@intel.com>
> ---
>  lib/bb/runqueue.py | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
> index 84b2685..3772e2e 100644
> --- a/lib/bb/runqueue.py
> +++ b/lib/bb/runqueue.py
> @@ -984,7 +984,12 @@ class RunQueue:
>          self.state = runQueuePrepare
>  
>          # For disk space monitor
> +        # Invoked at regular time intervals via the bitbake
> heartbeat event
> +        # while the build is running.
>          self.dm = monitordisk.diskMonitor(cfgData)
> +        bb.event.register('_bb_diskmonitor',
> +                          lambda x: self.dm.check(self) if
> self.state in [runQueueSceneRun, runQueueRunning, runQueueCleanUp]
> else False,
> +                          ('bb.event.HeartbeatEvent',))
>  
>          self.rqexe = None
>          self.worker = {}
> @@ -1208,9 +1213,6 @@ class RunQueue:
>                  self.rqdata.init_progress_reporter.next_stage()
>                  self.rqexe = RunQueueExecuteScenequeue(self)
>  
> -        if self.state in [runQueueSceneRun, runQueueRunning,
> runQueueCleanUp]:
> -            self.dm.check(self)
> -
>          if self.state is runQueueSceneRun:
>              retval = self.rqexe.execute()

Don't we have to unregister this at some point too? Cooker can persist
across multiple builds (although its not the default).

Cheers,

Richard

