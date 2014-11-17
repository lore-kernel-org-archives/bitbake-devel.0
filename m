Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 99D00714D7
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Nov 2014 13:07:18 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.9/8.14.5) with ESMTP id sAHD7Hl0029506
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Nov 2014 05:07:17 -0800 (PST)
Received: from ala-blade47.wrs.com (147.11.105.67) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.174.1;
	Mon, 17 Nov 2014 05:07:16 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 17 Nov 2014 05:07:15 -0800
Message-ID: <cover.1416229526.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Subject: [PATCH 0/1] bitbake-worker: exit normally when SIGHUP
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
X-List-Received-Date: Mon, 17 Nov 2014 13:07:21 -0000
Content-Type: text/plain

The following changes since commit edaeb8940813b620090a0797ad3b6a076897512d:

  bitbake: cooker.py: fix loginfo op being set to an invalid value (2014-11-12 17:04:50 +0000)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib rbt/sighup
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=rbt/sighup

Robert Yang (1):
  bitbake-worker: exit normally when SIGHUP

 bitbake/bin/bitbake-worker |    9 ++++++++-
 bitbake/lib/bb/cooker.py   |    7 ++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

-- 
1.7.9.5


