Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E61FCCFA06
	for <webhook@archiver.kernel.org>; Mon,  3 Nov 2025 16:31:24 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1691.1762187477387558085
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 03 Nov 2025 08:31:17 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bootlin.com header.s=dkim header.b=W4phRQOu;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0E71D4E414DA
	for <bitbake-devel@lists.openembedded.org>; Mon,  3 Nov 2025 16:31:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D8FC960628;
	Mon,  3 Nov 2025 16:31:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DA40410B501AA;
	Mon,  3 Nov 2025 17:31:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762187475; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=rZmeqNibr4aLCV5tx6Y381PA4hb6rsBo02GqlX77axM=;
	b=W4phRQOuy1y5TCFsL9H5RTL1DshXiDhEk9qrjdgAmYZXG3aeEDPhC2pakWUclnMaV9Huvb
	SYuxuDE5df9/fPclkho9SAWMhp1ph3wu/DrGVhj/BhKU+SkEnODTm2HTHaO8bHfIpox446
	Fovr88nO5E53KlA7nWwQSgaxof/NIBT4nCm33NyhghQEgj2kJ59gX8BWnyQBCoan18wky/
	IFbxXJdgPQmIzuzDva/1K1BHMjAFNvyNC2lDJicUrSXP9TbHJJ9RorPwZQ9V+5S72Fmphy
	hAYKZa/ZJ1Uz5MW3pGBE2RIftgOppt9D80xETKhACDBlv6oFthf9TYOHxjbIMA==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Mon, 03 Nov 2025 17:29:50 +0100
Subject: [PATCH 2/2] Add bitbake-setup documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20251103-bitbake-setup-v1-2-635a7c829a4b@bootlin.com>
References: <20251103-bitbake-setup-v1-0-635a7c829a4b@bootlin.com>
In-Reply-To: <20251103-bitbake-setup-v1-0-635a7c829a4b@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=26305;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=pwU+bNsHPO5omnjOZvSMWRi5+O90P5Y1kaUPb7CxCNs=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpCNjQEpDcaelJFSfp4LBqdmrh1uKC3QZB8i3RV
 GEdAFSRLLuJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaQjY0AAKCRDRgEFAKaOo
 Nu4ED/0UokACj1hOA05trBTuv3Yht3mVLRKgyMkgcMKboTiqD0wcDUxHPAqJrDSluelY8sL2ckI
 0bsSlqd+TtDTRiZ1GyGh00ukF3ayvHu6Bvp+F77WUwz9TGz0mqBwUQhFHi/bvCN6Wt2puj/wYzv
 HaqkhYMn5NufhnLIvoGlmCJ6CwcaM1Bon9qoRV+YR3wQC5KhUzXi+f5Ldqwoa9vbdB3sgWM8yM0
 3pu9S/BtzRzUJXO9S4iZxofMnlbQ6UbbHz5vwbCANtiHy1BCpoCbwrPnJymMLY3BSkLRu9Amf3H
 q5NM08y/Ue5UZtFmh7RMKj9ULStM/ododNdOXrfwwZPT8JhyFg+8ocj7xCPHKVZL/t8QaROjwtH
 0Y2sfYaXtythe3eoiXy90BuRzm35MtgLmiJ9mI3KypAuyFAaOvDteVn0d4MKVJT7ZmR8vppdxSM
 D7UCqZgL3qlFhp26KYdz5DYlBUlyA27+MBkTTHscDxEGU7+QWL81BUlY9cP8ViUtaK6xrJjxA8U
 M8VGDwNyteFn/5PsN0En0jETT85TKSnpJ5TVWYMlFc1Ucvm5tC7sFAmB1QFBGLHlQErr2g6k3tJ
 vAc45s7tGzru56ix5VlK5Juonmqtyvi4WzWenH+Xf+PluUozuym+rdVJHtWtL09/685IjPRgGNz
 YuU7t1Xj0eMx/PQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 03 Nov 2025 16:31:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18243

Add documentation for bitbake-setup. This is split in 6 sections,
including a quick start guide, terminology and reference.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 .../bitbake-user-manual-environment-setup.rst      | 672 +++++++++++++++=
++++++
 doc/index.rst                                      |   1 +
 2 files changed, 673 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setu=
p.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
new file mode 100644
index 0000000000..ad8143711a
--- /dev/null
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -0,0 +1,672 @@
+.. SPDX-License-Identifier: CC-BY-2.5
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Setting Up The Environment With bitbake-setup
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+|
+
+Setting up layers and configuring builds can be done through the
+``bitbake-setup`` tool. This tool acts as a top-level utility which can =
perform
+the following tasks:
+
+-  Parse a JSON configuration file that describes what layers and which =
snippets
+   of configuration to use.
+
+-  Clone the layers onto the versions specified in the configuration fil=
e.
+
+-  Create and setup a build directory ready for building what is specifi=
ed in
+   the configuration file.
+
+-  Behave according to global or per-project settings.
+
+-  Synchronize with upstream configuration changes.
+
+Quick Start
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+#. ``bitbake-setup`` is part of the BitBake repository under
+   ``./bin/bitbake-setup``. To start, run:
+
+   .. code-block:: shell
+
+      $ ./bin/bitbake-setup init
+
+   This command will ask you to choose which configurations to use avail=
able as
+   part of the default BitBake :term:`generic configurations <generic
+   Configuration>`.
+
+   .. note::
+
+      These default configurations are located in ``./bitbake/default-re=
gistry/``.
+      See the :ref:`ref-bbsetup-section-config-reference` section to lea=
rn more
+      about ``bitbake-setup`` input configuration files.
+
+#. With the default choices, the ``bitbake-setup init`` command creates =
the
+   following directories::
+
+      ~/bitbake-builds/
+      =E2=94=94=E2=94=80=E2=94=80 poky-master-poky-distro_poky-machine_q=
emux86-64/
+       =C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 build/
+       =C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 config/
+       =C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 layers/
+
+   With:
+
+   -  ``~/bitbake-build``: the :term:`Top Directory`, where ``bitbake-se=
tup``
+      configures everything (and never writes outside of). This director=
y can be
+      configured with the :ref:`ref-bbsetup-setting-top-dir-prefix` and
+      :ref:`ref-bbsetup-setting-top-dir-name` settings.
+
+   -  ``poky-master-poky-distro_poky-machine_qemux86-64``: a
+      :term:`Setup`, which is the result of the choices made during
+      the ``bitbake-setup init`` execution. The name of the directory wi=
ll vary
+      depending on the choices.
+
+   -  ``build/``: the :term:`BitBake Build` directory, where BitBake sto=
res
+      its own configuration and outputs for the builds.
+
+   -  ``config/``: a copy of the upstream :term:`generic configuration` =
used.
+
+   -  ``layers/``: the directory where :ref:`:ref:`layers
+      <bitbake-user-manual/bitbake-user-manual-intro:Layers>` are stored=
.
+
+#. Source the ``init-build-env`` file present in the :term:`BitBake Buil=
d`
+   directory:
+
+   .. code-block:: shell
+
+      $ source ./poky-master-poky-distro_poky-machine_qemux86-64/build/i=
nit-build-env
+
+   This command will prepare your current shell with the BitBake environ=
ment.
+
+#. You can then start running ``bitbake`` in the current shell. For more=
 information
+   on how to use ``bitbake``, see the :doc:`/bitbake-user-manual/bitbake=
-user-manual-execution`
+   section of this manual.
+
+Terminology
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The ``bitbake-setup`` tool revolves around some common terms we define i=
n this
+section.
+
+The following terms correspond to the hierarchy of directories that
+``bitbake-setup`` creates:
+
+.. glossary::
+   :term:`Top Directory`
+      The top directory is the place under which ``bitbake-setup`` reads=
 and
+      writes everything. ``bitbake-setup`` makes a promise to not touch =
anything
+      outside of that directory. The location of this directory can be c=
hanged
+      with the :ref:`ref-bbsetup-setting-top-dir-prefix` and
+      :ref:`ref-bbsetup-setting-top-dir-name` settings.
+
+      The top directory contains one or more :term:`Setup`.
+
+   :term:`Setup`
+      A Setup is the result of the :ref:`ref-bbsetup-command-init`
+      command. It maps one to one to the JSON data it was constructed fr=
om,
+      and is the combination of a :term:`Generic Configuration` and choi=
ces made
+      during the ``init`` command.
+
+      It contains at least a :ref:`layer
+      <bitbake-user-manual/bitbake-user-manual-intro:Layers>` checkout, =
a
+      :term:`BitBake Build`, and a ``config/`` directory holding the ups=
tream
+      :term:`Generic Configuration` it originates from.
+
+   :term:`BitBake Build`
+      A BitBake Build is a sub-tree inside a :term:`Setup` that BitBake =
itself
+      operates on. The files in the ``conf/`` directory of a :term:`BitB=
ake
+      Build` constitute the :ref:`BitBake configuration
+      <bitbake-user-manual/bitbake-user-manual-intro:Configuration Files=
>`.
+
+To illustrate, this will translate to the following hierarchy::
+
+   Top Directory
+   =E2=94=9C=E2=94=80=E2=94=80 Setup 1
+   =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 build
+   =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 layers
+   =E2=94=9C=E2=94=80=E2=94=80 Setup 2
+   =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 build
+   =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 layers
+   ...
+
+The following are involved to create these directories and their content=
s:
+
+.. glossary::
+   :term:`Generic Configuration`
+      A Generic Configuration is a file in JSON format containing a temp=
late to
+      create a :term:`Setup`. These files are used during the :ref:`ref-=
bbsetup-command-init`
+      command as a starting point to configure the :term:`Setup`. When t=
he
+      command runs, the user may be prompted with choices to further spe=
cify the
+      :term:`Setup` to create.
+
+      :term:`Generic Configuration` files are stored in :term:`registrie=
s
+      <Registry>`, and can be listed with the :ref:`ref-bbsetup-command-=
init`
+      command.
+
+      .. note::
+
+         The default :term:`Generic Configurations <Generic Configuratio=
n>` are
+         located in the BitBake repository in a local registry. the
+         ``default-registry/`` directory. This can be modified with the
+         :ref:`ref-bbsetup-setting-registry` setting.
+
+      :ref:`ref-bbsetup-command-status` will tell if a :term:`Setup`
+      is in sync with the :term:`Generic Configuration` it was construct=
ed from
+      (typically: layer updates).
+
+      :ref:`ref-bbsetup-command-update` will bring a :term:`Setup`
+      in sync with its :term:`Generic Configuration`.
+
+   :term:`Registry`
+      A configuration registry is a place where one or more :term:`Gener=
ic
+      Configurations <Generic Configuration>` are stored.
+
+      A registry should have the following structure::
+
+         registry/
+         =E2=94=94=E2=94=80=E2=94=80 configurations/
+          =C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 configuration1.conf.j=
son
+          =C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 configuration2.conf.j=
son
+
+      The registry location is configured through the
+      :ref:`ref-bbsetup-setting-registry` setting. This location can the=
 URL to
+      a Git repository, a local directory, or any URI supported by the B=
itBake
+      fetcher (see the :doc:`/bitbake-user-manual/bitbake-user-manual-fe=
tching`
+      section for more information on fetchers).
+
+   :term:`Settings`
+      Settings are operational parameters that are global to all builds =
under a
+      :term:`Top Directory`, stored in a ``settings.conf`` file. For exa=
mple,
+      this could the location of the configuration registry, or where th=
e
+      BitBake fetcher should store the downloads.
+
+      There are also global settings, common to all top directories that=
 are
+      stored in ``~/.config/bitbake-setup/settings.conf``.
+
+      See the :ref:`bitbake-user-manual/bitbake-user-manual-environment-=
setup:Settings`
+      to see the supported settings and where to store them.
+
+   :term:`Source Override`
+      A source override is a JSON file that can be used to modify revisi=
ons and
+      origins of layers that need to be checked out into a :term:`Setup`=
 (for
+      example when the master branches need to be changed to master-next=
 for
+      the purpose of testing). Such a file is specified with a command-l=
ine
+      option to :ref:`ref-bbsetup-command-init`.
+
+      See the :ref:`ref-bbsetup-source-override` section for more inform=
ation.
+
+The ``bitbake-setup`` command
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
+
+The ``bitbake-setup`` program has general options and sub-commands. Thes=
e can be
+obtained using ``bitbake-setup --help``.
+
+The general options, common to all commands, are:
+
+-  ``-h`` or ``--help``: Show the help message and exit.
+-  ``-d`` or ``--debug``: Enable debug outputs.
+-  ``-q`` or ``--quiet``: Print only errors.
+-  ``--color``: Colorize output (where COLOR is auto, always, never).
+-  ``--no-network``: Do not check whether configuration repositories and=
 layer
+   repositories have been updated; use only the local cache.
+-  ``--global-settings``: Path to the global settings file.
+-  ``--setting``: Modify a setting (for this bitbake-setup invocation on=
ly)
+   For example ``--setting default top-dir-prefix /path/to/top/dir``.
+
+.. _ref-bbsetup-command-init:
+
+``bitbake-setup init``
+----------------------
+
+The ``bitbake-setup init`` sub-command helps initializing a :term:`Setup=
`.
+
+This command can be run without any arguments to prompt the user with
+configuration options to choose from. These configuration options are ta=
ken from
+the input :term:`Generic Configuration` files in the :term:`registry`.
+
+.. note::
+
+   The registry location can be set with the :ref:`ref-bbsetup-setting-r=
egistry`
+   setting and the :ref:`ref-bbsetup-command-settings` command.
+
+The choices made during the bare ``bitbake-setup init`` command can also=
 be
+passed directly on the command-line, for example::
+
+   bitbake-setup init poky-master poky distro/poky-tiny
+
+``bitbake-setup`` will stop and ask to make a choice if the above comman=
d does
+not contain all of the required configurations to complete the sequence =
of
+choices.
+
+In addition, the command can take the following arguments:
+
+-  ``--non-interactive``: can be used to create :term:`Setups <Setup>`
+   without interactions from the user. The command will fail if not all =
the
+   required choices are provided in the command.
+
+-  ``--source-overrides``: can be used to pass one or more
+   :ref:`source override <ref-bbsetup-source-override>`.
+
+-  ``--build-dir-name``: can be used to configure the name of the :term:=
`Setup`
+   directory.
+
+-  ``--skip-selection``: can be used to skip some of the choices
+   (which may result in an incomplete :term:`Setup`!)
+
+.. _ref-bbsetup-command-list:
+
+``bitbake-setup list``
+----------------------
+
+The ``bitbake-setup list`` sub-command lists the available :term:`generi=
c
+configurations <generic configuration>` in the current :term:`registry`.
+
+In addition, the command can take the following arguments:
+
+-  ``--with-expired``: list the expired configuration.
+
+-  ``--write-json``: write the configurations into a JSON file so they c=
an be
+   programmatically processed.
+
+.. _ref-bbsetup-command-status:
+
+``bitbake-setup status``
+------------------------
+
+The ``bitbake-setup status`` sub-command shows the status of a
+:term:`Setup`. Any differences between the local copy of the :term:`gene=
ric
+configuration` and the upstream one are printed on the console.
+
+If the BitBake environment is sourced and ready to build, the ``bitbake-=
setup
+status`` command (without any arguments) will show the status of the cur=
rent
+:term:`Setup`.
+
+In addition, the command can take the following arguments:
+
+-  ``--build-dir``: path to the :term:`Setup` to check to status for. No=
t
+   required if :term:`BBPATH` is already configured.
+
+.. _ref-bbsetup-command-update:
+
+``bitbake-setup update``
+------------------------
+
+The ``bitbake-setup update`` sub-command updates a :term:`Setup` to sync=
 with
+the latest changes from a :term:`generic configuration` it was construct=
ed from.
+The :ref:`ref-bbsetup-command-status` command can be used to show the cu=
rrent
+status of the :term:`Setup`.
+
+In addition, the command can take the following arguments:
+
+-  ``--build-dir``: path to the :term:`Setup` to check to status for. No=
t
+   required if :term:`BBPATH` is already configured.
+
+.. _ref-bbsetup-command-install-buildtools:
+
+``bitbake-setup install-buildtools``
+------------------------------------
+
+The ``bitbake-setup install-buildtools`` sub-command installs and extrac=
ts a
+buildtools tarball into the specified :term:`Setup`. If the BitBake envi=
ronment
+is sourced and ready to build, the ``bitbake-setup status`` command (wit=
hout any
+arguments) will show the status of the current :term:`Setup`.
+
+After completion, help is printed to help the user on how to use the ext=
racted
+tarball.
+
+In addition, the command can take the following arguments:
+
+-  ``--force``: force the re-installation of the tarball.
+
+-  ``--setup-dir``: path to the :term:`Setup` to check to status for. No=
t
+   required if :term:`BBPATH` is already configured.
+
+.. _ref-bbsetup-command-settings:
+
+``bitbake-setup settings``
+--------------------------
+
+The ``bitbake-setup settings`` sub-command helps modifying the settings =
of
+``bitbake-setup``. This sub-command has sub-commands itself:
+
+-  ``bitbake-setup settings list`` lists the current settings and their =
value.
+-  ``bitbake-setup settings set`` sets a setting.
+-  ``bitbake-setup settings unset`` removes a setting.
+
+Settings must be set with a section and a value, for example::
+
+   bitbake-setup setting set default top-dir-name bitbake-builds
+
+Will set the value of ``top-dir-name`` in the ``default`` section to
+"bitbake-builds".
+
+In addition, the command can take the following arguments:
+
+-  ``--global``: write to the global settings
+   (``~/.config/bitbake-setup/settings.conf``) instead of the :term:`top
+   directory` settings.
+
+See the :ref:`bitbake-user-manual/bitbake-user-manual-environment-setup:=
Settings`
+to see the supported settings.
+
+.. note::
+
+   You can set custom new section to ``bitbake-setup`` settings, but the
+   supported setting listed in the :ref:`bitbake-user-manual/bitbake-use=
r-manual-environment-setup:Settings`
+   section are only affected when set in the ``default`` section.
+
+Settings
+=3D=3D=3D=3D=3D=3D=3D=3D
+
+The :term:`settings` allow configuring ``bitbake-setup``. Settings are s=
tored in
+a file named ``settings.conf``, in :wikipedia:`INI <INI_file>` format.
+
+There are multiple locations for storing settings. Settings in different
+locations can override each other, but the final value of a setting is c=
omputed
+from reading the files in this order:
+
+#. Global settings file: ``~/.config/bitbake-setup/settings.conf``.
+
+#. Local settings file, taken from a ``settings.conf`` file in the :term=
:`Top
+   Directory`.
+
+#. Command-line settings, depending on the command and settings name.
+
+A valid settings file would for example be:
+
+.. code-block:: ini
+
+   [default]
+   top-dir-prefix =3D /path/to/workspace
+   top-dir-name =3D bitbake-builds
+   registry =3D /path/to/bitbake/default-registry
+   dl-dir =3D /path/to/bitbake-setup-downloads
+
+Settings and their values can be listed and modified with the ``bitbake-=
setup
+settings`` command. See the :ref:`ref-bbsetup-command-settings` section =
for
+more information.
+
+Below are the available settings.
+
+.. _ref-bbsetup-setting-top-dir-prefix:
+
+``top-dir-prefix``
+------------------
+
+The :ref:`ref-bbsetup-setting-top-dir-prefix` setting helps configuring =
the
+leftmost part of the path to the :term:`Top Directory`.
+
+For example, with:
+
+.. code-block:: ini
+
+   [default]
+   top-dir-prefix =3D /path/to/workspace
+
+The :term:`top directory` would be ``/path/to/workspace/<top-dir-name>``=
 with
+the ``<top-dir-name>`` corresponding to the :ref:`ref-bbsetup-setting-to=
p-dir-name`
+setting.
+
+.. _ref-bbsetup-setting-top-dir-name:
+
+``top-dir-name``
+----------------
+
+The :ref:`ref-bbsetup-setting-top-dir-name` setting helps configuring th=
e
+rightmost part of the path to the :term:`Top Directory`.
+
+For example, with:
+
+.. code-block:: ini
+
+   [default]
+   top-dir-name =3D builds
+
+The :term:`top directory` would be ``<top-dir-prefix>/builds`` with
+the ``<top-dir-prefix>`` corresponding to the :ref:`ref-bbsetup-setting-=
top-dir-prefix`
+setting.
+
+.. _ref-bbsetup-setting-registry:
+
+``registry``
+------------
+
+The :ref:`ref-bbsetup-setting-registry` setting sets the URI location of=
 the
+registry. This URI can be any URI supported by the BitBake fetcher.
+
+A local registry would be configured as follows:
+
+.. code-block:: ini
+
+   [default]
+   registry =3D /path/to/registry
+
+When using another fetcher, it must be specified in the URI scheme. For =
example:
+
+.. code-block:: ini
+
+   [default]
+   registry =3D git://example.com/bitbake-setup-configurations;protocol=3D=
https;branch=3Dmaster;rev=3Dmaster
+
+This would fetch the remote configurations from a remote Git remote repo=
sitory,
+on the ``master`` branch.
+
+See the :doc:`/bitbake-user-manual/bitbake-user-manual-fetching` section=
 for more
+information on BitBake fetchers.
+
+.. _ref-bbsetup-setting-dl-dir:
+
+``dl-dir``
+----------
+
+The :ref:`ref-bbsetup-setting-dl-dir` setting set the location of source=
s
+``bitbake-setup`` will download when configuring a :term:`Setup`.
+
+This includes the registry (if the registry is stored remotely) or layer=
s.
+
+.. _ref-bbsetup-section-config-reference:
+
+Generic Configuration Files Reference
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+:term:`Generic Configurations <Generic Configuration>` are the input fil=
es given
+to ``bitbake-setup`` to configure :term:`Setups <Setup>`.
+
+These files are written in the JSON file format and are stored in a
+:term:`Registry`. They contains three main sections:
+
+-  ``version`` (**required**): version of the configuration file.
+
+   Example:
+
+   .. code-block:: json
+      :force:
+
+      {
+          "version": "1.0"
+      }
+
+-  ``description`` (**required**): the description of the configuration.
+
+   Example:
+
+   .. code-block:: json
+      :force:
+
+      {
+          "description": "OpenEmbedded - 'nodistro' basic configuration"
+      }
+
+-  ``sources``: one or more Git repository to fetch.
+
+   Example:
+
+   .. code-block:: json
+      :force:
+
+      {
+         "sources": {
+             "bitbake": {
+                 "git-remote": {
+                     "remotes": {
+                         "origin": {
+                             "uri": "git://git.openembedded.org/bitbake;=
protocol=3Dhttps"
+                         }
+                     },
+                     "branch": "master",
+                     "rev": "master"
+                 },
+                 "path": "bitbake"
+             }
+         }
+      }
+
+   Sources can be specified with the following options:
+
+   -  ``uri`` (**required**): a URI that follows the BitBake Git fetcher=
 syntax.
+      See the :doc:`/bitbake-user-manual/bitbake-user-manual-fetching` s=
ection
+      for more information on the Git fetcher.
+
+   -  ``rev`` (**required**): the revision to checkout. Can be the name =
of the
+      branch to checkout on the latest revision of the specified ``branc=
h``.
+
+   -  ``branch`` (**required**): the Git branch, used to check that the
+      specified ``rev`` is indeed on that branch.
+
+   -  ``path`` is where the source is extracted.
+
+-  ``bitbake-setup`` (**required**): contains a list of configurations.
+
+   Example:
+
+   .. code-block:: json
+
+      {
+         "bitbake-setup": {
+            "configurations": [
+            {
+                "bb-layers": ["openembedded-core/meta","meta-yocto/meta-=
yocto-bsp","meta-yocto/meta-poky"],
+                "bb-env-passthrough-additions": ["DL_DIR","SSTATE_DIR"],
+                "oe-fragments-one-of": {
+                    "machine": {
+                        "description": "Target machines",
+                        "options" : ["machine/qemux86-64", "machine/qemu=
arm64", "machine/qemuriscv64", "machine/genericarm64", "machine/genericx8=
6-64"]
+                    },
+                    "distro": {
+                        "description": "Distribution configuration varia=
nts",
+                        "options" : ["distro/poky", "distro/poky-altcfg"=
, "distro/poky-tiny"]
+                    }
+                },
+                "configurations": [
+                {
+                    "name": "poky",
+                    "description": "Poky - The Yocto Project testing dis=
tribution"
+                },
+                {
+                    "name": "poky-with-sstate",
+                    "description": "Poky - The Yocto Project testing dis=
tribution with internet sstate acceleration. Use with caution as it requi=
res a completely robust local network with sufficient bandwidth.",
+                    "oe-fragments": ["core/yocto/sstate-mirror-cdn"]
+                }
+                ]
+            }
+            ]
+         }
+      }
+
+   Configurations can be specified with the following options:
+
+   -  ``name`` (**required**): the name of this configuration snippet. T=
his is
+      what is prompted during the :ref:`ref-bbsetup-command-init` comman=
d
+      execution.
+
+   -  ``description`` (**required**): the description of this configurat=
ion
+      snippet. This is what is prompted during the
+      :ref:`ref-bbsetup-command-init` command execution.
+
+   -  ``configurations``: Configurations can contain as many sub-configu=
rations
+      as needed. This will create more choices when running the
+      :ref:`ref-bbsetup-command-init` command.
+
+   -  ``bb-env-passthrough-additions`` (*optional*): List of environment
+      variables to include in :term:`BB_ENV_PASSTHROUGH_ADDITIONS`.
+
+   -  ``bb-layers`` (*optional*): Layers to add to the ``bblayers.conf``=
 file.
+      This cannot be used in conjunction with the ``oe-template`` option=
.
+
+   -  ``oe-template`` (*optional*, OpenEmbedded specific): OpenEmbedded =
template
+      to use. This cannot be used in conjunction with the ``bb-layers`` =
option.
+
+      See https://docs.yoctoproject.org/dev-manual/custom-template-confi=
guration-directory.html
+      for more information of OpenEmbedded templates.
+
+   -  ``oe-fragments-one-of`` (*optional*, OpenEmbedded specific): the O=
penEmbedded
+      fragments to select as part of the build.
+
+      This will trigger choices to make during the
+      :ref:`ref-bbsetup-command-init` command execution.
+
+      See https://docs.yoctoproject.org/dev/ref-manual/fragments.html fo=
r
+      more information of OpenEmbedded configuration fragments.
+
+   -  ``oe-fragments`` (*optional*, OpenEmbedded specific): fragments to=
 select
+      as part of the build.
+
+      See https://docs.yoctoproject.org/dev/ref-manual/fragments.html fo=
r
+      more information of OpenEmbedded configuration fragments.
+
+Examples
+--------
+
+OpenEmbedded "nodistro" configuration for master branches:
+
+.. literalinclude:: ../../default-registry/configurations/oe-nodistro.co=
nf.json
+   :language: json
+
+Poky distribution configuration for master branches:
+
+.. literalinclude:: ../../default-registry/configurations/poky-master.co=
nf.json
+   :language: json
+
+.. _ref-bbsetup-source-override:
+
+Source Overrides
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+A source override is a file that can be used to override some of the
+sources definition of a :term:`Generic Configuration` file.
+
+These files are written in the JSON file format and are optionally passe=
d to the
+``--source-override`` argument of the :ref:`ref-bbsetup-command-init` co=
mmand.
+The ``--source-override`` option can be passed multiple times, in which =
case the
+overrides are applied in the order specified in the command-line.
+
+Here is an example source override:
+
+.. code-block:: json
+
+   {
+       "description": "Source override file",
+       "sources": {
+           "bitbake": {
+               "git-remote": {
+                   "branch": "master-next",
+                   "remotes": {
+                       "origin": {
+                           "uri": "ssh://git@push.openembedded.org/bitba=
ke"
+                       }
+                   },
+                   "rev": "acf5b02c5aaae1116d33b4e08b2ad7c27d9b94ab"
+               }
+           }
+       },
+       "version": "1.0"
+   }
+
+-  The ``version`` parameter contains the version of the used configurat=
ion, and
+   should match the one of the :term:`Generic Configuration` file in use=
.
+
+-  The ``sources`` section contains the same options as the ``sources`` =
option
+   of a :term:`Generic Configuration` file. See the
+   :ref:`ref-bbsetup-section-config-reference` section for more informat=
ion.
diff --git a/doc/index.rst b/doc/index.rst
index 546ef36c16..9f2a9067d3 100644
--- a/doc/index.rst
+++ b/doc/index.rst
@@ -12,6 +12,7 @@ BitBake User Manual
=20
    bitbake-user-manual/bitbake-user-manual-intro
    bitbake-user-manual/bitbake-user-manual-execution
+   bitbake-user-manual/bitbake-user-manual-environment-setup
    bitbake-user-manual/bitbake-user-manual-metadata
    bitbake-user-manual/bitbake-user-manual-ref-variables-context
    bitbake-user-manual/bitbake-user-manual-fetching

--=20
2.51.0


