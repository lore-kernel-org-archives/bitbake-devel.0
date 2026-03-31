Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01C3FF60E9
	for <webhook@archiver.kernel.org>; Tue, 31 Mar 2026 08:15:14 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15385.1774944913599415709
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Mar 2026 01:15:14 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bootlin.com header.s=dkim header.b=DQqUWxNb;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0D50C4E42881
	for <bitbake-devel@lists.openembedded.org>; Tue, 31 Mar 2026 08:15:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D20B76029D;
	Tue, 31 Mar 2026 08:15:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DE7A010450FD3;
	Tue, 31 Mar 2026 10:15:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774944911; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=hqJSGJmILKKseQg/nXLbVPNmh2DvQLxN18agS3apG2Y=;
	b=DQqUWxNbhdL61HxtHeLNseC1yhVPY6WgcVpaxOIban/l4iQJM85wA9y4TN+zV0g0YQ5jvc
	bC07rijMXS9fUumEzyI7s/ef5cfA7udwYqyNFzI6Dq6aFJ2gcaw4qAUbScHGV+w8Oc0aGP
	Of/1quiUjVxOisOfAwy8yrFaItOB0NQa2frjpDt9k39NIOnMt9ipoytw9XkZ/0i2tNwg75
	foFyN6qH357li2tzE/c/OqVmfSKWLjCnMexZPT7p8f5f1W3M9cZ2xYhKxDJgGsPQfgvU26
	Z+xMIkOO0K93+AbQw7lsarX4SvN1NwuE7sznVQL3dglprl5UBZjI2J1EdJin1w==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Tue, 31 Mar 2026 10:14:51 +0200
Subject: [PATCH 1/2] bitbake-setup: rename "abort" rebase conflict stragegy
 to "halt"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20260331-docs-fixes-v1-1-45ee34341e72@bootlin.com>
References: <20260331-docs-fixes-v1-0-45ee34341e72@bootlin.com>
In-Reply-To: <20260331-docs-fixes-v1-0-45ee34341e72@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7913;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=dw2+8gBHJDJ8fwjM86GXm/kUwCVnX2LPTFHws2eGiqw=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpy4KNh3d6N4vS6Ms69YHCE82H9o5886yNHNN8K
 dmiug1RuyuJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCacuCjQAKCRDRgEFAKaOo
 NlTgD/4mnkfmk9m73AC6fhdcbIJWEAud8rYB3MGTMFvO+yL0RzVCKRq+XkCv0/Nmb9gvDJtdQlZ
 qXM79PlG1EyrrbNvAsjm2ytt43BkcdI7NmcuLSNxQ3I/xFFhJK7+ZAiu+B9WL2f3M9k3EGHmr4e
 oMglesA2xRSgEB9/0E3XH24Thuz+v+EXnizvF9u/pstCjcLGSmuNNBT3gFJDpqg79EQUgkJn1wF
 ebza84Gu5K1fymIyw9SUKmYiHTHhifpogC51RB2hsOby33M1irpOnYVy9+dXjbRuZI4nk/L1OdO
 UvEs0jUbp2ZvAIh6L6unL5Ks5SQ+wDbEVNXUdwfqEWGfqCdIMNnqvuUNN1QRG/irYE/y9vBZNHF
 c4cj0csolnqBvEqi3tU1xu+8nQc1W6Q9aYEf2FgVYjcBaRrqvVAbNU/MUWOtzDto4AwNkUedkwW
 9ZwpYYH4nRf2oM6QL9mj4QKDohSq1ACToRbwPoDQnxdJVZQ5r5HcGyHi1bnlX6PWqndbmie74B8
 mBx0CG11yzmjGbIQ9mH5DZElak27pUQxFGUUxIWctW0vY8swsdjVcRyFmPW1MVeeDJhLW8NXsYF
 BTTAAnBfv4tHBEITiA/v+kkJiThbs/fCwfWpNmIne0B7BIPXSmZOW0fLWGCryCQb219Ydh1I8vA
 WYjd7e6+sQvfKUQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Mar 2026 08:15:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19287

As per [1], do not use the word "abort" and replace it with "halt" for
the rebase conflicts strategy. This is something we try to follow in our
documentation.

[1]: https://inclusivenaming.org/word-lists/tier-1/abort/

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 bin/bitbake-setup                                                 | 8 ++=
++----
 doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst | 6 ++=
+---
 doc/bitbake-user-manual/bitbake-user-manual-fetching.rst          | 2 +-
 lib/bb/tests/setup.py                                             | 8 ++=
++----
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index b02cbc2b1c4..33cbefb4914 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -167,7 +167,7 @@ def _get_remotes(r_remote):
=20
     return remotes
=20
-def checkout_layers(layers, confdir, layerdir, d, rebase_conflicts_strat=
egy=3D'abort'):
+def checkout_layers(layers, confdir, layerdir, d, rebase_conflicts_strat=
egy=3D'halt'):
     def _checkout_git_remote(r_remote, repodir, layers_fixed_revisions):
         rev =3D r_remote['rev']
         branch =3D r_remote.get('branch', None)
@@ -458,7 +458,7 @@ def merge_overrides_into_sources(sources, overrides):
             layers[k] =3D v
     return layers
=20
-def update_build(config, confdir, setupdir, layerdir, d, update_bb_conf=3D=
"prompt", init_vscode=3DFalse, rebase_conflicts_strategy=3D'abort'):
+def update_build(config, confdir, setupdir, layerdir, d, update_bb_conf=3D=
"prompt", init_vscode=3DFalse, rebase_conflicts_strategy=3D'halt'):
     layer_config =3D merge_overrides_into_sources(config["data"]["source=
s"], config["source-overrides"]["sources"])
     sources_fixed_revisions =3D checkout_layers(layer_config, confdir, l=
ayerdir, d, rebase_conflicts_strategy=3Drebase_conflicts_strategy)
     bitbake_config =3D config["bitbake-config"]
@@ -1273,9 +1273,9 @@ def main():
     parser_update =3D subparsers.add_parser('update', help=3D'Update a s=
etup to be in sync with configuration')
     add_setup_dir_arg(parser_update)
     parser_update.add_argument('--update-bb-conf', choices=3D['prompt', =
'yes', 'no'], default=3D'prompt', help=3D'Update bitbake configuration fi=
les (bblayers.conf, local.conf) (default: prompt)')
-    parser_update.add_argument('--rebase-conflicts-strategy', choices=3D=
['abort', 'backup'], default=3D'abort',
+    parser_update.add_argument('--rebase-conflicts-strategy', choices=3D=
['halt', 'backup'], default=3D'halt',
                         help=3D"What to do when a layer repository has l=
ocal modifications that prevent "
-                             "an in-place update: 'abort' (default) abor=
ts with an error message; "
+                             "an in-place update: 'halt' (default) halts=
 with an error message; "
                              "'backup' renames the directory to a timest=
amped backup and re-clones from upstream.")
     parser_update.set_defaults(func=3Dbuild_update)
=20
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setu=
p.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
index c22e19bd665..c7b73001404 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -458,9 +458,9 @@ In addition, the command can take the following argum=
ents:
    local modifications or commits that prevent an in-place update. Accep=
ted
    values are:
=20
-   -  ``abort`` (default): stop with an error message describing the pro=
blem.
+   -  ``halt`` (default): stop with an error message describing the prob=
lem.
       The repository is left in its previous state (the failed rebase is
-      automatically aborted). The error message includes a hint to re-ru=
n with
+      automatically halted). The error message includes a hint to re-run=
 with
       ``--rebase-conflicts-strategy=3Dbackup``.
    -  ``backup``: rename the conflicting layer directory to a timestampe=
d
       ``<name>-backup-<timestamp>`` path (preserving local work), then
@@ -523,7 +523,7 @@ In addition, the command can take the following argum=
ents:
=20
 -  This example shows what happens when a layer directory contains local
    commits that conflict with the incoming upstream changes. The failed =
rebase
-   is automatically aborted, and the ``dldir`` remote is left in the rep=
ository
+   is automatically halted, and the ``dldir`` remote is left in the repo=
sitory
    for manual resolution:
=20
    .. code-block:: shell
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/d=
oc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index c2747c40124..fbfc9600f12 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -223,7 +223,7 @@ The method raises an error if:
 -  The working tree contains staged or unstaged changes to tracked
    files (``LocalModificationsError``).
 -  Local commits cannot be cleanly rebased onto the new upstream
-   revision (``RebaseError``). A failed rebase is automatically aborted
+   revision (``RebaseError``). A failed rebase is automatically halted
    before the exception is raised.
 -  The download cache does not contain a sufficiently recent clone
    of the repository, or the checkout is a shallow clone.
diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index 638d56d3bb3..c85013eb4d4 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -639,14 +639,14 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"])=
)
         """Test the --rebase-conflicts-strategy option for the update co=
mmand.
=20
         Covers three scenarios not exercised by test_setup:
-        1. Uncommitted tracked-file change (LocalModificationsError) + d=
efault 'abort'
+        1. Uncommitted tracked-file change (LocalModificationsError) + d=
efault 'halt'
            strategy =E2=86=92 clean error message containing 'has uncomm=
itted changes' and a
            hint at --rebase-conflicts-strategy=3Dbackup; no backup direc=
tory is created.
         2. Same uncommitted change + 'backup' strategy =E2=86=92 directo=
ry is renamed to a
            timestamped backup and the layer is re-cloned cleanly.
         3. Committed local change that conflicts with an incoming upstre=
am commit
            (RebaseError):
-           a. Default 'abort' strategy =E2=86=92 error containing 'Merge=
 conflict' and the
+           a. Default 'halt' strategy =E2=86=92 error containing 'Merge =
conflict' and the
               --rebase-conflicts-strategy=3Dbackup hint; no backup direc=
tory is created.
            b. 'backup' strategy =E2=86=92 backup + re-clone instead of a=
 hard failure.
         """
@@ -663,7 +663,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         layer_path =3D os.path.join(setuppath, 'layers', 'test-repo')
         layers_path =3D os.path.join(setuppath, 'layers')
=20
-        # Scenario 1: uncommitted tracked change, default 'abort' strate=
gy
+        # Scenario 1: uncommitted tracked change, default 'halt' strateg=
y
         # Advance upstream so an update is required.
         self.add_file_to_testrepo('test-file', 'upstream-v2\n')
         # Modify the same tracked file in the layer without committing.
@@ -677,7 +677,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         self.assertIn('--rebase-conflicts-strategy=3Dbackup', str(ctx.ex=
ception))
         # No backup directory must have been created.
         self.assertEqual(self._count_layer_backups(layers_path), 0,
-                         "abort strategy must not create any backup")
+                         "halt strategy must not create any backup")
=20
         # Scenario 2: same uncommitted change, 'backup' strategy
         out =3D self.runbbsetup("update --update-bb-conf=3D'no' --rebase=
-conflicts-strategy=3Dbackup")

--=20
2.53.0


