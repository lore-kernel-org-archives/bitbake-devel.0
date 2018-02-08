Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 7734F77BD2
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  8 Feb 2018 04:28:52 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w184SrcH023918
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 7 Feb 2018 20:28:53 -0800 (PST)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.361.1; Wed, 7 Feb 2018 20:28:46 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 8 Feb 2018 12:29:37 +0800
Message-ID: <cover.1518064148.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Subject: [PATCH 0/1] bitbake: toaster: don't use git fetch --all
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
X-List-Received-Date: Thu, 08 Feb 2018 04:28:52 -0000
Content-Type: text/plain

The following changes since commit 44ea6ded0e8e73f5258ce55bd1b851e24243b76a:

  bitbake: bitbake-user-manual: Commented out Placeholder Paragraph (2018-02-06 18:10:35 +0000)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib rbt/toaster
  http://git.pokylinux.org/cgit.cgi//log/?h=rbt/toaster

Robert Yang (1):
  bitbake: toaster: don't use git fetch --all

 bitbake/lib/toaster/bldcontrol/localhostbecontroller.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.7.4


