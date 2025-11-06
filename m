Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF5BCCFA1C
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 09:23:46 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10846.1762421020266535037
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Nov 2025 01:23:40 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bootlin.com header.s=dkim header.b=N22hAUzZ;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id EFA511A18F0
	for <bitbake-devel@lists.openembedded.org>; Thu,  6 Nov 2025 09:23:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C68246068C;
	Thu,  6 Nov 2025 09:23:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 08B1B118507A1;
	Thu,  6 Nov 2025 10:23:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762421018; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=qvmjfB4IZpucRw/3qH3wqCoMab0luWtHFnR/nWCcpO8=;
	b=N22hAUzZy7geTmtuvoPWJmGrMwjfklgZ8YDbPeyPPQYMoEORdacfGgcMHYEQSz3x8XH8Og
	h2sfQ28HQd0T9RSHWj/8HgRYr7XQwxWeN1V2pj5Tv7GLMIrk5uLJA1uZ1kcDlNkGWUeO/L
	/z6KP79caXJHUSSKXhZjwv8n0OcrXpQ2i6lAjvBuzZRaLM2tElm2reBQY+bwORtlmNQ/hy
	cPNNeq5kssFRsu1rNNHMdYrbjPHh9UpEeYwRWx5FmVV2SnA845/Y+t5gAPNkMZiWCP/lvV
	IXHlbfyz0b3g2K4KM6JjLI68qG1nVcRm/8+HTY4zIGtdsCyJW0lZKMyVDWeilw==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Thu, 06 Nov 2025 10:23:31 +0100
Subject: [PATCH v2 2/2] Add bitbake-setup documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20251106-bitbake-setup-v2-2-2722ef759c35@bootlin.com>
References: <20251106-bitbake-setup-v2-0-2722ef759c35@bootlin.com>
In-Reply-To: <20251106-bitbake-setup-v2-0-2722ef759c35@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=32031;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=QZLAZVw4qcAuWIUtu+5Cna4ajFprDq3eSpGaOXaYZ0Y=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpDGkXaR7xk9GzDMq+lyY5GFKxtnStLC3c7sEPk
 OkG5N186G2JAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaQxpFwAKCRDRgEFAKaOo
 NnxRD/0ct6lnDse4/ONG1VTA2vUN04M4Ms1FqCfpUSUBOiHvqHCw3xbni+F9jz4cW1USXxIF4Zo
 sTTagX4WHN5/LBczLkIcm4mT0No+M9nmZ4B1wZG6Xlp24mN6ZR4bbtxssqIoNDyGb0uRGBVpfR6
 /cYxupKEXCl7cJAjdBxEWfCP4DIS/Y6hJxmoIIyr3ZIdXfvbn1hb//+EpNzTT9ItOrc0Nh8qknB
 9/dg94z5UDEYfhX3wdszoEb3IW5cxemwuycJpso9kJNbx484nfhjPL9zsVuil2eKPLGMa/g5Llv
 bH2bWF6QjkKTF/+RNzeGY2w3cWgOm1BuecX2ADSeoYPVupXH0cUzO95FXmNaJ7WQHwAckNzIBS0
 0KwOhGDlcDtfIQzLypDylktIwF1abHLNIDL9cPSmFld3XTDkcC5zljiT9qF+ckBA/kajt50NXGG
 x+jXygN/P+nXLtP+zq859dMFGxZNjQiMvviUrvsyElpzc+GO3JpgCU9P5j90KXCw/Mvt5QJOhKU
 z5525UvCEsyH72gXNYFlWWfG4AN7R0yX1DsoXTVb+WuNiB/eX7hkFJgWcbCUD0XiPJ2f+kk9d/N
 HKcCgBQS/yYEx+mCUODxPitwJpLSEmjbcWDxkcm6L9IchbuNMx9yePJgZKcVTKzM8sK5WA10I5G
 d+B4r/fnWr9NlaA==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Nov 2025 09:23:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18284

Add documentation for bitbake-setup. This is split in 6 sections,
including a quick start guide, terminology and reference.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 .../bitbake-user-manual-environment-setup.rst      | 802 +++++++++++++++=
++++++
 doc/index.rst                                      |   1 +
 2 files changed, 803 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setu=
p.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
new file mode 100644
index 0000000000..cd35b75cf1
--- /dev/null
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -0,0 +1,802 @@
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
+Setting up layers and configuring builds can be done with the
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
+-  Create and setup a directory ready for building what is specified in
+   configuration files.
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
+      configures everything. This directory can be configured with the
+      :ref:`ref-bbsetup-setting-top-dir-prefix` and
+      :ref:`ref-bbsetup-setting-top-dir-name` settings.
+
+   -  ``poky-master-poky-distro_poky-machine_qemux86-64``: a :term:`Setu=
p`
+      directory, which holds a :term:`Setup`: a result of the choices ma=
de
+      during the ``bitbake-setup init`` execution.
+
+      The name of the directory will vary depending on the choices.
+
+   -  ``config/``: holds the :term:`Specific Configuration`, which embed=
s the
+      :term:`Generic Configuration` (first choice of the :ref:`ref-bbset=
up-command-init` command)
+      and the choices made during the initialization.
+
+   -  ``build/``: the :term:`BitBake Build` directory, where BitBake sto=
res
+      its own configuration and outputs for the builds.
+
+   -  ``layers/``: the directory where :ref:`layers
+      <bitbake-user-manual/bitbake-user-manual-intro:Layers>` are stored=
 and
+      updated.
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
+``bitbake-setup`` works with a specific hierarchy of directories, that c=
an be
+represented as follows::
+
+   Top Directory
+   =E2=94=9C=E2=94=80=E2=94=80 Setup 1
+   =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 build/
+   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 config/
+   =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 layers/
+   =E2=94=9C=E2=94=80=E2=94=80 Setup 2
+   =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 build/
+   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 config/
+   =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 layers/
+   ...
+
+The "Top Directory" and "Setup" directories are defined as follows:
+
+.. glossary::
+   :term:`Top Directory`
+      The top directory is the working directory of ``bitbake-setup``, w=
here its
+      outputs end-up (unless otherwise configured by :term:`settings` su=
ch as
+      :ref:`ref-bbsetup-setting-dl-dir`).
+
+      The location of this directory can be changed with the
+      :ref:`ref-bbsetup-setting-top-dir-prefix` and
+      :ref:`ref-bbsetup-setting-top-dir-name` settings.
+
+      The top directory contains one or more :term:`Setup` directories, =
each of
+      them containing a :term:`Setup`.
+
+   :term:`Setup`
+      A Setup is the result of the :ref:`ref-bbsetup-command-init`
+      command, which creates a :term:`Setup` directory. It is constructe=
d from a
+      :term:`Generic Configuration` and choices made during the ``init``=
 command.
+
+      It contains at least:
+
+      -  A :term:`BitBake Build` (``build/`` directory).
+      -  A :term:`Specific Configuration` (``config/`` directory).
+      -  A :ref:`layer <bitbake-user-manual/bitbake-user-manual-intro:La=
yers>`
+         checkout (``layers/`` directory).
+
+The following components are involved to create the content of these dir=
ectories:
+
+.. glossary::
+   :term:`BitBake Build`
+      A BitBake Build is a sub-tree inside a :term:`Setup` that BitBake =
itself
+      operates on. The files in the ``conf/`` directory of a :term:`BitB=
ake
+      Build` constitute the :ref:`BitBake configuration
+      <bitbake-user-manual/bitbake-user-manual-intro:Configuration Files=
>`.
+
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
+      It is also possible to specify the choices on the command line for=
 a
+      completely non-interactive initialization.
+
+      :term:`Generic Configuration` files are stored in :term:`registrie=
s
+      <Registry>`, and can be listed with the :ref:`ref-bbsetup-command-=
init`
+      command.
+
+      :term:`Generic Configuration` files must end with the ``.conf.json=
``
+      suffix for ``bitbake-setup`` to locate them.
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
+   :term:`Specific Configuration`
+      The :term:`Specific Configuration` is stored in the ``config/`` di=
rectory
+      in a :term:`Setup`. It embeds the :term:`Generic Configuration` an=
d the
+      choices made during the initialization.
+
+      It is also a Git repository, that contains a history of the specif=
ic
+      configuration and updates made to it via :ref:`ref-bbsetup-command=
-update`.
+
+   :term:`Registry`
+      A configuration registry is a place where one or more :term:`Gener=
ic
+      Configurations <Generic Configuration>` are stored.
+
+      The directory structure of the registry can be any: ``bitbake-setu=
p``
+      recursively find files ending with ``.conf.json`` and consider it =
a
+      :term:`Generic Configuration`.
+
+      The registry location is configured through the
+      :ref:`ref-bbsetup-setting-registry` setting. This location can be =
the URL to
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
+      this could be the location of the configuration registry, or where=
 the
+      BitBake fetcher should store the downloads.
+
+      There are also global settings, common to all top directories that=
 are
+      stored in ``~/.config/bitbake-setup/settings.conf``.
+
+      See the :ref:`bitbake-user-manual/bitbake-user-manual-environment-=
setup:Settings`
+      section to see the supported settings and where they can be stored=
.
+
+   :term:`Source Override`
+      A source override is a JSON file that can be used to modify revisi=
ons and
+      origins of layers that need to be checked out into a :term:`Setup`=
. It can
+      be useful for example when the master branches need to be changed =
to
+      master-next for the purpose of testing, or to set up a CI pipeline=
 that
+      tests code in a pull request coming from a developer's repository =
and
+      branch.
+
+      Such a file is specified with a command-line option to
+      :ref:`ref-bbsetup-command-init`.
+
+      See the :ref:`ref-bbsetup-source-overrides` section for more infor=
mation on
+      the format of these files.
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
ly).
+   For example ``--setting default top-dir-prefix /path/to/top-dir``.
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
+   :ref:`source override <ref-bbsetup-source-overrides>`. See the
+   :ref:`ref-bbsetup-source-overrides` section.
+
+-  ``--setup-dir-name``: can be used to configure the name of the :term:=
`Setup`
+   directory.
+
+-  ``--skip-selection``: can be used to skip some of the choices
+   (which may result in an incomplete :term:`Setup`!)
+
+``bitbake-setup init`` Examples
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+-  This example prompts the user to choose a :term:`Generic Configuratio=
n` from
+   a custom registry:
+
+   .. code-block:: shell
+
+      $ ./bitbake/bin/bitbake-setup \
+          --setting default registry 'git://example.com/bitbake-setup-co=
nfigurations.git;protocol=3Dhttps;branch=3Dmain;rev=3Dmain' \
+          init
+
+-  This example initializes a :term:`Setup` with:=20
+
+   -  A custom :ref:`ref-bbsetup-setting-top-dir-prefix` and :ref:`ref-b=
bsetup-setting-top-dir-name`
+   -  A :term:`source override`.
+   -  A standalone :term:`generic configuration` file.
+   -  Choices passed on the command-line, applied non-interactively.
+
+   .. code-block:: shell
+
+      $ ./bitbake/bin/bitbake-setup \
+          --setting default top-dir-prefix /work/bitbake-setup \
+          --setting default top-dir-name custom-project \
+          init \
+          --non-interactive \
+          --source-overrides develop-branch.json \
+          ./gadget_master.conf.json \
+          gadget distro/gadget machine/gadget
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
+-  ``--with-expired``: list the expired configuration (e.g. older Yocto =
releases
+   that have reached their End-Of-Life dates).
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
+-  ``--setup-dir``: path to the :term:`Setup` to check to status for. No=
t
+   required if the command is invoked from an initialized BitBake enviro=
nment
+   that contains :term:`BBPATH`.
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
+status of the :term:`Setup` before updating it.
+
+In addition, the command can take the following arguments:
+
+-  ``--setup-dir``: path to the :term:`Setup` to update. Not required if=
 the
+   command is invoked from an initialized BitBake environment that conta=
ins
+   :term:`BBPATH`.
+
+.. _ref-bbsetup-command-install-buildtools:
+
+``bitbake-setup install-buildtools``
+------------------------------------
+
+The ``bitbake-setup install-buildtools`` sub-command installs and extrac=
ts a
+buildtools tarball into the specified :term:`Setup`.
+
+After completion, help is printed to help the user on how to use the ext=
racted
+tarball.
+
+.. note::
+
+   The purpose of the Buildtools tarball is to provide tools needed to r=
un
+   BitBake on build machines where such tools cannot be easily obtained =
from the
+   host Linux distribution (for example on older distribution versions t=
hat do
+   not contain a recent enough GCC compiler or Python interpreter, or ma=
chines
+   where the user running BitBake cannot easily install additional softw=
are into
+   the system). This command requires that the OpenEmbedded-core layer i=
s
+   present in the BitBake configuration.
+
+   See https://docs.yoctoproject.org/ref-manual/system-requirements.html=
#required-git-tar-python-make-and-gcc-versions
+   for more information.
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
+   (``~/.config/bitbake-setup/settings.conf``) instead of the :term:`Top
+   Directory` settings.
+
+See the :ref:`bitbake-user-manual/bitbake-user-manual-environment-setup:=
Settings`
+section to see the supported settings.
+
+.. note::
+
+   The supported setting listed in the
+   :ref:`bitbake-user-manual/bitbake-user-manual-environment-setup:Setti=
ngs`
+   section are only affected when set in the ``default`` section.
+
+Settings
+=3D=3D=3D=3D=3D=3D=3D=3D
+
+The settings allow configuring ``bitbake-setup``. Settings are stored in=
 a file
+named ``settings.conf``, in :wikipedia:`INI <INI_file>` format.
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
+#. Command-line settings, passed with the ``--setting`` argument.
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
+This is most useful to customize on systems where the default location o=
f the
+:term:`Top Directory` (``~/bitbake-builds``) is not suitable, and there =
is a
+dedicated directory for builds somewhere else.
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
+The :ref:`ref-bbsetup-setting-dl-dir` setting sets the location of the d=
ownload
+cache that ``bitbake-setup`` will configure for the purpose of downloadi=
ng
+configuration repositories and layers using BitBake fetchers. Please see
+:doc:`/bitbake-user-manual/bitbake-user-manual-fetching` and the :term:`=
DL_DIR`
+variable for more information.
+
+The location can be set such that it is shared with :term:`DL_DIR` speci=
fied by
+BitBake builds, so that there is a single directory containing a copy of
+everything needed to set up and run a BitBake build offline in a reprodu=
cible
+manner.
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
+:term:`Registry`. They can also be standalone files directly passed to t=
he
+:ref:`ref-bbsetup-command-init` command:
+
+.. code-block:: shell
+
+   $ bitbake-setup init /path/to/config.conf.json
+
+They contain the following sections:
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
+-  ``sources`` (*optional*): Git repositories to fetch.
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
+      If the value is the branch name, ``bitbake-setup`` will check out =
the
+      latest revision on that branch, and keep it updated when using the
+      :ref:`ref-bbsetup-command-update` command.
+
+   -  ``branch`` (**required**): the Git branch, used to check that the
+      specified ``rev`` is indeed on that branch.
+
+   -  ``path`` is where the source is extracted.
+
+-  ``expires`` (*optional*): Expiration date of the configuration. This =
date
+   should be in :wikipedia:`ISO 8601 <ISO_8601>` format (``YYYY-MM-DDTHH=
:MM:SS``).
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
+   -  ``configurations``: Configurations can recursively contain as many=
 nested
+      configurations as needed. This will create more choices when runni=
ng the
+      :ref:`ref-bbsetup-command-init` command.
+
+      The purpose of such nesting is to be able to scale the configurati=
ons, for
+      example when there is a need to create multiple configurations tha=
t share
+      some parameters (which are specified in their common parent), but =
differ
+      between themselves in other parameters. ``bitbake-setup`` will ass=
emble
+      configuration choices by putting together information from a leaf
+      configuration and all of its ancestors.
+
+   -  ``bb-env-passthrough-additions`` (*optional*): List of environment
+      variables to include in :term:`BB_ENV_PASSTHROUGH_ADDITIONS`.
+
+   -  ``bb-layers`` (*optional*): Layers to add to the ``bblayers.conf``=
 file
+      (paths are relative to the ``layers/`` directory of a :term:`Setup=
`,
+      unless ``{THISDIR}`` is used, see below).
+
+      The ``bb-layers`` option cannot be used in conjunction with the
+      ``oe-template`` option where the ``bblayers.conf`` files comes fro=
m the
+      template itself.
+
+      Local layers (layers not part of the ``sources``) can be added to
+      ``bb-layers`` by specifying their path with the ``{THISDIR}`` spec=
ial
+      keyword. For example::
+
+         {
+            ...
+            "bb-layers": [
+               "{THISDIR}/meta-myproject"
+            ],
+            ...
+         }
+
+      ``{THISDIR}`` translates to the parent directory of the current
+      :term:`Generic Configuration` file.
+
+      This is useful when (one or more) configuration files and (one or
+      more) layers are hosted in the same Git repository, which is clone=
d
+      and managed independently from bitbake-setup workflows. For exampl=
e::
+
+         =E2=94=9C=E2=94=80=E2=94=80 meta-myproject/
+         =E2=94=94=E2=94=80=E2=94=80 myproject.conf.json
+
+   -  ``oe-template`` (*optional*, OpenEmbedded specific): OpenEmbedded =
template
+      to use. This cannot be used in conjunction with the ``bb-layers`` =
option
+      as it already provides a ready ``bblayers.conf`` file to use.
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
+Generic Configuration Examples
+------------------------------
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
+.. _ref-bbsetup-source-overrides:
+
+Source Overrides
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+See the definition of :term:`Source Override` in the Terminology section=
.
+
+These files are written in the JSON file format and are optionally passe=
d to the
+``--source-overrides`` argument of the :ref:`ref-bbsetup-command-init` c=
ommand.
+The ``--source-overrides`` option can be passed multiple times, in which=
 case the
+overrides are applied in the order specified in the command-line.
+
+Here is an example file that overrides the branch of the BitBake reposit=
ory to
+"master-next":
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
+                           "uri": "git://git.openembedded.org/bitbake;pr=
otocol=3Dhttps"
+                       }
+                   },
+                   "rev": "master-next"
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


