Return-Path: <david.reyna@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id BB06E79973
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 30 Sep 2018 07:34:36 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id w8U7Y6f6014351
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Sun, 30 Sep 2018 00:34:16 -0700
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.217) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Sun, 30 Sep 2018 00:33:43 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sun, 30 Sep 2018 00:30:31 -0700
Message-ID: <cover.1538292172.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-Originating-IP: [147.11.157.217]
Subject: [PATCH 0/1] [SUMO] toaster: fix bitbake flexible path error from Bugzilla #12891
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
X-List-Received-Date: Sun, 30 Sep 2018 07:34:36 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

Summary:
In the previous patch that implemented flexable bitbake paths, a old definition
of the bitbake path was left in the code, undoing the functionality. This patch
addresses that error.

The following changes since commit 3b8dc3a88e28546100a6b0b2f2cc37f44e619371:

  glibc: fix CVE-2018-11237 (2018-09-27 12:17:46 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib dreyna/toaster/fix_bitbake_path_12942
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=dreyna/toaster/fix_bitbake_path_12942

Awais Belal (1):
  toaster: [Sumo] fix bitbake flexible path error from Bugzilla #12891

 lib/toaster/bldcontrol/localhostbecontroller.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
1.9.1


