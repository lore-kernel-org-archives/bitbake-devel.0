Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id D4AF060EA9
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Dec 2013 15:09:42 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.5) with ESMTP id rBAF9f6V006900
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Dec 2013 07:09:42 -0800 (PST)
Received: from pek-hostel-vm02.wrs.com (128.224.153.172) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
	14.2.347.0; Tue, 10 Dec 2013 07:09:42 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 10 Dec 2013 10:09:34 -0500
Message-ID: <cover.1386680149.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.10.4
MIME-Version: 1.0
Subject: [PATCH 0/5] [dora] bitbake: fixes for dora
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
X-List-Received-Date: Tue, 10 Dec 2013 15:09:43 -0000
Content-Type: text/plain

The following changes since commit 53d2563ff13fcec74d4250bef5419e36169e55cc:

  bitbake: perforce: Fix path subdirectory issues (2013-12-03 17:51:31 +0000)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib robert/dora-next-bitbake
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=robert/dora-next-bitbake

Olof Johansson (1):
  bitbake: monitordisk: lower inode check warning to note

Peter Seebach (1):
  bitbake: build.py: add single-quotes around already-expanded
    directory name

Richard Purdie (3):
  bitbake: cooker/command: Add error state for the server and use for
    pre_serve errors
  bitbake: fetch2: Fix handling of SCM mirrors in MIRRORS
  bitbake: runqueue: Fix hole in setsceneverify skipped task logic

 bitbake/lib/bb/build.py           |    2 +-
 bitbake/lib/bb/command.py         |    2 ++
 bitbake/lib/bb/cooker.py          |    3 ++-
 bitbake/lib/bb/fetch2/__init__.py |    4 ++++
 bitbake/lib/bb/monitordisk.py     |    2 +-
 bitbake/lib/bb/runqueue.py        |   21 +++++++++++++++++++--
 6 files changed, 29 insertions(+), 5 deletions(-)

-- 
1.7.10.4


