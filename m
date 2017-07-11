Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 56AC277FFE
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Jul 2017 10:27:47 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id v6BARnHr021094
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Jul 2017 03:27:49 -0700
Received: from ala-blade48.wrs.com (147.11.105.68) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.294.0;
	Tue, 11 Jul 2017 03:27:48 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 11 Jul 2017 03:27:45 -0700
Message-ID: <cover.1499768495.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Subject: [RFC PATCH 0/3] memres: fix for --observe-only
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
X-List-Received-Date: Tue, 11 Jul 2017 10:27:48 -0000
Content-Type: text/plain

Hello,

These are just RFC patches, bitbake memeres still has other problems as
listed here:
https://wiki.yoctoproject.org/wiki/Tinfoil2

I sent these patches earlier to make sure that I'm on the correct way.

Things I will work on recently:
1) Nongthing in bitbake-cookerdaemon.log, this is incorrect
2) Sometimes, Ctrl-C can't stop the build correctly
3) Sometimes, "bitbake -m" can't shutdown the server

// Robert

The following changes since commit 854c8c2e4c24ea3ddfec6e5b5f6477f0620510e4:

  oeqa/tinfoil: Improve test_wait_event for race issues (2017-07-08 13:34:46 +0100)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib rbt/memres
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=rbt/memres

Robert Yang (3):
  bitbake: knotty.py: add MonitorDiskEvent and RecipeTaskPreProcess
  bitbake: lib: fix --observe-only
  bitbake: uihelper.py: check event.pid is present

 bitbake/lib/bb/main.py          |  2 +-
 bitbake/lib/bb/server/xmlrpc.py | 13 ++++++++-----
 bitbake/lib/bb/ui/knotty.py     |  2 ++
 bitbake/lib/bb/ui/uievent.py    |  5 +++--
 bitbake/lib/bb/ui/uihelper.py   | 41 ++++++++++++++++++++++-------------------
 5 files changed, 36 insertions(+), 27 deletions(-)

-- 
2.11.0


