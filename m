Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1S1FcM-00042A-T0
	for bitbake-devel@lists.openembedded.org;
	Sat, 25 Feb 2012 12:16:47 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q1PB8Kfe028561
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Sat, 25 Feb 2012 03:08:20 -0800 (PST)
Received: from [128.224.162.196] (128.224.162.196) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Sat, 25 Feb 2012 03:08:19 -0800
Message-ID: <4F48C122.1030200@windriver.com>
Date: Sat, 25 Feb 2012 19:08:18 +0800
From: Robert Yang <liezhi.yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:9.0) Gecko/20111229 Thunderbird/9.0
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <cover.1329727465.git.liezhi.yang@windriver.com>
	<3f1562cf1c51f28221093dd13516206aa0287f6e.1329727465.git.liezhi.yang@windriver.com>
	<1329931725.20261.197.camel@ted>
In-Reply-To: <1329931725.20261.197.camel@ted>
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
X-List-Received-Date: Sat, 25 Feb 2012 11:16:47 -0000
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit


Hi Richard,

Thank you very much for your detailed review, I've fixed most of
them as you suggested except the following ones, and please see my
comments below.

On 02/23/2012 01:28 AM, Richard Purdie wrote:
> Hi Robert,
>
>>     # Set disk space and inode interval, the unit can be G, M, or K, but do
>>     # NOT use the GB, MB or KB (B is not needed), the format is:
>>     # "disk space interval, disk inode interval",  the default value is
>>     # "10M, 50" which means that it would warn when the free space is
>>     # lower than the minimum space(or inode), and would repeat the action
>>     # when the disk space reduces 10M (or the amount of inode reduces 50)
>>     # again.
>>     #BB_DISKMON_INTERVAL = "10M,10K"
>
> I'm wondering how useful this interval is? Surely once we've warned,
> aborted or stopped starting new tasks, running the action again isn't
> much use? This is particularly true with the change I'm proposing above.
>

I think there are 3 actions we can do: WARN, STOPTASKS or ABORT, this is
only useful for "WARN", when the action is "WARN", there would be too many
WARNINGS without the interval value.

>> +def errRet(info):
>> +    logger.error("%s" % info)
>> +    logger.error("Disk space monitor will NOT be enabled")
>> +    return None
>> +
>> +def errRetTwo(info):
>> +    logger.error("%s" % info)
>> +    logger.error("Disk space monitor will NOT be enabled")
>> +    return None, None
>
> These should be one multiline logger.error() call (using \n for
> newlines).
>

Yes, I've fixed this, also combine errRet and errRetTwo into one
function printERR.

>> +        for dev in devDict:
>> +            st = os.statvfs(devDict[dev][0])
>> +            # The free space, float point number
>> +            freeSpace = st.f_bavail * st.f_frsize
>> +            if devDict[dev][1] is not None and freeSpace<  devDict[dev][1]:
>> +                # Always show warning, and this is the default "WARN" action
>> +                if self.preFreeSpace[dev] == 0 or self.preFreeSpace[dev] - freeSpace>  self.dm.spaceInterval:
>> +                    logger.warn("The free space of %s is running low (%.3fGB left)" % (dev, freeSpace / 1024 / 1024 / 1024.0))
>> +                    self.preFreeSpace[dev] = freeSpace
>> +                if self.dm.action == "NO_NEW_TASK":
>> +                    logger.warn("No new tasks can be excuted since BB_DISKMON_ACTION = \"NO_NEW_TASK\"!")
>> +                    return 1
>> +                elif self.dm.action == "ABORT":
>> +                    logger.error("Immediately abort since BB_DISKMON_ACTION = \"ABORT\"!")
>> +                    sys.exit(1)
>
> Please don't do this. There is a way to immediately abort the runqueue
> by calling rq.finish_runqueue(True) (see cooker.py which does this).
>
> The return one could probably also be a finish_runqueue(False) call.

The finish_runqueue(False) works, but finish_runqueue(True) doesn't work
if there is no running task running(for example, when we use the
finish_runqueue(True) at the very beginning of the build), this is because
if there is no running taks, the function would do nothing. So I use:

rq.finish_runqueue(True)
return False

Then the build would always stop whether there is running tasks or not.

>>       def execute_runqueue(self):
>>           """
>>           Run the tasks in a queue prepared by rqdata.prepare()
>> @@ -946,7 +993,14 @@ class RunQueue:
>>                   self.rqexe = RunQueueExecuteScenequeue(self)
>>
>>           if self.state is runQueueSceneRun:
>> -            retval = self.rqexe.execute()
>> +            if self.dm and self.dm.enableMonitor:
>> +                dm_action = self.disk_monitor_action(self.dm.devDict)
>> +                if dm_action == 1:
>> +                    self.rqexe.finish()
>> +                else:
>> +                    retval = self.rqexe.execute()
>> +            else:
>> +                retval = self.rqexe.execute()
>>
>>           if self.state is runQueueRunInit:
>>               logger.info("Executing RunQueue Tasks")
>> @@ -954,10 +1008,17 @@ class RunQueue:
>>               self.state = runQueueRunning
>>
>>           if self.state is runQueueRunning:
>> -            retval = self.rqexe.execute()
>> +            if self.dm and self.dm.enableMonitor:
>> +                dm_action = self.disk_monitor_action(self.dm.devDict)
>> +                if dm_action == 1:
>> +                    self.rqexe.finish()
>> +                else:
>> +                    retval = self.rqexe.execute()
>> +            else:
>> +                retval = self.rqexe.execute()
>>
>>           if self.state is runQueueCleanUp:
>> -           self.rqexe.finish()
>> +            self.rqexe.finish()
>>
>>           if self.state is runQueueComplete or self.state is runQueueFailed:
>>               if self.rqexe.stats.failed:
>
>
> With the above changes, you can probably just put something like:
>
>         if self.state in [runQueueSceneRun, runQueueRunning, runQueueCleanUp]:
>              self.dm.check(self)
>

This would make the code more clearer, I have moved most of the code to
lib/bb/monitordisk.py as you suggested, but since the rq.finish_runqueue(True)
doesn't work when there is no running task, I still need check the return
status of the monitor, now the code is:

         if self.state in [runQueueSceneRun, runQueueRunning, runQueueCleanUp]:
             if self.dm.enableMonitor:
                 dm_ret = self.dm.dm_action()
                 if dm_ret == 1:
                     self.finish_runqueue(False)
                 elif dm_ret == 2:
                     self.finish_runqueue(True)
                     return False

// Robert

> in above if self.state is runQueueCleanUp in execute_runqueue() since
> calling the finish_runqueue() would change self.state
>
> Cheers,
>
> Richard
>
>
>
>


