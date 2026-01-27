Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEF6D2D8E9
	for <webhook@archiver.kernel.org>; Tue, 27 Jan 2026 10:28:58 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7449.1769509728819113655
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Jan 2026 02:28:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=Myjz6xM2;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B06CB1A2A6F;
	Tue, 27 Jan 2026 10:28:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 87393606F5;
	Tue, 27 Jan 2026 10:28:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 13FCF119A8687;
	Tue, 27 Jan 2026 11:28:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769509725; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=wizpf+8QOUkecQxhH84kADxkSW8hsTtfUIQ0Pb9WSI8=;
	b=Myjz6xM2SKT7mSd0S4ACbOYICg7xbuw+aFRvc+if/9eKwzYDT2Gm/MdTmStLZUYKLmd66a
	tAoMFRXuHT3/8Q9PZAXQgRAncbLudpPzKIVqXnMQQ0wVR6M6sU91Ex/X8WJLUL795eBfIj
	f+Z5KMxqO7ohHbtEaHkTd+jOBm1dVQiSk3/y2ETryE+e6c7qTLk9fGjAzs7VIM6QHJncEH
	ZYzT7BkW1I3k6zrZCnF/7XAvqCEORaB88GfF0FlyICjZceMP/yyHQc1KBPLhWbka9B5aV2
	jwSFXjYwCn4ImIuEBScLQcEH7fieCmqRystRpSQo/rQkRy6KS0O48Fh2CM/D7Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Jan 2026 11:28:44 +0100
Message-Id: <DFZAUH3GDEUD.12ABNZRF86B7U@bootlin.com>
Subject: Re: [docs][PATCH 1/5] doc: change some terminology around
 bitbake-setup
Cc: <docs@lists.yoctoproject.org>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <daiane.angolini@foundries.io>, <bitbake-devel@lists.openembedded.org>
References: <20260126222743.411405-1-daiane.angolini@foundries.io>
In-Reply-To: <20260126222743.411405-1-daiane.angolini@foundries.io>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 10:28:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18877

Hi,

On Mon Jan 26, 2026 at 11:27 PM CET, Daiane Angolini via lists.yoctoproject=
.org wrote:
> Change some terms to use more specific wording:
>
>   Generic Configuration  -> BitBake Setup Template
>   Specific Configuration -> BitBake Setup Instance


I think we agreed on naming those:

BitBake Setup Configuration Template
BitBake Setup Configuration Instance

?

Once again, I think it's important that those two terms refer to the JSON f=
iles.
I think adding "configuration" makes it clearer, especially for the "instan=
ce".

Also not sure about prefixing it with "Bitbake Setup". In your book you can
always prefix "Configuration Template/Instance" with "Bitbake Setup", but I
think in this document it clear that's it's related to bitbake-setup.

>   nested configurations  -> Variant
>
> Signed-off-by: Daiane Angolini <daiane.angolini@foundries.io>
> ---
>  .../bitbake-user-manual-environment-setup.rst | 88 +++++++++----------
>  1 file changed, 44 insertions(+), 44 deletions(-)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setu=
p.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> index 3b6a73fd8..824b01ffb 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> @@ -41,8 +41,8 @@ Quick Start
>        $ ./bitbake/bin/bitbake-setup init
> =20
>     This command will ask you to choose which configurations to use avail=
able as
> -   part of the default BitBake :term:`generic configurations <generic
> -   Configuration>`.
> +   part of the default BitBake :term:`BitBake Setup Templates <BitBake S=
etup
> +   Template>`.
> =20
>     .. note::
> =20
> @@ -73,8 +73,8 @@ Quick Start
> =20
>        The name of the directory will vary depending on the choices.
> =20
> -   -  ``config/``: holds the :term:`Specific Configuration`, which embed=
s the
> -      :term:`Generic Configuration` (first choice of the :ref:`ref-bbset=
up-command-init` command)
> +   -  ``config/``: holds the :term:`BitBake Setup Instance`, which embed=
s the
> +      :term:`BitBake Setup Template` (first choice of the :ref:`ref-bbse=
tup-command-init` command)
>        and the choices made during the initialization.
> =20
>     -  ``build/``: the :term:`BitBake Build` directory, where BitBake sto=
res
> @@ -145,12 +145,12 @@ The "Top Directory" and "Setup" directories are def=
ined as follows:
>     :term:`Setup`
>        A Setup is the result of the :ref:`ref-bbsetup-command-init`
>        command, which creates a :term:`Setup` directory. It is constructe=
d from a
> -      :term:`Generic Configuration` and choices made during the ``init``=
 command.
> +      :term:`BitBake Setup Template` and choices made during the ``init`=
` command.
> =20
>        It contains at least:
> =20
>        -  A :term:`BitBake Build` (``build/`` directory).
> -      -  A :term:`Specific Configuration` (``config/`` directory).
> +      -  A :term:`BitBake Setup Instance` (``config/`` directory).
>        -  Sources such as :ref:`layers
>           <bitbake-user-manual/bitbake-user-manual-intro:Layers>` or othe=
r
>           repositories managed by ``bitbake-setup`` (``layers/`` director=
y).
> @@ -173,8 +173,8 @@ The following components are involved to create the c=
ontent of these directories
>        Build` constitute the :ref:`BitBake configuration
>        <bitbake-user-manual/bitbake-user-manual-intro:Configuration Files=
>`.
> =20
> -   :term:`Generic Configuration`
> -      A Generic Configuration is a file in JSON format containing a temp=
late to
> +   :term:`BitBake Setup Template`
> +      A BitBake Setup Template is a file in JSON format containing a tem=
plate to
>        create a :term:`Setup`. These files are used during the :ref:`ref-=
bbsetup-command-init`
>        command as a starting point to configure the :term:`Setup`. When t=
he
>        command runs, the user may be prompted with choices to further spe=
cify the
> @@ -183,42 +183,42 @@ The following components are involved to create the=
 content of these directories
>        It is also possible to specify the choices on the command line for=
 a
>        completely non-interactive initialization.
> =20
> -      :term:`Generic Configuration` files are stored in :term:`registrie=
s
> +      :term:`BitBake Setup Template` files are stored in :term:`registri=
es
>        <Registry>`, and can be listed with the :ref:`ref-bbsetup-command-=
list`
>        command.
> =20
> -      :term:`Generic Configuration` files must end with the ``.conf.json=
``
> +      :term:`BitBake Setup Template` files must end with the ``.conf.jso=
n``
>        suffix for ``bitbake-setup`` to locate them.
> =20
>        .. note::
> =20
> -         The default :term:`Generic Configurations <Generic Configuratio=
n>` are
> +         The default :term:`BitBake Setup Templates <BitBake Setup Templ=
ate>` are
>           located in the BitBake repository in a local registry. the
>           ``default-registry/`` directory. This can be modified with the
>           :ref:`ref-bbsetup-setting-registry` setting.
> =20
>        :ref:`ref-bbsetup-command-status` will tell if a :term:`Setup`
> -      is in sync with the :term:`Generic Configuration` it was construct=
ed from
> +      is in sync with the :term:`BitBake Setup Template` it was construc=
ted from
>        (typically: layer updates).
> =20
>        :ref:`ref-bbsetup-command-update` will bring a :term:`Setup`
> -      in sync with its :term:`Generic Configuration`.
> +      in sync with its :term:`BitBake Setup Template`.
> =20
> -   :term:`Specific Configuration`
> -      The :term:`Specific Configuration` is stored in the ``config/`` di=
rectory
> -      in a :term:`Setup`. It embeds the :term:`Generic Configuration` an=
d the
> +   :term:`BitBake Setup Instance`
> +      The :term:`BitBake Setup Instance` is stored in the ``config/`` di=
rectory
> +      in a :term:`Setup`. It embeds the :term:`BitBake Setup Template` a=
nd the
>        choices made during the initialization.
> =20
> -      It is also a Git repository, that contains a history of the specif=
ic
> -      configuration and updates made to it via :ref:`ref-bbsetup-command=
-update`.
> +      It is also a Git repository, that contains a history of the setup =
instance
> +      and updates made to it via :ref:`ref-bbsetup-command-update`.
> =20
>     :term:`Registry`
> -      A configuration registry is a place where one or more :term:`Gener=
ic
> -      Configurations <Generic Configuration>` are stored.
> +      A configuration registry is a place where one or more :term:`BitBa=
ke
> +      Setup Templates <BitBake Setup Template>` are stored.
> =20
>        The directory structure of the registry can be any: ``bitbake-setu=
p``
>        recursively find files ending with ``.conf.json`` and consider it =
a
> -      :term:`Generic Configuration`.
> +      :term:`BitBake Setup Template`.
> =20
>        The registry location is configured through the
>        :ref:`ref-bbsetup-setting-registry` setting. This location can be =
the URL to
> @@ -279,7 +279,7 @@ The ``bitbake-setup init`` sub-command helps initiali=
zing a :term:`Setup`.
> =20
>  This command can be run without any arguments to prompt the user with
>  configuration options to choose from. These configuration options are ta=
ken from
> -the input :term:`Generic Configuration` files in the :term:`registry`.
> +the input :term:`BitBake Setup Template` files in the :term:`registry`.
> =20
>  .. note::
> =20
> @@ -288,9 +288,9 @@ the input :term:`Generic Configuration` files in the =
:term:`registry`.
> =20
>  Otherwise, the first argument to :ref:`ref-bbsetup-command-init` can be:
> =20
> --  A generic configuration ID in the registry.
> --  A path to a generic configuration file on a local disk.
> --  An HTTP URI to the generic configuration file.
> +-  A BitBake Setup Template ID in the registry.
> +-  A path to a BitBake Setup Template file on a local disk.
> +-  An HTTP URI to the BitBake Setup Template file.
> =20
>  The choices made during the bare ``bitbake-setup init`` command can also=
 be
>  passed directly on the command-line, for example::
> @@ -331,7 +331,7 @@ In addition, the command can take the following argum=
ents:
>  ``bitbake-setup init`` Examples
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> =20
> --  This example prompts the user to choose a :term:`Generic Configuratio=
n` from
> +-  This example prompts the user to choose a :term:`BitBake Setup Templa=
te` from
>     a custom registry:
> =20
>     .. code-block:: shell
> @@ -340,7 +340,7 @@ In addition, the command can take the following argum=
ents:
>            --setting default registry 'git://example.com/bitbake-setup-co=
nfigurations.git;protocol=3Dhttps;branch=3Dmain;rev=3Dmain' \
>            init
> =20
> --  This example takes a :term:`Generic Configuration` from a remote loca=
tion
> +-  This example takes a :term:`BitBake Setup Template` from a remote loc=
ation
>     (here, one of the default configuration in BitBake):
> =20
>     .. code-block:: shell
> @@ -351,7 +351,7 @@ In addition, the command can take the following argum=
ents:
> =20
>     -  A custom :ref:`ref-bbsetup-setting-top-dir-prefix` and :ref:`ref-b=
bsetup-setting-top-dir-name`
>     -  A :term:`source override`, and additionally overriding openembedde=
d-core with a locally managed directory.
> -   -  A standalone :term:`generic configuration` file.
> +   -  A standalone :term:`BitBake Setup Template` file.
>     -  Choices passed on the command-line, applied non-interactively.
> =20
>     .. code-block:: shell
> @@ -371,8 +371,8 @@ In addition, the command can take the following argum=
ents:
>  ``bitbake-setup list``
>  ----------------------
> =20
> -The ``bitbake-setup list`` sub-command lists the available :term:`generi=
c
> -configurations <generic configuration>` in the current :term:`registry`.
> +The ``bitbake-setup list`` sub-command lists the available :term:`BitBak=
e Setup
> +Templates <BitBake Setup Template>` in the current :term:`registry`.
> =20
>  In addition, the command can take the following arguments:
> =20
> @@ -388,8 +388,8 @@ In addition, the command can take the following argum=
ents:
>  ------------------------
> =20
>  The ``bitbake-setup status`` sub-command shows the status of a
> -:term:`Setup`. Any differences between the local copy of the :term:`gene=
ric
> -configuration` and the upstream one are printed on the console.
> +:term:`Setup`. Any differences between the local copy of the :term:`BitB=
ake Setup
> +Template` and the upstream one are printed on the console.
> =20
>  If the BitBake environment is sourced and ready to build, the ``bitbake-=
setup
>  status`` command (without any arguments) will show the status of the cur=
rent
> @@ -407,7 +407,7 @@ In addition, the command can take the following argum=
ents:
>  ------------------------
> =20
>  The ``bitbake-setup update`` sub-command updates a :term:`Setup` to sync=
 with
> -the latest changes from a :term:`generic configuration` it was construct=
ed from.
> +the latest changes from the :term:`BitBake Setup Template` it was constr=
ucted from.
>  The :ref:`ref-bbsetup-command-status` command can be used to show the cu=
rrent
>  status of the :term:`Setup` before updating it.
> =20
> @@ -617,16 +617,16 @@ manner.
> =20
>  The :ref:`ref-bbsetup-setting-use-full-setup-dir-name` setting, if set t=
o ``yes``
>  will override the suggestions for the :term:`Setup` directory name made =
by
> -``setup-dir-name`` entries in :term:`Generic Configuration` files. This
> +``setup-dir-name`` entries in :term:`BitBake Setup Template` files. This
>  will make the directory names longer, but fully specific: they will cont=
ain
>  all selections made during initialization.
> =20
>  .. _ref-bbsetup-section-config-reference:
> =20
> -Generic Configuration Files Reference
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +BitBake Setup Template Files Reference
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I think this is missing some modifications below?

e.g:

"""
-  ``bitbake-setup`` (**required**): contains a list of configurations.
"""

can be turned into

"""
-  ``bitbake-setup`` (**required**): contains a list of :term:`Variants
   <Variant>`.
"""

Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


