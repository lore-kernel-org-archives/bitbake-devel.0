Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id A4FF6719B8
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Jun 2017 19:04:59 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	07 Jun 2017 12:05:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.39,311,1493708400"; d="scan'208";a="865610498"
Received: from nippert-mobl.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.38.12])
	by FMSMGA003.fm.intel.com with ESMTP; 07 Jun 2017 12:04:59 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  7 Jun 2017 21:04:15 +0200
Message-Id: <cover.1496862217.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.4
Subject: [PATCH 0/2] Tinfoil log duplication fixes
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
X-List-Received-Date: Wed, 07 Jun 2017 19:05:01 -0000

The following changes since commit 705ab252e631903e6d2e46202b419a9e8adcd861:

  bitbake-layers: check layer dependencies before adding (2017-06-05 13:33:14 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bb-tinfoil-logging
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bb-tinfoil-logging

Paul Eggleton (2):
  tinfoil: fix duplication of log messages
  knotty: prevent extra logger from being enabled for tinfoil

 lib/bb/main.py      | 4 ++--
 lib/bb/msg.py       | 7 +++++++
 lib/bb/tinfoil.py   | 3 ++-
 lib/bb/ui/knotty.py | 5 +++--
 4 files changed, 14 insertions(+), 5 deletions(-)

-- 
2.9.4


