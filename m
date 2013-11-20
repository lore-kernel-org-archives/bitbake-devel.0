Return-Path: <seebs@msp-lpggp2.wrs.com>
Received: from msp-lpggp2.wrs.com (unknown [206.144.70.9])
	by mail.openembedded.org (Postfix) with ESMTP id 8EE5B60F50
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Nov 2013 00:30:18 +0000 (UTC)
Received: by msp-lpggp2.wrs.com (Postfix, from userid 508)
	id 48F6DA02E72; Tue, 19 Nov 2013 18:31:40 -0600 (CST)
From: Peter Seebach <peter.seebach@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 19 Nov 2013 18:31:38 -0600
Message-Id: <cover.1384907121.git.peter.seebach@windriver.com>
X-Mailer: git-send-email 1.7.1
Subject: [PATCH 0/2] improve recovery when something goes horribly wrong
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
X-List-Received-Date: Wed, 20 Nov 2013 00:30:18 -0000

Certain early failures can result in things going wrong in ways that
prevent "bitbake -e" from running, creating strange or cryptic failures,
and even when they're not all that cryptic, lack of include tracking
or variable history tracking can be a significant disadvantage.

These patches address one of the failure modes, and make it possible for
an oe-core change to address another.

The first patch makes run.* scripts work even when the path name generated
contains unexpanded variable names, by quoting the argument to cd. The
second provides an isTracking() to DataSmart to allow the sanity checks
to be normal errors rather than fatal errors when trying to run with
tracking enabled (which only occurs when you want to dump the results of
the tracking).

The following changes since commit a66ee0994645aa5658b2f5ea134ed17d89f8751a:

  fetch2: Fix handling of SCM mirrors in MIRRORS (2013-11-19 13:22:10 +0000)

are available in the git repository at:
  git://git.yoctoproject.org/poky-contrib seebs/warning_helper
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=seebs/warning_helper

Peter Seebach (2):
  build.py: add single-quotes around already-expanded directory name
  data_smart.py: Add isTracking() to datasmart

 lib/bb/build.py      |    2 +-
 lib/bb/data_smart.py |    3 +++
 2 files changed, 4 insertions(+), 1 deletions(-)


