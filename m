Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <xiaotongx.lv@intel.com>) id 1SfLR7-0000Ts-0l
	for bitbake-devel@lists.openembedded.org;
	Fri, 15 Jun 2012 03:34:53 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 14 Jun 2012 18:23:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="180281927"
Received: from lxt.sh.intel.com ([10.239.47.66])
	by fmsmga002.fm.intel.com with ESMTP; 14 Jun 2012 18:23:09 -0700
From: Xiaotong lv <xiaotongx.lv@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 15 Jun 2012 21:23:21 -0400
Message-Id: <cover.1339809365.git.xiaotongx.lv@intel.com>
X-Mailer: git-send-email 1.7.4.4
Subject: [PATCH 0/1] Webhob: webservice client
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 15 Jun 2012 01:34:53 -0000

this is  a webservice python client based on suds.
if client is other different language. such as java, php, etc.
we can use their corresponding webservice client program to call bitbake.


The following changes since commit cbe94009a060bc680bf196732642e295151b8ef9:

  Webhob: a general helper interface based on webservice (2012-06-06 21:03:11 -0400)

are available in the git repository at:
  git://git.yoctoproject.org/poky-contrib xtlv/webhob-webservice
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=xtlv/webhob-webservice

Xiaotong lv (1):
  Webhob: webservice client

 .../bb/ui/webservice_client/client_webservice.py   |   63 ++++++++++++++++++++
 1 files changed, 63 insertions(+), 0 deletions(-)
 create mode 100644 bitbake/lib/bb/ui/webservice_client/client_webservice.py

-- 
1.7.4.4



