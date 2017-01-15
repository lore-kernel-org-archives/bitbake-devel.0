Return-Path: <brian.avery@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 2E3A260721
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 15 Jan 2017 03:16:44 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 14 Jan 2017 19:16:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,231,1477983600"; d="scan'208";a="1083120175"
Received: from bavery-ws-desk.jf.intel.com ([10.7.198.85])
	by orsmga001.jf.intel.com with ESMTP; 14 Jan 2017 19:16:44 -0800
From: brian avery <brian.avery@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 14 Jan 2017 19:18:30 -0800
Message-Id: <cover.1484450104.git.brian.avery@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: brian avery <brian.avery@intel.com>
Subject: [PATCH 0/1] toaster: Fixes 9252 broken image builds
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
X-List-Received-Date: Sun, 15 Jan 2017 03:16:46 -0000

This fixes the "cannot connect to database" errors in Yocto 9252 that
were preventing toaster from building anything. The tinfoil2 changes
resulted in TOASTER_DIR bring cleared by the server. I added
TOASTER_DIR to the BB_ENV_EXTRAWHITE list so it is preserved.

-brian

The following changes since commit 81021bc0aa0f64e67535f6a9551e921a64fe4395:

  yocto-project-qs, ref-manual: Added note for "resources temporarily unavailable" error (2017-01-11 17:23:18 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib toaster-next
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=bavery/toaster-9252

brian avery (1):
  toaster: bin/toaster whitelist TOASTER_DIR

 bin/toaster | 1 +
 1 file changed, 1 insertion(+)

--
1.9.1

