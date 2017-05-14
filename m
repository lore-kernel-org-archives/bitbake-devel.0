Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id B95F062133
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 14 May 2017 21:30:21 +0000 (UTC)
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	14 May 2017 14:30:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.38,341,1491289200"; d="scan'208";a="101449470"
Received: from cdhirema-mobl1.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.142.50])
	by fmsmga005.fm.intel.com with ESMTP; 14 May 2017 14:30:20 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 15 May 2017 09:29:54 +1200
Message-Id: <cover.1494797368.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.3
Subject: [PATCH 0/2] A couple of typo fixes
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
X-List-Received-Date: Sun, 14 May 2017 21:30:22 -0000

The following changes since commit 21d963149b5d97452420230a252101115b708d85:

  toaster: move release lookup from morty to pyro (2017-04-20 07:59:30 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bb-typofixes
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bb-typofixes

Paul Eggleton (2):
  lib/bb/COW.py: fix typo in Tim Ansell's name
  lib/bb/fetch2: fix typo in conflicting revision message

 lib/bb/COW.py             | 2 +-
 lib/bb/fetch2/__init__.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.9.3


