Return-Path: <pavel@zhukoff.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCADC32793
	for <webhook@archiver.kernel.org>; Wed, 18 Jan 2023 10:15:03 +0000 (UTC)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
 by mx.groups.io with SMTP id smtpd.web10.11820.1674036894449212163
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 18 Jan 2023 02:14:54 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@zhukoff.net header.s=fm3 header.b=J6QQwYbA;
 spf=pass (domain: zhukoff.net, ip: 64.147.123.20, mailfrom: pavel@zhukoff.net)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id D3CE93200902;
	Wed, 18 Jan 2023 05:14:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 18 Jan 2023 05:14:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zhukoff.net; h=
	cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1674036892; x=1674123292; bh=0Y
	SS2HpcNhaMbDuUHluePIzEBygrJQH8v/VutC9c7Ug=; b=J6QQwYbAJxenXgFhAp
	xH1ij6vrr/LE8x5foZF+QufTuOqVWHgKYqm6R7iOVMI7hLYMtNaotzWeQlrPOwYS
	92MHHeMTax1y6+7XD6Z0b2dXg2Wy3b5PP/xxZowEFiWU05ElKGRVpda3G8TYzebw
	tPxBIQOgxqZNi81Wx3SpbEWhjCpV8gXInkRwu/LP7vhckY8hep/X6BrpVlwI8mwD
	IHa7ydJFlnnighYYaapnSTc2Ep10xIjnoKoSIxDSMKsCG4duLypPGO1UsNt8pnlZ
	2M5I83JZb32SF+YVzWP+B5QIzhTrEDDEY5RXM0qB7wTrbXvFoxqLnDuLCndQQnhh
	U9VA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1674036892; x=1674123292; bh=0YSS2HpcNhaMb
	DuUHluePIzEBygrJQH8v/VutC9c7Ug=; b=Dj5mlyeUd9TOeybPXsBa77g6khT0Y
	ls8BzUq7VJb0vIQx6VgRLyEzh2zTYrM7Z2Qz7oim4zNWCCgzNW0K5VFxSo6Nu84/
	EhZKBidis7EvCCMzO2RrfST8FZUKmNUd1vTv38GLZz3xQJgu6gyyb52PKhML95tr
	fcdgXH/ZBvPsrCy+Gr9embxSOj8ODkYUEm9aIhrHr7Cte41EPr2nmQMYyAJe9Yja
	B/nFW6HkybVJYXpFpZC38ak1EfdmU2ZcclCHZqjoh0V6A5I8yvCGD7yHsCq9GUGt
	CF6NSOol7j02rmvqaJK+j9nXmcQlTT7l36qVZc75TcEQ88rbLPhqF9rBw==
X-ME-Sender: <xms:nMbHY0SA-t1l-d99w3blmqHZCE7Ubn25VHoM4Lz67QgV04HPqIVQmg>
    <xme:nMbHYxzRixH_c6ymLCT1ACTKPA9q9CXBO5Pxt1OM_4FmF6lVuXuUkCK1wBGaoRKmL
    PGzW55Vn4V3x-T8FcQ>
X-ME-Received: <xmr:nMbHYx2JlxupcZ5d6f2CdmD4JoY4ofQmIw-M5dNGgv1JzIwCIpeWY5gEk_EzWxaaUi_VeFee>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddtkedgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfhgfhffvvefuffhorhgjkfggtgesthdtredttdertdenucfhrhhomheprfgr
    vhgvlhcukghhuhhkohhvuceophgrvhgvlhesiihhuhhkohhffhdrnhgvtheqnecuggftrf
    grthhtvghrnhepfeekudeuhfegtdduieeffffhudehvdevgeeljeehiedvhfegkeekhefh
    ueekudevnecuffhomhgrihhnpehophgvnhgvmhgsvgguuggvugdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehprghvvghlseiihhhu
    khhofhhfrdhnvght
X-ME-Proxy: <xmx:nMbHY4DbVLYA7resrCpMDh9Va71jtV-Q_2Hvgq5g2HxN7bPMrQaR6g>
    <xmx:nMbHY9g5mnUmd8tsQflee3HRsunRrLPvH_hToeEvCIdPfE_zCk8E-A>
    <xmx:nMbHY0pNqcbLHJ7tR9DksRIdxV48mI_JKDomzsrBMWZNky3wjsqdRQ>
    <xmx:nMbHY9LML6nMfKDpJzYMTpdaG9O2FruHokEUXUjP5fAHLn9vFqceZQ>
Feedback-ID: ib94946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Jan 2023 05:14:51 -0500 (EST)
References: <20230118072808.5895-1-pavel@zhukoff.net>
 <9d9e3eaa-92fe-2365-ab8c-352dee0af03c@theobroma-systems.com>
 <87cz7c2m2a.fsf@desktop.zhukoff.net>
User-agent: mu4e 1.8.13; emacs 28.2
From: Pavel Zhukov <pavel@zhukoff.net>
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH] fetch2/tests: Add parameter to recipe_uri
Date: Wed, 18 Jan 2023 11:13:25 +0100
Organization: Linux Private Site
Reply-To: pavel@zhukoff.net
In-reply-to: <87cz7c2m2a.fsf@desktop.zhukoff.net>
Message-ID: <878ri02lpi.fsf@desktop.zhukoff.net>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 18 Jan 2023 10:15:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14325


Pavel Zhukov <pavel@zhukoff.net> writes:

> Quentin Schulz <quentin.schulz@theobroma-systems.com> writes:
>
>> Hi Pavel,
> Hi Quentin!
>>
>> On 1/18/23 08:28, Pavel Zhukov wrote:
>>> While the parameter is not required it allows testing of possible
>>
>> I was convinced it was required for a year already but no :)
>>
>> I see Richard added a warning in Bitbake when the branch parameter is
>> missing and nobranch is not set to 1,
>> c.f. https://git.openembedded.org/bitbake/commit/?id=86a9c26828479be55865bcce72bcc7e12b93caa7
> Right, I saw this warning in the past but not this time... Anyway at the
> scope of this patch branch parameter can be changed with any other
> (rebaseable,bareclone etc) parameter git fetcher accpes.
> branch one is just first that came into my mind
> :) . 
Well. The warning is there but it's diplayed only if test failed:
Stdout:
URL: git://git.fake.repo/bitbake does not set any branch parameter. The future default branch used by tools and repositories is uncertain and we will therefore soon require this is set in all git urls.

So yes, we don't fail test if it's missed. And even more, test will fail
if it's specified and premirror is used in current bitbake

>>
>> Maybe it's time we make this a fail?
>>
>> Cheers,
>> Quentin


