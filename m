Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE65C433F5
	for <webhook@archiver.kernel.org>; Fri,  5 Nov 2021 14:42:44 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [217.70.183.199])
 by mx.groups.io with SMTP id smtpd.web11.6533.1636123363284452068
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Nov 2021 07:42:43 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bootlin.com, ip: 217.70.183.199, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 507C9FF808;
	Fri,  5 Nov 2021 14:42:41 +0000 (UTC)
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH 0/2] doc: extend BitBake variable descriptions
Date: Fri,  5 Nov 2021 15:42:36 +0100
Message-Id: <20211105144238.27679-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Nov 2021 14:42:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12900

This starts an effort to migrate eliminate duplication between the BitBake
and the Yocto Project manuals.

This starts by moving information that's relevant for BitBake
from the Yocto Project manuals to the BitBake one.

Please review the changes with care. I looked at BitBake's and OE core's code,
but I may have overlooked some features which are specific to OE and
hence don't belong in the BitBake manual.

Michael Opdenacker (2):
  doc: bitbake-user-manual: add TMPDIR and WORKDIR to the variable index
  doc: bitbake-user-manual: expand SRC_URI description

 .../bitbake-user-manual-execution.rst         |   2 +-
 .../bitbake-user-manual-fetching.rst          |   4 +-
 .../bitbake-user-manual-hello.rst             |   4 +-
 .../bitbake-user-manual-ref-variables.rst     | 122 +++++++++++++-----
 4 files changed, 98 insertions(+), 34 deletions(-)

-- 
2.25.1


