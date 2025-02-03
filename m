Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DDAC02192
	for <webhook@archiver.kernel.org>; Mon,  3 Feb 2025 17:39:22 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web11.94043.1738604357269660057
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 03 Feb 2025 09:39:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ee8J0hlN;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38da586ef14so4420f8f.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 03 Feb 2025 09:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1738604356; x=1739209156; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGFlcJQF4opFaTzXevZ9nLYYbHjByevfRuCvneDcDiI=;
        b=ee8J0hlNzSny3nXfrNHmqFQQLzRiz9R8Rvm/BkkRG2skfDqVBsy0FTcokQY5QNPYJp
         wJGq9eglR7n0h1i2PmVG5KuybhuyOWLNI/HgC3tilxc+hlteJlEb/4O5hu5jcv40eC01
         ALyztk3HEJUcpDqsX/3kpfa4oO3xF2wsEXy/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738604356; x=1739209156;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tGFlcJQF4opFaTzXevZ9nLYYbHjByevfRuCvneDcDiI=;
        b=QWh6FTt5zV7emuLWf3hY69+1hxSPFqXkclyc2EhVOfehSwozamdHdKdPGDckN0RBiC
         wh6wFU5eoMUlQk25PQjWDFHnSwaCTR8Ii4KwS8twt5Bl9iIgciPPY+GW+ZJqSJAXOp55
         rhGcy9Mcq8YLtitseuK4XZ9TGzkj9vVNDJFCQEfX6B4Mv0g4kILeDlUuJfq8+WU6OIAb
         jJnCB6T8WLaaHQmdujXaSx6XQfJlacS6Kb4GGJ7E7vSLZg/iwRSCHKAeXBd1Oyyl/FQ+
         0mugiBDrKDE68vWFKfrFAO3R9En2erdE/zRkMuLB56+paImLkSihYsbccFJwm5qFH+qw
         1AHg==
X-Forwarded-Encrypted: i=1; AJvYcCULlMn6IDeCQtgpY86GCxsu8HZt7WqxUqVQLYPmZc4AKBkc7RPBp1IZsIwqBWtSZJOivjAnLAucDE2NQDVL@lists.openembedded.org
X-Gm-Message-State: AOJu0Yx3dRrGnTyboLECZAwRB7TsIWeWcMxdLwBjMWqwXsZe5sEm+DKH
	EDcZxGhCcA8xyk1nXvTv8wAS4bCXlVjctHrW30RLtl0pxOZ4JnCr8ye6upPji6baCnJYwJzLyKW
	w
X-Gm-Gg: ASbGncuw0aEslmDncvMLzYbKA5xnoJ9SpHYRKeRE3xCCeDpHIXn6I+02BaSfs/OoJyc
	Sm5ZMUwc3zfVT+pRBrDzmswFVTQ0adrhlJlxG6u+d4fq2eGzxPGSGTqEoBfgFrZJ7LkAoaSCfai
	2H11GuM4POOZFkkM96+L54GGHr/jm8bARZGIL68QfBhdw3XhtKReF9eKlI5ZHK+5iob2AN1N/br
	DX52SocXmw6NPRVcOwwPF91P8Dz2Ful0gyLhagVCT1D62108CTxUY4RIncb4POtegZHhAHnmct7
	Nct61HBS+P5UiNWYgfgneJety4Lc23ETvm7PrAsNSLKG/CnTwdLM2LquShnC/fuCsezlHGvFEvn
	neN49
X-Google-Smtp-Source: AGHT+IHtvCWKdpbknHY2vurpFL3ahpkSOf+25N+ZN2f/qadEaqkocxtdIVKK0mVhCqNE4dLXZ4LT1Q==
X-Received: by 2002:a5d:47c8:0:b0:385:e1a8:e28e with SMTP id ffacd0b85a97d-38c51931ef0mr17643471f8f.10.1738604355645;
        Mon, 03 Feb 2025 09:39:15 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:41c1:3919:865f:692c? ([2001:8b0:aba:5f3c:41c1:3919:865f:692c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438e23d4456sm165806075e9.7.2025.02.03.09.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 09:39:15 -0800 (PST)
Message-ID: <e62b4794a1f77c36cc3be1b2a8e96bf92087461a.camel@linuxfoundation.org>
Subject: Re: [PATCH v2] parse: Forbid ambiguous assignments to ${.}, ${+},
 and ${:} variables
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Nikolai Merinov <n.merinov@inango-systems.com>, 
	bitbake-devel@lists.openembedded.org
Date: Mon, 03 Feb 2025 17:39:14 +0000
In-Reply-To: <20250203164235.1503956-2-n.merinov@inango-systems.com>
References: 
	<fc1891e201b3baaefb86c7c5f27202bc86ac171d.camel@linuxfoundation.org>
	 <20250203164235.1503956-2-n.merinov@inango-systems.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 03 Feb 2025 17:39:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17125

On Mon, 2025-02-03 at 18:42 +0200, Nikolai Merinov wrote:
> Old code that parse variable names in assignment commands behave differen=
tly for
> variables that ends with special symbol for single-character variable nam=
es and
> multi-character variable names. For example:
>=20
> =C2=A0 A+=3D"1"=C2=A0=C2=A0 # Change variable ${A}, '+' glued to '=3D'
> =C2=A0 A+ =3D "1" # Change variable ${A+}
>=20
> =C2=A0 +=3D"1"=C2=A0=C2=A0=C2=A0 # Change variable ${+}, the '+' symbol n=
ot part of assignment operator
> =C2=A0 + =3D "1"=C2=A0 # Change variable ${+}
>=20
> New code would always assume that '.=3D', '+=3D', and ':=3D' is assignmen=
t operator.
> As result code like the following would raise parsing error
>=20
> =C2=A0 +=3D"value"
>=20
> While code with extra spaces would work as before
>=20
> =C2=A0 + =3D "value" # Change variable ${+}
>=20
> This change allow to catch issues in code that generate bitbake configura=
tion
> files in a manner like "echo ${VARNAME}+=3D${VALUE} >> conf/local.conf"
>=20
> Signed-off-by: Nikolai Merinov <n.merinov@inango-systems.com>
> ---
> =C2=A0lib/bb/parse/parse_py/ConfHandler.py |=C2=A0 4 +++-
> =C2=A0lib/bb/tests/parse.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 20 ++++++++++++++++++++
> =C2=A02 files changed, 23 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py=
/ConfHandler.py
> index 24f81f7e9..1bde59725 100644
> --- a/lib/bb/parse/parse_py/ConfHandler.py
> +++ b/lib/bb/parse/parse_py/ConfHandler.py
> @@ -20,7 +20,7 @@ from bb.parse import ParseError, resolve_file, ast, log=
ger, handle
> =C2=A0__config_regexp__=C2=A0 =3D re.compile( r"""
> =C2=A0=C2=A0=C2=A0=C2=A0 ^
> =C2=A0=C2=A0=C2=A0=C2=A0 (?P<exp>export\s+)?
> -=C2=A0=C2=A0=C2=A0 (?P<var>[a-zA-Z0-9\-_+.${}/~:]+?)
> +=C2=A0=C2=A0=C2=A0 (?P<var>[a-zA-Z0-9\-_+.${}/~:]*?)
> =C2=A0=C2=A0=C2=A0=C2=A0 (\[(?P<flag>[a-zA-Z0-9\-_+.][a-zA-Z0-9\-_+.@/]*)=
\])?
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 \s* (
> @@ -166,6 +166,8 @@ def feeder(lineno, s, fn, statements, baseconfig=3DFa=
lse, conffile=3DTrue):
> =C2=A0=C2=A0=C2=A0=C2=A0 m =3D __config_regexp__.match(s)
> =C2=A0=C2=A0=C2=A0=C2=A0 if m:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 groupd =3D m.groupdict()
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if groupd['var'] =3D=3D "":
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raise=
 ParseError("Empty variable name in assignment: '%s'" % s, fn, lineno);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ast.handleData(statement=
s, fn, lineno, groupd)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return
> =C2=A0
> diff --git a/lib/bb/tests/parse.py b/lib/bb/tests/parse.py
> index cb60af364..7598d5904 100644
> --- a/lib/bb/tests/parse.py
> +++ b/lib/bb/tests/parse.py
> @@ -443,3 +443,23 @@ include \\
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 in_file.write("\n".join(lines))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 in_file.flush()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
bb.parse.handle(recipename_closed, bb.data.createCopy(self.d))
> +
> +=C2=A0=C2=A0=C2=A0 special_character_assignment =3D """
> +A+=3D"a"
> +A+ =3D "b"
> ++ =3D "c"
> +"""
> +=C2=A0=C2=A0=C2=A0 ambigous_assignment =3D """
> ++=3D "d"
> +"""
> +=C2=A0=C2=A0=C2=A0 def test_parse_exports(self):
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f =3D self.parsehelper(self.s=
pecial_character_assignment)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d =3D bb.parse.handle(f.name,=
 self.d)['']
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertEqual(d.getVar("A"=
), " a")
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertEqual(d.getVar("A+=
"), "b")
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertEqual(d.getVar("+"=
), "c")
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f =3D self.parsehelper(self.a=
mbigous_assignment)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with self.assertRaises(bb.par=
se.ParseError) as error:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bb.pa=
rse.handle(f.name, self.d)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertIn("Empty variable=
 name in assignment", str(error.exception))

This looks good and I appreciate having tests added, thanks!

The test name needs changing from test_parse_exports though else it
will redefinine one of the other tests.

Cheers,

Richard


