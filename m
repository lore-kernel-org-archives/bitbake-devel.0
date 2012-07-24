Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1StaRj-00055A-87 for bitbake-devel@lists.openembedded.org;
	Tue, 24 Jul 2012 10:26:23 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q6O8Euf5028657;
	Tue, 24 Jul 2012 09:14:56 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 26250-08; Tue, 24 Jul 2012 09:14:51 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q6O8Eha7028650
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 24 Jul 2012 09:14:46 +0100
Message-ID: <1343117680.21788.114.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Kang Kai <kai.kang@windriver.com>
Date: Tue, 24 Jul 2012 09:14:40 +0100
In-Reply-To: <0c6e89f1ac8abee8be17f821bda9b193b1761f6c.1343113295.git.kai.kang@windriver.com>
References: <cover.1343113295.git.kai.kang@windriver.com>
	<0c6e89f1ac8abee8be17f821bda9b193b1761f6c.1343113295.git.kai.kang@windriver.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: Re: [PATCH 2/2] cooker: treat termination by disk monitor as failure
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
X-List-Received-Date: Tue, 24 Jul 2012 08:26:23 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2012-07-24 at 15:04 +0800, Kang Kai wrote:
> [Yocto #2168]
> 
> Check the return value of function diskMonitor.check() in runqueue then
> pass it to cooker. The cooker treats that runqueue terminated by disk
> monitor as failure, then increase the build failure count if the return
> value is true.
> 
> The UIs could check the failure count accordingly, and this will helpful
> for UIs such as Hob.
> 
> Signed-off-by: Kang Kai <kai.kang@windriver.com>
> ---
>  bitbake/lib/bb/cooker.py   |   14 ++++++++++++--
>  bitbake/lib/bb/event.py    |    5 +++--
>  bitbake/lib/bb/runqueue.py |    9 +++++----
>  3 files changed, 20 insertions(+), 8 deletions(-)

I have to say I don't really like this code. I agree that the UI needs
to know about diskmonitor failures but I'm not sure about changing the
BuiuldCompleted event in this way. I think we should add the exit status
to the BuildCompleted event as an extra field (leaving the failures
count alone as it means something specific right now).

The UI is going to want more information about what failed (which disk
was full, how full was it, where is it mounted?). The best approach
therefore could be a specific DiskFull event which gets fired and the UI
can act upon containing much more information.

Cheers,

Richard


> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> index 361bc88..58a10f7 100644
> --- a/bitbake/lib/bb/cooker.py
> +++ b/bitbake/lib/bb/cooker.py
> @@ -1095,7 +1095,7 @@ class BBCooker:
>                  rq.finish_runqueue(False)
>              failures = 0
>              try:
> -                retval = rq.execute_runqueue()
> +                retval, termedbydm = rq.execute_runqueue()
>              except runqueue.TaskFailure as exc:
>                  failures += len(exc.args)
>                  retval = False
> @@ -1103,6 +1103,11 @@ class BBCooker:
>                  self.command.finishAsyncCommand()
>                  return False
>  
> +            if termedbydm:
> +                bb.event.fire(bb.event.BuildCompleted(len(rq.rqdata.runq_fnid), buildname, item, failures, bymonitor=True), self.configuration.event_data)
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
> +                retval, termedbydm = rq.execute_runqueue()
>              except runqueue.TaskFailure as exc:
>                  failures += len(exc.args)
>                  retval = False
> @@ -1143,6 +1148,11 @@ class BBCooker:
>                  self.command.finishAsyncCommand()
>                  return False
>  
> +            if termedbydm:
> +                bb.event.fire(bb.event.BuildCompleted(len(rq.rqdata.runq_fnid), buildname, targets, failures, bymonitor=True), self.configuration.data)
> +                self.command.finishAsyncCommand()
> +                return False
> +
>              if not retval:
>                  bb.event.fire(bb.event.BuildCompleted(len(rq.rqdata.runq_fnid), buildname, targets, failures), self.configuration.data)
>                  self.command.finishAsyncCommand()
> diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
> index 1116c0a..d719105 100644
> --- a/bitbake/lib/bb/event.py
> +++ b/bitbake/lib/bb/event.py
> @@ -305,14 +305,15 @@ class BuildStarted(BuildBase, OperationStarted):
>  
>  class BuildCompleted(BuildBase, OperationCompleted):
>      """bbmake build run completed"""
> -    def __init__(self, total, n, p, failures = 0):
> +    def __init__(self, total, n, p, failures = 0, bymonitor = False):
> +        if bymonitor:
> +            failures += 1
>          if not failures:
>              OperationCompleted.__init__(self, total, "Building Succeeded")
>          else:
>              OperationCompleted.__init__(self, total, "Building Failed")
>          BuildBase.__init__(self, n, p, failures)
>  
> -
>  class NoProvider(Event):
>      """No Provider for an Event"""
>  
> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
> index 0a8c723..efe3623 100644
> --- a/bitbake/lib/bb/runqueue.py
> +++ b/bitbake/lib/bb/runqueue.py
> @@ -867,6 +867,7 @@ class RunQueue:
>          """
>  
>          retval = 0.5
> +        termedbydm = False
>  
>          if self.state is runQueuePrepare:
>              self.rqexe = RunQueueExecuteDummy(self)
> @@ -882,7 +883,7 @@ class RunQueue:
>                  self.rqexe = RunQueueExecuteScenequeue(self)
>  
>          if self.state in [runQueueSceneRun, runQueueRunning, runQueueCleanUp]:
> -            self.dm.check(self)
> +            termedbydm = self.dm.check(self)
>  
>          if self.state is runQueueSceneRun:
>              retval = self.rqexe.execute()
> @@ -914,14 +915,14 @@ class RunQueue:
>  
>          if self.state is runQueueComplete:
>              # All done
> -            return False
> +            return False, termedbydm
>  
>          if self.state is runQueueChildProcess:
>              print("Child process, eeek, shouldn't happen!")
> -            return False
> +            return False, termedbydm
>  
>          # Loop
> -        return retval
> +        return retval, termedbydm
>  
>      def finish_runqueue(self, now = False):
>          if not self.rqexe:




