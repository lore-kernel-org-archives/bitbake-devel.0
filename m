Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F65CCFA1A
	for <webhook@archiver.kernel.org>; Tue, 11 Nov 2025 20:11:21 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.26845.1762891872948559084
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Nov 2025 12:11:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=gJJXSxCs;
 spf=pass (domain: gmail.com, ip: 209.85.128.177, mailfrom: jpewhacker@gmail.com)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71d71bcab6fso1135807b3.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 11 Nov 2025 12:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762891872; x=1763496672; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWIK87f2WUUw/jE5/e9294PcjA22ufAlnqOTcRGlYhQ=;
        b=gJJXSxCsdE+4pOt9l05tMphv2uzgI6urgJhYPpp8d7Xusrnrv1Q3aHdjhwKetcS5Mz
         2G51APW+daUoSY+du0fjt68OG03BcBKaXIjjGkwIRWtb2wZD5nbPVC14+MwozFsscsNF
         NzyOFWg7Xeq/P8j1RnqSN3x/spRGOsWud5/jp5/C4aPPiQGKK7wC+aKGLGb8j3Wih+mK
         zGJz+O4w5NBLzGuD51/ASgTBnq2MFLIC+NRrhZ3zc86N5+P19FMNIxhiCmVe9+EX2TAh
         6GZ3u3BfIVuKG31iRzpMuy9c12b1HhFipJR77Wt2IpoBfrtIBwvcg6dGFP2dAh37QGO+
         AsjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762891872; x=1763496672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jWIK87f2WUUw/jE5/e9294PcjA22ufAlnqOTcRGlYhQ=;
        b=j7GPhT/0S+ZwYJQQw41jUUSupridxOMD4RBFl1xsqDhHvs5ySm5lPCnUK1C068qt7z
         w8iobCMaa44rUVdjZhddfl1AX0bp8vNB0nDy7bKXYW/VRNiDGUBW+vzwhuQQtNmNbQSv
         7rhd6vAjjC94TCyb1qOrsOJ/Wi0/bRvjyAcivhx/rca0ZFmw+q5A5xCFGirzQuzLy1oA
         LGOxOiKfuZjKuEEyRNWBA1h2RdYv/LDq7SlDxpZVqUKl6ljbBLClQxhrpOrMUmw6pMRF
         yEOtBHpwMOvyV4i5isY9s+vbloZPN8ofY638d8eWS6ZX3RM6c1KqOSDxcNo0zm24bQrp
         sfvw==
X-Gm-Message-State: AOJu0YwSzRP8hJCsLZKwpEgyeZ5HxtVfaj2B/Bn1Pg1k67yqDlKyk3gC
	V5YtlQ7lIhdntGgofZyn1UTGsgSSPH3VQroVcDtOmB2540I+rRa3VQT5m0WexCG84GrT5uIivoW
	T4QYeXgwT4VTXlZuZcDHTb2D2EZ1937xRRA==
X-Gm-Gg: ASbGncuDefrobVDYf1VYD4S6f3IgqhLGNQ8HL0o/4+6JBhibTuzov2xUdRY6pTCHAti
	ko3L1Z3Po6VjR50ZombzYS5nbnr4YS70pwU4zv1BBweXvqWKJRMvELu7AEivspaEaMrmoao9Sc4
	F9L1NcqVx4AHRujaaHU9KdVvEQfMNBWG0PVLuIr5WbVAsWtIH8nz1uiW2zYfYM2SMGv1wKbZ/g0
	VuwAzOBeEIOzROdLBwIauajt5aDlCQvWGsT1LH831zseZFMtytubIxcFIZEEwc+KcyaIGIqDcs=
X-Google-Smtp-Source: AGHT+IFWlUngNBSHHj6jNjuOpKmuEx6O76907tcsqsb05WgIQ3ig0z6MgWfNuxV8I3Jp0Xv5jMRBmBMiw0KGECZ/egQ=
X-Received: by 2002:a05:690c:4386:b0:787:ffa6:6c4a with SMTP id
 00721157ae682-788136a88a6mr2300677b3.44.1762891871962; Tue, 11 Nov 2025
 12:11:11 -0800 (PST)
MIME-Version: 1.0
References: <a94dfade878b881bbd8c0524a99675983b8b20da.camel@linuxfoundation.org>
In-Reply-To: <a94dfade878b881bbd8c0524a99675983b8b20da.camel@linuxfoundation.org>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Tue, 11 Nov 2025 13:11:01 -0700
X-Gm-Features: AWmQ_bmqjc0EvO1yrNWQqV0otEbLsa6LuFWZ7hjtgEKlE5Kz1MDU4sj5EjEKGTw
Message-ID: <CAJdd5GYNB-s6FiaZDGBSf1DmFHo0cxiyG-uuvYqcGHJyynAiMQ@mail.gmail.com>
Subject: Re: [bitbake-devel] My bitbake-setup testing notes so far
To: richard.purdie@linuxfoundation.org
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 11 Nov 2025 20:11:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18334

On Tue, Nov 11, 2025 at 8:17=E2=80=AFAM Richard Purdie via
lists.openembedded.org
<richard.purdie=3Dlinuxfoundation.org@lists.openembedded.org> wrote:
>
> I've noted down a summary of my recent bitbake-setup testing notes:
>
>
> "bitbake-setup update" moves local.conf changes out the way. I think by
> default there should be a warning about out of date conf files and a
> y/n to move. There should be a command line option not to do this as it
> really isn't what most users expect/want. I do understand why it is
> doing it from an upgrade perspective.
>
>
> As Joshua mentions, we should just error for non-global settings that
> won't do anything.

A patch is sent for this

>
>
> When we set a top level dl-dir, it should filter down into DL_DIR in
> the builds, we do want to share that.

Maybe. I want to set that in site.conf so it's the same for all my
builds (a centralized site.conf is actually a really nice feature of
this tool!). Perhaps a compromise is that the default site.conf has a
DL_DIR that points to the one used by bitbake-setup. I'd rather have
site.conf be the authority on DL_DIR and modify bitbake-setup to use
the same path though it's settings than have bitbake-setup the
authority on where DL_DIR is located.

I'll send a patch for that

>
>
> There is a related issue with sstate-dir (and maybe hashequiv DB?) not
> being shared between builds by default. We have an opportunity to fix
> this right now.
>
>
> The message:
> 'Bitbake-setup is using /XXX/bitbake-builds as top directory ("bitbake-se=
tup settings --help" shows how to change it)"'
> is misleading. If you run that, if doesn't tell me. I need to run
> bitbake-setup settings list and know which one to change.
>
>
> I'm starting to wonder if there should a "--quickstart-help" which
> lists a set of examplecommands to run like:
>
> bitbake-setup settings set --global default top-dir-name poky

Setting top-dir-name to "poky" wouldn't make any sense to me as a
configuration option; --setup-dir-name=3Dpoky is what I would expect
instead.

> bitbake-setup settings set --global default dl-dir /media/build/sources/
> bitbake-setup init poky-master poky distro/poky machine/qemux86-64 --setu=
p-dir-name build

Ostensibly, you don't _need_ to run any of these unless you want to
change the settings. Just running `bitbake-setup init` is sufficient
if the defaults are OK (which, for most people, is probably fine?).
Other than the confusion about changing the top-dir, I really didn't
think this was that bad.

bitbake-setup does prompt the user to continue if it looks like the
top-dir is new (e.g. doesn't contain a site.conf) which gives them an
option to say 'no' and change it. Perhaps instead that prompt should
provide guidance on how to change the top directory name at that
point. I'll send a patch for that

>
> The reasoning being to give people an idea of needing to set some
> global values for thing like dl-dir.

See above.

>
>
> When I run init, the I should be able to edit the default build
> directory name more easily. "poky-master-poky-distro_poky-
> machine_qemux86-64" is a little nonsensical in that I can change DISTRO
> and MACHINE in a build without changing the build directory. Could we
> simplify the default? Should we give the user a hint about how to
> change the MACHINE/DISTRO? I think we do want to be able to encourage
> users to switch some settings in their builds.
>
>
> For settings, is there anything other than the default section? Should
> we perhaps default to default to simplify the commands?

I'm personally OK with the way it is. It matches the git config model
where git has sections and variables under those sections (although
git uses '.' as the separator, e.g. 'user.email'). I understood
'default' to mean the values that will be chosen if I don't say
otherwise, so I didn't find this confusing or cumbersome. I actually
think making "default" the default will be more confusing as to why
some variables need a section and some don't (assuming we add more
sections in the future).

TL; DR - I'd just leave this as is, I don't think it's confusing.

>
>
> We also don't have a good way of mimicking something more similar to
> the older poky layout with bitbake-setup. The autobuilder is the
> closest on that but with some horrible commands, I think we might want
> to find a way to allow that more easily/obviously.
>
>
>
> Any one of these issues in isolation isn't a blocker but together, they
> all make the experience a bit jarring and not what people are used to
> from us. We get one chance at users of the tool, I think this will
> break it.
>
> I do probably have more thoughts, I'll try and keep more notes as I go
> and find things. I'm sorry not to have come to some of this earlier :/.
>
> Cheers,
>
> Richard
>
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18324): https://lists.openembedded.org/g/bitbake-deve=
l/message/18324
> Mute This Topic: https://lists.openembedded.org/mt/116239397/3616693
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [JPEWha=
cker@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

