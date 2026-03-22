Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE43D58CA1
	for <webhook@archiver.kernel.org>; Sun, 22 Mar 2026 19:35:08 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1875.1774208105448677605
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 22 Mar 2026 12:35:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm1 header.b=JZ8ZupcP;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-1329275-2026032219350121e0b2a397000207be-fhskrf@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2026032219350121e0b2a397000207be
        for <bitbake-devel@lists.openembedded.org>;
        Sun, 22 Mar 2026 20:35:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=bSE2gYSANqns73ttG/aJgC90JnFuVbSjtHNL2Vi+PE8=;
 b=JZ8ZupcPHS0P53AfOtuWsv4R2NtYhaA5syBaVAz+roeHYHUDFNR528iKHvvwMWi7J/cuiE
 ZfcIZ4rakj7HAaUlZXIVkLjPgc28mLrkxA1uwpt7aClO4pyR3gf8cfAMufLtrYoAUxtwQd0M
 HFamhZYd9cTIntb4Ug9ZFY2rb/1OT1Xdnw3l/IRO0Ikw9YJBUgg/EBfHEEbdXVAS3jWX3HzG
 SsomCk+P27KSEWp+DpiPDcbCSwRV39dGrTwHNlBl1VIqb7USADFVMt6+7Kdp6/cPUNt7H1ly
 amDv5hfzefGm/2iBe/pUKBjSBJMmIM2lY0yPlgf9OPlsCJWSxZeE4KNg==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH 0/9] bitbake-setup: improvements, VSCode workspace generation
Date: Sun, 22 Mar 2026 20:34:11 +0100
Message-ID: <20260322193440.870120-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 22 Mar 2026 19:35:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19201

From: Adrian Freihofer <adrian.freihofer@siemens.com>

Based on master-next with commit from Alex
  bitbake-setup: use non-destructive 'update' mode of the git fetcher

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

- bitbake-setup rebase strategy (--rebase-strategy stop|backup):
  When unpack_update() cannot rebase a layer repository due to local
  modifications or a merge conflict, the default 'stop' strategy aborts with
  a clear message. The 'backup' strategy renames the directory to a timestamped
  backup and re-clones from upstream instead.

Adrian Freihofer (9):
  bitbake-selftest: add GitUnpackUpdateTest
  bitbake-setup: always restore sys.stdout
  tests/setup: cleanup imports
  tests/setup: fix dead check_setupdir_files guards
  bitbake-setup: report local modifications blocking an update
  bitbake-setup: generate config files for VSCode
  tests/setup: add test_vscode for VSCode workspace generation
  bitbake-setup: add --rebase-strategy to the update command
  tests/setup: add test_update_rebase_strategy

 bin/bitbake-setup     | 235 ++++++++++++++++--
 lib/bb/tests/fetch.py | 563 +++++++++++++++++++++++++++++++++++++++++-
 lib/bb/tests/setup.py | 204 ++++++++++++++-
 3 files changed, 971 insertions(+), 31 deletions(-)

-- 
2.53.0


