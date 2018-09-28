Return-Path: <akuster808@gmail.com>
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
	[209.85.210.194])
	by mail.openembedded.org (Postfix) with ESMTP id 47FEA799D1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Sep 2018 16:08:47 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id s5-v6so4630820pfj.7
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Sep 2018 09:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=Lw+Fsfu8DQvuVRl8yGsagoyu4U0zLXJeYLZYtWvqAVw=;
	b=Uv2d4NwH4xOHNLfoMBWKmrENJRThe9I9H1bQVxg7lPxnhLNJ4nBuKCwpNj1cYh/igq
	Ge/zwZ3iwFh8bT0DMApNA++gUJQIylrenAPXLBX0jbv7kc85K4wQW/mKt+q+Gi/IE+e9
	n9Y4aJjGn3Np1BD03nSyi5FZPvZf6qR7KdUMBQstHIaRIwZ4tRNmLB953/6EoGZDnhgE
	rOXTQ0kpr4L59p3HuyeBRllIWIFxCpTSuaY0mOdmNZh8uSbjvWfYFpipBMdsya/NAKLI
	1ruwf9YgGNQm/NaYWjNh9Kax6KMuw1S2UFgQdjFI7Z6PtMnj2kNlSUjBG7yxl9iasCfT
	TRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
	:message-id:date:user-agent:mime-version:in-reply-to
	:content-transfer-encoding:content-language;
	bh=Lw+Fsfu8DQvuVRl8yGsagoyu4U0zLXJeYLZYtWvqAVw=;
	b=XFZ7dCh9gpu25JJhVwlJiClecrbCgVyKmSerFtSIjQhrqh0E1eLxZfl7sOw/pAvUvz
	8VBBeteE4fiJ0EJ52CGA5GCJG1clTvCXvNvYAJxf6f9UQUQhBuT9VFs98ZjVzOSNrVAU
	+xk90gcKARXcfEPUv8E29StYmEEPm4120NedOKyJJBPZUjz/DQSi7gp56EnalZUP7yat
	sVkmuecYSTGasbwlqw/HBQapVy4mplBHr/kEmUMGFuy8HTkhx3XL1jruM9p1AxsrbaWZ
	dp0dFmybVXRuKX8ubTnHWA9H8YyDZAGaEOJSfJITNT5/MIxRfdNbl77f2qLNckCYznii
	O5CQ==
X-Gm-Message-State: ABuFfohvUEW40fpJPHHFHMGsyhR492gDPTwQMOfljv5dt1r4ot+adohb
	3m/Ynfs8AjBYGeP+1J2TCiP1Bu3L
X-Google-Smtp-Source: ACcGV63cr35yorm4IuS1t30ht7bzyoXNlNXAGMyOZVTBFrlAF2NYH0amXOWS8fhxhG/NJ5ar6fHvWw==
X-Received: by 2002:a63:b95e:: with SMTP id
	v30-v6mr15540430pgo.221.1538150928251; 
	Fri, 28 Sep 2018 09:08:48 -0700 (PDT)
Received: from ?IPv6:2601:202:4180:c33:e960:91d2:2331:2d71?
	([2601:202:4180:c33:e960:91d2:2331:2d71])
	by smtp.gmail.com with ESMTPSA id
	t12-v6sm6548185pgg.72.2018.09.28.09.08.47
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 28 Sep 2018 09:08:47 -0700 (PDT)
To: "Belal, Awais" <Awais_Belal@mentor.com>,
	"richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>, 
	"Reyna, David" <david.reyna@windriver.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
References: <1536831336527.93802@mentor.com>
	<5E53D14CE4667A45B9A06760DE5D13D0F3AC15D6@ALA-MBD.corp.ad.wrs.com>
	<1537430385445.98207@mentor.com> <1538034849901.46023@mentor.com>
	<f3a9349906015f5961c688f27b82fa92967e5510.camel@linuxfoundation.org>
	<1538120253384.1227@mentor.com>
	<573089240e7086a6091c1123454a842cec4cff78.camel@linuxfoundation.org>
	<1538131095353.74870@mentor.com>
From: akuster808 <akuster808@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=akuster808@gmail.com; prefer-encrypt=mutual; keydata=
	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
	8CS2NxU=
Message-ID: <816315bc-4572-6c96-9872-8f19bf511eb1@gmail.com>
Date: Fri, 28 Sep 2018 09:08:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1538131095353.74870@mentor.com>
Subject: Re: [sumo][PATCH] toaster: localhostbecontroller: fix bitbake path resolution
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
X-List-Received-Date: Fri, 28 Sep 2018 16:08:47 -0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US



On 09/28/2018 03:38 AM, Belal, Awais wrote:
>>> The patch doesn't apply to master so could you send a version which
>>> applies there please?
>>> I can then apply the sumo one at the same time which does presumably
>>> apply to sumo (I've not tried that as yet).
> Extremely sorry, this is only needed for sumo (1.38), master doesn't have this problem.

This does not apply to sumo either. We have the commit it depends on:

c1f5ec8 bitbake: toaster: use a more flexible way to find bitbake

- armin

>
>
>
> BR,
> Awais
>
> ________________________________________
> From: richard.purdie@linuxfoundation.org <richard.purdie@linuxfoundation.org>
> Sent: Friday, September 28, 2018 12:52 PM
> To: Belal, Awais; Reyna, David; bitbake-devel@lists.openembedded.org
> Subject: Re: [bitbake-devel] [sumo][PATCH] toaster: localhostbecontroller: fix bitbake path resolution
>
> On Fri, 2018-09-28 at 07:37 +0000, Belal, Awais wrote:
>>>> I'm confused. Does master need the patch? or only sumo?
>> Both.
> The patch doesn't apply to master so could you send a version which
> applies there please?
>
> I can then apply the sumo one at the same time which does presumably
> apply to sumo (I've not tried that as yet).
>
> Thanks,
>
> Richard


