Return-Path: <zizuzacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36591C531C9
	for <webhook@archiver.kernel.org>; Sun, 26 Jul 2026 14:54:19 +0000 (UTC)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12020.1785077649802849300
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 26 Jul 2026 07:54:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=EC/Sc5vO;
 spf=pass (domain: gmail.com, ip: 209.85.167.50, mailfrom: zizuzacker@gmail.com)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5b2aa3be376so1474382e87.0
        for <bitbake-devel@lists.openembedded.org>; Sun, 26 Jul 2026 07:54:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785077648; cv=none;
        d=google.com; s=arc-20260327;
        b=ACOvHVXqfh49lVV8NWyDoAWlXiQKHyBfHYYalNsaDkfqVxzR2mznta5qBhiN0uzyYf
         P9pyCtyk1QsrAhHtXJoZCmcAlnZKA/4MS3R2CyE60+gOXy5YdpN2DbTjxwxvK0Eesdci
         6+fXQysqt1MzqHZVeHS0nT3jS4/5g/HLaTvz4Nq+97g+V4NxsgdWj20UZAczgofsPkDB
         etvxx+NvxRiZo2l9GAQGjKSxgQa6tsBPtfrTluBWlm4nYnE5s5NcWQ0driv5CJMIj+QL
         SH/sqZlDv4U1vzuHDHNvHolDRh0nGV12RbTg/yXDPu6U5eDG6Bh4qWWKcWp3PYV7tBb0
         yjkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vy9mjBargCoc2FabTt8QsBY2UY+lT/d+UspFO/3fFNI=;
        fh=kwhZ3Li+yPVxdlH3ayfQoAuPa3/pJuSlz2Co5M6h6T8=;
        b=c2onNM69dJVzcD7nZgXDBsGUA3XGgjYwgKlgh0uhELORxrUsaiZheFvEcKE9KlMFeZ
         Qm5TXoGurg3pVJN6IVPATLAcJnpygtkb68ngh9Yi+XdYXakxk4r6CDB6htBeZueQWLCZ
         r0qs3XC4GxwKKzEkGkpHbRv5BxPjpCUX2YB96SAPbNs+Af6g2EqE6zKHwi6wz/ehl0uw
         8UH3yUTdsSh4EYXumzwK+lPWTrScQ1bGckCwalkQMCZ6bpLLk9g9rB0+0TX0djiwaRxz
         84xVzW35SCse/Dia6YJw79551Hf6PmGyH6pM7bQYtCmwHpv82MYxLhUaj/MsOd0YHj9Q
         E1bQ==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785077648; x=1785682448; darn=lists.openembedded.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vy9mjBargCoc2FabTt8QsBY2UY+lT/d+UspFO/3fFNI=;
        b=EC/Sc5vOxIC6TGKnMYPbVd2lynVuFookOLabXmJUK+9GTpD8wDnpXSk+nRtMyGDIdD
         dM9xhfi8nYaCGOvQc4KGZJN/N2BTkhdo/ZxLfcCHfCU+MJLAedVd/7ToiDU8KmBqnNkM
         abYvnhZ3shAF+Daxl4/4/mfhLtdLec83wuJsjWG7OX2uiQ9OIqyR2Jd12UOEqw3ReHQK
         Nsa9wwU1GJJ+Eo2LMhT1l7ZcKkUIhhzLx7vmbH4bKOedAXgXSPbaMc/oJoQ1+vxVIYmR
         jzean5wya58Zf1M538DPZPki3PAQKVVCk7L+/8u2uGz02meQTmG4zbkqxSe2ym4SsLMk
         5KOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785077648; x=1785682448;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vy9mjBargCoc2FabTt8QsBY2UY+lT/d+UspFO/3fFNI=;
        b=UiQplAYSv/dLTdK5px0MvOMI7BNywxsdDGGaLY7R541o+pYHOap5TXaOGu3xm9l84g
         OL/3DARz2p4JMwdqhdifPtpK+jjrK7To9yg0pE0r0EFON6EputOiGCkg4qi4RiSkKzS4
         xsfkXvozmEn8GPxjfIQ8A2vSZ+yV2wD41sUbK84S2in0idfNlPpYZ8Cd+sj3JdvbFI5k
         ySDOqSJGMBrSnoSv1arMbizl1KU8mKJ3Vyc0NWARxHJFCnwJ3y/v6FznKXLhMXD3Sfl7
         NSJID8zMG9oVoMi6kM+gieQWEXh/P4wKbkWdoFgnjBCI8D2JXmChUbyKOmUuossQrtqT
         2ARQ==
X-Gm-Message-State: AOJu0Yw/MhYlqmAvo3nFyn6x3KrWyKmQC3iOp1lqlXdT+s3SBdCjH90y
	atwCxXGRM+D/y0kvpW/Nc3/eDLkIO+dWgjpM3n9riWZNytdxeToMpXkoDlA2R06XFAJiI3Mdqhv
	dkTTg7Fm1wT5FKeok+pi8iDHcOrdkI7owMgCYZlY=
X-Gm-Gg: AR+sD11Udt0AgThLnJ4m7vaJtVgYDvCE9yuke/caBQB55ky4ZQPjNkaw6t0eM9zTvpd
	sNyqVFIxxVcpuFea6yDA/3CcfNct9gwm6yOjjOKv+BjqwqACavi10S3gj9frwMbksZpGqNBhNdk
	X/zZtlGa4CSyrkGvuMqcV4IfvzM47lM+t27+hgVSVbw2ahVMAGHSna//E89nRZz9lgF2fYvZI9O
	bbldGm741/9o+YycWO1BL59baVhj7sKfcOtB/WOppkMMpZhCL3DI4Vjnh41b+U=
X-Received: by 2002:a05:6512:10d1:b0:5ae:b59e:aa45 with SMTP id
 2adb3069b0e04-5b2c1b2bf66mr1109447e87.17.1785077647233; Sun, 26 Jul 2026
 07:54:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260725143002.23596-1-zizuzacker@gmail.com> <20260725143002.23596-2-zizuzacker@gmail.com>
 <dd3a79ae52d3d42959ee98c1b6e1d3df4c0a2dee.camel@linuxfoundation.org>
In-Reply-To: <dd3a79ae52d3d42959ee98c1b6e1d3df4c0a2dee.camel@linuxfoundation.org>
From: =?UTF-8?B?TWluaCBUaeG6v24gTmd1eeG7hW4=?= <zizuzacker@gmail.com>
Date: Sun, 26 Jul 2026 21:53:54 +0700
X-Gm-Features: AUfX_mzLqAVFyaoXWDeW5HyXOsWrYTtDDadMn7g865zL1btsjuediptlqQCvuVY
Message-ID: <CAH9t78za_ncy=tnBv--DFqBvsxU-VCX8xGZaj_P-ef3PGvircA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/1] data_smart: fix operations lost when
 an override name contains a variable
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 26 Jul 2026 14:54:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19863

> I think this is because expandKeys() calls renameVar and then
> renameVar itself also calls renameVar() on the same element, which
> breaks things. [...] then I think that resolve the issue?

Yes, it does, and it is the better fix. Both keys are already in the
todolist with their expanded names, so expandKeys() can rename them
both. My patch only worked around the second rename with expand().

I tested your diff on a fresh clone at c251833d2. It fixes the exact
form from the bug report, :prepend and :remove, a conditional override
with no operation keyword, several variables in one override name, and a
variable in the key as well as in the override name, all of which fail
on master. bb.tests.data passes, oe-core parses clean at 952 recipes
with no new warnings, and both v1 test cases pass on your diff unchanged.

> I'm less sure that three different key variables would work with plain
> renameVar, that may also need to set the "no recurse" option.

It does not need it, and it must not have it. In the native.bbclass
shape a key is renamed to another unexpanded key before expandKeys()
runs. recurse=3DTrue gives the right answer with no warnings. I tried
recurse=3DFalse there and the override value is lost: the dependent key is
left behind, and expandKeys() then expands it from the old parent name,
so it no longer matches.

Two things before I send a v2.

First, the new argument breaks recipe_sanity.bbclass, which replaces
DataSmart.renameVar with a wrapper taking a fixed set of arguments. Any
build using INHERIT +=3D "recipe_sanity" now dies before parsing starts:

    TypeError: myrename() got an unexpected keyword argument 'recurse'

A one line oe-core patch passing *args/**kwargs through fixes it, it
just has to go in at the same time.

Second, and this is why I have not sent a v2 yet. There is an ordering
bug here and it is not yours. Master already has it, in the case where
nothing gets dropped:

    ABC =3D "123"
    ABC:append:pn-linux-${XYZ} =3D " 456"
    ABC:append:cfg-${SFX} =3D " 789"

    master gives   "123 789 456"
    should be      "123 456 789"

Both appends are applied, just in the wrong order, and your diff does
not change that case at all.

It matters because of the case your diff does fix. Master drops those
operations, so nobody ever sees the order being wrong. Once they stop
being dropped, it shows:

    PN =3D "packagegroup-cross-canadian-qemux86"

    RDEPENDS:${PN} =3D "base"
    RDEPENDS:${PN}:append:pn-packagegroup-cross-canadian-${MACHINE} =3D " a=
"
    RDEPENDS:${PN}:append:libc-${TCLIBC} =3D " b"
    RDEPENDS:${PN}:append:class-target =3D " c"

    master      "base c"      a and b dropped
    your diff   "base c b a"
    my v1       "base c a b"
    should be   "base a b c"

pn-${PN}, libc-glibc and class-target are all in OVERRIDES at once, so
all three appends are meant to apply.

The reason seems to be __setvar_regexp__, which ends in
(:(?P<add>[^A-Z]*))?$. That came from 6eb56624e, where you stopped
capitalised overrides being processed. ${MACHINE} has uppercase in it,
so an override name holding it fails that test and is stored as a
variable of its own, while a plain override name passes and becomes an
entry in the :append flag on the base variable. The operations for one
variable then live in two places, and the flag group is applied first
regardless of what was written first. With your diff all six orderings
of a, b and c give "base c b a". Mine keeps the order within the second
group but still puts c first, so it is wrong as well.

That line leaves a second gap neither patch closes. A lowercase variable
name passes the regexp, so an append written with ${machine} rather than
${MACHINE} becomes a flag whose override name is still
pn-gizmo-${machine}, and that name is never expanded when overrides are
matched. Master, your diff and mine all return "base" for it. Nobody
writes ${machine} in practice, but it is another way to lose the same
operation.

Would you like me to fix the drop now and report the ordering as its own
bug, or look at these together? I did not want to send a v2 that changes
ordering without asking first.

Best regards,
Tien


V=C3=A0o CN, 26 thg 7, 2026 va=CC=80o lu=CC=81c 19:21 Richard Purdie
<richard.purdie@linuxfoundation.org> =C4=91=C3=A3 vi=E1=BA=BFt:

>
> On Sat, 2026-07-25 at 21:30 +0700, Zk47T via lists.openembedded.org wrote=
:
> > An operation whose override name needs key expansion is silently droppe=
d:
> >
> >     RDEPENDS:${PN}:append:pn-foo-${MACHINE} =3D " bar"
> >
> > renameVar() rebuilds the dependent override keys with a plain string
> > replace, so renaming RDEPENDS:${PN} leaves the append attached to
> > RDEPENDS:foo:append:pn-foo-${MACHINE}, which never matches an active
> > override. expandKeys() cannot fix that up afterwards either, as it work=
s
> > from a list of keys collected before any renaming happened.
> >
> > Expand the derived name before renaming it. Only do so once newkey is
> > itself expanded, otherwise expandKeys() has still to rename newkey and
> > handles the dependent keys along with it.
> >
> > Add regression tests for both cases.
> >
> > Fixes [YOCTO #14867]
> >
> > Signed-off-by: Nguyen Minh Tien <zizuzacker@gmail.com>
> > ---
> >  lib/bb/data_smart.py | 11 +++++++++--
> >  lib/bb/tests/data.py | 25 +++++++++++++++++++++++++
> >  2 files changed, 34 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
> > index 9961269a3..5738aff95 100644
> > --- a/lib/bb/data_smart.py
> > +++ b/lib/bb/data_smart.py
> > @@ -697,8 +697,15 @@ class DataSmart(MutableMapping):
> >              found =3D True
> >              self.overridedata[newkey] =3D []
> >              for (v, o) in self.overridedata[key]:
> > -                self.overridedata[newkey].append([v.replace(key, newke=
y), o])
> > -                self.renameVar(v, v.replace(key, newkey))
> > +                newv =3D v.replace(key, newkey)
> > +                # The derived name may still hold a variable reference=
 which
> > +                # expandKeys() will never revisit, so expand it here. =
Only once
> > +                # newkey is expanded though, otherwise expandKeys() ha=
s still to
> > +                # rename newkey and handles the dependent keys along w=
ith it.
> > +                if '${' in newv and '${' not in newkey:
> > +                    newv =3D self.expand(newv)
> > +                self.overridedata[newkey].append([newv, o])
> > +                self.renameVar(v, newv)
> >
>
> Thanks for the patch and the test cases. I had a deeper look at this as
> I was a bit puzzled how this would work without your patch:
>
> XYZ =3D "yocto"
> ABC =3D "123"
> ABC:append:pn-linux-${XYZ} =3D " 456"
> $ bitbake-getvar -r linux-yocto ABC
> ABC=3D"123 456"
>
> as if the code can handle that, it should be able to handle the other
> case too. I think this is because expandKeys() calls renameVar and then
> renameVar itself also calls renameVar() on the same element, which
> breaks things. That means that if you do:
>
> diff --git a/lib/bb/data.py b/lib/bb/data.py
> index 5fdcdb04a..e3af12a35 100644
> --- a/lib/bb/data.py
> +++ b/lib/bb/data.py
> @@ -94,7 +94,7 @@ def expandKeys(alterdata, readdata =3D None):
>              val =3D alterdata.getVar(key, False)
>              if val is not None:
>                  bb.warn("Variable key %s (%s) replaces original key %s (=
%s)." % (key, val, ekey, newval))
> -        alterdata.renameVar(key, ekey)
> +        alterdata.renameVar(key, ekey, recurse=3DFalse)
>
>  def inheritFromOS(d, savedenv, permitted):
>      """Inherit variables from the initial environment."""
> diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
> index 110dfa111..78ff9b961 100644
> --- a/lib/bb/data_smart.py
> +++ b/lib/bb/data_smart.py
> @@ -661,7 +661,7 @@ class DataSmart(MutableMapping):
>      def getVar(self, var, expand=3DTrue, noweakdefault=3DFalse, parsing=
=3DFalse):
>          return self.getVarFlag(var, "_content", expand, noweakdefault, p=
arsing)
>
> -    def renameVar(self, key, newkey, **loginfo):
> +    def renameVar(self, key, newkey, recurse=3DTrue, **loginfo):
>          """
>          Rename the variable key to newkey
>          """
> @@ -693,7 +693,8 @@ class DataSmart(MutableMapping):
>              self.overridedata[newkey] =3D []
>              for (v, o) in self.overridedata[key]:
>                  self.overridedata[newkey].append([v.replace(key, newkey)=
, o])
> -                self.renameVar(v, v.replace(key, newkey))
> +                if recurse:
> +                    self.renameVar(v, v.replace(key, newkey))
>
>          if ':' in newkey and val is None:
>              self._setvar_update_overrides(newkey, **loginfo)
>
>
>
> then I think that resolve the issue? It would also perhaps resolve an
> issue where a variable with three different key expansions in it might
> not work! I'm less sure that three different key variables would work
> with plain renameVar, that may also need to set the "no recurse"
> option, I'm not sure.
>
> Could you see if this makes sense to you?
>
> Cheers,
>
> Richard
>
>
>
>

