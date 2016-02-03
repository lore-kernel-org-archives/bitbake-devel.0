Return-Path: <raj.khem@gmail.com>
Received: from mail-io0-f174.google.com (mail-io0-f174.google.com
	[209.85.223.174])
	by mail.openembedded.org (Postfix) with ESMTP id A804D770C4;
	Wed,  3 Feb 2016 14:42:58 +0000 (UTC)
Received: by mail-io0-f174.google.com with SMTP id f81so57126839iof.0;
	Wed, 03 Feb 2016 06:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type;
	bh=X1/x1j5uZeskGTMeuCVLcJOL04Xba2fjFovt39Pw/dM=;
	b=MnANzKvI0BswF01LnG84jUshG1DdKpbL6lszEpaYpGIDDKZiitItq5vOsAmXY7cdZw
	zeKHDD4XlyFbvWrDi/+frLJXqsVB6aPS72e5GeZOgriXuk6hXf1Cir6V+/SXCLODLot9
	ewlmh0tzB6SkuAgnecVT+42i2hTDnvqwH1hk728xeHSXfJLip1QnrV85Yyb/+biUp/8x
	lrE6Ugk+Sd/Cbi/O9T2CubhF3hNtTpfjHGbRX81hcflLV5hE0gTmNK/teDvhFMsRun//
	DKpI0b0zRNOmXKwyTCeseuUi2jwnc+bx4NVb99SpyODA9oITjbRJs7/nenkjecanItkL
	pTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=X1/x1j5uZeskGTMeuCVLcJOL04Xba2fjFovt39Pw/dM=;
	b=dUshynfUVayoDCkdoVUVVzD6/2xdbZuQ/IgUDTDvrBzMmofbSJgXIPzhdV6RG9EcKI
	5kxlK/FQ52D/RkIGIY49u3Ov3wDbd0ZLl01P8eINlXWk7bffBxt5IKoJb8yh1Itefvvw
	mHVDbaXQO36Wyr57j7Yrt68f836lxckGY6CKkB9CvHLzFSvCqbzUEksH4vYPmlDSwebv
	dg5jT07S8G1zC3U9/L3ZngkGwPsCfmxWqQNxjRSfFBSwtXAXdug+nVfIq5shg2zaglP2
	6+vg1yy7k/tKqFJ+cIc5LW3b0mb79JRlq5xrNGc4fU20VEG7xASRU8e7qPbvdztSP4ip
	IfXw==
X-Gm-Message-State: AG10YOTsoUpjzHm+2xwBBS/c4uzpheNkzAzKnPwehC0ViHOV5wBr9wo6tmQJ+rCwBPlyiPg00hCoHwyXoojQng==
X-Received: by 10.107.34.79 with SMTP id i76mr4315539ioi.195.1454510579607;
	Wed, 03 Feb 2016 06:42:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.46.219 with HTTP; Wed, 3 Feb 2016 06:42:30 -0800 (PST)
In-Reply-To: <1454486425.27087.149.camel@linuxfoundation.org>
References: <1454457337.27087.142.camel@linuxfoundation.org>
	<CAMKF1spSfcfM-AAC4fPNUiRykQaZ0_zUpzQNFfb8nOOeS7t8-g@mail.gmail.com>
	<1454486425.27087.149.camel@linuxfoundation.org>
From: Khem Raj <raj.khem@gmail.com>
Date: Wed, 3 Feb 2016 06:42:30 -0800
Message-ID: <CAMKF1srdFP=Mhr=8r7qVWegSr_NF9uhaeBoe5Rd8RG5dJmSdLA@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: openembedded-architecture
	<openembedded-architecture@lists.openembedded.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [Openembedded-architecture] [PATCH] data_smart: Drop default expand=False to getVarFlag [API change]
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
X-List-Received-Date: Wed, 03 Feb 2016 14:43:01 -0000
Content-Type: text/plain; charset=UTF-8

On Wed, Feb 3, 2016 at 12:00 AM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> On Tue, 2016-02-02 at 21:36 -0800, Khem Raj wrote:
>> On Tue, Feb 2, 2016 at 3:55 PM, Richard Purdie
>> <richard.purdie@linuxfoundation.org> wrote:
>> > At some point in the future, getVarFlag should expand by default.
>> > To
>> > get there from the current position, we need a period of time where
>> > the
>> > expand parameter is mandatory.
>> >
>>
>> what are advantages of this.
>
> Most users expect the data to be expanded by default. Most call sites
> also use getVar(xxx, True), its uncommon to see expand=False, outside
> the core of bitbake.
>
> So the ultimate advantage is a more sensible default which is what the
> user expects and leads to neater/smaller code.
>

That makes sense.

> We have had several bugs requesting this and it does confuse people.
>
> I have heard regrets from some of the original developers that the
> default wasn't True as well.
>
> Cheers,
>
> Richard
>

