Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 993586FE64
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 14:35:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	s7REZHAB004142; Wed, 27 Aug 2014 15:35:17 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id p-kHgzYBvHzD; Wed, 27 Aug 2014 15:35:17 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	s7REZBsV004134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 27 Aug 2014 15:35:13 +0100
Message-ID: <1409150113.29296.2.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Hongxu Jia <hongxu.jia@windriver.com>
Date: Wed, 27 Aug 2014 15:35:13 +0100
In-Reply-To: <53FDE832.8060207@windriver.com>
References: <cover.1409147456.git.hongxu.jia@windriver.com>
	<482f226a680a13d96157e6d437fb9b8d237c68dc.1409147456.git.hongxu.jia@windriver.com>
	<1409148322.5772.52.camel@ted> <53FDE832.8060207@windriver.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org, Zhangle.Yang@windriver.com
Subject: Re: [PATCH 1/1] bitbake: runqueue: catch hashvalidate error in RunQueueExecuteScenequeue
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
X-List-Received-Date: Wed, 27 Aug 2014 14:35:21 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2014-08-27 at 22:16 +0800, Hongxu Jia wrote:
> On 08/27/2014 10:05 PM, Richard Purdie wrote:
> > On Wed, 2014-08-27 at 21:57 +0800, Hongxu Jia wrote:
> >> We need to catch the failure of self.rq.hashvalidate which invoked
> >> in RunQueueExecuteScenequeue, and exit in a normal build.
> >>
> >> So we raise and except bb.BBHandledException for this specific error.
> >>
> >> Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
> >> ---
> >>   bitbake/lib/bb/runqueue.py | 16 +++++++++++++---
> >>   1 file changed, 13 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
> >> index e13dc57..59e4188 100644
> >> --- a/bitbake/lib/bb/runqueue.py
> >> +++ b/bitbake/lib/bb/runqueue.py
> >> @@ -1046,7 +1046,14 @@ class RunQueue:
> >>                   self.state = runQueueComplete
> >>               else:
> >>                   self.start_worker()
> >> -                self.rqexe = RunQueueExecuteScenequeue(self)
> >> +                try:
> >> +                    self.rqexe = RunQueueExecuteScenequeue(self)
> >> +                except bb.BBHandledException:
> >> +                    # While hashvalidate failed, we need exit the normal build.
> >> +                    self.state = runQueueComplete
> >> +                except:
> >> +                    logger.error("RunQueueExecuteScenequeue init failed")
> >> +                    raise
> > Do you still need to do this with the change below? runqueue didn't
> > complete, it failed so the state doesn't seem right...
> 
> I want to exit the build peacefully, without too much break messages
> if we don't assign the above complete status, we have messages like this:
> ...
> ERROR: Hash validation failed in RunQueueExecuteScenequeue
> ERROR: An uncaught exception occured in runqueue, please see the failure 
> below:
> ERROR: Running idle function
> Traceback (most recent call last):
>                   try:
>      >                retval = function(self, data, False)
>                       if retval is False:
>                   try:
>      >                retval = rq.execute_runqueue()
>                   except runqueue.TaskFailure as exc:
>    File "/home/jiahongxu/yocto/poky/bitbake/lib/bb/runqueue.py", line 
> 1103, in RunQueue.execute_runqueue():
>               try:
>      >            return self._execute_runqueue()
>               except bb.runqueue.TaskFailure:
>    File "/home/jiahongxu/yocto/poky/bitbake/lib/bb/runqueue.py", line 
> 1049, in RunQueue._execute_runqueue():
>                       self.start_worker()
>      >                self.rqexe = RunQueueExecuteScenequeue(self)
>                       '''
>    File "/home/jiahongxu/yocto/poky/bitbake/lib/bb/runqueue.py", line 
> 1838, in RunQueueExecuteScenequeue.__init__(rq=<bb.runqueue.RunQueue 
> instance at 0x7f509f4bd950>):
>                       logger.error("Hash validation failed in 
> RunQueueExecuteScenequeue %s" % str(e))
>      >                raise bb.BBHandledException()
> 
> BBHandledException
> ...
> 
> Do you have ang ideas about how to exit the build peacefully?

I think bitbake has some deeper issues here we should fix. Firstly, I
think execute_runqueue should really do something like:

        try:
            return self._execute_runqueue()
        except bb.runqueue.TaskFailure:
            raise
        except BaseException as e:
            if not isinstance(e, (SystemExit, BBHandledException)):
                logger.error("An uncaught exception occured in runqueue, please see the failure below:")
            try:
                self.teardown_workers()
            except:
                pass
            self.state = runQueueComplete
            raise

then in buildFileIdle and buildTargetsIdle we should change SystemExit to (SystemExit, BBHandledException) too.

Cheers,

Richard



