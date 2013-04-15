Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1URfad-0001ka-8G
	for bitbake-devel@lists.openembedded.org;
	Mon, 15 Apr 2013 11:21:05 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id r3F93DiQ011879
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Apr 2013 02:03:13 -0700 (PDT)
Received: from pek-usp-9.wrs.com (128.224.162.26) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.2.342.3;
	Mon, 15 Apr 2013 02:03:13 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 15 Apr 2013 16:47:35 +0800
Message-ID: <cover.1365993432.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.7
MIME-Version: 1.0
Subject: [PATCH 0/1] monitordisk.py: disable inode checking for btrfs
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
X-List-Received-Date: Mon, 15 Apr 2013 09:21:07 -0000
Content-Type: text/plain

The following changes since commit 068085f79010e3db70085d4b789f84ae721e4901:

  ref-manual: Review comments applied for patch session (2013-04-13 23:57:17 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib robert/monitor
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=robert/monitor

Robert Yang (1):
  monitordisk.py: disable inode checking for btrfs

 bitbake/lib/bb/monitordisk.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

-- 
1.7.7



