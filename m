Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1UGmeZ-0006Bo-FH
	for bitbake-devel@lists.openembedded.org;
	Sat, 16 Mar 2013 09:39:49 +0100
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id r2G8N1KZ029936
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 16 Mar 2013 01:23:01 -0700 (PDT)
Received: from pek-usp-9.wrs.com (128.224.162.26) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.2.342.3;
	Sat, 16 Mar 2013 01:23:00 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sat, 16 Mar 2013 16:07:40 +0800
Message-ID: <cover.1363405523.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.7
MIME-Version: 1.0
Cc: qingtao.cao@windriver.com
Subject: [PATCH 0/1] utils.py: fix BB_ENV_WHITELIST
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
X-List-Received-Date: Sat, 16 Mar 2013 08:39:49 -0000
Content-Type: text/plain

The following changes since commit 1ceb13dda11645229053fc4840954333f8910ba4:

  icecc: improve interaction with sstate (2013-03-15 01:53:05 +0000)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib robert/bb_white
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=robert/bb_white

Robert Yang (1):
  utils.py: fix BB_ENV_WHITELIST

 bitbake/lib/bb/utils.py |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

-- 
1.7.7



