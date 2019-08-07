Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 2E8EF7F30D
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Aug 2019 09:25:41 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x779PMP8010335
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 7 Aug 2019 02:25:32 -0700
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.468.0; Wed, 7 Aug 2019 02:25:10 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 7 Aug 2019 17:50:47 +0800
Message-ID: <cover.1565171270.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Subject: [PATCH 0/2] Fixes for KeyboardInterrupt during parsing and building
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
X-List-Received-Date: Wed, 07 Aug 2019 09:25:41 -0000
Content-Type: text/plain

The following changes since commit 88c6be81a5fbed098999fbef5576c5e0bb90cc21:

  opensbi: handle deploy task under sstate (2019-08-06 11:24:27 +0100)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib rbt/key
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=rbt/key

Robert Yang (2):
  cooker: Cleanup the queue before call process.join()
  knotty: Fix for the Second Keyboard Interrupt

 bitbake/lib/bb/cooker.py    |  8 ++++++++
 bitbake/lib/bb/ui/knotty.py | 18 ++++++++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)

-- 
2.7.4


