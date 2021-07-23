Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
 by mx.groups.io with SMTP id smtpd.web10.8313.1627047455088874635
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 23 Jul 2021 06:37:35 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bootlin.com, ip: 217.70.183.200, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id C3EB32000B;
	Fri, 23 Jul 2021 13:37:32 +0000 (UTC)
Subject: Re: [bitbake-devel] disable do_fetch
To: Mayank Agarwal <mayank77fromindia@gmail.com>,
 bitbake-devel@lists.openembedded.org
References: <CAKjpqyKE2teAWB5wc=6RU5_CASExfA2oXpyHNWJ5TRw2kxwntQ@mail.gmail.com>
From: "Michael Opdenacker" <michael.opdenacker@bootlin.com>
Organization: Bootlin
Message-ID: <03d28ae2-1e99-a50c-13ea-c55d6d9cf41a@bootlin.com>
Date: Fri, 23 Jul 2021 15:37:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAKjpqyKE2teAWB5wc=6RU5_CASExfA2oXpyHNWJ5TRw2kxwntQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US

Hi Mayank

On 7/22/21 3:27 PM, Mayank Agarwal wrote:
> Hi all,
>
> I am compiling simple c file given in file folder using simple recipe that
> has do_compil() and do_install functions.
> But i am getting fetcher failure error:
>
> I don't want to execute do_fetch(),for that i am giving 
> do_fetch[noexec] = "1"
>
> but it is not taking affect.

Could you share your recipe? It may help.
You didn't share your fetcher failure either.
Cheers,
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

