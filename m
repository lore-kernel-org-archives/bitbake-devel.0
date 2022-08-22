Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262EEC28D13
	for <webhook@archiver.kernel.org>; Mon, 22 Aug 2022 19:57:17 +0000 (UTC)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com
 [209.85.167.52])
 by mx.groups.io with SMTP id smtpd.web12.22867.1661198233924634902
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Aug 2022 12:57:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=EeMo8kVv;
 spf=pass (domain: gmail.com, ip: 209.85.167.52,
 mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f52.google.com with SMTP id q7so13084387lfu.5
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Aug 2022 12:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=LSVfchqsRmc/rT2RhLl5keCqTo1B7A5en2BYxeid+eo=;
        b=EeMo8kVvoBPueHi5bEcHhKXD32ApokXPMtkqdn9E7QWGVA6p49qvRocx3KDrqOqbHp
         RCB6rqTS53CTvk+90hLytB164qgYf2UszlCFnSSJXQLSvnmD7mpswMzQf+fiLKoi9vLA
         GvxW1zIi2HfXD/UwTBjmiyWxIhtIiUuqkOr6ZgY4OrBbGXHP7myDPdl15FOMO477aT4e
         BjgoXfQabgRIjfD2fqlGk+Kn82eOf5UZdM2mNhz4FnN8aC014Q22rPQJ/49v0DW7PfCm
         FVNnVCvkQlCrYV26EdkIiYBVGKQQ2Rko+T0SRlHSMQQhUf0TTL7z4Bom2TkGz9YJI2R8
         H/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=LSVfchqsRmc/rT2RhLl5keCqTo1B7A5en2BYxeid+eo=;
        b=RpIHR5K/NzDGR7p4lPKn5uFul0BWS0khQutZpTW6WgORO0XC7z1PhkYwtfwemKwQpj
         0iUMg0hWU5GtPH3JhOwY8FJu+mkcDq+SCaDeEkLQQqOSDk34k2I51oWDuj2gfMTaKySC
         HkMjcgEwXR3jIKbPkq6Z9KZwcpfFKgYWo3Tgyyj0ykAmnXAhQWFleTX9uJ0uDyq+f/pq
         NXN7Lk6FiFfckbdHTXcihg0DS6UGv+BZ4mvtDYQ5/o2rAY+uYANhIpuD6HIpCqpyeH1q
         koozVoIcMGwP0HEYfn5Frfq2zRluJjuRbncCaIQK/K1SDwk+Iuw6amdy1rqsYV+QOGC2
         PvRQ==
X-Gm-Message-State: ACgBeo0x0a0Frq6utFwJ68vA08cRi6sKhGze5MXu6WUTSHv9DHewBLkj
	6TBPswTf/raPEIXsiOBGohGlc18osnbFMn74xbQ=
X-Google-Smtp-Source: 
 AA6agR7B52AS4L/6YJYInsiizcY/njeXIkIWTddDNIBdizhPzXpf2lMdGWS2YFzRdeukr/5qJdxdSqeWZJpp12e0EW8=
X-Received: by 2002:a05:6512:2987:b0:492:e469:b327 with SMTP id
 du7-20020a056512298700b00492e469b327mr2379130lfb.534.1661198231785; Mon, 22
 Aug 2022 12:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <535F3AC6-0FB2-4559-AFE9-A7DE98519735@bitflipper.net>
In-Reply-To: <535F3AC6-0FB2-4559-AFE9-A7DE98519735@bitflipper.net>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 22 Aug 2022 21:56:59 +0200
Message-ID: 
 <CANNYZj8ixOhOLCF5F9WiH0tEt+SdFoituNekVOW1HiUJ50rbaA@mail.gmail.com>
Subject: Re: [bitbake-devel] Bitbake + Patching
To: bitflipper <forums@bitflipper.net>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Aug 2022 19:57:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13929

Hello,

the correct place to post this question is the yocto mailing list:
https://lists.yoctoproject.org/g/yocto

Alex

On Mon, 22 Aug 2022 at 21:24, bitflipper <forums@bitflipper.net> wrote:
>
>
>
>
> HI, I don=E2=80=99t think this is the right email to be poosing this ques=
tion to, but I am hoping that you can point to the right place where I can =
get my answers. The problem I need to gain more insight on is the following=
:
>
> We are currently using  Zeus, and with Zeus, we get Apacje v2.4.41. But I=
 would like to get a later version of apache because of there have been a f=
ew fixes related to cyber security. So I believe that, given we=E2=80=99re =
using Zeus, we can=E2=80=99t upgrade to the latest version of Apache vis th=
e current recipe that Zeus uses. Therefore I believe that the only way acco=
mplish getting tho the latest version of apache would to be =E2=80=98patch=
=E2=80=99  the v2.4.41 version that comes with Zeus.
>
> Looking at the Bitbake manual, in section 4.1, it states the following:
>
> "BitBake takes several steps when fetching source code or files. The fetc=
her codebase deals with two distinct processes in order: obtaining the file=
s from somewhere (cached or otherwise) and then unpacking those files into =
a specific location and perhaps in a specific way. Getting and unpacking th=
e files is often optionally followed by patching. Patching, however, is not=
 covered by this module."
>
>
> The manual does not cover patching.
>
> Where can I get information on this process of patching something like ap=
ache or any other application that was add via IMAGE_INSTALL_append method.
>
> Any help pointing me to where this process might be documented is much ap=
preciated.
>
>
> Thanks, Jim
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13928): https://lists.openembedded.org/g/bitbake-deve=
l/message/13928
> Mute This Topic: https://lists.openembedded.org/mt/93189128/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.k=
anavin@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

