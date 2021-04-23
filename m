Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web10.2079.1619195936701752149
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 23 Apr 2021 09:38:57 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: michael.opdenacker@bootlin.com)
X-Originating-IP: 92.150.42.106
Received: from [10.0.0.12] (lfbn-mar-1-834-106.w92-150.abo.wanadoo.fr [92.150.42.106])
	(Authenticated sender: michael.opdenacker@bootlin.com)
	by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id CD2E2C0010;
	Fri, 23 Apr 2021 16:38:44 +0000 (UTC)
Cc: michael.opdenacker@bootlin.com, bitbake-devel@lists.openembedded.org,
 docs@lists.yoctoproject.org
Subject: Re: [bitbake-devel] [PATCH] README: update/fix contribution guidelines
To: Martin Jansa <martin.jansa@gmail.com>
References: <20210423163108.338904-1-michael.opdenacker@bootlin.com>
 <20210423163441.zyojiy5w3b2kp3ao@jama>
From: "Michael Opdenacker" <michael.opdenacker@bootlin.com>
Organization: Bootlin
Message-ID: <45815b7c-debd-edd0-8f7c-9f62a17fb2eb@bootlin.com>
Date: Fri, 23 Apr 2021 18:38:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210423163441.zyojiy5w3b2kp3ao@jama>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US


On 4/23/21 6:34 PM, Martin Jansa wrote:
> On Fri, Apr 23, 2021 at 06:31:08PM +0200, Michael Opdenacker wrote:
>> - Ask to CC the docs@lists.yoctoproject.org mailing list
> it adds 2nd --to
>
> which is probably fine, just doesn't match with commit message


Oops, I'll fix this. Good catch!

Thanks

Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

