Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166EAC02192
	for <webhook@archiver.kernel.org>; Mon,  3 Feb 2025 17:41:22 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web10.94422.1738604478908544539
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 03 Feb 2025 09:41:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=VGfILbAm;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4361c705434so34950325e9.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 03 Feb 2025 09:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1738604477; x=1739209277; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0yN+nvs+Zpq7pQz274WDB1XlreCXEqijf9GKRCx5E34=;
        b=VGfILbAmWXVmSG3Fvl9WmqvCRAN5FaUFKsQ7wjFdAFksKJTbuf8u2vqZ0j3zBYp+Qq
         +CO4s1gzvZ9evdWMBX2n1eMXVZSDcja7Sm4DSxeg27NmYsIjVf6dFDEXRdGaYLgqA+Rx
         Wh8CofcD5Kwoec2OVVUxprx8ijavA/JMtSzYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738604477; x=1739209277;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0yN+nvs+Zpq7pQz274WDB1XlreCXEqijf9GKRCx5E34=;
        b=PB13hOw2Um05QOcbpUA/TMwUvoZvRFJ4mvAeFWEQlGEZCf4mHeBXkrT5v4ktrA4mwa
         WCzGYdKxBMudoHcSM3q0G55W6b9St3qpGb197kz6r7DwV2xHNc+LAiQM8N9vQyHPQEQP
         SaGx5NaZPtRDsKenrbpWXxlZRUN5SGLDwymakOjMQTumdlhkSKPoaySGNutRmX5XJGM5
         fQZTat9JfEYnjz5+fBNbbcp/ZwX+66uleWDiP0+Cy8RyLkg/mfcFoFKP380TpZEZilgb
         Exy2Pc5mfydxjFRMqiJQH58E2O6THWKVV08CUDHbp6ZXdofGMb9lNhGy0/AbRKhQRwn+
         lQuA==
X-Forwarded-Encrypted: i=1; AJvYcCWMZ71YUSkR4YAUFVFWOZ1dcqRKWSi3+LMPQvdzUJfJlyXto/ScMg/2zcsZc6xr+atTXebMwTWTrfALD3ss@lists.openembedded.org
X-Gm-Message-State: AOJu0YxgoI7uBZ/Xxvt6cBMc/VH0aqFm99BrbOg+me/ZzIHVofMW4o68
	pZtWIFbgkAl68H1lGFOzAyDA1cYRzEB930O3qf00qkwkFN4JDjiVwVQh2CsyoEBShM7S5jWpOYY
	J
X-Gm-Gg: ASbGncvb9OiyQir01x+bosaXSRyfPIiOyPKx23cgSa19USmM07SuktOoseC5h1RVcu1
	mef9dkMW6ry3siIiR49WtLFYNDvQ1iKZA5a84d4q9CzuF3WHtPS24qH5/iXrKfDUTmomj2cSp+A
	K/RkqMPChUV//CimPzpYZ5s3cAg6ZGhixAW1C0lN8+kLTqGDNjcsRtrJdSeLpfVsQlpvw+lW+0F
	KjYBWT1LIkbOHRqdD2g4L7wPJbmK0abGI7MpJXVOx5AAqpOvSbAG6cY8a2cLbaXe8klUl87Wt5d
	BFadEARDmZFJ7w1LoLjwMrdqq1b6nBi1o6DVbQLuzL3eo21a/NXmHLpDTepvAJNdjxHRa2k0YiO
	TuPNt
X-Google-Smtp-Source: AGHT+IHXTaISQ7rwxFPJeXm4W85S9/UoaLjOhFMgNebjhRzotsZCJslYGHlX4JAhgt0GFoQ/8TCLCA==
X-Received: by 2002:a05:600c:8712:b0:434:a1e7:27b0 with SMTP id 5b1f17b1804b1-438dc3c29f2mr257239185e9.11.1738604477315;
        Mon, 03 Feb 2025 09:41:17 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:41c1:3919:865f:692c? ([2001:8b0:aba:5f3c:41c1:3919:865f:692c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438e23de772sm160874875e9.13.2025.02.03.09.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 09:41:16 -0800 (PST)
Message-ID: <9ee0c248fb20dd6b718e6a0059d7665bafc85c22.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 0/3] NPM/NPM Shrinkwrap Basic
 Authentication Credential Support:
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: eric.meyers15310@gmail.com, Chuck Wolber <chuckwolber@gmail.com>
Cc: alex.kanavin@gmail.com, bitbake-devel@lists.openembedded.org, 
 "eric.meyers@arthrex.com"
	 <eric.meyers@arthrex.com>
Date: Mon, 03 Feb 2025 17:41:16 +0000
In-Reply-To: <CA+cKJ+HRxtWLSehYjUc6rLS18xxp2C_kvq8Tx_vJ_FvuxdTPXw@mail.gmail.com>
References: <20250127142918.163-1-eric.meyers@arthrex.com>
	 <CANNYZj-d4EXpM30v+DgY6p=3NjVZG7ThKTBTPSGX70CXh+rjPA@mail.gmail.com>
	 <CA+cKJ+HEK9d-tvf-Srz=NwHCrkyikb-ws1u8Bn9kD--EiDF5zQ@mail.gmail.com>
	 <CANNYZj8jjBpFrix4mwYG2SJ1JuvX6MHSmvcrO70WNmuEs=x0rQ@mail.gmail.com>
	 <CAB=6tBR1y2Xzpy0MK1uW2TLV7O1opcW_UP_LGd-t=yYg+SAL2Q@mail.gmail.com>
	 <CA+cKJ+HRxtWLSehYjUc6rLS18xxp2C_kvq8Tx_vJ_FvuxdTPXw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 03 Feb 2025 17:41:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17127

On Mon, 2025-02-03 at 09:33 -0600, Eric Meyers via
lists.openembedded.org wrote:
> On Mon, Jan 27, 2025 at 3:06=E2=80=AFPM Chuck Wolber <chuckwolber@gmail.c=
om>
> wrote:
> >=20
> >=20
> >=20
> > On Mon, Jan 27, 2025 at 10:01=E2=80=AFAM Alexander Kanavin via
> > lists.openembedded.org
> > <alex.kanavin=3Dgmail.com@lists.openembedded.org> wrote:
> > >=20
> > > On Mon, 27 Jan 2025 at 16:44, Eric Meyers
> > > <eric.meyers15310@gmail.com> wrote:
> > > > Are you suggesting that instead of username=3D and password=3D
> > > > parameters
> > > > in the npm/npmsw SRC_URI, it should be an "npmrc" parameter
> > > > that
> > > > effectively the user can point to the location of their .npmrc
> > > > file
> > > > for authentication on an NPM registry? Then, within a user's
> > > > associated recipe, they would need to create the npmrc file in
> > > > a
> > > > do_fetch:prepend() step that that corresponds to the path
> > > > passed into
> > > > the SRC_URI?
> > >=20
> > > The only acceptable solution would be one that takes passwords
> > > written
> > > in plain text out of layers and local.conf altogether. And the
> > > way to
> > > do it is to write these things into ~/.npmrc and ~/.netrc in a
> > > secure
> > > manner (e.g. pass in to users via encrypted email with
> > > instructions
> > > that the file must not be readable by anyone but the user), and
> > > ensure
> > > that npm and wget are able to pick them up from those files (wget
> > > does
> > > this already, npm I'm not sure).
> >=20
> >=20
> > Could this also be solved by letting the end user decide, sort of
> > like the way FETCHCMD_*
> > works?
> >=20
> > A CREDENTIALCMD_npm variable in local.conf could be saddled with
> > exporting the
> > namespace, password, and username values into whatever environment
> > needs them in a
> > "Just in Time" fashion to lower (but not completely eliminate)
> > exposure.
> >=20
> > An identity agent, like the 1P or vault CLI would be an obvious
> > choice here, but one could
> > just as easily tie it to a script that devolves down to looking in
> > ~/.npmrc if they wanted to.
> >=20
> > ..Ch:W..
> >=20
> > --
> > "Perfection must be reached by degrees; she requires the slow hand
> > of time." - Voltaire
>=20
> Last week I had off, so I'm just getting around to addressing these
> comments this week. Chuck's suggestion is interesting and I will
> definitely consider it. So this amounts to two potential paths
> forward
> for this issue (1 by Alex and 1 by Chuck):
>=20
> 1. Take a similar approach to how the wget fetcher uses default netrc
> credentials within the user's home directory and use default
> credentials populated by the user within an npmrc file in their home
> directory.
> =C2=A0=C2=A0=C2=A0 - Pros: Moves away from specifying username/password i=
n recipe,
> using precedent set in wget fetcher, potentially less changes in
> fetcher (no parameter additions, no creation of npmrc file, etc)
> =C2=A0=C2=A0=C2=A0 - Cons: Currently, the wget fetcher relies on default =
behavior of
> "netrc" python library - there is no analogous "npmrc" python library
> and we would need to add logic to check this file manually (shouldn't
> be too difficult but still would need to rework current NPM
> environment behavior in the fetcher). Might pose challenges in CI/CD
> environments where these files need to now be created if using
> private
> registries (again should be easy enough).
>=20
> 2. Take a similar approach to how FETCHCMD_npm is used and specify
> another variable named "FETCHCREDENTIALCMD_npm" that allows the user
> to point to a specific npmrc file to use in their environment.
> =C2=A0=C2=A0=C2=A0 - Pros: Moves away from specifying username/password i=
n recipe
> =C2=A0=C2=A0=C2=A0 - Cons: Adding another variable to bitbake, lowers (bu=
t doesn't
> completely eliminate) credential exposure, might require more support
> within recipetool within poky
>=20
> I am going to take a stab at reworking this patch to match approach
> #1
> outlined above, but if any hiccups come up, I'll post issues here and
> re-evaluate using another approach (potentially #2 above). #1 feels
> like it will be easier to implement and more straightforward than #2,
> but perhaps I'm missing something.

FWIW I think this is the right thing to do and #1 matches what we've
done elsewhere.

Having watched what happens in the real world with passwords in urls,
we really don't want to support that.

Cheers,

Richard

