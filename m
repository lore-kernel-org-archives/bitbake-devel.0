Return-Path: <david.reyna@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id B0AE378E88
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Oct 2018 07:17:18 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w9F7HJ42015992
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Oct 2018 00:17:20 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.217) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Mon, 15 Oct 2018 00:17:19 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 15 Oct 2018 00:14:10 -0700
Message-ID: <cover.1539558338.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-Originating-IP: [147.11.157.217]
Subject: [PATCH 0/3] toaster: cummulative 101418 patch
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
X-List-Received-Date: Mon, 15 Oct 2018 07:17:18 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

These are three errors found that affect the 2.6 release for Toaster:
  * Bug 12959 - toaster: missing shutil import
    This causes a page failure when importing projects
  * Bug 12958 - toaster: bump django version to match build tools
    The avoids a toaster setup error with the 2.6 version of django
  * Bug 12957 - bad link for distro conf file
    The links to the distro conf file are broken and therefore blank
  * The simplicity of the patches should reflect their safety 



The following changes since commit b02f3bfe2fee291a9db85094e5f31b1933acf871:

  local.conf.sample.extended: add another warning to comment about GLIBC_GENERATE_LOCALES (2018-10-14 23:45:40 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib dreyna/submit/dreyna/toaster/toaster_cummulative_101418
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=dreyna/submit/dreyna/toaster/toaster_cummulative_101418

David Reyna (3):
  toaster: bad link for distro conf file
  toaster: bump django version to match build tools
  toaster: missing shutil import

 lib/toaster/orm/models.py                                  | 2 +-
 lib/toaster/toastergui/tables.py                           | 8 +++-----
 lib/toaster/toastermain/management/commands/buildimport.py | 1 +
 toaster-requirements.txt                                   | 2 +-
 4 files changed, 6 insertions(+), 7 deletions(-)

-- 
1.9.1


