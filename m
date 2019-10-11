Return-Path: <martin.jansa@gmail.com>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by mail.openembedded.org (Postfix) with ESMTP id 8290B7F5C0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 Oct 2019 17:43:48 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id p14so12840671wro.4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 Oct 2019 10:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:date:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=9BNcgLdngeyBbWYik3LmyEUlwN8Z4P1Ocfk2Ru/hOas=;
	b=XAfcJc2J8dATjI1ZjNYtVmAqqJbKdCkA360c07AcVlX1J9oMU1gf9iT1Ce30nQKJy3
	GGtdTmXpM/Tjv8Lzx/pXkJwfZhYOYFEJLPhzIb9brUOgRuQL1ZSptr3+oRh6hWQyqW0b
	54g/t1mEeYU5/H492qcLCCNPCwWzN1r1jN8GzjEqH4ZaI6anB9f7x6hsnGhTEdOgYgL6
	kazJoBHChzP9jiczbOm7zH4dfzvPWSk71IP5Pwaw2oPqB6dAy7TJZH5gdVxpNqYbWVNT
	zwUZMZmZ4gJ15aWkzlk0aIxdomyaEPAm9FP15skfHp+k6NVBbXw3zlojmbFLV7y4KScK
	x+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:date:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=9BNcgLdngeyBbWYik3LmyEUlwN8Z4P1Ocfk2Ru/hOas=;
	b=BM6xMORVTIg7fi0ZqbtcnuFMcBkA5z9lJR76vcDiA885IDMLv0QgKJuvvD3a+EXWS+
	cZrjBV795v1mD+8OI0ZrnOQ31F494DeOfRIh/SR90Bq2TlzlZVlAwWz7KZ2IUZnoRHua
	ebB97rO78Vft7l0JFqccZ08OX9xugEZeKf3eTJGq3VX9eW1mV1udzqU6C24b2q0cLcmS
	INAf+MUxHNf92+jr57AE2mfjahk8DqpWauM8vZ544i/chAtxe/nhBSak7diHXePnmYde
	h5scDhao4+c+MrK6ngmp0WmKZW1v5LdCJWyqE1OgX3HvClhNL3DulDFQyYiGDxxUTm9u
	Zh1A==
X-Gm-Message-State: APjAAAU77It+6h13kN5HU96XBwl/ZvY31UyIReSPLpwF8BzU4qqfO/df
	0p5ppBFhRzYxU0x8tbLDW6rVtnde00M=
X-Google-Smtp-Source: APXvYqzzk6bgBja2L+VuyG2JTUUaTVfeyt3QxCb2TDEdl1ERyG7HzlCEp84y1w7isdnkCAr+n+GZ1w==
X-Received: by 2002:adf:e302:: with SMTP id b2mr13264625wrj.298.1570815829156; 
	Fri, 11 Oct 2019 10:43:49 -0700 (PDT)
Received: from localhost (ip-217-030-068-212.aim-net.cz. [217.30.68.212])
	by smtp.gmail.com with ESMTPSA id
	c18sm10459400wrv.10.2019.10.11.10.43.47
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 11 Oct 2019 10:43:48 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
Date: Fri, 11 Oct 2019 19:43:51 +0200
To: Chris Laplante <chris.laplante@agilent.com>
Message-ID: <20191011174351.GA1563@jama>
References: <cover.1570810590.git.chris.laplante@agilent.com>
MIME-Version: 1.0
In-Reply-To: <cover.1570810590.git.chris.laplante@agilent.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/9] BitBake Vim indentation plugin
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
X-List-Received-Date: Fri, 11 Oct 2019 17:43:48 -0000
X-Groupsio-MsgNum: 10614
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline

--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2019 at 12:22:58PM -0400, Chris Laplante via bitbake-devel =
wrote:
> This patchset adds Vim indentation support for the BitBake language.
>=20
> It supports indenting variable assignments, Python and shell tasks/functi=
ons.
> To accomplish Python indentation, it uses a hacked-up version of the Pyth=
on indenter
> from Vim upstream. The upstream shell indenter is used directly, without
> modification, however in the future it will be necessary to modify the sh=
ell
> indenter to properly support "fakeroot" shell tasks.

Thank you. As vim user I'll test this soon.

Does the above mean that it will use 4 spaces for python and tabs for
shell tasks like oe-core is using?

Would it be possible to simply modify it locally to use 4 spaces for
indentation everywhere like other OE layers are using?

https://www.openembedded.org/wiki/Styleguide#Format_Guidelines

Cheers,

> The following changes since commit 94f6b31befda5c496f65e863a6f8152b42d7eb=
f0:
>=20
>   build-appliance-image: Update to master head revision (2019-10-09 22:28=
:50 +0100)
>=20
> are available in the git repository at:
>=20
>   git://git.yoctoproject.org/poky-contrib cpl/bitbake-vim
>   http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=3Dcpl/bitbake-=
vim
>=20
> Chris Laplante (9):
>   bitbake: contrib/vim: initial commit, with unmodified code from
>     indent/python.vim
>   bitbake: contrib/vim: Modify Python indentation to work with 'python
>     do_task {'
>   bitbake: contrib/vim: More Python indenting; move indent file to
>     correct directory
>   bitbake: contrib/vim: Special handling of bb.fatal
>   bitbake: contrib/vim: don't redeclare indenter
>   bitbake: contrib/vim: renaming & comments
>   bitbake: contrib/vim: indenting for assignments; tweak Python
>     indenting
>   bitbake: contrib/vim: handle shell indenting
>   bitbake: contrib/vim: Add copyright and license notice
>=20
>  bitbake/contrib/vim/indent/bitbake.vim | 342 +++++++++++++++++++++++++++=
++++++
>  1 file changed, 342 insertions(+)
>  create mode 100644 bitbake/contrib/vim/indent/bitbake.vim
>=20
> --
> 2.7.4
>=20
> --=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQRU+ejDffEzV2Je2oc3VSO3ZXaAHAUCXaC/VgAKCRA3VSO3ZXaA
HAjVAJ93y5xi9h5m7nXJiKICIL/lmhk4OgCfSgKbe2gM7sSrlSIoHzs5LywxjBo=
=X7bw
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
