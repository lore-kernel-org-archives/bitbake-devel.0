Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5F8CCF9E3
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 15:28:52 +0000 (UTC)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16384.1762961328018471275
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Nov 2025 07:28:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=lVMVLUsc;
 spf=pass (domain: gmail.com, ip: 209.85.128.171, mailfrom: jpewhacker@gmail.com)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71d71bcac45so8789797b3.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 12 Nov 2025 07:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762961327; x=1763566127; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMQ2B3QiQ2TQKaN/PZDI6BEPr9T4HMWrr1f3pFb33i0=;
        b=lVMVLUsc5u3WzFbMEmqZpm0IRHPR24G6TDBNev4e1ORyKJJTLoHQk0vCGpYdSB5Dnx
         0YTJDFjma2dYVpcLU8aPcdGW+hC5y3Q2HFeuxBydsw+PoWRNwEHHp4AjedSPdWy7iqKk
         8dOkDXRL0BRwVdCN0QGXD7lVi6XQv0dAIoBUDfj78F+Y33wY4DLf58alUmGaF5uHWreO
         axDzjzWcGMtFX2bkP2z+yoO01DS7GD+HLanceoDJh4E4Qw2ulxInOa7ydk8kAU2jiC4J
         A5VCAwSGj8tEZsAjQ4s1KHZ3qty+iBi7lU40ZUbNCTzGTXJ/0e/y26aXtPTuIHICxzPf
         I0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762961327; x=1763566127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oMQ2B3QiQ2TQKaN/PZDI6BEPr9T4HMWrr1f3pFb33i0=;
        b=dd3imvoezh4xxwj01cIJOoybndFLPd8CoppGijfEsCeU0hxo1dnXGtXzhH4mHYHIHf
         wb94XMoKYjJ8kQOSIzavTliXMGcBliq/gvjso6UczTBTYI7QRbcp4TpF7Xse8yCZL6K2
         JYU+gUZ1ibVMlsyXqKQJYFodIigAAV+q0jP+oIMUfgQ95ZUsCHqQNXrZ8FU4Dx+rgPCU
         05/ESH4BPsWDYnMxoT5XUtMi9sofigJHMgZozb3TSPlUYvBKByyvme5z/BGiHQaDLOml
         kYstuF79WvPItKblkAJFavKBwG7LcXa9xpJ3V3mgVigQwSIdEn9sLEb67d8J+YqR4NTv
         3YLg==
X-Forwarded-Encrypted: i=1; AJvYcCWo+GxaYfEybfkT5/BGVOYc/alVy1O3TCEjpAC9GBxzETxhN1yXhcQqfi5etIkn7A+CLsCWPrG3MAFYFec5@lists.openembedded.org
X-Gm-Message-State: AOJu0Yz0BNU/FiIHtlsOibp5wepbbj1PIUUlY69P4BRDzhvgP1thoBHR
	hOgStrbRemgkjfTSCntCkG7670yHpEk3ipNK1mfSmnti8YNeXnCGM3NIwCBXaIIKhPjGeiR7byn
	P7RLR9f9249y8a+2e9bwj9S93sYAr4NlbYw==
X-Gm-Gg: ASbGncvmWtRWm2uSksqmx3MEYyl7+2CATregTznfkJhrS7zcI4FugFJxA+M5YqWiSLH
	I3+zVY76v5H7GjPgRSAKgYwRmTSTUQUibbStBhwSUOpsNMo5aMJ2dQN4ELb2xPEFpJEvnZN2FVl
	2hZ9HSg2YrIjksw46tUYrm/mCt4GZunhj7T771AL0rIFH4Unh+tk5mmkqXAFe5rPW4aaro5QPIq
	0MIylMa2P77F+LQGqcWxNhg10PqEFTfqdJzRqG6dg+wvk3215joOfkH7j4tiXZoz+uN97BFIPc=
X-Google-Smtp-Source: AGHT+IHexjTgehpHOp8QOgXHwZ/Mv6cKDoF1PcapJMIledieDDOJXP7jwAVO2kXI8iHInQipS/ugzMw+p2nU+9yIz/g=
X-Received: by 2002:a05:690c:5312:b0:786:6a75:b705 with SMTP id
 00721157ae682-78813612cd4mr22494097b3.8.1762961326980; Wed, 12 Nov 2025
 07:28:46 -0800 (PST)
MIME-Version: 1.0
References: <a94dfade878b881bbd8c0524a99675983b8b20da.camel@linuxfoundation.org>
 <CAJdd5GYNB-s6FiaZDGBSf1DmFHo0cxiyG-uuvYqcGHJyynAiMQ@mail.gmail.com> <2460b48d-e465-4f00-bfb8-b7b88111a90d@gmail.com>
In-Reply-To: <2460b48d-e465-4f00-bfb8-b7b88111a90d@gmail.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Wed, 12 Nov 2025 08:28:35 -0700
X-Gm-Features: AWmQ_bnoCWZGzhb2jT-hPkewP3Bp64n49bHg8gcWQzT7us1J32YRvucpxCsAaYg
Message-ID: <CAJdd5GYzS9Jno=w=mooVLXysnGfHWsNOQUjwpq6hUyik-cSNaA@mail.gmail.com>
Subject: Re: [bitbake-devel] My bitbake-setup testing notes so far
To: Gyorgy Sarvari <skandigraun@gmail.com>
Cc: richard.purdie@linuxfoundation.org, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Nov 2025 15:28:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18353

On Wed, Nov 12, 2025 at 12:46=E2=80=AFAM Gyorgy Sarvari <skandigraun@gmail.=
com> wrote:
>
> On 11/11/25 21:11, Joshua Watt via lists.openembedded.org wrote:
> > On Tue, Nov 11, 2025 at 8:17=E2=80=AFAM Richard Purdie via
> > lists.openembedded.org
> > <richard.purdie=3Dlinuxfoundation.org@lists.openembedded.org> wrote:
> >> I've noted down a summary of my recent bitbake-setup testing notes:
> >>
> >>
> >> "bitbake-setup update" moves local.conf changes out the way. I think b=
y
> >> default there should be a warning about out of date conf files and a
> >> y/n to move. There should be a command line option not to do this as i=
t
> >> really isn't what most users expect/want. I do understand why it is
> >> doing it from an upgrade perspective.
> >>
> >>
> >> As Joshua mentions, we should just error for non-global settings that
> >> won't do anything.
> > A patch is sent for this
> >
> >>
> >> When we set a top level dl-dir, it should filter down into DL_DIR in
> >> the builds, we do want to share that.
> > Maybe. I want to set that in site.conf so it's the same for all my
> > builds (a centralized site.conf is actually a really nice feature of
> > this tool!). Perhaps a compromise is that the default site.conf has a
> > DL_DIR that points to the one used by bitbake-setup. I'd rather have
> > site.conf be the authority on DL_DIR and modify bitbake-setup to use
> > the same path though it's settings than have bitbake-setup the
> > authority on where DL_DIR is located.
> >
> > I'll send a patch for that
> >
> >>
> >> There is a related issue with sstate-dir (and maybe hashequiv DB?) not
> >> being shared between builds by default. We have an opportunity to fix
> >> this right now.
> >>
> >>
> >> The message:
> >> 'Bitbake-setup is using /XXX/bitbake-builds as top directory ("bitbake=
-setup settings --help" shows how to change it)"'
> >> is misleading. If you run that, if doesn't tell me. I need to run
> >> bitbake-setup settings list and know which one to change.
> >>
> >>
> >> I'm starting to wonder if there should a "--quickstart-help" which
> >> lists a set of examplecommands to run like:
> >>
> >> bitbake-setup settings set --global default top-dir-name poky
> > Setting top-dir-name to "poky" wouldn't make any sense to me as a
> > configuration option; --setup-dir-name=3Dpoky is what I would expect
> > instead.
> >
> >> bitbake-setup settings set --global default dl-dir /media/build/source=
s/
> >> bitbake-setup init poky-master poky distro/poky machine/qemux86-64 --s=
etup-dir-name build
> > Ostensibly, you don't _need_ to run any of these unless you want to
> > change the settings. Just running `bitbake-setup init` is sufficient
> > if the defaults are OK (which, for most people, is probably fine?).
> > Other than the confusion about changing the top-dir, I really didn't
> > think this was that bad.
> >
> > bitbake-setup does prompt the user to continue if it looks like the
> > top-dir is new (e.g. doesn't contain a site.conf) which gives them an
> > option to say 'no' and change it. Perhaps instead that prompt should
> > provide guidance on how to change the top directory name at that
> > point. I'll send a patch for that
> >
> >> The reasoning being to give people an idea of needing to set some
> >> global values for thing like dl-dir.
> > See above.
> >
> >>
> >> When I run init, the I should be able to edit the default build
> >> directory name more easily. "poky-master-poky-distro_poky-
> >> machine_qemux86-64" is a little nonsensical in that I can change DISTR=
O
> >> and MACHINE in a build without changing the build directory. Could we
> >> simplify the default? Should we give the user a hint about how to
> >> change the MACHINE/DISTRO? I think we do want to be able to encourage
> >> users to switch some settings in their builds.
> >>
> >>
> >> For settings, is there anything other than the default section? Should
> >> we perhaps default to default to simplify the commands?
> > I'm personally OK with the way it is. It matches the git config model
> > where git has sections and variables under those sections (although
> > git uses '.' as the separator, e.g. 'user.email'). I understood
> > 'default' to mean the values that will be chosen if I don't say
> > otherwise, so I didn't find this confusing or cumbersome. I actually
> > think making "default" the default will be more confusing as to why
> > some variables need a section and some don't (assuming we add more
> > sections in the future).
> >
> > TL; DR - I'd just leave this as is, I don't think it's confusing.
>
> Along with the "global" flag, personally I find it pretty confusing.
> Consider
>
> $ bitbake-setup settings set default foo bar
> $ bitbake-setup settings set --global default foo baz
> $ bitbake-setup settings list
> ...
> default foo bar
> $ bitbake-setup settings unset default foo
> $ bitbake-setup settings list
> ...
> default foo baz
> #... but both were "default"..
>
> For me, "global" and "default" have the same meaning in this context (or
> at least I would expect them to be the same)
>
> Personally I would either remove the "default" section, or I would
> remove the "global" flag, and make "default" actually default, globally.

I think the problem isn't the way it's being done, it's that the word
"default" is not clearly communicating the purpose, or being
misunderstood. If "default" where another work, say "foo" (since I
don't want to suggest a new name), than this settings config would
operate exactly like `git config`, where there is a "global" config
that applies to all invocations of bitbake-setup, and a per-repo (or
in this case, per-top-dir) config that only applies to projects that
share a top-dir. Git also separates configs into "sections", it just
uses "." instead (e.g. "user.name")

I would highly recommend keeping this model; having global vs.
per-top-level config is really useful for user configuration purposes,
and using sections will allow future tooling to more easily integrate
into bitbake-setup by allowing their config options to use dedicated
sections.

I think the "default" name of the section is perhaps the hang up here,
but I also think the name does accurately describe what the settings
are, so I don't really have a better name.

>
> (Or maybe I need further clarification about this...)
>
>
> >>
> >> We also don't have a good way of mimicking something more similar to
> >> the older poky layout with bitbake-setup. The autobuilder is the
> >> closest on that but with some horrible commands, I think we might want
> >> to find a way to allow that more easily/obviously.
> >>
> >>
> >>
> >> Any one of these issues in isolation isn't a blocker but together, the=
y
> >> all make the experience a bit jarring and not what people are used to
> >> from us. We get one chance at users of the tool, I think this will
> >> break it.
> >>
> >> I do probably have more thoughts, I'll try and keep more notes as I go
> >> and find things. I'm sorry not to have come to some of this earlier :/=
.
> >>
> >> Cheers,
> >>
> >> Richard
> >>
> >>
> >>
> >>
> >>
> >>
> >>
> >> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> >> Links: You receive all messages sent to this group.
> >> View/Reply Online (#18334): https://lists.openembedded.org/g/bitbake-d=
evel/message/18334
> >> Mute This Topic: https://lists.openembedded.org/mt/116239397/6084445
> >> Group Owner: bitbake-devel+owner@lists.openembedded.org
> >> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [ska=
ndigraun@gmail.com]
> >> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> >>
>

