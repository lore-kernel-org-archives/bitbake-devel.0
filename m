Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60816C433F5
	for <webhook@archiver.kernel.org>; Thu, 25 Nov 2021 08:39:15 +0000 (UTC)
Received: from mail1.wrs.com (mail1.wrs.com [147.11.3.146])
 by mx.groups.io with SMTP id smtpd.web12.9690.1637829554654121738
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 25 Nov 2021 00:39:14 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=fail (domain: windriver.com, ip: 147.11.3.146, mailfrom: liezhi.yang@windriver.com)
Received: from mail.windriver.com (mail.wrs.com [147.11.1.11])
	by mail1.wrs.com (8.15.2/8.15.2) with ESMTPS id 1AP8dCJ9026826
	(version=TLSv1.1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>; Thu, 25 Nov 2021 00:39:13 -0800
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com
 [147.11.82.252])
	by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 1AP8dC4M023778
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
 Thu, 25 Nov 2021 00:39:12 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 25 Nov 2021 00:39:12 -0800
Received: from ala-lpggp3.wrs.com (147.11.105.124) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2242.12 via Frontend Transport; Thu, 25 Nov 2021 00:39:12 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 0/1] data_smart.py: Skip old override syntax checking for
 anonymous functions
Date: Thu, 25 Nov 2021 00:39:11 -0800
Message-ID: <cover.1637829491.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 25 Nov 2021 08:39:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13106

The following changes since commit ffd87a89393f25924f53dbc86dcf5a98c3a8d0ff:

  bitbake-user-manual: fix backslash issues (2021-11-21 11:28:00 +0000)

are available in the Git repository at:

  git://github.com/robertlinux/bitbake rbt/bb
  https://github.com/robertlinux/bitbake/tree/rbt/bb

Robert Yang (1):
  data_smart.py: Skip old override syntax checking for anonymous
    functions

 lib/bb/data_smart.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.31.1


