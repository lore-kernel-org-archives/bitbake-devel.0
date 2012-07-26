Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SuLYZ-000537-06 for bitbake-devel@lists.openembedded.org;
	Thu, 26 Jul 2012 12:44:35 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q6QAX4Hk020068;
	Thu, 26 Jul 2012 11:33:04 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 17865-10; Thu, 26 Jul 2012 11:33:00 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q6QAWuVJ020062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 26 Jul 2012 11:32:57 +0100
Message-ID: <1343298776.29991.23.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Kang Kai <kai.kang@windriver.com>
Date: Thu, 26 Jul 2012 11:32:56 +0100
In-Reply-To: <29b7d71a66994a626bcbcfce87e9279cb0da7961.1343295453.git.kai.kang@windriver.com>
References: <cover.1343295453.git.kai.kang@windriver.com>
	<29b7d71a66994a626bcbcfce87e9279cb0da7961.1343295453.git.kai.kang@windriver.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: Re: [PATCH 2/3] cooker: send event when terminated by disk monitor
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 26 Jul 2012 10:44:35 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-07-26 at 17:39 +0800, Kang Kai wrote:
> Part of [Yocto #2168]
> 
> Add a event DiskFull to descript the termination by disk monitor.
> 
> According to the return info from function diskMonitor.check, runqueue
> pass it to cooker. The cooker check the info and send event DiskFull
> when runqueue terminated by disk monitor.
> 
> The UIs could get the infomation from the event DiskFull.
> 
> Signed-off-by: Kang Kai <kai.kang@windriver.com>
> ---
>  bitbake/lib/bb/cooker.py   |   14 ++++++++++++--
>  bitbake/lib/bb/event.py    |    8 ++++++++
>  bitbake/lib/bb/runqueue.py |    9 +++++----
>  3 files changed, 25 insertions(+), 6 deletions(-)

This is good and heading the right way but why can't self.dm.check fire
the event itself? This appears to unnecessarily complicate code...

Cheers,

Richard

> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> index 5d01af3..d8341b9 100644
> --- a/bitbake/lib/bb/cooker.py
> +++ b/bitbake/lib/bb/cooker.py
> @@ -1095,7 +1095,7 @@ class BBCooker:
>                  rq.finish_runqueue(False)
>              failures = 0
>              try:
> -                retval = rq.execute_runqueue()
> +                retval, dmdata = rq.execute_runqueue()
>              except runqueue.TaskFailure as exc:
>                  failures += len(exc.args)
>                  retval = False
> @@ -1103,6 +1103,11 @@ class BBCooker:
>                  self.command.finishAsyncCommand()
>                  return False
>  
> +            if 'terminated' in dmdata and dmdata['terminated']:
> +                bb.event.fire(bb.event.DiskFull(dmdata['dev'], dmdata['type'], dmdata['freespace'], dmdata['mountpoint']), self.configuration.event_data)
> +                self.command.finishAsyncCommand()
> +                return False
> +
>              if not retval:
>                  bb.event.fire(bb.event.BuildCompleted(len(rq.rqdata.runq_fnid), buildname, item, failures), self.configuration.event_data)
>                  self.command.finishAsyncCommand()
> @@ -1135,7 +1140,7 @@ class BBCooker:
>                  rq.finish_runqueue(False)
>              failures = 0
>              try:
> -                retval = rq.execute_runqueue()
> +                retval, dmdata = rq.execute_runqueue()
>              except runqueue.TaskFailure as exc:
>                  failures += len(exc.args)
>                  retval = False
> @@ -1143,6 +1148,11 @@ class BBCooker:
>                  self.command.finishAsyncCommand()
>                  return False
>  
> +            if 'terminated' in dmdata and dmdata['terminated']:
> +                bb.event.fire(bb.event.DiskFull(dmdata['dev'], dmdata['type'], dmdata['freespace'], dmdata['mountpoint']), self.configuration.event_data)
> +                self.command.finishAsyncCommand()
> +                return False
> +
>              if not retval:
>                  bb.event.fire(bb.event.BuildCompleted(len(rq.rqdata.runq_fnid), buildname, targets, failures), self.configuration.data)
>                  self.command.finishAsyncCommand()
> diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
> index 1116c0a..20923b5 100644
> --- a/bitbake/lib/bb/event.py
> +++ b/bitbake/lib/bb/event.py
> @@ -312,6 +312,14 @@ class BuildCompleted(BuildBase, OperationCompleted):
>              OperationCompleted.__init__(self, total, "Building Failed")
>          BuildBase.__init__(self, n, p, failures)
>  
> +class DiskFull(Event):
> +    """Disk full case build aborted"""
> +    def __init__(self, dev, type, freespace, mountpoint):
> +        Event.__init__(self)
> +        self._dev = dev
> +        self._type = type
> +        self._free = freespace
> +        self._mountpoint = mountpoint
>  
>  class NoProvider(Event):
>      """No Provider for an Event"""
> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
> index 0a8c723..233e6a9 100644
> --- a/bitbake/lib/bb/runqueue.py
> +++ b/bitbake/lib/bb/runqueue.py
> @@ -867,6 +867,7 @@ class RunQueue:
>          """
>  
>          retval = 0.5
> +        dmdata = {}
>  
>          if self.state is runQueuePrepare:
>              self.rqexe = RunQueueExecuteDummy(self)
> @@ -882,7 +883,7 @@ class RunQueue:
>                  self.rqexe = RunQueueExecuteScenequeue(self)
>  
>          if self.state in [runQueueSceneRun, runQueueRunning, runQueueCleanUp]:
> -            self.dm.check(self)
> +            dmdata = self.dm.check(self)
>  
>          if self.state is runQueueSceneRun:
>              retval = self.rqexe.execute()
> @@ -914,14 +915,14 @@ class RunQueue:
>  
>          if self.state is runQueueComplete:
>              # All done
> -            return False
> +            return False, dmdata
>  
>          if self.state is runQueueChildProcess:
>              print("Child process, eeek, shouldn't happen!")
> -            return False
> +            return False, dmdata
>  
>          # Loop
> -        return retval
> +        return retval, dmdata
>  
>      def finish_runqueue(self, now = False):
>          if not self.rqexe:




