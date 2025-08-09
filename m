Return-Path: <chuck@wolber.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818BFC87FCF
	for <webhook@archiver.kernel.org>; Sat,  9 Aug 2025 19:59:53 +0000 (UTC)
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by mx.groups.io with SMTP id smtpd.web11.13372.1754769591026827066
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 09 Aug 2025 12:59:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@wolber.net header.s=fm2 header.b=Sq/G0zms;
 dkim=pass header.i=@messagingengine.com header.s=fm3 header.b=C9LLSnSU;
 spf=pass (domain: wolber.net, ip: 103.168.172.145, mailfrom: chuck@wolber.net)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 3E001EC1D42;
	Sat,  9 Aug 2025 15:59:50 -0400 (EDT)
Received: from phl-imap-03 ([10.202.2.93])
  by phl-compute-02.internal (MEProxy); Sat, 09 Aug 2025 15:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolber.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1754769590;
	 x=1754855990; bh=4J0VE2IrjFqhvecl6ygXCf5HbmThKcvRhEVrDMVvAwQ=; b=
	Sq/G0zmsGI9fVyzj741aigb9cx5ac5hMo+CBf19vCB9i1PIrN/qEtsXSEOFNQFv4
	rJFutrtx/J2/+jq80ItY09QLanl9jokE3COQmz8tFIVw2NIghGio70qcRdSu//AL
	wfmHmp4Bc8VXWk/f2yXoeGfSiQGWC6VxsmxFKd+Ul1/SHmDado6c0SbrKMJVvo9J
	yMYYVdXbmk/4aCztv/hadw66RHANZ7FmJ8aYVNLVDLkGEM913pyfMMJ0X+oGPXNj
	/xkMEuNzZURz36YsI/VPSafeCoNG39ZuDyVZyd/VSyKwl8pB9jb7Pf7fFtJ57nRy
	/KB+TR2tHld5la0DwKCq1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754769590; x=
	1754855990; bh=4J0VE2IrjFqhvecl6ygXCf5HbmThKcvRhEVrDMVvAwQ=; b=C
	9LLSnSUjST66ccbtUd9jHDmHjxeaF6k2vKMujoQI6vyROLc7LQk9FcW88LxUddL+
	L+JxPnvsG+hl20Cj6SOXoePWtzKZInyfKatxjEO3q07XLksWygwfwY41pxXeAmVT
	oQkgCgqOkY8a/p2nINieCDoa5WQ4Xz9ajCO7p68XLC0b8TtiQtMus3NLzCZQ7kj9
	VoBXS2+2W0KHlmPIQ+NDUHPTrZVICda/nUdu1W+AYSiTI499cpHRCHy97FgnH1LW
	mRVwmYKnvSRiB0YM9oHUSvReG9XDhOG5CJsobsJKiEQF4rO4re/L9ZdKIe5QoX5Q
	JlSwbMU4Xft9ryXmkNvjQ==
X-ME-Sender: <xms:tqiXaPHw4V4a6OoB39j6qZ3K8r3rlLiw0v8QcPRQnvaWHXgOrDKCMw>
    <xme:tqiXaMU4zshBMks3GCeqQe3FxAz0z70QR4I-6Jr31GPsFcqO-ADRMB3xv8GOq2KBV
    P4FQ73C1B5aBrQLMrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdejiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofgggfgtfffkvefuhffvofhfjgesthhqredtredtjeenucfhrhhomhepfdevhhhu
    tghkucghohhlsggvrhdfuceotghhuhgtkhesfiholhgsvghrrdhnvghtqeenucggtffrrg
    htthgvrhhnpeetjeejtdeugeeigfeihfeutdegfedtgeelieeiteetueejgeduvdfhheei
    veejhfenucffohhmrghinhepohhpvghnvghmsggvugguvggurdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkhesfiholhgs
    vghrrdhnvghtpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehjphgvfihhrggtkhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopegrlhgv
    gidrkhgrnhgrvhhinhesghhmrghilhdrtghomhdprhgtphhtthhopegsihhtsggrkhgvqd
    guvghvvghlsehlihhsthhsrdhophgvnhgvmhgsvgguuggvugdrohhrgh
X-ME-Proxy: <xmx:tqiXaOtWSyYmQpVeTdgw1T3aFL1QtdCzGBD39rs81Dpvd2FJ_ScwPg>
    <xmx:tqiXaKWfMFPcUHhwQe4y0eyyFiR7DAeEbyQ5XU8lExgAQbWGSqwJ4Q>
    <xmx:tqiXaGu4z2dEcjmT54vaXbPg_PD3LibPSdT1zisSf71aOJ3I_263Cg>
    <xmx:tqiXaGWxmA04IMHgg1ZRNj5Gx1yOLskk2u9Sss-eJoU7dxd2eFncEw>
    <xmx:tqiXaN4SyC8CYbQHS0cUz1DD1uPZO0hD_re0gx0EdlXiHmxl6CokV6-T>
Feedback-ID: i5cf64821:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EDD9A18E0063; Sat,  9 Aug 2025 15:59:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 09 Aug 2025 12:59:49 -0700
Message-Id: <DBY5WKIGG9UG.3DFOCYWME1YVA@wolber.net>
Cc: <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel][PATCH] cooker: Add layer-specific ignore for
 dangling appends
From: "Chuck Wolber" <chuck@wolber.net>
To: <JPEWhacker@gmail.com>, "Alexander Kanavin" <alex.kanavin@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250729144906.1665908-1-JPEWhacker@gmail.com>
 <CANNYZj-TMk4ktaPqC2EbS-k636cJfr3hyeZXp5rrEESi-ovZjw@mail.gmail.com>
 <CAJdd5GaNH=gP+ypmV31MLwYgF-xdT+e-E9rfW1JCgQis2PJtyA@mail.gmail.com>
In-Reply-To: <CAJdd5GaNH=gP+ypmV31MLwYgF-xdT+e-E9rfW1JCgQis2PJtyA@mail.gmail.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 09 Aug 2025 19:59:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17848

On Tue Jul 29, 2025 at 7:59 AM PDT, Joshua Watt via lists.openembedded.org
wrote:
> On Tue, Jul 29, 2025 at 8:57=E2=80=AFAM Alexander Kanavin <alex.kanavin@g=
mail.com>
> wrote:
>
>> On Tue, 29 Jul 2025 at 16:49, Joshua Watt via lists.openembedded.org
>> <JPEWhacker=3Dgmail.com@lists.openembedded.org> wrote:
>> >
>> > Our setup is that we have a "disto" layer that we need to maintain aga=
inst
>> > several version of Yocto at once. In this disto layer, we make policy
>> > choices that sometimes are tied to a specific version of a recipe foun=
d in
>> > a specific version of Yocto using a bbappend; and often that version i=
s
>> > only in one or two Yocto versions, which means that the bbappend will =
be
>> > dangling in the others.
>>
>> This is where the weak point of the argument is. Yocto does not make
>> concessions to layers that attempt to be compatible across yocto release=
s,
>> patches that help such layers had been previously rejected, and this wou=
ld
>> create a precedent to the contrary.

Yes, but perhaps some consideration is merited? This is a perennial problem=
 for
OEMs with long lived products.


>> It's always possible to make a branch.

While this is logically correct, it is also an unreasonable response.

The argument is being made with sincerity, clarity, and consistency. I thin=
k it
there is a lot to be gained by taking more time to understand it.


> Branching isn't an option for us; we are unwilling to add the maintenance
> overhead of dealing with that.

You are not alone in this respect. Perhaps we need to find a better way to
explain this to the YP community? I believe adequate consideration of the
problem will improve more than just the plight of OEMs with long lived
products.


..Ch:W..


