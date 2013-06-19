Return-Path: <cristiana.voicu@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 27897608CD
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Jun 2013 14:14:48 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 19 Jun 2013 07:12:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,896,1363158000"; d="scan'208";a="332146484"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.72])
	by orsmga001.jf.intel.com with ESMTP; 19 Jun 2013 07:14:46 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 19 Jun 2013 17:16:22 +0300
Message-Id: <1371651387-20886-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH 0/5] Make changes in Hob in order to work correctly with bitbake-worker
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
X-List-Received-Date: Wed, 19 Jun 2013 14:14:48 -0000


Cristiana Voicu (5):
  hob: remove the rest of the old template functionality
  bitbake: add a new command and modify others
  bitbake: call the initConfiguration when reparsing
  hob: replace the init cooker with reset in order to keep the history
  hob: save variables in conf/ directory

 bitbake/lib/bb/command.py                   |   30 ++---
 bitbake/lib/bb/cooker.py                    |   14 +-
 bitbake/lib/bb/ui/crumbs/builder.py         |  130 +++----------------
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |   62 ++++-----
 bitbake/lib/bb/ui/crumbs/template.py        |  187 ---------------------------
 5 files changed, 77 insertions(+), 346 deletions(-)
 delete mode 100644 bitbake/lib/bb/ui/crumbs/template.py

-- 
1.7.9.5


