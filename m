Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id C7CF678094
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Feb 2018 08:01:14 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w1781FGW026857
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 7 Feb 2018 00:01:15 -0800 (PST)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.361.1; Wed, 7 Feb 2018 00:01:09 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 7 Feb 2018 16:01:58 +0800
Message-ID: <cover.1517990305.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Subject: [PATCH 0/1] contrib/dump_cache.py: make it can dump everything
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
X-List-Received-Date: Wed, 07 Feb 2018 08:01:15 -0000
Content-Type: text/plain

Hi RP,

I'd like to move this script to oe-core/scripts, and remove it to dump_cache.py
or bb-dump-cache.py if no objections, the benefit is that oe-core/scripts is in
$PATH after run oe-init-build-env, which makes it easy to run.

// Robert

The following changes since commit 44ea6ded0e8e73f5258ce55bd1b851e24243b76a:

  bitbake: bitbake-user-manual: Commented out Placeholder Paragraph (2018-02-06 18:10:35 +0000)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib rbt/dump
  http://git.pokylinux.org/cgit.cgi//log/?h=rbt/dump

Robert Yang (1):
  contrib/dump_cache.py: make it can dump everything

 bitbake/contrib/dump_cache.py | 85 ++++++++++++++++++++++++++-----------------
 1 file changed, 51 insertions(+), 34 deletions(-)

-- 
2.7.4


