Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id EFC3060112
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  5 Jan 2016 15:42:12 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga103.fm.intel.com with ESMTP; 05 Jan 2016 07:42:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,525,1444719600"; d="scan'208";a="884211654"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga002.jf.intel.com with ESMTP; 05 Jan 2016 07:42:13 -0800
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 741386A4004;
	Tue,  5 Jan 2016 08:30:10 -0800 (PST)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  5 Jan 2016 15:45:36 +0200
Message-Id: <1452001538-25251-1-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <CAJTo0LaxgVGcwkTL-3mzHeCtU+s42oMVwtm7Sbcb1YqErx2p=w@mail.gmail.com>
References: <CAJTo0LaxgVGcwkTL-3mzHeCtU+s42oMVwtm7Sbcb1YqErx2p=w@mail.gmail.com>
Subject: [PATCH v2 0/2] improved killing bitbake server
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
X-List-Received-Date: Tue, 05 Jan 2016 15:42:13 -0000

Hi,

Setup of event queue includes registering of UI handler.
This operation can fail when cooker is busy. However, there is
no need in registering UI handler for terminating the server.

This patchset makes server terminating to work without setting up
the event queue and registering UI handler. This should make
terminating server to work more reliably.

This should also help Toaster backend to restart bitbake server
and observer without getting "Could not register UI event handler"
errors.

Changes in v2: Fixed AttributeError: BitBakeProcessServerConnection instance has no attribute 'setupEventQueue'

Ed Bartosh (2):
  bitbake: xmplrpc: split connect method
  bitbake: main: kill server without queue setup

 bitbake/lib/bb/main.py            | 12 +++++++-----
 bitbake/lib/bb/server/__init__.py |  3 +++
 bitbake/lib/bb/server/xmlrpc.py   |  4 ++--
 3 files changed, 12 insertions(+), 7 deletions(-)

--
Regards,
Ed


