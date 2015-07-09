Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 2333C6017E
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  9 Jul 2015 07:18:01 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.1/8.15.1) with ESMTPS id t697I1D4027943
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 9 Jul 2015 00:18:02 -0700 (PDT)
Received: from ala-blade47.wrs.com (147.11.105.67) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.224.2;
	Thu, 9 Jul 2015 00:18:01 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 9 Jul 2015 00:18:00 -0700
Message-ID: <cover.1436426161.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Subject: [PATCH 0/1 V2] git.py: create a branch when checkout
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
X-List-Received-Date: Thu, 09 Jul 2015 07:18:02 -0000
Content-Type: text/plain

* V2:
    - Use upstream name
    - Track remote branch

* V1:
    - Initial version

// Robert

The following changes since commit 0aaa67a790ab211b35eed58173efa115ceb6e243:

  oeqa/bbtests: Fix to ensure DL_DIR is set (2015-07-08 13:09:28 +0100)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib rbt/git
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=rbt/git

Robert Yang (1):
  git.py: create a branch when checkout

 bitbake/lib/bb/fetch2/git.py |    7 +++++++
 1 file changed, 7 insertions(+)

-- 
1.7.9.5


