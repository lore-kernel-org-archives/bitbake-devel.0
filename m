Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CD8C433EF
	for <webhook@archiver.kernel.org>; Tue,  4 Jan 2022 06:22:59 +0000 (UTC)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by mx.groups.io with SMTP id smtpd.web11.3284.1641277377131827686
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 03 Jan 2022 22:22:58 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="unable to parse pub key" header.i=@intel.com header.s=intel
 header.b=UaWGTfWr;
 spf=pass (domain: intel.com, ip: 192.55.52.115,
 mailfrom: anuj.mittal@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641277377; x=1672813377;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RCwPje011Tc8CqfEyMCDTc78m3JKLJfv/fJ//nE6qCI=;
  b=UaWGTfWrK0jvikDQ4KmKAyfe9rL6B5tnIc6C/TkPVaBmcScTf/pm6hK0
   9hiTHUcHtWVdWOfxGv+TD802WJtq81djKN5HsjZXZvRpenkB2ajlpMVlN
   hXuyOG3ZKEzHmb+BPz9lpGPxHCuljKRpCzDeCfiYhGQJ/F1qmdbthQmj7
   xFRhcInao6EpADkxRo4CCqyIQEDr+PRGS0yD2JMwBDbpBrFOXjM5CQaAt
   714ZY8sd3WClWP1fjsIfdM3Ew2QonSGNZGooIMm9ZoOouw33zkKayGGeg
   bvQJkpqW0gd0u/SKqsT2MdgpIoJQbQk+KbvAn1IyDMNJl4KGO5ylWC2Rl
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="242373890"
X-IronPort-AV: E=Sophos;i="5.88,260,1635231600";
   d="scan'208";a="242373890"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jan 2022 22:22:56 -0800
X-IronPort-AV: E=Sophos;i="5.88,260,1635231600";
   d="scan'208";a="526161967"
Received: from asaninud-mobl1.gar.corp.intel.com (HELO
 anmitta2-mobl3.intel.com) ([10.213.130.119])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jan 2022 22:22:55 -0800
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.52][PATCH 0/4] Pull request
Date: Tue,  4 Jan 2022 14:22:50 +0800
Message-Id: <cover.1641277318.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 04 Jan 2022 06:22:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13214

Please merge these changes.

Thanks,

Anuj

The following changes since commit 6bfb02f845001bf4f05d9b68695bb616b1642b2a:

  lib/pyinotify.py: Remove deprecated module asyncore (2021-12-14 22:59:46 +0000)

are available in the Git repository at:

  git://push.openembedded.org/bitbake-contrib stable/1.52-next

Anton Mikanovich (1):
  process: Do not mix stderr with stdout

Richard Purdie (1):
  tests/fetch: Drop gnu urls from wget connectivity test

Stefan Herbrechtsmeier (2):
  fetch: npm: Quote destdir in run chmod command
  fetch: npm: Use temporary file for empty user config

 lib/bb/fetch2/npm.py  | 16 ++++++----------
 lib/bb/process.py     |  2 +-
 lib/bb/tests/fetch.py |  3 ---
 3 files changed, 7 insertions(+), 14 deletions(-)

-- 
2.33.1


