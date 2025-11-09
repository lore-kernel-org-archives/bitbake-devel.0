Return-Path: <adrian.freihofer@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD887CCFA1A
	for <webhook@archiver.kernel.org>; Sun,  9 Nov 2025 15:29:36 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.26716.1762702169942368696
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 09 Nov 2025 07:29:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=l37+PK3y;
 spf=pass (domain: gmail.com, ip: 209.85.128.54, mailfrom: adrian.freihofer@gmail.com)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477549b3082so20145365e9.0
        for <bitbake-devel@lists.openembedded.org>; Sun, 09 Nov 2025 07:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762702168; x=1763306968; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0Ujt4QW5FlK2pbdKiJzkpE/TOkwst4J4mAcT/O8wQvQ=;
        b=l37+PK3y5SGyZRPRieA8Jb8E/GLdqgNcMLqS8Ln63VHXYqEivqrIhXn1RLGLq+eDZf
         KhldziD/16lMw7rzo7QaNmctH/178UUF/Bl+ozq8woGxpL9D5yv9afhrZYkBEsvR9jRQ
         ZUb6DiVPDiqVeqHtukk/62kX9KpoFwGF0WHFSFxYWl1KFwK9ue/5Zf+8oCNRcygIn/J0
         CRLhmb9JYC3Z1X1DulAVVGtLDKBiTs6LEUO5zb8iCUKm8cvVsoVsIkCQqMsjhfH2nzZh
         ydyva5APAaHJHTu36tb4RCsTeZ1f5EQanZ7BEEp/JvCxrNaRF6cIGWR7ePGtXMouHovF
         R30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762702168; x=1763306968;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ujt4QW5FlK2pbdKiJzkpE/TOkwst4J4mAcT/O8wQvQ=;
        b=RFaH71AD277+syzY32gd8JA8AArQZbvCj6C3DM9at5wgpm7yt0tfsNmrRyWgjOKl9K
         IgqDifwEWyx2/FWQ61F17dSdlzAvVwvE/BNjQLgOTdgg6c8sP0mDVGVpnkTGBiI7l7wH
         lnnfzXF8wc8yxiXt7FGFEvJQVdCk/OF/P4vpH8CrYzY3ubWFk7FRPR8RrnabNn7z/BN1
         FZO+YiDRAU/MYAb+8YLvr50ahRTuezCMOJ/eJhidkAPwM++4wSbE3e4wT8/TjbeXLxYA
         GNEm5uKgi6i/m++v3Y08tFrhxb0vdjfHantD8vgvq8umEwOfuZ8Kltyqn7DJ3vGdqMs3
         Bm/w==
X-Forwarded-Encrypted: i=1; AJvYcCX4F956hGh6+GZWo73sWR4M3JkIcWqKykteptMJVUjwfgs7MrO6RXU2+XtyhdZBwJSZAhH3lfeqiv9e3Pxf@lists.openembedded.org
X-Gm-Message-State: AOJu0Yw5nBCdxqvBQc+eX80twvLchluL3db/j20PjsXQ5i95aMB4UY9u
	6zbsLnnp7LIAHOHFBVtH6d3vpz8O0vx3cUD3CxjI4AmEd3QQMGeYQY5q
X-Gm-Gg: ASbGncvRlYy6p8Bbwd96rcE/80roXqnrvOwTgbgyDpn744OpWGRzbKlzx4b/c8Up3/X
	ngsb1NQVTVMNkbRGSi+rb/Q77SBsId4ytsVnUelo62ht5Q+kGpz3iibnIHlzqy4jgABTH9THAiq
	zuZjddK8kAgs5IUHK0X7jqvcNOQnx/QqYsdxVwPbrpZa+fgsgbIwdcn5hD6BMhxtjwi6dD/y74M
	Y/IGmrs60nE7/TSXhmv9t/5sDr6Jx4vlMG0+0cQvZTA6kmSJOPnbHf0OP2GVpAwoIYtU79bg5iP
	r2nv4rnia8q1n65Xb4WycfpSsyZE9/WszItakMJcrTDvj+yLAkWUYHO37UEh7g4fbivWIYqW75V
	IZlWK1gvR8lwkIsskB54gg+4HSyZL1xmHYX+I31rOfLVGJR0cfsJpCXnIE3kPuqGABFVW2GnZ8Y
	dNkVP4f8LneGs91VMDQKPhWYmaCxWDq2pxg9CJ0zl4B8/SvOyCgoo=
X-Google-Smtp-Source: AGHT+IHL/MliNMgQSA9pfRluxKnetPdFrkVZh0CfZZjbIOevH2tJ8ET100zKo0ZIbFW6WReeEJoNSA==
X-Received: by 2002:a05:600c:1c1e:b0:477:fcb:2267 with SMTP id 5b1f17b1804b1-47773228868mr46826375e9.8.1762702167686;
        Sun, 09 Nov 2025 07:29:27 -0800 (PST)
Received: from ?IPv6:2a02:169:59a6:0:55c4:f628:91f3:4287? ([2a02:169:59a6:0:55c4:f628:91f3:4287])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cdc33c8sm270236515e9.2.2025.11.09.07.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 07:29:27 -0800 (PST)
Message-ID: <743a968c4958035964411ed3be7d434065f9404b.camel@gmail.com>
Subject: Re: [docs] [PATCH v3 2/2] Add bitbake-setup documentation
From: adrian.freihofer@gmail.com
To: antonin.godard@bootlin.com, bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	docs@lists.yoctoproject.org
Date: Sun, 09 Nov 2025 16:29:26 +0100
In-Reply-To: <20251107-bitbake-setup-v3-2-9aa227ade002@bootlin.com>
References: <20251107-bitbake-setup-v3-0-9aa227ade002@bootlin.com>
	 <20251107-bitbake-setup-v3-2-9aa227ade002@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 09 Nov 2025 15:29:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18315

On Fri, 2025-11-07 at 12:16 +0100, Antonin Godard via
lists.yoctoproject.org wrote:
> Add documentation for bitbake-setup. This is split in 6 sections,
> including a quick start guide, terminology and reference.
>=20
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> ---
> =C2=A0.../bitbake-user-manual-environment-setup.rst=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 822
> +++++++++++++++++++++
> =C2=A0doc/index.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A02 files changed, 823 insertions(+)
>=20
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-
> setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-
> setup.rst
> new file mode 100644
> index 0000000000..66c0b0fa68
> --- /dev/null
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-
> setup.rst
> @@ -0,0 +1,822 @@
> +.. SPDX-License-Identifier: CC-BY-2.5
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Setting Up The Environment With bitbake-setup
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +|
> +
> +Setting up layers and configuring builds can be done with the
> +``bitbake-setup`` tool. This tool acts as a top-level utility which
> can perform
> +the following tasks:
> +
> +-=C2=A0 Parse a JSON configuration file that describes what layers and
> which snippets
> +=C2=A0=C2=A0 of configuration to use.
> +
> +-=C2=A0 Clone the layers onto the versions specified in the configuratio=
n
> file.
> +
> +-=C2=A0 Create and setup a directory ready for building what is specifie=
d
> in
> +=C2=A0=C2=A0 configuration files.
> +
> +-=C2=A0 Behave according to global or per-project settings.
> +
> +-=C2=A0 Synchronize with upstream configuration changes.
> +
> +Quick Start
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +#. ``bitbake-setup`` is part of the BitBake repository under
> +=C2=A0=C2=A0 ``./bin/bitbake-setup``. To start, run:

This is based on the assumption that everybody knows how to get
BitBake, but that's probably not the case. For many users, it was part
of Poky for a decade, which is now gone. There should be at least a
link to https://git.openembedded.org/bitbake and a hint that git clone
is used to get it.

From an OE-Core developer's perspective, it might be self-explanatory
that BitBake is a separate Git repository which can be cloned and
executed without any dependencies to fancy Python modules. It's also
obvious why we need BitBake (the fetcher) to fetch BitBake.
But for some users this might looks a bit strange. Why not pip? Why do
I need BitBake if there is now bitbake-setup to get BitBake setups to
my machine? To which path should the bitbake repo be cloned?

Regards,
Adrian

> +
> +=C2=A0=C2=A0 .. code-block:: shell
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $ ./bin/bitbake-setup init
> +
> +=C2=A0=C2=A0 This command will ask you to choose which configurations to=
 use
> available as
> +=C2=A0=C2=A0 part of the default BitBake :term:`generic configurations
> <generic
> +=C2=A0=C2=A0 Configuration>`.
> +
> +=C2=A0=C2=A0 .. note::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 These default configurations are located =
in
> ``./bitbake/default-registry/``.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 See the :ref:`ref-bbsetup-section-config-=
reference` section to
> learn more
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 about ``bitbake-setup`` input configurati=
on files.
> +
> +#. With the default choices, the ``bitbake-setup init`` command
> creates the
> +=C2=A0=C2=A0 following directories::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ~/bitbake-builds/
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 poky-master-p=
oky-distro_poky-machine_qemux86-64/
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=
=94=80 build/
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=
=94=80 config/
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=
=94=80 layers/
> +
> +=C2=A0=C2=A0 With:
> +
> +=C2=A0=C2=A0 -=C2=A0 ``~/bitbake-build``: the :term:`Top Directory`, whe=
re
> ``bitbake-setup``
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 configures everything. This directory can=
 be configured with
> the
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :ref:`ref-bbsetup-setting-top-dir-prefix`=
 and
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :ref:`ref-bbsetup-setting-top-dir-name` s=
ettings.
> +
> +=C2=A0=C2=A0 -=C2=A0 ``poky-master-poky-distro_poky-machine_qemux86-64``=
: a
> :term:`Setup`
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 directory, which holds a :term:`Setup`: a=
 result of the
> choices made
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 during the ``bitbake-setup init`` executi=
on.
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The name of the directory will vary depen=
ding on the choices.
> +
> +=C2=A0=C2=A0 -=C2=A0 ``config/``: holds the :term:`Specific Configuratio=
n`, which
> embeds the
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :term:`Generic Configuration` (first choi=
ce of the :ref:`ref-
> bbsetup-command-init` command)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and the choices made during the initializ=
ation.
> +
> +=C2=A0=C2=A0 -=C2=A0 ``build/``: the :term:`BitBake Build` directory, wh=
ere BitBake
> stores
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 its own configuration and outputs for the=
 builds.
> +
> +=C2=A0=C2=A0 -=C2=A0 ``layers/``: the directory where :ref:`layers
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <bitbake-user-manual/bitbake-user-manual-=
intro:Layers>` and
> other
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 repositories managed by ``bitbake-setup``=
 are stored and
> updated.
> +
> +#. Source the ``init-build-env`` file present in the :term:`BitBake
> Build`
> +=C2=A0=C2=A0 directory:
> +
> +=C2=A0=C2=A0 .. code-block:: shell
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $ source ./poky-master-poky-distro_poky-m=
achine_qemux86-
> 64/build/init-build-env
> +
> +=C2=A0=C2=A0 This command will prepare your current shell with the BitBa=
ke
> environment.
> +
> +#. You can then start running ``bitbake`` in the current shell. For
> more information
> +=C2=A0=C2=A0 on how to use ``bitbake``, see the :doc:`/bitbake-user-
> manual/bitbake-user-manual-execution`
> +=C2=A0=C2=A0 section of this manual.
> +
> +Terminology
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The ``bitbake-setup`` tool revolves around some common terms we
> define in this
> +section.
> +
> +``bitbake-setup`` works with a specific hierarchy of directories,
> that can be
> +represented as follows::
> +
> +=C2=A0=C2=A0 Top Directory
> +=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 Setup 1
> +=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 build/
> +=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 config/
> +=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 layers/
> +=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 Setup 2
> +=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 build/
> +=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 config/
> +=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 layers/
> +=C2=A0=C2=A0 ...
> +
> +The "Top Directory" and "Setup" directories are defined as follows:
> +
> +.. glossary::
> +=C2=A0=C2=A0 :term:`Top Directory`
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The top directory is the working director=
y of ``bitbake-
> setup``, where its
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 outputs end-up (unless otherwise configur=
ed by
> :term:`settings` such as
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :ref:`ref-bbsetup-setting-dl-dir`).
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The location of this directory can be cha=
nged with the
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :ref:`ref-bbsetup-setting-top-dir-prefix`=
 and
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :ref:`ref-bbsetup-setting-top-dir-name` s=
ettings.
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The top directory contains one or more :t=
erm:`Setup`
> directories, each of
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 them containing a :term:`Setup`.
> +
> +=C2=A0=C2=A0 :term:`Setup`
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 A Setup is the result of the :ref:`ref-bb=
setup-command-init`
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 command, which creates a :term:`Setup` di=
rectory. It is
> constructed from a
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :term:`Generic Configuration` and choices=
 made during the
> ``init`` command.
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 It contains at least:
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0 A :term:`BitBake Build` (``build/=
`` directory).
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0 A :term:`Specific Configuration` =
(``config/`` directory).
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0 Sources such as :ref:`layers
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <bitbake-user-manual/bi=
tbake-user-manual-intro:Layers>` or
> other
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 repositories managed by=
 ``bitbake-setup`` (``layers/``
> directory).
> +
> +The following components are involved to create the content of these
> directories:
> +
> +.. glossary::
> +=C2=A0=C2=A0 :term:`BitBake Build`
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 A BitBake Build is a sub-tree inside a :t=
erm:`Setup` that
> BitBake itself
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 operates on. The files in the ``conf/`` d=
irectory of a
> :term:`BitBake
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Build` constitute the :ref:`BitBake confi=
guration
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <bitbake-user-manual/bitbake-user-manual-=
intro:Configuration
> Files>`.
> +
> +=C2=A0=C2=A0 :term:`Generic Configuration`
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 A Generic Configuration is a file in JSON=
 format containing a
> template to
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 create a :term:`Setup`. These files are u=
sed during the
> :ref:`ref-bbsetup-command-init`
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 command as a starting point to configure =
the :term:`Setup`.
> When the
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 command runs, the user may be prompted wi=
th choices to further
> specify the
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :term:`Setup` to create.
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 It is also possible to specify the choice=
s on the command line
> for a
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 completely non-interactive initialization=
.
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :term:`Generic Configuration` files are s=
tored in
> :term:`registries
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <Registry>`, and can be listed with the :=
ref:`ref-bbsetup-
> command-list`
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 command.
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :term:`Generic Configuration` files must =
end with the
> ``.conf.json``
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 suffix for ``bitbake-setup`` to locate th=
em.
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .. note::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The default :term:`Gene=
ric Configurations <Generic
> Configuration>` are
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 located in the BitBake =
repository in a local registry. the
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ``default-registry/`` d=
irectory. This can be modified with
> the
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :ref:`ref-bbsetup-setti=
ng-registry` setting.
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :ref:`ref-bbsetup-command-status` will te=
ll if a :term:`Setup`
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is in sync with the :term:`Generic Config=
uration` it was
> constructed from
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (typically: layer updates).
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :ref:`ref-bbsetup-command-update` will br=
ing a :term:`Setup`
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in sync with its :term:`Generic Configura=
tion`.
> +
> +=C2=A0=C2=A0 :term:`Specific Configuration`
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The :term:`Specific Configuration` is sto=
red in the
> ``config/`` directory
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in a :term:`Setup`. It embeds the :term:`=
Generic
> Configuration` and the
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 choices made during the initialization.
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 It is also a Git repository, that contain=
s a history of the
> specific
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 configuration and updates made to it via =
:ref:`ref-bbsetup-
> command-update`.
> +
> +=C2=A0=C2=A0 :term:`Registry`
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 A configuration registry is a place where=
 one or more
> :term:`Generic
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Configurations <Generic Configuration>` a=
re stored.
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The directory structure of the registry c=
an be any: ``bitbake-
> setup``
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 recursively find files ending with ``.con=
f.json`` and consider
> it a
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :term:`Generic Configuration`.
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The registry location is configured throu=
gh the
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :ref:`ref-bbsetup-setting-registry` setti=
ng. This location can
> be the URL to
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a Git repository, a local directory, or a=
ny URI supported by
> the BitBake
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fetcher (see the :doc:`/bitbake-user-manu=
al/bitbake-user-
> manual-fetching`
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 section for more information on fetchers)=
.
> +
> +=C2=A0=C2=A0 :term:`Settings`
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Settings are operational parameters that =
are global to all
> builds under a
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :term:`Top Directory`, stored in a ``sett=
ings.conf`` file. For
> example,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 this could be the location of the configu=
ration registry, or
> where the
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BitBake fetcher should store the download=
s.
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 There are also global settings, common to=
 all top directories
> that are
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stored in ``~/.config/bitbake-setup/setti=
ngs.conf``.
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 See the :ref:`bitbake-user-manual/bitbake=
-user-manual-
> environment-setup:Settings`
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 section to see the supported settings and=
 where they can be
> stored.
> +
> +=C2=A0=C2=A0 :term:`Source Override`
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 A source override is a JSON file that can=
 be used to modify
> revisions and
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 origins of layers or other sources that n=
eed to be checked out
> into a
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :term:`Setup` (in the ``layers/`` directo=
ry). It can be useful
> for example
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 when the master branches need to be chang=
ed to master-next for
> the purpose
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 of testing, or to set up a CI pipeline th=
at tests code in a
> pull request
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 coming from a developer's repository and =
branch.
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Such a file is specified with a command-l=
ine option to
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :ref:`ref-bbsetup-command-init`.
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 See the :ref:`ref-bbsetup-source-override=
s` section for more
> information on
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the format of these files.
> +
> +The ``bitbake-setup`` command
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +
> +The ``bitbake-setup`` program has general options and sub-commands.
> These can be
> +obtained using ``bitbake-setup --help``.
> +
> +The general options, common to all commands, are:
> +
> +-=C2=A0 ``-h`` or ``--help``: Show the help message and exit.
> +-=C2=A0 ``-d`` or ``--debug``: Enable debug outputs.
> +-=C2=A0 ``-q`` or ``--quiet``: Print only errors.
> +-=C2=A0 ``--color``: Colorize output (where COLOR is auto, always,
> never).
> +-=C2=A0 ``--no-network``: Do not check whether configuration repositorie=
s
> and layer
> +=C2=A0=C2=A0 repositories have been updated; use only the local cache.
> +-=C2=A0 ``--global-settings``: Path to the global settings file.
> +-=C2=A0 ``--setting``: Modify a setting (for this bitbake-setup
> invocation only).
> +=C2=A0=C2=A0 For example ``--setting default top-dir-prefix /path/to/top=
-
> dir``.
> +
> +.. _ref-bbsetup-command-init:
> +
> +``bitbake-setup init``
> +----------------------
> +
> +The ``bitbake-setup init`` sub-command helps initializing a
> :term:`Setup`.
> +
> +This command can be run without any arguments to prompt the user
> with
> +configuration options to choose from. These configuration options
> are taken from
> +the input :term:`Generic Configuration` files in the
> :term:`registry`.
> +
> +.. note::
> +
> +=C2=A0=C2=A0 The registry location can be set with the :ref:`ref-bbsetup=
-
> setting-registry`
> +=C2=A0=C2=A0 setting and the :ref:`ref-bbsetup-command-settings` command=
.
> +
> +Otherwise, the first argument to :ref:`ref-bbsetup-command-init` can
> be:
> +
> +-=C2=A0 A generic configuration ID in the registry.
> +-=C2=A0 A path to a generic configuration file on a local disk.
> +-=C2=A0 An HTTP URI to the generic configuration file.
> +
> +The choices made during the bare ``bitbake-setup init`` command can
> also be
> +passed directly on the command-line, for example::
> +
> +=C2=A0=C2=A0 bitbake-setup init <generic config> poky distro/poky-tiny .=
..
> +
> +``bitbake-setup`` will stop and ask to make a choice if the above
> command does
> +not contain all of the required configurations to complete the
> sequence of
> +choices.
> +
> +In addition, the command can take the following arguments:
> +
> +-=C2=A0 ``--non-interactive``: can be used to create :term:`Setups
> <Setup>`
> +=C2=A0=C2=A0 without interactions from the user. The command will fail i=
f not
> all the
> +=C2=A0=C2=A0 required choices are provided in the command.
> +
> +-=C2=A0 ``--source-overrides``: can be used to pass one or more
> +=C2=A0=C2=A0 :ref:`source override <ref-bbsetup-source-overrides>`. See =
the
> +=C2=A0=C2=A0 :ref:`ref-bbsetup-source-overrides` section.
> +
> +-=C2=A0 ``--setup-dir-name``: can be used to configure the name of the
> :term:`Setup`
> +=C2=A0=C2=A0 directory.
> +
> +-=C2=A0 ``--skip-selection``: can be used to skip some of the choices
> +=C2=A0=C2=A0 (which may result in an incomplete :term:`Setup`!)
> +
> +``bitbake-setup init`` Examples
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +-=C2=A0 This example prompts the user to choose a :term:`Generic
> Configuration` from
> +=C2=A0=C2=A0 a custom registry:
> +
> +=C2=A0=C2=A0 .. code-block:: shell
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $ ./bitbake/bin/bitbake-setup \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --setting default=
 registry 'git://example.com/bitbake-
> setup-configurations.git;protocol=3Dhttps;branch=3Dmain;rev=3Dmain' \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 init
> +
> +-=C2=A0 This example takes a :term:`Generic Configuration` from a remote
> location
> +=C2=A0=C2=A0 (here, one of the default configuration in BitBake):
> +
> +=C2=A0=C2=A0 .. code-block:: shell
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $ ./bitbake/bin/bitbake-setup init
> https://git.openembedded.org/bitbake/plain/default-registry/configuration=
s/oe-nodistro.conf.json
> +
> +-=C2=A0 This example initializes a :term:`Setup` with:=20
> +
> +=C2=A0=C2=A0 -=C2=A0 A custom :ref:`ref-bbsetup-setting-top-dir-prefix` =
and
> :ref:`ref-bbsetup-setting-top-dir-name`
> +=C2=A0=C2=A0 -=C2=A0 A :term:`source override`.
> +=C2=A0=C2=A0 -=C2=A0 A standalone :term:`generic configuration` file.
> +=C2=A0=C2=A0 -=C2=A0 Choices passed on the command-line, applied non-int=
eractively.
> +
> +=C2=A0=C2=A0 .. code-block:: shell
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $ ./bitbake/bin/bitbake-setup \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --setting default=
 top-dir-prefix /work/bitbake-setup \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --setting default=
 top-dir-name custom-project \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 init \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --non-interactive=
 \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --source-override=
s develop-branch.json \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ./gadget_master.c=
onf.json \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gadget distro/gad=
get machine/gadget
> +
> +.. _ref-bbsetup-command-list:
> +
> +``bitbake-setup list``
> +----------------------
> +
> +The ``bitbake-setup list`` sub-command lists the available
> :term:`generic
> +configurations <generic configuration>` in the current
> :term:`registry`.
> +
> +In addition, the command can take the following arguments:
> +
> +-=C2=A0 ``--with-expired``: list the expired configuration (e.g. older
> Yocto releases
> +=C2=A0=C2=A0 that have reached their End-Of-Life dates).
> +
> +-=C2=A0 ``--write-json``: write the configurations into a JSON file so
> they can be
> +=C2=A0=C2=A0 programmatically processed.
> +
> +.. _ref-bbsetup-command-status:
> +
> +``bitbake-setup status``
> +------------------------
> +
> +The ``bitbake-setup status`` sub-command shows the status of a
> +:term:`Setup`. Any differences between the local copy of the
> :term:`generic
> +configuration` and the upstream one are printed on the console.
> +
> +If the BitBake environment is sourced and ready to build, the
> ``bitbake-setup
> +status`` command (without any arguments) will show the status of the
> current
> +:term:`Setup`.
> +
> +In addition, the command can take the following arguments:
> +
> +-=C2=A0 ``--setup-dir``: path to the :term:`Setup` to check to status
> for. Not
> +=C2=A0=C2=A0 required if the command is invoked from an initialized BitB=
ake
> environment
> +=C2=A0=C2=A0 that contains :term:`BBPATH`.
> +
> +.. _ref-bbsetup-command-update:
> +
> +``bitbake-setup update``
> +------------------------
> +
> +The ``bitbake-setup update`` sub-command updates a :term:`Setup` to
> sync with
> +the latest changes from a :term:`generic configuration` it was
> constructed from.
> +The :ref:`ref-bbsetup-command-status` command can be used to show
> the current
> +status of the :term:`Setup` before updating it.
> +
> +In addition, the command can take the following arguments:
> +
> +-=C2=A0 ``--setup-dir``: path to the :term:`Setup` to update. Not
> required if the
> +=C2=A0=C2=A0 command is invoked from an initialized BitBake environment =
that
> contains
> +=C2=A0=C2=A0 :term:`BBPATH`.
> +
> +.. _ref-bbsetup-command-install-buildtools:
> +
> +``bitbake-setup install-buildtools``
> +------------------------------------
> +
> +The ``bitbake-setup install-buildtools`` sub-command installs and
> extracts a
> +buildtools tarball into the specified :term:`Setup`.
> +
> +After completion, help is printed to help the user on how to use the
> extracted
> +tarball.
> +
> +.. note::
> +
> +=C2=A0=C2=A0 The purpose of the Buildtools tarball is to provide tools n=
eeded
> to run
> +=C2=A0=C2=A0 BitBake on build machines where such tools cannot be easily
> obtained from the
> +=C2=A0=C2=A0 host Linux distribution (for example on older distribution
> versions that do
> +=C2=A0=C2=A0 not contain a recent enough GCC compiler or Python interpre=
ter,
> or machines
> +=C2=A0=C2=A0 where the user running BitBake cannot easily install additi=
onal
> software into
> +=C2=A0=C2=A0 the system). This command requires that the OpenEmbedded-co=
re
> layer is
> +=C2=A0=C2=A0 present in the BitBake configuration.
> +
> +=C2=A0=C2=A0 See
> https://docs.yoctoproject.org/ref-manual/system-requirements.html#require=
d-git-tar-python-make-and-gcc-versions
> +=C2=A0=C2=A0 for more information.
> +
> +In addition, the command can take the following arguments:
> +
> +-=C2=A0 ``--force``: force the re-installation of the tarball.
> +
> +-=C2=A0 ``--setup-dir``: path to the :term:`Setup` to check to status
> for. Not
> +=C2=A0=C2=A0 required if :term:`BBPATH` is already configured.
> +
> +.. _ref-bbsetup-command-settings:
> +
> +``bitbake-setup settings``
> +--------------------------
> +
> +The ``bitbake-setup settings`` sub-command helps modifying the
> settings of
> +``bitbake-setup``. This sub-command has sub-commands itself:
> +
> +-=C2=A0 ``bitbake-setup settings list`` lists the current settings and
> their value.
> +-=C2=A0 ``bitbake-setup settings set`` sets a setting.
> +-=C2=A0 ``bitbake-setup settings unset`` removes a setting.
> +
> +Settings must be set with a section and a value, for example::
> +
> +=C2=A0=C2=A0 bitbake-setup setting set default top-dir-name bitbake-buil=
ds
> +
> +Will set the value of ``top-dir-name`` in the ``default`` section to
> +"bitbake-builds".
> +
> +In addition, the command can take the following arguments:
> +
> +-=C2=A0 ``--global``: write to the global settings
> +=C2=A0=C2=A0 (``~/.config/bitbake-setup/settings.conf``) instead of the
> :term:`Top
> +=C2=A0=C2=A0 Directory` settings.
> +
> +See the :ref:`bitbake-user-manual/bitbake-user-manual-environment-
> setup:Settings`
> +section to see the supported settings.
> +
> +.. note::
> +
> +=C2=A0=C2=A0 The supported setting listed in the
> +=C2=A0=C2=A0 :ref:`bitbake-user-manual/bitbake-user-manual-environment-
> setup:Settings`
> +=C2=A0=C2=A0 section are only affected when set in the ``default`` secti=
on.
> +
> +Settings
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The settings allow configuring ``bitbake-setup``. Settings are
> stored in a file
> +named ``settings.conf``, in :wikipedia:`INI <INI_file>` format.
> +
> +There are multiple locations for storing settings. Settings in
> different
> +locations can override each other, but the final value of a setting
> is computed
> +from reading the files in this order:
> +
> +#. Global settings file: ``~/.config/bitbake-setup/settings.conf``.
> +
> +#. Local settings file, taken from a ``settings.conf`` file in the
> :term:`Top
> +=C2=A0=C2=A0 Directory`.
> +
> +#. Command-line settings, passed with the ``--setting`` argument.
> +
> +A valid settings file would for example be:
> +
> +.. code-block:: ini
> +
> +=C2=A0=C2=A0 [default]
> +=C2=A0=C2=A0 top-dir-prefix =3D /path/to/workspace
> +=C2=A0=C2=A0 top-dir-name =3D bitbake-builds
> +=C2=A0=C2=A0 registry =3D /path/to/bitbake/default-registry
> +=C2=A0=C2=A0 dl-dir =3D /path/to/bitbake-setup-downloads
> +
> +Settings and their values can be listed and modified with the
> ``bitbake-setup
> +settings`` command. See the :ref:`ref-bbsetup-command-settings`
> section for
> +more information.
> +
> +Below are the available settings.
> +
> +.. _ref-bbsetup-setting-top-dir-prefix:
> +
> +``top-dir-prefix``
> +------------------
> +
> +The :ref:`ref-bbsetup-setting-top-dir-prefix` setting helps
> configuring the
> +leftmost part of the path to the :term:`Top Directory`.
> +
> +For example, with:
> +
> +.. code-block:: ini
> +
> +=C2=A0=C2=A0 [default]
> +=C2=A0=C2=A0 top-dir-prefix =3D /path/to/workspace
> +
> +The :term:`top directory` would be ``/path/to/workspace/<top-dir-
> name>`` with
> +the ``<top-dir-name>`` corresponding to the :ref:`ref-bbsetup-
> setting-top-dir-name`
> +setting.
> +
> +This is most useful to customize on systems where the default
> location of the
> +:term:`Top Directory` (``~/bitbake-builds``) is not suitable, and
> there is a
> +dedicated directory for builds somewhere else.
> +
> +.. _ref-bbsetup-setting-top-dir-name:
> +
> +``top-dir-name``
> +----------------
> +
> +The :ref:`ref-bbsetup-setting-top-dir-name` setting helps
> configuring the
> +rightmost part of the path to the :term:`Top Directory`.
> +
> +For example, with:
> +
> +.. code-block:: ini
> +
> +=C2=A0=C2=A0 [default]
> +=C2=A0=C2=A0 top-dir-name =3D builds
> +
> +The :term:`top directory` would be ``<top-dir-prefix>/builds`` with
> +the ``<top-dir-prefix>`` corresponding to the :ref:`ref-bbsetup-
> setting-top-dir-prefix`
> +setting.
> +
> +.. _ref-bbsetup-setting-registry:
> +
> +``registry``
> +------------
> +
> +The :ref:`ref-bbsetup-setting-registry` setting sets the URI
> location of the
> +registry. This URI can be any URI supported by the BitBake fetcher.
> +
> +A local registry would be configured as follows:
> +
> +.. code-block:: ini
> +
> +=C2=A0=C2=A0 [default]
> +=C2=A0=C2=A0 registry =3D /path/to/registry
> +
> +When using another fetcher, it must be specified in the URI scheme.
> For example:
> +
> +.. code-block:: ini
> +
> +=C2=A0=C2=A0 [default]
> +=C2=A0=C2=A0 registry =3D git://example.com/bitbake-setup-
> configurations;protocol=3Dhttps;branch=3Dmaster;rev=3Dmaster
> +
> +This would fetch the remote configurations from a remote Git remote
> repository,
> +on the ``master`` branch.
> +
> +See the :doc:`/bitbake-user-manual/bitbake-user-manual-fetching`
> section for more
> +information on BitBake fetchers.
> +
> +.. _ref-bbsetup-setting-dl-dir:
> +
> +``dl-dir``
> +----------
> +
> +The :ref:`ref-bbsetup-setting-dl-dir` setting sets the location of
> the download
> +cache that ``bitbake-setup`` will configure for the purpose of
> downloading
> +configuration repositories, layers and other sources using BitBake
> fetchers.
> +Please see :doc:`/bitbake-user-manual/bitbake-user-manual-fetching`
> and the
> +:term:`DL_DIR` variable for more information.
> +
> +The location can be set such that it is shared with :term:`DL_DIR`
> specified by
> +BitBake builds, so that there is a single directory containing a
> copy of
> +everything needed to set up and run a BitBake build offline in a
> reproducible
> +manner.
> +
> +.. _ref-bbsetup-section-config-reference:
> +
> +Generic Configuration Files Reference
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +:term:`Generic Configurations <Generic Configuration>` are the input
> files given
> +to ``bitbake-setup`` to configure :term:`Setups <Setup>`.
> +
> +These files are written in the JSON file format and are stored in a
> +:term:`Registry`. They can also be standalone files directly passed
> to the
> +:ref:`ref-bbsetup-command-init` command:
> +
> +.. code-block:: shell
> +
> +=C2=A0=C2=A0 $ bitbake-setup init /path/to/config.conf.json
> +
> +They contain the following sections:
> +
> +-=C2=A0 ``version`` (**required**): version of the configuration file.
> +
> +=C2=A0=C2=A0 Example:
> +
> +=C2=A0=C2=A0 .. code-block:: json
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :force:
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "version": "1.0"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +
> +-=C2=A0 ``description`` (**required**): the description of the
> configuration.
> +
> +=C2=A0=C2=A0 Example:
> +
> +=C2=A0=C2=A0 .. code-block:: json
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :force:
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "description": "O=
penEmbedded - 'nodistro' basic
> configuration"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +
> +-=C2=A0 ``sources`` (*optional*): Git repositories to fetch.
> +
> +=C2=A0=C2=A0 Example:
> +
> +=C2=A0=C2=A0 .. code-block:: json
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :force:
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "sources": {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 "bitbake": {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 "git-remote": {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "remotes": {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "o=
rigin": {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 "uri":
> "git://git.openembedded.org/bitbake;protocol=3Dhttps"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "branch": "master",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "rev": "master"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 },
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 "path": "bitbake"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 }
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0 Sources can be specified with the following options:
> +
> +=C2=A0=C2=A0 -=C2=A0 ``uri`` (**required**): a URI that follows the BitB=
ake Git
> fetcher syntax.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 See the :doc:`/bitbake-user-manual/bitbak=
e-user-manual-
> fetching` section
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for more information on the Git fetcher.
> +
> +=C2=A0=C2=A0 -=C2=A0 ``rev`` (**required**): the revision to checkout. C=
an be the
> name of the
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 branch to checkout on the latest revision=
 of the specified
> ``branch``.
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 If the value is the branch name, ``bitbak=
e-setup`` will check
> out the
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 latest revision on that branch, and keep =
it updated when using
> the
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :ref:`ref-bbsetup-command-update` command=
.
> +
> +=C2=A0=C2=A0 -=C2=A0 ``branch`` (**required**): the Git branch, used to =
check that
> the
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 specified ``rev`` is indeed on that branc=
h.
> +
> +=C2=A0=C2=A0 -=C2=A0 ``path`` is where the source is extracted.
> +
> +-=C2=A0 ``expires`` (*optional*): Expiration date of the configuration.
> This date
> +=C2=A0=C2=A0 should be in :wikipedia:`ISO 8601 <ISO_8601>` format (``YYY=
Y-MM-
> DDTHH:MM:SS``).
> +
> +-=C2=A0 ``bitbake-setup`` (**required**): contains a list of
> configurations.
> +
> +=C2=A0=C2=A0 Example:
> +
> +=C2=A0=C2=A0 .. code-block:: json
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "bitbake-setup": {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "conf=
igurations": [
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 "bb-layers": ["openembedded-core/meta","meta-
> yocto/meta-yocto-bsp","meta-yocto/meta-poky"],
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 "bb-env-passthrough-additions":
> ["DL_DIR","SSTATE_DIR"],
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 "oe-fragments-one-of": {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "machine": {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "descrip=
tion": "Target machines",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "options=
" : ["machine/qemux86-64",
> "machine/qemuarm64", "machine/qemuriscv64", "machine/genericarm64",
> "machine/genericx86-64"]
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "distro": {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "descrip=
tion": "Distribution configuration
> variants",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "options=
" : ["distro/poky", "distro/poky-
> altcfg", "distro/poky-tiny"]
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 },
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 "configurations": [
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "name": "poky",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "description": "Poky - The Yocto=
 Project testing
> distribution"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 },
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "name": "poky-with-sstate",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "description": "Poky - The Yocto=
 Project testing
> distribution with internet sstate acceleration. Use with caution as
> it requires a completely robust local network with sufficient
> bandwidth.",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "oe-fragments": ["core/yocto/sst=
ate-mirror-cdn"]
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ]
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ]
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0 Configurations can be specified with the following options:
> +
> +=C2=A0=C2=A0 -=C2=A0 ``name`` (**required**): the name of this configura=
tion
> snippet. This is
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 what is prompted during the :ref:`ref-bbs=
etup-command-init`
> command
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 execution.
> +
> +=C2=A0=C2=A0 -=C2=A0 ``description`` (**required**): the description of =
this
> configuration
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 snippet. This is what is prompted during =
the
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :ref:`ref-bbsetup-command-init` command e=
xecution.
> +
> +=C2=A0=C2=A0 -=C2=A0 ``configurations``: Configurations can recursively =
contain as
> many nested
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 configurations as needed. This will creat=
e more choices when
> running the
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :ref:`ref-bbsetup-command-init` command.
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The purpose of such nesting is to be able=
 to scale the
> configurations, for
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 example when there is a need to create mu=
ltiple configurations
> that share
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 some parameters (which are specified in t=
heir common parent),
> but differ
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 between themselves in other parameters. `=
`bitbake-setup`` will
> assemble
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 configuration choices by putting together=
 information from a
> leaf
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 configuration and all of its ancestors.
> +
> +=C2=A0=C2=A0 -=C2=A0 ``bb-env-passthrough-additions`` (*optional*): List=
 of
> environment
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 variables to include in :term:`BB_ENV_PAS=
STHROUGH_ADDITIONS`.
> +
> +=C2=A0=C2=A0 -=C2=A0 ``bb-layers`` (*optional*): List of layers to add t=
o the
> ``bblayers.conf``
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file. Paths in this list are relative to =
the ``layers/``
> directory of a
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :term:`Setup`.
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The ``bb-layers`` keyword cannot be used =
in conjunction with
> the
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ``oe-template`` option, as the ``bblayers=
.conf`` file comes
> from the
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 template itself.
> +
> +=C2=A0=C2=A0 -=C2=A0 ``bb-layers-file-relative`` (*optional*): List of l=
ayers that
> are not
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 managed by ``bitbake-setup`` but that nee=
d to be included as
> part of the
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ``bblayers.conf`` file. Paths in this lis=
t are relative to the
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 configuration file.
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This is useful when (one or more) configu=
ration files and (one
> or
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 more) layers are hosted in the same Git r=
epository, which is
> cloned
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and managed independently from bitbake-se=
tup workflows. For
> example::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=
=94=80 meta-myproject/
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=
=94=80 myproject.conf.json
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Then ``myproject.conf.json`` can contain =
the following to add
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ``meta-myproject`` to ``bblayers.conf``::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "bb-l=
ayers-file-relative": [
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 "meta-myproject"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ],
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The ``bb-layers-file-relative`` keyword c=
annot be used in
> conjunction with the
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ``oe-template`` keyword, as the ``bblayer=
s.conf`` file comes
> from the
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 template itself.
> +
> +=C2=A0=C2=A0 -=C2=A0 ``oe-template`` (*optional*, OpenEmbedded specific)=
:
> OpenEmbedded template
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to use. This cannot be used in conjunctio=
n with the
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ``bb-layers`` or ``bb-layers-file-relativ=
e`` keywords as it
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 already provides a ready ``bblayers.conf`=
` file to use.
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 See
> https://docs.yoctoproject.org/dev-manual/custom-template-configuration-di=
rectory.html
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for more information of OpenEmbedded temp=
lates.
> +
> +=C2=A0=C2=A0 -=C2=A0 ``oe-fragments-one-of`` (*optional*, OpenEmbedded s=
pecific):
> the OpenEmbedded
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fragments to select as part of the build.
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This will trigger choices to make during =
the
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :ref:`ref-bbsetup-command-init` command e=
xecution.
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 See
> https://docs.yoctoproject.org/dev/ref-manual/fragments.html=C2=A0for
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 more information of OpenEmbedded configur=
ation fragments.
> +
> +=C2=A0=C2=A0 -=C2=A0 ``oe-fragments`` (*optional*, OpenEmbedded specific=
):
> fragments to select
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 as part of the build.
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 See
> https://docs.yoctoproject.org/dev/ref-manual/fragments.html=C2=A0for
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 more information of OpenEmbedded configur=
ation fragments.
> +
> +Generic Configuration Examples
> +------------------------------
> +
> +OpenEmbedded "nodistro" configuration for master branches:
> +
> +.. literalinclude:: ../../default-registry/configurations/oe-
> nodistro.conf.json
> +=C2=A0=C2=A0 :language: json
> +
> +Poky distribution configuration for master branches:
> +
> +.. literalinclude:: ../../default-registry/configurations/poky-
> master.conf.json
> +=C2=A0=C2=A0 :language: json
> +
> +.. _ref-bbsetup-source-overrides:
> +
> +Source Overrides
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +See the definition of :term:`Source Override` in the Terminology
> section.
> +
> +These files are written in the JSON file format and are optionally
> passed to the
> +``--source-overrides`` argument of the :ref:`ref-bbsetup-command-
> init` command.
> +The ``--source-overrides`` option can be passed multiple times, in
> which case the
> +overrides are applied in the order specified in the command-line.
> +
> +Here is an example file that overrides the branch of the BitBake
> repository to
> +"master-next":
> +
> +.. code-block:: json
> +
> +=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "description": "Source override fil=
e",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "sources": {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "bitbake": =
{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 "git-remote": {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "branch": "master-next",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "remotes": {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "origin": {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 "uri":
> "git://git.openembedded.org/bitbake;protocol=3Dhttps"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "rev": "master-next"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "version": "1.0"
> +=C2=A0=C2=A0 }
> +
> +-=C2=A0 The ``version`` parameter contains the version of the used
> configuration, and
> +=C2=A0=C2=A0 should match the one of the :term:`Generic Configuration` f=
ile in
> use.
> +
> +-=C2=A0 The ``sources`` section contains the same options as the
> ``sources`` option
> +=C2=A0=C2=A0 of a :term:`Generic Configuration` file. See the
> +=C2=A0=C2=A0 :ref:`ref-bbsetup-section-config-reference` section for mor=
e
> information.
> diff --git a/doc/index.rst b/doc/index.rst
> index 546ef36c16..9f2a9067d3 100644
> --- a/doc/index.rst
> +++ b/doc/index.rst
> @@ -12,6 +12,7 @@ BitBake User Manual
> =C2=A0
> =C2=A0=C2=A0=C2=A0 bitbake-user-manual/bitbake-user-manual-intro
> =C2=A0=C2=A0=C2=A0 bitbake-user-manual/bitbake-user-manual-execution
> +=C2=A0=C2=A0 bitbake-user-manual/bitbake-user-manual-environment-setup
> =C2=A0=C2=A0=C2=A0 bitbake-user-manual/bitbake-user-manual-metadata
> =C2=A0=C2=A0=C2=A0 bitbake-user-manual/bitbake-user-manual-ref-variables-=
context
> =C2=A0=C2=A0=C2=A0 bitbake-user-manual/bitbake-user-manual-fetching
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#8014):
> https://lists.yoctoproject.org/g/docs/message/8014
> Mute This Topic: https://lists.yoctoproject.org/mt/116168702/4454582
> Group Owner: docs+owner@lists.yoctoproject.org
> Unsubscribe:
> https://lists.yoctoproject.org/g/docs/unsub=C2=A0[adrian.freihofer@gmail.=
com
> ]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

