Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f48.google.com (mail-pa0-f48.google.com
	[209.85.220.48])
	by mail.openembedded.org (Postfix) with ESMTP id 1E92965C8A
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Oct 2015 20:27:06 +0000 (UTC)
Received: by pabur7 with SMTP id ur7so14705879pab.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Oct 2015 13:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=ObxcaYFiuunaFOxHZemw9wZOfXwDRCm+JQbEJBRPf5E=;
	b=qzQpP0lJAHrUFanbmAijwuiCZQAV+zn4bguodZYrHaM2S79BlJrlChmLMmaxcnCyUE
	2/lnTBEVYu9dQC518MluISF1zr3X371zM4ezmpBFwFerq6LzZTMVMEb55lkieXjKlUm1
	KDvtYeBEj+l1rFnDpr89qzZh6cNMjRaWAzHIQbb5/J0wjcImnsnbXIe8oKtcYPDhUmRP
	+ZMeqZ7MjWZm5DtLjOdWO5ILVBg3M8u4WN44GYletogkrSOxkOCI1b1Eztxyk0pv54t4
	ETnHJyuJ0thn3sfzfYPu4+ZCMvxm84eapsWM5PBSQMbXKtpvdNIW9S29czuu/KY3QuUK
	p5NQ==
X-Received: by 10.68.69.17 with SMTP id a17mr5618780pbu.10.1444854426561;
	Wed, 14 Oct 2015 13:27:06 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	fa14sm11307714pac.8.2015.10.14.13.27.05
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 14 Oct 2015 13:27:06 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Oct 2015 13:29:10 -0700
Message-Id: <cover.1444854417.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH 00/10] toaster:Implement UI changesfor command line builds project
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
X-List-Received-Date: Wed, 14 Oct 2015 20:27:08 -0000

This implements changes across the UI to hide irrelevant options
for command-line builds, and show additional help icons explaining
why those options are hidden.

It also modifies the behaviour of the "New build" button to take
account of the special status of the command-line builds project.

For UI details, see the document attached to bug 8231
at https://bugzilla.yoctoproject.org/attachment.cgi?id=2760.

-bavery

The following changes since commit 4d49aae0ca64d3d42295484ba1d80b6442c1ade6:

  toaster: Test that exception isn't thrown by project page (2015-10-14 14:45:29 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib bavery/submit/elliot/2015-10-14_cli-builds-ui-8231
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=bavery/submit/elliot/2015-10-14_cli-builds-ui-8231

Elliot Smith (10):
  toaster: Reorganise and lint tests
  toaster: Replace "Run again" button with help text for cli builds
  toaster: Show 'not applicable' for default project machine and release
  toaster: Make the builds view the project page for "command line
    builds"
  toaster: Hide tabs and add info popups for command line builds
  toaster: Show tooltip next to cli builds project name in all builds
  toaster: More linting of tests
  toaster: Clean up template code
  toaster: Exclude "command line builds" project from projects typeahead
  toaster: Modify "New build" button behaviour for cli builds project

 lib/toaster/toastergui/static/css/default.css      |   5 +
 lib/toaster/toastergui/static/js/base.js           |  18 +-
 lib/toaster/toastergui/templates/base.html         |  98 ++++---
 lib/toaster/toastergui/templates/builds.html       |  19 +-
 lib/toaster/toastergui/templates/mrb_section.html  |  66 +++--
 lib/toaster/toastergui/templates/projects.html     |  23 +-
 .../toastergui/templates/projecttopbar.html        |  80 ++---
 .../toastergui/templatetags/project_url_tag.py     |  34 +++
 lib/toaster/toastergui/tests.py                    | 322 ++++++++++++++++++---
 lib/toaster/toastergui/typeaheads.py               |   4 +-
 lib/toaster/toastergui/views.py                    |   9 +-
 11 files changed, 494 insertions(+), 184 deletions(-)
 create mode 100644 bitbake/lib/toaster/toastergui/templatetags/project_url_tag.py

--
1.9.1

