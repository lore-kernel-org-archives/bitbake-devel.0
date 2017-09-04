Return-Path: <david.reyna@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id EF83B60290
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  4 Sep 2017 04:10:31 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id v844AWex008152
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 3 Sep 2017 21:10:32 -0700
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.78) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.361.1; Sun, 3 Sep 2017 21:10:30 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sun, 3 Sep 2017 21:02:14 -0700
Message-ID: <cover.1504496902.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-Originating-IP: [147.11.157.78]
Subject: [PATCH 0/3] toaster: cummulative 03092017 patch
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
X-List-Received-Date: Mon, 04 Sep 2017 04:10:32 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

The patch "toaster: missing ToasterSetting import" is High priority and
restores Toaster start up.

There are no new files.

The following changes since commit ee5bce2d11e783c0921df47b629025a6b67c44bf:

  kernel-dev: Removed bad reference for creating patches. (2017-09-02 00:52:49 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib dreyna/submit/dreyna/toaster/cummulative_020917_patch
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=dreyna/submit/dreyna/toaster/cummulative_020917_patch

David Reyna (3):
  toaster: missing ToasterSetting import
  toaster: recipe links broken for default layers
  toaster: edit column list not sorted

 lib/toaster/orm/fixtures/oe-core.xml             |  3 +++
 lib/toaster/orm/fixtures/poky.xml                |  9 +++++++++
 lib/toaster/orm/management/commands/lsupdates.py |  3 +++
 lib/toaster/toastergui/static/js/table.js        | 11 ++++++++++-
 4 files changed, 25 insertions(+), 1 deletion(-)

-- 
1.9.1


