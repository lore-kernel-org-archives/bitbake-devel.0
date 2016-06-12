Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 6271860557
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 12 Jun 2016 08:44:59 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id u5C8j0Bi022446
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 12 Jun 2016 01:45:00 -0700 (PDT)
Received: from ala-blade47.wrs.com (147.11.105.67) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.248.2;
	Sun, 12 Jun 2016 01:45:00 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sun, 12 Jun 2016 01:44:59 -0700
Message-ID: <cover.1465721061.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.8.0
MIME-Version: 1.0
Subject: [PATCH 0/1] cooker.py: fix warn() -> warning()
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
X-List-Received-Date: Sun, 12 Jun 2016 08:45:00 -0000
Content-Type: text/plain

The following changes since commit 40e789d1fee7f0df2d23230fff38325119ad2935:

  bitbake: lib/bb/main.py: Fix use of BBPOSTCONF and BBPRECONF (2016-06-09 18:00:58 +0100)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib rbt/cooker
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=rbt/cooker

Robert Yang (1):
  cooker.py: fix warn() -> warning()

 bitbake/lib/bb/cooker.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.8.0


