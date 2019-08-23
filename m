Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id B97F17D251
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 Aug 2019 03:51:40 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x7N3osFB028507
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 22 Aug 2019 20:51:14 -0700
Received: from localhost.localdomain (128.224.162.182) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
	14.3.468.0; Thu, 22 Aug 2019 20:50:38 -0700
To: Christopher Larson <kergoth@gmail.com>,
	<bitbake-devel@lists.openembedded.org>
References: <cover.1566459309.git.liezhi.yang@windriver.com>
	<3562c905fd50bb986aba8a40778245a026339c93.1566459309.git.liezhi.yang@windriver.com>
	<6c3c318c-9e88-48b6-80c0-b98a8b79e759@Spark>
From: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <556a2ab1-6245-6666-8e0f-080c9de259ef@windriver.com>
Date: Fri, 23 Aug 2019 11:52:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6c3c318c-9e88-48b6-80c0-b98a8b79e759@Spark>
Subject: Re: [PATCH 1/1] bitbake: cooker: Kill alive process before join it
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
X-List-Received-Date: Fri, 23 Aug 2019 03:51:40 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit

Hi Larson,

On 8/22/19 10:14 PM, Christopher Larson wrote:
> Looks like you’re partially duplicating what the ‘force’ logic does already, but 
> for the non-force case as well, yes? process.terminate() sounds a lot like 
> sending a SIGTERM, though admittedly I haven’t read the code to Process 
> recently. Perhaps if this is truly necessary, the logic can be simplified.


The process.join(.1) may also hang if the result_queue is not NULL, but AFAIK ,
this only happens when KeyboardInterrupt or Failed to parse a recipe, so I think
that 'force' shutdown's process.jion(.1) won't hang, and I didn't see it hangs
in the "force" code, we may have another way to make it better, check
result_queue._wlock, but the _wlock is an internal variable, so I gave it up and
just use os.kill() to avoid the hang problem completely, but there might be
side effects that I didn't know?

// Robert

> On Aug 22, 2019, 12:10 AM -0700, Robert Yang <liezhi.yang@windriver.com>, wrote:
>> Fixed:
>> $ echo helloworld >> meta/recipes-extended/bash/bash_4.4.18.bb
>> $ while true; do kill-bb; rm -fr bitbake-cookerdaemon.log 
>> tmp/cache/default-glibc/qemux86-64/x86_64/bb_cache.dat* ; bitbake -p; done
>>
>> It may hang in 10 mins, there are two problems:
>> * There might be deadlocks when call process.join() if the queue is not NULL,
>> so we need cleanup the queue before join() it, but:
>> * The self.result_queue.get(timeout=0.25) may hang if the queue._wlock is hold
>> by SomeOtherProcess, the queue has the following info when it hangs:
>> '_wlock': <Lock(owner=SomeOtherProcess)>, so that we may can't clean up the
>> queue.
>>
>> We can kill alvie process before join it to fix the problems.
>>
>> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
>> ---
>> bitbake/lib/bb/cooker.py | 12 ++++--------
>> 1 file changed, 4 insertions(+), 8 deletions(-)
>>
>> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
>> index 0607fcc..e42bcba 100644
>> --- a/bitbake/lib/bb/cooker.py
>> +++ b/bitbake/lib/bb/cooker.py
>> @@ -2082,19 +2082,15 @@ class CookerParser(object):
>> for process in self.processes:
>> self.parser_quit.put(None)
>>
>> - # Cleanup the queue before call process.join(), otherwise there might be
>> - # deadlocks.
>> - while True:
>> - try:
>> - self.result_queue.get(timeout=0.25)
>> - except queue.Empty:
>> - break
>> -
>> for process in self.processes:
>> if force:
>> process.join(.1)
>> process.terminate()
>> else:
>> + # Kill the alive process firstly before join() it to avoid
>> + # deadlocks
>> + if process.is_alive():
>> + os.kill(process.pid, 9)
>> process.join()
>>
>> sync = threading.Thread(target=self.bb_cache.sync)
>> --
>> 2.7.4
>>
>> --
>> _______________________________________________
>> bitbake-devel mailing list
>> bitbake-devel@lists.openembedded.org
>> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

