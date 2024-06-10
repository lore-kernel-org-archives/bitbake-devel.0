Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E04C27C55
	for <webhook@archiver.kernel.org>; Mon, 10 Jun 2024 09:48:50 +0000 (UTC)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
 by mx.groups.io with SMTP id smtpd.web10.15888.1718012923705209606
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 10 Jun 2024 02:48:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=B5Sv8mce;
 spf=pass (domain: gmail.com, ip: 209.85.208.182, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ebe40673e8so10086481fa.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 10 Jun 2024 02:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718012922; x=1718617722; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kRUe3FCcGHs9CxI/oTPqt6TEAKU02X+OZZNir3JO9Ek=;
        b=B5Sv8mcepwwUEVOHMxccTtqVi2h260GGxj3+O2HiBOvkVtIFutlEr60BHyYexfzoNQ
         N2Yr/3KRmVwVYf/IvvxRZlBCT37mQmvCpIdDediskPu0R8hYM7dye9y1DWl+j4WUSBf/
         va5PvjAnp8DQ6QoI5mrYYv3sm0GsvdvUdUukzc9GtkSQA0xu1XhvBMc39YXQdfVBJkc7
         IVTw6zpy4lnl/Yb4oPb0Zc0VpeEfyZIPvrlRs9bse1498+QhFq30/CWFRbH1ktS0IYHy
         Hl4aSHajHyZ6em/yWz+pHjWjhbOUNxrPXY3b6QZ487r1Aa1sTENiOFakchFcUZ/0PsGD
         dCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718012922; x=1718617722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kRUe3FCcGHs9CxI/oTPqt6TEAKU02X+OZZNir3JO9Ek=;
        b=IHmzVIr76nNPjsemA2vovxMnfXhHb5FXIAH3uuz+aV60s7LshCKBn3byp1Ld3eotfB
         t1eNxyicml9KrAqNhQTYJjy4PSTkSvGDvZ/wlJ8iiUD0P31bibtI9NR/EudG6a0+ZG8o
         O0qx434io69FGzhH6VQ1jbxBmiVmnz1EsO379a11u92kI49cawLDel2oZPn3hCe7fpxR
         ZbIiOV/397FbvukvW26oySTinLer3sSOIJOUqrWv2zLKJRM4lyPWQ3O/K/pw7umXWv9o
         wW3qXrNJTVLNSKxv7WgS8eJytrG0ud0U3DkjKZ0W3/EUmg6GxdTyJePuTijJ2ascwCfw
         SB7g==
X-Gm-Message-State: AOJu0Yy6efuM7sSBHb30Ubh4ALU+6L/MfYH/AuJM7QcCIuncSThAHezI
	OOOM8DMQHyFiwrn5yo5GTS3CgFBllqYJVd248m6LgR72Z4Gl/jXo6Y1pt4jj6q5zN4HhGR1vIrm
	pCopcfphbuMIYW7d0gGWEv3+eJ+M=
X-Google-Smtp-Source: AGHT+IElM/3bt3ILhEKKfilCeCJWdFwdYs3QMtiFZIGHkgIcndbZPdImPD7TJcOy8nP9tbXwdniPVaC21xppeU4zRlM=
X-Received: by 2002:a2e:3615:0:b0:2eb:e9c0:ab69 with SMTP id
 38308e7fff4ca-2ebe9c0ac3bmr8297391fa.39.1718012921570; Mon, 10 Jun 2024
 02:48:41 -0700 (PDT)
MIME-Version: 1.0
References: <CANNYZj_Y5q497u-KseXrBNgn9g_YKyUJoA4+5TMFv1PsW09sAA@mail.gmail.com>
 <24273.1718012691661826958@lists.openembedded.org>
In-Reply-To: <24273.1718012691661826958@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 10 Jun 2024 11:48:29 +0200
Message-ID: <CANNYZj8q2NngfY5Z5z6rMH779_HRi99JngNC-GL4hMnTxRhxrA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2] fetch2/wget: Add user_agent parameter
 so it can be used optionally
To: egyszeregy@freemail.hu
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 10 Jun 2024 09:48:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16342

Not to the server hoster companies. I asked you to report this to
upstream maintainers that placed those artefacts there, and to the
layer maintainers that wrote recipes that fetch those artefacts. Don't
jump into writing a whole new universal solution before you get
feedback from meta-xilinx folks, and a possible alternative solution
from them.

Alex


On Mon, 10 Jun 2024 at 11:44, Livius via lists.openembedded.org
<egyszeregy=3Dfreemail.hu@lists.openembedded.org> wrote:
>
> Do you motivated to collect the all of URLs in a list which are broken an=
d all the time update/report them to the server hoster companies? (more the=
n half of them will be never response for you anything)
>
> I have no time for it, rather more I am motivated to make it as a "new us=
er-agent feature" for wget fetcher to use it a slightly less cumbersome sol=
ution. If need it can be used quickly this is the main goal. This is what n=
eed to the Yocto users/maintaniers whit correct documentation not any ugly =
undocumented suggestions and workarounds for it which are available only fr=
om random topics in forum and mailing list.
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16341): https://lists.openembedded.org/g/bitbake-deve=
l/message/16341
> Mute This Topic: https://lists.openembedded.org/mt/106583049/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.k=
anavin@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

