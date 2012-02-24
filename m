Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1S0jGJ-0000Bu-6t
	for bitbake-devel@lists.openembedded.org;
	Fri, 24 Feb 2012 01:43:51 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 23 Feb 2012 16:35:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="128827625"
Received: from dongxiao-osel.sh.intel.com (HELO [10.239.36.11])
	([10.239.36.11])
	by fmsmga002.fm.intel.com with ESMTP; 23 Feb 2012 16:35:27 -0800
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
In-Reply-To: <1330037463.22167.5.camel@ted>
References: <cover.1330003017.git.dongxiao.xu@intel.com>
	<cec8b6e6c33582be660dd35c6050efc3f28e6baa.1330003017.git.dongxiao.xu@intel.com>
	<1330037463.22167.5.camel@ted>
Date: Fri, 24 Feb 2012 08:34:09 +0800
Message-ID: <1330043649.8145.59.camel@dongxiao-osel>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 9/9] runqueue: fire sceneQueueTaskStarted event when a setscene queue starts
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
X-List-Received-Date: Fri, 24 Feb 2012 00:43:51 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-02-23 at 22:51 +0000, Richard Purdie wrote:
> On Thu, 2012-02-23 at 21:47 +0800, Dongxiao Xu wrote:
> > The current code prints a log when a setscene task starts, therefore
> > the progressbar in hob will not receive it. Use a sceneQueueTaskStarted
> > event instead.
> > 
> > Signed-off-by: Shane Wang <shane.wang@intel.com>
> > Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
> > ---
> >  lib/bb/runqueue.py |   10 ++++++++++
> >  1 files changed, 10 insertions(+), 0 deletions(-)
> > 
> > diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
> > index d1d9ad9..ef28415 100644
> > --- a/lib/bb/runqueue.py
> > +++ b/lib/bb/runqueue.py
> > @@ -1653,6 +1653,9 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
> >                  self.task_skip(task)
> >                  return True
> >  
> > +            startevent = sceneQueueTaskStarted(task, self.stats, self.rq)
> > +            bb.event.fire(startevent, self.cfgData)
> > +
> >              pid, pipein, pipeout = self.fork_off_task(fn, realtask, taskname)
> >  
> >              self.build_pids[pid] = task
> > @@ -1720,6 +1723,13 @@ class runQueueTaskStarted(runQueueEvent):
> >          runQueueEvent.__init__(self, task, stats, rq)
> >          self.noexec = noexec
> >  
> > +class sceneQueueTaskStarted(runQueueTaskStarted):
> > +    """
> > +    Event notifing a setscene task was started
> > +    """
> > +    def __init__(self, task, stats, rq, noexec=False):
> > +        runQueueTaskStarted.__init__(self, task, stats, rq, noexec)
> > +
> 
> This one has me a little worried since it inherits runQueueTaskStarted
> and a UI might confuse this with real runQueueTaskStarted() events. Is
> there something else we can inherit here?

Hi Richard,

Here we inherit runQueueTaskStarted event is because we saw the
sceneQueueTaskFailed event inherits runQueueTaskFailed in existing code.

What about change both of sceneQueueTaskxxx directly inherit
runQueueEvent?

Thanks,
Dongxiao

> 
> Cheers,
> 
> Richard
> 
> 




