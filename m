Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 5441F60762
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 27 Mar 2017 00:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=intel.com; i=@intel.com; q=dns/txt; s=intel;
	t=1490573854; x=1522109854; h=from:to:subject:date:message-id;
	bh=tmtSscedvI03Wn9ATs5QN3U7wpFwItMDcJXUOs7NMj4=;
	b=JJbMZn3rDk0r8wS02UCsK+tfpjR7gD/KJynI1/np9xqFiq4g9UTRZXfg
	atVEdglk6/ElaZh+XgZu4AoW+GZGUg==;
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	26 Mar 2017 17:17:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.36,229,1486454400"; d="scan'208";a="80843969"
Received: from tienhauh-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.171.185])
	by fmsmga005.fm.intel.com with ESMTP; 26 Mar 2017 17:17:31 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 27 Mar 2017 13:17:25 +1300
Message-Id: <cover.1490573768.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.3
Subject: [PATCH 0/3] Fixes for tinfoil usage issues
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
X-List-Received-Date: Mon, 27 Mar 2017 00:17:32 -0000

Fixes for a recursion issue triggered by RSS in OE, and a logging issue
caused by the tinfoil2 rework.


The following changes since commit 751b06c25d22eea8240f9429cb49874082245e52:

  bitbake-diffsigs: Add debug support (2017-03-22 14:52:39 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/tinfoil-fixes-bb2
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/tinfoil-fixes-bb2

Paul Eggleton (3):
  fetch2/git: prevent recursion on getting latest revision
  lib/bb/msg: introduce logger_create() function
  tinfoil: enable client-side logger handling by default

 bin/bitbake-diffsigs | 14 ++------------
 bin/bitbake-dumpsig  | 14 ++------------
 bin/bitbake-layers   | 25 +++++--------------------
 lib/bb/fetch2/git.py | 28 ++++++++++++++++++++--------
 lib/bb/msg.py        | 15 +++++++++++++++
 lib/bb/tinfoil.py    |  6 +++++-
 6 files changed, 49 insertions(+), 53 deletions(-)

-- 
2.9.3


