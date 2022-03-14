Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DB5C433EF
	for <webhook@archiver.kernel.org>; Mon, 14 Mar 2022 02:14:05 +0000 (UTC)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by mx.groups.io with SMTP id smtpd.web08.21884.1647224044035250454
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 13 Mar 2022 19:14:04 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="unable to parse pub key" header.i=@intel.com header.s=intel
 header.b=Do3cZWUo;
 spf=pass (domain: intel.com, ip: 192.55.52.43,
 mailfrom: anuj.mittal@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647224044; x=1678760044;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KivTAnzWPDX/wh1qKuQbclPbFumJ3QX2OxkupsNQI2I=;
  b=Do3cZWUo4532Ryx9aiCLQL8gkyw2afYf/LM25puz0rKLe7JyVfUhCHfu
   gNGmXQ31a76DKJcnnsPPbQ9JZh/onMxQRqOCpI5nSUujCMhNY//ICDma1
   lv64umvqQ1oisjuO0gscTp0vsxz/tSW87lzMgVybcNPO3tGc7xtuB6+cC
   EhgzaENmKailrww5E4oBi0WbcDIOhREH9NCM6wweRj6hx7lFL5+fRt3es
   h+cM6deRvQHqlaw7N3x2MaWDCX9NYcG+6KU2hvTHx7vKM6qHSlbFmwqUz
   9OrqwLVtvPDTFVTfhOQsYMxdv4C1Sth/LrR+vTahaaAcWtv/oqMZvnRpH
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="342344733"
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400";
   d="scan'208";a="342344733"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2022 19:14:03 -0700
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400";
   d="scan'208";a="818562514"
Received: from lsim7-mobl1.gar.corp.intel.com (HELO anmitta2-mobl3.intel.com)
 ([10.215.229.232])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2022 19:14:02 -0700
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.52][PATCH 0/5] Patch review
Date: Mon, 14 Mar 2022 10:13:52 +0800
Message-Id: <cover.1647223687.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 14 Mar 2022 02:14:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13476

Please review and merge these changes for 1.52/honister. No issues seen
while testing on autobuilder.

Thanks,

Anuj

The following changes since commit 1428128c787642dca690a7d51f2be793e001ae37:

  tests/fetch: Handle upstream master -> main branch change (2022-02-23 18:09:52 +0000)

are available in the Git repository at:

  git://push.openembedded.org/bitbake-contrib stable/1.52-next

Daniel Gomez (1):
  contrib: Fix hash server Dockerfile dependencies

Daniel Wagenknecht (1):
  fetch2: ssh: username and password are optional

Richard Purdie (3):
  data_smart: Fix overrides file/line message additions
  cooker: Improve parsing failure from handled exception usability
  utils: Ensure shell function failure in python logging is correct

 contrib/hashserv/Dockerfile | 6 +++++-
 lib/bb/cooker.py            | 4 +++-
 lib/bb/data_smart.py        | 8 ++++----
 lib/bb/fetch2/ssh.py        | 2 +-
 lib/bb/utils.py             | 2 +-
 5 files changed, 14 insertions(+), 8 deletions(-)

-- 
2.35.1


