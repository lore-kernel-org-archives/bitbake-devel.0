Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33615C02192
	for <webhook@archiver.kernel.org>; Mon,  3 Feb 2025 17:42:52 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web11.94140.1738604562379064569
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 03 Feb 2025 09:42:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=JjyYn5zl;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4361f664af5so55062235e9.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 03 Feb 2025 09:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1738604561; x=1739209361; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oyxz1IgrCFSujkpUE4vdkK2KvAo6+6RjKnBazYed/UI=;
        b=JjyYn5zlFixea0ILdfq6C6SDeGlNwKg1vK5psJ2ASxFLNwGrvBjyLv9Limoz5ow0PG
         tt/Cl92JFZTjPct6sx0Rly0lHKLxLpDO/STQbBRzFVRZix/G1uUv16zJ1VlavgZz8FFD
         zZPYF+xPoJzulcx37cy+9Vm90GPz1Yu4PuX8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738604561; x=1739209361;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Oyxz1IgrCFSujkpUE4vdkK2KvAo6+6RjKnBazYed/UI=;
        b=FhBYUZhpLLnQ6OR+hBu2uSpLXBShvQGBLRb9tNI1w9eTQ5omQz7CKUrmM8S9GUUuxo
         lI3275m9vWKigVUPqAT6NazS2i1A2608D3gV0aYsKjv9WmUcctiFtmKhFZVpK4s4onSs
         xSSWLtTxFmA3aTCOEhfJ9EaphhqwRdsuPe4IZko8BHHUMB4DMf81jyuCUkUHciUeeBX5
         FEDyAVfJxnhtCcxw8Scxosc/3o+kYdwmJroSUWh+7bf+eaMMcGhy5RLrV83QMlbhhbYj
         HCnczHbLZDD83Ht5ALeLXXDDtMy1laYO7DoUn/xxfTvdktiKkgRmMHHFtPJ2AjIjq3p7
         cT5w==
X-Forwarded-Encrypted: i=1; AJvYcCWgwPjQUdkNKhFD+peOahitdnpNCMgbwavh4ssEj2j+qnNp1VOHdy8X6O6NmGxCx0AqZgobK20npMGXlGyo@lists.openembedded.org
X-Gm-Message-State: AOJu0YycSmT/lmzdZv6wZAU35zgI9n67P3HU0M/kRUrRtAa8qWR4ldsA
	uqojnKIPyw6M+wzvGRRmFdmZbjqe/l2/8ND7+M3716Yb8sM5yPf5jr9vaQdG3sFrRrAzU3fbGFm
	C
X-Gm-Gg: ASbGncsW7IfI0UXs+NSVbZx4+tBy3JBNQSKSNdQha25rrWY33dAFdTvap6f6qEM6b47
	WYugcwt0cG+F2bnSccBAlA2Y3HXQscMrFgAp+eMIBQ64zV0EXkBuuyY8DM1fsjFAPCMLY4qc1kt
	owV4YFZaSUkn1KpsaqP1Y3wgN0V1X1EQVE+Yd671ZCaP6LIMTBEMoFQWylURT08s4L9PMd67WUT
	PvZ8+GDDnFbbt+ezoItxWdW7QrpUrtgfSfj2Jlff5S77egsgCMJwd2GIu9EJvSHURRYhv4OPIQi
	CZE1StsI7eaBg3B75bLdLv18/3BgOVDNqbV3kyysAlJEdQM99Oh/KcDL+j2K1I8JkzMRmtwnyAT
	DZ6Y0
X-Google-Smtp-Source: AGHT+IFrjC8uI9E70Jys/SiHiJCnh89S8QRd70+UaRqgKOuWwQToic5dMEFTjrMo/5LxenjhtovFjQ==
X-Received: by 2002:a5d:6503:0:b0:38b:da34:5915 with SMTP id ffacd0b85a97d-38c5195fd72mr15401238f8f.23.1738604560719;
        Mon, 03 Feb 2025 09:42:40 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:41c1:3919:865f:692c? ([2001:8b0:aba:5f3c:41c1:3919:865f:692c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c11b58esm13104191f8f.42.2025.02.03.09.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 09:42:40 -0800 (PST)
Message-ID: <7b451077afdb98d825d060ae3e1c05654c82a731.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] parse: Forbid ambiguous assignments to
 ${.}, ${+}, and ${:} variables
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: peter.kjellerstedt@axis.com, "n.merinov@inango-systems.com"
	 <n.merinov@inango-systems.com>, "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Mon, 03 Feb 2025 17:42:39 +0000
In-Reply-To: <DB5PR02MB10213AFB411A607B11EAB0B62EFE82@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20250129185531.3752682-1-n.merinov@inango-systems.com>
	 <DB5PR02MB10213AFB411A607B11EAB0B62EFE82@DB5PR02MB10213.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 03 Feb 2025 17:42:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17128

On Fri, 2025-01-31 at 20:40 +0000, Peter Kjellerstedt via lists.openembedde=
d.org wrote:
> > -----Original Message-----
> > From: bitbake-devel@lists.openembedded.org=C2=A0<bitbake-devel@lists.op=
enembedded.org> On Behalf Of Nikolay Merinov via lists.openembedded.org
> > Sent: den 29 januari 2025 19:56
> > To: bitbake-devel@lists.openembedded.org
> > Cc: Nikolai Merinov <n.merinov@inango-systems.com>
> > Subject: [bitbake-devel] [PATCH] parse: Forbid ambiguous assignments to=
 ${.}, ${+}, and ${:} variables
> >=20
> > Old code that parse variable names in assignment commands behave differ=
ntly for
>=20
> differntly -> differently=20
>=20
> > variables that ends with special symbol for single-character variable n=
ames and
> > multi-character variable names. For example:
> >=20
> > =C2=A0 A+=3D"1"=C2=A0=C2=A0 # Change variable ${A}, '+' glued to '=3D'
> > =C2=A0 A+ =3D "1" # Change variable ${A+}
> >=20
> > =C2=A0 +=3D"1"=C2=A0=C2=A0=C2=A0 # Change variable ${+}, the '+' symbol=
 not part of assignment operator
> > =C2=A0 + =3D "1"=C2=A0 # Change variable ${+}
> >=20
> > New code would always assume that '.=3D', '+=3D', and ':=3D' is assignm=
ent operator.
> > As result code like the following would raise parsing error
> >=20
> > =C2=A0 +=3D"value"
> >=20
> > While code with extra spaces would work as before
> >=20
> > =C2=A0 + =3D "value" # Change variable ${+}
> >=20
> > This change allow to catch issues in code that generate bitbake configu=
ration
> > files in a manner like "echo ${VARNAME}+=3D${VALUE} >> conf/local.conf"
> >=20
> > Signed-off-by: Nikolai Merinov <n.merinov@inango-systems.com>
> > ---
> > =C2=A0lib/bb/parse/parse_py/ConfHandler.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> > =C2=A0lib/toaster/toastermain/management/commands/buildimport.py | 2 +-
> > =C2=A02 files changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_=
py/ConfHandler.py
> > index 24f81f7e9..bdac66004 100644
> > --- a/lib/bb/parse/parse_py/ConfHandler.py
> > +++ b/lib/bb/parse/parse_py/ConfHandler.py
> > @@ -20,7 +20,7 @@ from bb.parse import ParseError, resolve_file, ast, l=
ogger, handle
> > =C2=A0__config_regexp__=C2=A0 =3D re.compile( r"""
> > =C2=A0=C2=A0=C2=A0=C2=A0 ^
> > =C2=A0=C2=A0=C2=A0=C2=A0 (?P<exp>export\s+)?
> > -=C2=A0=C2=A0=C2=A0 (?P<var>[a-zA-Z0-9\-_+.${}/~:]+?)
> > +=C2=A0=C2=A0=C2=A0 (?P<var>([a-zA-Z0-9\-_${}/~] | [+.:](?!=3D))+?)
> > =C2=A0=C2=A0=C2=A0=C2=A0 (\[(?P<flag>[a-zA-Z0-9\-_+.][a-zA-Z0-9\-_+.@/]=
*)\])?
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 \s* (
> > diff --git a/lib/toaster/toastermain/management/commands/buildimport.py=
 b/lib/toaster/toastermain/management/commands/buildimport.py
> > index f7139aa04..37d27a445 100644
> > --- a/lib/toaster/toastermain/management/commands/buildimport.py
> > +++ b/lib/toaster/toastermain/management/commands/buildimport.py
> > @@ -60,7 +60,7 @@ def _log(msg):
> > =C2=A0__config_regexp__=C2=A0 =3D re.compile( r"""
> > =C2=A0=C2=A0=C2=A0=C2=A0 ^
> > =C2=A0=C2=A0=C2=A0=C2=A0 (?P<exp>export\s+)?
> > -=C2=A0=C2=A0=C2=A0 (?P<var>[a-zA-Z0-9\-_+.${}/~]+?)
> > +=C2=A0=C2=A0=C2=A0 (?P<var>([a-zA-Z0-9\-_${}/~] | [.+](?!=3D))+?)
> > =C2=A0=C2=A0=C2=A0=C2=A0 (\[(?P<flag>[a-zA-Z0-9\-_+.]+)\])?
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 \s* (
> > --
> > 2.34.1
> >=20
>=20
> The above made me ponder on the existence of $, { and } in the regular=
=20
> expression for the variable name and what that can be (ab)used for. I
> realized that it allows you do define really odd variables such as:
>=20
> ${} =3D "foobar"
> } =3D "foobar"
> $ =3D "foobar"
>=20
> And while you cannot access them directly using, e.g., "${$}", you can=
=20
> access them using, e.g., "${@d.getVar('$')"...
>=20
> This also allows defining variables that do not match the syntax at all,=
=20
> e.g.:
>=20
> EQUAL =3D "=3D"
> ${EQUAL} =3D "bar"
>=20
> which will define the variable "=3D" and where "${@d.getVar('=3D')}" then
> returns "bar" as expected...
>=20
> I am not sure this is a problem or working as intended, but it is a bit=
=20
> odd.
>=20

The set/getVar API doesn't really sanity check the variable names so it
is behaving much as I'd have expected. Whether it should be a bit
stricter about variable names is a good question...

Cheers,

Richard


