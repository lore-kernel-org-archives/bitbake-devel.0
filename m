Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 0778D6ABF7
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Apr 2015 08:44:25 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.9/8.14.9) with ESMTP id t3A8iQFK018324
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Apr 2015 01:44:26 -0700 (PDT)
Received: from ala-blade47.wrs.com (147.11.105.67) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.224.2;
	Fri, 10 Apr 2015 01:44:26 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 10 Apr 2015 01:44:25 -0700
Message-ID: <cover.1428655392.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Subject: [PATCH 0/1] bitbake: runqueue/cooker: catch hashvalidate error
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
X-List-Received-Date: Fri, 10 Apr 2015 08:44:26 -0000
Content-Type: text/plain

*** BLURB HERE ***
The following changes since commit 6ebeae9b2011050c318a764e980bc47e51cc2d74:

  tiff: remove extra dev and dbg from PACKAGES (2015-04-10 01:24:01 -0700)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib rbt/hx
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=rbt/hx

Hongxu Jia (1):
  bitbake: runqueue/cooker: catch hashvalidate error in
    RunQueueExecuteScenequeue

 bitbake/lib/bb/cooker.py   |    4 ++--
 bitbake/lib/bb/runqueue.py |   14 ++++++++------
 2 files changed, 10 insertions(+), 8 deletions(-)

-- 
1.7.9.5


