Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 0E14C60125
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Aug 2017 09:12:09 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id v789CARc005178
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 8 Aug 2017 02:12:10 -0700
Received: from ala-blade48.wrs.com (147.11.105.68) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.361.1;
	Tue, 8 Aug 2017 02:12:09 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 8 Aug 2017 02:12:04 -0700
Message-ID: <cover.1502183410.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Subject: [WIP][RFC PATCH 0/5] fix for memres bitbake
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
X-List-Received-Date: Tue, 08 Aug 2017 09:12:10 -0000
Content-Type: text/plain

The following changes since commit 9ed748a542b520c1cb763d981969233c0f5efd4e:

  bitbake: daemonize: Always print any remaning UI events at exit (2017-08-03 11:14:13 +0100)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib rbt/bitbake
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=rbt/bitbake

Robert Yang (5):
  btiabke: main.py: remove unneeded float()
  bitbake: main: add log handler when status-only
  bitbake: process: fix disconnect when BB_SERVER_TIMEOUT
  bitbake: main: handle BB_SERVER_TIMEOUT = -1
  bitbake: main: make observe-only work without --bind

 bitbake/lib/bb/main.py           | 14 +++++---------
 bitbake/lib/bb/server/process.py | 13 ++++++-------
 2 files changed, 11 insertions(+), 16 deletions(-)

-- 
2.11.0


