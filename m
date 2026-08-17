Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62618C5B572
	for <webhook@archiver.kernel.org>; Mon, 17 Aug 2026 21:08:46 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5348.1787000923357063157
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Aug 2026 14:08:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=fcpdrLTL;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4994c49f588so3671975e9.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 17 Aug 2026 14:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1787000921; x=1787605721; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=FGBFen4ZL5Cq9H2fIPdsVA+igm/DBQJGNxpXQvhfxt8=;
        b=fcpdrLTLAPICodf+JxqCJNEcD/a4gsB2oJHYQhSA87X/zwQ5OTVsz11jFaF+aEif0w
         T5jc84uou9Asb1kJqkQZ1cKo3nG7MIlA63akk8f3BzJO8RI5Etj2bGknEbTBmbnNpfMk
         mqVpywkqbW4Ieg8SAC5Gy4DRD4DFMXSCaEDjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787000921; x=1787605721;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FGBFen4ZL5Cq9H2fIPdsVA+igm/DBQJGNxpXQvhfxt8=;
        b=guIrxAXkZZzNbzIR/2+YmTWei6v4zOqLzaiAQ8Ob0erStfCdplNOu3yjPZGM2BY6Ch
         0llyjBwJ9waBnqmoGuc4A62BEtvLfZprOOMg+CziIeBvsMS41F9DqHDBxf1FU1PqSO+P
         0X2dfbi+0GymO/jf3Q5VMxLIrCimwJwCQQ+3Qc9Pj+8lc8H4EhTeGbV4suoXu1kr+E8Z
         AZdBMpPvl5bDUv31m3oKt9g/y24U8pXxlkFHTDCsNQzj8X0ukLl3EhHHpR4eMk6VY00j
         ateEjdZToMniB6Rm1EZb2j5ZXPlPUHO7cFo25+vCaMYDEHMBaqoIxltrb9VDkT7a3i5I
         0EJA==
X-Gm-Message-State: AOJu0YyYLyabPFgve2JHTonoMfXtA7y2qIiv2U4DPD80dG6IWghk9rlq
	0RZUj0HpsCP0rjUngPx5xQY/rjc/cKHq++EzA3W+m4z+ymMopYt21eaCtQejvrqK5ck=
X-Gm-Gg: AR+sD132K/RdcGvc4R+2UkGBeKUx5MwAPC2CtsUv3G5gFBmU2xeXv6SoyUPh0+2UrQi
	Ff5yhKA+y0F+oLOHM1pnrd5f7uIBrLdkEDqCOnvB2ZL0pqUOV+1dVhc5pKLxNcZO4jpuCA1MYAv
	xDnJZHp/L4hTrnrwlYV5HpO1wdUqRNkUzF8gv663cyOrhT0+ztP+btCT3rKUp1qVhE0gS49pRco
	RwFylti9PHbp8XilZUXKhOuOc6+VnOqZuloAqeW+x3KyzvA/PpgEeXl6TctHa75d92B0CJIw4IH
	8GlhIWsP4DuY1JFMJAVE3cfgEaGPKmBwWxUzMdCU+LJaQNNwdKGXwZaT8W+ZAXOyt5+3n8b6nVk
	1kHE5btDHtXJ5fB+xqJbUAUFBMev88SXDvaj5sqlZ5UGFVRyBi174YpLSpPotyV8iCkK+l4KJeo
	DL/oX1JaQqfUQzoO1s7IFh0YXCQd8BcL9L2DkT0s8qxPIPMyAo+xDhGN99RQTTC49OiVLXkZlDb
	zuylZfYKxhg7Fd36XszM8LQMc0huTttMS0SUfzlgzPdDTK/638hCAQZLWQCPu34
X-Received: by 2002:a05:600c:c04b:10b0:495:5d6d:9cc1 with SMTP id 5b1f17b1804b1-499a1f81c6bmr6414975e9.0.1787000921373;
        Mon, 17 Aug 2026 14:08:41 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:4d4c:ee18:5ecd:c132? ([2001:8b0:aba:5f3c:4d4c:ee18:5ecd:c132])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4999610ed6dsm227397945e9.8.2026.08.17.14.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 14:08:39 -0700 (PDT)
Message-ID: <8558d54fda8e977ea6e677693db0586b8e10e80a.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] toaster: Add recipe variables view
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paolo Wattebled <paolo.wattebled@savoirfairelinux.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 17 Aug 2026 22:08:38 +0100
In-Reply-To: <1200355947.1128688.1786996086820.JavaMail.zimbra@savoirfairelinux.com>
References: <20260812150448.2343308-1-paolo.wattebled@savoirfairelinux.com>
	 <2434d54e4295573c9632a1fbcd0cef7ae6a0d413.camel@linuxfoundation.org>
	 <252742809.992447.1786635089054.JavaMail.zimbra@savoirfairelinux.com>
	 <fbc8c6306856f3be07a2e6aa3ec76b9070a35897.camel@linuxfoundation.org>
	 <453789479.1044718.1786717890540.JavaMail.zimbra@savoirfairelinux.com>
	 <2417b94a9c5734b9e9b54f9d1eb3133cab4c0ff1.camel@linuxfoundation.org>
	 <1200355947.1128688.1786996086820.JavaMail.zimbra@savoirfairelinux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Aug 2026 21:08:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19979

On Mon, 2026-08-17 at 15:48 -0400, Paolo Wattebled wrote:
> > The cache you've added is per parsed recipe, not per recipe used in the
> > build. Was the patch AI assisted?
>=20
> The new `recipe_variables` field is collected in the recipe parse cache f=
or
> every parsed recipe. `buildDependTree()` copies cache fields into the
> dependency graph only for recipes in the runqueue, and Toaster persists o=
nly
> those entries. Thus the cache is per parsed recipe, while persisted Toast=
er
> rows are runqueue-selected.
>=20
> Yes, the patch was AI-assisted, as disclosed in the commit messages. I us=
ed
> AI tools to assist with code generation, but I reviewed and tested the
> changes, and I take responsibility for the design and the submitted commi=
ts.

Sorry, I did somehow miss the tag in the commit. Nonetheless, I am
worried that the changes here aren't quite right.

> > 33 differences per recipe seems very low as well.
> >=20
> > bitbake -e bash | grep -v ^# > a
> > bitbake -e quilt | grep -v ^# > b
> > diff -u a b | grep ^-[A-Z] | grep -v : | wc
> >=20
> > So I've filtered only variables not functions, nothing with an override
> > and I still get 132 differences.
>=20
> > I think you're missing a lot of values.
>=20
> The current code records only variables whose BitBake `VariableHistory` h=
as an
> operation from the recipe, a matching `.bbappend`, or a recipe-owned `.in=
c`.
> It excludes class- and configuration-only values, functions, inactive
> overrides, and values that fail expansion.
>=20
> Therefore the count reflects this source filter, not the complete effecti=
ve
> recipe datastore. I agree that describing the result as a resolved recipe
> variable snapshot was misleading.
>=20
> This raises a question about the intended scope of the feature. In your v=
iew,
> which variables should Toaster expose here? Should it provide the complet=
e
> effective recipe datastore, including values inherited from configuration=
 and
> classes and values selected through overrides, or should it expose a clea=
rly
> defined subset? If you expect a subset, which inclusion or exclusion crit=
eria
> would you consider useful and correct?

I'm not sure what the right answer is, but I don't think your current
criteria works as you think it does.

> > Ok, how does it use variable history for selection?
>=20
> Variable history is used only as a provenance filter: it selects variable=
s
> touched by recipe metadata. The stored value is then obtained separately =
from
> the parsed recipe datastore using `metadata.getVar(..., True)`. The histo=
ry
> itself is not stored. The compressed snapshot is carried through the depe=
ndency
> graph for runqueue recipes and then stored in Toaster's `RecipeVariable` =
table.

For example if the core metadata has:

X =3D "${Y}"
Y =3D "Z"

then the recipe sets Y =3D "A", the variable history for X doesn't change
but the value does. That is a simple example, there are much more
complex ones.

Cheers,

Richard

