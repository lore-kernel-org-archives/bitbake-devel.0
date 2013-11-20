Return-Path: <seebs@msp-lpggp2.wrs.com>
Received: from msp-lpggp2.wrs.com (unknown [206.144.70.9])
	by mail.openembedded.org (Postfix) with ESMTP id EF9046DA12
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Nov 2013 23:25:00 +0000 (UTC)
Received: by msp-lpggp2.wrs.com (Postfix, from userid 508)
	id 53953A02EC0; Wed, 20 Nov 2013 17:26:23 -0600 (CST)
From: Peter Seebach <peter.seebach@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 20 Nov 2013 17:26:22 -0600
Message-Id: <cover.1384989450.git.peter.seebach@windriver.com>
X-Mailer: git-send-email 1.7.1
Subject: [PATCH 0/1] v2: cooker.py and friends, switch to SanityCheck events
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
X-List-Received-Date: Wed, 20 Nov 2013 23:25:02 -0000

This is probably a little off, but it's maybe worth a try. This
patch updates the mechanism used for sanity check events. It will
result in sanity checks being run twice, probably, without a
corresponding oe-core change, but shouldn't be otherwise harmful.
The intent is to get away from the idea that sanity checks are an
unintended and barely-documented side-effect of ConfigParsed, and
to introduce the idea that bitbake might have insights into whether
it wants sanity checks to be fatal.

The use-events stuff is related to how oe-core was doing this; it
assumed that it should use bb.event.SanityChecksFailed() instead of
printing a message if it got a SanityCheck event, and I'd rather not
change the behavior that much right now.

The following changes since commit 67b752993a2c64cba9ccc4fa662f0bddf081e74a:

  toasterui: fix typo (2013-11-20 14:06:42 +0000)

are available in the git repository at:
  git://git.yoctoproject.org/poky-contrib seebs/insanity_continued
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=seebs/insanity-continued

Peter Seebach (1):
  cooker.py and friends: Convert to using Sanity Check events.

 lib/bb/cooker.py     |    2 ++
 lib/bb/cookerdata.py |   10 ++++++++++
 lib/bb/event.py      |    4 ++++
 lib/bb/ui/knotty.py  |    1 +
 4 files changed, 17 insertions(+), 0 deletions(-)


