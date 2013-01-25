Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1TyiC2-0003oY-DV
	for bitbake-devel@lists.openembedded.org;
	Fri, 25 Jan 2013 13:15:39 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id r0P8ZDW2019607
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Jan 2013 00:35:13 -0800 (PST)
Received: from pek-usp-13.wrs.com (128.224.163.69) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.318.4;
	Fri, 25 Jan 2013 00:35:12 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 25 Jan 2013 16:35:08 +0800
Message-ID: <cover.1359080497.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.1
MIME-Version: 1.0
Cc: Zhenfeng.Zhao@windriver.com
Subject: [PATCH 0/2] bitbake-layers: print the recipe's depends that crosses a layer boundary
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
X-List-Received-Date: Fri, 25 Jan 2013 12:15:42 -0000
Content-Type: text/plain

The following changes since commit 8d6e55bf2192524bda84138b5356a2791adbbe61:

  prserv: add LOCALCOUNT to AUTOINCs migration feature (2013-01-22 16:01:32 +0000)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib robert/bitbake-layers
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=robert/bitbake-layers

Robert Yang (2):
  bitbake-layers: fix get_file_layer
  bitbake-layers: print the recipe's depends that crosses a layer
    boundary

 bitbake/bin/bitbake-layers |  136 +++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 135 insertions(+), 1 deletions(-)



