Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 306276F569
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  3 Mar 2014 16:55:16 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 03 Mar 2014 08:50:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,578,1389772800"; d="scan'208";a="465598560"
Received: from dmilliga-mobl.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.120.25])
	by orsmga001.jf.intel.com with ESMTP; 03 Mar 2014 08:54:35 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  3 Mar 2014 16:54:30 +0000
Message-Id: <cover.1393865613.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.5.3
Subject: [PATCH 0/1] Allow exclusion of variable value portions from signatures
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
X-List-Received-Date: Mon, 03 Mar 2014 16:55:18 -0000

The following change since commit 8239264753977bd06ad5b1b574245d3842af489b:

  fetch2: Drop svk fetcher (2014-03-02 17:23:30 +0000)

is available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/vardepvalueexclude
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/vardepvalueexclude

Paul Eggleton (1):
  data: add vardepvalueexclude varflag

 lib/bb/data.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

-- 
1.8.5.3


