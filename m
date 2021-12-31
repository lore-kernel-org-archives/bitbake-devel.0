Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3F2C433EF
	for <webhook@archiver.kernel.org>; Fri, 31 Dec 2021 00:22:02 +0000 (UTC)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by mx.groups.io with SMTP id smtpd.web11.5667.1640910121693805729
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Dec 2021 16:22:01 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="unable to parse pub key" header.i=@intel.com header.s=intel
 header.b=XCLO1BY3;
 spf=pass (domain: intel.com, ip: 134.134.136.100,
 mailfrom: anuj.mittal@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640910121; x=1672446121;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=x/y3N1BCNmbnY/MMWl5SUpGaZF/ytMoJBrI58oAkZbE=;
  b=XCLO1BY3vWuxcRUIJqGnhYyyb9GiyNPkkk2SGvgY99B1sQkASP9BwMyH
   gIDwdNwRPgvon3ZIQclqgRgOP+PkEgZufQSWF/n9ReQHIHxvB5uZnkxUU
   6Aw5Z0ycPagu14w6/vCto5ATE8Es3zMFa8R+1opp9H2PlMCIkmOOJRtxO
   ChSuWvGo0urJiFPRACqBQJ4CwI91sOmGWMK3R32yyn9hpn/FWcY6fX5m5
   vWOcvz8Pc0wPUY5aQPVtA14ez8IV6JW7qx0jUiSsq4pUOZZDtQnAJ24TD
   zr0BHQ1I4442hkQX/wPYCra9n/9HI1fXEbuhFxFQd8fmsuzVpl1HmhRWg
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="305110467"
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600";
   d="scan'208";a="305110467"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Dec 2021 16:22:00 -0800
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600";
   d="scan'208";a="468943763"
Received: from jiayingk-mobl2.gar.corp.intel.com (HELO
 anmitta2-mobl3.intel.com) ([10.215.231.141])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Dec 2021 16:21:59 -0800
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.52][PATCH 0/4] Review request
Date: Fri, 31 Dec 2021 08:21:51 +0800
Message-Id: <cover.1640910042.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 31 Dec 2021 00:22:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13204

Please review and merge these changes for 1.52. No issues seen while
testing on autobuilder.

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


