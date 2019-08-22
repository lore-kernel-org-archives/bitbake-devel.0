Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 39E017EC95
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Aug 2019 07:10:18 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x7M7A060000398
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Aug 2019 00:10:10 -0700
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.468.0; Thu, 22 Aug 2019 00:09:49 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 22 Aug 2019 15:35:37 +0800
Message-ID: <cover.1566459309.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Subject: [PATCH 0/1] bitbake: cooker: Kill alive process before join it
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
X-List-Received-Date: Thu, 22 Aug 2019 07:10:19 -0000
Content-Type: text/plain

The following changes since commit 58ab85d3e005476ab5bcc288ad421c0c5d1e0582:

  systemd: add PACKAGECONFIG for gnu-efi (2019-08-21 21:52:59 +0100)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib rbt/cooker
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=rbt/cooker

Robert Yang (1):
  bitbake: cooker: Kill alive process before join it

 bitbake/lib/bb/cooker.py | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

-- 
2.7.4


