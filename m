Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1U2J5m-00075m-Kl
	for bitbake-devel@lists.openembedded.org;
	Mon, 04 Feb 2013 11:16:03 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id r14A0D3m010955
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 4 Feb 2013 02:00:13 -0800 (PST)
Received: from pek-usp-3.wrs.com (128.224.163.124) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.318.4;
	Mon, 4 Feb 2013 02:00:12 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 4 Feb 2013 18:03:34 +0800
Message-ID: <cover.1359970151.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.11.2
MIME-Version: 1.0
Cc: Zhenfeng.Zhao@windriver.com
Subject: [PATCH 0/1] monitordisk.py: disable the inode checking for some fs
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
X-List-Received-Date: Mon, 04 Feb 2013 10:16:05 -0000
Content-Type: text/plain

The following changes since commit 75f470cd18d693a9a96d9849291c2c8de4dcbeb8:

  qt4: Add space for _appends (2013-02-01 22:49:47 +0000)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib robert/monitor
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=robert/monitor

Robert Yang (1):
  monitordisk.py: disable the inode checking for some fs

 bitbake/lib/bb/monitordisk.py | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

-- 
1.7.11.2



