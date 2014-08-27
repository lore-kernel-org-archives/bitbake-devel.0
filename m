Return-Path: <Hongxu.Jia@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 4B02C710CD
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 11:03:30 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail.windriver.com (8.14.9/8.14.5) with ESMTP id s7RB2tia014258
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 27 Aug 2014 04:02:55 -0700 (PDT)
Received: from [128.224.162.194] (128.224.162.194) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.174.1;
	Wed, 27 Aug 2014 04:02:55 -0700
Message-ID: <53FDBAD7.9010403@windriver.com>
Date: Wed, 27 Aug 2014 19:02:47 +0800
From: Hongxu Jia <hongxu.jia@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:31.0) Gecko/20100101 Thunderbird/31.0
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <cover.1409136202.git.hongxu.jia@windriver.com>	
	<4ce3cc607c61c23904de8f3844e7e8b360375557.1409136202.git.hongxu.jia@windriver.com>
	<1409136574.5772.37.camel@ted>
In-Reply-To: <1409136574.5772.37.camel@ted>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] bitbake: runqueue: terminate build safely while RunQueueExecuteScenequeue init failed
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
X-List-Received-Date: Wed, 27 Aug 2014 11:03:33 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 08/27/2014 06:49 PM, Richard Purdie wrote:
> On Wed, 2014-08-27 at 18:44 +0800, Hongxu Jia wrote:
>> While RunQueueExecuteScenequeue init failed, the exit of build is mess.
>> Here is the example while bb.fatal invoked in RunQueueExecuteScenequeue:
>> ...
>> Traceback (most recent call last):
>> |  File "/home/jiahongxu/yocto/poky/bitbake/lib/bb/runqueue.py",
>>    line 1824, in RunQueueExecuteScenequeue.__init__(rq=<bb.runqueue.RunQueue
>>    instance at 0x7f87dd7d5050>):
>> |                 locs = { "sq_fn" : sq_fn, "sq_task" : sq_taskname,
>>    "sq_hash" : sq_hash, "sq_hashfn" : sq_hashfn, "d" : self.cooker.data }
>> |    >            valid = bb.utils.better_eval(call, locs)
>>
>> |    def better_eval(source, locals):
>> |    >    return eval(source, get_context(), locals)
>>
>> |  File "<string>", line 1, in <module>
>> |  File "/home/jiahongxu/yocto/poky/bitbake/lib/bb/__init__.py", line 102,
>>    in fatal:
>> |         logger.critical(''.join(args))
>> |    >    raise BBHandledException()
>>
>> BBHandledException
>> ...
>>
>> We should terminate build safely while RunQueueExecuteScenequeue init failed.
>>
>> Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
>> ---
>>   bitbake/lib/bb/runqueue.py | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
>> index e13dc57..c7b1dc0 100644
>> --- a/bitbake/lib/bb/runqueue.py
>> +++ b/bitbake/lib/bb/runqueue.py
>> @@ -1046,7 +1046,12 @@ class RunQueue:
>>                   self.state = runQueueComplete
>>               else:
>>                   self.start_worker()
>> -                self.rqexe = RunQueueExecuteScenequeue(self)
>> +                try:
>> +                    self.rqexe = RunQueueExecuteScenequeue(self)
>> +                except:
>> +                    # The RunQueueExecuteScenequeue init failure
>> +                    # terminated the build safely
>> +                    self.state = runQueueComplete
>>   
> If the init fails, shouldn't we show a traceback and exit with an error
> status? Does this happen in a normal build and if so, is there an
> underlying cause we should fix?

In my case, I want to catch the failure of self.rq.hashvalidate which
invoked in RunQueueExecuteScenequeue, and exit in a normal build.

>
> I'm worried this would let errors go unnoticed. Except clauses in
> general should catch specific errors not every exception so this really
> can't merge in this form, sorry.

Got it, I will add condition to catch the failure of self.rq.hashvalidate,
and don't affect other errors.

Thanks,
//Hongxu

> Cheers,
>
> Richard
>
>


