Return-Path: <Qi.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id D1A0A605D2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Apr 2015 08:45:58 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail1.windriver.com (8.14.9/8.14.9) with ESMTP id t3F8jx8n023426
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Apr 2015 01:45:59 -0700 (PDT)
Received: from pek-qchen1-d1.corp.ad.wrs.com (128.224.162.236) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
	14.3.224.2; Wed, 15 Apr 2015 01:45:59 -0700
From: Chen Qi <Qi.Chen@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 15 Apr 2015 16:46:04 +0800
Message-ID: <cover.1429087384.git.Qi.Chen@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Subject: [PATCH V2 0/1] bitbake-layers: change the behaviour of show-cross-depends
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
X-List-Received-Date: Wed, 15 Apr 2015 08:46:04 -0000
Content-Type: text/plain

Changes in V2:
Use regex match to determine the layer directory name instead of using the hacky
method.

The following changes since commit 9e4adec98db325112ca7a8b9dd95722d4d0ab642:

  distro_alias.inc: update/sort alias information. (2015-03-31 22:54:54 +0100)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib ChenQi/bitbake-layers-show-cross-depends
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=ChenQi/bitbake-layers-show-cross-depends

Chen Qi (1):
  bitbake-layers: change the behaviour of show-cross-depends

 bitbake/bin/bitbake-layers | 68 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 58 insertions(+), 10 deletions(-)

-- 
1.9.1


