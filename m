Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1SuKiQ-0004LN-OI
	for bitbake-devel@lists.openembedded.org;
	Thu, 26 Jul 2012 11:50:43 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id q6Q9d9UT014645
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 26 Jul 2012 02:39:09 -0700 (PDT)
Received: from localhost.localdomain (128.224.162.164) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server
	(TLS) id 14.1.255.0; Thu, 26 Jul 2012 02:39:09 -0700
From: Kang Kai <kai.kang@windriver.com>
To: <richard.purdie@linuxfoundation.org>
Date: Thu, 26 Jul 2012 17:39:05 +0800
Message-ID: <cover.1343295453.git.kai.kang@windriver.com>
X-Mailer: git-send-email 1.7.5.4
MIME-Version: 1.0
X-Originating-IP: [128.224.162.164]
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: [PATCH 0/3] V2: hob check disk size
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
X-List-Received-Date: Thu, 26 Jul 2012 09:50:43 -0000
Content-Type: text/plain

Hi Richard,

This version 2 update to create a new event DiskFull to descript the termination by disk monitor.
The event DiskFull records the information of which device, lack of disk or inode, free space left
and mount point as you comment in previous letter.

Update hob to deal event DiskFull. Because the detail log could be seen in log tab, I didn't change
the hob code too much.

Regards,
Kai

The following changes since commit 0ffb02eec2beaea27ff0ec9d3d31b0a09e675a4c:

  documentation: Updated the h6 style to use a larger font (2012-07-24 10:35:34 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib kangkai/hob-check-size
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=kangkai/hob-check-size

Kang Kai (3):
  monitordisk: update check() to return a dict
  cooker: send event when terminated by disk monitor
  hob: deal event DiskFull

 bitbake/lib/bb/cooker.py                 |   14 ++++++++++++--
 bitbake/lib/bb/event.py                  |    8 ++++++++
 bitbake/lib/bb/monitordisk.py            |   25 +++++++++++++++++++++++--
 bitbake/lib/bb/runqueue.py               |    9 +++++----
 bitbake/lib/bb/ui/crumbs/builder.py      |    4 ++++
 bitbake/lib/bb/ui/crumbs/runningbuild.py |   11 +++++++++++
 6 files changed, 63 insertions(+), 8 deletions(-)

-- 
1.7.5.4



