Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id D3ACD65E8F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Apr 2014 16:35:54 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 10 Apr 2014 09:35:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,835,1389772800"; d="scan'208";a="518446356"
Received: from pbrannig-mobl.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.121.73])
	by fmsmga002.fm.intel.com with ESMTP; 10 Apr 2014 09:35:54 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 10 Apr 2014 17:35:39 +0100
Message-Id: <cover.1397147607.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.9.0
Subject: [PATCH 0/1] File checksum regression fix
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
X-List-Received-Date: Thu, 10 Apr 2014 16:35:55 -0000

The following changes since commit 40027a6e093c3b7480bfaccbd57e0e613d9a7b71:

  toaster: Allow toaster to start without pytz (2014-04-09 18:21:40 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/checksumfix3
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/checksumfix3

Paul Eggleton (1):
  cache: don't trigger reparse on recipes with wildcards in SRC_URI

 lib/bb/cache.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
1.9.0


