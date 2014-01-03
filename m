Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 8130760E7C
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  3 Jan 2014 09:21:59 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.5) with ESMTP id s039M0HU026033
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 3 Jan 2014 01:22:00 -0800 (PST)
Received: from pek-blade16.wrs.com (128.224.153.44) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.2.347.0;
	Fri, 3 Jan 2014 01:22:00 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sat, 4 Jan 2014 01:24:31 +0800
Message-ID: <cover.1388769834.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Subject: [PATCH 0/1] bitbake/lib/bb/cooker.py: remove a duplicated self.data
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 03 Jan 2014 09:22:00 -0000
Content-Type: text/plain

The following changes since commit 17aa50645015a149298e78a175bbd3cbf171df22:

  classes/package: set SUMMARY in do_split_packages() (2014-01-02 22:39:24 +0000)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib robert/cooker
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=robert/cooker

Robert Yang (1):
  bitbake/lib/bb/cooker.py: remove a duplicated self.data

 bitbake/lib/bb/cooker.py | 2 --
 1 file changed, 2 deletions(-)

-- 
1.8.3.1


