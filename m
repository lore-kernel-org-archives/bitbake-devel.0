Return-Path: <david.reyna@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 7122871B99
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  1 Oct 2018 07:49:00 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w917n1HQ023379
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 1 Oct 2018 00:49:01 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.217) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Mon, 1 Oct 2018 00:49:00 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 1 Oct 2018 00:45:49 -0700
Message-ID: <cover.1538379577.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-Originating-IP: [147.11.157.217]
Subject: [PATCH 0/3] toaster: cummulative 092918 patch
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
X-List-Received-Date: Mon, 01 Oct 2018 07:49:00 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

Cummulative patches for Toaster:
* 12943: Enable YP-2.6 "Thud", remove "Rocko"
* 12813: Allow captures of error/warning message for command line builds
* 12944: Disable git remote check to allow for firewalls
  (Disable this nice-to-have check to allow for firewalls this release, enhance later)


The following changes since commit 3bbbe25ae74e120f7d3452685f0cae2245d7b14d:

  glibc-package.inc: correct intention for deleting /usr/lib as needed (2018-09-27 23:41:41 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib dreyna/submit/dreyna/toaster/toaster_cummulative_092918
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=dreyna/submit/dreyna/toaster/toaster_cummulative_092918

David Reyna (3):
  toaster: error logs missing for cli builds
  toaster: add 'thud' release to Toaster
  toaster: disable git remote check to allow for firewalls

 lib/bb/ui/buildinfohelper.py                    |  9 +++++----
 lib/toaster/bldcontrol/localhostbecontroller.py |  7 +++++--
 lib/toaster/orm/fixtures/oe-core.xml            | 12 ++++++------
 lib/toaster/orm/fixtures/poky.xml               | 10 +++++-----
 4 files changed, 21 insertions(+), 17 deletions(-)

-- 
1.9.1


