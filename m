Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id D87D67D94E
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Apr 2019 02:49:26 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x3Q2mors031461
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 25 Apr 2019 19:49:01 -0700
Received: from localhost.corp.ad.wrs.com (128.224.162.182) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
	14.3.439.0; Thu, 25 Apr 2019 19:48:39 -0700
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	<bitbake-devel@lists.openembedded.org>
References: <cover.1556186399.git.liezhi.yang@windriver.com>
	<d37712258af9b6fedb9e1586ace28908bec88391.1556186399.git.liezhi.yang@windriver.com>
	<9f8a038abf7b7eff75038ccef5f066bfd37e58f5.camel@linuxfoundation.org>
From: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <0c45f88f-6056-2fa6-1db1-f7ce413ba0f3@windriver.com>
Date: Fri, 26 Apr 2019 10:49:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <9f8a038abf7b7eff75038ccef5f066bfd37e58f5.camel@linuxfoundation.org>
Subject: Re: [PATCH 2/2] bitbake: build.py: check dependendent task for addtask
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
X-List-Received-Date: Fri, 26 Apr 2019 02:49:27 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 4/25/19 6:50 PM, Richard Purdie wrote:
> On Thu, 2019-04-25 at 18:01 +0800, Robert Yang wrote:
>> The following command is incorrect, but was ignored silently, that may suprise
>> users:
>>
>> addtask task after task_not_existed
>>
>> This patch can check and warn for it. It would be better to also check "before"
>> tasks, but there is no easier way to do it.
>>
>> [YOCTO #13282]
>>
>> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
>> ---
>>   bitbake/lib/bb/build.py | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
>> index 7571421..861e9a9 100644
>> --- a/bitbake/lib/bb/build.py
>> +++ b/bitbake/lib/bb/build.py
>> @@ -815,6 +815,9 @@ def add_tasks(tasklist, d):
>>           task_deps['parents'][task] = []
>>           if 'deps' in flags:
>>               for dep in flags['deps']:
>> +                # Check and warn for "addtask task after foo" while foo does not exist
>> +                if not dep in tasklist:
>> +                    bb.warn('%s: dependent task %s does not exist!' % (d.getVar('PN'), dep))
>>                   dep = d.expand(dep)
>>                   task_deps['parents'][task].append(dep)
> 
> I can't help wonder if this change has races, depending on the order of
> the addtask and deltask expressions. Do most layers parse cleanly with
> this?

The bb.build.add_tasks() is only called by ast.py's finalize(), I think that
everything should be ready in finalize stage, and there should be no races.
I tested this with meta-oe, python perl, selinux and others, didn't see
any problems (unless I depended on an invalid task).

> 
> At one point bitbake did support "floating" invalid tasks, I can't
> remember if we changed that or not though.

This warning is good for checking typos during development, I think that
user can call "bb.build.addtask()" dynamically in a function to fix the warning
for floating tasks?

// Robert

> 
> Cheers,
> 
> Richard
> 
> 

