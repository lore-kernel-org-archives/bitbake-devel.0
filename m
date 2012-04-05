Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1SFmRO-0003oV-8P
	for bitbake-devel@lists.openembedded.org;
	Thu, 05 Apr 2012 15:09:30 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q35D0Hj7014289
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 5 Apr 2012 06:00:17 -0700 (PDT)
Received: from usp-ub10.corp.ad.wrs.com (128.224.163.69) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.1.255.0; Thu, 5 Apr 2012 06:00:17 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 5 Apr 2012 20:58:56 +0800
Message-ID: <cover.1333630624.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.1
MIME-Version: 1.0
Subject: [PATCH 0/1] diskspace monitor: assign a default value when only of the interval is set
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
X-List-Received-Date: Thu, 05 Apr 2012 13:09:30 -0000
Content-Type: text/plain

The following changes since commit 5607729d9901c394b7cd4db6e38fe7fb19116f39:

  self-hosted-image: Increase space for build and allow builder user sudo access (2012-04-04 17:17:55 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib robert/monitor
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=robert/monitor

Robert Yang (1):
  diskspace monitor: assign a default value when only of the interval
    is set

 bitbake/lib/bb/monitordisk.py |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)



