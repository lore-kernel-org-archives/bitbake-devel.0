Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1S4neF-000370-00
	for bitbake-devel@lists.openembedded.org;
	Tue, 06 Mar 2012 07:13:23 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q2664kiW005515
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 5 Mar 2012 22:04:46 -0800 (PST)
Received: from build-PowerEdge-T100.corp.ad.wrs.com (128.224.163.66) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.1.255.0; Mon, 5 Mar 2012 22:04:46 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 6 Mar 2012 14:04:35 +0800
Message-ID: <cover.1331012089.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.4.1
MIME-Version: 1.0
Subject: [PATCH 0/1] siggen.py: Use basehash if no taskhash
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
X-List-Received-Date: Tue, 06 Mar 2012 06:13:23 -0000
Content-Type: text/plain

The following changes since commit a439d32dd843d10a9f65cc858b02422fac7deb50:

  soc-family.inc: to be included in machine.conf to add SOC_FAMILY to MACHINEOVERRIDE (2012-03-04 05:41:11 -0800)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib robert/basehash
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=robert/basehash

Robert Yang (1):
  siggen.py: Use basehash if no taskhash

 bitbake/lib/bb/siggen.py |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

-- 
1.7.4.1



