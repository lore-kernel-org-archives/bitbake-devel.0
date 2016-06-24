Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 8C891731C4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Jun 2016 07:55:50 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id u5O7toOB010122
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Jun 2016 00:55:50 -0700
Received: from ala-blade47.wrs.com (147.11.105.67) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.248.2;
	Fri, 24 Jun 2016 00:55:50 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 24 Jun 2016 00:55:48 -0700
Message-ID: <cover.1466754896.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.8.2
MIME-Version: 1.0
Subject: [PATCH 0/1] fetch2: remove "." in the end
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
X-List-Received-Date: Fri, 24 Jun 2016 07:55:54 -0000
Content-Type: text/plain

The following changes since commit c6d50b272936b61b98a056ea2e1de5d0f4ef53ce:

  bitbake: lib/bb/build.py: remove task flag in deltask() (2016-06-23 14:26:33 +0100)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib rbt/dot
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=rbt/dot

Jason Wessel (1):
  fetch2: remove "." in the end

 bitbake/lib/bb/fetch2/__init__.py | 2 ++
 bitbake/lib/bb/fetch2/git.py      | 2 ++
 2 files changed, 4 insertions(+)

-- 
2.8.2


