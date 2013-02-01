Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1U1CcK-0007KX-Jw
	for bitbake-devel@lists.openembedded.org;
	Fri, 01 Feb 2013 10:09:05 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id r118rLHs009632
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 1 Feb 2013 00:53:21 -0800 (PST)
Received: from pek-usp-3.wrs.com (128.224.163.124) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.318.4;
	Fri, 1 Feb 2013 00:53:19 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 1 Feb 2013 16:56:44 +0800
Message-ID: <cover.1359697886.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.11.2
MIME-Version: 1.0
Cc: Zhenfeng.Zhao@windriver.com
Subject: [PATCH 0/1] knotty.py: fix unknown event bb.event.DiskFull
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
X-List-Received-Date: Fri, 01 Feb 2013 09:09:05 -0000
Content-Type: text/plain

The following changes since commit 8d80483e2f0f755a61087be1dffaf595fbc467fd:

  bitbake: bitbake-layers: print the recipe's depends that crosses a layer boundary (2013-01-31 14:00:03 +0000)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib robert/knotty
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=robert/knotty

Robert Yang (1):
  knotty.py: fix unknown event bb.event.DiskFull

 bitbake/lib/bb/ui/knotty.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
1.7.11.2



