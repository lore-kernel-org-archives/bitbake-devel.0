Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1S0jVe-0000du-Pn for bitbake-devel@lists.openembedded.org;
	Fri, 24 Feb 2012 01:59:42 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q1O0pJfU031886;
	Fri, 24 Feb 2012 00:51:19 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 31838-01; Fri, 24 Feb 2012 00:51:15 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q1O0p7Vh031799
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 24 Feb 2012 00:51:08 GMT
Message-ID: <1330044668.25226.19.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Xu, Dongxiao" <dongxiao.xu@intel.com>
Date: Fri, 24 Feb 2012 00:51:08 +0000
In-Reply-To: <1330043649.8145.59.camel@dongxiao-osel>
References: <cover.1330003017.git.dongxiao.xu@intel.com>
	<cec8b6e6c33582be660dd35c6050efc3f28e6baa.1330003017.git.dongxiao.xu@intel.com>
	<1330037463.22167.5.camel@ted> <1330043649.8145.59.camel@dongxiao-osel>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
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
X-List-Received-Date: Fri, 24 Feb 2012 00:59:43 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-02-24 at 08:34 +0800, Xu, Dongxiao wrote:
> On Thu, 2012-02-23 at 22:51 +0000, Richard Purdie wrote:
> > On Thu, 2012-02-23 at 21:47 +0800, Dongxiao Xu wrote:
> > > The current code prints a log when a setscene task starts, therefore
> > > the progressbar in hob will not receive it. Use a sceneQueueTaskStarted
> > > event instead.
> > > 
> > > Signed-off-by: Shane Wang <shane.wang@intel.com>
> > > Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
> > > ---
> > >  lib/bb/runqueue.py |   10 ++++++++++
> > >  1 files changed, 10 insertions(+), 0 deletions(-)
> > > 
> > > diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
> > > index d1d9ad9..ef28415 100644
> > > --- a/lib/bb/runqueue.py
> > > +++ b/lib/bb/runqueue.py
> > > @@ -1653,6 +1653,9 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
> > >                  self.task_skip(task)
> > >                  return True
> > >  
> > > +            startevent = sceneQueueTaskStarted(task, self.stats, self.rq)
> > > +            bb.event.fire(startevent, self.cfgData)
> > > +
> > >              pid, pipein, pipeout = self.fork_off_task(fn, realtask, taskname)
> > >  
> > >              self.build_pids[pid] = task
> > > @@ -1720,6 +1723,13 @@ class runQueueTaskStarted(runQueueEvent):
> > >          runQueueEvent.__init__(self, task, stats, rq)
> > >          self.noexec = noexec
> > >  
> > > +class sceneQueueTaskStarted(runQueueTaskStarted):
> > > +    """
> > > +    Event notifing a setscene task was started
> > > +    """
> > > +    def __init__(self, task, stats, rq, noexec=False):
> > > +        runQueueTaskStarted.__init__(self, task, stats, rq, noexec)
> > > +
> > 
> > This one has me a little worried since it inherits runQueueTaskStarted
> > and a UI might confuse this with real runQueueTaskStarted() events. Is
> > there something else we can inherit here?
> 
> Hi Richard,
> 
> Here we inherit runQueueTaskStarted event is because we saw the
> sceneQueueTaskFailed event inherits runQueueTaskFailed in existing code.
> 
> What about change both of sceneQueueTaskxxx directly inherit
> runQueueEvent?

That sounds reasonable to me. sceneQueueTaskFailed sounds like a bug and
might explain an error I keep seeing in knotty but haven't looked
into/reported yet! You might fix a bug by changing that :)

Cheers,

Richard





