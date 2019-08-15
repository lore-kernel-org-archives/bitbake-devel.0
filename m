Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id DF8937CD73
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Aug 2019 10:54:54 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x7FAsIKm005102
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 15 Aug 2019 03:54:28 -0700
Received: from localhost.localdomain (128.224.162.182) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
	14.3.468.0; Thu, 15 Aug 2019 03:54:07 -0700
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	<bitbake-devel@lists.openembedded.org>
References: <cover.1557388944.git.liezhi.yang@windriver.com>
	<ac4edd962cb6b4831cb85cd731d2d2a810c62503.1557388944.git.liezhi.yang@windriver.com>
	<850ae48669455c75cf34b2306f01add428aa62c0.camel@linuxfoundation.org>
From: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <95b0b779-42a9-5078-1d40-a6ecb0b38294@windriver.com>
Date: Thu, 15 Aug 2019 18:55:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
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
X-List-Received-Date: Thu, 15 Aug 2019 10:54:55 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Hi RP,

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

I think that I've found the root cause, it is because no code handles
BBHandledException during server is starting, so we will *always* get
(double) exceptions when BBHandledException comes during server is starting,
such as call bb.fatal() during parsing configurations files. I will
send a patch to fix it.

// Robert

> 
> Cheers,
> 
> Richard
> 
> 

