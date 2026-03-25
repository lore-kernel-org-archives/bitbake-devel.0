Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF5EFEA826
	for <webhook@archiver.kernel.org>; Wed, 25 Mar 2026 07:14:12 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16762.1774422847650004916
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 25 Mar 2026 00:14:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm1 header.b=NAZHhhe7;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-1329275-202603250714044721ec9401000207c1-s8g437@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202603250714044721ec9401000207c1
        for <bitbake-devel@lists.openembedded.org>;
        Wed, 25 Mar 2026 08:14:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=a28sr2MnPbPhLUCW5YzgFekEtDEeA01PBw7NtOAs1x8=;
 b=NAZHhhe7rdHKGcJXH1kDVXIs61TVWZrd1ai2+DPjH20j6Rka0RYQ1u404qaWoAFyy/DQ4d
 ZmQ0wpYndOfY82ufd9uzlbA/SfcYZzR4xdWsoYbJneTWJEBB0vP5Elu7TbpS04RGc+Dyka4O
 NVhXs+H4LWbzyRzEf3OKA7G95GkmvHqB6Q8ElnJfKgzNn0n4miOjteyvBQ+tri77FP7GV7Zk
 iFOwBSg1QCLe0B079ZmILcurMFs3UXaF35hukN4jiOjVmX4vR5wITw6+XGTqHCxtxAsfn4EA
 8+J4csagvin84hGkyMzI+PlDyM0ETaxIgvCtsSqBWlGSOLAYa9m+oV5w==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH v2 00/10] bitbake-setup: improvements, VSCode workspace generation
Date: Wed, 25 Mar 2026 07:51:42 +0100
Message-ID: <20260325071342.47272-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 25 Mar 2026 07:14:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19225

From: Adrian Freihofer <adrian.freihofer@siemens.com>

Comparison to v1:
- Rebased on latest master
- Addressed feedback from Richard:
  - There is now a bb.fetch2.LocalModificationsError
  - Adapted test accordingly (changed order of commits because of that)
- Addressed feedback from Alexander:
  - run configure_vscode() inside setup_bitbake_build(), simplifying the logic
  - Remove the --init-vscode option from update (only init supports it now)
  - Renamed --rebase-strategy to --rebase-conflicts-strategy with
    'abort' and 'backup' options
  - Adapted tests accordingly


Adds:
- Tests for bitbake fetcher unpack_update: add GitUnpackUpdateTest covering
  the full unpack_update workflow — fast-forward rebase with local commits,
  dldir remote setup, conflict detection, staged/modified file blocking,
  untracked file handling, shallow clone rejection, and stale dldir remote.

- Some findings in bitbake-setup: always restore sys.stdout after fetch log
  redirection; fix dead guards in check_setupdir_files; clean up imports;
  turn unhandled Exception in main() into a clean ERROR log line and non-zero
  exit instead of a raw traceback; report local modifications that block an
  update with an actionable error message.

- VSCode workspace generation (--init-vscode / --no-init-vscode):
  bitbake-setup init and update can generate a bitbake.code-workspace file
  that configures the Yocto BitBake VS Code extension, Python analysis paths,
  file associations, and folders for each layer repository. User-added folders
  and settings are preserved on update; a corrupt workspace file is detected
  and left unchanged.

- bitbake-setup rebase strategy (--rebase-conflicts-strategy abort|backup):
  When unpack_update() cannot rebase a layer repository due to uncommitted
  local modifications or a committed local change that causes a rebase
  conflict, the default 'abort' strategy aborts with a clear, actionable
  error message. The 'backup' strategy renames the directory to a timestamped
  backup and re-clones from upstream instead.


Testing
- bitbake-selftest bb.tests.fetch.GitUnpackUpdateTest
- bitbake-selftest bb.tests.setup
- Manual testing with --rebase-conflicts-strategy abort:
  - bitbake-setup init
  - cd layers/openembedded-core
  - git checkout older commit
  - modify a file to provoke a conflict without committing
  - bitbake-setup update
    --> fails with a clear message about local modifications blocking the update
  - git stash
    bitbake-setup update
    --> succeeds with a fast-forward update
    git stash pop
  ==> Workflow feels smooth :-)

- Manual testing with --rebase-conflicts-strategy backup (uncommitted changes):
  - bitbake-setup init
  - cd layers/openembedded-core
  - git checkout older commit
  - modify a file to provoke a conflict without committing
  - bitbake-setup update --rebase-conflicts-strategy backup
    --> succeeds with a backup and a fresh clone from upstream
  ==> Workflow feels smooth :-)

- Manual testing with --rebase-conflicts-strategy backup (committed conflict):
  - bitbake-setup init
  - cd layers/openembedded-core
  - edit a file to provoke a conflict
  - bitbake-setup update --rebase-conflicts-strategy backup
    --> succeeds: the conflicting directory is backed up and re-cloned cleanly
  ==> Workflow feels smooth, but we probably need to improve it later
    - VSCode shows the backup directory as a workspace folder, that's fine
    - Who is going to delete the backup later? In VSCode it's possible to
      click "Remove folder from workspace" and then delete it manually on the command line
    Some features like bitbake-setup update --remove-backups interactively might be nice



Adrian Freihofer (10):
  fetch2: add LocalModificationsError for uncommitted changes blocking
    update
  bitbake-selftest: add GitUnpackUpdateTest
  tests/fetch: remove unused import, fix trailing whitespace
  bitbake-setup: always restore sys.stdout
  tests/setup: cleanup imports
  tests/setup: fix dead check_setupdir_files guards
  bitbake-setup: generate config files for VSCode
  tests/setup: add test_vscode for VSCode workspace generation
  bitbake-setup: add --rebase-conflicts-strategy to the update command
  tests/setup: add test_update_rebase_conflicts_strategy

 bin/bitbake-setup         | 223 ++++++++++++++-
 lib/bb/fetch2/__init__.py |   8 +
 lib/bb/fetch2/git.py      |   2 +-
 lib/bb/tests/fetch.py     | 563 +++++++++++++++++++++++++++++++++++++-
 lib/bb/tests/setup.py     | 195 ++++++++++++-
 5 files changed, 965 insertions(+), 26 deletions(-)

-- 
2.53.0


