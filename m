Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id D9F047868B
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  1 Feb 2018 15:14:50 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w11FEpgB021101
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 1 Feb 2018 07:14:52 -0800 (PST)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.361.1; Thu, 1 Feb 2018 07:14:51 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 1 Feb 2018 23:15:21 +0800
Message-ID: <cover.1517497731.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Subject: [PATCH 0/8] cooker: fixes and parsing performance improve
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
X-List-Received-Date: Thu, 01 Feb 2018 15:14:52 -0000
Content-Type: text/plain

Hi RP,

These patches contain fixes for memory resident bitbake, and
parsing/loading improvement, please see the patches for details.

BTW., do we have a plan to switch to memory resident bitbake by default?
I've tested it a lot with these patches, it works well.

// Robert

The following changes since commit 385944254d0ef88bd6450a221a54cbcb40020b42:

  tcmode-default.inc: drop preferred version of gzip-native (2018-01-31 17:01:20 +0000)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib rbt/inotify
  http://git.pokylinux.org/cgit.cgi//log/?h=rbt/inotify

Robert Yang (8):
  bitbake: cooker: skip when BBFILE_PATTERN is empty
  bitbake: cooker: fix for BBFILE_PATTERN matches bbappend
  bitbake: cooker: don't stop file notifier when cooker is shutdown
  bitbake: cooker: don't preserve BB_CONSOLELOG
  bitbake: cache: improve debug message
  bitbake: parse: fixes for resolve_file()
  bitbake: cooker: fix event notifications
  bitbake: cooker: improve inotify handling

 bitbake/lib/bb/cache.py                      | 14 +++--
 bitbake/lib/bb/cooker.py                     | 79 +++++++++++++++-------------
 bitbake/lib/bb/parse/__init__.py             |  3 +-
 bitbake/lib/bb/parse/parse_py/BBHandler.py   |  3 --
 bitbake/lib/bb/parse/parse_py/ConfHandler.py |  3 --
 bitbake/lib/bb/server/process.py             |  2 +
 6 files changed, 55 insertions(+), 49 deletions(-)

-- 
2.7.4


