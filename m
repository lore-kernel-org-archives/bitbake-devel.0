Return-Path: <david.reyna@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 22C4478434
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Nov 2017 22:31:15 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id vAKMVG12025386
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Nov 2017 14:31:16 -0800
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.78) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server
	(TLS) id 14.3.361.1; Mon, 20 Nov 2017 14:31:16 -0800
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 20 Nov 2017 14:23:28 -0800
Message-ID: <cover.1511216528.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-Originating-IP: [147.11.157.78]
Subject: [PATCH 0/6] toaster: cummulative 11202017 patch
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
X-List-Received-Date: Mon, 20 Nov 2017 22:31:16 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

1) This patch is intended for both YP-2.4.1 and master. If I need to submit this differently, 
please let me know.

2) This patch contains the following:
    * 12363: this is a Medium+ defect to fix broken master Toaster builds to Rocko projects
    * 12316,12315: these resolve issues from the ELCE-Prague BoF meeting
    * 12192,12204,12193: these resolve forward going issues

3) There are no new files

The following changes since commit 4ed19ac8c19afd56d445d84e02b622cb056b8359:

  poky: Switch to post release name/version (2017-11-14 17:26:58 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib dreyna/submit/dreyna/toaster/cummulative_112017_patch
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=dreyna/submit/dreyna/toaster/cummulative_112017_patch

David Reyna (6):
  toaster: unset BBPATH before starting bbserver for backwards
    compatibility
  toaster: update Toaster for Django 1.11
  toaster: some recipe events do not include packages
  toaster: enable custom env support for shell calls
  toaster: landing page show cmdline capture
  toaster: add 'nobuild' option to Toaster

 bin/toaster                                     | 19 +++++---
 lib/bb/ui/buildinfohelper.py                    |  6 ++-
 lib/toaster/bldcollector/urls.py                |  2 +-
 lib/toaster/bldcontrol/localhostbecontroller.py | 44 +++++++++++-------
 lib/toaster/toastergui/templates/base.html      |  4 ++
 lib/toaster/toastergui/templates/landing.html   | 10 ++++-
 lib/toaster/toastergui/urls.py                  |  2 +-
 lib/toaster/toastergui/views.py                 | 59 +++++++++++++++----------
 lib/toaster/toastergui/widgets.py               |  4 ++
 lib/toaster/toastermain/settings.py             |  2 +-
 lib/toaster/toastermain/urls.py                 |  2 +-
 toaster-requirements.txt                        |  2 +-
 12 files changed, 103 insertions(+), 53 deletions(-)

-- 
1.9.1


