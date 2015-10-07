Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 071F860125
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Oct 2015 12:17:39 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga102.fm.intel.com with ESMTP; 07 Oct 2015 05:17:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,648,1437462000"; d="scan'208";a="786606010"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga001.jf.intel.com with ESMTP; 07 Oct 2015 05:17:37 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id D0E976A4083;
	Wed,  7 Oct 2015 05:16:38 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  7 Oct 2015 15:17:31 +0300
Message-Id: <cover.1444219934.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH 0/5] toaster: remove startup questions
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
X-List-Received-Date: Wed, 07 Oct 2015 12:17:40 -0000

This removes the startup questions from toaster and uses the following dir structure.

cwd/toaster.sqlite
cwd/_toaster_clones
cwd/build

You can override TOASTER_CONF to point at the toasterconf.json in meta.

There are still a fair number of directory assumptions that need to be worked out
for 2.1 but this should let us start up easier and automate tests better.

Since we are putting the builddir here, we should really allow users to set
the SSTATE_DIR and DL_DIR variables. I will try to add that as part of the
change needed for 7880 since it has to set a number of new variables.

The following changes since commit 2bd6d137555b44c374853068767e7f4c736898d1:

  toaster: Hide "Download build log" button if log doesn't exist (2015-10-07 13:02:07 +0300)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib ed/submit/bavery/toaster/startup_simplification_8217_v3
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=ed/submit/bavery/toaster/startup_simplification_8217_v3

brian avery (5):
  toaster: removed superuser question from startup
  toaster: remove layer and build dir interactive questions
  toaster: check for configuration file and exit if not found
  toaster: get rid of interactivity in bldcontrol
  toaster: remove bashisms so script works in dash as well

 bin/toaster                                        |  39 ++++--
 .../management/commands/checksettings.py           | 138 ++++++---------------
 2 files changed, 69 insertions(+), 108 deletions(-)

--
Ed

