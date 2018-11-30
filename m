Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 1BD046D756
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 30 Nov 2018 03:22:22 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id wAU3M3W1004275
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 29 Nov 2018 19:22:14 -0800
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.408.0; Thu, 29 Nov 2018 19:21:53 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 30 Nov 2018 11:39:17 +0800
Message-ID: <cover.1543548740.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Subject: [PATCH 0/1] cooker: simplify BB_DANGLINGAPPENDS_WARNONLY
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
X-List-Received-Date: Fri, 30 Nov 2018 03:22:23 -0000
Content-Type: text/plain

Hi RP,

I'd like to change the fatal message to be an event, the benefits are:
- Things like report-error.bbclass can catch the error
- It's easier to get bbappends list from an event message than from console log.

What's your opinion, please ?

// Robert

The following changes since commit 41d89552620bfbc94031d314e6b3d0324f7a330e:

  bitbake: fetch2: Avoid warning about incorrect character escaping in regex (2018-11-27 22:15:34 +0000)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib rbt/append
  http://git.pokylinux.org/cgit.cgi//log/?h=rbt/append

Robert Yang (1):
  cooker: simplify BB_DANGLINGAPPENDS_WARNONLY

 bitbake/lib/bb/cooker.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

-- 
2.7.4


