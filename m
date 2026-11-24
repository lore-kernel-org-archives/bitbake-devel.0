Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14972.1795515072014855787
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 24 Nov 2026 02:11:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm2 header.b=IGYYMby6;
 dkim=pass header.i=@messagingengine.com header.s=fm3 header.b=aexrPjl6;
 spf=pass (domain: pbarker.dev, ip: 103.168.172.145, mailfrom: paul@pbarker.dev)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id DE38BEC0CBB
	for <bitbake-devel@lists.openembedded.org>; Tue, 24 Nov 2026 05:11:10 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 24 Nov 2026 05:11:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795515070;
	 x=1795601470; bh=JFxCHGEFx2svvFNqV9VR3RigFrr1gEvOX0Ek8nbaSSo=; b=
	IGYYMby6KrpxHNTPJxTFfl+doaNtCcmf2OnNTsvF0C0HOQVUsiK833PQ6a/0JS/G
	UiNv+zGzSgKTpXUEvbpFph+Dprxckw8TK7m+sZdx9KJALQsINucRiEOsVf0ZWses
	GBDvLW2kZ/Y8MmS5PxsW0+7J2GuipHD16hZCRbBwkyW/I2OKrGQWSudEYw8UE94F
	ZiAsk23YGll3IH/vLYAw20jceIt1fcmZovAiTyvWAL/ITlWKL3aHJtb6Z6sY3ji2
	qcR63hLw0wIWlidgeR6f/7f3DScDR67crya0I/XBKFBWstbk1Iv+mm+jPY4xicr5
	Ev5hK4qAftig+4/OEmDRGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1795515070; x=1795601470; bh=J
	FxCHGEFx2svvFNqV9VR3RigFrr1gEvOX0Ek8nbaSSo=; b=aexrPjl6uHA/zLyuY
	4rHCny/Akp2C39LHuABjmfsXx4lFv2feduofqjx5c0OqEXBLK0ERCEO7PJKb+Pid
	liRhmrZSTR5h0DcymwHjhtUjJ8DCKNkmxHvlb1jtxsTDxLiVFKq9M8TDFZdScoEq
	z3+bsf3VxtHHjxOe6iJ7ogtffuPPp70QRJ81aP4xoelzQo956c1XJMbtjbGZQVJb
	yuLxy2OF1C7qLuaZc7a3u6ZW0Y4MJv782ncejKjLS3IHsyNT82tb3uGBnWznlxxY
	tlkSIkhktWj2oDMCEk4ebRLJ4LT0lxCvwwJSbMCn9nTRcm1/hwJhhC3tCmLK5bAZ
	0ux+w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pbarker.dev a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795515070; d=pbarker.dev;
	mf=PHBhdWxAcGJhcmtlci5kZXY+;
	rt=PGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZz4=;
	s=fm2:rsa-sha256:prf/bkR+wtVwMtaypYT8VDQy7aGAZiQJI5fYnR+vV8dz8It
	HudiJAc7mNin074RuVqk2C7sIob6uOXthGJl5ZXHh7IboBm47kkjxzA2hF4TUdmI
	6xnLHN5rJ/fF2+mEx3kf99HZIbLbDhu6g9anBjOSG5ZX/5VtgLLA/wOS1h9pOyf1
	BKuXuOthtcGY6SQGSsQcS3eqp0mihbzEG+5ZTmvY9dA1IarkOEZshFrr6gftUYZR
	8yXKVm6vpzlczBmtG1eViFuUxN6Md0v3R+X0u+PZq7StqgRamcZ+8zOVzJNfWt5o
	GSVXsL8Qm6BVu6FSzNV51KJ5aad7OW1iH4foMzw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=content-transfer-encoding,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:mGl7YODgPr0X4suyIKZIh0nt7UMOhPGYlTvx1RrwM/I=:OvXt2t1tHzn1X/xdQRacsZ5zxYlh03dXJkUErZf1754=;
X-ME-Sender: <xms:vmIFa1AwWj4qTESYYj78yfsenTctyK5R-jNeJdh-IHh-7wApu9qRFw>
    <xme:vmIFazto17G59Lu8ADyu7Vsr8ieCoQ4yIg6MEqh8Rs-aRMLrNd5cOBxBI1Wprc2mf
    wzPh2tEVepQjfhhYLf4_Fd_KCSCml1QJeGB6iwcL6cw4ioHtdQZ734d>
X-ME-Received: <xmr:vmIFayasmqgswNjNDUwlmxqlvYJWkbv0O49m-xCTfQeaWvK8ZOtkGMQSZmQKrpcvm4uLh5EehxBPfbkAA4mFyOTJiVNW>
X-ME-Proxy-Cause: dmFkZTE8SDI0CS8PbXNY/kERTr6j1GLWIpvj7FHtS+VFSQyIynUa8Fp20lS5eLw65NuCI9
    KBtObsKtiYU7K5vXObkjnCaG5Sh4iLY/e6BckB3VSjphybGR1b57sLGdtcYg8M1ujaFfjS
    J6UOT4a+iv5su0IsvQYNANMkATlk1emPZCnUfVqkBS++/a6hw+rsP7EURBMRXaUB7MVHaO
    6ROF2Muak/XAZ9njUDozzP0s9HD/favfbEb+2E290LonDV1SvM1NHP/6X6ZvyEAsEqQmU4
    6m8Bek5iFVbgSolg5WNEdYHfbKiMwh5lovDRLreo5o4G3B/gmgYbzFu995mhhLzj3tqLFh
    cOsOLnkyx4u6Gac9lTZQaN+OnAQjHhaNAxNsZNAjtS61Kz+73VpkE2Sw0hiAjpbQFawp9G
    0HurvT3zi/jSpONMigtXzKyXzZMbPIrhVkYruJiDdCDOE0t4XWYlWYtGRfkfSjq0zg67Pc
    r0ntcWLR89tOM8S/EISKjazJnUjvfLcdlz8isME69HG4VsqQneNjUM9EPpcG6+UBRrtPth
    ziAHVHG5R0FRpePm1UL7tR4QBbU+VC8biAoQeR3r1Vh6yLmmrnQh3bjHSdYdg6vTGvsZpF
    iwFZE+duBOG9QugilSJrNNdsOdFffDKRI3RflgpDIO49Kdauzj7dfhINq3bQ
X-ME-Proxy: <xmx:vmIFa-XtU1EdFuVleKsCWSZArhjY4e0w-Fd70fwJCgIGR2DZM8ydEA>
    <xmx:vmIFa-7zK4vUwaduKllwADip1wRu-_xW-bxdaAZGVWSz9_Pu_ZJt-Q>
    <xmx:vmIFaxhj293wO33O1EO7aNu2Ijfo-kQNoT3XcXUZKMs4eD84xXAIaw>
    <xmx:vmIFa9e4Ym3O99U4ps8UyHPy85EnKlHGPusxec84b5p2ZTOeHVDpdQ>
    <xmx:vmIFa4-DENUJfWBV9jGHlZ9tqV4I8qsw_e2zkVbbnKDJzZd_zW-mRlua>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 05:11:10 -0500 (EST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 10:11:08 +0000
Message-Id: <DN3CYZHBB3D3.25ITWGNR351WD@pbarker.dev>
From: "Paul Barker" <paul@pbarker.dev>
To: "Krzysztof Kaszubski" <sympthicode@gmail.com>,
 <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] toaster: fix lack of whitespace around assignment
X-Mailer: aerc 0.22.0
References: <20261106154830.599244-1-sympthicode@gmail.com>
 <1215804.1795512325667105490@lists.openembedded.org>
In-Reply-To: <1215804.1795512325667105490@lists.openembedded.org>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Tue, 24 Nov 2026 10:11:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20474

On Tue Nov 24, 2026 at 9:25 AM GMT, Krzysztof Kaszubski wrote:
> Hey, will this patch be taken into account?

Hi Krzysztof,

Your patch was merged:
  https://git.openembedded.org/bitbake/commit/?id=3De016540115bd6295ba2d6b2=
8be00723949b16562

We don't generally send out emails when things get merged, please check
the git history instead. Feel free to ping us if a patch hasn't had any
replies and isn't merged after a couple of weeks.

Thanks for the contribution!

Best regards,

--=20
Paul Barker

