Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 9ED20796DA
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Sep 2018 08:27:17 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w8C8RIIf007828
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Sep 2018 01:27:18 -0700 (PDT)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.408.0; Wed, 12 Sep 2018 01:27:18 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 12 Sep 2018 16:38:15 +0800
Message-ID: <cover.1536741423.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Subject: [PATCH 0/1] dump_cache.py: move it to oe-core/scripts
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
X-List-Received-Date: Wed, 12 Sep 2018 08:27:17 -0000
Content-Type: text/plain

The following changes since commit ae130de4ba287730d5f843019ecf8b8383b3741e:

  yasm: remove (2018-09-11 12:09:10 +0100)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib rbt/dump
  http://git.pokylinux.org/cgit.cgi//log/?h=rbt/dump

Robert Yang (1):
  dump_cache.py: move it to oe-core/scripts

 bitbake/contrib/dump_cache.py | 85 -------------------------------------------
 1 file changed, 85 deletions(-)
 delete mode 100755 bitbake/contrib/dump_cache.py

-- 
2.7.4


