Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D27FC433EF
	for <webhook@archiver.kernel.org>; Tue, 14 Dec 2021 01:26:04 +0000 (UTC)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by mx.groups.io with SMTP id smtpd.web08.20089.1639445158687040632
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 13 Dec 2021 17:25:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=intel header.b=JxMGs782;
 spf=pass (domain: intel.com, ip: 134.134.136.20,
 mailfrom: anuj.mittal@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639445158; x=1670981158;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eDf+RnbLEhLoY30GeHH+b5Jf9FVYdBQU2i20pRrRg0M=;
  b=JxMGs782UtkYnk07zaSgK2wSRB4b2G9QqCk/P/9+v+myDfjhp3el5pYD
   F8MeMx6n0vV74ThpQZ6x3p7Gt5UUovTC8+GkHRZRhwiqdq9kN4RbpHQi/
   wn3Nw377vIqjE6T0T0ZDPYPXrZwCwvdEFNGmx/RMLuSq3iLOLGV8y1Xew
   YW80WgXg628nzazmD6f14iVT7n44taLr+3IiCNTxG9wehd1oDY3yVn4u8
   XgpFP8h8LbNgMDG1ZjaZ7Wzhh7KbksCzH8Jz5yGfL9aRuWIPp+dlvbPJ/
   heXHopaQSlVN6NBeyWCHI8TNo6lzbfE655CCA/JkU0AfmzVY/uTM2ur0Q
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="226147963"
X-IronPort-AV: E=Sophos;i="5.88,204,1635231600";
   d="scan'208";a="226147963"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Dec 2021 17:25:57 -0800
X-IronPort-AV: E=Sophos;i="5.88,204,1635231600";
   d="scan'208";a="464869983"
Received: from zyteoh-mobl.gar.corp.intel.com (HELO anmitta2-mobl3.intel.com)
 ([10.215.239.31])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Dec 2021 17:25:56 -0800
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.52][PATCH 0/1] Pull request
Date: Tue, 14 Dec 2021 09:25:46 +0800
Message-Id: <cover.1639444935.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 14 Dec 2021 01:26:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13153

Please review and merge this change for 1.52. Tested and no problems
seen.

Thanks,

Anuj

The following changes since commit 5c46ce77aa55cb46abe224b6a31dad87b9249bcf:

  data_smart.py: Skip old override syntax checking for anonymous functions (2021-12-12 22:24:22 +0000)

are available in the Git repository at:

  git://push.openembedded.org/bitbake-contrib stable/1.52-next

Robert Yang (1):
  lib/pyinotify.py: Remove deprecated module asyncore

 lib/pyinotify.py | 30 ------------------------------
 1 file changed, 30 deletions(-)

-- 
2.33.1


