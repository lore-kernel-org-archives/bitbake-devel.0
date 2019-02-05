Return-Path: <david.reyna@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 4DD6F7C07B
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  5 Feb 2019 04:14:16 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x154Dud7025465
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 4 Feb 2019 20:14:07 -0800
Received: from dreyna-Precision-T5600.corp.ad.wrs.com (147.11.200.210) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.435.0; Mon, 4 Feb 2019 20:13:46 -0800
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 4 Feb 2019 19:37:26 -0800
Message-ID: <cover.1549337711.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [147.11.200.210]
Subject: [PATCH 0/1] [thud] toaster: thud_branch_13064
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
X-List-Received-Date: Tue, 05 Feb 2019 04:14:17 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

Fix the Toaster fixture files for the Thud release to correctly
register and checkout the Thud branches.

The following changes since commit 3541f019a505d18263fad0b46b88d470e3fd9d62:

  bitbake: process: Rewrite multiple connection handling (2019-01-28 17:03:14 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib dreyna/submit/dreyna/toaster/thud_branch_13064
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=dreyna/submit/dreyna/toaster/thud_branch_13064

David Reyna (1):
  toaster: correctly register the thud branch

 lib/toaster/orm/fixtures/oe-core.xml | 2 +-
 lib/toaster/orm/fixtures/poky.xml    | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.7.4


