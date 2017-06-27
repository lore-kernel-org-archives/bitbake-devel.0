Return-Path: <david.reyna@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id BAD2277F79
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Jun 2017 20:53:02 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id v5RKr2S8003129
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Jun 2017 13:53:03 -0700
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.209) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.294.0; Tue, 27 Jun 2017 13:53:02 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 27 Jun 2017 13:44:22 -0700
Message-ID: <cover.1498595646.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-Originating-IP: [147.11.157.209]
Subject: [PATCH 0/5] toaster: cummulative 26062017 patch
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
X-List-Received-Date: Tue, 27 Jun 2017 20:53:05 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

*** NOTE for MERGE: New Files: ***
 create mode 100644 bitbake/lib/toaster/orm/migrations/0016_clone_progress.py
 create mode 100644 bitbake/lib/toaster/orm/migrations/0017_distro_clone.py
 create mode 100644 bitbake/lib/toaster/toastergui/templates/distro_btn.html

I have been advised that: "If the patch creates any NEW files, the integration 
scripts that pull it into bitbake will fail. So, if new files are created as 
part of this patch set, you need to explicitly point that out in the body of 
the email for the patch set"

- David

=================

The following changes since commit b8358bc61435ec996ecd6931fb6d6d41bb4f710b:

  bitbake: bitbake-selftest: add bb.tests.event to bitbake-selftest (2017-06-23 14:14:17 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib dreyna/submit/dreyna/toaster/cummulative_062017_patch
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=dreyna/submit/dreyna/toaster/cummulative_062017_patch

David Reyna (5):
  toaster: address Django-1.10 API deprecations
  toaster: git clone progress bar
  toaster: Add distro selection support
  toaster: large package set breaks sqlite query
  toaster: test 'commit' first in get_vcs_reference

 bin/toaster                                        | 10 ++-
 lib/toaster/bldcollector/urls.py                   | 10 ++-
 lib/toaster/bldcontrol/localhostbecontroller.py    | 12 +++
 .../management/commands/checksettings.py           |  6 +-
 .../bldcontrol/management/commands/runbuilds.py    |  6 +-
 lib/toaster/orm/management/commands/lsupdates.py   | 27 ++++++-
 lib/toaster/orm/migrations/0016_clone_progress.py  | 24 ++++++
 lib/toaster/orm/migrations/0017_distro_clone.py    | 25 ++++++
 lib/toaster/orm/models.py                          | 50 +++++++++++-
 lib/toaster/toastergui/api.py                      | 13 +++-
 lib/toaster/toastergui/static/js/mrbsection.js     | 15 ++++
 lib/toaster/toastergui/static/js/projectpage.js    | 73 +++++++++++++++++
 lib/toaster/toastergui/tables.py                   | 91 ++++++++++++++++++++++
 lib/toaster/toastergui/templates/base.html         |  1 +
 .../toastergui/templates/baseprojectpage.html      |  1 +
 lib/toaster/toastergui/templates/distro_btn.html   | 20 +++++
 lib/toaster/toastergui/templates/mrb_section.html  | 29 ++++++-
 lib/toaster/toastergui/templates/project.html      | 16 ++++
 lib/toaster/toastergui/typeaheads.py               | 30 +++++++
 lib/toaster/toastergui/urls.py                     | 69 +++++++++-------
 lib/toaster/toastergui/views.py                    | 13 +++-
 lib/toaster/toastergui/widgets.py                  |  4 +
 .../toastermain/management/commands/buildslist.py  |  6 +-
 lib/toaster/toastermain/settings.py                | 70 ++++++++++-------
 lib/toaster/toastermain/urls.py                    |  8 +-
 toaster-requirements.txt                           |  2 +-
 26 files changed, 539 insertions(+), 92 deletions(-)
 create mode 100644 bitbake/lib/toaster/orm/migrations/0016_clone_progress.py
 create mode 100644 bitbake/lib/toaster/orm/migrations/0017_distro_clone.py
 create mode 100644 bitbake/lib/toaster/toastergui/templates/distro_btn.html

-- 
1.9.1


