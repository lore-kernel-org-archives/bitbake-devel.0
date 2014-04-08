Return-Path: <peter.kjellerstedt@axis.com>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id D9FB365DC0
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Apr 2014 14:09:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id CBEAD2E408
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Apr 2014 16:09:42 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id 4YDSQDLK8441 for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Apr 2014 16:09:39 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bes.se.axis.com (Postfix) with ESMTP id 847122E383
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Apr 2014 16:09:39 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 6356ACDF
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Apr 2014 16:09:39 +0200 (CEST)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id 5843E68E
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Apr 2014 16:09:39 +0200 (CEST)
Received: from saur-2.se.axis.com (saur-2.se.axis.com [10.92.3.2])
	by thoth.se.axis.com (Postfix) with ESMTP id 4CCAC34005
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Apr 2014 16:09:39 +0200 (CEST)
Received: from saur-2.se.axis.com (localhost [127.0.0.1])
	by saur-2.se.axis.com (8.14.5/8.14.5) with ESMTP id s38E9dlH003256
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 8 Apr 2014 16:09:39 +0200
Received: (from pkj@localhost)
	by saur-2.se.axis.com (8.14.5/8.14.5/Submit) id s38E9dsx003252
	for bitbake-devel@lists.openembedded.org; Tue, 8 Apr 2014 16:09:39 +0200
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  8 Apr 2014 16:09:33 +0200
Message-Id: <cover.1396966113.git.pkj@axis.com>
X-Mailer: git-send-email 1.9.0
Subject: [PATCH 0/1] Clear Knotty footer before outputting to stderr
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
X-List-Received-Date: Tue, 08 Apr 2014 14:09:45 -0000

This fixes a problem with Knotty when errors are output to stderr
while the footer of currently active tasks is displayed.

//Peter

The following changes since commit 68a55c8ff779d8df90626e68d5d4e48660dd8027:

  ref-manual: Edits to fix up how GID and UIDs are handled. (2014-04-08 14:20:16 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib pkj/knotty_stderr
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=pkj/knotty_stderr

Peter Kjellerstedt (1):
  bitbake: knotty: Clear footer before outputting to stderr

 bitbake/lib/bb/ui/knotty.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
1.9.0


