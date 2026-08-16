Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855D7C5DF66
	for <webhook@archiver.kernel.org>; Sun, 16 Aug 2026 22:15:19 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18659.1786918513769898357
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 16 Aug 2026 15:15:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm2 header.b=N0H5Yyw8;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-1329275-202608162215106ac2250a6700020784-rbonnh@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202608162215106ac2250a6700020784
        for <bitbake-devel@lists.openembedded.org>;
        Mon, 17 Aug 2026 00:15:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=RVbM+/kqEzwzExX7Zk5WYJknyBR6on170sRIxqKKVjo=;
 b=N0H5Yyw8Jq9vb6ZnQwEd540+FCL9VAo1jOhHWnJiwc1EcKVTtuthCjD4jay4w7TZjrYfGt
 Z3MI/vMAiSncdGwAkjTf+hc9BdAoWrdv5+nDIQSfW358vMWHWYB7l16VsCVaIjtcrDcSqXcN
 ZrhyQoFf6HC+x92NLDNoJnZTWlhXHQk4f2WrQYe13kgNB7TpWnlDNYrRnkfTrW0IpfV+ut/3
 gCn6GOKDFf3csR3hHAQ/fPNKmczoqH5G5tcZBoJNLvC3LC+cKHdR2CWaZchByNRgXUIfr8WZ
 eeKq/2ftblyLpT74VRGgYMrTknajOL4CpI/a3tj+0F3JJXRKzXutlDdA==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH v2 0/8] cooker/tinfoil: fix -b bbappend handling and add single-task prepared-task API
Date: Mon, 17 Aug 2026 00:14:39 +0200
Message-ID: <20260816221507.155861-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 16 Aug 2026 22:15:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19964

From: Adrian Freihofer <adrian.freihofer@siemens.com>

Hi Richard,

This v2 should answer your question:
  doesn't this only add limited collections data so whilst it fixes -b,
  it potentially corrupts the cache for the non -b cases?
  https://lists.openembedded.org/g/bitbake-devel/message/19957

The test case test_run_prepared_task_recipecache_self_heals should
prove that this works as expected.

The commits going into bitbake do not change in comparison to v1.
Only the test changed.

Regards,
Adrian

Adrian Freihofer (8):
  cooker: fix bitbake -b silently ignoring bbappends
  tests/cooker: add a shared bitbake-subprocess test base class
  tests/cooker: add a bitbake -b bbappend test
  command: fix setConfig coercing bool config values to truthy strings
  cooker: add a buildFile mode that runs a single task
  tinfoil: add a prepared task runner
  tests/cooker: add TinfoilTests for run_prepared_task
  parse/ast: skip empty BBPATH segments in include_all

 lib/bb/command.py      |   8 +-
 lib/bb/cooker.py       |  14 +-
 lib/bb/parse/ast.py    |   4 +
 lib/bb/tests/cooker.py | 342 ++++++++++++++++++++++++++++++++++++++++-
 lib/bb/tinfoil.py      |  23 ++-
 5 files changed, 383 insertions(+), 8 deletions(-)

-- 
2.55.0


