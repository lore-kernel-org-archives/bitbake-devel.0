Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DE9FF60EB
	for <webhook@archiver.kernel.org>; Tue, 31 Mar 2026 08:15:24 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15386.1774944914360537994
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Mar 2026 01:15:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=nhOd+IbW;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id CC07A4E42883
	for <bitbake-devel@lists.openembedded.org>; Tue, 31 Mar 2026 08:15:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A25D86029D;
	Tue, 31 Mar 2026 08:15:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AC03510450FF2;
	Tue, 31 Mar 2026 10:15:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774944912; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6P45JJd0fgE6H5JrxTm9kKaMyNc0mzEFcKSTHRirpTg=;
	b=nhOd+IbWE7R31dpj1w5aGcFSVuEeTkBEJBsXhC8NgL6RvQeb6CilvNrOo5KJ9WKzb7P3lo
	oVcLmmNWDWazp/8+2iZXNK6/0r1iNnMr5oAuwdMyo/3H5rikLlzqOikKbywvrfXByC0kOk
	2qEQn2rlKBkgx0ouy1skrEDpVH1O0iGji+6lmEI17/pRpM9s8jOGJF6DYUu+5Xedoz5g5M
	jJKDmmhR7fxiyoycZ5jzjUIvnw31CvZbAxyRIsaarYoaTrxeh1Xq6gc9YbiiV9LILjNPL1
	UpOk0dxFWJ+T8CKnTi6V/b5bSpqwAyJh+Ad1TpNVzcmKzNKHCFCUOiR6im0ulQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Tue, 31 Mar 2026 10:14:52 +0200
Subject: [PATCH 2/2] doc/bitbake-user-manual-environment-setup.rst: replace
 shell blocks by console
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-docs-fixes-v1-2-45ee34341e72@bootlin.com>
References: <20260331-docs-fixes-v1-0-45ee34341e72@bootlin.com>
In-Reply-To: <20260331-docs-fixes-v1-0-45ee34341e72@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5839;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=sldTZpzHi0cENzuSTCJDMP3kle1yGBxNnajv8r1OP4c=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpy4KNCivgqp+UJ/za2sx7ozz4LY4vrfvkMxyWa
 20RirdJIH2JAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCacuCjQAKCRDRgEFAKaOo
 NkD7D/4nFD3OYD/zbr/jt9IsxnO6xpHTREiC89otOBpjKLjgMczbNz3QRMqUpQJQy0DlVqXYYNf
 3FdDey8MbSZrRz9rvRUGC7CBop6yKlMwnac7+itcmQTonsplrDmZY/NXiYugOG2WRCjtNwVK89E
 6Nk7xX50LPch8Hi97Yz4LCcMwCIe9O552FIaSAvtl/Op8TIpZNG3qfffm2am1r5w8sO15SMDAv/
 e0a9DNW0ddf91g0g2r0KtGSDTvNVrdUgeK6i52dG0Tdszv/njv9jjXCQbhcj0jmZAs6MwQ3FfQA
 s53nzwGMmJshUysmj4Lz6eqdmM+ECq4jOTdUOTcy1QzWIpcyBh2oyJJXI+vyLKgI9wkmVULicMT
 JHlaLDDxqx+uOkD+zhVl1Nj+UTJQsbCJ33KFiqC3obnWKM86eZlk1BJz641ATvS9Br1GT9nALcu
 cYTgQ0syDXJ9TrAO1hKoNsWIFwZbQdJ03RPQO+M5TKlVAmh7BpDGtODCMUTLbSeOSZ0vyh88OdE
 wwqTM+XXpBVhN2XE5lwOiJUjHKyWs/zD3pCmo6o5r+BNXNZW65v2FdDHVjGnCGhdTaBxChbtUu3
 rEf+Hy3UmowuVT00A+pjQ8XSHKAPd1vle81/81h6VNL1RtDGtKN69EWubEC+HNBcEkjphbW9BPZ
 peHTKSU2L5cr5uw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Mar 2026 08:15:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19288

The appropriate lexer to use for command examples is console, not shell.
Replace all misuses of this lexer in this document.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 .../bitbake-user-manual-environment-setup.rst      | 30 +++++++++++-----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
index c7b73001404..ece872ad26c 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -27,7 +27,7 @@ Quick Start
 
 #. If you haven't already, clone the BitBake repository:
 
-   .. code-block:: shell
+   .. code-block:: console
 
       $ git clone https://git.openembedded.org/bitbake
 
@@ -36,7 +36,7 @@ Quick Start
 
    To start, run:
 
-   .. code-block:: shell
+   .. code-block:: console
 
       $ ./bitbake/bin/bitbake-setup init
 
@@ -94,7 +94,7 @@ Quick Start
 #. Source the ``init-build-env`` file present in the :term:`BitBake Build`
    directory:
 
-   .. code-block:: shell
+   .. code-block:: console
 
       $ source ./poky-master-poky-distro_poky-machine_qemux86-64/build/init-build-env
 
@@ -343,7 +343,7 @@ In addition, the command can take the following arguments:
 -  This example prompts the user to choose a :term:`Configuration Template` from
    a custom registry:
 
-   .. code-block:: shell
+   .. code-block:: console
 
       $ ./bitbake/bin/bitbake-setup \
           --setting default registry 'git://example.com/bitbake-setup-configurations.git;protocol=https;branch=main;rev=main' \
@@ -352,7 +352,7 @@ In addition, the command can take the following arguments:
 -  This example takes a :term:`Configuration Template` from a remote location
    (here, one of the default configuration in BitBake):
 
-   .. code-block:: shell
+   .. code-block:: console
 
       $ ./bitbake/bin/bitbake-setup init https://git.openembedded.org/bitbake/plain/default-registry/configurations/oe-nodistro-master.conf.json
 
@@ -363,7 +363,7 @@ In addition, the command can take the following arguments:
    -  A standalone :term:`Configuration Template` file.
    -  Choices passed on the command-line, applied non-interactively.
 
-   .. code-block:: shell
+   .. code-block:: console
 
       $ ./bitbake/bin/bitbake-setup \
           --setting default top-dir-prefix /work/bitbake-setup \
@@ -477,7 +477,7 @@ In addition, the command can take the following arguments:
    environment. Local commits in any layer directory are rebased on top of
    the new upstream revision and preserved:
 
-   .. code-block:: shell
+   .. code-block:: console
 
       $ bitbake-setup update
       NOTE: Bitbake-setup is using /path/to/bitbake-builds as top directory.
@@ -493,7 +493,7 @@ In addition, the command can take the following arguments:
 -  This example shows what happens when a layer directory contains staged or
    unstaged changes to tracked files. The update is blocked with an error:
 
-   .. code-block:: shell
+   .. code-block:: console
 
       $ bitbake-setup update
       NOTE: Bitbake-setup is using /path/to/bitbake-builds as top directory.
@@ -515,7 +515,7 @@ In addition, the command can take the following arguments:
 
    Stashing the changes and re-running resolves the issue:
 
-   .. code-block:: shell
+   .. code-block:: console
 
       $ git -C layers/openembedded-core stash
       $ bitbake-setup update
@@ -526,7 +526,7 @@ In addition, the command can take the following arguments:
    is automatically halted, and the ``dldir`` remote is left in the repository
    for manual resolution:
 
-   .. code-block:: shell
+   .. code-block:: console
 
       $ bitbake-setup update
       ERROR: Repository at layers/openembedded-core has local commits that could
@@ -539,7 +539,7 @@ In addition, the command can take the following arguments:
    The conflict can be resolved manually using the ``dldir`` remote that
    ``bitbake-setup`` adds to the repository:
 
-   .. code-block:: shell
+   .. code-block:: console
 
       $ git -C layers/openembedded-core rebase dldir/master
       # fix conflicts in an editor, then stage the resolved files:
@@ -552,7 +552,7 @@ In addition, the command can take the following arguments:
    preserves the conflicting directory under a timestamped backup path and
    re-clones the layer cleanly from upstream:
 
-   .. code-block:: shell
+   .. code-block:: console
 
       $ bitbake-setup update --rebase-conflicts-strategy=backup
       NOTE: Bitbake-setup is using /path/to/bitbake-builds as top directory.
@@ -583,7 +583,7 @@ In addition, the command can take the following arguments:
    the following commands can be used to apply these commits on top of the new
    upstream revision in the fresh clone:
 
-   .. code-block:: shell
+   .. code-block:: console
 
       $ git -C layers/openembedded-core-backup.20260329160426 log --oneline my-wip
       a1b2c3d u-boot: fix compilation with newer GCC
@@ -620,7 +620,7 @@ In addition, the command can take the following arguments:
    Once all desired commits have been recovered and verified, the backup
    directory can be removed:
 
-   .. code-block:: shell
+   .. code-block:: console
 
       $ rm -rf layers/openembedded-core-backup.20260329160426
 
@@ -856,7 +856,7 @@ These files are written in the JSON file format and are stored in a
 :term:`Registry`. They can also be standalone files directly passed to the
 :ref:`ref-bbsetup-command-init` command:
 
-.. code-block:: shell
+.. code-block:: console
 
    $ bitbake-setup init /path/to/config.conf.json
 

-- 
2.53.0


