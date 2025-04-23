Return-Path: <philip.lorenz@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C900DC369CB
	for <webhook@archiver.kernel.org>; Wed, 23 Apr 2025 15:25:47 +0000 (UTC)
Received: from esa6.hc324-48.eu.iphmx.com (esa6.hc324-48.eu.iphmx.com [207.54.71.69])
 by mx.groups.io with SMTP id smtpd.web11.11597.1745421943467318387
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Apr 2025 08:25:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bmw.de header.s=mailing1 header.b=j6RLyUCF;
 spf=pass (domain: bmw.de, ip: 207.54.71.69, mailfrom: prvs=201e634cf=philip.lorenz@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1745421943; x=1776957943;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=G8Gx4pLqvyVQbcrWfsA70Ivhk5lUo+aPB547Q77ptoc=;
  b=j6RLyUCFZg006dFU5DkXVXgDLDsGYeglNXb+QdHh/GDaIW+n21+we+Vk
   duxkyPPkB4tNFx04BshGVWGIqc5jbgE878YgHj0DwssSC1n3MfvXn96S2
   p9YEXaH0vnyjxJkNZWMlr/11bqMDo7XGSd6JNI4VVszFxaWN+GcX2q9+0
   M=;
X-CSE-ConnectionGUID: d3wDcS8PTgSeZ8vlVV+KMw==
X-CSE-MsgGUID: qriAqdOdRcKwN/LL4Z4krA==
Received: from esagw5.bmwgroup.com (HELO esagw5.muc) ([160.46.252.46]) by
 esa6.hc324-48.eu.iphmx.com with ESMTP/TLS; 23 Apr 2025 17:25:40 +0200
Received: from esabb2.muc ([160.50.100.34])  by esagw5.muc with ESMTP/TLS;
 23 Apr 2025 17:25:40 +0200
Received: from smucmp19d.bmwgroup.net (HELO smucmp19d.europe.bmw.corp)
 ([10.30.13.170]) by esabb2.muc with ESMTP/TLS; 23 Apr 2025 17:25:41 +0200
Received: from localhost.localdomain (10.30.85.210) by smucmp19d.europe.bmw.corp
 (2a03:1e80:a15:58f::205d) with Microsoft SMTP Server (version=TLS;
 Wed, 23 Apr 2025 17:25:40 +0200
X-CSE-ConnectionGUID: Wuva3diHTj2hwWxCARB3tw==
X-CSE-MsgGUID: AUPao0YUQbKf0puQ1tvj8g==
X-CSE-ConnectionGUID: DqA8gHeZQaKplTPhwYxi/A==
X-CSE-MsgGUID: ARNwizuwRHGJYpNUkzoVWQ==
From: Philip Lorenz <philip.lorenz@bmw.de>
To: <bitbake-devel@lists.openembedded.org>
CC: Philip Lorenz <philip.lorenz@bmw.de>
Subject: [PATCH 0/8] Fix gitsm LFS support
Date: Wed, 23 Apr 2025 17:18:53 +0200
Message-ID: <20250423151901.1300944-1-philip.lorenz@bmw.de>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: smucmp15a.europe.bmw.corp (2a03:1e80:a15:58f::1:68) To
 smucmp19d.europe.bmw.corp (2a03:1e80:a15:58f::205d)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Apr 2025 15:25:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17542

This patch series fixes a number of issues we observed when using the
gitsm fetcher in conjunction with git-lfs.

I'd like to highlight two patches in this series:
* 0004-fetch2-Simplify-git-LFS-detection: I could not come up with a
  good reason on why the code so far preferred the content of
 `.gitattributes` on the repository's branch instead of always
  considering the state of the target revision. Please let me know
  if there's something I didn't take into account.
* 0005-fetch2-Use-git-lfs-fetch-to-download-objects.patch: I could not
  replicate the `git-lfs fetch` behaviour in versions going back to
  2.13.2 released in 2021. This leads me to believe that the issue
  leading to this workaround is no longer in place. However, if anyone
  remembers the actual issue / versions involved I can also retest to
  confirm that there are no regression.

Philip Lorenz (8):
  fetch2: Clean up no longer used name parameter
  tests/fetch: Move commonly used imports to top
  fetch2: Check for git-lfs existence before using it
  fetch2: Simplify git LFS detection
  fetch2: Use git-lfs fetch to download objects
  fetch2: Fix incorrect lfs parametrization for submodules
  fetch2: Fix LFS object checkout in submodules
  tests/fetch: Test gitsm with LFS

 lib/bb/fetch2/git.py   |  69 +++++++-------------
 lib/bb/fetch2/gitsm.py |   9 +--
 lib/bb/tests/fetch.py  | 139 ++++++++++++++++++++++++++---------------
 3 files changed, 115 insertions(+), 102 deletions(-)


