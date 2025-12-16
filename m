Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DEDD5C0F3
	for <webhook@archiver.kernel.org>; Tue, 16 Dec 2025 08:53:34 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17863.1765875202849992253
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Dec 2025 00:53:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=wineIQaV;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 172C1C19D31;
	Tue, 16 Dec 2025 08:52:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 817116071C;
	Tue, 16 Dec 2025 08:53:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C5E25119431F1;
	Tue, 16 Dec 2025 09:53:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1765875200; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=cg6HL7yjlTpI6jERmF1gZ8WI46pU7Sxee8bSfrsY0HE=;
	b=wineIQaVGTFIx2xZjaav/g0Duglg3rdppMQ0xa+gBpSOO/xGHunndGAh8wXPJ04Wjnxdlh
	KnuoLLEUW4+6kkkM+YAPEXhBrNPAI50fnnoZLAAWYtH2spa00ZvBJbuJ/+d3IRiFSq5m15
	AbmwDEpE2UoSFE46tjjUqG1B/q7I8LCk2GCmT/RoTpPjVSznpHlEG9psvo4fN7m5TAdZl5
	dN2wuQd4GbutSDbCOzBzSQQgmERPsQ6MHqPYM4hDoHGpd8VFLaDovMoGTV4yO5aM/6jMoS
	E0kmUOMOa6+hj7ST7QJ+aRga/vPlgd9QMJxcDC7ZnQQvXr2CnpLGGQPZBxofVQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Dec 2025 09:53:18 +0100
Message-Id: <DEZIIIY0ZK6I.1UC32EXJJYUW@bootlin.com>
Subject: Re: [PATCH v2 4/5] bitbake-setup: implement symlinking local
 sources into builds
Cc: <paul@pbarker.dev>, "Alexander Kanavin" <alex@linutronix.de>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: "Alexander Kanavin" <alex.kanavin@gmail.com>,
 <bitbake-devel@lists.openembedded.org>
References: <20251215125127.2660714-1-alex.kanavin@gmail.com>
 <20251215125127.2660714-4-alex.kanavin@gmail.com>
In-Reply-To: <20251215125127.2660714-4-alex.kanavin@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Dec 2025 08:53:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18600

Hi,

On Mon Dec 15, 2025 at 1:51 PM CET, Alexander Kanavin wrote:
[...]
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setu=
p.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> index 12b29241f..35aa43f9b 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> @@ -317,6 +317,17 @@ In addition, the command can take the following argu=
ments:
>  -  ``--skip-selection``: can be used to skip some of the choices
>     (which may result in an incomplete :term:`Setup`!)
> =20
> +-  ``-L`` or ``--use-local-source``: instead of getting a source as pres=
cribed in
> +   a configuration, symlink it into a :term:`Setup` from a path on local=
 disk. This
> +   is useful for local development where that particular source director=
y is managed
> +   separately, and bitbake-setup will include it in a build but will not=
 otherwise
> +   touch or modify it. This option can be specified multiple times to sp=
ecify multiple
> +   local sources.
> +
> +   The option can be seen as a command line shortcut to providing an ove=
rride file
> +   with a ``local`` source in it. See the :ref:`ref-bbsetup-source-overr=
ides` section
> +   for more information on source overrides.
> +
>  ``bitbake-setup init`` Examples
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> =20
> @@ -339,7 +350,7 @@ In addition, the command can take the following argum=
ents:
>  -  This example initializes a :term:`Setup` with:=20
> =20
>     -  A custom :ref:`ref-bbsetup-setting-top-dir-prefix` and :ref:`ref-b=
bsetup-setting-top-dir-name`
> -   -  A :term:`source override`.
> +   -  A :term:`source override`, and additionally overriding openembedde=
d-core with a locally managed directory.
>     -  A standalone :term:`generic configuration` file.
>     -  Choices passed on the command-line, applied non-interactively.
> =20
> @@ -351,6 +362,7 @@ In addition, the command can take the following argum=
ents:
>            init \
>            --non-interactive \
>            --source-overrides develop-branch.json \
> +          -L openembedded-core ~/development/openembedded-core-gadget \
>            ./gadget_master.conf.json \
>            gadget distro/gadget machine/gadget
> =20
> @@ -649,7 +661,8 @@ They contain the following sections:
>            "description": "OpenEmbedded - 'nodistro' basic configuration"
>        }
> =20
> --  ``sources`` (*optional*): Git repositories to fetch.
> +-  ``sources`` (*optional*): sources, such as git repositories that shou=
ld be provided
> +   under ``layers/`` directory of a :term:`Setup`.
> =20
>     Example:
> =20
> @@ -669,28 +682,51 @@ They contain the following sections:
>                       "rev": "master"
>                   },
>                   "path": "bitbake"
> +             },
> +             "openembedded-core": {
> +                 "local": {
> +                     "path": "~/path/to/local/openembedded-core"
> +                 }
>               }
>           }
>        }
> =20
>     Sources can be specified with the following options:
> =20
> -   -  ``uri`` (**required**): a URI that follows the git URI syntax.
> -      See https://git-scm.com/docs/git-clone#_git_urls for more informat=
ion.
> +   -  ``path`` (*optional*): where the source is extracted, relative to =
the
> +      ``layers/`` directory of a :term:`Setup`. If unspecified, the name=
 of the
> +      source is used.
> =20
> -   -  ``rev`` (**required**): the revision to checkout. Can be the name =
of the
> -      branch to checkout on the latest revision of the specified ``branc=
h``.
> +   -  ``git-remote`` (*optional*): specifies URI, branch and revision of=
 a git
> +      repository to fetch from.
> =20
> -      If the value is the branch name, ``bitbake-setup`` will check out =
the
> -      latest revision on that branch, and keep it updated when using the
> -      :ref:`ref-bbsetup-command-update` command.
> +      ``git-remote`` entries are specified with the following options:
> =20
> -   -  ``branch`` (**required**): the Git branch, used to check that the
> -      specified ``rev`` is indeed on that branch.
> +      -  ``uri`` (**required**): a URI that follows the git URI syntax.
> +         See https://git-scm.com/docs/git-clone#_git_urls for more infor=
mation.
> =20
> -   -  ``path`` (*optional*): where the source is extracted, relative to =
the
> -      ``layers/`` directory of a :term:`Setup`. If unspecified, the name=
 of the
> -      source is used.
> +      -  ``rev`` (**required**): the revision to checkout. Can be the na=
me of the
> +         branch to checkout on the latest revision of the specified ``br=
anch``.
> +
> +         If the value is the branch name, ``bitbake-setup`` will check o=
ut the
> +         latest revision on that branch, and keep it updated when using =
the
> +         :ref:`ref-bbsetup-command-update` command.
> +
> +      -  ``branch`` (**required**): the Git branch, used to check that t=
he
> +         specified ``rev`` is indeed on that branch.
> +
> +   -  ``local`` (*optional*): specifies a path on local disk that should=
 be symlinked
> +      to under ``layers/``. This is useful for local development, where =
some layer
> +      or other component used in a build is managed separately, but shou=
ld still be
> +      available for bitbake-setup driven builds.
> +
> +      ``local`` entries are specified with the following options:
> +
> +      -  ``path`` (**required**): the path on local disk where the exter=
nally
> +         managed source tree is. ``~`` and ``~user`` are expanded to tha=
t user's home
> +         directory. Paths in configuration files must be absolute (after=
 possible
> +         ~ expansion), paths in override files can be relative to the di=
rectory where
> +         the override file is.
> =20
>  -  ``expires`` (*optional*): Expiration date of the configuration. This =
date
>     should be in :wikipedia:`ISO 8601 <ISO_8601>` format (``YYYY-MM-DDTHH=
:MM:SS``).
> @@ -868,7 +904,7 @@ The ``--source-overrides`` option can be passed multi=
ple times, in which case th
>  overrides are applied in the order specified in the command-line.
> =20
>  Here is an example file that overrides the branch of the BitBake reposit=
ory to
> -"master-next":
> +"master-next", and provides openembedded-core as a symlink to a path on =
local disk:
> =20
>  .. code-block:: json
> =20
> @@ -885,6 +921,11 @@ Here is an example file that overrides the branch of=
 the BitBake repository to
>                     },
>                     "rev": "master-next"
>                 }
> +           },
> +           "openembedded-core": {
> +               "local": {
> +                   "path": "~/path/to/local/openembedded-core"
> +               }
>             }
>         },
>         "version": "1.0"

Documentation looks good to me, thank you

Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


