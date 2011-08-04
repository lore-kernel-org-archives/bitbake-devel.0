Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qomj2-0000xE-Fb
	for bitbake-devel@lists.openembedded.org;
	Thu, 04 Aug 2011 03:27:52 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 03 Aug 2011 18:23:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,313,1309762800"; d="scan'208";a="34155889"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.173])
	by orsmga002.jf.intel.com with ESMTP; 03 Aug 2011 18:23:28 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  3 Aug 2011 18:23:16 -0700
Message-Id: <cover.1312420894.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 0/6] Bug fixes for hob
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 04 Aug 2011 01:27:52 -0000

A fairly small series of bug fixes for the hob UI, please review.

The following changes since commit 25ec13075855f7e321a9763682a8cd4ca09203cd:

  bb/ui/crumbs/runningbuild: emit signal when command fails with exit signal (2011-08-02 18:12:46 -0700)

are available in the git repository at:
  git://github.com/incandescant/bitbake hob
  https://github.com/incandescant/bitbake/tree/hob

Joshua Lock (6):
  bb/ui/hob: fix detection of whether GPLv3 is disabled
  bb/ui/crumbs/tasklistmodel: fix regex used for loading image recipes
  bb/ui/hob: prevent label on progress bar from changing rapidly when
    loading
  bb/ui/crumbs/hobeventhandler: use generic loading message once cache
    loaded
  bb/ui/hob: only connect to the changed signal of image_combo once
  bb/ui/hob: be clear that the image contents are an estimate

 lib/bb/ui/crumbs/hobeventhandler.py |    3 +-
 lib/bb/ui/crumbs/tasklistmodel.py   |    2 +-
 lib/bb/ui/hob.py                    |   39 ++++++++++++++++++++++++++---------
 3 files changed, 32 insertions(+), 12 deletions(-)

-- 
1.7.6



