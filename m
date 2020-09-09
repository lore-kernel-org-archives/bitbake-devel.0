Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 by mx.groups.io with SMTP id smtpd.web10.11738.1599652359894697364
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 09 Sep 2020 04:52:40 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: windriver.com, ip: 147.11.1.11, mailfrom: liezhi.yang@windriver.com)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
	by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 089BqbvC002285
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
	Wed, 9 Sep 2020 04:52:37 -0700 (PDT)
Received: from [128.224.162.181] (128.224.162.181) by ALA-HCB.corp.ad.wrs.com
 (147.11.189.41) with Microsoft SMTP Server id 14.3.487.0; Wed, 9 Sep 2020
 04:52:24 -0700
Subject: Re: [bitbake-devel] [PATCH v2 0/3] Fix performance issues for bitbake-layers show-recipes (Saves 95% time)
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        <bitbake-devel@lists.openembedded.org>
References: <cover.1599560025.git.liezhi.yang@windriver.com>
 <e7754a3974063f48276cc06ffec8dee508ae6331.camel@linuxfoundation.org>
From: "Robert Yang" <liezhi.yang@windriver.com>
Message-ID: <36f74178-9bf2-7c39-fe87-f48605862b6a@windriver.com>
Date: Wed, 9 Sep 2020 19:51:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e7754a3974063f48276cc06ffec8dee508ae6331.camel@linuxfoundation.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 9/8/20 11:39 PM, Richard Purdie wrote:
> On Tue, 2020-09-08 at 03:21 -0700, Robert Yang wrote:
>> * V2
>>    - Save prioritized BBFILES to BBFILES_PRIORITIZED
>>
>>    - "bitbake-layers show-recipes" requires 14 min to run which was
>> too slow,
>>      these 3 patches can make it run in 40s which can save 95% time.
>>
>>    - It becomes slow since the following commit:
>>      (85e03a64: tinfoil: Simplify remote datastore connections)
>>
>> * V1
>>    - Initial version
>>
>> // Robert
>>
> 
> Breaks oe-selftest:
> 
> https://autobuilder.yoctoproject.org/typhoon/#/builders/80/builds/1341
> https://autobuilder.yoctoproject.org/typhoon/#/builders/80/builds/1341
> and so on.

I'm sorry, I've fixed the errors and will send a V3.

The self.collection_res should be defined in an init function.

// Robert

> 
> Cheers,
> 
> Richard
> 
> 
> 
> 
