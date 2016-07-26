Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id ECFD560746
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Jul 2016 03:37:08 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga101.fm.intel.com with ESMTP; 25 Jul 2016 20:37:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,422,1464678000"; d="scan'208";a="1023890387"
Received: from unknown (HELO peggleto-mobl.ger.corp.intel.com)
	([10.255.139.129])
	by orsmga002.jf.intel.com with ESMTP; 25 Jul 2016 20:37:07 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 26 Jul 2016 15:36:39 +1200
Message-Id: <cover.1469504165.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
Subject: [PATCH 0/1] Fix file checksum failure with broken symlinks
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
X-List-Received-Date: Tue, 26 Jul 2016 03:37:09 -0000

The following changes since commit 5fa0b3a19e7d0f40790f737abeddf499d53f1f6a:

  bitbake: implement idle timeout for xmlrpc server (2016-07-21 07:48:35 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bb-checksum-fix
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bb-checksum-fix

Paul Eggleton (1):
  lib/bb/checksum: avoid exception on broken symlinks

 lib/bb/checksum.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.5.5


