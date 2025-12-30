Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C45E94134
	for <webhook@archiver.kernel.org>; Tue, 30 Dec 2025 09:16:10 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.61212.1767086157383332089
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 30 Dec 2025 01:15:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm2 header.b=L8MF4hV6;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-1329275-202512300915542fcc3a5d1f0002070d-sw0rlv@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202512300915542fcc3a5d1f0002070d
        for <bitbake-devel@lists.openembedded.org>;
        Tue, 30 Dec 2025 10:15:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=d7LcPsMm9rU2e/tRF3KCTY63tShWA1Cvz+mr+8hg3ik=;
 b=L8MF4hV6S9NUjOom19bMNfiyz+uS6a4fFwjdwaAETIOCw4FWvqb9PcFdOCKkcPp4noquBn
 uQkXhYP1l7MXn2UTJRKSl/5JXtMo7iqBOHpdMekq8aPjgboAWbSKC4kuGiOvf+fI7CdMUgVu
 7I4DnqlkRMjRgvJXez6WWAhLfVdacfcAMkYfrZgjU1D6Th0LPq9naW2T4OtISLE2Irl5r/K1
 MNFN8zKA/dzuiGNSljeyA8LB+RsjzK+t9pC9adr7ivs+UUj9NL4G+su0XSmxMWU5ft8sm0jE
 eE2ARgQ7MLfW5kvUrTpyyCwkWRno+mvVxRmV7ytLtZYRu/mWdZ3dH1gg==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH 0/1] bitbake --skip-deps feature
Date: Tue, 30 Dec 2025 10:15:15 +0100
Message-ID: <20251230091530.2373504-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 30 Dec 2025 09:16:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18657

From: Adrian Freihofer <adrian.freihofer@siemens.com>

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

Adrian Freihofer (1):
  tests/runqueue: cover --skip-deps

 lib/bb/tests/runqueue.py | 9 +++++++++
 1 file changed, 9 insertions(+)

-- 
2.52.0


