Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB70C71151
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 15:21:02 +0000 (UTC)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
 by mx.groups.io with SMTP id smtpd.web10.13109.1749828053268260401
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 13 Jun 2025 08:20:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=RttVn0ab;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.167.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-553b584ac96so320806e87.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 13 Jun 2025 08:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1749828051; x=1750432851; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D5rKa8dVPIgbovqqK4FQwTVwdMEtuLAKYtlB1DvqwJU=;
        b=RttVn0abMegWvic3zHG++Wu7JL3h2efsJ7JucmhcGg07sXWn3kMuC0HmRKPxTXjIq1
         oD7mBRAV2GrEb/EoaDYtW3Q5E8FqQHr7bvW3ALXS0mrxIL8+LFdYp2sIWPp430QSXfRb
         Ukkc5SHmRitj4sj/44u9xjh9lJ/GoyXgLj/QA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749828051; x=1750432851;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D5rKa8dVPIgbovqqK4FQwTVwdMEtuLAKYtlB1DvqwJU=;
        b=XQz4BAI+T9h1HpDlUBn7PcCQZ7qFbSCw0ktu/CGQbyWf0EbKFzRO9XvJAIOu9aEYbE
         IBk9d4ATxXROg2LXA66A+2gQY4VR/i0pv1kSxvl0+XG6ICGMmUQc0vYdhU3tuk+BhNQE
         IiH1oVkMjOd97mBz++zAr38gS9V+WgHuQvJzuxrxEOo6+B/bN5rPkblefzH1fYA4WNEv
         Pr8i1dXOPdKmGTYOm5UpgGpp7LZQDXtGj6SPZVU0WoiAC6q3z8WlXMKGbzlw82KbbxCJ
         eVSOxjLAYuTXA0MiCNbpQp71lmiY36OpZwySW3aAVAdwzj2i7S3zfcdnUlfNbseICIb5
         Ne7Q==
X-Gm-Message-State: AOJu0YzQyT40Fxoy2VfyBSuEBUbbw8snAn3j+Z/dHRI0izd21qgTZPor
	sTSD2yWIYy1reWXh9jZqbTeC1oWE0J9R0YCPS4b/KACrXAgMXvBIvC+9Gy9QCKh66os=
X-Gm-Gg: ASbGncvcfh3D2eASrSWPiQokiGs+p/sOR6EtD+eQbstz1Uhctg14YzQLrimKt/tdE4b
	6YCACGwc1N/kKVxEf+vWmo/hAimRfP8/9T6ZL9SCApHVjWvawV21LsOPE9gyeZ1kFuWFGPmf5I6
	8+qcd8Okc8FTDq9o/X0O+/tilU+HDlqVdUpxIPg4QzSYjnL4SIJHrSSb+tc6RmiVVslURT+U110
	L2qu85KCu6OFCUtZYaMApTp6eKh2IV+g0yU89qrWCVkCMT6wX8D+jWAIHqAdqQ9xOnNbjJlCqbw
	b1ZSAXcXBVIW2ihBr6aUXIVBy7ZBWlw3RdEa5t7IVUSAF3D/aMUzQQ9GjRIY363j3JU1vDoOaqn
	vikCaTn3+cbx13rf2cA92527us0XNJ9FSn29I1JmwbnJm8XWn2UY=
X-Google-Smtp-Source: AGHT+IH1FHe4MVQy8XRTo+0rUX16TSX2BBnzqHmwBy8kuMm9e0hvjyOj1RQ4S1BGXAvaYYeqABLZXg==
X-Received: by 2002:a05:6512:3b9e:b0:553:a3b2:efea with SMTP id 2adb3069b0e04-553af990800mr1076075e87.36.1749828051174;
        Fri, 13 Jun 2025 08:20:51 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:3ba4:44fa:9d9b:3977? ([2001:8b0:aba:5f3c:3ba4:44fa:9d9b:3977])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac1cb073sm476739e87.170.2025.06.13.08.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 08:20:49 -0700 (PDT)
Message-ID: <2de0572b0f92ac2c0d0d065c488ce501d43afe2a.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Should stamp files for different versions of a
 recipe exist at the same time?
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: mac@mcrowe.com
Cc: bitbake-devel@lists.openembedded.org
Date: Fri, 13 Jun 2025 16:20:46 +0100
In-Reply-To: <aErlJVHB8_AbsYqH@mcrowe.com>
References: <aDnoNJFkC535qqiI@mcrowe.com>
	 <18dd4e56-87a5-4de3-a148-bd42f67ba57a@cherry.de>
	 <aD2ByO73juj7zy7I@mcrowe.com>
	 <418eea7bdcd9b528623498a6139ae42389ef192d.camel@linuxfoundation.org>
	 <aD3TP6hIE9vvFaAo@mcrowe.com>
	 <a9296bd359abc522a135cbaa37995d5b5633046e.camel@linuxfoundation.org>
	 <aEXier1YxgCzOv1F@mcrowe.com>
	 <518ee0f0eef4e155c93ccba344a5ea1e6102b37b.camel@linuxfoundation.org>
	 <1847671617FAC7D3.17668@lists.openembedded.org>
	 <aErlJVHB8_AbsYqH@mcrowe.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 13 Jun 2025 15:21:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17701

On Thu, 2025-06-12 at 15:33 +0100, Mike Crowe via lists.openembedded.org wr=
ote:
> [
> =C2=A0Snip explanation of problems with recipes that have the same PACKAG=
E_ARCH
> =C2=A0but different task hashes. My understanding of Richard's view was t=
hat
> =C2=A0although doing this may have worked in the past, it is to be avoide=
d. I
> =C2=A0wrote a script to detect tasks with the same PACKAGE_ARCH and diffe=
ring
> =C2=A0hashes.
> ]
>=20
> On Monday 09 June 2025 at 15:45:21 +0100, Mike Crowe via lists.openembedd=
ed.org wrote:
> > Instead I hacked together a Python script that reads the locked-sigs.in=
c
> > files, that are already conveniently arranged by PACKAGE_ARCH. It seems=
 to
> > detect problematic recipes for me. At the very least it might help work=
 out
> > whether this problem is common enough that more work would be worthwhil=
e.
>=20
> Hi Richard,
>=20
> Unfortunately this script revealed that there are various problems that a=
re
> difficult to address.
>=20
> 1. CC for allarch packages
>=20
> We have slightly different values for CC on different MACHINEs. (32-bit
> ARMs get -mfp16-format=3D and particularly-contrained MACHINEs get reduce=
d
> SECURITY_CFLAGS. All with the same DEFAULTTUNE are consistent though.) CC
> is always exported by bitbake.conf (among several other places). This
> taints all task hashes for all recipes, even allarch ones. Setting CC =3D
> "no-cc-for-allarch" in allarch.bbclass works around this problem for
> allarch packages.

Where are we adding flags to CC rather than CFLAGS? That sounds like
the real bug somewhere...

> 2. multilib changes baselib for native and allarch packages
>=20
> The task hashes for native packages change when multilib changes baselib
> for the primary (i.e. non-MLPREFIX) architecture. This ends up tainting t=
he
> hashes of some allarch packages which depend on -native packages too, suc=
h
> as ca-certificates.
>=20
> This can be solved if we can avoid baselib being different. I'm hoping th=
at
> we can do this which will make this a non-problem for us. It may be more =
of
> a problem for others.
>=20
> 3. RECIPE_SYSROOT changes its dependencies when using multilib
>=20
> Between multilib-using and non-multilib-using machines RECIPE_SYSROOT
> changes which variables it depends on, even if its expanded version doesn=
't
> change value. This causes the hashes to change:
>=20
> =C2=A0basehash changed from 7e0c5fd84cfb6c12da76d35af73b20ad139213fe8d3d6=
6c9efb934ad5da2c73a to f3644c0dfa625fc1b60782e4e32afb622abf0620bd3235d07a54=
3b3bb4de4d65
> =C2=A0List of dependencies for variable RECIPE_SYSROOT changed from 'froz=
enset()' to 'frozenset({'MLPREFIX'})'
> =C2=A0Dependency on variable MLPREFIX was added
> =C2=A0Variable RECIPE_SYSROOT value changed from '${WORKDIR}/recipe-sysro=
ot' to '${WORKDIR}/${MLPREFIX}recipe-sysroot'
>=20
> The only way I can think of to avoid this is to always set RECIPE_SYSROOT
> to "${WORKDIR}/${MLPREFIX}recipe-sysroot" in bitbake.conf (which means
> setting RECIPE_SYSROOT:class-native too), even when not using multilib.

One trick that may work for this is setting:

RECIPE_SYSROOT[vardepvalue] =3D "${RECIPE_SYSROOT}"

>=20
> 4. gcc-source is sensitive to TARGET_CC_ARCH, SECURITY_CFLAGS and
> =C2=A0=C2=A0 SECURITY_LDFLAGS.
>=20
> gcc-source.inc already has a list of variables that it has to sanitise. I=
t
> can sanitise these too.
>=20
> 5. cross packages are PACKAGE_ARCH =3D "${BUILD_ARCH}", but they depend o=
n
> =C2=A0=C2=A0 non-cross packages with the default PACKAGE_ARCH.
>=20
> This means that changing PACKAGE_ARCH for MACHINEs that have differences =
in
> (e.g.) multilib or SECURITY_CFLAGS isn't sufficient to ensure that they a=
re
> kept separate. That different value of PACKAGE_ARCH in (e.g.)
> linux-libc-headers taints the hashes for (e.g.) gcc-cross-aarch64.

I suspect that is meant to be getting excluded from the hashes...

> 6. :append breaks the variable sanitising done by native.bbclass,
> =C2=A0=C2=A0 allarch.bbclass, gcc-source.inc etc.
>=20
> The :append happens after the variable has been sanitised. The only way I
> can see around this is to invent new "EXTRA_" variables included in the
> default value.

Which variables are we appending and can we stop doing that? I keep
telling people we need to avoid :append and friends...

> Assuming we can't fix all of these we're left unable to rely on a tool to
> identify more serious contraventions. I think this leaves us with four
> options:
>=20
> A. Fix all the serious contraventions of recipes changing behaviour with
> =C2=A0=C2=A0 the same PACKAGE_ARCH we know about and hope that if any new=
 ones appear
> =C2=A0=C2=A0 we'll be able to work out what's going wrong and fix them. T=
his isn't
> =C2=A0=C2=A0 great because it will probably be members of the team who ha=
ve less
> =C2=A0=C2=A0 understanding of this stuff that encounter the problems. Thi=
s assumes
> =C2=A0=C2=A0 that any problems cause actual build failures rather than si=
lent
> =C2=A0=C2=A0 misbehaviour.
>=20
> B. Find some way to fix all the above problems, and any new ones that are
> =C2=A0=C2=A0 then revealed. Keep using a tool on the autobuilder to make =
sure that no
> =C2=A0=C2=A0 new contraventions appear. Encourage use of the tool in othe=
r layers
> =C2=A0=C2=A0 too.
>=20
> C. Find a way to fix the Bitbake problem that I originally identified at
> =C2=A0=C2=A0 the start of this thread. I think that I was on the right tr=
ack by
> =C2=A0=C2=A0 suggesting that we need to do what sstate_clean does to clea=
n up old
> =C2=A0=C2=A0 stamps even when running a non-setscene task, but I suspect =
that this
> =C2=A0=C2=A0 got muddled up with my confusion over stamp filenames.
>=20
> D. Use a distinct TMPDIR for each group of "similar" MACHINEs and rely on
> =C2=A0=C2=A0 sstate to avoid needing to rebuild packages that truly are i=
dentical.
> =C2=A0=C2=A0 I'm not keen on this option because it will require reworkin=
g a lot of
> =C2=A0=C2=A0 the tooling we have around Bitbake. I also think it would pr=
eclude the
> =C2=A0=C2=A0 hope that I have that one day we'd be able to use multiconfi=
g to build
> =C2=A0=C2=A0 all of our MACHINEs at once in parallel.
>=20
>=20
> In the short term I think that I'm going to have a go at option C, but wi=
th
> the fallback that I can just hack around oe-core#5634f2fb17 to fix the
> problem for us in the short term.

I've done my best to give some ideas/thoughts above as best I can...

Cheers,

Richard

