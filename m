Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B593C433FE
	for <webhook@archiver.kernel.org>; Fri, 29 Apr 2022 11:19:47 +0000 (UTC)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by mx.groups.io with SMTP id smtpd.web09.8783.1651231177220696368
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 29 Apr 2022 04:19:38 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="unable to parse pub key" header.i=@intel.com header.s=intel
 header.b=D1dv0U65;
 spf=pass (domain: intel.com, ip: 134.134.136.65,
 mailfrom: anuj.mittal@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651231177; x=1682767177;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fkkwlCJFCCzSDqr3Qmb7OEP+M0rjPMmJKVAJq+RGjdk=;
  b=D1dv0U65Sjg9SZiaDvX8jw9H1tWDLHlkEMp0BjZWGORPB/rR64OWHSze
   YQ0jUM6kqn06cGUu27Ei6ZjGneSsrI6p+8T+tPFY64maKk5+2SEAYGAfQ
   Np6uh8eCDEIxLuKFfKez4iD2tw7/3MXD9Fyh4qYn5nmrcasRUrv0kzPyG
   yHtFTSg1Ic0SxRgfln1WR1+C4awIDaX3znxrZrh4POR1Ic5czCmyNnSuF
   qFTr5QazuA+ogWR6lKh2kMb3MjYTKlTDa1KsST8n4hXkcIew86lTMm+eq
   H2P/o8TSjZ4GShTNI81xWRNpNUn6swcUoyCvByI1uXiOjJ5RGO1XmHD7J
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="266430830"
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600";
   d="scan'208";a="266430830"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2022 04:15:54 -0700
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600";
   d="scan'208";a="597282339"
Received: from fsuhimi-mobl.gar.corp.intel.com (HELO anmitta2-mobl3.intel.com)
 ([10.215.146.39])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2022 04:15:43 -0700
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.52][PATCH 0/2] Pull request
Date: Fri, 29 Apr 2022 19:15:36 +0800
Message-Id: <cover.1651230735.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 29 Apr 2022 11:19:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13666

Please review these changes for honister/1.52. Tested with OE-core and
no problems seen while testing.

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/3591

Thanks,

Anuj

The following changes since commit 70ea322a4866f7ef20361a6b146f2be568261c6a:

  server/process: Disable gc around critical section (2022-04-16 23:02:05 +0100)

are available in the Git repository at:

  git://push.openembedded.org/bitbake-contrib stable/1.52-next

Ross Burton (2):
  bitbake: knotty: display active tasks when printing keepAlive()
    message
  bitbake: knotty: reduce keep-alive timeout from 5000s (83 minutes) to
    10 minutes

 lib/bb/ui/knotty.py | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

-- 
2.35.1


