Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BE8C433F5
	for <webhook@archiver.kernel.org>; Thu, 16 Dec 2021 08:15:51 +0000 (UTC)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com
 [209.85.222.44])
 by mx.groups.io with SMTP id smtpd.web08.7412.1639642549991615018
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Dec 2021 00:15:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=EtQza4gm;
 spf=pass (domain: gmail.com, ip: 209.85.222.44,
 mailfrom: alex.kanavin@gmail.com)
Received: by mail-ua1-f44.google.com with SMTP id y22so9793997uap.2
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Dec 2021 00:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=raYp3/39g3h2TbMKQBfjHxENHkdyb2n4rqzvhpEpnQQ=;
        b=EtQza4gmUq07IW4GgMCo+FQFRD474f3xajGRhbfrT7QlmJKd+jelcyT3X3mJrM9Ov3
         sXwbEo6boA/6A6q2pxEbSWfZ3BUvgG0lEBfSOAcD1pBfi7muo/P/qGcbpKDlXNcSqqCz
         jCa3uWQrbm2j5IwBVaSWsId5CLLPtDWzXQXjEBr/FhiH0niwrazJ+FsKNfYb0DI9FFss
         1Q+Cpnr6CEJhZToy21KipgiQZTmDCZMOQsKH9jl6d9zaCJgmPNLq0/1n87n0Ajk5i2KI
         hScUzAZaPol1XmrvTeBkxaZZ/R5imFH91SAgVy5+zq9Rcs5SCJMynU7DlMDV3BSqNeDD
         krYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=raYp3/39g3h2TbMKQBfjHxENHkdyb2n4rqzvhpEpnQQ=;
        b=5SX4qAthK3f/ccMDcg+7dTvYuxO1bKcDKbZuH3csxvbFxbeLvlh0Fixni/qWdRupR4
         q1TVZAB/KTcTxhUYOL3uIR7Fu6xZHaAngNUVcjyIBVB1vFTbDbSuD5Jp5gC5Ix04T+kb
         q0IoJeC/+Q7UFgpGFi2Ng68ng3CA6kXxr5qFxKIUyvyp5JXhGQnWflThDA/3NERxtDZE
         mAKw4Ml2CiRPf32CAMWvJYpX5+vfGvWuFA3sTZYoQcGdckTrb9jxz/d+2FNLcjvPOSbS
         pSbglSSgbttSSTqPUyLsdpJqdT2z4RtpRbuU0sk51Bf6Bss0iU0Y9QsUSrAImvuxxWIC
         7s1A==
X-Gm-Message-State: AOAM5307NWprF3gMPV5anWX2JR/J+bQmYraIP/sF41HW6/Z4YbMEIR40
	lnhfK5vLa1bO1ff/44EygN6gL1LTNuMB1b3Wnzc=
X-Google-Smtp-Source: 
 ABdhPJytnCaCggDgrkVHYCq214/O4HNsnAFaf5APKlJQKmIpH2Y5nSX4KNjB+BtSToUhcxqD6eRnkiQXRoTzEGzQEQ8=
X-Received: by 2002:a9f:218c:: with SMTP id 12mr11525437uac.71.1639642549121;
 Thu, 16 Dec 2021 00:15:49 -0800 (PST)
MIME-Version: 1.0
References: <20211215142449.13469-1-pontusja@lap5cg1077w4w.se.axis.com>
 <CANNYZj-EFA-tZzFLQvVDrLmiFyat5BsU14nyKdQ3BC7gzsmPfg@mail.gmail.com>
 <5d35085259c04e5a9e0177430f316dd6@axis.com>
In-Reply-To: <5d35085259c04e5a9e0177430f316dd6@axis.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 16 Dec 2021 09:15:37 +0100
Message-ID: 
 <CANNYZj8OvCOk3mQbedykKN2zJr7V74SNdn4S6e-x7OYsEj1O=g@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC] Implementation of a submodule fetcher
To: Fredrik Gustafsson <Fredrik.Gustafsson@axis.com>
Cc: Pontus Jaensson <Pontus.Jaensson@axis.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="000000000000b2f79205d33f0720"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 16 Dec 2021 08:15:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13173

--000000000000b2f79205d33f0720
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Dec 2021 at 06:31, Fredrik Gustafsson <
Fredrik.Gustafsson@axis.com> wrote:

> bitbake has already support for non reproduceable builds, you can set
> SRCREV to a branch, which will change. This patch is actually for
> introducing reproducible builds, however the information is in git and not
> in bb-files.
>
> The usecase here is traceability. Let's say you're developing a package
> and you want to integrate that to your bitbake system. It will require two
> commits, one to the package repository and one to the layer repository. You
> can get around this by settings SRCREV to a branch but then you no longer
> get reproduceable builds.
>
> To solve this, we have built a service that once a package is updated, the
> bb-file in the layer repository is automatically rewritten so match the new
> version of the package. This is error prone and cumbersome. Using the layer
> repository as a superproject will made it possible to use gerrits
> superproject subscription that makes the layer repository to be updated
> each time the submodule (the package) is updated. This gives us
> reproduceable builds, only one commit to introduce a change and no inhouse
> developed services.
>

Apologies again, but without organizationally enforcing submodule structure
this fetcher is not providing reproducible behaviour. If there are no
source code checksums available for bitbake to verify during fetch, then
there's no guarantee that the component repo has not been modified, and
that guarantee must be technical, not organizational. The requirement for
all fetchers is that they provide that ability: you can switch it off if
you want to, but that is not allowed to be the default (or only) behavior.

If the problem is updating SRCREVs in a recipe, there is a standard,
official way to do it: 'devtool upgrade'. Would that work for you?

Alex

--000000000000b2f79205d33f0720
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Thu, 16 Dec 2021 at 06:31, Fredrik Gustafsson &lt;<a href=3D"mail=
to:Fredrik.Gustafsson@axis.com">Fredrik.Gustafsson@axis.com</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">




<div dir=3D"ltr">
<div id=3D"gmail-m_2139662143445721374divtagdefaultwrapper" style=3D"font-s=
ize:12pt;color:rgb(0,0,0);font-family:Calibri,Helvetica,sans-serif,EmojiFon=
t,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&=
quot;Segoe UI Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols" dir=3D"l=
tr">bitbake has already support for non reproduceable builds, you can set S=
RCREV to a branch, which will change. This patch is actually for introducin=
g reproducible builds, however the information is in git and not in bb-file=
s.<div style=3D"color:rgb(0,0,0)">
<div><br>
</div>
<div>The usecase here is traceability. Let&#39;s say you&#39;re developing =
a package and you want to integrate that to your bitbake system. It will re=
quire two commits, one to the package repository and one to the layer repos=
itory. You can get around this by settings
 SRCREV to a branch but then you no longer get reproduceable builds.</div>
<div><br>
</div>
<div>To solve this, we have built a service that once a package is updated,=
 the bb-file in the layer repository is automatically rewritten so match th=
e new version of the package. This is error prone and cumbersome. Using the=
 layer repository as a superproject
 will made it possible to use gerrits superproject subscription that makes =
the layer repository to be updated each time the submodule (the package) is=
 updated. This gives us reproduceable builds, only one commit to introduce =
a change and no inhouse developed
 services.</div></div></div></div></blockquote></div><div class=3D"gmail_qu=
ote"><br></div><div class=3D"gmail_quote">Apologies again, but without orga=
nizationally enforcing submodule structure this fetcher is not providing re=
producible behaviour. If there are no source code checksums available for b=
itbake to verify during fetch, then there&#39;s no guarantee that the compo=
nent repo has not been modified, and that guarantee must be technical, not =
organizational. The requirement for all fetchers is that they provide that =
ability: you can switch it off if you want to, but that is not allowed to b=
e the default (or only) behavior.</div><div class=3D"gmail_quote"><br></div=
><div class=3D"gmail_quote">If the problem is updating SRCREVs in a recipe,=
 there is a standard, official way to do it: &#39;devtool upgrade&#39;. Wou=
ld that work for you?</div><div class=3D"gmail_quote"><br></div><div class=
=3D"gmail_quote">Alex<br></div></div>

--000000000000b2f79205d33f0720--

