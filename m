Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web10.22.1619200809850425236
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 23 Apr 2021 11:00:10 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bootlin.com, ip: 217.70.183.201, mailfrom: michael.opdenacker@bootlin.com)
X-Originating-IP: 109.210.254.211
Received: from [192.168.1.25] (amontpellier-552-1-199-211.w109-210.abo.wanadoo.fr [109.210.254.211])
	(Authenticated sender: michael.opdenacker@bootlin.com)
	by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id C4FF51BF203;
	Fri, 23 Apr 2021 18:00:07 +0000 (UTC)
Subject: Re: [bitbake-devel] [PATCH] README: update/fix contribution guidelines
To: Martin Jansa <martin.jansa@gmail.com>,
 bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org
References: <20210423163108.338904-1-michael.opdenacker@bootlin.com>
 <167889E551A803AE.3436@lists.openembedded.org>
 <20210423164117.xf4qafojdrqrezll@jama>
From: "Michael Opdenacker" <michael.opdenacker@bootlin.com>
Organization: Bootlin
Message-ID: <5d9240f6-d837-609b-5344-6f1bcf038d7b@bootlin.com>
Date: Fri, 23 Apr 2021 20:00:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210423164117.xf4qafojdrqrezll@jama>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Content-Language: en-US

Hi Martin,

On 4/23/21 6:41 PM, Martin Jansa wrote:
> On Fri, Apr 23, 2021 at 06:34:41PM +0200, Martin Jansa via lists.openembedded.org wrote:
>> On Fri, Apr 23, 2021 at 06:31:08PM +0200, Michael Opdenacker wrote:
>>> - Ask to CC the docs@lists.yoctoproject.org mailing list
>> it adds 2nd --to
>>
>> which is probably fine, just doesn't match with commit message
> And more surprisingly this e-mail to docs@lists.yoctoproject.org was
> rejected with:
>
>
> Message not delivered
> Your message couldn't be delivered to docs@lists.yoctoproject.org
> because the remote server is misconfigured. See technical details below
> for more information.
> LEARN MORE
> WarningThis link will take you to a third-party site

Oops, that's ugly indeed.  Unfortunately, our lists are hosted on
Groups.io, so our ability to fix this is limited.

>
> The response from the remote server was:
> 510 5.1.1 Your email address, martin.jansa@gmail.com, is not subscribed
> to that group. To subscribe, send an email to
> docs+subscribe@lists.yoctoproject.org, or visit
> https://lists.yoctoproject.org/g/docs


This is also a bit uncomfortable to ask people to do us a favor and CC a
list that only accepts post from members...

Thoughts anyone?

Cheers,

Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

