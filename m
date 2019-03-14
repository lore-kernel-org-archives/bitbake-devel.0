Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 26F746B90D
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Mar 2019 09:09:17 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x2E98gQ9032345
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Mar 2019 02:09:07 -0700
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.439.0; Thu, 14 Mar 2019 02:08:59 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 14 Mar 2019 17:28:16 +0800
Message-ID: <cover.1552555629.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Subject: [PATCH 0/5] fetch2: Fixes for git and gitsm
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
X-List-Received-Date: Thu, 14 Mar 2019 09:09:17 -0000
Content-Type: text/plain

The following changes since commit 9818acbb00b6f78dbfcc5796ec78bf25f6535288:

  meta-yocto-bsp: Add the v5.0 kernel support for all the BSPs (2019-03-11 05:43:49 -0700)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib rbt/fetch2
  http://git.pokylinux.org/cgit.cgi//log/?h=rbt/fetch2

Robert Yang (5):
  fetch2/git: Fix clean to remove clonedir
  fetch2: Add get_mirrorname()
  fetch2: Print SCMs list when SRCREV_FORMAT is not set
  fetch2/gitsm: Add clean function
  fetch2: Add gitsm's function process_submodules()

 bitbake/lib/bb/fetch2/__init__.py | 33 +++++++++++++++++++++++++++++++--
 bitbake/lib/bb/fetch2/git.py      | 16 ++++++++++++----
 bitbake/lib/bb/fetch2/gitsm.py    | 15 +++++++++++++--
 3 files changed, 56 insertions(+), 8 deletions(-)

-- 
2.7.4


