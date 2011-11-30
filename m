Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1RVgVc-0005Da-A3
	for bitbake-devel@lists.openembedded.org;
	Wed, 30 Nov 2011 10:31:20 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id pAU9OdGo004835
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Nov 2011 01:24:39 -0800 (PST)
Received: from build-PowerEdge-T100.corp.ad.wrs.com (128.224.163.66) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.1.255.0; Wed, 30 Nov 2011 01:24:38 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 30 Nov 2011 17:23:49 +0800
Message-ID: <cover.1322644797.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.4.1
MIME-Version: 1.0
Subject: [PATCH 0/2] Remove a few unwanted lines
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
X-List-Received-Date: Wed, 30 Nov 2011 09:31:20 -0000
Content-Type: text/plain

Remove a few unwanted lines, and the following test is OK:

$ bitbake core-image-sato

// Robert

The following changes since commit cf02474bda67f4f1043b2e95e1b371b2354585a7:

  qt-mobility: Add missing patch (2011-11-29 14:36:18 +0000)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib robert/remove_unwanted
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=robert/remove_unwanted

Robert Yang (2):
  Remove the duplicated assignments of self.configuration.cmd
  Remove the async_cmds and sync_cmds from command.py

 bitbake/lib/bb/command.py |   14 --------------
 bitbake/lib/bb/cooker.py  |    3 ---
 2 files changed, 0 insertions(+), 17 deletions(-)

-- 
1.7.4.1



