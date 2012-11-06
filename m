Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1TVlmb-0002QW-Ry
	for bitbake-devel@lists.openembedded.org;
	Tue, 06 Nov 2012 17:13:46 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id qA6CWQfQ019606
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 6 Nov 2012 04:32:26 -0800 (PST)
Received: from usp-opensuse12-64.corp.ad.wrs.com (128.224.162.26) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.2.318.4; Tue, 6 Nov 2012 04:32:25 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 6 Nov 2012 20:18:41 +0800
Message-ID: <cover.1352200293.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.7
MIME-Version: 1.0
Cc: Zhenfeng.Zhao@windriver.com
Subject: [PATCH 0/1] print clear message for "bitbake -e ASSUME_PROVIDED"
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
X-List-Received-Date: Tue, 06 Nov 2012 16:13:46 -0000
Content-Type: text/plain

The following changes since commit 78983e939ab17f02f8911c8b0d0e326b419856b9:

  lib/oe/classextend: Ensure we don't extend expressions more than once (2012-11-06 09:34:47 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib robert/assume
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=robert/assume

Robert Yang (1):
  print clear message for "bitbake -e ASSUME_PROVIDED"

 bitbake/lib/bb/cooker.py |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

-- 
1.7.7



