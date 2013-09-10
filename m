Return-Path: <denis@denix.org>
Received: from vms173003pub.verizon.net (vms173003pub.verizon.net
	[206.46.173.3])
	by mail.openembedded.org (Postfix) with ESMTP id CAB77616F5
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Sep 2013 16:34:05 +0000 (UTC)
Received: from gandalf.denix.org ([unknown] [108.45.150.102])
	by vms173003.mailsrvcs.net
	(Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16
	2009)) with ESMTPA id <0MSX00G7S4NSUSV0@vms173003.mailsrvcs.net> for
	bitbake-devel@lists.openembedded.org;
	Tue, 10 Sep 2013 11:33:44 -0500 (CDT)
Received: from elrond.denix (elrond [192.168.0.7])
	by gandalf.denix.org (Postfix) with ESMTP id 8E7E320011; Tue,
	10 Sep 2013 12:33:28 -0400 (EDT)
From: Denys Dmytriyenko <denis@denix.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 10 Sep 2013 12:33:26 -0400
Message-id: <1378830807-24027-1-git-send-email-denis@denix.org>
X-Mailer: git-send-email 1.8.3.2
Cc: Denys Dmytriyenko <denys@ti.com>
Subject: [1.18][PATCH] Backport methodpool changes from master
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
X-List-Received-Date: Tue, 10 Sep 2013 16:34:06 -0000

From: Denys Dmytriyenko <denys@ti.com>

The patch to retire methodpool helps fix intermittent parsing issue in Dylan:
http://thread.gmane.org/gmane.comp.handhelds.openembedded.core/42786

Richard Purdie (1):
  methodpool: Retire it, remove global method scope

 lib/bb/cooker.py                   |  2 ++
 lib/bb/methodpool.py               | 43 --------------------------------------
 lib/bb/parse/ast.py                |  8 +++----
 lib/bb/parse/parse_py/BBHandler.py |  4 ----
 4 files changed, 5 insertions(+), 52 deletions(-)

-- 
1.8.3.2


