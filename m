Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D223FF886D
	for <webhook@archiver.kernel.org>; Tue, 28 Apr 2026 20:42:32 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2403.1777408951515603981
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 28 Apr 2026 13:42:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=h89ZlRBd;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43fde5b81a1so8831289f8f.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 28 Apr 2026 13:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1777408950; x=1778013750; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=41iT33yuRbRwNCbmIjZi1iraRNAE8Qm9DtCGAn8WCXs=;
        b=h89ZlRBd1W4MMdQ36h5/cm8biFrUlX9OAKEC4nuHUco8AW2mGtoA938PfDQj18FCMR
         1fYnBfnJ9q5sigT8HZ4viYOgjUNxZhQA530r7RH7dzOT0HzcE807OaC2yE3uQr0TyznA
         HhEZYerkNxoOK++fwWEKAGww1Ixl4r0bVxQkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777408950; x=1778013750;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=41iT33yuRbRwNCbmIjZi1iraRNAE8Qm9DtCGAn8WCXs=;
        b=tYX/lJtJd1aF1oQXdEUC46GAjuVHiXJidokVgl3f9aueFoUWS/wlr5sAnuxqWBG6VV
         i5oe9OkUp4uIGOLdejIpuwfSj3CKN0pB6PKeyW4kYREcf7Ct7fMR6ffSV8oHMG0cjR6K
         aXwDAuvQ5oSDz3V1fNvadAPcBb5bh5elZ18wSTTUW4GUymWtYgLX3n5ETceN8dd0tIP9
         21L4xCraOKV7o0lvMHiGgU31BVpXW/BjmUgEIhxXUXLuW+SSA4/grpDIfEPYmpRzhVTV
         1/0buLKnpYTSJQezQoZfSij7MmWKUtin6GaBokDgshWPimRz4NDuAKcszNX0QWE1xtsT
         9icQ==
X-Gm-Message-State: AOJu0YxNcA+sZkSFEbcIS9rmPb2bjN10BPCy4hrWKDMDbuRont48Hvq5
	J2US49H6ryPUVlsDhBjYDth+ecUZGN+0mDuXKFzSVa0gkEZkwWXeiclwbmpEDnIpDN8=
X-Gm-Gg: AeBDieuu3WHDDlgDCRw+1UdyMaa2qojQYXIynrDiCSOF8yC7iHO/lILUJO6fTvpNN8K
	3GLLIgXfBU4AezITaBqKhls3EYsFXy98dltaZ8r4aDM41fx9FpkFOUJDYavxc/SvAmCL6XMNvPt
	ht4q9jZmi2ubn2972BDQ4TW9C0Wi48L+1ZF0AIl4eACcXSrXU4azwu5TaQRviy7Uw4mI27Bo3L/
	ArawBTOj6UEE0qbEYvDa0pW+c4QETLq8+ZIm9KxVwTBbU6J8p+hfi0gxP/NuYGkBxND6Agc/kwW
	qtzTHb//2Yn2Ie5sU+bCN0AhCtM8bzT9igcFWovyKkEaegC4ok+ZO/5LOoMoANCM9UdsL+CHSr5
	TuaNWAVpvn8gO86Ehl2zg6MsNB66LcMrT0+ENf1rhHCdHExdSmE743pcv1+W7rytjwp3xgotO4y
	iKVXLMFGw1i+44hyD+wMs/7tOiJvDv9s2654tB5AJ57o75C3WaSpCKTzdd+sQQZvTw0mMgKvX1l
	Bd+Y9TKVyb7sQYbYM9j4jvgx3cVaelEtEI=
X-Received: by 2002:a05:6000:1789:b0:43b:8f4e:27f8 with SMTP id ffacd0b85a97d-4478ea89df3mr1559466f8f.12.1777408949747;
        Tue, 28 Apr 2026 13:42:29 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:549b:62f6:707:b10a? ([2001:8b0:aba:5f3c:549b:62f6:707:b10a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b3d4843bsm474393f8f.7.2026.04.28.13.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 13:42:29 -0700 (PDT)
Message-ID: <eeab5758b01722f5474855d21f718ea2d5cabff8.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [docs] [PATCH 1/1] doc:
 bitbake-user-manual-metadata: fix inherit_defer documentation
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bijak.dawid@gmail.com, Quentin Schulz <quentin.schulz@cherry.de>
Cc: bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org
Date: Tue, 28 Apr 2026 21:42:28 +0100
In-Reply-To: <ljbjkwt32h72aziah2gepb6k5rfxygfrhkfysmulj5scnca5pu@o4vikz4hfmh3>
References: <20260424062327.820993-1-bijak.dawid@gmail.com>
	 <20260424062327.820993-2-bijak.dawid@gmail.com>
	 <c25e0e9a-8809-4ac6-90ee-3687972e03af@cherry.de>
	 <ljbjkwt32h72aziah2gepb6k5rfxygfrhkfysmulj5scnca5pu@o4vikz4hfmh3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 28 Apr 2026 20:42:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19406

On Mon, 2026-04-27 at 20:14 +0200, Dawid Bijak via lists.openembedded.org w=
rote:
> On Mon, Apr 27, 2026 at 02:35:45PM +0200, Quentin Schulz wrote:
> > Hi Dawid,
> >=20
> > On 4/24/26 8:23 AM, Dawid Bijak via lists.yoctoproject.org wrote:
> > > [You don't often get email from bijak.dawid=3Dgmail.com@lists.yoctopr=
oject.org. Learn why this is important at https://aka.ms/LearnAboutSenderId=
entification=C2=A0]
> > >=20
> > > The documentation for inherit_defer contained the claim
> > >=20
> > > "If VARNAME is going to be set, it needs to be set before the
> > > inherit_defer statement is parsed"
> > >=20
> > > which is incorrect and contradicts the purpose of inherit_defer.
> > > The wrong claim is replaced with an example which demonstrates
> > > the contrast between a plain defer statement and the inherit_defer
> > > statement by using an override assignment placed after inherit_defer
> > >=20
> > > Additionally the inline python expression examples have been
> > > moved from the inherit_defer section up to the inherit section, since
> > > they apply to both directives
> > >=20
> >=20
> > I'm pretty sure the whole inherit_defer thing started because an inline
> > Python expression didn't work. I vaguely remember a bbappend either add=
ing
> > this new inherit based on PACKAGECONFIG containing a value, or having t=
he
> > main recipe with this inherit <PACKAGECONFIG.contains> and a bbappend m=
odify
> > PACKAGECONFIG. See commit 5c2e840eafeb ("ast/BBHandler: Add inherit_def=
er
> > support") in BitBake.
> >=20
> > So I'm very skeptical this is correct.
>=20
> Hi Quentin,
> Thanks for your response.
> I'm afraid I don't quite follow your point about PACKAGECONFIG.contains.
> I'm not sure what you're referring to exactly.
> But, as far as I can tell, the inherit statement works fine with inline p=
ython expressions.=20
> I think, it evaluates the expression in place, much like :=3D would.
>=20
> For example, on current master I tried the following:
> =C2=A0COND =3D ""
> =C2=A0COND:append =3D " x"
> =C2=A0inherit ${@bb.utils.contains('COND', 'x', 'foo', 'bar', d)}
> This inherits foo.=20
>=20
> However, if I move the :append below the inherit directive:
> =C2=A0COND =3D ""
> =C2=A0inherit ${@bb.utils.contains('COND', 'x', 'foo', 'bar', d)}
> =C2=A0COND:append =3D " x"
> it inherits bar.

It works, as long as you are sure that COND won't be changed after the
inherit. When mutliple files altering the variables are involved, that
is often unclear. I think the doc's intent is therefore to recommend
anything with variable accesses is therefore deferred, unless the user
is sure they know what they're doing.

Cheers,

Richard






