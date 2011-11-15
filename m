Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1RQLeL-00034i-H1
	for bitbake-devel@lists.openembedded.org;
	Tue, 15 Nov 2011 17:14:17 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id pAFDk8g5019511
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 Nov 2011 05:46:08 -0800 (PST)
Received: from build-PowerEdge-T100.corp.ad.wrs.com (128.224.163.66) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.1.255.0; Tue, 15 Nov 2011 05:46:08 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 15 Nov 2011 21:45:38 +0800
Message-ID: <cover.1321364305.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.4.1
MIME-Version: 1.0
Subject: [RFC PATCH 0/1] Fix bitbake-runtask
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
X-List-Received-Date: Tue, 15 Nov 2011 16:14:17 -0000
Content-Type: text/plain

Hi Richard,

There are losts changes for bitbake-runtask, and I'm not very sure
about them, please see the commit message and give your suggestions.

Thank you very much!

// Robert

Please review the following changes for suitability for inclusion. If you have
any objections or suggestions for improvement, please respond to the patches. If
you agree with the changes, please provide your Acked-by.

The following changes since commit fa81f8dfb7a342e355b608aa4204cf23ed2b251c:

  mime.bbclass: fix typo (2011-11-15 12:05:30 +0000)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib robert/bitbake-runtask
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=robert/bitbake-runtask

Robert Yang (1):
  Fix bitbake-runtask

 bitbake/bin/bitbake-runtask |   74 ++++++++++++++++++++++--------------------
 bitbake/lib/bb/build.py     |    4 +-
 2 files changed, 41 insertions(+), 37 deletions(-)

-- 
1.7.4.1



