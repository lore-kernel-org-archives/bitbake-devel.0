Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E853C27C5F
	for <webhook@archiver.kernel.org>; Mon, 10 Jun 2024 09:26:50 +0000 (UTC)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
 by mx.groups.io with SMTP id smtpd.web11.15427.1718011604193497119
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 10 Jun 2024 02:26:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=TpxiGwZ2;
 spf=pass (domain: gmail.com, ip: 209.85.167.53, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52bbdb15dd5so3068764e87.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 10 Jun 2024 02:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718011602; x=1718616402; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pOSO+bTHHKqz2yUMZuZ0FXPLU/CxxeJ9VM05o/n0bA=;
        b=TpxiGwZ2CGKELLXx1r6wJk0KskLWs9lBd2FmN1zRsF2KoRuyMj4UnNj6ejhnZCpRyw
         an7bxxmglNskNpkCSiEE5+TfrQ/0HatghF5bPSVzcs6cXRjNw69P9Uk7zmeWFUkhNwJx
         ueX74jhUam19jdX4ekZhxPSnGjZQg32RIekjS+2YCmR6a4sdSxp4aNQNkyrKrUR66vy1
         xV15bvwgDdeREIIFkmvq9cc0ciLTK7b7IXxBhcR/kaduMhF7T7goaWbde7UJZ0hYe5de
         c2dQwAb1Bta8wOT1WUFFeiP5DBvSgopNUBCtaJAaDJOTVnFnOfRBcraRl/vLtLhWXB2R
         XFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718011602; x=1718616402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5pOSO+bTHHKqz2yUMZuZ0FXPLU/CxxeJ9VM05o/n0bA=;
        b=dDEcGzLM//q9wATDKo3MyyPpNrUdJtYyj8llJlBAB1FfqwAGGiaborYfmnP27yQJEl
         txBqkpvz4mK7qHcko2pCZ4A+IxqVBr1dSjbIOkz9w1GhDTtFjyx3nCKFRNgMvNLxea3S
         7QLPFBQFW7xu5UilApSiTizeKDyWztVbdG77eFnucvbSbVRJYNp2Gab4Bz/IEyjT11eO
         sqyH1jqatRDeRRyQImFKuJugIA5hlVvyxJqkll+gt6oEX7NfnBpysS/K5W4oH942HIy6
         /3dd5Cy/ozY8AeJA97no8GU4oyKvBoypuRlVYzoUOb3z5DxH54/al5CGmoI7CtkeoYv/
         17EA==
X-Gm-Message-State: AOJu0Yx9c8oML/eJwv54ycrYXSl07mqDonib4J6y/ateLo1oUfeShBqW
	tUvG/jemMXd1dbL1GIwrdzbl1FwzZsed3UCPZqqlGdG7tLAXE+kF4c7UpG10LDIidfWV356J/hW
	BbNMpEvOCu4gwaeK+jQWEdKVMtZM=
X-Google-Smtp-Source: AGHT+IFZpcBIOWzBXYEobRIPQKH+CvGQWQdlm4BzFEpBHe+isVMaNMtMVwWWLrp5eIqKJYdtpbNKkaucUDRD6wR7cdQ=
X-Received: by 2002:a2e:8752:0:b0:2eb:120c:1a59 with SMTP id
 38308e7fff4ca-2eb120c1b22mr40730581fa.16.1718011601780; Mon, 10 Jun 2024
 02:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <24273.1718010239225296120@lists.openembedded.org> <Groupsio.3.24273.1718010239225296120@lists.openembedded.org>
In-Reply-To: <Groupsio.3.24273.1718010239225296120@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 10 Jun 2024 11:26:29 +0200
Message-ID: <CANNYZj_Y5q497u-KseXrBNgn9g_YKyUJoA4+5TMFv1PsW09sAA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2] fetch2/wget: Add user_agent parameter
 so it can be used optionally
To: egyszeregy@freemail.hu
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 10 Jun 2024 09:26:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16339

I can't agree with this. Setting a custom user agent is not a solution
either, it's a workaround, just slightly less cumbersome than using
FETCHCMD_wget.

If you make it easy to set custom user agents, then the actual issue
(broken servers) will never get reported, let alone solved. You don't
need to report it to server administrators; the correct people are
those that placed the download artefacts onto those servers. They
might be open to moving those artefacts elsewhere, or if they are as
well uncooperative, the recipe maintainers can move them and update
the recipes (which has to happen for older yoctos in any case).

Did you contact meta-xilinx maintainers about the issue? Can you
report it to them first?

Alex

On Mon, 10 Jun 2024 at 11:10, Livius via lists.openembedded.org
<egyszeregy=3Dfreemail.hu@lists.openembedded.org> wrote:
>
> [Edited Message Follows]
>
> Yes FETCHCMD_wget can solve it, but it is a workaround and not a nice sol=
ution. Moreover need many experiences for it to understand where and how ne=
ed to be used, it is not optimal for Yocto end-users, also there will be no=
 any official documentation about that it is a recommended ugly solution so=
lve this issues in recipes. I can not believe this kind of "hacking" is the=
 best to use for long-term solution, this issue need to be solved even more=
 in many recipes in the future in my opinion (more and more HTTP servers ar=
e going be crazy in the future).
>
> In a last commits regarding user-agent every info about this situation ca=
n be found in its commit message.
> https://github.com/openembedded/bitbake/commit/d6fa261a9603677f0b3abbd309=
c1ca6073b63f4c
> This patch was not ready to solve this in a good way, therefore it was re=
verted because Jfrog Artifactory does not like it if wget use a browser use=
r-agent, so it must be not a hardcoded wget downloading mode.
> https://github.com/openembedded/bitbake/commit/feef5cd12e877f42ffcace168d=
44b0e6eb80a907
>
> I also run in to this same issue, because dear AMD changed there HTTP ser=
vers to be stupid with wget (it is now affected in all old Yocto releases a=
s well, thanks AMD).
> https://support.xilinx.com/s/question/0D54U00008RolRMSAZ/yocto-metaxilinx=
core-cannot-find-pmuromnative-url?language=3Den_US
>
> Nobody from us can solve the server issues, not I am and not You are the =
server maintainers of this big tech companies, they will never take care ab=
out this problem in Yocto, i think. So it means a nice and easy solution ne=
ed to be provided by the Yocto project/bitbake about this issues.
>
> It is clear for me there are some random HTTP server hoster which does no=
t like wget downloading and must be used some fake browser user-agent for t=
hem and unfortunately there are other server hoster which do the opposite i=
ssue, a browser user-agent can require an interactive browser for download =
(wget can not do it).
>
> So my opinion, user-agent must be an enable/disable parameter for wget fe=
tcher. It will helps for recipe maintainers to use it if need. Default "Moz=
illa/5.0 (X11; Ubuntu; Linux x86_64; rv:126.0) Gecko/20100101 Firefox/126.0=
" user-agent in BB_USER_AGENT will be fine in 99% if need to use it, but al=
so it is easily changeable in a recipe file if maintainer found out, there =
need to be use any other user-agent for a specific HTTP host server/URL.
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16338): https://lists.openembedded.org/g/bitbake-deve=
l/message/16338
> Mute This Topic: https://lists.openembedded.org/mt/106583049/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.k=
anavin@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

