Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web11.8888.1619451530694571572
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 26 Apr 2021 08:38:51 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: michael.opdenacker@bootlin.com)
X-Originating-IP: 92.150.42.106
Received: from [10.0.0.12] (lfbn-mar-1-834-106.w92-150.abo.wanadoo.fr [92.150.42.106])
	(Authenticated sender: michael.opdenacker@bootlin.com)
	by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 88FB0C000B;
	Mon, 26 Apr 2021 15:38:38 +0000 (UTC)
Cc: bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org
Subject: Re: [bitbake-devel] [docs] [PATCH v2] README: update/fix contribution guidelines
To: Quentin Schulz <quentin.schulz@streamunlimited.com>
References: <16788A2044914AF0.27757@lists.openembedded.org>
 <20210423175429.340205-1-michael.opdenacker@bootlin.com>
 <20210426084313.v3ulmf3xk7euu2lm@qschulz>
From: "Michael Opdenacker" <michael.opdenacker@bootlin.com>
Organization: Bootlin
Message-ID: <ddf7b641-150b-e64c-9297-df5d364a1f16@bootlin.com>
Date: Mon, 26 Apr 2021 17:38:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210426084313.v3ulmf3xk7euu2lm@qschulz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US

Hi Quentin,

On 4/26/21 10:43 AM, Quentin Schulz wrote:
> Hi Michael,
>
> On Fri, Apr 23, 2021 at 07:54:29PM +0200, Michael Opdenacker wrote:
>> - Ask to CC the docs@lists.yoctoproject.org mailing list
>> - doc/README: fix the command to generate the manual
>>
> Usually, when you have to make a list in a commit log of things you did,
> it's telling you that there should be multiple commits. Here you two
> changes are not related.
>
> Anyway, that's just me picking nits, I wouldn't have replied if it wasn't
> to give my
>
> Reviewed-by: Quentin Schulz <foss@0leil.net>


Many thanks for your review and for your kind advice. Indeed, the
changes were related to documentation, but independent from each other.
I'll remember that next time

Thanks again, and thanks to Richard for having merged this change into
"master"!

Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

