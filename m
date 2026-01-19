Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA1DCA5FFE
	for <webhook@archiver.kernel.org>; Mon, 19 Jan 2026 07:34:39 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.30752.1768808076941111530
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 18 Jan 2026 23:34:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm1 header.b=ZTpj008c;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-1329275-20260119073433cfeb5944d00002079f-uhwy5j@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20260119073433cfeb5944d00002079f
        for <bitbake-devel@lists.openembedded.org>;
        Mon, 19 Jan 2026 08:34:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=nUj1NulrvCsdJMTsS3YaZGD8euWmHiw1SPOffKlyb3o=;
 b=ZTpj008cVFuW7TZjcpVtTGs04JGkzI/n/t7BTZl/cPMME2l64KobcADBAF7hZnh4ElJju2
 yE8ucMWoUPf/webyDTYPgR7WasEZcULqG7yxaW5u+V33G3UjYkajFne07INZCIhgywKQVfRL
 Det1euO32DhO55DQ2WP96uBdGcamZX0OSmP8DY0zkMJ15hRI4GyeMkTfuF86BTHNT+JSU0ak
 UdWp5iTP7P8YzPvbVxqGRhl7ugbuiUi495y2Q+Exnl6g4O+bMdg4IOFDjtIgNpQo9JccmhKs
 Wfc9/JxUbGyUmmsC54RI5QFX/+rZKqU5ExuJoMrUFSqU3+AXYWqwsuSA==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH 0/2] bitbake-setup: Add VSCode workspace generation support
Date: Mon, 19 Jan 2026 08:34:01 +0100
Message-ID: <20260119073419.952608-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 19 Jan 2026 07:34:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18805

From: Adrian Freihofer <adrian.freihofer@siemens.com>

This patch series introduces automatic generation of VSCode workspace
configuration files for bitbake projects created with bitbake-setup. The
feature enhances the developer experience by automatically configuring a
multi-root workspace tailored for bitbake development.

The implementation generates a `bitbake.code-workspace` file that includes:

- Multi-root workspace structure with all layer repositories and the build
  configuration directory as top-level folders in the VSCode explorer
- Pre-configured BitBake extension settings (paths to bitbake folder, build
  folder, environment script, etc.)
- File associations for `.conf` and `.inc` files mapped to the bitbake
  language
- Python analysis paths automatically discovered from layer `lib/` and
  `scripts/` directories
- Sensible exclusion patterns for `.git` and log directories

The workspace file is placed at the setup directory level, outside any
version-controlled repositories, avoiding repository clutter while providing
a centralized configuration for the entire project.

Adrian Freihofer (2):
  bitbake-setup: generate config files for VSCode
  bitbake-selftest: add test for VSCode workspace generation

 bin/bitbake-setup     | 198 +++++++++++++++++++++++++++++++++++++----
 lib/bb/tests/setup.py | 201 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 384 insertions(+), 15 deletions(-)

-- 
2.52.0


