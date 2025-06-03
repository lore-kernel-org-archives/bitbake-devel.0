Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2750AC5AE59
	for <webhook@archiver.kernel.org>; Tue,  3 Jun 2025 10:18:18 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web11.7877.1748945890518464163
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 03 Jun 2025 03:18:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=IH0MABr+;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so20979875e9.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 03 Jun 2025 03:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1748945888; x=1749550688; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0W9ibNOMQsZZDFQxA9tmq8hcOrRwqtgf+3h9cis0Nok=;
        b=IH0MABr+cTHDQ6VHrfM6MtP6np109SfIdp5glAghSjBliKSw94A53uaMvt6Ra9Aonp
         tD/PmrkG8AHN364eV8gb2d9T9PLtcfWx8ykJyIIvntNMPml3+9cKOxNfflqKxz8Qejel
         8TmH8+0aQhdrtij4m3KIPvK/DdIJ2B7kawpKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748945888; x=1749550688;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0W9ibNOMQsZZDFQxA9tmq8hcOrRwqtgf+3h9cis0Nok=;
        b=xQn+AHJVNC2MuUxI5OaEsG6NvF7/Zkm9X3kDpeS9CMMx5yTMWkRGCdmhnwW0CzKA3u
         vChVRlb98NX0k6LoP3k9fXe0d0tcwpWc4OIHvla7CNkokyklLuo2JqYC66jGVzyjtYNM
         Wb9II1mhZtQf0Uou55XwGlh04SeLyddZ/iIxlsgDXMis9zpFC+CWYp4uzndNSCf2zq1I
         iw6oMq1lIVIhypuLWOcXLnKa27FFFEfeW8p3jF16FkvhPo9iUQnNUqSanwjJZjQuE6Tg
         Ht3VHXwPTmR8FhcnOJmkxeUGYhVn9QAfPF69ZwLUvceSPWpVTPfxdBYd/nIL+MpA0GnN
         o0PA==
X-Forwarded-Encrypted: i=1; AJvYcCUxFyAQqA7hpsz9BdkfwUySH5fgkq78oyQRRLJYzq1STj5EL+wkXUIws+9CEfqaOaxcwUR0PjJ31gaHxj9O@lists.openembedded.org
X-Gm-Message-State: AOJu0Yx3b1sefgDkXzVFVwnbeP3ca0zXGooH8uYpD5yE7W+1UdvaYyah
	vv70uUHQJNeAk9tqUOGeqz4NFlaVxYCScSOnI39rvpER+xsJfEGeL3nN/helSbQhL1PjJcGBEo9
	4KCfTE2g=
X-Gm-Gg: ASbGnctYjlsQcIslzEPcIJWo5D4cxiAUiTAbVMRbMcVx8FPECGEYTuK26+jC4yP3LDQ
	qwDXoHEtlWO2cof2DFXWwo4KJG7xpt5pazVfLNyLtNoDlFqoEbJY3C7mV1G7OhASATP6P5NfbQi
	lwujXMfyKpC6gN3wovz8EkyZ6fdU+vROPe8DmM3y6R48E9ZzTQFGzEJkQMiZ50q+n94cSJpnKws
	u8FLBM11c3gyKULrjzUzyGwQjgAMomyJjWsPOAMwZHVdd3RVfURpouiGZcQbRhWR8vnCUvh3+we
	WWxkVO/cgYllZpfQQ5ES9A1b3WlWyM1O3lYuY0wl/THtiNY8SCjL6ptlsrr/b42R6bUPkuKV300
	WnUsXVKNSo3gJRf+BYOEvkkv/+zlR7aI6XJodZaAL
X-Google-Smtp-Source: AGHT+IFsYYzBBUauWaTqYIkaaoa0Ed4/m3R41co5Xt5fXyhvs9QLX3CTL5CPsrQ5AGffXD2xkYrSug==
X-Received: by 2002:a05:6000:25ca:b0:3a4:df80:7284 with SMTP id ffacd0b85a97d-3a4f7a0234fmr13723976f8f.1.1748945888385;
        Tue, 03 Jun 2025 03:18:08 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:3864:8101:3606:8242? ([2001:8b0:aba:5f3c:3864:8101:3606:8242])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7f8ed27sm162487405e9.2.2025.06.03.03.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 03:18:07 -0700 (PDT)
Message-ID: <088d727e59e370375ea4695fe59c21d7b6e38b7a.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Should stamp files for different versions of a
 recipe exist at the same time?
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Mike Crowe <mac@mcrowe.com>, bitbake-devel@lists.openembedded.org
Date: Tue, 03 Jun 2025 11:18:06 +0100
In-Reply-To: <aD7JUkYhjqg70RAR@mcrowe.com>
References: <aDnoNJFkC535qqiI@mcrowe.com>
	 <18dd4e56-87a5-4de3-a148-bd42f67ba57a@cherry.de>
	 <aD2ByO73juj7zy7I@mcrowe.com>
	 <418eea7bdcd9b528623498a6139ae42389ef192d.camel@linuxfoundation.org>
	 <aD3TP6hIE9vvFaAo@mcrowe.com>
	 <a9296bd359abc522a135cbaa37995d5b5633046e.camel@linuxfoundation.org>
	 <aD7JUkYhjqg70RAR@mcrowe.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 03 Jun 2025 10:18:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17677

On Tue, 2025-06-03 at 11:07 +0100, Mike Crowe wrote:
> On Monday 02 June 2025 at 22:04:39 +0100, Richard Purdie wrote:
> > On Mon, 2025-06-02 at 17:37 +0100, Mike Crowe wrote:
> > > On Monday 02 June 2025 at 15:17:44 +0100, Richard Purdie wrote:
> > > > On Mon, 2025-06-02 at 11:49 +0100, Mike Crowe via lists.openembedde=
d.org wrote:
> > > > > On Monday 02 June 2025 at 12:15:57 +0200, Quentin Schulz wrote:
> > > > > > Hi Mike,
> > > > > >=20
> > > > > > On 5/30/25 7:17 PM, Mike Crowe via lists.openembedded.org wrote=
:
> > > > > > > I seem to be running into a problem in Scarthgap that relates=
 to outdated
> > > > > > > stamp files not being removed. I think this results in tasks =
not running
> > > > > > > when they should in later builds. I don't believe that this p=
roblem happens
> > > > > > > with Dunfell[1], though it does still happen with current mas=
ter (both
> > > > > > > Bitbake and openembedded-core) too[2].
> > > > > > >=20
> > > > > > > In case my description below isn't clear, the files required =
are available
> > > > > > > in
> > > > > > > https://github.com/mikecrowe/openembedded-core/tree/stamps-no=
t-removed-repro
> > > > > > > though
> > > > > > > https://github.com/mikecrowe/openembedded-core/commit/8fd8055=
ab3e1d2d429c6076481952bace251750c
> > > > > > > is probably the most interesting to look at.
> > > > > > >=20
> > > > > > > My reproduction requires a package to have two different reci=
pes with
> > > > > > > different COMPATIBLE_MACHINEs and swapping between building f=
or those two
> > > > > > > different MACHINEs. I'm using dummy recipes called lictest_on=
e.bb and
> > > > > > > lictest_two.bb because I'm able to reproduce this problem wit=
h licence
> > > > > > > files, though I suspect that it is not limited to them. I hav=
e two machines
> > > > > > > named qemuarm64 and qemuarm64b.
> > > > > > >=20
> > > > > > > # PREPARATION
> > > > > > >=20
> > > > > > > I first start by running the cleansstate task for the recipe =
for both
> > > > > > > MACHINEs in order to ensure we're starting from a sensible st=
ate:
> > > > > > >=20
> > > > > > > =C2=A0 MACHINE=3Dqemuarm64 bitbake -c cleansstate lictest
> > > > > > > =C2=A0 MACHINE=3Dqemuarm64b bitbake -c cleansstate lictest
> > > > > > >=20
> > > > > > > # FIRST MACHINE BUILD 1
> > > > > > >=20
> > > > > > > I build for the first machine:
> > > > > > >=20
> > > > > > > =C2=A0 MACHINE=3Dqemuarm64 bitbake core-image-minimal
> > > > > > >=20
> > > > > > > At this point tmp-glibc/deploy/licenses/cortexa57/lictest con=
tains the
> > > > > > > licence files and tmp-glibc/stamps/cortexa57-oe-linux/lictest=
/ contains
> > > > > >=20
> > > > > > Intuitively I would say that your recipes also need to have PAC=
KAGE_ARCH =3D
> > > > > > "${MACHINE_ARCH}" set and then this wouldn't be an issue at all=
 I believe
> > > > > > (because different directories for each recipe). I'm not entire=
ly sure what
> > > > > > is the recommendation for when to start using PACKAGE_ARCH =3D
> > > > > > "${MACHINE_ARCH}", like what's the thing that should trigger th=
is addition
> > > > > > in the recipe?
> > > > >=20
> > > > > Hi Quentin,
> > > > >=20
> > > > > Thanks. I had been holding that back as a somewhat-hacky solution=
 to the
> > > > > problem. It would reduce the amount setscene tasks running when s=
witching
> > > > > though.
> > > > >=20
> > > > > In reality the situation is more complex than the one I described=
 above. We
> > > > > actually have multiple machines and two sets of recipes. Some mac=
hines use
> > > > > one set of recipes and some use the other set. Using PACKAGE_ARCH=
 =3D
> > > > > "${MACHINE_ARCH}" might work, but it would result in more builds =
than
> > > > > necessary. I had considered changing setting PACKAGE_ARCH =3D
> > > > > "${TUNE_PKGARCH}-suffix" or PACKAGE_ARCH:append =3D "-suffix" or =
similar
> > > > > would work, but I haven't tested that.
> > > > >=20
> > > > > It's also not been clear to me where the divide between PACKAGE_A=
RCH =3D
> > > > > "${TUNE_PKGARCH}" and PACKAGE_ARCH =3D "${MACHINE_ARCH}" is. Ther=
e are lots
> > > > > of ways (e.g. setting PACKAGECONFIG:pn-package) that could cause =
a
> > > > > PACKAGE_ARCH =3D "${TUNE_PKGARCH}"-specific recipe to vary betwee=
n MACHINEs.
> > > > >=20
> > > > > > I'm also not saying that this isn't a bug or a bigger issue, ev=
en if my
> > > > > > suggestion may work around the issue.
> > > > >=20
> > > > > Thanks for the suggestion. If Dunfell had behaved as Scarthgap or=
 master
> > > > > currently do then we probably would have just considered that to =
be the
> > > > > expected behaviour.
> > > >=20
> > > > I have a feeling there were some changes in this area to fix bugs b=
ut
> > > > I'm not remembering specifics. It sounds like some issue could have
> > > > crept in.
> > > >=20
> > > > What you're supposed to be able to do is define your own package
> > > > architectures so that you could have two here, one for each of your
> > > > configs. You could then switch between them and the appropriate
> > > > packages would be used.
> > >=20
> > > The trouble with this is it requires everything that depends on these
> > > packages to also use those package architectures otherwise the proble=
m just
> > > moves up a level. Recipes changing for the same PACKAGE_ARCH is also =
not
> > > very discoverable in the general case (though in this one it is quite
> > > obvious).
> >=20
> > You've changed the configuration for them so it is only right they
> > should have a different PACKAGE_ARCH. This kind of thing does ripple
> > badly but that is the implication of a change like this.
>=20
> I agree. I just worry that if nothing breaks most of the time when we fai=
l
> to set the different PACKAGE_ARCH on a reverse dependency then we'll not
> notice the mistake. Maybe that doesn't matter until it breaks though?
>=20
> The recipes involved in our case are gstreamer ones, which are depended
> upon by many other random recipes in other layers. We _can_ add a .bbappe=
nd
> for each of them that we use, but there's always a risk that we'll not
> notice when someone adds a new dependency. Maybe we could come up with so=
me
> tooling to detect the situation?

We have tests in core for some of these kinds of scenarios, see the
sstate tests in meta/lib/oeqa/selftest/cases/sstatetests.py (run with
oe-selftest -r sstatetests -j X).

The basic idea is to run two "bitbake XXX -S none" commands on the
different configs and then analyse the stamps directories.

> > Let me explain this slightly differently. We once decided that it was
> > ok to change MACHINE and build in the same TMPDIR (multimachine
> > support). It was decided that changing DISTRO still meant a new TMPDIR
> > though. The implication of this is that if you change the
> > configuration/policy of a package (which is effectively distro policy),
> > it should be in a different TMPDIR.
> >=20
> > Over time, our error correction handling got better, to the point that
> > if you don't change TMPDIR but change DISTRO, it does mostly work. The
> > key bit is mostly. Ideally we'd catch all cases and we don't do badly
> > but it sounds like we're missing something here.
>=20
> At least in Dunfell, and probably for a while before that, I think that y=
ou
> did such a good job that my expectations had been that this worked.

We try to make it work but there are so many ways you could in theory
break it...

> > The way to officially handle what you describe is through PACKAGE_ARCH,
> > even if that is a bit painful (or separate TMPDIR).
> >=20
> > > > As it stands, you're relying on the sstate code to swap things out,
> > > > which is meant to be a fallback, not a default way of operating. Fa=
r
> > > > too many people rely on that doing the right thing now though.
> > >=20
> > > Our situation is actually even worse than I described above. One set =
of
> > > machines has multilib enabled and one doesn't, yet they share a
> > > TUNE_PKGARCH so the sstate shuffling happens for every package! Given=
 your
> > > response it sounds like we should stop doing this.
>=20
> I shouldn't have said 'every package' there. I should have said 'every
> package where PACKAGE_ARCH =3D "${TUNE_PKGARCH}"'. In particular
> ${MACHINE_ARCH}, native and allarch packages don't need shuffling.
>=20
> > > How would you recommend defining our own package architecture in this=
 case?
> > >=20
> > > 1. TUNE_PKGARCH:append =3D "-oursuffix"? (Which would also affect
> > > =C2=A0=C2=A0 SSTATE_ARCHS_TUNEPKG.)
> >=20
> > You want sstate arch to be different so this is probably fine.
>=20
> OK. I did run into some problems when I tried it. I think that option 2
> will probably be better anyway.
>=20
> > > 2. Set the default PACKAGE_ARCH ?=3D "${TUNE_PKGARCH}-oursuffix" over=
riding
> > > =C2=A0=C2=A0 the ??=3D default in bitbake.conf unless someone else ov=
errides it?
> >=20
> > That would change all recipes and you should only change the recipes
> > affected and their dependencies.
> >=20
> > If it is all recipes, you want a separate TMPDIR and it is really a
> > different distro (or sub-distro).

Personally, I think you want a separate TMPDIR for ease.

> All recipes that currently have PACKAGE_ARCH set to "${TUNE_PKGARCH}" are
> affected. Not allarch ones, not "${MACHINE_ARCH}" ones and, most
> importantly for saving time and space, not native ones, so using a
> separate TMPDIR would be less than ideal.

Remember that if you share SSTATE_DIR between the two builds (and
probably a hashequiv server), it will reuse all the pieces that match
between the builds. This therefore isn't as expensive as you'd think,
it should reuse everything you mention.

> > > 3. Something else?
> > >=20
> > > (I had a look through the docs but couldn't find any advice and the
> > > multilib examples don't appear to do this.)
> >=20
> > FWIW multilib changes PACKAGE_ARCH.
>=20
> I'm sorry but I realise now that I've been extremely unclear here. When I
> said multilib, I didn't mean that side of multilib that has the
> ${MLPREFIX}, I meant the side that doesn't. You'd think that enabling
> multilib wouldn't have an effect on the non-multilib recipes, but it does
> for aarch64 because doing so changes (at least) libdir. :(

Right, it is assumed that if you want multilib, you always enable it in
your distro and use it in your different configs on at least a per arch
basis. We haven't tried to make the task signatures match with and
without mutlilib turned on as that would be hard and not that useful in
reality.

> For the MACHINE that enables multilib, we have in our machine
> configuration:
>=20
> =C2=A0DEFAULTTUNE =3D "cortexa72-cortexa53-crypto"
> =C2=A0require conf/machine/include/tune-cortexa72-cortexa53.inc
> =C2=A0MULTILIBS =3D "multilib:lib32"
> =C2=A0DEFAULTTUNE:virtclass-multilib-lib32 =3D "armv7at-neon"
>=20
> tune-cortexa72-cortexa53.inc contains:
>=20
> =C2=A0BASE_LIB:tune-cortexa72-cortexa53-crypto=3D"lib64"
>=20
> which means that multilib.conf sets libdir based on that to "/usr/lib64".
>=20
> For the MACHINE that doesn't enable multilib, we have none of that so
> bitbake.conf just uses BASELIB to set libdir to "/usr/lib".

You could try changing that to match with /usr/lib64 but I don't know
if that would allow sstate object reuse or not. Probably not as it
isn't something we've chosen to invest time in.

> I'm not sure if this change is intentional, but it does mean that merely
> enabling multilib and not using it changes behaviour.
>=20
> For our use, we'd have been much happier with libdir always being
> "/usr/lib" but we unfortunately got baked into the default behaviour earl=
y
> on.

You could have chosen /usr/lib for the multlib. I get a lot of
complaints that we don't follow some of the other distro defaults which
is why multilib defaults to them as that was "new" at the time and we
could change them. OE has defaulted to /usr/lib since forever.

Cheers,

Richard

