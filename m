Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id DFD8378072
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Jul 2017 12:52:10 +0000 (UTC)
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	27 Jul 2017 05:52:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.40,419,1496127600"; d="scan'208";a="131949807"
Received: from nippert-mobl.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.43.119])
	by fmsmga005.fm.intel.com with ESMTP; 27 Jul 2017 05:52:10 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 27 Jul 2017 14:51:48 +0200
Message-Id: <cover.1501159861.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.4
Subject: [PATCH 0/1] bitbake-diffsigs: fix regression after recent server changes
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
X-List-Received-Date: Thu, 27 Jul 2017 12:52:11 -0000

The following changes since commit 1b14f115a9e929e29e91e8ac70826a3fe7259961:

  fetch2/__init__.py: replace stray logger.warn() with logger.warning() (2017-07-25 23:14:07 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bb-diffsigs-server-fix
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bb-diffsigs-server-fix

Paul Eggleton (1):
  bitbake-diffsigs: fix regression after recent server changes

 bin/bitbake-diffsigs | 35 ++++++++++++++++++++++++++++-------
 lib/bb/command.py    | 11 +++++++++++
 lib/bb/event.py      |  8 ++++++++
 3 files changed, 47 insertions(+), 7 deletions(-)

-- 
2.9.4


