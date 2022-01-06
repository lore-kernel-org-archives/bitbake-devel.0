Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA6BC433EF
	for <webhook@archiver.kernel.org>; Thu,  6 Jan 2022 23:55:01 +0000 (UTC)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by mx.groups.io with SMTP id smtpd.web11.187.1641513300555075237
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Jan 2022 15:55:00 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="unable to parse pub key" header.i=@intel.com header.s=intel
 header.b=fgi33oNF;
 spf=pass (domain: intel.com, ip: 134.134.136.24,
 mailfrom: anuj.mittal@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641513300; x=1673049300;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nNEqHM2RQt4v41Nzc41Brk4J78F55+ouo6iL+x4XWPQ=;
  b=fgi33oNF553JZWS4Z7NvZL6KZI9Y5yJyfX+to8D/C7GL2/407xKler/F
   aipE24zXNj6QF5zkkjzfbQQ8fE6st53A9DGiLtihHGNc68fUz0Gzx2W5P
   k2o1nsNejAyuf7rE8ZLigSkfsas8GKFxhGRLFVF5HrqHXqe2Y/N86cysa
   iifrQ3c4II7wf5x/+ebbg1H3bBVxsBethXFOVBoYJ8BXxUb3GBBg0IPHO
   7oI++UVEhwqfnBDcb+Qr5WJ517z6593YHAAKT5iqWXZpk91qyx2EBESoK
   94im7PxRT8c57odU/ctFaH2v5CpgTw8u+EY1nB8UuHBO21H8t4gV/6kTd
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="242555970"
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600";
   d="scan'208";a="242555970"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jan 2022 15:54:59 -0800
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600";
   d="scan'208";a="689588986"
Received: from iho1-mobl.gar.corp.intel.com (HELO anmitta2-mobl3.intel.com)
 ([10.215.230.146])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jan 2022 15:54:58 -0800
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 0/2] Pull request
Date: Fri,  7 Jan 2022 07:54:54 +0800
Message-Id: <cover.1641513156.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Jan 2022 23:55:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13224

Please merge these changes.

Thanks,

Anuj

The following changes since commit 315599b5b3ca0f1c797555db2460081681b6c945:

  utils: Handle lockfile filenames that are too long for filesystems (2021-12-05 12:36:22 +0000)

are available in the Git repository at:

  git://push.openembedded.org/bitbake-contrib stable/1.50-next

Anton Mikanovich (1):
  process: Do not mix stderr with stdout

Richard Purdie (1):
  tests/fetch: Drop gnu urls from wget connectivity test

 lib/bb/process.py     | 2 +-
 lib/bb/tests/fetch.py | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

-- 
2.33.1


