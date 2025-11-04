Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B586FCCFA04
	for <webhook@archiver.kernel.org>; Tue,  4 Nov 2025 12:26:12 +0000 (UTC)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16448.1762259163039374986
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Nov 2025 04:26:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Mzyd4MlZ;
 spf=pass (domain: gmail.com, ip: 209.85.160.169, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ecae310df8so86832341cf.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 04 Nov 2025 04:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762259162; x=1762863962; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++6QHVL//aDrxJ6uVvCzjBYqHl02XtUlfEia1OP7TFg=;
        b=Mzyd4MlZVyZdvGeanID2tf3hCQ0cX5YPXV+N3a9lsIPfp1N9DWp3jY0ahzg0omlT6N
         i6RczEuuSc0Wf1dKU8sB8+rON4BFaEGMUjaaTEEZ5eFEyiH9JSjrgsp+cA5qT7aEfTW1
         00wKhoZCgTqUzocXRidCGGlCECfKYWn4Xi1edkGHFOsEcepN68ojsG5cAl0dQROmlDhe
         NHF/Qr7S5VLlIoef/JUlppv1KBVnPt97hyeULC7J8w9OqpnGh+GQGa3WSCYRBQbKtMEK
         PfdxRpCNS5X7/vPzvg2mo+SIowgTpyW+HcY6ZIC164g5lE76qNCYF9y2vYHurFZRaZr3
         kuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762259162; x=1762863962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++6QHVL//aDrxJ6uVvCzjBYqHl02XtUlfEia1OP7TFg=;
        b=pV+44oimr6a7USmMNyiB+N6BxAooKGvajqeo/YxvSsQFnw2APg3S7NzOcuwI28orHV
         PErSJHqFFB7XzNHKV3Y9cUwAIFAu26+mBbInZc6KpYagrSL/peyTMne6cWR9v2U5InjT
         QFnnAHDDfNfcCD6qXZPldQgnV9WadD/LQizjB5X0t1aAje4tyooq+18p6N4OmMGPPjH2
         KEXzaZDkBinIWWTOWgFcAZtokc7b0pR2GVjUl4svo+6mGzq4KKL6nfWLhFRXZEMfOLfQ
         /gwRa2ZEbWEHu9sW+XXAZnWacTuophm+MSWMeYz3SqYbsRmcdzTm44d16tSHvM2gPspC
         cYoQ==
X-Gm-Message-State: AOJu0Yw6tlC+OyMATODCdTPxXfYfc5P+mbF8tcm46z2Df9MkdObMolod
	yujmwtUehFfSYvPzxrSkWjT/GRFF+IDquA7IgaBVqLRMLZznXmP8pXld39LqR0oSUt0wD6xvzHj
	GSIouB/pjbS3Xb2CCJnw33i00NTG9i6jZHA==
X-Gm-Gg: ASbGnctK9u0JjzbSYEnwrkDBU2KUcTDfVOLd31ry8yVndWAVKu4VEyPIsEea46Klke3
	zm4ppkHNC7/8Svj0BkD/Q9H0GhRT1hx32O5bFsz3FlTADOYTIvxpyi7YRc3brEBU/gB7HVp6vYz
	GvOrPglogOZHeSJqAC1Qnpj42L/Wf/PlivOH+Nb1s39Jw7f68h5a3wkJRebhAcoAXEu0NjgN7X8
	gEuX3dujaTe2ohA9CVeg66V0344I/zpg8CWgn8ZH4nSzwLgUDIyVQ46qOWGo0khCb+EDYUPeDxa
	2SQzokrQMzeZwtkLTgI=
X-Google-Smtp-Source: AGHT+IHX5iLieMao67k9kH3HwJ8ZKVb2lE/mQt7xh/bAYg2WW+H661ubcd25kY45OEBdFVXr2tw9O6osNTadnc2Q+dE=
X-Received: by 2002:a05:622a:410c:b0:4e8:947e:16ef with SMTP id
 d75a77b69052e-4ed30defe28mr212117301cf.21.1762259161823; Tue, 04 Nov 2025
 04:26:01 -0800 (PST)
MIME-Version: 1.0
References: <20251103-bitbake-setup-v1-0-635a7c829a4b@bootlin.com> <20251103-bitbake-setup-v1-2-635a7c829a4b@bootlin.com>
In-Reply-To: <20251103-bitbake-setup-v1-2-635a7c829a4b@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 4 Nov 2025 13:25:50 +0100
X-Gm-Features: AWmQ_blHJoRIcV3ODf_IUG84gxTcp0KAWoDsm-5OVEvQpdUWm1S6KFetaZicymw
Message-ID: <CANNYZj8p5zTnzo3AO88_c7Q=qDtO1-QWaFNh+z37xLX4Y1H8Bw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 2/2] Add bitbake-setup documentation
To: antonin.godard@bootlin.com
Cc: bitbake-devel@lists.openembedded.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, docs@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 04 Nov 2025 12:26:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18251

On Mon, 3 Nov 2025 at 17:31, Antonin Godard via lists.openembedded.org
<antonin.godard=3Dbootlin.com@lists.openembedded.org> wrote:
> +   -  ``poky-master-poky-distro_poky-machine_qemux86-64``: a
> +      :term:`Setup`, which is the result of the choices made during
> +      the ``bitbake-setup init`` execution. The name of the directory wi=
ll vary
> +      depending on the choices.

A Setup Directory, which holds a Setup, which is the outcome of the
choices made during...

> +   -  ``config/``: a copy of the upstream :term:`generic configuration` =
used.

Not quite: this holds the specific configuration.

It embeds the generic configuration and adds information about the
choices made during the initialization.
It is also a git repository, that contains a history of the specific
configuration and updates made to it via 'bitbake-setup update'.
(this should probably go to the terminology section)

> +   -  ``layers/``: the directory where :ref:`:ref:`layers
> +      <bitbake-user-manual/bitbake-user-manual-intro:Layers>` are stored=
.

... and updated.

> +      The top directory contains one or more :term:`Setup`.

One or more Setup directories, each of them containing a Setup.

> +   :term:`Setup`
> +      A Setup is the result of the :ref:`ref-bbsetup-command-init`
> +      command. It maps one to one to the JSON data it was constructed fr=
om,
> +      and is the combination of a :term:`Generic Configuration` and choi=
ces made
> +      during the ``init`` command.

There's no one to one mapping anymore, that's from an obsolete earlier
prototype which did not have the 'choose from options' approach.

Better:

It is constructed from a Generic configuration via choices made during...

> +      It contains at least a :ref:`layer
> +      <bitbake-user-manual/bitbake-user-manual-intro:Layers>` checkout, =
a
> +      :term:`BitBake Build`, and a ``config/`` directory holding the ups=
tream
> +      :term:`Generic Configuration` it originates from.

config/ holds a Specific configuration under git-backed version
control. (and see above)

> +The following are involved to create these directories and their content=
s:
> +
> +.. glossary::
> +   :term:`Generic Configuration`
> +      A Generic Configuration is a file in JSON format containing a temp=
late to
> +      create a :term:`Setup`. These files are used during the :ref:`ref-=
bbsetup-command-init`
> +      command as a starting point to configure the :term:`Setup`. When t=
he
> +      command runs, the user may be prompted with choices to further spe=
cify the
> +      :term:`Setup` to create.

It is also possible to specify the choices on the command line for a
completely non-interactivie initialization.

> +      :term:`Generic Configuration` files are stored in :term:`registrie=
s
> +      <Registry>`, and can be listed with the :ref:`ref-bbsetup-command-=
init`
> +      command.
> +
> +      .. note::
> +
> +         The default :term:`Generic Configurations <Generic Configuratio=
n>` are
> +         located in the BitBake repository in a local registry. the
> +         ``default-registry/`` directory. This can be modified with the
> +         :ref:`ref-bbsetup-setting-registry` setting.

A definition for the Specific configuration should be added here perhaps?

> +   :term:`Registry`
> +      A configuration registry is a place where one or more :term:`Gener=
ic
> +      Configurations <Generic Configuration>` are stored.
> +
> +      A registry should have the following structure::
> +
> +         registry/
> +         =E2=94=94=E2=94=80=E2=94=80 configurations/
> +             =E2=94=9C=E2=94=80=E2=94=80 configuration1.conf.json
> +             =E2=94=94=E2=94=80=E2=94=80 configuration2.conf.json

That structure is not enforced at all. Bitbake-setup will do a
complete file tree walk and take anything that ends in .conf.json, so
the directory structure is freeform and up to the registry maintainer.

> +   :term:`Settings`
> +      Settings are operational parameters that are global to all builds =
under a
> +      :term:`Top Directory`, stored in a ``settings.conf`` file. For exa=
mple,

... that are shared between all Setups under...

> +   :term:`Source Override`
> +      A source override is a JSON file that can be used to modify revisi=
ons and
> +      origins of layers that need to be checked out into a :term:`Setup`=
 (for
> +      example when the master branches need to be changed to master-next=
 for
> +      the purpose of testing).

... or to set up a CI pipeline that tests code in a pull request that
comes from a developer's repo and branch.

> +-  ``--build-dir-name``: can be used to configure the name of the :term:=
`Setup`
> +   directory.

--setup-dir-name

> +In addition, the command can take the following arguments:
> +
> +-  ``--with-expired``: list the expired configuration.

... list the expired configurations, such as older Yocto releases that
have already reached their EOL dates.

> +If the BitBake environment is sourced and ready to build, the ``bitbake-=
setup
> +status`` command (without any arguments) will show the status of the cur=
rent
> +:term:`Setup`.
> +
> +In addition, the command can take the following arguments:
> +
> +-  ``--build-dir``: path to the :term:`Setup` to check to status for. No=
t
> +   required if :term:`BBPATH` is already configured.

--setup-dir, not required if the command is invoked from an
initialized bitbake environment that contains BBPATH.

> +.. _ref-bbsetup-command-update:
> +
> +``bitbake-setup update``
> +------------------------
> +
> +The ``bitbake-setup update`` sub-command updates a :term:`Setup` to sync=
 with
> +the latest changes from a :term:`generic configuration` it was construct=
ed from.
> +The :ref:`ref-bbsetup-command-status` command can be used to show the cu=
rrent
> +status of the :term:`Setup`.
> +
> +In addition, the command can take the following arguments:
> +
> +-  ``--build-dir``: path to the :term:`Setup` to check to status for. No=
t
> +   required if :term:`BBPATH` is already configured.

Same as above.

> +.. _ref-bbsetup-command-install-buildtools:
> +
> +``bitbake-setup install-buildtools``
> +------------------------------------
> +
> +The ``bitbake-setup install-buildtools`` sub-command installs and extrac=
ts a
> +buildtools tarball into the specified :term:`Setup`. If the BitBake envi=
ronment
> +is sourced and ready to build, the ``bitbake-setup status`` command (wit=
hout any
> +arguments) will show the status of the current :term:`Setup`.

Erroneous copy-paste?

Also add:

The purpose of buildtools tarball is to provide tools needed to run
bitbake on build machines where such tools cannot be easily obtained
from the host Linux distribution (for example on older distrubution
versions that do not contain a recent enough gcc compiler or python
interpreter, or machines where the user running bitbake cannot easily
install additional software into the system). This command requires
that Openembedded-core layer is present in a configuration. Please see
'link to buildtools section in ref-manual/system-requirements' for
further information,

> +#. Command-line settings, depending on the command and settings name.

Probably mention that this is done with the --setting option?

> +``top-dir-prefix``
> +------------------
> +
> +The :ref:`ref-bbsetup-setting-top-dir-prefix` setting helps configuring =
the
> +leftmost part of the path to the :term:`Top Directory`.
> +
> +For example, with:
> +
> +.. code-block:: ini
> +
> +   [default]
> +   top-dir-prefix =3D /path/to/workspace
> +
> +The :term:`top directory` would be ``/path/to/workspace/<top-dir-name>``=
 with
> +the ``<top-dir-name>`` corresponding to the :ref:`ref-bbsetup-setting-to=
p-dir-name`
> +setting.

This is most useful on systems where the default location of
~/bitbake-builds is not suitable, and there is a dedicated directory
for yocto builds somewhere else.

> +``dl-dir``
> +----------
> +
> +The :ref:`ref-bbsetup-setting-dl-dir` setting set the location of source=
s
> +``bitbake-setup`` will download when configuring a :term:`Setup`.
> +
> +This includes the registry (if the registry is stored remotely) or layer=
s.

This is the location for the download cache that bitbake-setup will
configure for the purpose of downloading configuration repositories
and layers using bitbake fetchers. Please see 'link to
user-manual-fetching', 'link to ref-variables-DL-DIR' for further
information. The location can be set such that it is shared with
DL_DIR specified by bitbake builds, so that there is a single
directory containing a copy of everything needed to set up and run a
bitbake build offline in a reproducible manner.

> +.. _ref-bbsetup-section-config-reference:
> +
> +Generic Configuration Files Reference
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +:term:`Generic Configurations <Generic Configuration>` are the input fil=
es given
> +to ``bitbake-setup`` to configure :term:`Setups <Setup>`.
> +
> +These files are written in the JSON file format and are stored in a
> +:term:`Registry`. They contains three main sections:

They can also be standalone files, with a local path or a URI to them
specified on the command line: 'bitbake-setup init
/path/to/config.conf.json'.

> +   -  ``rev`` (**required**): the revision to checkout. Can be the name =
of the
> +      branch to checkout on the latest revision of the specified ``branc=
h``.

If the value is matching the branch name, bitbake-setup will check out
the latest revion on that branch, and keep it updated when using the
'update' sub-command.

> +   -  ``configurations``: Configurations can contain as many sub-configu=
rations
> +      as needed. This will create more choices when running the
> +      :ref:`ref-bbsetup-command-init` command.

... can recursively contain as many nested...

The purpose of such nesting is to be able to scale the configurations,
for example when there is a need to create multiple configurations
that share some parameters (which are specified in their common
parent), but differ between themselves in other parameters.
Bitbake-setup will assemble configuration choices by putting together
information from a leaf configuration and all of its ancestors.

> +   -  ``bb-env-passthrough-additions`` (*optional*): List of environment
> +      variables to include in :term:`BB_ENV_PASSTHROUGH_ADDITIONS`.
> +
> +   -  ``bb-layers`` (*optional*): Layers to add to the ``bblayers.conf``=
 file.
> +      This cannot be used in conjunction with the ``oe-template`` option=
.

... where bblayers.conf comes from a template itself.

> +   -  ``oe-template`` (*optional*, OpenEmbedded specific): OpenEmbedded =
template
> +      to use. This cannot be used in conjunction with the ``bb-layers`` =
option.

... as it already provides a ready bblayers.conf file to use.

> +   -  ``oe-fragments-one-of`` (*optional*, OpenEmbedded specific): the O=
penEmbedded
> +      fragments to select as part of the build.
> +
> +      This will trigger choices to make during the
> +      :ref:`ref-bbsetup-command-init` command execution.
> +
> +      See https://docs.yoctoproject.org/dev/ref-manual/fragments.html fo=
r
> +      more information of OpenEmbedded configuration fragments.
> +
> +   -  ``oe-fragments`` (*optional*, OpenEmbedded specific): fragments to=
 select
> +      as part of the build.
> +
> +      See https://docs.yoctoproject.org/dev/ref-manual/fragments.html fo=
r
> +      more information of OpenEmbedded configuration fragments.

Yay, the work to document fragments paid off here :)

> +Source Overrides
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +A source override is a file that can be used to override some of the
> +sources definition of a :term:`Generic Configuration` file.

Probably this instead should refer to the definition in terminology above?

Otherwise, fantastic work!

Alex

