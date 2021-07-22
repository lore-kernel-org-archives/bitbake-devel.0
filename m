Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
 by mx.groups.io with SMTP id smtpd.web09.5366.1626944646655671709
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 22 Jul 2021 02:04:07 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bootlin.com, ip: 217.70.183.199, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 79B9FFF805;
	Thu, 22 Jul 2021 09:04:04 +0000 (UTC)
Cc: YP docs mailing list <docs@lists.yoctoproject.org>
Subject: Re: [bitbake-devel] [docs] DEFAULT_PREFERENCE no longer used?
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 BitBake developer list <bitbake-devel@lists.openembedded.org>
References: <53a7dab9-2c9c-ce0b-b363-543c33959e62@bootlin.com>
 <f6e86401ad6f2077133a7d989fc32c34547d24eb.camel@linuxfoundation.org>
From: "Michael Opdenacker" <michael.opdenacker@bootlin.com>
Organization: Bootlin
Message-ID: <79035258-333d-3768-53d9-8b240b013251@bootlin.com>
Date: Thu, 22 Jul 2021 11:04:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f6e86401ad6f2077133a7d989fc32c34547d24eb.camel@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US

Hi Richard,

On 7/22/21 10:59 AM, Richard Purdie wrote:
> On Thu, 2021-07-22 at 10:55 +0200, Michael Opdenacker wrote:
>> Greetings,
>>
>> Looking at the code, it seems that the DEFAULT_PREFERENCE variable is no
>> longer in use. Unless I missed something, the variable is still read,
>> but not taken into account any more, and there are just two recipes that
>> set it.
>>
>> The BitBake documentation still refers to it though.
>>
>> May I propose documentation and code patches to remove it for good?
> I think it is still used:
>
> lib/bb/cache.py:        self.defaultpref = self.intvar('DEFAULT_PREFERENCE', metadata)
> lib/bb/cache.py:        cachedata.pkg_dp[fn] = self.defaultpref
> lib/bb/providers.py:        preference = dataCache.pkg_dp[f]


Oops, I read too quickly then, overlooking the second line.
Thanks for proving me wrong :)

Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

