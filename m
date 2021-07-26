Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
 by mx.groups.io with SMTP id smtpd.web12.31625.1627314275937787830
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 26 Jul 2021 08:44:36 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bootlin.com, ip: 217.70.183.193, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id CB997240002;
	Mon, 26 Jul 2021 15:44:32 +0000 (UTC)
Cc: docs@lists.yoctoproject.org
Subject: Re: [docs] [bitbake-devel] [PATCH] doc: bitbake-user-manual: fix syntax in example and improve description
From: "Michael Opdenacker" <michael.opdenacker@bootlin.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
References: <20210722171021.69225-1-michael.opdenacker@bootlin.com>
 <a7519c3f91a397c4e4259be88c0ccd76c3b2f037.camel@linuxfoundation.org>
 <16945E9217B4CF53.14473@lists.openembedded.org>
Organization: Bootlin
Message-ID: <ee3b6c49-802c-8840-f8f0-5e47bfb51581@bootlin.com>
Date: Mon, 26 Jul 2021 17:44:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <16945E9217B4CF53.14473@lists.openembedded.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US

Hi Richard,

On 7/23/21 10:35 AM, Michael Opdenacker wrote:
>
> Of course! I was wondering when we are supposed to start updating the
> documentation. Probably right now, indeed, right?
>
>> An example of my scripted conversion run against the manuals is included
>> in this commit:
>>
>> http://git.yoctoproject.org/cgit.cgi/poky-contrib/diff/documentation/ref-manual/variables.rst?h=rpurdie/overrides-convert&id=9ac22a64a4c0ac4640552e90674e6459f0fece9a
> Where can I find the script (or commands) that you used to modify the
> documentation?

I found your script from patch messages
(http://git.yoctoproject.org/cgit.cgi/poky-contrib/commit/?h=rpurdie/overrides-convert&id=f7c5c3bbb9bc5d4c4c8f798d64a020a4504542df),
and it seems to do the job fine. I just had to exclude the migration
guides, but that's easy to do it manually.

How shall I proceed? Shall I send a big patch to
docs@lists.yoctoproject.org for people to review and check that the
output from your script is right?

Thanks in advance
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

