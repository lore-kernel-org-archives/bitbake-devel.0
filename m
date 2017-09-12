Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by mail.openembedded.org (Postfix) with ESMTP id 33A70783F1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Sep 2017 10:11:11 +0000 (UTC)
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by orsmga104.jf.intel.com with ESMTP; 12 Sep 2017 03:11:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.42,382,1500966000"; d="scan'208";a="127916103"
Received: from nrahulx-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.249.73.25])
	by orsmga004.jf.intel.com with ESMTP; 12 Sep 2017 03:11:10 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 12 Sep 2017 22:10:33 +1200
Message-Id: <cover.1505210965.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.5
Subject: [PATCH 0/1] command: Add command to invalidate parse cache
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
X-List-Received-Date: Tue, 12 Sep 2017 10:11:12 -0000

This is required by the OE-Core patch I'm about to send to fix
devtool's lack of handling dependencies during source extraction.


The following changes since commit ed3aab90dbf9b6efefd9eb66d81123cb94d3c7da:

  toaster: update pyro to rocko as stable release (2017-09-11 11:00:11 +0100)

are available in the git repository at:

  git://git.openembedded.org/bitbake-contrib paule/parsecache-invalidate
  http://cgit.openembedded.org/bitbake-contrib/log/?h=paule/parsecache-invalidate

Paul Eggleton (1):
  command: Add command to invalidate parse cache

 lib/bb/command.py | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.9.5


