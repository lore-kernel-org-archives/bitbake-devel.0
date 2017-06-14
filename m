Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id 6844C782EF
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Jun 2017 10:10:50 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	14 Jun 2017 03:10:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.39,340,1493708400"; d="scan'208";a="867840901"
Received: from petrova-mobl12.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.48.250])
	by FMSMGA003.fm.intel.com with ESMTP; 14 Jun 2017 03:10:50 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Jun 2017 12:10:23 +0200
Message-Id: <cover.1497434991.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.4
Subject: [PATCH 0/2] A couple more memres fixes
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
X-List-Received-Date: Wed, 14 Jun 2017 10:10:51 -0000

The following changes since commit 8d0a76f5a595dddf16b7268bae2c00ef5f568316:

  ConfHandler.py: allow require or include with multiple parameters (2017-06-12 15:28:25 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bb-memres-fixes2
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bb-memres-fixes2

Paul Eggleton (2):
  cooker: fix always loading cache on every UI start with memres
  cooker: ensure graceful exit after exception during BuildCompleted handler

 lib/bb/cooker.py | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

-- 
2.9.4


