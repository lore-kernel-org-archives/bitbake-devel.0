Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624E7C433FE
	for <webhook@archiver.kernel.org>; Sat,  6 Nov 2021 06:39:38 +0000 (UTC)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com
 [209.85.222.43])
 by mx.groups.io with SMTP id smtpd.web08.16600.1636180771918875044
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Nov 2021 23:39:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=pjkBEN1y;
 spf=pass (domain: gmail.com, ip: 209.85.222.43,
 mailfrom: alex.kanavin@gmail.com)
Received: by mail-ua1-f43.google.com with SMTP id b3so21246155uam.1;
        Fri, 05 Nov 2021 23:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/+796WBaRvuP7KiqPo+BKCHhoj9yk1+g3NupYYjPRIw=;
        b=pjkBEN1yU4RlaDSUjcMDrWYL1IA85QGyEgZptZOAeUv4/Q9hgPovX+8rQqwRamMuN4
         f8UMGdF2PAHOgboP7xxjQaAar6gxMHX8reDhYFWzFacmdpcUSCAuzIEZe7IfV8I1gSjK
         iB6Xr68zV3hv7zJMjd/AzjjOWAvPTXSFLacohx1+rMtaeNtiZNmOTgFZNO5dGzHqzVCz
         +2fJbrdQOAuHPU+GPxKRXBzCk89CqlvAY76AqctBoAMwEPhagv9qup4IKeh0GJaPnI3P
         FFXbWcvpxJExuJDkpr+P726ncTHsLlG3GH5CqrIkbU7vhBZU+Tu9MdgEfae1HeDMxex0
         7qwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/+796WBaRvuP7KiqPo+BKCHhoj9yk1+g3NupYYjPRIw=;
        b=26eKTcwvGDS/Zhh51KsltDgxkM6EbQPktJtT6DfKaI9p6dI7impkCRoyxWRqNA1hpV
         zG1Wg+nK8d6mspoDhbnwjdqkXKFH0WVdHfuS4+K8MtCi4T2xpJOC1TdqzXUKZfxZsy0r
         d3fRAObv6JIQlAg45rapCUjCdN+mQn/9Z1jIhLw7iinKFsUDWyo/ArCHq6tF+9Y3KVXl
         iLPyfOn0nQRM8wwkBPlzVTYMrp+GUW+tWmGYHeKL3FGR2kMlSGoEbdqTACXo428Xz4OR
         Yep832Oa1Y16pldIxjbCtJNRFm7DjSDY3FJS9FIJWjAbKGmZoXlinbJJMUdUlNH+0wjd
         HGlw==
X-Gm-Message-State: AOAM530GHyAb4Q+TIGuadkNonu5mXnJtpb0RgbHpXmbCzOokaj8+/IYR
	bFoRCe5PAFGe8iN7sWlZhY3Au0xQSIaYXZLIVhI=
X-Google-Smtp-Source: 
 ABdhPJwSAhUGTHawn1yzUunaXzNKx+2J1i3yL5nrAETITuRyJi/PMxkQw7BWVMlVKo7M/DSMPclyPCcWWtQA6PVzWZA=
X-Received: by 2002:ab0:30e1:: with SMTP id d1mr71943934uam.22.1636180771100;
 Fri, 05 Nov 2021 23:39:31 -0700 (PDT)
MIME-Version: 1.0
References: <20211105133104.19895-1-jasper@fancydomain.eu>
 <CANNYZj_s8_PkKfMQnBxNZLs-p0F5xb4StCXiF84OkbE5zpptqw@mail.gmail.com>
 <ea3f24549a6e54f880e925e8f5cf6128fc5629f9.camel@iris-sensing.com>
 <CANNYZj9sxmakRNGKUuH+ZAWDMJs2EhKT5O4f8HRxd=ovhQPpug@mail.gmail.com>
 <281CD8F4-9B15-40A6-9AAE-F2C0D633E5AD@fancydomain.eu>
 <CANNYZj-pKjvRT+Y39mT-t3G+GBON0Z=xZFURJH8AhPGfjOf7yw@mail.gmail.com>
 <37710923b54b6675d315124f3916eb9c19c233e1.camel@iris-sensing.com>
In-Reply-To: <37710923b54b6675d315124f3916eb9c19c233e1.camel@iris-sensing.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Sat, 6 Nov 2021 07:39:19 +0100
Message-ID: 
 <CANNYZj9jhht0X12ktW7JCAS5o=FCZbxS9=x=CBX84Xku1GL4ng@mail.gmail.com>
Subject: Re: [bitbake-devel] [oe-core][PATCH 1/2] devtools: Initial recipe for
 repo 2.17.3
To: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
Cc: "jasper@fancydomain.eu" <jasper@fancydomain.eu>,
	"openembedded-core@lists.openembedded.org"
 <openembedded-core@lists.openembedded.org>,
	"martin@mko.dev" <martin@mko.dev>,
 Daniel Baumgart <Daniel.Baumgart@iris-sensing.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="000000000000a65ad605d0190586"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 06 Nov 2021 06:39:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12921

--000000000000a65ad605d0190586
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Nov 2021 at 21:32, Jasper Orschulko <
Jasper.Orschulko@iris-sensing.com> wrote:

> So yeah... as far as I can tell, there are multiple ways to approach
> this issue, but none of them seem straight forward nor pretty. Bitbake
> as it is is just fundamentally not good at handling highly dynamic
> configurations. The combination with KAS somewhat defuses the
> situation, but there are still some situations where there is no easy
> answer.
>

Yes, yocto does not support 'variations' of the build that is already set
up. Once you set the distro, and the machine, there's only one way to build
a recipe; if you want another way, you need to indeed make another recipe,
or another distro. I would still say making a set of distros is still the
proper 'yocto way' to solve your problem. There are examples in meta-poky:
poky-altcfg and poky-tiny, and there has been poky-bleeding-revisions or
similar in the past.

This is a reoccurring topic; there have been proposal in the past to
introduce 'variants' as yet another abstraction, but they add so much
complexity on top of what is already very complex, that the tradeoff is not
acceptable to the project.

Alex

--000000000000a65ad605d0190586
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Fri, 5 Nov 2021 at 21:32, Jasper Orschulko &lt;<a href=3D"mailto:=
Jasper.Orschulko@iris-sensing.com">Jasper.Orschulko@iris-sensing.com</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
So yeah... as far as I can tell, there are multiple ways to approach<br>
this issue, but none of them seem straight forward nor pretty. Bitbake<br>
as it is is just fundamentally not good at handling highly dynamic<br>
configurations. The combination with KAS somewhat defuses the<br>
situation, but there are still some situations where there is no easy<br>
answer.<br></blockquote><div><br></div>Yes, yocto does not support &#39;var=
iations&#39; of the build that is already set up. Once you set the distro, =
and the machine, there&#39;s only one way to build a recipe; if you want an=
other way, you need to indeed make another recipe, or another distro. I wou=
ld still say making a set of distros is still the proper &#39;yocto way&#39=
; to solve your problem. There are examples in meta-poky: poky-altcfg and p=
oky-tiny, and there has been poky-bleeding-revisions or similar in the past=
.</div><div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">This=
 is a reoccurring topic; there have been proposal in the past to introduce =
&#39;variants&#39; as yet another abstraction, but they add so much complex=
ity on top of what is already very complex, that the tradeoff is not accept=
able to the project.</div><div class=3D"gmail_quote"><br></div><div class=
=3D"gmail_quote">Alex<br></div></div>

--000000000000a65ad605d0190586--

