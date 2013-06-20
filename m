Return-Path: <cristiana.voicu@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 6F75860071
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Jun 2013 10:18:02 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 20 Jun 2013 03:19:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,903,1363158000"; d="scan'208";a="356656081"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.72])
	by fmsmga002.fm.intel.com with ESMTP; 20 Jun 2013 03:18:02 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 20 Jun 2013 13:19:40 +0300
Message-Id: <1371723585-27966-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH_V2 0/5] Chnages in Hob in order to work correctly with bitbake-worker
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 20 Jun 2013 10:18:02 -0000


Cristiana Voicu (5):
  hob: remove the rest of the old template functionality
  bitbake & hob: modify some commands and call them from hob
  bitbake: call the initConfiguration when reparsing
  hob: replace the init cooker with reset in order to keep the history
  hob: save variables in conf/ directory

 bitbake/lib/bb/command.py                   |   16 ++-
 bitbake/lib/bb/cooker.py                    |   14 +-
 bitbake/lib/bb/ui/crumbs/builder.py         |  130 +++----------------
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |   64 ++++-----
 bitbake/lib/bb/ui/crumbs/template.py        |  187 ---------------------------
 5 files changed, 77 insertions(+), 334 deletions(-)
 delete mode 100644 bitbake/lib/bb/ui/crumbs/template.py

-- 
1.7.9.5


