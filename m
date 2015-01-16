Return-Path: <Chong.Lu@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id F180572BCE
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Jan 2015 09:38:15 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail.windriver.com (8.14.9/8.14.5) with ESMTP id t0G9cE8f010116
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Jan 2015 01:38:15 -0800 (PST)
Received: from pek-hostel-deb02.wrs.com (128.224.153.152) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
	14.3.174.1; Fri, 16 Jan 2015 01:38:14 -0800
From: Chong Lu <Chong.Lu@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 16 Jan 2015 17:33:56 +0800
Message-ID: <1421400837-10632-1-git-send-email-Chong.Lu@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Subject: [RFC][PATCH 0/1] bitbake: cooker: wait seconds to unlock bitbake.lock
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
X-List-Received-Date: Fri, 16 Jan 2015 09:38:24 -0000
Content-Type: text/plain

I get errors when using prserver on ubuntu 12.04:

$ bitbake-prserv-tool export export.inc
ERROR: Only one copy of bitbake should be run against a build directory

$ bitbake-prserv-tool import export.inc 
ERROR: Only one copy of bitbake should be run against a build directory
Importing from file export.inc failed!

Try to add seconds between two bitbake commands.

The following changes since commit 4e20211090d2b193250edaa64f84e355a1c31fe5:

  bitbake: toasterui: fix variable data error (2015-01-16 08:25:31 +0000)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib chonglu/unlock
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=chonglu/unlock

Chong Lu (1):
  bitbake: cooker: wait seconds to unlock bitbake.lock

 bitbake/lib/bb/cooker.py | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
1.9.1


