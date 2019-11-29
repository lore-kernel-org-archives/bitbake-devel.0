Return-Path: <Kai.Kang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id AAC406C216
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 29 Nov 2019 01:11:21 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id xAT1BLtr009539
	(version=TLSv1 cipher=AES256-SHA bits=256 verify=FAIL);
	Thu, 28 Nov 2019 17:11:21 -0800
Received: from [128.224.162.183] (128.224.162.183) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.468.0;
	Thu, 28 Nov 2019 17:11:20 -0800
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	<bitbake-devel@lists.openembedded.org>
References: <20191128092718.13336-1-kai.kang@windriver.com>
	<140ccb87e6820c4daea903644f43b178a8541a26.camel@linuxfoundation.org>
From: Kang Kai <Kai.Kang@windriver.com>
Message-ID: <8d9471d6-9b96-a0ed-91fe-84faa7ced515@windriver.com>
Date: Fri, 29 Nov 2019 09:11:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <140ccb87e6820c4daea903644f43b178a8541a26.camel@linuxfoundation.org>
Subject: Re: [PATCH] runqueue: add mc to pending hash index
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
X-List-Received-Date: Fri, 29 Nov 2019 01:11:21 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US

On 2019/11/29 上午1:51, Richard Purdie wrote:
> On Thu, 2019-11-28 at 17:27 +0800, kai.kang@windriver.com wrote:
>> From: Kai Kang <kai.kang@windriver.com>
>>
>> When build multiconfig target by following steps in section "Enabling
>> Multiple Configuration Build Dependencies" in yocto dev-manual which
>> adds dependency between multiconfig targets:
>>
>> do_image[mcdepends] = "mc:x86:arm:core-image-minimal:do_rootfs"
>>
>> it shows a lot of warnings, such as:
>>
>>> WARNING: Deferring
>>>    mc:x86:virtual:native:/path/to/meta/recipes-
>>> support/nss/nss_3.45.bb:do_populate_sysroot
>>>    after
>>>    mc:arm:virtual:native:/path/to/meta/recipes-
>>> support/nss/nss_3.45.bb:do_populate_sysroot
>> In function pending_hash_index it only checks PN, taskname and hash.
>> But
>> they are same for multiconfig native and allarch packages. Add
>> multiconfig
>> to pending hash index too to make the index unique.
>>
>> Ref:
>> https://www.yoctoproject.org/docs/latest/dev-manual/dev-manual.html#dev-enabling-multiple-configuration-build-dependencies
>>
>> Signed-off-by: Kai Kang <kai.kang@windriver.com>
> This patch completes defeats the point of this code, disabling it. Its
> the wrong thing to do, we want this code to be active.
>
> The bug is that this should not be a warning, probably just a note.
>
> We need it to be a note so that we can tell the mechanism is in action
> from build output logs.

I have sent a patch to change from warning to note. But without 
comment,  I thought it should be fixed in this function.
Would you like to review the patch "runqueue.py: not show warning for 
deferred multiconfig task" on Oct 17, please?

Thanks,
Kai



>
> Cheers,
>
> Richard
>
>> ---
>>   bitbake/lib/bb/runqueue.py | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
>> index 485d9341f5..059eb9e283 100644
>> --- a/bitbake/lib/bb/runqueue.py
>> +++ b/bitbake/lib/bb/runqueue.py
>> @@ -69,12 +69,12 @@ def build_tid(mc, fn, taskname):
>>       return fn + ":" + taskname
>>   
>>   # Index used to pair up potentially matching multiconfig tasks
>> -# We match on PN, taskname and hash being equal
>> +# We match on mc, PN, taskname and hash being equal
>>   def pending_hash_index(tid, rqdata):
>>       (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
>>       pn = rqdata.dataCaches[mc].pkg_fn[taskfn]
>>       h = rqdata.runtaskentries[tid].unihash
>> -    return pn + ":" + "taskname" + h
>> +    return mc + ":" + pn + ":" + "taskname" + h
>>   
>>   class RunQueueStats:
>>       """
>> -- 
>> 2.17.1
>>
>

-- 
Kai Kang


