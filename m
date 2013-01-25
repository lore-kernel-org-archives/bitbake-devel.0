Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1TyiBy-0003oY-D6
	for bitbake-devel@lists.openembedded.org;
	Fri, 25 Jan 2013 13:15:36 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id r0P8YFOi019597
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Jan 2013 00:34:15 -0800 (PST)
Received: from pek-usp-13.wrs.com (128.224.163.69) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.318.4;
	Fri, 25 Jan 2013 00:34:14 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 25 Jan 2013 16:34:12 +0800
Message-ID: <cover.1359083205.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.1
MIME-Version: 1.0
Cc: Zhenfeng.Zhao@windriver.com
Subject: [PATCH 0/1] cache.py: remove the duplicated self.file_depends
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
X-List-Received-Date: Fri, 25 Jan 2013 12:15:37 -0000
Content-Type: text/plain

The following changes since commit ec2e1349f8ef7116f2f451b52b7d228199388147:

  bitbake-layers: print the recipe's depends that crosses a layer boundary (2013-01-25 10:18:23 +0800)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib robert/cache.py
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=robert/cache.py

Robert Yang (1):
  cache.py: remove the duplicated self.file_depends

 bitbake/lib/bb/cache.py |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)



