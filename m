Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1SugEv-0007rW-MD
	for bitbake-devel@lists.openembedded.org;
	Fri, 27 Jul 2012 10:49:42 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q6R8c7pG000585
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Fri, 27 Jul 2012 01:38:07 -0700 (PDT)
Received: from localhost.localdomain (128.224.162.164) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server
	(TLS) id 14.1.255.0; Fri, 27 Jul 2012 01:38:06 -0700
From: Kang Kai <kai.kang@windriver.com>
To: <richard.purdie@linuxfoundation.org>
Date: Fri, 27 Jul 2012 16:38:01 +0800
Message-ID: <cover.1343378110.git.kai.kang@windriver.com>
X-Mailer: git-send-email 1.7.5.4
MIME-Version: 1.0
X-Originating-IP: [128.224.162.164]
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: [PATCH 0/2] V3: hob check disk size
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
X-List-Received-Date: Fri, 27 Jul 2012 08:49:42 -0000
Content-Type: text/plain

Hi Richard,

In V3 I fire the event DiskFull in diskMonitor.check() as your commented.

Thanks,
Kai

The following changes since commit 0ffb02eec2beaea27ff0ec9d3d31b0a09e675a4c:

  documentation: Updated the h6 style to use a larger font (2012-07-24 10:35:34 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib kangkai/hob-check-size
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=kangkai/hob-check-size

Kang Kai (2):
  monitordisk: fire event DISKFULL when terminate build
  hob: deal event DiskFull

 bitbake/lib/bb/event.py                  |    8 ++++++++
 bitbake/lib/bb/monitordisk.py            |    5 +++++
 bitbake/lib/bb/ui/crumbs/builder.py      |    4 ++++
 bitbake/lib/bb/ui/crumbs/runningbuild.py |   11 ++++++++++-
 4 files changed, 27 insertions(+), 1 deletions(-)

-- 
1.7.5.4



