Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42392CC6B08
	for <webhook@archiver.kernel.org>; Tue, 13 Oct 2026 13:10:23 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6822.1791897019436165973
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Oct 2026 06:10:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=YIXSd8Eu;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.218.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c37b612635bso31128766b.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 13 Oct 2026 06:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1791897017; x=1792501817; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=YRqd03n3HIkrpl9u91dUCtxYLKIPFzAZrXsWRgK75mg=;
        b=YIXSd8EuEW9AU1AgCvMKEJLPcSCszIxwgUqGyD5z4A5yvmAhFVYugrkyHeZvqiPx3p
         CTccQY7nWyn9upS1vBnh5l50YZg4yQ0OMrGcM1J8awCcqpFYsotTwlskCQVRSTfd4CSf
         OCDZvfUstOxO8kGBXToRxSI8Uol2vD2sAp8zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791897017; x=1792501817;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YRqd03n3HIkrpl9u91dUCtxYLKIPFzAZrXsWRgK75mg=;
        b=vMGhH5xJazaEtRCYfXoyqanMHUvOqmovIUknb5Ua1RGWJhdDfoGd1282gpZbuyIile
         voNcDzRrpMLIlveLqHXwshdc6HhnlGZ9UGNLaDbL7xvbm2WcsXMTlV3GAK8kajxpfqpc
         H95lQ8kTagLp+9DgPFhruybK4uGQ1SIO9qfUVHubImxmttDSji8p3JoOz3pllALqB92g
         1nOoBESgUdRykpHRdVrkhmsDFo+ysg2JNt9QlOw8SWO66r8YA/HbnnK9OQ4oh7bGgv73
         qOYFgMYL/O5ovFbpNBqi7pdhl/uJLFL3EmnJ/n5CmIttX/SizfGnegtjouw4PmriFRTH
         T3lA==
X-Forwarded-Encrypted: i=1; AKwUvBxn7/FXcUEsBKWhyp4M1+He73XzIRXgthoB2AdouH/wzfX4zrtmsjqfBGjp2rPAGA6ZQmuyAUTpcy6d34NU@lists.openembedded.org
X-Gm-Message-State: AFq9FYJ9EylPfvN+5ZvG7D8APeJiIbxAeS+UK3ErqfpAjs6NBoEMb1nF
	xD9sEftF1HQnYAbGoZCwB4yGHf2XApIlKkoLETAifkik/tsEvH+420kGaPMzWo2V0oU=
X-Gm-Gg: AYBFou1g75JxsUSK63hUsZp4XiGidXv+dXghBqarbWs3bS2k5pPuWbdSWCxEjLpeGAn
	FyqK10YWeePPDjqwLV08tTwcanPIkKAeuhkIdTk7I+rpk0AUKrX/MxSjiMaTx/tK2mGmaErb+jl
	GtxJOC03ds+q+Y4VrJrqfeWOGjO50NAliYerr303iRLymtaod3avX9S/NuhWIi6Epv34NxWSbQD
	SfxttHIyyqC9b69Y4KtQcWslWnfA5RvqPpH5Mr/FI0doKspadjkFR7G91ElXvohqSIOk1T61xDa
	nvb3XBlrGedoiRTcxGl/6xv+uYZCmY9Kdkholm7FHMBXZIip7WG10J/Ynmfq5Ye9xjFJSjSIKCX
	jnEC3iSeDQgxVEeE0+fWzy5x0VpKwn6wcrLJHmTyA7ppnsgIuGrkBqhrU/1aWdhENUJZK8Odz+z
	dn/aB6HJ8NeuOry6wjBlwO2gE78V+V8ka/u8p1Z+cjCfECk69yZxiSRb1MM3tOXAHOJz53a3I7S
	4PTXHzIWGP77lA0zYp8ONZG6b3izFhhBG6Lm7V5tlX5F+5azYh87i91FRT/Wf4=
X-Received: by 2002:a17:907:1ca0:b0:c26:22ec:db92 with SMTP id a640c23a62f3a-c31aa02c51amr1278861966b.47.1791897017452;
        Tue, 13 Oct 2026 06:10:17 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:4c74:cb0d:dec6:c05e? ([2001:8b0:aba:5f3c:4c74:cb0d:dec6:c05e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c36fe6dbc61sm80494866b.30.2026.10.13.06.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 06:10:16 -0700 (PDT)
Message-ID: <b709283077dfbd7b34bcca2ebb38c38edb8b94af.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] doc: document dependency tracking
 associated with addpylib
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Antonin Godard <antonin.godard@bootlin.com>, yann.dirson@vates.tech, 
	bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org
Date: Tue, 13 Oct 2026 14:10:15 +0100
In-Reply-To: <DM3P6R5ZRVPM.3PW3QYG9BZOEI@bootlin.com>
References: 
	<1791793541.8631fc262581453bbf619ec5b2062170.1a12f37b16e00080d7@vates.tech>
	 <DM2VSZ91PNOJ.YXQAWC84B6NR@bootlin.com>
	 <DM2W2QFSWNBT.2A6RT11K7VMT1@bootlin.com>
	 <1791885365.8631fc262581453bbf619ec5b2062170.1a134b0cf0a0008425@vates.tech>
	 <DM3P6R5ZRVPM.3PW3QYG9BZOEI@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 13 Oct 2026 13:10:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20330

On Tue, 2026-10-13 at 14:09 +0200, Antonin Godard wrote:
> On Tue Oct 13, 2026 at 11:56 AM CEST, Yann Dirson via lists.openembedded.=
org wrote:
> >=20
> >=20
> > On 10/12/26 3:20 PM, Antonin Godard wrote:
> > > On Mon Oct 12, 2026 at 3:08 PM CEST, Antonin Godard via lists.openemb=
edded.org wrote:
> > > > Hi,
> > > >=20
> > > > On Mon Oct 12, 2026 at 10:25 AM CEST, Yann Dirson via lists.openemb=
edded.org wrote:
> > > > > Reported-by: Claude Opus 5.5
> > > > > Signed-off-by: Yann Dirson <yann.dirson@vates.tech>
> > > > > ---
> > > > > =C2=A0 doc/bitbake-user-manual/bitbake-user-manual-metadata.rst |=
 8 ++++++++
> > > > > =C2=A0 1 file changed, 8 insertions(+)
> > > > >=20
> > > > > diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata=
.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> > > > > index 621aab253..eef1f9624 100644
> > > > > --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> > > > > +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> > > > > @@ -2264,6 +2264,14 @@ The specified <namespace> is imported auto=
matically, and if the imported
> > > > > =C2=A0 module specifies an attribute named ``BBIMPORTS``, that li=
st of
> > > > > =C2=A0 sub-modules is iterated and imported too.
> > > > > =C2=A0=20
> > > > > +Additionally, Bitbake will detect usage of functions from such a
> > > > > +library and include them in task hashes, so changes in those fun=
ctions
> > > > > +trigger task rebuilds.=C2=A0 Note that only functions inside mod=
ules
> > > > > +declared using ``BBIMPORTS`` benefit from this dependency tracki=
ng,
> > > > > +any name defined directly in the specified namespace (e.g. in
> > > > > +`<namespace>/__init__.py`, or in a library hat would be defined =
as
> > > >=20
> > > > s/hat/that/
> > > >=20
> > > > > +`<namespace>.py`) would *not* benefit from this tracking.
> > > >=20
> > > > Otherwise, this is clear to me. I did not know about this limitatio=
n/feature,
> > > > and this is definitely important to document, thanks!
> > >=20
> > > Reading the code[1], it seems that functions prefixed with _ are not =
included
> > > in the task checksums - if I understood correctly. I think it would b=
e also
> > > important to mention that. Could you add it in a v2?
> >=20
> > It could be asked why we would want to exclude them.=C2=A0 Usually that=
 would=20
> > be internal functions, to be called by the exported ones, so they would=
=20
> > equally matter - but then they are actually not included in the task=
=20
> > hash, so it rather looks like a bug rather than something to document?
>=20
> You're right, it seems strange to exclude them entirely. You may want to =
send a
> patch to remove this then? At least it will kick-off the discussion on th=
is
> list.

I suspect there are two levels of issues here. Funcitons with a single
"_" prefix are internal functions and those were the ones we likely
wanted to exclude. __init__ is probably an oversight. I do think people
are getting too focused on the detail of the taskhashes though. There
comes a point in our code when something becomes API rather than "data"
and the taskhashes really are meant to reflect more data than absolute
every detail. Before function library hashing that boundary was clearer
but it still exists (e.g. bitbake itself isn't hashed, nor should it
be, nor the host system python version).

Cheers,

Richard






