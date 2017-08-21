Return-Path: <david.reyna@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 67F8B78252
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Aug 2017 04:11:06 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id v7L4B89M003185
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 20 Aug 2017 21:11:08 -0700
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.78) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.361.1; Sun, 20 Aug 2017 21:11:07 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sun, 20 Aug 2017 21:02:45 -0700
Message-ID: <cover.1503287968.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-Originating-IP: [147.11.157.78]
Subject: [PATCH 0/1] toaster: support custom Layer Index URL and fixture override
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
X-List-Received-Date: Mon, 21 Aug 2017 04:11:07 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>


These two simple changes help enable users and commercial partners to attach their 
custom layer index servers to Toaster, plus more control over the custom content 
for Toaster projects.


The following changes since commit 04dc76713b57f28457742dd863caa663591d4866:

  devtool/copy_buildsystem: adds meta-skeleton layer in the eSDK installation. (2017-08-19 22:15:39 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib dreyna/submit/dreyna/toaster/custom_layer_index_11957
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=dreyna/submit/dreyna/toaster/custom_layer_index_11957

David Reyna (1):
  toaster: support custom Layer Index URL and fixture override

 lib/toaster/bldcontrol/management/commands/checksettings.py | 5 ++++-
 lib/toaster/orm/management/commands/lsupdates.py            | 6 +++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

-- 
1.9.1


