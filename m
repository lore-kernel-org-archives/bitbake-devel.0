Return-Path: <jonathan.yong@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 7EA386C5D8
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  4 Dec 2018 05:37:53 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	03 Dec 2018 21:37:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,312,1539673200"; d="scan'208";a="115834321"
Received: from vanguard-01.png.intel.com ([10.221.118.162])
	by FMSMGA003.fm.intel.com with ESMTP; 03 Dec 2018 21:37:53 -0800
From: "Yong, Jonathan" <jonathan.yong@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  4 Dec 2018 05:37:52 +0000
Message-Id: <20181204053753.44975-1-jonathan.yong@intel.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Subject: [PATCH 0/1] document git usehead argument
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
X-List-Received-Date: Tue, 04 Dec 2018 05:37:53 -0000
Content-Transfer-Encoding: 8bit

This is a documentation-only change to document the usehead
argument.

Yong, Jonathan (1):
  bitbake-user-manual: document git usehead argument

 doc/bitbake-user-manual/bitbake-user-manual-fetching.xml | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.19.2


