Return-Path: <tobias.hagelborn@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id 2EC48786BD
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Jan 2018 15:09:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 6506B18407
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Jan 2018 16:00:10 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id ywEDMUu9r9yo for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Jan 2018 16:00:08 +0100 (CET)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
	by bastet.se.axis.com (Postfix) with ESMTPS id 5E2FB1838E
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Jan 2018 16:00:08 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 290011A07B
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Jan 2018 16:00:08 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F11241A06F
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Jan 2018 16:00:07 +0100 (CET)
Received: from seth.se.axis.com (unknown [10.0.2.172])
	by boulder02.se.axis.com (Postfix) with ESMTP
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Jan 2018 16:00:07 +0100 (CET)
Received: from XBOX02.axis.com (xbox02.axis.com [10.0.5.16])
	by seth.se.axis.com (Postfix) with ESMTP id E0A283178
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Jan 2018 16:00:07 +0100 (CET)
Received: from lnxtobiasha.se.axis.com (10.0.5.60) by XBOX02.axis.com
	(10.0.5.16) with Microsoft SMTP Server (TLS) id 15.0.1263.5;
	Mon, 29 Jan 2018 16:00:07 +0100
From: Tobias Hagelborn <tobias.hagelborn@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 29 Jan 2018 15:59:51 +0100
Message-ID: <1517237992-4829-1-git-send-email-tobiasha@axis.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: XBOX03.axis.com (10.0.5.17) To XBOX02.axis.com (10.0.5.16)
X-TM-AS-GCONF: 00
Cc: Tobias Hagelborn <tobiasha@axis.com>
Subject: [PATCH] bb.utils.movefiles: Support cross device move into existing directory
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 29 Jan 2018 15:09:28 -0000
Content-Type: text/plain

This was a fully reproducable issue with populate_sdk using a setup of:
* Ubuntu 16 LTS / Linux kernel 4.4
* Docker 17 / storage-driver: overlay2 (overlayfs) (resulting in cross device copy)
* Our firmware image

Tobias Hagelborn (1):
  utils.py: Support cross device move into existing directory

 bitbake/lib/bb/utils.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

-- 
2.1.4


