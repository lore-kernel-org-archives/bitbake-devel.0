Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1S3Nep-0001fM-SH
	for bitbake-devel@lists.openembedded.org;
	Fri, 02 Mar 2012 09:16:08 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q227tBP7019871
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 1 Mar 2012 23:55:11 -0800 (PST)
Received: from localhost.localdomain (128.224.162.225) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server
	(TLS) id 14.1.255.0; Thu, 1 Mar 2012 23:55:11 -0800
From: Kang Kai <kai.kang@windriver.com>
To: <sgw@linux.intel.com>, <bitbake-devel@lists.openembedded.org>
Date: Fri, 2 Mar 2012 15:54:57 +0800
Message-ID: <cover.1330674604.git.kai.kang@windriver.com>
X-Mailer: git-send-email 1.7.5.4
MIME-Version: 1.0
X-Originating-IP: [128.224.162.225]
Subject: [PATCH 0/1] Yocto 1561: enable cleanup of WORKDIR
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
X-List-Received-Date: Fri, 02 Mar 2012 08:16:08 -0000
Content-Type: text/plain

Hi Saul,

This is implementation of Yocto 1561: enable cleanup of WORKDIR.
The original design was create a new script to fullfill the feature, but it
doesn't work. So I add a command line option to do it.

Regards,

The following changes since commit 6b6aa170d5c618cfcd016dd1de926db647f7f932:

  busybox: Restore 'date' compatability (2012-03-01 23:16:43 +0000)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib kangkai/cleanup
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=kangkai/cleanup

Kang Kai (1):
  bitbake: enable cleanup of WORKDIR

 bitbake/bin/bitbake       |    4 +++
 bitbake/lib/bb/command.py |    5 +++
 bitbake/lib/bb/cooker.py  |   63 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+), 0 deletions(-)

-- 
1.7.5.4



