Return-Path: <philip.lorenz@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F095C369C2
	for <webhook@archiver.kernel.org>; Fri, 25 Apr 2025 14:48:20 +0000 (UTC)
Received: from esa12.hc324-48.eu.iphmx.com (esa12.hc324-48.eu.iphmx.com [207.54.72.34])
 by mx.groups.io with SMTP id smtpd.web10.8243.1745592492730691985
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 25 Apr 2025 07:48:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bmw.de header.s=mailing1 header.b=qMCnYXz/;
 spf=pass (domain: bmw.de, ip: 207.54.72.34, mailfrom: prvs=2034cd71c=philip.lorenz@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1745592493; x=1777128493;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6JRxvP7vcx5K0QqibK7rPUWeCNR6DI/wv4hOBHLH9dE=;
  b=qMCnYXz/UV9eSmi8ed7G8uQEpI5FmnlaRBdh/9QzJi3KBKRmQYfw8R53
   ZXF2mcsI7w0WptBNSdWyS0DYoGwE4iw6BO+wAcFgY9nP+w5WYgIxDtLHJ
   LdZpDDXZW5RgKAuJomEOTecNk6kzWGophW+8iZ5YIVIXqOsYs8oycgQpP
   M=;
X-CSE-ConnectionGUID: u3yw+TkfT72bMce837mELA==
X-CSE-MsgGUID: 1eLuOL5OS62XgE9zyP62uw==
Received: from 160.46.252.49.spf.bmwgroup.com (HELO esagw6.muc) ([160.46.252.49]) by
 esa12.hc324-48.eu.iphmx.com with ESMTP/TLS; 25 Apr 2025 16:48:09 +0200
Received: from esabb1.muc ([160.50.100.31])  by esagw6.muc with ESMTP/TLS;
 25 Apr 2025 16:48:08 +0200
Received: from smucmp19d.bmwgroup.net (HELO smucmp19d.europe.bmw.corp)
 ([10.30.13.170]) by esabb1.muc with ESMTP/TLS; 25 Apr 2025 16:48:07 +0200
Received: from localhost.localdomain (10.30.85.205) by smucmp19d.europe.bmw.corp
 (2a03:1e80:a15:58f::205d) with Microsoft SMTP Server (version=TLS;
 Fri, 25 Apr 2025 16:48:06 +0200
X-CSE-ConnectionGUID: 0rXYKu3mQwGTMxx7MYEkhw==
X-CSE-MsgGUID: oF3QK86wSM6Jwzug8qFdmA==
X-CSE-ConnectionGUID: q22+DcLRT6+PrGo8UUh+Vw==
X-CSE-MsgGUID: whw5LQzMQcWtcQRhsPwzrg==
From: Philip Lorenz <philip.lorenz@bmw.de>
To: <bitbake-devel@lists.openembedded.org>
CC: Philip Lorenz <philip.lorenz@bmw.de>, <mathieu.dubois-briand@bootlin.com>,
	<richard.purdie@linuxfoundation.org>
Subject: [PATCH v3 0/8] Fix gitsm LFS support
Date: Fri, 25 Apr 2025 16:41:30 +0200
Message-ID: <20250425144138.4089681-1-philip.lorenz@bmw.de>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: smucmp17a.europe.bmw.corp (2a03:1e80:a15:58f::1:3a) To
 smucmp19d.europe.bmw.corp (2a03:1e80:a15:58f::205d)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 25 Apr 2025 14:48:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17569

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

Philip Lorenz (8):
  fetch2: Clean up no longer used name parameter
  tests/fetch: Move commonly used imports to top
  fetch2: Check for git-lfs existence before using it
  fetch2: Simplify git LFS detection
  fetch2: Use git-lfs fetch to download objects
  fetch2: Fix incorrect lfs parametrization for submodules
  fetch2: Fix LFS object checkout in submodules
  tests/fetch: Test gitsm with LFS

 lib/bb/fetch2/git.py   |  69 +++++---------
 lib/bb/fetch2/gitsm.py |  13 ++-
 lib/bb/tests/fetch.py  | 202 +++++++++++++++++++++++++++++++----------
 3 files changed, 182 insertions(+), 102 deletions(-)


