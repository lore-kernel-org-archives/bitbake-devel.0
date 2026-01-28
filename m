Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F4FD3F083
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 15:47:01 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.327.1769615217861591169
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 28 Jan 2026 07:46:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=MF7vFeZt;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id ED2D4C211E8
	for <bitbake-devel@lists.openembedded.org>; Wed, 28 Jan 2026 15:46:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4256C6071F;
	Wed, 28 Jan 2026 15:46:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8A162119A86D4;
	Wed, 28 Jan 2026 16:46:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769615214; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=qwWUoajQ7CkjgBUQtumBjUCQkAgghTYHZJ19uwSaOw4=;
	b=MF7vFeZt6mSLPBtg/agGHsyGMBPtJ0ralx/e6mOcvfUr4WFxHd7rsrPMkD3iPTovzcVK7h
	GQj5ikiXacMPNp0X1EHJCSUP9DRgQBLEIkY9vfALHiatgaqb0iBapLoeZK/pF4kOq7VTsV
	sGLAGIyVmeNKIW/gP8GdNarl1ABAY8AL9SlW5FZQZeTlwphsERvb4ZqcwrmScwbBAJG/Hm
	w5VcHjBSJ4dIAllLE6gdIZLJM8qp0vEMfMEMOhbQF3a5k5dZlHxwDSH1T5RoBuGRDuQe3V
	QyZkDVTdOuVcvKtl5q+CLsKBSmi/r+UB1+dfe1126fwuHTOgGJ7P73eYtu8a0Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Jan 2026 16:46:52 +0100
Message-Id: <DG0C8LN6ZUK1.3ACK0646PJ6FP@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <rob.woolley@windriver.com>, <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v2 02/10] bitbake-setup: Add pypi
 packaging
References: <20260127160508.3392732-1-rob.woolley@windriver.com>
 <20260127160508.3392732-3-rob.woolley@windriver.com>
In-Reply-To: <20260127160508.3392732-3-rob.woolley@windriver.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 28 Jan 2026 15:47:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18919

Hi,

On Tue Jan 27, 2026 at 5:04 PM CET, Rob Woolley via lists.openembedded.org =
wrote:
[...]
> diff --git a/contrib/pypi/README.md b/contrib/pypi/README.md
> new file mode 100644
> index 00000000..a6dd99e0
> --- /dev/null
> +++ b/contrib/pypi/README.md
> @@ -0,0 +1,42 @@
> +# bitbake-setup
> +
> +This package provides the `bitbake-setup` command and the Python modules
> +required to support BitBake setup and configuration.

s/BitBake setup/`bitbake-setup`/

> +
> +## Usage
> +
> +Instructions on uses of bitbake-setup can be found in=20
> +[Setting Up the Environment With bitbake-setup](https://docs.yoctoprojec=
t.org/bitbake/dev/bitbake-user-manual/bitbake-user-manual-environment-setup=
.html) from the Yocto Project manual.

s/Yocto Project Manual/BitBake Manual/

> +
> +List the available configurations;
> +```bash
> +bitbake-setup list
> +```
> +
> +Show the help for the bitbake-setup init subcommand:

s/bitbake-setup/`bitbake-setup`/

> +```bash
> +bitbake-setup init --help
> +usage: bitbake-setup init [-h] [--non-interactive] [--source-overrides S=
OURCE_OVERRIDES] [--setup-dir-name SETUP_DIR_NAME] [--skip-selection SKIP_S=
ELECTION] [-L SOURCE_NAME PATH]
> +                          [config ...]
> +
> +positional arguments:
> +  config                path/URL/id to a configuration file (use 'list' =
command to get available ids), followed by configuration options. Bitbake-s=
etup will ask to choose from available
> +                        choices if command line doesn't completely speci=
fy them.
> +
> +options:
> +  -h, --help            show this help message and exit
> +  --non-interactive     Do not ask to interactively choose from availabl=
e options; if bitbake-setup cannot make a decision it will stop with a fail=
ure.
> +  --source-overrides SOURCE_OVERRIDES
> +                        Override sources information (repositories/revis=
ions) with values from a local json file.
> +  --setup-dir-name SETUP_DIR_NAME
> +                        A custom setup directory name under the top dire=
ctory.
> +  --skip-selection SKIP_SELECTION
> +                        Do not select and set an option/fragment from av=
ailable choices; the resulting bitbake configuration may be incomplete.
> +  -L SOURCE_NAME PATH, --use-local-source SOURCE_NAME PATH
> +                        Symlink local source into a build, instead of ge=
tting it as prescribed by a configuration (useful for local development).
> +```

I would avoid pasting a command output here, it's hard to maintain properly=
.
Just leave `bitbake-setup init --help` is enough.

[...]
> diff --git a/contrib/pypi/pyproject.toml b/contrib/pypi/pyproject.toml
> new file mode 100644
> index 00000000..53d5ffc1
> --- /dev/null
> +++ b/contrib/pypi/pyproject.toml
> @@ -0,0 +1,97 @@
> +[build-system]
> +requires =3D [
> +    "setuptools>=3D64",
> +    "setuptools_scm[toml]>=3D8",
> +]
> +build-backend =3D "setuptools.build_meta"
> +
> +[project]
> +name =3D "bitbake-setup"
> +dynamic =3D ["version"]
> +description =3D "bitbake-setup"
> +readme =3D "README.md"

Wondering if it would be possible to include the
doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst file here
instead of a custom README?

We will likely forget about the above README.md file, and that's one more f=
ile
to maintain. If the README needs to be next to the other file, maybe create=
 a
symlink to bitbake-user-manual-environment-setup.rst?

> +requires-python =3D ">=3D3.9"
> +license =3D "GPL-2.0-only AND MIT"
> +authors =3D [
> +  { name =3D "OpenEmbedded BitBake Developers", email =3D "bitbake-devel=
@lists.openembedded.org" }
> +]
> +classifiers =3D [
> +  "Programming Language :: Python :: 3",
> +  "Operating System :: POSIX :: Linux",
> +]
> +
> +dependencies =3D [
> +  # BitBake is mostly self-contained
> +]
> +
> +[project.optional-dependencies]
> +test =3D [
> +  "pytest>=3D7",
> +]
> +
> +lint =3D [
> +  "ruff>=3D0.3",
> +  "mypy>=3D1.8",
> +]
> +
> +dev =3D [
> +  "nox>=3D2022.11.21",
> +  "pytest>=3D7",
> +  "ruff>=3D0.3",
> +  "mypy>=3D1.8",
> +  "build",
> +  "twine",
> +]
> +
> +[project.scripts]
> +bitbake-setup =3D "bitbake_setup.__main__:main"
> +
> +[project.urls]
> +Homepage =3D "https://git.openembedded.org/bitbake/"
> +Documentation =3D "https://docs.yoctoproject.org/bitbake/dev/bitbake-use=
r-manual/"

Not sure we want to link to the development version of the documentation he=
re.
You could instead link to the latest released documentation:
https://docs.yoctoproject.org/bitbake/bitbake-user-manual/

Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


