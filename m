Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id 47C79783D2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Jun 2017 14:33:50 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	15 Jun 2017 07:33:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.39,343,1493708400"; d="scan'208";a="99855401"
Received: from hadjizad-mobl2.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.63.65])
	by orsmga002.jf.intel.com with ESMTP; 15 Jun 2017 07:33:51 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 15 Jun 2017 16:33:27 +0200
Message-Id: <cover.1497537169.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.4
Subject: [PATCH 0/1] Additional Hob code removal
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
X-List-Received-Date: Thu, 15 Jun 2017 14:33:51 -0000

The following changes since commit 7b4e81772ed8789521661a3b32b576c91276ae34:

  bitbake-user-manual: Updated BBLAYERS_FETCH_DIR variable description (2017-06-15 11:15:52 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bb-drob-hob-events
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bb-drob-hob-events

Paul Eggleton (1):
  event: drop some unused events

 lib/bb/event.py | 21 ---------------------
 1 file changed, 21 deletions(-)

-- 
2.9.4


