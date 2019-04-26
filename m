Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id A61207D8D1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Apr 2019 03:17:22 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x3Q3HLHV018667
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 25 Apr 2019 20:17:21 -0700 (PDT)
Received: from localhost.corp.ad.wrs.com (128.224.162.182) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
	14.3.439.0; Thu, 25 Apr 2019 20:17:20 -0700
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	<bitbake-devel@lists.openembedded.org>
References: <cover.1556186399.git.liezhi.yang@windriver.com>
	<793cb29db2286f072e1cc1f73a11b89ac3168196.1556186399.git.liezhi.yang@windriver.com>
	<c7e5005a5f24dd70c6a2d59922c43ce07ba41fe2.camel@linuxfoundation.org>
From: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <ff25b67b-bd58-f49f-e3b7-538f55eb682b@windriver.com>
Date: Fri, 26 Apr 2019 11:17:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c7e5005a5f24dd70c6a2d59922c43ce07ba41fe2.camel@linuxfoundation.org>
Subject: Re: [PATCH 1/2] bitbake: BBHandler: Fix addtask and deltask
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
X-List-Received-Date: Fri, 26 Apr 2019 03:17:22 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 4/25/19 6:48 PM, Richard Purdie wrote:
> On Thu, 2019-04-25 at 18:00 +0800, Robert Yang wrote:
>> The following commands are not supported, but they were ignored
>> silently, that
>> may suprise users:
>>
>> * addtask task1 task2
>>    task2 is ignored
>>
>> * addtask task1 before task2 before task3
>>    Should be: addtask task1 before task2 task3
>>
>> * addtask task1 after task2 after task3
>>    Should be: addtask task1 after task2 task3
>>
>> * deltask task1 task2
>>    task2 is ignore
>>
>> This patch can check and warn for them.
>>
>> [YOCTO #13282]
>>
>> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
>> ---
>>   bitbake/lib/bb/parse/parse_py/BBHandler.py | 25
>> ++++++++++++++++++++++++-
>>   1 file changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/bitbake/lib/bb/parse/parse_py/BBHandler.py
>> b/bitbake/lib/bb/parse/parse_py/BBHandler.py
>> index 9dba5f2..4d90ff0 100644
>> --- a/bitbake/lib/bb/parse/parse_py/BBHandler.py
>> +++ b/bitbake/lib/bb/parse/parse_py/BBHandler.py
>> @@ -42,7 +42,7 @@ __func_start_regexp__    =
>> re.compile(r"(((?P<py>python)|(?P<fr>fakeroot))\s*)*(
>>   __inherit_regexp__       = re.compile(r"inherit\s+(.+)" )
>>   __export_func_regexp__   = re.compile(r"EXPORT_FUNCTIONS\s+(.+)" )
>>   __addtask_regexp__       =
>> re.compile(r"addtask\s+(?P<func>\w+)\s*((before\s*(?P<before>((.*(?=a
>> fter))|(.*))))|(after\s*(?P<after>((.*(?=before))|(.*)))))*")
>> -__deltask_regexp__       = re.compile(r"deltask\s+(?P<func>\w+)")
>> +__deltask_regexp__       =
>> re.compile(r"deltask\s+(?P<func>\w+)(?P<ignores>.*)")
>>   __addhandler_regexp__    = re.compile(r"addhandler\s+(.+)" )
>>   __def_regexp__           = re.compile(r"def\s+(\w+).*:" )
>>   __python_func_regexp__   = re.compile(r"(\s+.*)|(^$)|(^#)" )
>> @@ -236,11 +236,34 @@ def feeder(lineno, s, fn, root, statements,
>> eof=False):
>>   
>>       m = __addtask_regexp__.match(s)
>>       if m:
>> +        if len(m.group().split()) == 2:
>> +            # Check and warn for "addtask task1 task2"
>> +            m2 = re.match(r"addtask\s+(?P<func>\w+)(?P<ignores>.*)",
>> s)
>> +            if m2 and m2.group('ignores'):
>> +                logger.warning('addtask ignored: "%s"' %
>> m2.group('ignores'))
>> +
>> +        # Check and warn for "addtask task1 before task2 before
>> task3", the
>> +        # similar to "after"
>> +        dup_after = 0
>> +        dup_before = 0
>> +        for tmp in s.split():
>> +            if 'before' == tmp:
>> +                dup_before += 1
>> +            if 'after' == tmp:
>> +                dup_after += 1
>> +        if dup_after > 1:
> 
> taskexpression = s.split()
> if taskexpression.count("after") > 1:
>     
> logger.warning("X")
> if taskexpression.count("before") > 1:
>     
> logger.warning("Y")
> 
>> +            logger.warning('addtask found more than 1 keyword
>> "after": "%s"' % s)
> 
> How about:
> 
> addtask contained multiple 'after' keywords, only one is supported
> 
>> +        if dup_before > 1:
>> +            logger.warning('addtask found more than 1 keyword
>> "before": "%s"' % s)
> 
> and:
> 
> addtask contained multiple 'before' keywords, only one is supported

Thanks for all the replies above, I will fix them.

> 
>>           ast.handleAddTask(statements, fn, lineno, m)
>>           return
>>   
>>       m = __deltask_regexp__.match(s)
>>       if m:
>> +        # Check and warn "for deltask task1 task2"
>> +        if m.group('ignores'):
>> +            logger.warning('deltask ignored: "%s"' %
>> m.group('ignores'))
> 
> deltask listing multiple tasks is not supported
> 
> I did wonder if we should support multiple tasks for deltask?

Yes, that's a good idea, but if we support "deltask multiple tasks",
I think that we should also support "addtask multiple tasks" since
they are a pair, but I have other concerns on addtask, for example,
the following code is hard to read and maintain:

__addtask_regexp__       = 
re.compile(r"addtask\s+(?P<func>\w+)\s*((before\s*(?P<before>((.*(?=after))|(.*))))|(after\s*(?P<after>((.*(?=before))|(.*)))))*")

I think that we need break it into small pieces. so I gave it up with these
concerns which looks risky.

> 
> Also, we might want to consider adding something to lib/bb/tests/ for
> this?

Thanks, I will add it.

// Robert

> 
> Cheers,
> 
> Richard
> 
> 

