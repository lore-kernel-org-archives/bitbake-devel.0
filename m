Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1S1GI9-0004Ny-K5 for bitbake-devel@lists.openembedded.org;
	Sat, 25 Feb 2012 12:59:57 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q1PBpYhO019660;
	Sat, 25 Feb 2012 11:51:34 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 19581-01; Sat, 25 Feb 2012 11:51:30 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q1PBpNj4019654
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 25 Feb 2012 11:51:25 GMT
Message-ID: <1330170684.13788.29.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>
Date: Sat, 25 Feb 2012 11:51:24 +0000
In-Reply-To: <4F48C122.1030200@windriver.com>
References: <cover.1329727465.git.liezhi.yang@windriver.com>
	<3f1562cf1c51f28221093dd13516206aa0287f6e.1329727465.git.liezhi.yang@windriver.com>
	<1329931725.20261.197.camel@ted> <4F48C122.1030200@windriver.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/2] V4 Disk space monitoring
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
X-List-Received-Date: Sat, 25 Feb 2012 11:59:57 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sat, 2012-02-25 at 19:08 +0800, Robert Yang wrote:
> Thank you very much for your detailed review, I've fixed most of
> them as you suggested except the following ones, and please see my
> comments below.

Thanks! (comments below)

> On 02/23/2012 01:28 AM, Richard Purdie wrote:
> > Hi Robert,
> >
> >>     # Set disk space and inode interval, the unit can be G, M, or K, but do
> >>     # NOT use the GB, MB or KB (B is not needed), the format is:
> >>     # "disk space interval, disk inode interval",  the default value is
> >>     # "10M, 50" which means that it would warn when the free space is
> >>     # lower than the minimum space(or inode), and would repeat the action
> >>     # when the disk space reduces 10M (or the amount of inode reduces 50)
> >>     # again.
> >>     #BB_DISKMON_INTERVAL = "10M,10K"
> >
> > I'm wondering how useful this interval is? Surely once we've warned,
> > aborted or stopped starting new tasks, running the action again isn't
> > much use? This is particularly true with the change I'm proposing above.
> >
> 
> I think there are 3 actions we can do: WARN, STOPTASKS or ABORT, this is
> only useful for "WARN", when the action is "WARN", there would be too many
> WARNINGS without the interval value.

Can we call it BB_DISKMON_WARNINTERVAL then?


> >> +        for dev in devDict:
> >> +            st = os.statvfs(devDict[dev][0])
> >> +            # The free space, float point number
> >> +            freeSpace = st.f_bavail * st.f_frsize
> >> +            if devDict[dev][1] is not None and freeSpace<  devDict[dev][1]:
> >> +                # Always show warning, and this is the default "WARN" action
> >> +                if self.preFreeSpace[dev] == 0 or self.preFreeSpace[dev] - freeSpace>  self.dm.spaceInterval:
> >> +                    logger.warn("The free space of %s is running low (%.3fGB left)" % (dev, freeSpace / 1024 / 1024 / 1024.0))
> >> +                    self.preFreeSpace[dev] = freeSpace
> >> +                if self.dm.action == "NO_NEW_TASK":
> >> +                    logger.warn("No new tasks can be excuted since BB_DISKMON_ACTION = \"NO_NEW_TASK\"!")
> >> +                    return 1
> >> +                elif self.dm.action == "ABORT":
> >> +                    logger.error("Immediately abort since BB_DISKMON_ACTION = \"ABORT\"!")
> >> +                    sys.exit(1)
> >
> > Please don't do this. There is a way to immediately abort the runqueue
> > by calling rq.finish_runqueue(True) (see cooker.py which does this).
> >
> > The return one could probably also be a finish_runqueue(False) call.
> 
> The finish_runqueue(False) works, but finish_runqueue(True) doesn't work
> if there is no running task running(for example, when we use the
> finish_runqueue(True) at the very beginning of the build), this is because
> if there is no running taks, the function would do nothing. So I use:
> 
> rq.finish_runqueue(True)
> return False
> 
> Then the build would always stop whether there is running tasks or not.

Ah, right. How about we add as a separate patch:

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index c24841f..09dab3d 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1060,6 +1060,13 @@ class RunQueueExecute:
         for pipe in self.build_pipes:
             self.build_pipes[pipe].read()
 
+        if len(self.failed_fnids) != 0:
+            self.rq.state = runQueueFailed
+            return
+
+        self.rq.state = runQueueComplete
+        return
+
     def finish(self):
         self.rq.state = runQueueCleanUp
 

> This would make the code more clearer, I have moved most of the code to
> lib/bb/monitordisk.py as you suggested, but since the rq.finish_runqueue(True)
> doesn't work when there is no running task, I still need check the return
> status of the monitor, now the code is:
> 
>          if self.state in [runQueueSceneRun, runQueueRunning, runQueueCleanUp]:
>              if self.dm.enableMonitor:
>                  dm_ret = self.dm.dm_action()
>                  if dm_ret == 1:
>                      self.finish_runqueue(False)
>                  elif dm_ret == 2:
>                      self.finish_runqueue(True)
>                      return False

See above, I think we can fix this! :)

Cheers,

Richard



