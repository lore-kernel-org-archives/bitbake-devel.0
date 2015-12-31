Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 3A6E36FFCD
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 31 Dec 2015 18:38:46 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga102.jf.intel.com with ESMTP; 31 Dec 2015 10:38:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,504,1444719600"; d="scan'208";a="718240016"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga003.jf.intel.com with ESMTP; 31 Dec 2015 10:38:47 -0800
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 097C96A4087;
	Thu, 31 Dec 2015 11:26:45 -0800 (PST)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 31 Dec 2015 18:42:12 +0200
Message-Id: <1451580136-29714-1-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH 0/4] Improve error reporting for registerEventHandler
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
X-List-Received-Date: Thu, 31 Dec 2015 18:38:47 -0000

Hi,

This patchset includes refactoring changes for the code that deals
with registering UI event handlers. It improves error reporting
and cleans up the code a bit.

Ed Bartosh (4):
  cooker: add state.get_name method
  uievent: add error to registerEventHandler return
  uievent: get rid of EventHandler attribute
  uievent: refactor retry loop

 bitbake/lib/bb/cooker.py        |  8 ++++++++
 bitbake/lib/bb/server/xmlrpc.py |  4 ++--
 bitbake/lib/bb/ui/uievent.py    | 22 +++++++++++-----------
 3 files changed, 21 insertions(+), 13 deletions(-)

--
Regards,
Ed


