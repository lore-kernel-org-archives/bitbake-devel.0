Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3752CA5FF0
	for <webhook@archiver.kernel.org>; Mon,  5 Oct 2026 14:31:56 +0000 (UTC)
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21544.1791210711554541992
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 05 Oct 2026 07:31:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=qS2lbqY1;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=RI4DdFZh;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.156, mailfrom: paul@pbarker.dev)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B7AEC7A006B
	for <bitbake-devel@lists.openembedded.org>; Mon,  5 Oct 2026 10:31:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 05 Oct 2026 10:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1791210710;
	 x=1791297110; bh=BgJfYlJxmqm0/4BgFrpuEZFLheonkZGBLrc3HAl9qjg=; b=
	qS2lbqY1OESgaQUH6bSaXr5PKBZF1iPEgL71lICzw5gX1ZD7KkRkPujDILDyAMAA
	32gpuu1QqQLLUMqY5kvlAp3/tfgBsaCyguw9Agzg/eqlzxqk/sy/SQgqvx65PO16
	DZ6qHuN6zoVVT226N04VHs39OjzncheEp8f5zfxlZqQV2iEh2CqfXTA4JTRMtZQu
	UdIFN9qSHW4sMzqUS/wRNBH8xbwF/1HyxxooCaNr5ZltoLGAIokAa/cuCL8cY/Fz
	ui4Uivf+5XNX4HSxQBgtivSpWb2Mnnn+qcD9m7DpHU3bcubOtYNcey/d6wdn2Nvq
	Cy2/pgLsxrun0HE4/XsUwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1791210710; x=1791297110; bh=B
	gJfYlJxmqm0/4BgFrpuEZFLheonkZGBLrc3HAl9qjg=; b=RI4DdFZhNhydxBy3D
	2FyIYYEYrx/BtIvyx4ZjKomNLRt/dct2h9gTxAumbgNb6MiVTkioNqQCm0LTh1wU
	s9+9ol++rD2llIdB/3WNCt4P6WJq7+SqXzu6kkV8neSHsg9Ad8UzURfBg/HUoc0W
	zAJ31O0Q7JwcYeLNYiGCc1MkECKSZYCskeqstYwG8cflZ/gvDeZW5N0vj9AnEUqK
	ZLekX5XCTD6PAogSUvpUKf7Ra7uF0u967iVmkJ0IHtiQhZXl4MCXsMVPDtAxUTYw
	FHQdMNOAYJt4B1FmA2qpOnhfxV3z6pyelgtQrefPeQuzBFc83mA+PKyIW+1PoMVj
	24uEQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pbarker.dev a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791210710; d=pbarker.dev;
	mf=PHBhdWxAcGJhcmtlci5kZXY+;
	rt=PGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZz4=;
	s=fm3:rsa-sha256:LJtyuTDG4RpRYqhApn3hg5hT1+8GY295/+fRDiLdM1S3PM3
	VflU0dePyzhx4ZoQqVjzVXSaPLah3Jl+qW5DJ5gSIB1tZK7otG/CpI+z5DfwhxU7
	B+7g2/x2nY2CuQEf80NuTecptmEfRd39xQ9qeTPj9xGy4jWCDje3OjbPQwpuHz30
	26PeuF+CN8axV5F5Sxu9z5PIt2hNbW0wHYSKA9zNLdoB2Ryi2MIO9tP3YrD+Rl2I
	Q4BEVNkf7NBoaq8atPPr3gEC0drKDcLOkHJFiU9/exagprn+RXps0nw7O3dgmkqn
	VCQ0H81kwXy/gVGfYGuy/3I7cPxaN2RS2FQCMvQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=content-transfer-encoding,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:XwucbAstT1VAyaad4ZuLuGlvg3l6y5SFGQfx7eAceyo=:BgJfYlJxmqm0/4BgFrpuEZFLheonkZGBLrc3HAl9qjg=;
X-ME-Sender: <xms:1rTDatcQ-GhMOEy8rDsNg0ILSeAUQK3kh9K7QS2D-XfAAZsp3lIWUg>
    <xme:1rTDahP1h2G0QTnwxGk9484osi5kch5RsIj7SdfCx3icf-kT_i2LkA9Jt14LExgpA
    tkk3LlMDbc-KQ1wbyg8-owL0jA1hQiyGuq9gZZeuOYMft6ZhfQD2g>
X-ME-Received: <xmr:1rTDakJh30gh7sSPmx2yY_mfrlPiA6m44cGhoF_bpVarXAGW3vxxCG7uhvYEpbHpq2OTcww6GSM-Q4btoET9KAK1haoDkw>
X-ME-Proxy-Cause: dmFkZTGAI8RgBloaTfOMWDeBxN0dP0JMppvu6dp05az6kT8ySOOmKHkuHdoNpWMUBrsYGB
    n55YhELYqk5cfX17H6s9L0J99nUu2ooMLaBtg0RGQWBg93tk6fnXWF6vRoDQ0oUA8HCxh/
    6t/Jd5PQ68IkcCtkqmP36lHcV0ZjsX0OLfhsVAevQZKEQbj9KXQYQqvysSHORRAGLfkRkM
    sn5qs6+sAUKrDz9rE3SOEc7ZK/YXKwmSFNLJAZhKE39JTtX5gmaNW8RJ3IwVim2rNk7kwI
    wz2a+vwre1k0bzn+tAnfdwYZpS+RmL4tgfgRgZFgcDOiuAjT9iPO7DB4d1iMtMxy4Tggd5
    tonE7VPRAkQvWunO6/A5xTnaMAYgd4OC/0XrOTAOHpHNNsVY48wti2+ynkL3WT525dILof
    XZr9m56DQxXQOVDpVW/Ej9nbC1dVpHIPCAyR8tOlnVC7UUUKWUnAIYVAWSf2ZQDrUIaPkg
    JIEOXNRqPJ6NadXBjFNLgg6VsagmhnwNzKZdb7ByoYzYrB0xBPjg+nu2VsU+rWjNpTAZsc
    r46SrSGgh5Qhsl3EBT8j7XjbRVGlV8EBEr9p617iHn3WYNGBqccPiu61eCNnqqdMmD3+H+
    HkeAyTzGBAwjce7cEcFZg3AOp12obbOMB4IZTr4oC4bJIsjLmhirfJZONtmA
X-ME-Proxy: <xmx:1rTDaiH-L8WxJTW8OFEQd_I1NE_OCfibM1U-cdFzmh6h7aFluxgSEw>
    <xmx:1rTDasRX8-HVeN3sJSmSk-xCjqESAS_35wc6u5F_WplrXy5WuI58nw>
    <xmx:1rTDauFhvlP4D4L_rZZFFZuOV8alSADZCrWBfC2otHW1kvkkvI90xA>
    <xmx:1rTDao-FAOnEIHAifz0CkUpKua20i-mQD_2WOSdwj_3-4Tr-vW37-Q>
    <xmx:1rTDaiPmHL2m_cthq07GGX5-w5ApFxUiDISEWi93cUzUgGEpc890lzBP>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Oct 2026 10:31:49 -0400 (EDT)
Message-ID: <2d1f4781057f4a1a58ad5f91fa0a2b5a1ec3c624.camel@pbarker.dev>
Subject: Re: [PATCH] knotty: add OSC 9;4 sequence for progress display
From: Paul Barker <paul@pbarker.dev>
To: git@cookiesoft.de, bitbake-devel@lists.openembedded.org
Date: Mon, 05 Oct 2026 15:31:42 +0100
In-Reply-To: <20261005083628.1451356-1-git@cookiesoft.de>
References: <20261005083628.1451356-1-git@cookiesoft.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 05 Oct 2026 14:31:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20295

On Mon, 2026-10-05 at 10:36 +0200, git@cookiesoft.de wrote:
> From: Marcel Hellwig <git@cookiesoft.de>
>=20
> OSC 9;4[0] allows the terminal emulator to display a progress bar.
> This is helpful for the long-running tasks in both Bitbake and Devtool.
>=20
> The most prominent supporters are Windows Terminal and KDE's Konsole.
> Terminals that do not support the sequence simply ignore it, so no
> special treament is required.

Sadly I don't think we can assume this - not all terminal emulators
handle these escape sequences properly. We've had issues with this when
systemd started enabling OSC sequence output by default [1].

I would prefer this to be configurable, and probably off by default if
there isn't a way to detect whether the current terminal supports these
sequences.

[1]: https://lore.kernel.org/openembedded-core/20260415082949.3446677-1-Qi.=
Chen@windriver.com/

Best regards,

--=20
Paul Barker


