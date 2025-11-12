Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEABCCFA1A
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 15:32:50 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.36.1762961563104357328
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Nov 2025 07:32:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=dZNtUDlU;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4777707a7c2so7780695e9.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 12 Nov 2025 07:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1762961561; x=1763566361; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9I/xRTubf2tQQR4ZJU/GaEUjWYECHu38G9u9Lwu0rx4=;
        b=dZNtUDlUeYOulGrUWEChdiQs9Fg7j/Ld5pbrhyRPPdKsPngxtyZBRWUi8+ugW19DD5
         +clMz2h+LaX9sM4DXxVQIK4HDSYy8TzXIOwcKxYGSyQrssB6FmAWIRqUXtZOIBrs5/h0
         rijvRUFgjFb+J+pPFlkCuBj7riQBIY888Pw7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762961561; x=1763566361;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9I/xRTubf2tQQR4ZJU/GaEUjWYECHu38G9u9Lwu0rx4=;
        b=YryEE43RxfxqDqUiUCMOjHOFrptoWIVTf5M+aDf+TNsuronpHqhy9O+wlUkU1iYaZL
         KH6zM0sROpTeVxQ1Dxg9Wt+dXhazXuadAsQboifwThKd/+UFF1C8eJZH1G+wT4yqEmu6
         A8TkINNC3BIqPab97RjAozwDHFhUEm2HE/KpwU3DQgI+QAeExx7ivRiXhASd6NuMEOym
         3T0FeXKKllRUVl+Zm7Ubs2KijEZ2aGcZUI1ighnZUxq0mr7bFW6PKbP3i251bOFWMSYg
         7OsBHJVCKNAdvYMvrRFkOf+MONYURJ0GOego19nVL8kZi3GKqFak9Y0RDNDDIpz631t0
         71uw==
X-Gm-Message-State: AOJu0Ywj+XmNb1XiqgT9XGgZPXyI1gg5+G5fL2ydjoS8c/BxhuGFXXXT
	bLg8C1pDN++X/ODtKTRN144VJ7jSqnqVHZM1FpiZlCG+oFjtJzDNKKIzPfO1hYa7Ivg=
X-Gm-Gg: ASbGncuSmZcUyh7K4IRl6Uwr270jlwGze+yzFTpIBpmJTtp1hCPQhp0/qJjyUsBdiWs
	FZ3YBVJ/hQTapIA75xctKkMHNcf1ptGTAfgaJSkzsr9cuo4E24rP49eXXVjPE+I+6cI/bEjFvJW
	9ybGwcV4sCbeq5j166DVKyIWzSgw7DL3B7OPQw3IhCuUMpXHdxC6Ryqwvxvqn5mecu4d3O+O6ZM
	whZtvU+E3W+Xo06FKXcW3S8T0uSqNNRgE9/nnK+pLaNeLGjS6ev61DU7gJALZDoEKIvbSAoON52
	t0eBp8VE6/UUd1Wg/8bCLXoXEgHXeKa800laE1y9dhlk/kRhAPOk4z10ipi0p2R0WzrugI/fTCm
	No5t6thFFb7GRAgpRiN9iF8SVXSC1AxHI2eH2HIiIHx0mhs8ryQ1pfNJu2Xt8fZ0OBQpDqep4Cv
	X9B3sJ4eLCrYSck/1YaaAMoco3rcHxei2bVJvw5ZKHGkSNs/hnAfkVn6eA4DXvDLmR
X-Google-Smtp-Source: AGHT+IFLWq362ul07jfJJk7TkBX4kiQe7kdQdeicATmkvD8g1dZqq5DQ1LwMDE26P6rOQBRjJBwuxg==
X-Received: by 2002:a05:6000:2006:b0:427:374:d91e with SMTP id ffacd0b85a97d-42b4b83c86dmr3918672f8f.11.1762961561192;
        Wed, 12 Nov 2025 07:32:41 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:8876:d08f:2a0c:d6ff? ([2001:8b0:aba:5f3c:8876:d08f:2a0c:d6ff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe63b7d7sm35563977f8f.11.2025.11.12.07.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 07:32:40 -0800 (PST)
Message-ID: <4442a7b1de5edff6b0915ee77783449b59686811.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] My bitbake-setup testing notes so far
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Watt <jpewhacker@gmail.com>, Gyorgy Sarvari
 <skandigraun@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 12 Nov 2025 15:32:39 +0000
In-Reply-To: <CAJdd5GYzS9Jno=w=mooVLXysnGfHWsNOQUjwpq6hUyik-cSNaA@mail.gmail.com>
References: 
	<a94dfade878b881bbd8c0524a99675983b8b20da.camel@linuxfoundation.org>
	 <CAJdd5GYNB-s6FiaZDGBSf1DmFHo0cxiyG-uuvYqcGHJyynAiMQ@mail.gmail.com>
	 <2460b48d-e465-4f00-bfb8-b7b88111a90d@gmail.com>
	 <CAJdd5GYzS9Jno=w=mooVLXysnGfHWsNOQUjwpq6hUyik-cSNaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Nov 2025 15:32:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18354

On Wed, 2025-11-12 at 08:28 -0700, Joshua Watt wrote:
> On Wed, Nov 12, 2025 at 12:46=E2=80=AFAM Gyorgy Sarvari <skandigraun@gmai=
l.com> wrote:
> >=20
> > On 11/11/25 21:11, Joshua Watt via lists.openembedded.org wrote:
> > > On Tue, Nov 11, 2025 at 8:17=E2=80=AFAM Richard Purdie via
> > > lists.openembedded.org
> > > <richard.purdie=3Dlinuxfoundation.org@lists.openembedded.org> wrote:
> > > > I've noted down a summary of my recent bitbake-setup testing notes:
> > > >=20
> > > >=20
> > > > "bitbake-setup update" moves local.conf changes out the way. I thin=
k by
> > > > default there should be a warning about out of date conf files and =
a
> > > > y/n to move. There should be a command line option not to do this a=
s it
> > > > really isn't what most users expect/want. I do understand why it is
> > > > doing it from an upgrade perspective.
> > > >=20
> > > >=20
> > > > As Joshua mentions, we should just error for non-global settings th=
at
> > > > won't do anything.
> > > A patch is sent for this
> > >=20
> > > >=20
> > > > When we set a top level dl-dir, it should filter down into DL_DIR i=
n
> > > > the builds, we do want to share that.
> > > Maybe. I want to set that in site.conf so it's the same for all my
> > > builds (a centralized site.conf is actually a really nice feature of
> > > this tool!). Perhaps a compromise is that the default site.conf has a
> > > DL_DIR that points to the one used by bitbake-setup. I'd rather have
> > > site.conf be the authority on DL_DIR and modify bitbake-setup to use
> > > the same path though it's settings than have bitbake-setup the
> > > authority on where DL_DIR is located.
> > >=20
> > > I'll send a patch for that
> > >=20
> > > >=20
> > > > There is a related issue with sstate-dir (and maybe hashequiv DB?) =
not
> > > > being shared between builds by default. We have an opportunity to f=
ix
> > > > this right now.
> > > >=20
> > > >=20
> > > > The message:
> > > > 'Bitbake-setup is using /XXX/bitbake-builds as top directory ("bitb=
ake-setup settings --help" shows how to change it)"'
> > > > is misleading. If you run that, if doesn't tell me. I need to run
> > > > bitbake-setup settings list and know which one to change.
> > > >=20
> > > >=20
> > > > I'm starting to wonder if there should a "--quickstart-help" which
> > > > lists a set of examplecommands to run like:
> > > >=20
> > > > bitbake-setup settings set --global default top-dir-name poky
> > > Setting top-dir-name to "poky" wouldn't make any sense to me as a
> > > configuration option; --setup-dir-name=3Dpoky is what I would expect
> > > instead.
> > >=20
> > > > bitbake-setup settings set --global default dl-dir /media/build/sou=
rces/
> > > > bitbake-setup init poky-master poky distro/poky machine/qemux86-64 =
--setup-dir-name build
> > > Ostensibly, you don't _need_ to run any of these unless you want to
> > > change the settings. Just running `bitbake-setup init` is sufficient
> > > if the defaults are OK (which, for most people, is probably fine?).
> > > Other than the confusion about changing the top-dir, I really didn't
> > > think this was that bad.
> > >=20
> > > bitbake-setup does prompt the user to continue if it looks like the
> > > top-dir is new (e.g. doesn't contain a site.conf) which gives them an
> > > option to say 'no' and change it. Perhaps instead that prompt should
> > > provide guidance on how to change the top directory name at that
> > > point. I'll send a patch for that
> > >=20
> > > > The reasoning being to give people an idea of needing to set some
> > > > global values for thing like dl-dir.
> > > See above.
> > >=20
> > > >=20
> > > > When I run init, the I should be able to edit the default build
> > > > directory name more easily. "poky-master-poky-distro_poky-
> > > > machine_qemux86-64" is a little nonsensical in that I can change DI=
STRO
> > > > and MACHINE in a build without changing the build directory. Could =
we
> > > > simplify the default? Should we give the user a hint about how to
> > > > change the MACHINE/DISTRO? I think we do want to be able to encoura=
ge
> > > > users to switch some settings in their builds.
> > > >=20
> > > >=20
> > > > For settings, is there anything other than the default section? Sho=
uld
> > > > we perhaps default to default to simplify the commands?
> > > I'm personally OK with the way it is. It matches the git config model
> > > where git has sections and variables under those sections (although
> > > git uses '.' as the separator, e.g. 'user.email'). I understood
> > > 'default' to mean the values that will be chosen if I don't say
> > > otherwise, so I didn't find this confusing or cumbersome. I actually
> > > think making "default" the default will be more confusing as to why
> > > some variables need a section and some don't (assuming we add more
> > > sections in the future).
> > >=20
> > > TL; DR - I'd just leave this as is, I don't think it's confusing.
> >=20
> > Along with the "global" flag, personally I find it pretty confusing.
> > Consider
> >=20
> > $ bitbake-setup settings set default foo bar
> > $ bitbake-setup settings set --global default foo baz
> > $ bitbake-setup settings list
> > ...
> > default foo bar
> > $ bitbake-setup settings unset default foo
> > $ bitbake-setup settings list
> > ...
> > default foo baz
> > #... but both were "default"..
> >=20
> > For me, "global" and "default" have the same meaning in this context (o=
r
> > at least I would expect them to be the same)
> >=20
> > Personally I would either remove the "default" section, or I would
> > remove the "global" flag, and make "default" actually default, globally=
.
>=20
> I think the problem isn't the way it's being done, it's that the word
> "default" is not clearly communicating the purpose, or being
> misunderstood. If "default" where another work, say "foo" (since I
> don't want to suggest a new name), than this settings config would
> operate exactly like `git config`, where there is a "global" config
> that applies to all invocations of bitbake-setup, and a per-repo (or
> in this case, per-top-dir) config that only applies to projects that
> share a top-dir. Git also separates configs into "sections", it just
> uses "." instead (e.g. "user.name")
>=20
> I would highly recommend keeping this model; having global vs.
> per-top-level config is really useful for user configuration purposes,
> and using sections will allow future tooling to more easily integrate
> into bitbake-setup by allowing their config options to use dedicated
> sections.
>=20
> I think the "default" name of the section is perhaps the hang up here,
> but I also think the name does accurately describe what the settings
> are, so I don't really have a better name.

We modelled this on git config and in git's context, "default" actually
maps to the different section names like 'user' or 'url' or 'pull'.

I'm all in favour of the different levels of config, global and local.
I think the section naming is something different to that.

Cheers,

Richard

