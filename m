Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C77CDB47E
	for <webhook@archiver.kernel.org>; Wed, 18 Oct 2023 20:07:35 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
 by mx.groups.io with SMTP id smtpd.web10.11363.1697659650959457825
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 18 Oct 2023 13:07:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=hjoIDU5O;
 spf=pass (domain: gmail.com, ip: 209.85.128.177, mailfrom: ticotimo@gmail.com)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5a7ac4c3666so89038487b3.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 18 Oct 2023 13:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697659650; x=1698264450; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pjmzMzhNxkLwhvjG+c5GKg2Pvi8BwUB7hr6Md6/YOhs=;
        b=hjoIDU5OE9myVoKI/InxCsrKRfsvHP3Fxj8pBGCigORqqgUE6pxZcqCBxkbTZMpQsp
         zv0CtQVvVj8Gw7WqhYl+txhY/LD6T2TvnvPXhdqsZmY90igL4SKs2FXZ40hR8JVRDA+7
         kRKbsmxQ4jwNcJcG/eVLNMbhGbUUiNx5Q+3+Sf6DKxxEdnTejElU5wrd+LvOYiCGjZJv
         BdsrG1kvtsjo6yPyank1ocKDaMhUHBQHSNUfz+HHP8A8KlxdKYf5C5zVPn4+8gfz3Xs5
         LSDFzdmyxF2atGz8iIXdf9YuLh/aXkGPxoUp1hK43NWoHebilF3Hp0kZNJuoc7tikJxu
         IOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697659650; x=1698264450;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pjmzMzhNxkLwhvjG+c5GKg2Pvi8BwUB7hr6Md6/YOhs=;
        b=JCgAHR4/jvUyxrSVIUdRQ4w73wSHWUOk2w8EJIUbn1MaypmqGrhwLPlliuXuMXjEbY
         EYIY8XBYp90WY5ACUhmbgkQv6J66UhbYEOz4zNG4LUB0v5rTtjY45I+ZDbuArLVdGz7T
         bg21tcHFMXMopsAeuHzdWP8rSC1SBFQIOkED6I4ahSK81ZqJJhEANTIYhUnMGyLkEOpR
         9CdvlDSFO1s143sp6Khr31V1ceqKCPcSBFgw6v/0tU8ED6HlP2o8t/zWVyEN+iG+NLgY
         wM9QDmiKLbljxQB7e9R1LX4G3Jasm0HqB2vrXdvQqOOzGZZiaiV5kgVHE1HkLEeQzagH
         Tx7A==
X-Gm-Message-State: AOJu0Yybv9T6RDaNK/J+wEeaNly52KM+ZgtOIzLVgJFf6ol1eFF/uKIE
	HFCrLiacLRbBd4kBoXhN34NZzLw707TVHkBokkM=
X-Google-Smtp-Source: AGHT+IHvNMa41SUSOcIQ43WfOy/WMPEicSL5JkSXaujIee5tpJt8mAOnMVRozmRwBnUnd4vhKlBSnj95Qpp8Piz+XjI=
X-Received: by 2002:a81:4996:0:b0:5a8:3550:61b2 with SMTP id
 w144-20020a814996000000b005a8355061b2mr345944ywa.29.1697659650072; Wed, 18
 Oct 2023 13:07:30 -0700 (PDT)
MIME-Version: 1.0
References: <CANx9H-Df7sm427L8pB50CfraS_Grx6Sj_TG-jUXTX9Qw=N3S5A@mail.gmail.com>
 <6763.1697659027490126820@lists.yoctoproject.org>
In-Reply-To: <6763.1697659027490126820@lists.yoctoproject.org>
From: Tim Orling <ticotimo@gmail.com>
Date: Wed, 18 Oct 2023 13:07:19 -0700
Message-ID: <CANx9H-DACKkbym_Q0RKY8BOg26eB-spWS9AabNrX=p19A1fGgA@mail.gmail.com>
Subject: Re: [Toaster] [PATCH] toaster: add tox.ini file to execute flake8 and
 test suite
To: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
Cc: toaster@lists.yoctoproject.org, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="000000000000646988060803300c"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 18 Oct 2023 20:07:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15260

--000000000000646988060803300c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

this reply is sent to both toaster@lists.yoctoproject.org and
bitbake-devel@lists.openembedded.org

On Wed, Oct 18, 2023 at 12:57=E2=80=AFPM Marlon Rodriguez Garcia <
marlon.rodriguez-garcia@savoirfairelinux.com> wrote:

> i send it to both as requested by richard, should i not?
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#5875):
> https://lists.yoctoproject.org/g/toaster/message/5875
> Mute This Topic: https://lists.yoctoproject.org/mt/102046799/924729
> Group Owner: toaster+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/toaster/unsub [
> ticotimo@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000646988060803300c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">this reply is sent to both <a href=3D"mailto:toaster@lists=
.yoctoproject.org">toaster@lists.yoctoproject.org</a> and <a href=3D"mailto=
:bitbake-devel@lists.openembedded.org">bitbake-devel@lists.openembedded.org=
</a></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Wed, Oct 18, 2023 at 12:57=E2=80=AFPM Marlon Rodriguez Garcia &lt;<a=
 href=3D"mailto:marlon.rodriguez-garcia@savoirfairelinux.com">marlon.rodrig=
uez-garcia@savoirfairelinux.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">i send it to both as requested by richard,=
 should i not?
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#5875): <a href=3D"https://lists.yoctoproject.org/g/toas=
ter/message/5875" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctop=
roject.org/g/toaster/message/5875</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/102046799/924=
729" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/mt=
/102046799/924729</a><br>
Group Owner: <a href=3D"mailto:toaster%2Bowner@lists.yoctoproject.org" targ=
et=3D"_blank">toaster+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://lists.yoctoproject.org/g/toaster/unsub" rel=
=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/g/toaster/=
unsub</a> [<a href=3D"mailto:ticotimo@gmail.com" target=3D"_blank">ticotimo=
@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--000000000000646988060803300c--

