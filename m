Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web11.5634.1627029346267147081
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 23 Jul 2021 01:35:46 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bootlin.com, ip: 217.70.183.194, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 3064840004;
	Fri, 23 Jul 2021 08:35:43 +0000 (UTC)
Cc: docs@lists.yoctoproject.org
Subject: Re: [docs] [bitbake-devel] [PATCH] doc: bitbake-user-manual: fix syntax in example and improve description
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
References: <20210722171021.69225-1-michael.opdenacker@bootlin.com>
 <a7519c3f91a397c4e4259be88c0ccd76c3b2f037.camel@linuxfoundation.org>
From: "Michael Opdenacker" <michael.opdenacker@bootlin.com>
Organization: Bootlin
Message-ID: <80d7406b-0b12-feaf-7381-56c815062122@bootlin.com>
Date: Fri, 23 Jul 2021 10:35:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <a7519c3f91a397c4e4259be88c0ccd76c3b2f037.camel@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US

Hi Richard,

On 7/23/21 12:14 AM, Richard Purdie wrote:
> I should probably highlight there is a new command, "bitbake-getvar":
>
> http://git.yoctoproject.org/cgit.cgi/poky/commit/?id=7bbeddeee1992d8c8fb71ba2dd49b03d0ae1ce86
>
> We probably want to document that.


Sure, this sounds like a very good idea indeed. I'll take care of that.

>
> Whilst I'm thinking about it, the override discussions on the architecture list
> are going to have implications for documentation too.
>
> http://git.yoctoproject.org/cgit.cgi/poky/commit/?id=75fad23fc06c008a03414a1fc288a8614c6af9ca


Of course! I was wondering when we are supposed to start updating the
documentation. Probably right now, indeed, right?

>
> An example of my scripted conversion run against the manuals is included
> in this commit:
>
> http://git.yoctoproject.org/cgit.cgi/poky-contrib/diff/documentation/ref-manual/variables.rst?h=rpurdie/overrides-convert&id=9ac22a64a4c0ac4640552e90674e6459f0fece9a

Where can I find the script (or commands) that you used to modify the
documentation?

Thanks,
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

