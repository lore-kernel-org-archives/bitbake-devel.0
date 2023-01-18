Return-Path: <pavel@zhukoff.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841E7C004D4
	for <webhook@archiver.kernel.org>; Wed, 18 Jan 2023 10:07:23 +0000 (UTC)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
 by mx.groups.io with SMTP id smtpd.web11.11941.1674036436200129417
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 18 Jan 2023 02:07:16 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@zhukoff.net header.s=fm3 header.b=KHxi5nW8;
 spf=pass (domain: zhukoff.net, ip: 64.147.123.20, mailfrom: pavel@zhukoff.net)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 5225B320093E;
	Wed, 18 Jan 2023 05:07:13 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 18 Jan 2023 05:07:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zhukoff.net; h=
	cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1674036432; x=1674122832; bh=KY
	CUH4xtv4JeC9kjcyIo3Go2+Z3wJNOvx0slLr/V3Mk=; b=KHxi5nW8j3hpMdbPmd
	GZieLlVQBDrkaftKF7IkBnZ0gWyd7R2INqDd5+Ry6DTwcx0ysN6vaOnjs86uO2/k
	dSnPTn5wutiP8mBpTWtOysnylSUV764WZErWxBy5escdy6/GGrG576HIJZ9dZXr6
	pr8zlxk5KmWBwXPdc+SMAXlnGrZyi6TD2v/0KLzyS62Zyd+o83OH+IFNVrou+Zix
	YEsGccrUiImgjTFCSL4stxK8x7pYdiYs1033gbND7OeZ0iWp2cuR7DPk+7tdEXgp
	135Xg8haZ6YWK5kqRgpCguoWQcWxTuuvuxWvwzDKD1RYlf2j/fdmlRIiZPbHoMbT
	ETJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1674036432; x=1674122832; bh=KYCUH4xtv4JeC
	9kjcyIo3Go2+Z3wJNOvx0slLr/V3Mk=; b=eKni9vwkQO+hmtks5XBbTXLS0pIUm
	AD0e7cPLO2qwovUd4+Bn9oQP9tFbe2Z27LROInxIAZtaJBDLHCS1YgHXxR82iv7s
	liFA2k0yQcJfo8yxvVxJCihzNBvbMjtp5W3U0Smm8vo9Usspa6njYKFfr2h6Plr4
	hoz8Mxhc4Ns3FEqNpmIRApwud2+qFtuuT5rmvB2bXKM6iyFtd9VqCvp65PUf+Hiq
	tjrcLqtI7cb3JoEhxsTIDB8Vnccx+6WDpUc4AyQr1Kc46eKbJ6yTkH3Cp4WOt6MZ
	TYS8VgRP0G+mqp340OUlcE5Ke+nY84vtQd8cdDU2pbnqHMLkRswImlpeA==
X-ME-Sender: <xms:0MTHY7j0pGhsOpxpmYkAEIIYVURvlUnMBC3mbU8yTUa-jDnCwc-DEw>
    <xme:0MTHY4CerzPf0ng2-7vlbkM6A7KR0vAhrCXWYTK5kM3IKUFzjiRSdZ1D50jxYmB_k
    UbG-lWNriEYOn7sU28>
X-ME-Received: <xmr:0MTHY7HUjd9jZ5IdD_DiemQounoPP0NDEsQpiW6fwTisbSwKHUD-NU0LqfjxuP83q0PRvYZh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddtkedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfhgfhffvvefuffhorhgjkfggtgesthdtredttdertdenucfhrhhomheprfgr
    vhgvlhcukghhuhhkohhvuceophgrvhgvlhesiihhuhhkohhffhdrnhgvtheqnecuggftrf
    grthhtvghrnhepfeekudeuhfegtdduieeffffhudehvdevgeeljeehiedvhfegkeekhefh
    ueekudevnecuffhomhgrihhnpehophgvnhgvmhgsvgguuggvugdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehprghvvghlseiihhhu
    khhofhhfrdhnvght
X-ME-Proxy: <xmx:0MTHY4QBinJRMoQDWYZ7QcS20EmSJcFKKRaN7KA-JVjU9HjsNNPmKA>
    <xmx:0MTHY4wBE9y9j8KctugXc30q_mMWgoPu_R50dnegPPmixDvjkI1lqg>
    <xmx:0MTHY-4Mch1skGyQ8L6hx02dGnf1l2tu4wCWmODs2_AQc9DyWRHDHg>
    <xmx:0MTHY-Z2RL2ucZsUlekzGeLr-C0qZvPAbnQWOe1I2Vmnlh4p1Ms_0g>
Feedback-ID: ib94946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Jan 2023 05:07:12 -0500 (EST)
References: <20230118072808.5895-1-pavel@zhukoff.net>
 <9d9e3eaa-92fe-2365-ab8c-352dee0af03c@theobroma-systems.com>
User-agent: mu4e 1.8.13; emacs 28.2
From: Pavel Zhukov <pavel@zhukoff.net>
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH] fetch2/tests: Add parameter to recipe_uri
Date: Wed, 18 Jan 2023 11:02:34 +0100
Organization: Linux Private Site
Reply-To: pavel@zhukoff.net
In-reply-to: <9d9e3eaa-92fe-2365-ab8c-352dee0af03c@theobroma-systems.com>
Message-ID: <87cz7c2m2a.fsf@desktop.zhukoff.net>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 18 Jan 2023 10:07:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14324


Quentin Schulz <quentin.schulz@theobroma-systems.com> writes:

> Hi Pavel,
Hi Quentin!
>
> On 1/18/23 08:28, Pavel Zhukov wrote:
>> While the parameter is not required it allows testing of possible
>
> I was convinced it was required for a year already but no :)
>
> I see Richard added a warning in Bitbake when the branch parameter is
> missing and nobranch is not set to 1,
> c.f. https://git.openembedded.org/bitbake/commit/?id=86a9c26828479be55865bcce72bcc7e12b93caa7
Right, I saw this warning in the past but not this time... Anyway at the
scope of this patch branch parameter can be changed with any other
(rebaseable,bareclone etc) parameter git fetcher accpes.
branch one is just first that came into my mind
:) . 
>
> Maybe it's time we make this a fail?
>
> Cheers,
> Quentin


