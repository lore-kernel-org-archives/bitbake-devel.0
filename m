Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF31C5B555
	for <webhook@archiver.kernel.org>; Mon,  2 Jun 2025 21:04:48 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web10.6497.1748898284245725416
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 02 Jun 2025 14:04:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=cMu6Py4S;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a375888197so2481004f8f.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 02 Jun 2025 14:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1748898283; x=1749503083; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gAGb3NJbbrbGEoa0Rk4JSSKtFtGoB87cvTqzqf1GDuY=;
        b=cMu6Py4SWw1P65SfSPHFRRVCRHSaSROsbcA+Qx2aBtNzWZMVj0hTxHpLu7uJVC9Vxd
         oj6ciT63IZ2C8nYLLOY8tWOsKq8S8jsBtNdqHVcMBl4ugI55flIbBPZObHgfeTC8Ga/f
         qmUJkN7mZwpLZAdWubNyOLS537De+6kv/mzNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748898283; x=1749503083;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gAGb3NJbbrbGEoa0Rk4JSSKtFtGoB87cvTqzqf1GDuY=;
        b=E1OsnQLpP5tZuw79GvcZqED5lX5cnDouSgYG4WU/uQaLOnqykJ2knTH4sjJfQix3CH
         i1XhFC5aKUlRyy5Gw9K3lBn5ZzD/jEG4cH6lRARFFN4mO4xdJ2evqLqVZ6rOo1SAPAJE
         6jX70eLrZjK5YQVF1FxJW9f6PzUOMoc04qz2MqAmZ731AwKcC9wVhfr0J3cr3HYK9RIu
         8+knn3U6U7tW6ETjk4B5DLN/NKic5cZ4eIWemRMvYPuRcxf1qQe3LcvsnV0zWTQvE0wS
         kLIkmqPEJEgE8NI2+uWOo7fY+O6/SpG9QWY2aUd+67JN62yhXX/yVxFcT0mslANzm05c
         ZCJg==
X-Forwarded-Encrypted: i=1; AJvYcCXmMZkOpQD7xIRtE3PvGV4Re4hamyETpqzJbGg5HVYSEwzGvXEs1zoTmlwMxbcp7b1yw1OjFP/AN8vqiBGt@lists.openembedded.org
X-Gm-Message-State: AOJu0YxcZDfbmaNu/XZQb81h6TRd5Us8K6/l90GFPnTSp70k7/xp8UJj
	BQPshi3SRr3c+h5bmKoq9U2d5MKa1VauJk1rj9RFdkgCr2yMjCflUV/jUVm1L938ft85AoWoUCh
	6La60xi0=
X-Gm-Gg: ASbGnctUq3vyZh0UuoGlkPT8jftl0wdDpzaAMTnYcZc5kiYXT2QVEsj9HJ7T3kyEL6j
	oIVMcgGAfbN/dcTbKwOVnFNp47tevd1umSfUgqJqryPfzfpVbhSo9+sR7rFRTc6zdlDt4ZL2MiZ
	yrotDo1YAR/TrCnq/cE0Ky0ZFZZHRzu53ChnZwI62B0k6W4AjsZDtSVDBTd8Tq7nEj8pIDC+eX6
	3PtjcQSJBSQ3tgDsN3YydgrReUy7mw4hpfKti5tooboNjWYQpgivcLa7hB2kZt6gFzzXJaEN1lE
	73eQby3Dg99AP/gi2jXReDepqmmwZNnZQLGzlmRSZRIukSBd8iEZFQ3XWBk7H6bFYW8mwwJv0zz
	/pepfQNNuPepMKSzEeBIE7m3FzzDnkvimM8CV7QNv
X-Google-Smtp-Source: AGHT+IE61w5dlvOsyjKoZySMnrs/Una3LfKslX5D2/D7qB2O83CznvRv6fzgFsNA0g/aespjbyaqEg==
X-Received: by 2002:a05:6000:2905:b0:3a4:f900:21c4 with SMTP id ffacd0b85a97d-3a4fe1874bemr7129007f8f.26.1748898282459;
        Mon, 02 Jun 2025 14:04:42 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:f190:efe6:7bd4:a92a? ([2001:8b0:aba:5f3c:f190:efe6:7bd4:a92a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d8006c21sm133605385e9.33.2025.06.02.14.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 14:04:41 -0700 (PDT)
Message-ID: <a9296bd359abc522a135cbaa37995d5b5633046e.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Should stamp files for different versions of a
 recipe exist at the same time?
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Mike Crowe <mac@mcrowe.com>, bitbake-devel@lists.openembedded.org
Date: Mon, 02 Jun 2025 22:04:39 +0100
In-Reply-To: <aD3TP6hIE9vvFaAo@mcrowe.com>
References: <aDnoNJFkC535qqiI@mcrowe.com>
	 <18dd4e56-87a5-4de3-a148-bd42f67ba57a@cherry.de>
	 <aD2ByO73juj7zy7I@mcrowe.com>
	 <418eea7bdcd9b528623498a6139ae42389ef192d.camel@linuxfoundation.org>
	 <aD3TP6hIE9vvFaAo@mcrowe.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 02 Jun 2025 21:04:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17675

On Mon, 2025-06-02 at 17:37 +0100, Mike Crowe wrote:
> On Monday 02 June 2025 at 15:17:44 +0100, Richard Purdie wrote:
> > On Mon, 2025-06-02 at 11:49 +0100, Mike Crowe via lists.openembedded.or=
g wrote:
> > > On Monday 02 June 2025 at 12:15:57 +0200, Quentin Schulz wrote:
> > > > Hi Mike,
> > > >=20
> > > > On 5/30/25 7:17 PM, Mike Crowe via lists.openembedded.org wrote:
> > > > > I seem to be running into a problem in Scarthgap that relates to =
outdated
> > > > > stamp files not being removed. I think this results in tasks not =
running
> > > > > when they should in later builds. I don't believe that this probl=
em happens
> > > > > with Dunfell[1], though it does still happen with current master =
(both
> > > > > Bitbake and openembedded-core) too[2].
> > > > >=20
> > > > > In case my description below isn't clear, the files required are =
available
> > > > > in
> > > > > https://github.com/mikecrowe/openembedded-core/tree/stamps-not-re=
moved-repro
> > > > > though
> > > > > https://github.com/mikecrowe/openembedded-core/commit/8fd8055ab3e=
1d2d429c6076481952bace251750c
> > > > > is probably the most interesting to look at.
> > > > >=20
> > > > > My reproduction requires a package to have two different recipes =
with
> > > > > different COMPATIBLE_MACHINEs and swapping between building for t=
hose two
> > > > > different MACHINEs. I'm using dummy recipes called lictest_one.bb=
 and
> > > > > lictest_two.bb because I'm able to reproduce this problem with li=
cence
> > > > > files, though I suspect that it is not limited to them. I have tw=
o machines
> > > > > named qemuarm64 and qemuarm64b.
> > > > >=20
> > > > > # PREPARATION
> > > > >=20
> > > > > I first start by running the cleansstate task for the recipe for =
both
> > > > > MACHINEs in order to ensure we're starting from a sensible state:
> > > > >=20
> > > > > =C2=A0 MACHINE=3Dqemuarm64 bitbake -c cleansstate lictest
> > > > > =C2=A0 MACHINE=3Dqemuarm64b bitbake -c cleansstate lictest
> > > > >=20
> > > > > # FIRST MACHINE BUILD 1
> > > > >=20
> > > > > I build for the first machine:
> > > > >=20
> > > > > =C2=A0 MACHINE=3Dqemuarm64 bitbake core-image-minimal
> > > > >=20
> > > > > At this point tmp-glibc/deploy/licenses/cortexa57/lictest contain=
s the
> > > > > licence files and tmp-glibc/stamps/cortexa57-oe-linux/lictest/ co=
ntains
> > > >=20
> > > > Intuitively I would say that your recipes also need to have PACKAGE=
_ARCH =3D
> > > > "${MACHINE_ARCH}" set and then this wouldn't be an issue at all I b=
elieve
> > > > (because different directories for each recipe). I'm not entirely s=
ure what
> > > > is the recommendation for when to start using PACKAGE_ARCH =3D
> > > > "${MACHINE_ARCH}", like what's the thing that should trigger this a=
ddition
> > > > in the recipe?
> > >=20
> > > Hi Quentin,
> > >=20
> > > Thanks. I had been holding that back as a somewhat-hacky solution to =
the
> > > problem. It would reduce the amount setscene tasks running when switc=
hing
> > > though.
> > >=20
> > > In reality the situation is more complex than the one I described abo=
ve. We
> > > actually have multiple machines and two sets of recipes. Some machine=
s use
> > > one set of recipes and some use the other set. Using PACKAGE_ARCH =3D
> > > "${MACHINE_ARCH}" might work, but it would result in more builds than
> > > necessary. I had considered changing setting PACKAGE_ARCH =3D
> > > "${TUNE_PKGARCH}-suffix" or PACKAGE_ARCH:append =3D "-suffix" or simi=
lar
> > > would work, but I haven't tested that.
> > >=20
> > > It's also not been clear to me where the divide between PACKAGE_ARCH =
=3D
> > > "${TUNE_PKGARCH}" and PACKAGE_ARCH =3D "${MACHINE_ARCH}" is. There ar=
e lots
> > > of ways (e.g. setting PACKAGECONFIG:pn-package) that could cause a
> > > PACKAGE_ARCH =3D "${TUNE_PKGARCH}"-specific recipe to vary between MA=
CHINEs.
> > >=20
> > > > I'm also not saying that this isn't a bug or a bigger issue, even i=
f my
> > > > suggestion may work around the issue.
> > >=20
> > > Thanks for the suggestion. If Dunfell had behaved as Scarthgap or mas=
ter
> > > currently do then we probably would have just considered that to be t=
he
> > > expected behaviour.
> >=20
> > I have a feeling there were some changes in this area to fix bugs but
> > I'm not remembering specifics. It sounds like some issue could have
> > crept in.
> >=20
> > What you're supposed to be able to do is define your own package
> > architectures so that you could have two here, one for each of your
> > configs. You could then switch between them and the appropriate
> > packages would be used.
>=20
> The trouble with this is it requires everything that depends on these
> packages to also use those package architectures otherwise the problem ju=
st
> moves up a level. Recipes changing for the same PACKAGE_ARCH is also not
> very discoverable in the general case (though in this one it is quite
> obvious).

You've changed the configuration for them so it is only right they
should have a different PACKAGE_ARCH. This kind of thing does ripple
badly but that is the implication of a change like this.

Let me explain this slightly differently. We once decided that it was
ok to change MACHINE and build in the same TMPDIR (multimachine
support). It was decided that changing DISTRO still meant a new TMPDIR
though. The implication of this is that if you change the
configuration/policy of a package (which is effectively distro policy),
it should be in a different TMPDIR.

Over time, our error correction handling got better, to the point that
if you don't change TMPDIR but change DISTRO, it does mostly work. The
key bit is mostly. Ideally we'd catch all cases and we don't do badly
but it sounds like we're missing something here.

The way to officially handle what you describe is through PACKAGE_ARCH,
even if that is a bit painful (or separate TMPDIR).

> > As it stands, you're relying on the sstate code to swap things out,
> > which is meant to be a fallback, not a default way of operating. Far
> > too many people rely on that doing the right thing now though.
>=20
> Our situation is actually even worse than I described above. One set of
> machines has multilib enabled and one doesn't, yet they share a
> TUNE_PKGARCH so the sstate shuffling happens for every package! Given you=
r
> response it sounds like we should stop doing this.
>=20
> How would you recommend defining our own package architecture in this cas=
e?
>=20
> 1. TUNE_PKGARCH:append =3D "-oursuffix"? (Which would also affect
> =C2=A0=C2=A0 SSTATE_ARCHS_TUNEPKG.)

You want sstate arch to be different so this is probably fine.

> 2. Set the default PACKAGE_ARCH ?=3D "${TUNE_PKGARCH}-oursuffix" overridi=
ng
> =C2=A0=C2=A0 the ??=3D default in bitbake.conf unless someone else overri=
des it?

That would change all recipes and you should only change the recipes
affected and their dependencies.

If it is all recipes, you want a separate TMPDIR and it is really a
different distro (or sub-distro).

> 3. Something else?
>=20
> (I had a look through the docs but couldn't find any advice and the
> multilib examples don't appear to do this.)

FWIW multilib changes PACKAGE_ARCH.

> > So I'd say there is probably a bug somewhere here but you're also not
> > using the system quite as intended.
>=20
> > Thanks for a test case btw, that really helps. I will try and take a
> > look if I can find time but that is hard atm :/.
>=20
> In my original message I wrote:
> > > > My guess is that the problem here is that the stamps from the first
> > > > machine build weren't removed during the "SECOND MACHINE BUILD 1" s=
tep
> > > > above. If I remove them myself then the problem goes away. Is that
> > > > theory correct? If so, then I can start trying to work out why and =
any
> > > > advice would be welcome. If that theory is not correct then does an=
yone
> > > > have any idea where I should start investigating?
>=20
> I was hoping that someone would just know the answer to my first question
> above off the top of their head. If so then I'm willing to try digging in=
to
> this myself to see what I can discover. I just need to make sure that I'm
> chasing the right part of the problem.

I've avoided answering this as I think you're right but I'm not 100%
sure and I don't want to send you off in the wrong direction. There are
reasons it might not wipe out stamps and those reasons may be
intentional but without looking at what is going on I couldn't be
completely sure. So I think you're right and I'd chase that way but...

Cheers,

Richard


