Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 by mx.groups.io with SMTP id smtpd.web10.6050.1596107938508730859
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Jul 2020 04:18:58 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: windriver.com, ip: 147.11.146.13, mailfrom: liezhi.yang@windriver.com)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id 06UBIumJ023549
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
	Thu, 30 Jul 2020 04:18:56 -0700 (PDT)
Received: from [128.224.162.181] (128.224.162.181) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.487.0; Thu, 30 Jul 2020
 04:18:55 -0700
Subject: Re: [bitbake-devel] [PATCH 1/3] cooker.py: Save prioritized BBFILES
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        <bitbake-devel@lists.openembedded.org>
References: <20200730092342.7420-1-liezhi.yang@windriver.com>
 <dee49e85c1eab606b528add87d52af439ad898b0.camel@linuxfoundation.org>
From: "Robert Yang" <liezhi.yang@windriver.com>
Message-ID: <4f0a4755-5547-4b7d-fc31-5c1ac43b55d1@windriver.com>
Date: Thu, 30 Jul 2020 19:17:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <dee49e85c1eab606b528add87d52af439ad898b0.camel@linuxfoundation.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 7/30/20 6:37 PM, Richard Purdie wrote:
> On Thu, 2020-07-30 at 02:23 -0700, Robert Yang wrote:
>> The original code saved BBFILES back to BBFILES without changes, I think that
>> it was for avoiding undefined BBFILES. Now save prioritized BBFILES back which
>> is more usable for the one which requires it such as bb.utils.get_file_layer().
>>
>> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
>> ---
>>   lib/bb/cooker.py | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
>> index 3a58a3a33..5571e5312 100644
>> --- a/bitbake/lib/bb/cooker.py
>> +++ b/bitbake/lib/bb/cooker.py
>> @@ -1738,10 +1738,10 @@ class CookerCollectFiles(object):
>>           collectlog.debug(1, "collecting .bb files")
>>   
>>           files = (config.getVar( "BBFILES") or "").split()
>> -        config.setVar("BBFILES", " ".join(files))
> 
> I traced that back to 2007 but didn't go further. I don't think we
> should be writing this value back at all. Its going to confuse anyone
> trying to understand the history of the data in the variable.
> 
>>           # Sort files by priority
>>           files.sort( key=lambda fileitem: self.calc_bbfile_priority(fileitem)[0] )
>> +        config.setVar("BBFILES", " ".join(files))
> 
> If we want to make this information available to the wider system, we
> should perhaps have bitbake API for querying these kinds of things?

This prioritized BBFILES can improve the performance, for example, if
BBFILES has no priority, the "bitbake-layers show-recipes"s' time would
increase from 40s to 110s in my testing.

Did you mean something like bb.utils.get_prioritized_bbfiles(), please?

// Robert


> 
> Cheers,
> 
> Richard
> 
