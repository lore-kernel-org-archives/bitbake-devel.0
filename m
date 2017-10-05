Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id D5968719B7
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  5 Oct 2017 23:07:31 +0000 (UTC)
Received: from orsmga005.jf.intel.com ([10.7.209.41])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	05 Oct 2017 16:07:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.42,482,1500966000"; d="scan'208";a="157294789"
Received: from pnaidu-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.147.41])
	by orsmga005.jf.intel.com with ESMTP; 05 Oct 2017 16:07:29 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  6 Oct 2017 12:06:53 +1300
Message-Id: <cover.1507244747.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.5
Subject: [PATCH 0/1] toaster: build missing toaster.conf settings
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
X-List-Received-Date: Thu, 05 Oct 2017 23:07:32 -0000

Fix a regression in toaster caused by the server reworking. I believe
we will need this for the YP 2.4 release because Toaster configuration
is broken without it.


The following changes since commit 41ba3c8bfcd3501604f6a17bd327a8193b11b656:

  bitbake-user-manual: Updated kernel version in PREFERRED_VERSION example (2017-09-26 15:42:45 +0100)

are available in the git repository at:

  git://git.openembedded.org/bitbake-contrib paule/toaster-fix
  http://cgit.openembedded.org/bitbake-contrib/log/?h=paule/toaster-fix

David Reyna (1):
  toaster: build missing toaster.conf settings

 lib/toaster/bldcontrol/localhostbecontroller.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.9.5


