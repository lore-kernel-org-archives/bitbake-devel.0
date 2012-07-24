Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1StZLU-00063h-BC
	for bitbake-devel@lists.openembedded.org;
	Tue, 24 Jul 2012 09:15:52 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q6O74LnZ001992
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 24 Jul 2012 00:04:21 -0700 (PDT)
Received: from localhost.localdomain (128.224.162.164) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server
	(TLS) id 14.1.255.0; Tue, 24 Jul 2012 00:04:20 -0700
From: Kang Kai <kai.kang@windriver.com>
To: <richard.purdie@linuxfoundation.org>
Date: Tue, 24 Jul 2012 15:04:13 +0800
Message-ID: <cover.1343113295.git.kai.kang@windriver.com>
X-Mailer: git-send-email 1.7.5.4
MIME-Version: 1.0
X-Originating-IP: [128.224.162.164]
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: [PATCH 0/2] treat runqueue terminated by disk monitor as failure
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
X-List-Received-Date: Tue, 24 Jul 2012 07:15:52 -0000
Content-Type: text/plain

Hi Richard,

These 2 patches are for Yocto 2168. BB_DISKMON_DIRS and BB_DISKMON_WARNINTERVAL
should be set in local.conf to enable disk monitor to test the patches.

Regards,
Kai

The following changes since commit 315d52934693b14f08b62f3f5f361d834484e180:

  Pyphon-native: Fix typo (2012-07-22 14:20:57 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib kangkai/hob-check-size
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=kangkai/hob-check-size

Kang Kai (2):
  monitordisk: update return value
  cooker: treat termination by disk monitor as failure

 bitbake/lib/bb/cooker.py      |   14 ++++++++++++--
 bitbake/lib/bb/event.py       |    5 +++--
 bitbake/lib/bb/monitordisk.py |   12 ++++++++++--
 bitbake/lib/bb/runqueue.py    |    9 +++++----
 4 files changed, 30 insertions(+), 10 deletions(-)

-- 
1.7.5.4



