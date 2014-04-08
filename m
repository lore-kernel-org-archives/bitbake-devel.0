Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id EF16265D40
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Apr 2014 14:33:57 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 08 Apr 2014 06:59:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,818,1389772800"; d="scan'208";a="489275236"
Received: from paulonei-mobl.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.120.244])
	by orsmga001.jf.intel.com with ESMTP; 08 Apr 2014 07:03:21 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  8 Apr 2014 15:03:08 +0100
Message-Id: <cover.1396965331.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.9.0
Subject: [PATCH 0/2] A couple more file checksum fixes
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
X-List-Received-Date: Tue, 08 Apr 2014 14:34:00 -0000

The following changes since commit 35c67281775b08925957c32663d587d486944e0e:

  hob: add "recipes/images/" to BBFILES when Hob is launched (2014-04-08 13:06:34 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/checksumfix2
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/checksumfix2

Paul Eggleton (2):
  fetch2: handle wildcards correctly when recording file checksums
  fetch2: fix traceback when a wildcard matches a directory

 lib/bb/fetch2/__init__.py | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

-- 
1.9.0


