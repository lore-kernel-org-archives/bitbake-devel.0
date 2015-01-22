Return-Path: <Chong.Lu@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 6E4DA65C7B
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Jan 2015 01:36:11 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.9/8.14.5) with ESMTP id t0M1aAGe020204
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
	Wed, 21 Jan 2015 17:36:10 -0800 (PST)
Received: from [128.224.162.204] (128.224.162.204) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.174.1;
	Wed, 21 Jan 2015 17:36:09 -0800
Message-ID: <54C05406.80103@windriver.com>
Date: Thu, 22 Jan 2015 09:36:06 +0800
From: Chong Lu <Chong.Lu@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:24.0) Gecko/20100101 Thunderbird/24.0
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <cover.1421657244.git.Chong.Lu@windriver.com>	
	<dcc1cd29cdf4dbcf242fda70bbd03fe9a2e84263.1421657244.git.Chong.Lu@windriver.com>
	<1421848488.1798.55.camel@linuxfoundation.org>
In-Reply-To: <1421848488.1798.55.camel@linuxfoundation.org>
X-Originating-IP: [128.224.162.204]
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] bitbake: prserv/serv: sync database after thead quit
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
X-List-Received-Date: Thu, 22 Jan 2015 01:36:19 -0000
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit


On 01/21/2015 09:54 PM, Richard Purdie wrote:
> On Mon, 2015-01-19 at 16:48 +0800, Chong Lu wrote:
>> We need sync database after thread quit, else we may get a empty table
>> after import a PR database.
>>
>> [YOCTO #6752]
>>
>> Signed-off-by: Chong Lu <Chong.Lu@windriver.com>
>> ---
>>   bitbake/lib/prserv/serv.py | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/bitbake/lib/prserv/serv.py b/bitbake/lib/prserv/serv.py
>> index 25eb46a..c774c5e 100644
>> --- a/bitbake/lib/prserv/serv.py
>> +++ b/bitbake/lib/prserv/serv.py
>> @@ -87,7 +87,7 @@ class PRServer(SimpleXMLRPCServer):
>>                   self.finish_request(request, client_address)
>>                   self.shutdown_request(request)
>>                   iter_count = (iter_count + 1) % iterations_between_sync
>> -                if iter_count == 0:
>> +                if iter_count == 0 or self.quit:
>>                       self.table.sync_if_dirty()
>>               except:
>>                   self.handle_error(request, client_address)
> Thanks for the patch. I had a look at this problem and I think there are
> bigger problems with the code. Can you take a look at the patch I've
> just posted, it should solve this issue as well as several others.
>
> Cheers,
>
> Richard
>

Hi Richard,

I try your patch in my environment, it can fix [YOCTO #6752].
Thanks for your improve.

Best Regards
Chong

>


