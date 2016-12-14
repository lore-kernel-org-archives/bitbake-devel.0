Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id A3D3160767
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Dec 2016 06:05:09 +0000 (UTC)
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
	by orsmga103.jf.intel.com with ESMTP; 13 Dec 2016 22:05:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,345,1477983600"; d="scan'208";a="42390047"
Received: from oshau-mobl1.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.185.66])
	by fmsmga006.fm.intel.com with ESMTP; 13 Dec 2016 22:05:09 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Dec 2016 19:05:02 +1300
Message-Id: <cover.1481695229.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
Subject: [PATCH v2 0/1] runqueue: dry-run real tasks when BB_SETSCENE_ENFORCE is set
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
X-List-Received-Date: Wed, 14 Dec 2016 06:05:10 -0000

Changes since v1:
* Ensure the worker does actually run the task during setscene tasks, which it
  erroneously wasn't in v1 due to the same main worker instance being shared
  between the setscene and normal tasks - I clearly hadn't tested the patch
  properly.
* Compare BB_SETSCENE_ENFORCE to "1" rather than just checking it's assigned


The following changes since commit a2768ecae7846d72a1bdb7cbbc5e8d242af854f6:

  bitbake-user-manual: Added new "Line Joining" section. (2016-12-08 16:35:56 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/setscene-enforce-dryrun
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/setscene-enforce-dryrun

Paul Eggleton (1):
  runqueue: dry-run real tasks when BB_SETSCENE_ENFORCE is set

 bin/bitbake-worker | 12 +++++++-----
 lib/bb/runqueue.py | 13 +++++++------
 2 files changed, 14 insertions(+), 11 deletions(-)

-- 
2.5.5


