Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id 04F5560110
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jun 2016 11:01:00 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga104.fm.intel.com with ESMTP; 20 Jun 2016 04:01:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,498,1459839600"; d="scan'208";a="722189062"
Received: from linux.intel.com ([10.54.29.200])
	by FMSMGA003.fm.intel.com with ESMTP; 20 Jun 2016 04:01:00 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.68])
	by linux.intel.com (Postfix) with ESMTP id 893E16A4080
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jun 2016 04:00:58 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 20 Jun 2016 14:00:47 +0300
Message-Id: <cover.1466419987.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH 0/5] Fix writing events to file
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
X-List-Received-Date: Mon, 20 Jun 2016 11:01:01 -0000

Hi,

This patchset fixes "object is not JSON serializable" error caused by attempt
to convert binary pickled event object to JSON when bitbake is called with
-w command line option.

It also fixes error caused writing the same event to the file multiple times and
refactoring of event writing functionality.

The following changes since commit 09d08340fe0fca6f551c33d2fdcafb72f52812d2:

  Revert "cmake.bbclass: set the modules directory correctly" (2016-06-20 08:40:21 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib ed/bitbake/cooker-event-pickling-9803
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=ed/bitbake/cooker-event-pickling-9803

Ed Bartosh (5):
  cooker: move EventLogWriteHandler to the top module level
  cooker: encode event objects to base64
  cooker: don't remove event file
  cooker: replace EventLogWriteHandler with namedtuple
  cooker: clean up EvertWriter

 bitbake/lib/bb/cooker.py | 114 +++++++++++++++++++++--------------------------
 1 file changed, 51 insertions(+), 63 deletions(-)

--
Regards,
Ed

