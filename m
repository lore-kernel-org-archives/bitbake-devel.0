Return-Path: <Hongxu.Jia@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id A5F627067B
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 14:16:27 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail.windriver.com (8.14.9/8.14.5) with ESMTP id s7REGRjZ014152
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 27 Aug 2014 07:16:27 -0700 (PDT)
Received: from [128.224.162.194] (128.224.162.194) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.174.1;
	Wed, 27 Aug 2014 07:16:26 -0700
Message-ID: <53FDE832.8060207@windriver.com>
Date: Wed, 27 Aug 2014 22:16:18 +0800
From: Hongxu Jia <hongxu.jia@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:31.0) Gecko/20100101 Thunderbird/31.0
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <cover.1409147456.git.hongxu.jia@windriver.com>	
	<482f226a680a13d96157e6d437fb9b8d237c68dc.1409147456.git.hongxu.jia@windriver.com>
	<1409148322.5772.52.camel@ted>
In-Reply-To: <1409148322.5772.52.camel@ted>
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
X-List-Received-Date: Wed, 27 Aug 2014 14:16:28 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 08/27/2014 10:05 PM, Richard Purdie wrote:
> On Wed, 2014-08-27 at 21:57 +0800, Hongxu Jia wrote:
>> We need to catch the failure of self.rq.hashvalidate which invoked
>> in RunQueueExecuteScenequeue, and exit in a normal build.
>>
>> So we raise and except bb.BBHandledException for this specific error.
>>
>> Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
>> ---
>>   bitbake/lib/bb/runqueue.py | 16 +++++++++++++---
>>   1 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
>> index e13dc57..59e4188 100644
>> --- a/bitbake/lib/bb/runqueue.py
>> +++ b/bitbake/lib/bb/runqueue.py
>> @@ -1046,7 +1046,14 @@ class RunQueue:
>>                   self.state = runQueueComplete
>>               else:
>>                   self.start_worker()
>> -                self.rqexe = RunQueueExecuteScenequeue(self)
>> +                try:
>> +                    self.rqexe = RunQueueExecuteScenequeue(self)
>> +                except bb.BBHandledException:
>> +                    # While hashvalidate failed, we need exit the normal build.
>> +                    self.state = runQueueComplete
>> +                except:
>> +                    logger.error("RunQueueExecuteScenequeue init failed")
>> +                    raise
> Do you still need to do this with the change below? runqueue didn't
> complete, it failed so the state doesn't seem right...

I want to exit the build peacefully, without too much break messages
if we don't assign the above complete status, we have messages like this:
...
ERROR: Hash validation failed in RunQueueExecuteScenequeue
ERROR: An uncaught exception occured in runqueue, please see the failure 
below:
ERROR: Running idle function
Traceback (most recent call last):
                  try:
     >                retval = function(self, data, False)
                      if retval is False:
                  try:
     >                retval = rq.execute_runqueue()
                  except runqueue.TaskFailure as exc:
   File "/home/jiahongxu/yocto/poky/bitbake/lib/bb/runqueue.py", line 
1103, in RunQueue.execute_runqueue():
              try:
     >            return self._execute_runqueue()
              except bb.runqueue.TaskFailure:
   File "/home/jiahongxu/yocto/poky/bitbake/lib/bb/runqueue.py", line 
1049, in RunQueue._execute_runqueue():
                      self.start_worker()
     >                self.rqexe = RunQueueExecuteScenequeue(self)
                      '''
   File "/home/jiahongxu/yocto/poky/bitbake/lib/bb/runqueue.py", line 
1838, in RunQueueExecuteScenequeue.__init__(rq=<bb.runqueue.RunQueue 
instance at 0x7f509f4bd950>):
                      logger.error("Hash validation failed in 
RunQueueExecuteScenequeue %s" % str(e))
     >                raise bb.BBHandledException()

BBHandledException
...

Do you have ang ideas about how to exit the build peacefully?

//Hongxu


> Cheers,
>
> Richard
>
>>           if self.state in [runQueueSceneRun, runQueueRunning, runQueueCleanUp]:
>>               self.dm.check(self)
>> @@ -1821,7 +1828,11 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
>>                   sq_task.append(task)
>>               call = self.rq.hashvalidate + "(sq_fn, sq_task, sq_hash, sq_hashfn, d)"
>>               locs = { "sq_fn" : sq_fn, "sq_task" : sq_taskname, "sq_hash" : sq_hash, "sq_hashfn" : sq_hashfn, "d" : self.cooker.data }
>> -            valid = bb.utils.better_eval(call, locs)
>> +            try:
>> +                valid = bb.utils.better_eval(call, locs)
>> +            except Exception as e:
>> +                logger.error("Hash validation failed in RunQueueExecuteScenequeue %s" % str(e))
>> +                raise bb.BBHandledException()
>>   
>>               valid_new = stamppresent
>>               for v in valid:
>> @@ -2003,7 +2014,6 @@ class TaskFailure(Exception):
>>       def __init__(self, x):
>>           self.args = x
>>   
>> -
>>   class runQueueExitWait(bb.event.Event):
>>       """
>>       Event when waiting for task processes to exit
>


