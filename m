Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87961C4829A
	for <webhook@archiver.kernel.org>; Sun, 11 Feb 2024 19:59:00 +0000 (UTC)
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
 by mx.groups.io with SMTP id smtpd.web10.35306.1707648613776395337
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 11 Feb 2024 02:50:14 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@posteo.com header.s=2017 header.b=lQtHVE87;
 spf=pass (domain: posteo.com, ip: 185.67.36.65, mailfrom: simone.p.weiss@posteo.com)
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id CBFEB240028
	for <bitbake-devel@lists.openembedded.org>; Sun, 11 Feb 2024 11:50:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.com; s=2017;
	t=1707648611; bh=sk7j57tAp/s0+S+KpEy6r2AGop5AsagvJwPnarKsGJg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=lQtHVE87p1fXkSp846W+Kfw0fkT6EUwl1yyyxw3YCDqG8n6QnPh8uuXj9I4CtJGNX
	 Hi/Sd56R3sQun9evnAkZoHRgrRWMIVcJlU8eVvbOo7/WNd4NwTkLci94SfNjk8imEF
	 UbuMKnIA065+RTcF/t5ZIlH7vr3OIRnwCgn3odTMktp1QcmgjiHoLM0PnvSP7eIdQk
	 l1XvqOElAHAq5+cuD5nfzIwEDxi/3Yez3tLeePwWUzjNIN5fTgLfiz8wzHYyn/MsO+
	 J7lnCLwJlZl2gsjBboxHaOqPlZzyC8kdRuGMxWd+5kuTD+JK+51H3fX5tJqormuEzt
	 IQk+7i8A9482g==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4TXkrL4sPyz6twn;
	Sun, 11 Feb 2024 11:50:10 +0100 (CET)
From: =?UTF-8?B?U2ltb25lIFdlacOf?= <simone.p.weiss@posteo.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	=?UTF-8?q?Simone=20Wei=C3=9F?= <simone.p.weiss@posteo.com>
Subject: [PATCH] bitbake: doc: Add section for variable context
Date: Sun, 11 Feb 2024 10:40:56 +0000
Message-Id: <20240211104056.85709-1-simone.p.weiss@posteo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 11 Feb 2024 19:59:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15879

From: Simone Wei=C3=9F <simone.p.weiss@posteo.com>

This is inspired by the same section in the yocto-docs. It aims to provid=
e
information in what contexts(recipes, .conf, bbclass,...) a variable is u=
sually
used. For that I tried to group similar variables, so that a short overvi=
ew is
given. This was inspired by [YOCTO #14072], but of course does not implem=
ent a
warning if a variable is used in an unintended context.

Signed-off-by: Simone Wei=C3=9F <simone.p.weiss@posteo.com>
---
 ...bake-user-manual-ref-variables-context.rst | 77 +++++++++++++++++++
 bitbake/doc/index.rst                         |  1 +
 2 files changed, 78 insertions(+)
 create mode 100644 bitbake/doc/bitbake-user-manual/bitbake-user-manual-r=
ef-variables-context.rst

diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-vari=
ables-context.rst b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-r=
ef-variables-context.rst
new file mode 100644
index 0000000000..9b94e09299
--- /dev/null
+++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables-c=
ontext.rst
@@ -0,0 +1,77 @@
+.. SPDX-License-Identifier: CC-BY-SA-2.0-UK
+
+****************
+Variable Context
+****************
+
+Variables might only have an impact or can be used in certain contexts. =
Some
+should only be used in global files like ``.conf``, while others are int=
ended only
+for local files like ``.bb``. This chapter aims to describe some importa=
nt variable
+contexts.
+
+.. _ref-varlcontext-configuration:
+
+#.  **BitBakes own configuration**: Variables starting with `BB_` usuall=
y
+    configure the behaviour of BitBake itself. For example, one could co=
nfigure:
+
+    - system resources, like disk space to be used (:term:`BB_DISKMON_DI=
RS`),
+      or number of tasks to be run in parallel by BitBake (:term:`BB_NUM=
BER_THREADS`).
+
+    - how the fetchers shall behave, e.g., :term:`BB_FETCH_PREMIRRORONLY=
` is used
+      by BitBake to determine if BitBake's fetcher shall search only
+      :term:`PREMIRRORS` for files.
+
+    Those variables are usually configured globally.
+
+#.  **BitBake configuration**: There are variables:
+
+    - like :term:`B` or :term:`T`, that are used to specify directories =
used by
+      BitBake during the build of a particular recipe. Those variables a=
re
+      specified in ``bitbake.conf``. Some, like :term:`B`, are quite oft=
en
+      overwritten in recipes.
+
+    - starting with `FAKEROOT` configure how the fakeroot command is han=
dled.
+      Those are usually set by ``bitbake.conf`` and might get adapted in=
 a
+      ``bbclass``.
+
+    - detailing where BitBake will store and fetch information from for
+      preservation between build runs like :term:`CACHE`, :term:`DL_DIR`=
 or
+      :term:`PERSISTENT_DIR`. Those are usually global.
+
+
+#.  **Layers and files**: Variables starting with `LAYER` configure how
+    BitBake handles layers. Additionally, variables starting with `BB` c=
onfigure
+    how layers and files are handled. For example:
+
+    - :term:`LAYERDEPENDS` is used to configure on which layers a given =
layer
+      depends.
+
+    - the configured layers are contained in :term:`BBLAYERS` and files =
in
+      :term:`BBFILES`.
+
+    Those variables are often used in the files ``layer.conf`` and ``bbl=
ayers.conf``.
+
+#.  **Recipes and packages**: Variables handling recipes and packages ca=
n be split into:
+
+    - :term:`PN`, :term:`PV` or :term:`PF` for example, contain informat=
ion about the
+      name or revision of a recipe or package. Usually, the default set =
in
+      ``bitbake.conf`` is used, but those are from time to time overwrit=
ten in recipes.
+
+    - :term:`SUMMARY`, :term:`DESCRIPTION`, :term:`LICENSE` or :term:`HO=
MEPAGE`
+      contain the expected information and should be set specifically fo=
r every
+      recipe.
+
+    - In recipes, variables are also used to control build and runtime
+      dependencies between recipes/packages with other recipes/packages.=
 The
+      most common should be: :term:`PROVIDES`, :term:`RPROVIDES`, :term:=
`DEPENDS`,
+      and :term:`RDEPENDS`.
+
+    - There are further variables starting with `SRC` that specify the s=
ources in
+      a recipe like :term:`SRC_URI` or :term:`SRCDATE`. Those are also u=
sually set
+      in recipes.
+
+    - Which version or=C2=A0 provider of a recipe should be given prefer=
ence when
+      multiple recipes would provide the same item, is controlled by var=
iables
+      starting with ``PREFERRED_``. Those are normally set in the config=
uration
+      files of a ``MACHINE`` or ``DISTRO``.
+
diff --git a/bitbake/doc/index.rst b/bitbake/doc/index.rst
index 3ff8b1580f..30d2a5e3c7 100644
--- a/bitbake/doc/index.rst
+++ b/bitbake/doc/index.rst
@@ -15,6 +15,7 @@ BitBake User Manual
    bitbake-user-manual/bitbake-user-manual-metadata
    bitbake-user-manual/bitbake-user-manual-fetching
    bitbake-user-manual/bitbake-user-manual-ref-variables
+   bitbake-user-manual/bitbake-user-manual-ref-variables-context
    bitbake-user-manual/bitbake-user-manual-hello
=20
 .. toctree::
--=20
2.39.2


