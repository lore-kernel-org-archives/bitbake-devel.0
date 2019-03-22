Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 87A3F7CD17
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Mar 2019 09:36:24 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x2M9aOTh024725
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Mar 2019 02:36:25 -0700 (PDT)
Received: from ala-blade47.wrs.com (147.11.105.67) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.439.0;
	Fri, 22 Mar 2019 02:36:24 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 22 Mar 2019 02:36:23 -0700
Message-ID: <cover.1553247190.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Subject: [PATCH 0/1 V2] fetch2: Add get_mirrorname()
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
X-List-Received-Date: Fri, 22 Mar 2019 09:36:24 -0000
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

* V2
  - Use mirrorname as 'MIRRORNAME' if it is defined in origud.

* V1
  - Initial version

// Robert

The following changes since commit 2187d06166ed6819a1d07c3f8a3be7a256fab18c:

  goarch: Add riscv64 (2019-03-21 16:19:23 +0000)

are available in the Git repository at:

  git://git.pokylinux.org/poky-contrib rbt/mirror
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=rbt/mirror

Robert Yang (1):
  fetch2: Add get_mirrorname()

 bitbake/lib/bb/fetch2/__init__.py | 8 +++++++-
 bitbake/lib/bb/fetch2/git.py      | 4 +++-
 2 files changed, 10 insertions(+), 2 deletions(-)

-- 
2.21.0


