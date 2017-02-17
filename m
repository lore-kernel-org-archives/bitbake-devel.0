Return-Path: <markus.lehtonen@linux.intel.com>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by mail.openembedded.org (Postfix) with ESMTP id 3E22271A74
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 Feb 2017 09:39:20 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga105.fm.intel.com with ESMTP; 17 Feb 2017 01:39:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.35,171,1484035200"; d="scan'208";a="47687443"
Received: from bpaczek-mobl.ger.corp.intel.com (HELO
	mqz-osx-suse64.fi.intel.com) ([10.252.29.32])
	by orsmga002.jf.intel.com with ESMTP; 17 Feb 2017 01:39:20 -0800
From: Markus Lehtonen <markus.lehtonen@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 17 Feb 2017 11:39:17 +0200
Message-Id: <1487324358-2675-1-git-send-email-markus.lehtonen@linux.intel.com>
X-Mailer: git-send-email 2.6.6
Subject: [PATCH] Fix to svn fetcher
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
X-List-Received-Date: Fri, 17 Feb 2017 09:39:22 -0000

I came up with this patch when working on Yocto bug #10405 and going through
all the svn fetcher parameters. I'm not an SVN expert but the code looked
broken and the documentation is incorrect, too, e.g. in that svn does not support
rsh:// protocol.

Markus Lehtonen (1):
  fetch2/svn: change 'rsh' parameter to 'ssh'

 lib/bb/fetch2/svn.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.6.6


