Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by mail.openembedded.org (Postfix) with ESMTP id 6732D71C9C
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  9 Dec 2016 02:26:38 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga105.fm.intel.com with ESMTP; 08 Dec 2016 18:26:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,322,1477983600"; d="scan'208";a="200673373"
Received: from sng18-mobl3.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.190.78])
	by fmsmga004.fm.intel.com with ESMTP; 08 Dec 2016 18:26:38 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  9 Dec 2016 15:26:32 +1300
Message-Id: <cover.1481250376.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
Subject: [PATCH 0/1] runqueue: dry-run real tasks when BB_SETSCENE_ENFORCE is set
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
X-List-Received-Date: Fri, 09 Dec 2016 02:26:43 -0000

The following changes since commit a2768ecae7846d72a1bdb7cbbc5e8d242af854f6:

  bitbake-user-manual: Added new "Line Joining" section. (2016-12-08 16:35:56 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/setscene-enforce-dryrun
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/setscene-enforce-dryrun

Paul Eggleton (1):
  runqueue: dry-run real tasks when BB_SETSCENE_ENFORCE is set

 bin/bitbake-worker | 6 ++++--
 lib/bb/runqueue.py | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

-- 
2.5.5


