Return-Path: <david.reyna@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 77E056003C
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Sep 2017 00:06:20 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id v8F06LgM029885
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Sep 2017 17:06:21 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.78) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.361.1; Thu, 14 Sep 2017 17:06:20 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 14 Sep 2017 16:58:07 -0700
Message-ID: <cover.1505433280.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-Originating-IP: [147.11.157.78]
Subject: [PATCH 0/2] toaster: cummulative 14092017 patch
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
X-List-Received-Date: Fri, 15 Sep 2017 00:06:20 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>


This patch set fixes larger and small issues with importing layers into Toaster. There are no new files.


The following changes since commit abea8ec5063998e0e2b822be7704c0d14569df0e:

  meta-yocto: Restructure and tidy up READMEs (2017-09-14 13:36:22 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib dreyna/submit/dreyna/toaster/cummulative_140917_patch
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=dreyna/submit/dreyna/toaster/cummulative_140917_patch

David Reyna (2):
  toaster: reserve HEAD from imported layers
  toaster: allow dots in user path names

 lib/toaster/toastergui/api.py                     |  6 +++---
 lib/toaster/toastergui/static/js/importlayer.js   | 19 +++++++++++++++----
 lib/toaster/toastergui/templates/importlayer.html |  4 ++--
 lib/toaster/toastergui/templates/projectconf.html |  8 ++++----
 4 files changed, 24 insertions(+), 13 deletions(-)

-- 
1.9.1


