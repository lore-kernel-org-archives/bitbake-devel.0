Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 26DDA7D9CD
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 May 2019 11:02:13 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x4EB2DWc024358
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 14 May 2019 04:02:13 -0700 (PDT)
Received: from localhost.corp.ad.wrs.com (128.224.162.182) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
	14.3.439.0; Tue, 14 May 2019 04:02:00 -0700
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	<bitbake-devel@lists.openembedded.org>
References: <cover.1557388944.git.liezhi.yang@windriver.com>
	<ac4edd962cb6b4831cb85cd731d2d2a810c62503.1557388944.git.liezhi.yang@windriver.com>
	<850ae48669455c75cf34b2306f01add428aa62c0.camel@linuxfoundation.org>
From: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <3fb3e0d9-098f-7fdc-5c3c-9501dfe98af4@windriver.com>
Date: Tue, 14 May 2019 19:02:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <850ae48669455c75cf34b2306f01add428aa62c0.camel@linuxfoundation.org>
Subject: Re: [PATCH 1/1] bitbake: cookerdata: Avoid double exceptions for bb.fatal()
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
X-List-Received-Date: Tue, 14 May 2019 11:02:14 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 5/12/19 4:28 PM, Richard Purdie wrote:
> On Thu, 2019-05-09 at 16:03 +0800, Robert Yang wrote:
>> The bb.fatal() raises BBHandledException() which causes double exceptions,
>> e.g.:
>>
>> Add 'HOSTTOOLS += "hello"' to conf/local.conf:
>> $ bitbake -p
>> [snip]
>> During handling of the above exception, another exception occurred:
>> [snip]
>> ERROR: The following required tools (as specified by HOSTTOOLS) appear to be unavailable in PATH, please install them in order to proceed:
>>    hello
>>
>> Use "raise" rather than "raise bb.BBHandledException" to fix the double
>> exceptions.
>>
>> [YOCTO #13267]
>>
>> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
>> ---
>>   bitbake/lib/bb/cookerdata.py | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/bitbake/lib/bb/cookerdata.py
>> b/bitbake/lib/bb/cookerdata.py
>> index f8ae410..585edc5 100644
>> --- a/bitbake/lib/bb/cookerdata.py
>> +++ b/bitbake/lib/bb/cookerdata.py
>> @@ -301,7 +301,9 @@ class CookerDataBuilder(object):
>>               if multiconfig:
>>                   bb.event.fire(bb.event.MultiConfigParsed(self.mcdata
>> ), self.data)
>>   
>> -        except (SyntaxError, bb.BBHandledException):
>> +        except bb.BBHandledException:
>> +            raise
>> +        except SyntaxError:
>>               raise bb.BBHandledException
>>           except bb.data_smart.ExpansionError as e:
>>               logger.error(str(e))
> 
> Hi Robert,
> 
> This doesn't sound right, where is this exception being printed a
> second time? The point of "BBHandledException" is to say "don't print
> any further traces for this exception". If this fixes the bug, it means
> something somewhere is printing a trace for a second time when it
> should pass through BBHandledException?

Hi RP,

I found another serious problem when tried to raise BBHandledException. There
is a deadlock when a recipe is failed to parse, e.g.:

$ echo helloworld >> meta/recipes-extended/bash/bash_4.4.18.bb
$ bitbake -p
meta/recipes-extended/bash/bash_4.4.18.bb:42: unparsed line: 'helloworld'
[hangs]

Then bitbake hangs, we can use Ctrl-C to break it, but the sub processes
are still existed, and we need kill them manually, otherwise we can't start
bitbake again.

I think that there are two problems:
1) The cooker.py:parse_generator() raises an exception which makes
    one of result_queue or parser_quit have a deadlock, then
    causes the shutdown():process.join() hanged.

2) The sub processes, parser_quit and result_queue are running dependently,
    we can't make sure that cooker.py:Parser():realrun() can get data from
    parser_quit, so there is a race issue, the Parser's subprocess maybe already
    exited before parser_quit sends data to it.

I think that we can move part of parse_next()'s code into parse_generator()
to fix the deadlock problem, and we may need change the working way of
parser_quit. But I'm not sure, I need your suggestions before work on it.

// Robert

> 
> Cheers,
> 
> Richard
> 
> 

