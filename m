Return-Path: <philip.lorenz@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC43C3ABAB
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 08:18:05 +0000 (UTC)
Received: from esa2.hc324-48.eu.iphmx.com (esa2.hc324-48.eu.iphmx.com [207.54.68.120])
 by mx.groups.io with SMTP id smtpd.web11.13074.1745914681685012812
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Apr 2025 01:18:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bmw.de header.s=mailing1 header.b=K8ylNtkh;
 spf=pass (domain: bmw.de, ip: 207.54.68.120, mailfrom: prvs=207d80f5d=philip.lorenz@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1745914681; x=1777450681;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9Vf2mj6E0TvMQsxuS/l67dlFd2+FDDqAmP4ckaH5N0I=;
  b=K8ylNtkhaYB9gpHiKrzlkDF7zxS6H/wpUXbTlIiUWLRKgoOSayI4li2p
   IaLTs6YySRgUIbNF4TwLU+Ixsv/g545ptSXa5JgfHP0iqqi3T3ro1oBiB
   kBpSPyAMCG8mwU0ut9cfheH4hkGNK/yx+Rqxt423Z759jhif6pcn0Dn8L
   4=;
X-CSE-ConnectionGUID: J3Herv3aQBOlJq+WY/Y6Ng==
X-CSE-MsgGUID: +my0dD1jQwWkX12gTvooNw==
Received: from esagw2.bmwgroup.com (HELO esagw2.muc) ([160.46.252.38]) by
 esa2.hc324-48.eu.iphmx.com with ESMTP/TLS; 29 Apr 2025 10:17:58 +0200
Received: from esabb4.muc ([160.50.100.33])  by esagw2.muc with ESMTP/TLS;
 29 Apr 2025 10:17:57 +0200
Received: from smucmp19d.bmwgroup.net (HELO smucmp19d.europe.bmw.corp)
 ([10.30.13.170]) by esabb4.muc with ESMTP/TLS; 29 Apr 2025 10:17:58 +0200
Received: from localhost.localdomain (10.30.85.212) by smucmp19d.europe.bmw.corp
 (2a03:1e80:a15:58f::205d) with Microsoft SMTP Server (version=TLS;
 Tue, 29 Apr 2025 10:17:57 +0200
X-CSE-ConnectionGUID: NYsTHTvXQUiBDbwz+7H29Q==
X-CSE-MsgGUID: MvCFz7+sR6y/JwZZk0Yffw==
X-CSE-ConnectionGUID: xuO/I0JnTVOSQ6bWJmHehQ==
X-CSE-MsgGUID: BiTMM4qiQ76zaARFpMVkag==
From: Philip Lorenz <philip.lorenz@bmw.de>
To: <bitbake-devel@lists.openembedded.org>
CC: Philip Lorenz <philip.lorenz@bmw.de>, <mathieu.dubois-briand@bootlin.com>,
	<richard.purdie@linuxfoundation.org>
Subject: [PATCH v4 0/8] Fix gitsm LFS support
Date: Tue, 29 Apr 2025 10:11:16 +0200
Message-ID: <20250429081124.3695505-1-philip.lorenz@bmw.de>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: smucmp09b.europe.bmw.corp (2a03:1e80:a15:58f::203f) To
 smucmp19d.europe.bmw.corp (2a03:1e80:a15:58f::205d)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 29 Apr 2025 08:18:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17584

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

---
V1 -> V2:
* The correct parameter is now passed for each submodule URL when LFS is
  explicitly disabled
* Smudging for submodules is now skipped when LFS is explcitly disabled.
  This ensures consistent behaviour in setups where git-lfs is installed
  but should not be used.
* Test cases are extended to test the LFS disabled state.
* Explicitly install git lfs into submodule in the test cases to make
  sure that git-lfs is actually used for storing the files.

V2 -> V3:
* Only check for git-lfs existence after confirming whether it is really
  neded

V3 -> V4:
* Fix unit test execution on hosts which do not have git-lfs installed

Philip Lorenz (8):
  fetch2: Clean up no longer used name parameter
  tests/fetch: Move commonly used imports to top
  fetch2: Check for git-lfs existence before using it
  fetch2: Simplify git LFS detection
  fetch2: Use git-lfs fetch to download objects
  fetch2: Fix incorrect lfs parametrization for submodules
  fetch2: Fix LFS object checkout in submodules
  tests/fetch: Test gitsm with LFS

 lib/bb/fetch2/git.py   |  69 +++++--------
 lib/bb/fetch2/gitsm.py |  13 ++-
 lib/bb/tests/fetch.py  | 214 +++++++++++++++++++++++++++++++----------
 3 files changed, 192 insertions(+), 104 deletions(-)


