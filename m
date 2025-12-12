Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59A5D44144
	for <webhook@archiver.kernel.org>; Fri, 12 Dec 2025 08:11:32 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8368.1765527084401222578
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Dec 2025 00:11:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=fTtAjzGx;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6027F4E41B71;
	Fri, 12 Dec 2025 08:11:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 361EE606DF;
	Fri, 12 Dec 2025 08:11:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DA214103C8CFD;
	Fri, 12 Dec 2025 09:11:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1765527081; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=fOPrZ9uXtHM/CHhfnm43StZ5BVeMNjq0KBJbGO6we0s=;
	b=fTtAjzGxYUinJ1IllOFEiAIK1zVLGtSLB9Gy8q1Y907VNYFyYolYO8kDd7zi1xvA7nKBjp
	9waCYhegaty87oG5rGcpKOLPBrFEmrw7q15GQstFg13GrrPvjphAwEg4X1KS0cVTzDMuUR
	GbezPjC255PhMghYqCM9Ad8XRNraEY/dc9m4TUS/D5122W1Mepc/fP+/WvVzFWnu/FdrmC
	d8EUpzJKSovDbaCBhlFYWT6Oe7MvppYTDhWHRoFHMip4D9B2Bx/8nBGDb4qB0qdFi7zNQu
	B4IfkjNO1/WHYgllx4sjtmJOlxc51ZDb+/PztFRCyCejHK3QJkyrVq1MbxqwuQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Dec 2025 09:11:18 +0100
Message-Id: <DEW346OSAIK5.1JC1QR7QCHUHD@bootlin.com>
Cc: <paul@pbarker.dev>, "Alexander Kanavin" <alex@linutronix.de>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <alex.kanavin@gmail.com>, <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH 4/4] bitbake-setup: implement symlinking
 local sources into builds
References: <20251211142532.983960-1-alex.kanavin@gmail.com>
 <20251211142532.983960-4-alex.kanavin@gmail.com>
In-Reply-To: <20251211142532.983960-4-alex.kanavin@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Dec 2025 08:11:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18572

Hi,

On Thu Dec 11, 2025 at 3:25 PM CET, Alexander Kanavin via lists.openembedde=
d.org wrote:
[...]
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setu=
p.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> index 12b29241f..4d3585f09 100644
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
> +   for more information on source overrides

Missing a period.

> +
>  ``bitbake-setup init`` Examples
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Maybe we could add an example (or extend one) in this section to show how t=
his
new --use-local-source option is used?

> =20
> @@ -649,7 +660,8 @@ They contain the following sections:
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
> @@ -669,12 +681,31 @@ They contain the following sections:
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
> +   -  ``path`` (*optional*): where the source is extracted, relative to =
the
> +      ``layers/`` directory of a :term:`Setup`. If unspecified, the name=
 of the
> +      source is used.
> +
> +   -  ``git-remote`` (*optional*): specifies URI, branch and revision of=
 a git
> +      repository to fetch from.

I'd maybe move git-remote below local and just make one bullet point for th=
e
git-remote description. Because at the moment it appears to be under "local=
".

So like that:

"""
-  ``git-remote`` (*optional*): specifies URI, branch and revision of a git
   repository to fetch from.

   ``git-remote`` entries are specified with the following options:

   -  ``uri`` (**required**): a URI that follows the git URI syntax.
      See https://git-scm.com/docs/git-clone#_git_urls for more information=
.

   ...
"""

> +
> +   -  ``local`` (*optional*): specifies a path on local disk that should=
 be symlinked
> +      to under ``layers\``. This is useful for local development, where =
some layer

Should be "/" instead of "\"

> +      or other component used in a build is managed separately, but shou=
ld still be
> +      available for bitbake-setup driven builds.
> +
> +   ``git-remote`` entries are specified with the following options:
> +
>     -  ``uri`` (**required**): a URI that follows the git URI syntax.
>        See https://git-scm.com/docs/git-clone#_git_urls for more informat=
ion.
> =20
> @@ -688,9 +719,13 @@ They contain the following sections:
>     -  ``branch`` (**required**): the Git branch, used to check that the
>        specified ``rev`` is indeed on that branch.
> =20
> -   -  ``path`` (*optional*): where the source is extracted, relative to =
the
> -      ``layers/`` directory of a :term:`Setup`. If unspecified, the name=
 of the
> -      source is used.
> +   ``local`` entries are specified with the following options:
> +
> +   -  ``path`` (**required**): the path on local disk where the external=
ly
> +      managed source tree is. ``~`` and ``~user`` are expanded to that u=
ser's home
> +      directory. Paths in configuration files must be absolute (after po=
ssible
> +      ~ expansion), paths in override files can be relative to the direc=
tory where
> +      the override file is.

Likewise, I would put this under the description of "local", like git-remot=
e. In
the end it will group and makes things a bit easier to follow IMO.

Otherwise LGTM, thanks for the docs update. :)

Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


