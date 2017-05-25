Return-Path: <kergoth@gmail.com>
Received: from mail-oi0-f41.google.com (mail-oi0-f41.google.com
	[209.85.218.41])
	by mail.openembedded.org (Postfix) with ESMTP id ED2C578130
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 May 2017 15:50:26 +0000 (UTC)
Received: by mail-oi0-f41.google.com with SMTP id h4so284933485oib.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 May 2017 08:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=gg0OFRo9U/8kt7T4K0TAUuOfCRUR8YeVwXuxltwGFi4=;
	b=qLce7MJUVEwboY+l0f67/m1lXX6/CCu4yX8JWSo3Jo5wWOy/dt44uqBVeMsb9vuk/R
	N8d4Vltl6Eb8tXiUMxV7pmZuJYALrhpvZCnsR4tsq/HOY4OIb5of9UBVtp0SN/OnQ/Wj
	cusUCLWTS7IE5cq4unuLqcMwwiaQj28UocXqv4rSvSvZesyGlfFnPjCGRt2tyv4fVHQz
	AxRwOqFcZCr/Y9y0ROK2SiDAvn/ksCImFGw8+ND9Diem5rgbTzzyeCvFhb64p5ggY3y3
	u5K2VQerv4ys9j8dbW8W9IarsdxaU0LH/riDIcpT4AQD6V1h5G+wPkjenLSwfTz1DVTP
	eLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=gg0OFRo9U/8kt7T4K0TAUuOfCRUR8YeVwXuxltwGFi4=;
	b=Y2aIrHwgqwlhZGwWYfxJQ5ytKlL1QCVLBLrV1i2rfo7rJNqHSy+RGe2WbX97vYbCln
	/Z507xVuZdTnGsHLEx4OZTsb8yU2njoq7BbN86a1NYtZlFN4jQ0UUJvVx+g8F/rdu1mt
	8wA+1MzDFIl5FVtR/0/J3gkvbq5r+WCwrdTz+V0EYDyPxnFIefBMiz5K7U0IuMyOmQXR
	MLmRNyexAy/xgLXnAddDCdZqXC+UqHarcqeemYWyhF30qu1sVzj6k6pxYq7nENvZanTV
	C1dtRNsxVM4/znRZ3/CTRkP9WGpGv2y/z9tlgXyr+tk0RsK+wFoubMAS5dVGRcSI3u74
	X0mA==
X-Gm-Message-State: AODbwcDSANFajsCIjvVNtopaJjRyZfB58T6OaU4v+8ir8HwXd6izAAEY
	8IbubsHlgIL2uYiVtunWp77JAaa57w==
X-Received: by 10.202.242.198 with SMTP id q189mr19949516oih.11.1495727427681; 
	Thu, 25 May 2017 08:50:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.30.226 with HTTP; Thu, 25 May 2017 08:50:07 -0700 (PDT)
In-Reply-To: <cf231a157650f22c55ce6861ce824b74b245af55.1495450175.git-series.patrick.ohly@intel.com>
References: <cf231a157650f22c55ce6861ce824b74b245af55.1495450175.git-series.patrick.ohly@intel.com>
From: Christopher Larson <kergoth@gmail.com>
Date: Thu, 25 May 2017 08:50:07 -0700
Message-ID: <CABcZAN=d7BHGOM9602pfbA4N6chDB8b8RDKB4xo6fhCChDx0Rg@mail.gmail.com>
To: Patrick Ohly <patrick.ohly@intel.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] cooker.py: allow dangling bbappends if explicitly whitelisted
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 25 May 2017 15:50:27 -0000
Content-Type: multipart/alternative; boundary="001a114a429a0213eb05505b2e86"

--001a114a429a0213eb05505b2e86
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2017 at 3:50 AM, Patrick Ohly <patrick.ohly@intel.com>
wrote:

> Having a .bbappend without corresponding .bb file triggers an error or
> at least warning, depending on the global BB_DANGLINGAPPENDS_WARNONLY.
>
> Some layers (for example, meta-freescale) avoid that message by only
> adding .bbappends to the BBFILES when the layers they apply to are
> present. Others (like intel-iot-refkit) avoid such .bbappends by
> falling back to global assignments with _pn-<recipe> as override. Both
> is complicated.
>
> Now the warning code checks BBAPPENDS_DANGLING_WHITELIST and ignores
> all bbappends which match a file pattern in that list. This is an
> easier way to have bbappends which may or may not apply to an
> existing recipe.
>

IMHO this makes it too easy to miss legitimate problems. By adding them
only when the layers are present, you ensure that if that layer removes the
recipe you=E2=80=99re appending, you=E2=80=99ll immediately know it. This h=
ides such actual
problems by suppressing for all optional appends across the board.
--=20
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Senior Software Engineer, Mentor Graphics

--001a114a429a0213eb05505b2e86
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Mon, May 22, 2017 at 3:50 AM, Patrick Ohly <span dir=3D"ltr">&lt;<a href=
=3D"mailto:patrick.ohly@intel.com" target=3D"_blank">patrick.ohly@intel.com=
</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D":172" c=
lass=3D"a3s aXjCH m15c2fc7d09d756ec">Having a .bbappend without correspondi=
ng .bb file triggers an error or<br>
at least warning, depending on the global BB_DANGLINGAPPENDS_WARNONLY.<br>
<br>
Some layers (for example, meta-freescale) avoid that message by only<br>
adding .bbappends to the BBFILES when the layers they apply to are<br>
present. Others (like intel-iot-refkit) avoid such .bbappends by<br>
falling back to global assignments with _pn-&lt;recipe&gt; as override. Bot=
h<br>
is complicated.<br>
<br>
Now the warning code checks BBAPPENDS_DANGLING_WHITELIST and ignores<br>
all bbappends which match a file pattern in that list. This is an<br>
easier way to have bbappends which may or may not apply to an<br>
existing recipe.</div></blockquote></div><br>IMHO this makes it too easy to=
 miss legitimate problems. By adding them only when the layers are present,=
 you ensure that if that layer removes the recipe you=E2=80=99re appending,=
 you=E2=80=99ll immediately know it. This hides such actual problems by sup=
pressing for all optional appends across the board.<br>-- <br><div class=3D=
"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div>=
<div dir=3D"ltr">Christopher Larson<br>kergoth at gmail dot com<br>Founder =
- BitBake, OpenEmbedded, OpenZaurus<br>Senior Software Engineer, Mentor Gra=
phics</div></div></div></div>
</div></div>

--001a114a429a0213eb05505b2e86--
