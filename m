Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE0EFC97EB
	for <webhook@archiver.kernel.org>; Sun, 29 Mar 2026 18:34:31 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34714.1774809263056260880
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 29 Mar 2026 11:34:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm1 header.b=ECrtDx19;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-1329275-20260329183421f305c8e3a30002072b-mtiucb@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20260329183421f305c8e3a30002072b
        for <bitbake-devel@lists.openembedded.org>;
        Sun, 29 Mar 2026 20:34:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=CnK2Cmu+v2s96HGHUKyPbB8QDzt/La9E/MSU1CFpLjI=;
 b=ECrtDx195unNsphkmsMVbXberhiQh39OsgG6YKZ4qq5LLFi7wwyAueuct9jTF4wIf8a1xo
 7OrUFPZaQdmURdF9x0IiIR/bfYw7cYgbafWr4a77/X3k81gn3XMyIrzg1eNeBNw6oC5A2fTr
 yLP297f5zXFihSs07oK344S+fJ1YCqY0wgrMFTQDN/Ds1SoH0POftCBMxBISoyjyjYx7foiw
 lg9FkwSKf3cWA6eEBh2bj6W4IOsnkMoXYRcZzhUcClQW4GU1fFCbfUVpJbad4Da/Fq7XLx05
 OBJx+sp0wlHg2W5r7xEalMkL+N+qtSkWgKf77nhgcGNV2nRyw0fjGelQ==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH v3 14/14] doc: document new bitbake-setup init and update features
Date: Sun, 29 Mar 2026 20:33:01 +0200
Message-ID: <20260329183332.1996183-15-adrian.freihofer@siemens.com>
In-Reply-To: <20260329183332.1996183-1-adrian.freihofer@siemens.com>
References: <20260329183332.1996183-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 29 Mar 2026 18:34:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19266

From: Adrian Freihofer <adrian.freihofer@siemens.com>

Document the two new options introduced in the setup command:

- --init-vscode / --no-init-vscode (66c26e5f0): generates a
  bitbake.code-workspace file for VS Code in the Setup directory,
  with layer folders, BitBake extension settings, and file associations.
  Default is enabled when the 'code' binary is found on PATH.

- --rebase-conflicts-strategy (60ce61cca): controls the fallback
  behaviour when a layer repository cannot be updated in place due
  to local modifications or conflicting local commits. Documents both
  the 'abort' (default) and 'backup' values.

Also documents the in-place update behaviour of the update command
(fetch via dldir remote + rebase), with a cross-reference to the
unpack_update() section in the fetching chapter.

Also document that the update command is intended to be run from a
shell with the BitBake environment sourced, and why --autostash is not
used (transparency: uncommitted changes are surfaced rather than silently
stashed and re-applied).

Add examples for the four distinct update scenarios, using real output
from an actual update session:
- normal update with local commits rebased and preserved
- update blocked by uncommitted changes, with stash + retry steps
- rebase conflict with manual resolution via the dldir git remote,
  including the rebase --continue + re-run sequence
- rebase conflict resolved via --rebase-conflicts-strategy=backup,
  showing the real WARNING output and timestamped backup directory name,
  with a step-by-step git workflow (cd into the fresh clone, fetch the
  backup branch by local path, cherry-pick oldest-first) to recover
  commits from the backup, and cleanup instructions (rm -rf the backup,
  or remove the VS Code workspace folder via the UI or by re-running
  bitbake-setup update after deletion)

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 .../bitbake-user-manual-environment-setup.rst | 205 ++++++++++++++++++
 1 file changed, 205 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
index 37518fceb..c22e19bd6 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -327,6 +327,16 @@ In addition, the command can take the following arguments:
    with a ``local`` source in it. See the :ref:`ref-bbsetup-source-overrides` section
    for more information on source overrides.
 
+-  ``--init-vscode`` / ``--no-init-vscode``: generate (or skip generating) a
+   ``bitbake.code-workspace`` file in the :term:`Setup` directory. The workspace
+   file configures the `Yocto Project BitBake
+   <https://marketplace.visualstudio.com/items?itemName=yocto-project.yocto-bitbake>`_
+   VS Code extension with paths to the build directory and the init script, and
+   lists the layer directories as workspace folders. Any user-added folders or
+   settings in an existing workspace file are preserved across updates.
+   The default is ``true`` when ``code`` (the VS Code binary) is found on
+   ``PATH``, and ``false`` otherwise.
+
 ``bitbake-setup init`` Examples
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -410,6 +420,30 @@ the latest changes from the :term:`Configuration Template` it was constructed fr
 The :ref:`ref-bbsetup-command-status` command can be used to show the current
 status of the :term:`Setup` before updating it.
 
+This command is intended to be run from a shell where the BitBake environment
+has been sourced (e.g. after ``source build/init-build-env``), so that
+``bitbake-setup`` can automatically identify the current :term:`Setup` without
+requiring the ``--setup-dir`` argument.
+
+When a layer repository already exists in the :term:`Setup` (i.e. it has been
+previously checked out by ``bitbake-setup init`` or a prior ``update``), the
+update is performed *in place* using the fetcher's
+:ref:`unpack_update <bb-the-unpack-update>` method: the new upstream revision
+is fetched into the local download cache and then rebased on top of the
+checkout's current HEAD. This means any local commits in the layer directory
+are preserved and rebased onto the new upstream revision. If the working tree
+contains staged or unstaged changes to tracked files, the update is blocked
+until those changes are committed, stashed or discarded.
+
+.. note::
+
+   ``bitbake-setup`` performs the rebase to fast-forward local commits onto
+   the new upstream revision, but intentionally does not go further by using
+   ``--autostash`` (which would silently stash uncommitted changes before the
+   rebase and pop them afterwards). Any uncommitted modifications are surfaced
+   to the user before the update proceeds, so there are no surprises from an
+   automatic stash/pop cycle.
+
 In addition, the command can take the following arguments:
 
 -  ``--update-bb-conf``: whether to update the :term:`BitBake Build`
@@ -420,10 +454,181 @@ In addition, the command can take the following arguments:
    -  ``yes``: update the configuration files.
    -  ``no``: don't update the configuration files.
 
+-  ``--rebase-conflicts-strategy``: what to do when a layer repository has
+   local modifications or commits that prevent an in-place update. Accepted
+   values are:
+
+   -  ``abort`` (default): stop with an error message describing the problem.
+      The repository is left in its previous state (the failed rebase is
+      automatically aborted). The error message includes a hint to re-run with
+      ``--rebase-conflicts-strategy=backup``.
+   -  ``backup``: rename the conflicting layer directory to a timestamped
+      ``<name>-backup-<timestamp>`` path (preserving local work), then
+      re-clone the layer from upstream into a fresh directory.
+
 -  ``--setup-dir``: path to the :term:`Setup` to update. Not required if the
    command is invoked from an initialized BitBake environment that contains
    :term:`BBPATH`.
 
+``bitbake-setup update`` Examples
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+-  This example performs a standard update from an initialized BitBake
+   environment. Local commits in any layer directory are rebased on top of
+   the new upstream revision and preserved:
+
+   .. code-block:: shell
+
+      $ bitbake-setup update
+      NOTE: Bitbake-setup is using /path/to/bitbake-builds as top directory.
+      NOTE: Looking up config poky-master in configuration registry
+      NOTE: Layer repository https://git.openembedded.org/openembedded-core
+            checked out into /path/to/bitbake-builds/poky-master/layers/openembedded-core
+            updated revision master from d383ea3... to b50d6de...
+      Fetching layer/tool repositories into /path/to/bitbake-builds/poky-master/layers
+          bitbake
+          meta-yocto
+          openembedded-core
+
+-  This example shows what happens when a layer directory contains staged or
+   unstaged changes to tracked files. The update is blocked with an error:
+
+   .. code-block:: shell
+
+      $ bitbake-setup update
+      NOTE: Bitbake-setup is using /path/to/bitbake-builds as top directory.
+      NOTE: Looking up config poky-master in configuration registry
+      Fetching layer/tool repositories into /path/to/bitbake-builds/poky-master/layers
+          bitbake
+          meta-yocto
+          openembedded-core
+      ERROR: Unpack failure for URL:
+       'git://git.openembedded.org/openembedded-core;protocol=https;rev=master;branch=master;destsuffix=openembedded-core'.
+       Repository at /path/to/bitbake-builds/poky-master/layers/openembedded-core has uncommitted changes, unable to update:
+       M meta/recipes-devtools/ccache/ccache_4.13.1.bb
+
+      Commit, stash or discard your changes and re-run the update.
+      Use 'bitbake-setup update --rebase-conflicts-strategy=backup'
+      to automatically back up the directory and re-clone from upstream,
+      or use 'bitbake-setup init -L openembedded-core /path/to/local/checkout'
+      to work with a local checkout instead.
+
+   Stashing the changes and re-running resolves the issue:
+
+   .. code-block:: shell
+
+      $ git -C layers/openembedded-core stash
+      $ bitbake-setup update
+      $ git -C layers/openembedded-core stash pop
+
+-  This example shows what happens when a layer directory contains local
+   commits that conflict with the incoming upstream changes. The failed rebase
+   is automatically aborted, and the ``dldir`` remote is left in the repository
+   for manual resolution:
+
+   .. code-block:: shell
+
+      $ bitbake-setup update
+      ERROR: Repository at layers/openembedded-core has local commits that could
+      not be rebased onto the new upstream revision:
+      ...
+      Note: the 'dldir' remote points to the local download cache and may be
+      used to resolve the conflict manually.
+      Once resolved, re-run the update.
+
+   The conflict can be resolved manually using the ``dldir`` remote that
+   ``bitbake-setup`` adds to the repository:
+
+   .. code-block:: shell
+
+      $ git -C layers/openembedded-core rebase dldir/master
+      # fix conflicts in an editor, then stage the resolved files:
+      $ git -C layers/openembedded-core add meta/recipes-core/base-files/base-files.bb
+      $ git -C layers/openembedded-core rebase --continue
+      $ bitbake-setup update
+
+-  When manual conflict resolution is not desired, the
+   ``--rebase-conflicts-strategy=backup`` option can be used instead. It
+   preserves the conflicting directory under a timestamped backup path and
+   re-clones the layer cleanly from upstream:
+
+   .. code-block:: shell
+
+      $ bitbake-setup update --rebase-conflicts-strategy=backup
+      NOTE: Bitbake-setup is using /path/to/bitbake-builds as top directory.
+      NOTE: Looking up config poky-master in configuration registry
+      NOTE: Layer repository https://git.openembedded.org/openembedded-core checked
+            out into /path/to/bitbake-builds/poky-master/layers/openembedded-core
+            updated revision master from 2ec283e... to b50d6de...
+      Fetching layer/tool repositories into /path/to/bitbake-builds/poky-master/layers
+          bitbake
+          meta-yocto
+          openembedded-core
+      WARNING: Unpack failure for URL:
+        'git://git.openembedded.org/openembedded-core;protocol=https;rev=master;branch=master;destsuffix=openembedded-core'.
+        Repository at /path/to/bitbake-builds/poky-master/layers/openembedded-core
+        has local commits that could not be rebased onto the new upstream revision:
+      ...
+      Note: the 'dldir' remote points to the local download cache and may be used to resolve the conflict manually.
+      Once resolved, re-run the update.
+      Renaming /path/to/bitbake-builds/poky-master/layers/openembedded-core to
+        /path/to/bitbake-builds/poky-master/layers/openembedded-core-backup.20260329160426
+        to preserve your work, then re-cloning from upstream.
+
+   The backup directory is a complete git repository. Local commits can be
+   recovered from it after the update by fetching a branch from the backup
+   into the fresh clone (git accepts local paths as remote URLs) and then
+   cherry-picking the desired commits. For example, given a ``my-wip`` branch
+   with two commits existing in the backup repository and not in the fresh clone,
+   the following commands can be used to apply these commits on top of the new
+   upstream revision in the fresh clone:
+
+   .. code-block:: shell
+
+      $ git -C layers/openembedded-core-backup.20260329160426 log --oneline my-wip
+      a1b2c3d u-boot: fix compilation with newer GCC
+      2ec283e base-files: update version
+      ...
+
+      $ cd layers/openembedded-core
+      $ git checkout -b my-wip
+      Switched to a new branch 'my-wip'
+      $ git fetch ../openembedded-core-backup.20260329160426 my-wip
+
+      $ git cherry-pick 2ec283e
+      # resolve any conflicts, then stage the resolved files:
+      $ git add meta/recipes-core/base-files/base-files.bb
+      $ git cherry-pick --continue
+
+      $ git cherry-pick a1b2c3d
+      # resolve any conflicts, then stage the resolved files:
+      $ git add meta/recipes-devtools/u-boot/u-boot_2026.04.bb
+      $ git cherry-pick --continue
+
+      $ cd ../..
+
+   The sequence above is:
+
+   #. Inspect the backup's branch history to identify the commits to recover.
+   #. Change into the fresh clone and create a matching branch.
+   #. Fetch the backup branch so its objects become available locally. Git
+      accepts filesystem paths as remote URLs, and from inside
+      ``layers/openembedded-core/``, ``../`` points to ``layers/``, where the
+      backup directory sits.
+   #. Cherry-pick the commits in oldest-first order.
+
+   Once all desired commits have been recovered and verified, the backup
+   directory can be removed:
+
+   .. code-block:: shell
+
+      $ rm -rf layers/openembedded-core-backup.20260329160426
+
+   If a VSCode workspace is in use, the backup directory will appear as an
+   additional workspace folder until it is cleaned up. It can be removed from
+   the workspace via the VS Code UI by right-clicking the folder and selecting
+   *Remove Folder from Workspace*.
+
 .. _ref-bbsetup-command-install-buildtools:
 
 ``bitbake-setup install-buildtools``
-- 
2.53.0


