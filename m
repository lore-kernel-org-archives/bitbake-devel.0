Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 66EA66F242
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Apr 2014 14:35:43 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 07 Apr 2014 07:01:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,810,1389772800"; d="scan'208";a="488623562"
Received: from scfernan-mobl.gar.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.120.216])
	by orsmga001.jf.intel.com with ESMTP; 07 Apr 2014 07:01:24 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  7 Apr 2014 15:01:16 +0100
Message-Id: <cover.1396879250.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.9.0
Subject: [PATCH 0/1] Fix for missing file checksums
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
X-List-Received-Date: Mon, 07 Apr 2014 14:35:50 -0000

The following change since commit f9416e76e272ba3249abff099f6f3a47fe82e03e:

  fetch2: Fix bug in file checksum generation (2014-04-06 11:31:18 +0100)

is available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/checksumfix
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/checksumfix

Paul Eggleton (1):
  fetch2: avoid cache ignoring missing files

 lib/bb/fetch2/__init__.py | 1 -
 1 file changed, 1 deletion(-)

-- 
1.9.0


