Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71097FC97F4
	for <webhook@archiver.kernel.org>; Sun, 29 Mar 2026 18:34:31 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34709.1774809263055401340
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 29 Mar 2026 11:34:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm1 header.b=d4dY7S2g;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-1329275-202603291834191db00c638e00020779-8ohxm4@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202603291834191db00c638e00020779
        for <bitbake-devel@lists.openembedded.org>;
        Sun, 29 Mar 2026 20:34:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=fRjQ/6QgIrDrTp8RzdAaTHXr8hrSbQXhhZZ/RJRGTSg=;
 b=d4dY7S2gi1Q3bTNdeugzQ2ov/FAQAlC0+AUlRcpckUqhS0HacroVSvX4v2rQvf1NgqJ6Kh
 7HaglavIm3ACd3RGDC5LbZBoYoHK6xeW7ekkECcTwIhYW+PIaTUKU+D4uJpDAe6Mt6Z+H2Bv
 3o0XOa24HgxPP3QbaY8dZ8WKtmmuz3obJycWQfw7apM4GGWqw6WL8uwMld01YegjyFyboaU2
 A+Jyg+4rs8VGR7gx+OT9VLDYzNEG8/ZZ9D/LQIn7rbssKi91rSAV4+4atCNpdrRSRcSekGT/
 pGuCSibhd0pL9vuNz05PZOO78DM4UsErhJnwTiPRrYs38v3xO/NhI2Gg==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH v3 00/14] bitbake-setup: improvements, VSCode workspace generation
Date: Sun, 29 Mar 2026 20:32:47 +0200
Message-ID: <20260329183332.1996183-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 29 Mar 2026 18:34:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19263

From: Adrian Freihofer <adrian.freihofer@siemens.com>

Changes from v2 to v3:
- Rebased on master-next from 29.3.2026:
- New commit:
  bitbake-setup: Fix type annotation for descriptions parameter in print_configs
  might be squashed into commit on master-next
- New exception: bb.fetch2.RebaseError
  - Adapted tests accordingly
  - Simplified code in bitbake-setup accordingly
- New commit:
  bitbake-setup: catch unexpected exceptions and show a clean error message
- Documentation
  - git fetcher unpack_update
  - bitbake-setup non destructive update mode

Adds:

- fetch2: new LocalModificationsError and RebaseError exception subclasses of
  UnpackError, raised by unpack_update() to give callers a precise handle on
  the two blocking update conditions (uncommitted working-tree changes vs.
  local commits that conflict with upstream). Both carry a user-facing message
  with the affected path and, for RebaseError, the git rebase output and a
  hint about the 'dldir' remote.

- Tests for bitbake fetcher unpack_update: add GitUnpackUpdateTest covering
  the full unpack_update workflow — fast-forward rebase with local commits,
  dldir remote setup, conflict detection, staged/modified file blocking,
  shallow clone rejection, and stale dldir remote.

- bitbake-setup bug fixes: always restore sys.stdout after fetch log
  redirection (try/finally); fix dead guards in check_setupdir_files that
  used stale key names; clean up imports in tests/setup; fix the type
  annotation for the 'descriptions' parameter of print_configs (list[str] |
  None instead of list[str]).

- bitbake-setup: catch unexpected exceptions and show a clean error message:
  a top-level try/except in main() converts any unhandled exception into a
  single ERROR log line and non-zero exit. Full traceback is still shown with
  --debug; SystemExit and KeyboardInterrupt are re-raised normally.

- VSCode workspace generation (--init-vscode / --no-init-vscode):
  bitbake-setup init generates a bitbake.code-workspace file that configures
  the Yocto BitBake VS Code extension (pathToBuildFolder, pathToEnvScript,
  disableConfigModification), Python analysis extra paths, file associations
  for *.conf and *.inc, and a top-level folder for each layer git repository
  and for build/conf. User-added folders and settings are preserved on update;
  a corrupt workspace file is detected and left unchanged. The flag defaults
  to True when the 'code' binary is found on PATH.

- bitbake-setup --rebase-conflicts-strategy (abort|backup):
  When unpack_update() raises LocalModificationsError or RebaseError, the
  'abort' strategy (default) stops with a structured error that names the
  affected source and hints at --rebase-conflicts-strategy=backup. The
  'backup' strategy renames the affected layer directory to a timestamped
  backup and re-clones from upstream, preserving local work while delivering
  a clean tree. Strategy is threaded from CLI through build_status() and
  update_build() to checkout_layers().

- Documentation: new "Non-Destructive Update (unpack_update)" section in the
  fetching chapter describing the three-step internal process (dldir remote,
  fetch, rebase), the two error conditions, and the shallow/stale-dldir
  limitation. Updated bitbake-setup chapter documents --init-vscode,
  --rebase-conflicts-strategy, the in-place update behaviour, and four update
  scenario examples with real output.

Adrian Freihofer (14):
  bitbake-setup: Fix type annotation for descriptions parameter in
    print_configs
  fetch2: add LocalModificationsError and RebaseError exceptions
  bitbake-selftest: add GitUnpackUpdateTest
  tests/fetch: remove unused import, fix trailing whitespace
  doc: document the unpack_update() non-destructive git update method
  bitbake-setup: always restore sys.stdout
  tests/setup: cleanup imports
  tests/setup: fix dead check_setupdir_files guards
  bitbake-setup: generate config files for VSCode
  tests/setup: add test_vscode for VSCode workspace generation
  bitbake-setup: add --rebase-conflicts-strategy to the update command
  tests/setup: add test_update_rebase_conflicts_strategy
  bitbake-setup: catch unexpected exceptions and show a clean error
    message
  doc: document new bitbake-setup init and update features

 bin/bitbake-setup                             | 235 +++++++-
 .../bitbake-user-manual-environment-setup.rst | 205 +++++++
 .../bitbake-user-manual-fetching.rst          |  45 ++
 lib/bb/fetch2/__init__.py                     |  17 +
 lib/bb/fetch2/git.py                          |   7 +-
 lib/bb/tests/fetch.py                         | 566 +++++++++++++++++-
 lib/bb/tests/setup.py                         | 202 ++++++-
 7 files changed, 1243 insertions(+), 34 deletions(-)

-- 
2.53.0


