Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DDCEE021C
	for <webhook@archiver.kernel.org>; Tue, 30 Dec 2025 15:36:13 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.66400.1767108971066159428
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 30 Dec 2025 07:36:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm2 header.b=JKj1iEBj;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-1329275-20251230153609fdf737df51000207ae-tpb0e0@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20251230153609fdf737df51000207ae
        for <bitbake-devel@lists.openembedded.org>;
        Tue, 30 Dec 2025 16:36:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=plqq2+V5mnob2XmIk6k4uu9SnqK+yuBJXVJA7/JYTiA=;
 b=JKj1iEBjTCF7xHs7z6sXc12tVLhm7/UhC6LaI8x3h7UmjCArGMVSepREIk6KrAfrAnPGhU
 Dzkfcv33BvWoAdRb7lduMaWzmSbiMaH9KvxuMSAaraSa6L/DAip6nIkWsY2CcnVEE8Z83Dpm
 TuMKr6al5Y95BKOAT1CBSFolxbO3doWXDalu1CVEqnLCSvDyff5OK4C5gKz+UgP+0hoj+0Ii
 z/zfsdVPHzdLOiRpBlluLvlu+lYN+P6z8hrKQdHF2r8QJTsNQTI8jwU8EtjKeyN1nyYawZdk
 PbSFInd4er4CSSL273VkBCbTNoDAIRmHmEJX8ieSrwjjC35/P9mjj2xQ==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH v2 0/2] bitbake --skip-deps feature
Date: Tue, 30 Dec 2025 16:32:28 +0100
Message-ID: <20251230153539.3940266-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 30 Dec 2025 15:36:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18660

From: Adrian Freihofer <adrian.freihofer@siemens.com>

Changes in comparison to v1:
- Added the first patch which adds the --skip-deps option to bitbake.
  Sorry, for the confusion.

Adds a "skip-deps" feature to run/build specific tasks without scheduling their
full dependency tree.

This is useful for devtool ide-sdk, which works like this:
- The IDE's native build system is used to build the code.
- bitbake my-recipe:do_install --skip-deps --force is run to install the built
  artifacts.
- A script based on devtool deploy-target is used to deploy the installed
  artifacts to the target device.
- The IDE's debugging features are used to debug the code on the target device.

One more commit to openembedded-core is needed to fully support this feature.
This is already prepared and tested. Branch is here:
https://git.openembedded.org/openembedded-core-contrib/log/?h=adrianf/ide-sdk-improvements

Adrian Freihofer (2):
  bitbake: add --skip-deps option to re-run tasks directly
  tests/runqueue: cover --skip-deps

 lib/bb/cookerdata.py     |   3 +-
 lib/bb/main.py           |   5 +
 lib/bb/runqueue.py       | 319 ++++++++++++++++++++-------------------
 lib/bb/tests/runqueue.py |   9 ++
 4 files changed, 178 insertions(+), 158 deletions(-)

-- 
2.52.0


