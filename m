Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FD5FB516D
	for <webhook@archiver.kernel.org>; Mon,  6 Apr 2026 20:24:58 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.64177.1775507090714264245
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 06 Apr 2026 13:24:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm2 header.b=cum5q89J;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-1329275-202604062024477b1f8a8b170002073f-rpiq7y@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202604062024477b1f8a8b170002073f
        for <bitbake-devel@lists.openembedded.org>;
        Mon, 06 Apr 2026 22:24:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=iTKljRMtJP9TEruhJ8z0igRwQ7DFXrzdLbE/LzGrp8k=;
 b=cum5q89JDvOgpRx5HfM7WXfkLOmUOD/e3T5+FHqLGU2m3WP8/Mr2dWlZErSy6FpnxwRcog
 06zitsePaJXow3Skap5flh4GFVW7fiEZg3x6npTDD8gtNg3w02kRJ0ym5cy+AWkEegimImhs
 MbPObBIq801N/q0bgLHw3+funSe4LjQjPXuqIFtv++q8Z1ppSs30lq3oLIVPP/zncX6sPP85
 hO0tdqUDAEMwmIMYKEdJV/RDzw051EnRtzdZb894m5GPq0y96VkPEJT66x7t8Crqy8wU7DNc
 pjqjeVBa4Ub/Cjgm/Hunqvnb6r5SSGafxX4v1B1b2v9KlnyVEq5OJVPQ==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH 0/4] bitbake-setup: extra-remotes support for contrib push mirrors
Date: Mon,  6 Apr 2026 22:24:01 +0200
Message-ID: <20260406202430.1856836-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 06 Apr 2026 20:24:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19334

From: Adrian Freihofer <adrian.freihofer@siemens.com>

This series contains one small fix and a new feature that may warrant
discussion before merging.

Fix (likely uncontroversial):
  bitbake-setup: update vscode workspace always

  The vscode workspace file is now updated unconditionally so that a
  manually changed build directory is always reflected. Previously it
  was skipped when the registry configuration had not changed.

New feature (may need discussion / could be postponed):
  bitbake-setup: add support for extra-remotes in layer sources
  bitbake-setup: add contrib extra-remotes to default-registry configs
  bitbake-selftest: setup: add test_extra_remotes

  Adds an 'extra-remotes' property to git-remote source definitions so
  that additional git remotes (e.g. SSH push mirrors) can be configured
  in checked-out repositories after checkout, without affecting fetch or
  change detection.

  A new --extra-remotes-filter option controls which remotes are added:
    non-optional (default), all, none, or comma-separated names.

  The default-registry entries for bitbake, openembedded-core, and
  meta-yocto are extended with optional 'contrib' extra-remotes pointing
  to the SSH push mirrors on push.openembedded.org.

  Self-tests cover all filter variants and the re-apply/update behaviour.

Adrian Freihofer (4):
  bitbake-setup: update vscode workspace always
  bitbake-setup: add support for extra-remotes in layer sources
  bitbake-setup: add contrib extra-remotes to default-registry configs
  bitbake-selftest: setup: add test_extra_remotes

 bin/bitbake-setup                             |  87 +++++++++++++-
 .../oe-nodistro-master.conf.json              |  16 ++-
 .../oe-nodistro-whinlatter.conf.json          |  16 ++-
 .../configurations/poky-master.conf.json      |  24 +++-
 .../configurations/poky-whinlatter.conf.json  |  24 +++-
 lib/bb/tests/setup.py                         | 107 ++++++++++++++++++
 setup-schema/layers.schema.json               |  22 ++++
 7 files changed, 280 insertions(+), 16 deletions(-)

-- 
2.53.0


