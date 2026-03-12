Return-Path: <pierre-loup.gosse@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FCBFED2FB
	for <webhook@archiver.kernel.org>; Thu, 12 Mar 2026 09:57:55 +0000 (UTC)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17774.1773309467116360611
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Mar 2026 02:57:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=3PtY/5Ou;
 spf=pass (domain: smile.fr, ip: 209.85.167.48, mailfrom: pierre-loup.gosse@smile.fr)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59de8155501so873813e87.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 12 Mar 2026 02:57:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773309465; cv=none;
        d=google.com; s=arc-20240605;
        b=ZnKIWQFig748GHSj15C5/eJnMbUMnbafdFNBVEIoD23wva6IRNJBEwTvu3+7T4RKQ4
         iTX/ezKvVvan4HoBXZwsQO9kHeI86Hhz7fwclz+yfOEg8Dtc2qwdMceUlRzw/kw2O+Q1
         pTztkuDPUjT+qL+fCL6SsM8cYyyfm/rth869PMMiPcFSU7kNtJjPid4kjaH/J1vEniIp
         3WlRE40uwseXcPQ/78dvEmcqokPwaudZkAwAy7I+ReaLK3xCY945+Ui4HhHFTc63kk0b
         GCUWvMTY6TNZbwbPO+RHc4FexvxH/PCnvUVVd031NUfBo4vtsxb0ExxHRiCvaxHejfDP
         swNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=S9bvwES+JdkYOfDzcYw8ZNM+/XaqtBUZeq6YafW/OTc=;
        fh=mDpvvBKTylZqe907qYZ2WV5PmbYApZx9Yq0Zo6x98DY=;
        b=a7VzpgoSy1umOW729Y4nBOZqp0UI5VWo9KQqH/MSpgHuqdruXzjTJZacB11u7zUoe7
         yZr5DApJhUKtx7PI3FD5sSFTVejNnp8juP7LuA0Faa2NnMQjA9tEAmMHeMxFO0LnD1pp
         86q4rhRWgYT/8eBmXPmIJNkUKs3gnVSOH8/KFgqHpVUK4xrfEgFK9H9qvzx5X+uXzflV
         Tg2mnVjBxAabEo5VS2+C6DR0lWJjYJSp4MXtDfh73YVjsrV66P+ozSfzKC555dtdemaJ
         97Uu6CmX3LmQstRYN9W8kj5ZoB5Gu0kzhUef9/GKeB/afUXEIIHFaXAqT/2GElMDIKRr
         qjfw==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1773309465; x=1773914265; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S9bvwES+JdkYOfDzcYw8ZNM+/XaqtBUZeq6YafW/OTc=;
        b=3PtY/5Ou3/P1Fx6Vmhp/LzsNdESKY+wGt5PSig80flU0DvIArgliCBtXxmtdQ0HUu3
         oeE6z8Qk6Wxr1ZbsUue9vQS1htPIQO7EHJHLj8T6zPnbezubQt+iqk4muE7muDCG9t2D
         +04CQsaG9PSvFHZtxfFY6177yE0cE9hvrcR2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773309465; x=1773914265;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9bvwES+JdkYOfDzcYw8ZNM+/XaqtBUZeq6YafW/OTc=;
        b=gQgBFWLxT/ciRWXgtSOoOO6Q7+GR6Y6EcBwLYEsw15ap6ZzK/LFgBhrjXk0xKwTVzf
         lAvFwp6e63MwPcGr1BFVKANMkk8lgT7iIkdQfnRbBNktULozTiMuDgM2eKvJX7Vf2VVs
         SQtB9PoyXoVu5mLNyo01ibE/yn7F6Zmuwzd6tFKJbjLFZPgSu1CX3/LaWs0ECj0T8MUd
         xON6TXha0kkWd1iJKeLHyXaB+mCq6ID3GSMSRenAuf1ZYFC2RcEO68Ogwl5Hbu6CmdDR
         951yvL0bLnl3gzeulndXtsJjrttFhZ2HKWa01mGkoArxLKNlDWhuvqy1PNyzlM0u3b0R
         ubEw==
X-Gm-Message-State: AOJu0YxdKObIzBe92v3YYyo4b8s9SDKrnYXcc3/4mfwRwCmrYp2ygBgt
	gHXLVQR2IKe/jnJZGpUWBKEan7No+BCqsfRQreXpcoxGvw7GcEbE8iC7PZFXT3B5FueARa5/NO9
	rwpyBtbBSE9y/yHayD5Rj8HCyWOx9E1dgyuTf6bRq7g==
X-Gm-Gg: ATEYQzzg2hHGmvzKtROnEUG0zSXHBS6RVyhy+p27z3YOzAe8tvHCF7xL0ibUvsQCfa0
	BPXtGM+CWtYxhq/hZuyYCe6GEwNF+LWB92mLywUeBBuYOGHsU/Lx5my7l+jQ0ih8nhGkDMAUT3b
	UcUQb9jI8AuEvMmvICBLhzJTvezoGEUmAwGOpUZM0e5FXBj91axfu1//+T3X59yZNMX0gAREaaD
	rTyZy2Qk4tN8V/frrepHRHA0YzlZ52ZzZAgHH/lOpfouQlAYQe54a+6YdtcMOAnUd2yJsxWAeAP
	SA2ROIJFGBLEVXejn7PgYtY43XzEx4Z/XWHbGcLYesB8gEzsW2gqW33uxgEvmvoQ5p1KcDw=
X-Received: by 2002:a05:6512:61d4:20b0:5a1:3400:f937 with SMTP id
 2adb3069b0e04-5a156bb35ebmr1643563e87.7.1773309464652; Thu, 12 Mar 2026
 02:57:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260311131917.2203296-1-pierre-loup.gosse@smile.fr>
 <fc5468c04fc393f098ffeb1ea37c4332587ddd59.camel@linuxfoundation.org> <146381.1773306543289644043@lists.openembedded.org>
In-Reply-To: <146381.1773306543289644043@lists.openembedded.org>
From: Pierre-loup GOSSE <pierre-loup.gosse@smile.fr>
Date: Thu, 12 Mar 2026 10:57:33 +0100
X-Gm-Features: AaiRm532T6qulb_-bH-uFi8QAq_xB1To5xNoFxrmSalTorpFM4jYjBW8cBoGQ28
Message-ID: <CAHT-cZtiwNVxLSzUb5NaQFixQicYVHKuoTMv-5US8LVU+T0ETw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/1] utils: add is_enabled function
To: michalwsieron@gmail.com, richard.purdie@linuxfoundation.org
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000b7bc34064cd0c8d7"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 Mar 2026 09:57:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19149

--000000000000b7bc34064cd0c8d7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Isn't this identical to `oe.utils.vartrue()` anyway?


I missed that, yes it is. Thanks. I mistakenly focused only on the bitbake
lib.

Richard, I can use to_boolean, but given Michal's comment, is the function
still necessary in the bitbake lib if it already exists in the OE lib?

Regards,

Pierre-Loup


On Thu, Mar 12, 2026 at 10:09=E2=80=AFAM Michal Sieron via lists.openembedd=
ed.org
<michalwsieron=3Dgmail.com@lists.openembedded.org> wrote:

> Isn't this identical to `oe.utils.vartrue()` anyway?
>
> ```
> def vartrue(var, iftrue, iffalse, d):
>     import oe.types
>     if oe.types.boolean(d.getVar(var)):
>         return iftrue
>     else:
>         return iffalse
> ```
>
> Br,
> Michal
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Liens: Vous recevez tous les messages envoy=C3=A9s =C3=A0 ce groupe.
> Voir/R=C3=A9pondre en ligne (#19148):
> https://lists.openembedded.org/g/bitbake-devel/message/19148
> Sujets: https://lists.openembedded.org/mt/118259802/9955716
> Propri=C3=A9taire du groupe: bitbake-devel+owner@lists.openembedded.org
> Se d=C3=A9sabonner: https://lists.openembedded.org/g/bitbake-devel/unsub =
[
> pierre-loup.gosse@smile.fr]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000b7bc34064cd0c8d7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hi,<br><br><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">Isn&#39;t this identical to `oe.utils.vartrue()` a=
nyway?</blockquote></div><div><br>I missed that, yes it is. Thanks. I mista=
kenly focused only on the bitbake lib.<br><br>Richard,
 I can use to_boolean, but given Michal&#39;s comment, is the function stil=
l
 necessary in the bitbake lib if it already exists in the OE lib?<br><br>Re=
gards,<br><br>Pierre-Loup</div><br></div><br><div class=3D"gmail_quote gmai=
l_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 12, 20=
26 at 10:09=E2=80=AFAM Michal Sieron via <a href=3D"http://lists.openembedd=
ed.org">lists.openembedded.org</a> &lt;michalwsieron=3D<a href=3D"mailto:gm=
ail.com@lists.openembedded.org">gmail.com@lists.openembedded.org</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div>Isn&#3=
9;t this identical to `oe.utils.vartrue()` anyway?</div>
<div>=C2=A0</div>
<div>```</div>
<div>def vartrue(var, iftrue, iffalse, d):<br>=C2=A0 =C2=A0 import oe.types=
<br>=C2=A0 =C2=A0 if oe.types.boolean(d.getVar(var)):<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return iftrue<br>=C2=A0 =C2=A0 else:<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return iffalse</div>
<div>```</div>
<div>=C2=A0</div>
<div>Br,</div>
<div>Michal</div>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Liens: Vous recevez tous les messages envoy=C3=A9s =C3=A0 ce groupe.<br>
Voir/R=C3=A9pondre en ligne (#19148): <a href=3D"https://lists.openembedded=
.org/g/bitbake-devel/message/19148" rel=3D"noreferrer" target=3D"_blank">ht=
tps://lists.openembedded.org/g/bitbake-devel/message/19148</a><br>
Sujets: <a href=3D"https://lists.openembedded.org/mt/118259802/9955716" rel=
=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt/1182598=
02/9955716</a><br>
Propri=C3=A9taire du groupe: <a href=3D"mailto:bitbake-devel%2Bowner@lists.=
openembedded.org" target=3D"_blank">bitbake-devel+owner@lists.openembedded.=
org</a><br>
Se d=C3=A9sabonner: <a href=3D"https://lists.openembedded.org/g/bitbake-dev=
el/unsub" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.o=
rg/g/bitbake-devel/unsub</a> [<a href=3D"mailto:pierre-loup.gosse@smile.fr"=
 target=3D"_blank">pierre-loup.gosse@smile.fr</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div>

--000000000000b7bc34064cd0c8d7--

