Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57543C433EF
	for <webhook@archiver.kernel.org>; Tue, 25 Jan 2022 03:41:32 +0000 (UTC)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by mx.groups.io with SMTP id smtpd.web09.2695.1643082091358209472
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Jan 2022 19:41:31 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="unable to parse pub key" header.i=@intel.com header.s=intel
 header.b=Y7xuzih4;
 spf=pass (domain: intel.com, ip: 192.55.52.151,
 mailfrom: anuj.mittal@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643082091; x=1674618091;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=F3LdEmzbwCYAvpI+XLK41KETTByamrfwcvzY2ZOO/jk=;
  b=Y7xuzih4RwGN9RVso0YL/tluTQrI5smZvLR745khRQ0+cI/XZCrMK01n
   7pcKOcMm636O9kN2OXKlJpj6U5yQ/8grtNXarpGNFnNKy1X9puiVE1p/Q
   KL9sGfUlz0TNIwrCE8JFD5dY2Vkm7qGQXbXVYJ/rWdOeQTZfwWOROfpUa
   MSC+epVDm+C+fsdwoA3SJe2M2Q+FxukMziai7GEwrDSpjoHJzEmqDflJa
   2st/uEmB6BHABLvpvm9BZ0kyiK4CdXcgBNymX9GnCWz1E7D3Sv1ZbPrX1
   L0sa9zorc1EDLoqWurDpsLQoIDFwqRlyQNK4p9EP6+6W0dORjfStVlXsC
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="226880295"
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600";
   d="scan'208";a="226880295"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2022 19:41:28 -0800
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600";
   d="scan'208";a="534542603"
Received: from yongyuns-mobl.gar.corp.intel.com (HELO
 anmitta2-mobl3.intel.com) ([10.213.129.99])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2022 19:41:27 -0800
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 0/1] Patch review
Date: Tue, 25 Jan 2022 11:41:22 +0800
Message-Id: <cover.1643081933.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Jan 2022 03:41:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13277

Please review this change for 1.50. Tested on autobuilder and no
problems seen.

Thanks,

Anuj

The following changes since commit 598ea8584f792b30799231c4d3151d40852fc43c:

  tests/fetch: Drop gnu urls from wget connectivity test (2021-12-28 12:39:02 +0800)

are available in the Git repository at:

  git://push.openembedded.org/bitbake-contrib stable/1.50-next

Richard Purdie (1):
  utils: Update to use exec_module() instead of load_module()

 lib/bb/utils.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
2.34.1


