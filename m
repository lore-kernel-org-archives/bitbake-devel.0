Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 5F13E6BE0C
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  4 Dec 2018 01:48:33 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id wB41mXVj029022
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 3 Dec 2018 17:48:34 -0800 (PST)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.408.0; Mon, 3 Dec 2018 17:48:33 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 4 Dec 2018 10:05:59 +0800
Message-ID: <cover.1543889029.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Subject: [PATCH 0/4] fixes for pysh
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
X-List-Received-Date: Tue, 04 Dec 2018 01:48:33 -0000
Content-Type: text/plain

Hi RP,

The pysh's code looks a little out of date, and the author declared that pysh
is no longer maintained:
http://pysh.sourceforge.net/

These are fixes for it.

// Robert

The following changes since commit 016e3dda2d6acc9b457079d11b5346a5352a431d:

  btrfs-tools: update to 4.19 (2018-12-03 12:20:01 +0000)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib rbt/pysh
  http://git.pokylinux.org/cgit.cgi//log/?h=rbt/pysh

Robert Yang (4):
  pysh: Remove unused modules
  pysh/sherrors.py: Remove unused classes
  pysh/pyshlex.py: Set is not importable
  bitbake: pysh: Improve error handling for shell code

 bitbake/lib/bb/codeparser.py          |    5 +-
 bitbake/lib/bb/pysh/builtin.py        |  710 -----------------
 bitbake/lib/bb/pysh/interp.py         | 1367 ---------------------------------
 bitbake/lib/bb/pysh/lsprof.py         |  116 ---
 bitbake/lib/bb/pysh/pysh.py           |  167 ----
 bitbake/lib/bb/pysh/pyshlex.py        |    5 -
 bitbake/lib/bb/pysh/pyshyacc.py       |   17 +-
 bitbake/lib/bb/pysh/sherrors.py       |   26 -
 bitbake/lib/bb/pysh/subprocess_fix.py |   77 --
 9 files changed, 13 insertions(+), 2477 deletions(-)
 delete mode 100644 bitbake/lib/bb/pysh/builtin.py
 delete mode 100644 bitbake/lib/bb/pysh/interp.py
 delete mode 100644 bitbake/lib/bb/pysh/lsprof.py
 delete mode 100644 bitbake/lib/bb/pysh/pysh.py
 delete mode 100644 bitbake/lib/bb/pysh/subprocess_fix.py

-- 
2.7.4


