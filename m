Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFD6C55822
	for <webhook@archiver.kernel.org>; Tue,  4 Aug 2026 21:12:38 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.26866.1785877950958483350
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Aug 2026 14:12:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=SU3xikGU;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4954aff6088so2399255e9.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 04 Aug 2026 14:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1785877949; x=1786482749; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=54N6oVASnp7O5gUUrqkHLySvgy0nFAkPnsq9rhvT5Kg=;
        b=SU3xikGUpWr+6saPZd6ohyMt0KGcrOAheHLY/G2vQzSSv49YY1Bc+DjjkMWmsXNos+
         ExoaZnrr8hkI0EvFZgReQVdVO6GLy6Yk3nKYTTUK3em7ng32Q3HXtVeqxdPeyoi1z6MQ
         xx9XCl5MBSyKNF1b6DS2taGLU11QDfh9jBT+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785877949; x=1786482749;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=54N6oVASnp7O5gUUrqkHLySvgy0nFAkPnsq9rhvT5Kg=;
        b=Uq2asjR6R6sqSabHp0TTeSKVORD6xgJCjtwCIss936MOsDdw3sz92eLzv2tHoozNT+
         4YHVFgDJETFfzYk5OQTFTHOiWd1tOP2LS+rR3RGqtke75uyGMHkLI9uJz3mobYyTzdfx
         uh/ibD+jBqOOkr3/bto399VZapfWOHslibJMqv9wIhZvlIveig3ovMzv2UmiyggAGn3u
         k+fWA85Cbe6IDTU8CHhXml82tVGGEEjMXxgjcIKWvFOAzjFw10ocDFT2fRDS0fXS/OWG
         yqLYuugu5j5JB5IVxTPGciibuRoIhiF8OnokH2Us2g3r1xm8/VMIhwe6Ksz5sY3xSzBb
         I1YQ==
X-Gm-Message-State: AOJu0Yxc2E9ucA0n49PDKYUXta2KnLTq8ORRAw9/P+aPiu0fchB2MUCJ
	j3qqw1njclicPIB71L4WA2ZNEdCa5yfBgUAKhKl7jLJex1RJ3iQcX2pmyroLXDz0NyE=
X-Gm-Gg: AR+sD12yMXJ6NqANVWWZaffYr1Mt73CGSqCuFemJMZET1/XE6c9latC0p3RKWwsm2As
	KwQG+BPn0bImU2uaxs0WGgHQ7HN+wn+i9igHUwYy45LXPmcizXgBYWNE+MreZiQyC+wqD/Sh9kI
	te4D2R3PDrGwoB93aUje5Q8ydHjjBkoweDQaYBWbUdaTVZvEZ5jPttWKDxMc8ZS9KgMNNRHvf2a
	GvmtFl+A8ScsayqVxBjJ/0p1iXuy2EbT/XcKiiCxMNW3r885q1jLVPS2dTxljWzJ4WSFICaNFRD
	IlIg8LZIXajZq5kU601fdfh50vhQcHwoEu9O1llouXgLVLp9K69AJJCN1n49ZNn4oERfiTJjij/
	2h31gQU/oz8FiWsJ7XPP9f1lvMhwVuepBJxL0sKn3G051/KgOB1hvGqx7HnRPBfv7+BZbL5KOWy
	eGh3/vYX+HfwY3wykJ+MO7XP1ETKlW50rMOOkNozxYmeQSmfI61cZzobetxocu0xlEBhpy7rWNs
	rPjhj59obsvjl47vmvpIjJ5qY4HPbB1f+Zyst6eqPCa4YP6XfY5ng==
X-Received: by 2002:a05:600c:190a:b0:495:6a50:3fb8 with SMTP id 5b1f17b1804b1-4994e743275mr12055705e9.1.1785877948923;
        Tue, 04 Aug 2026 14:12:28 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:cf1f:6744:c6dd:c3ab? ([2001:8b0:aba:5f3c:cf1f:6744:c6dd:c3ab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e52d819sm11016925e9.1.2026.08.04.14.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 14:12:28 -0700 (PDT)
Message-ID: <bf89837cf89ae1bdfdabc4adc4bf5bf49593e72d.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/1] data_smart: fix operations lost
 when an override name contains a variable
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Minh =?UTF-8?Q?Ti=E1=BA=BFn_Nguy=E1=BB=85n?= <zizuzacker@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Tue, 04 Aug 2026 22:12:27 +0100
In-Reply-To: <CAH9t78za_ncy=tnBv--DFqBvsxU-VCX8xGZaj_P-ef3PGvircA@mail.gmail.com>
References: <20260725143002.23596-1-zizuzacker@gmail.com>
	 <20260725143002.23596-2-zizuzacker@gmail.com>
	 <dd3a79ae52d3d42959ee98c1b6e1d3df4c0a2dee.camel@linuxfoundation.org>
	 <CAH9t78za_ncy=tnBv--DFqBvsxU-VCX8xGZaj_P-ef3PGvircA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 04 Aug 2026 21:12:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19902

Hi Tien,

On Sun, 2026-07-26 at 21:53 +0700, Minh Ti=E1=BA=BFn Nguy=E1=BB=85n wrote:
> > I think this is because expandKeys() calls renameVar and then
> > renameVar itself also calls renameVar() on the same element, which
> > breaks things. [...] then I think that resolve the issue?
>=20
> Yes, it does, and it is the better fix. Both keys are already in the
> todolist with their expanded names, so expandKeys() can rename them
> both. My patch only worked around the second rename with expand().
>=20
> I tested your diff on a fresh clone at c251833d2. It fixes the exact
> form from the bug report, :prepend and :remove, a conditional override
> with no operation keyword, several variables in one override name, and a
> variable in the key as well as in the override name, all of which fail
> on master. bb.tests.data passes, oe-core parses clean at 952 recipes
> with no new warnings, and both v1 test cases pass on your diff unchanged.
>=20
> > I'm less sure that three different key variables would work with plain
> > renameVar, that may also need to set the "no recurse" option.
>=20
> It does not need it, and it must not have it. In the native.bbclass
> shape a key is renamed to another unexpanded key before expandKeys()
> runs. recurse=3DTrue gives the right answer with no warnings. I tried
> recurse=3DFalse there and the override value is lost: the dependent key i=
s
> left behind, and expandKeys() then expands it from the old parent name,
> so it no longer matches.
>=20
> Two things before I send a v2.
>=20
> First, the new argument breaks recipe_sanity.bbclass, which replaces
> DataSmart.renameVar with a wrapper taking a fixed set of arguments. Any
> build using INHERIT +=3D "recipe_sanity" now dies before parsing starts:
>=20
> =C2=A0=C2=A0=C2=A0 TypeError: myrename() got an unexpected keyword argume=
nt 'recurse'
>=20
> A one line oe-core patch passing *args/**kwargs through fixes it, it
> just has to go in at the same time.
>=20
> Second, and this is why I have not sent a v2 yet. There is an ordering
> bug here and it is not yours. Master already has it, in the case where
> nothing gets dropped:
>=20
> =C2=A0=C2=A0=C2=A0 ABC =3D "123"
> =C2=A0=C2=A0=C2=A0 ABC:append:pn-linux-${XYZ} =3D " 456"
> =C2=A0=C2=A0=C2=A0 ABC:append:cfg-${SFX} =3D " 789"
>=20
> =C2=A0=C2=A0=C2=A0 master gives=C2=A0=C2=A0 "123 789 456"
> =C2=A0=C2=A0=C2=A0 should be=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "123 456 789"
>=20
> Both appends are applied, just in the wrong order, and your diff does
> not change that case at all.
>=20
> It matters because of the case your diff does fix. Master drops those
> operations, so nobody ever sees the order being wrong. Once they stop
> being dropped, it shows:
>=20
> =C2=A0=C2=A0=C2=A0 PN =3D "packagegroup-cross-canadian-qemux86"
>=20
> =C2=A0=C2=A0=C2=A0 RDEPENDS:${PN} =3D "base"
> =C2=A0=C2=A0=C2=A0 RDEPENDS:${PN}:append:pn-packagegroup-cross-canadian-$=
{MACHINE} =3D " a"
> =C2=A0=C2=A0=C2=A0 RDEPENDS:${PN}:append:libc-${TCLIBC} =3D " b"
> =C2=A0=C2=A0=C2=A0 RDEPENDS:${PN}:append:class-target =3D " c"
>=20
> =C2=A0=C2=A0=C2=A0 master=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "base c"=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 a and b dropped
> =C2=A0=C2=A0=C2=A0 your diff=C2=A0=C2=A0 "base c b a"
> =C2=A0=C2=A0=C2=A0 my v1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "base c a b"
> =C2=A0=C2=A0=C2=A0 should be=C2=A0=C2=A0 "base a b c"
>=20
> pn-${PN}, libc-glibc and class-target are all in OVERRIDES at once, so
> all three appends are meant to apply.
>=20
> The reason seems to be __setvar_regexp__, which ends in
> (:(?P<add>[^A-Z]*))?$. That came from 6eb56624e, where you stopped
> capitalised overrides being processed. ${MACHINE} has uppercase in it,
> so an override name holding it fails that test and is stored as a
> variable of its own, while a plain override name passes and becomes an
> entry in the :append flag on the base variable. The operations for one
> variable then live in two places, and the flag group is applied first
> regardless of what was written first. With your diff all six orderings
> of a, b and c give "base c b a". Mine keeps the order within the second
> group but still puts c first, so it is wrong as well.
>=20
> That line leaves a second gap neither patch closes. A lowercase variable
> name passes the regexp, so an append written with ${machine} rather than
> ${MACHINE} becomes a flag whose override name is still
> pn-gizmo-${machine}, and that name is never expanded when overrides are
> matched. Master, your diff and mine all return "base" for it. Nobody
> writes ${machine} in practice, but it is another way to lose the same
> operation.
>=20
> Would you like me to fix the drop now and report the ordering as its own
> bug, or look at these together? I did not want to send a v2 that changes
> ordering without asking first.

Were you going to send an updated patch? I think the issues are
separate, we should fix the operations in one patch. I'm not convinced
the ordering issue is "real" in that we've not commited to any
particular order, only that for a given bitbake version, it should
always be consistent. It would be good to close out the first issue.
I'm happy to write some patches if you're not able to.

Cheers,

Richard


