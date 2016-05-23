Return-Path: <peter.kjellerstedt@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id 1844E601A4
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 May 2016 11:35:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id CE8CB1811B
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 May 2016 13:35:51 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id 7yyt5PdAiGwn for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 May 2016 13:35:51 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bastet.se.axis.com (Postfix) with ESMTP id 8EB19180F2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 May 2016 13:35:50 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 6FC471A8A
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 May 2016 13:35:50 +0200 (CEST)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id 64F121512
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 May 2016 13:35:50 +0200 (CEST)
Received: from saur-2.se.axis.com (saur-2.se.axis.com [10.92.3.2])
	by seth.se.axis.com (Postfix) with ESMTP id 5EF20FB1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 May 2016 13:35:50 +0200 (CEST)
Received: from saur-2.se.axis.com (localhost [127.0.0.1])
	by saur-2.se.axis.com (8.14.5/8.14.5) with ESMTP id u4NBZoek027510
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 May 2016 13:35:50 +0200
Received: (from pkj@localhost)
	by saur-2.se.axis.com (8.14.5/8.14.5/Submit) id u4NBZoYS027506
	for bitbake-devel@lists.openembedded.org;
	Mon, 23 May 2016 13:35:50 +0200
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 23 May 2016 13:35:48 +0200
Message-Id: <cover.1464003299.git.pkj@axis.com>
X-Mailer: git-send-email 2.1.0
Subject: [PATCH 0/1] Fixes for the Git fetcher
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
X-List-Received-Date: Mon, 23 May 2016 11:35:54 -0000

This fixes a problem with the Git fetcher where it could assign the
wrong SHA-1 to a Git reference. The problem was that the matching done
in _latest_revision() wasn't exact, which means that, e.g., SRCREV =
"R${PV}" where PV = "1.0" would match a tag called R1.0.0, rather than
fail as it should since the tag R1.0 does not exist.

//Peter

The following changes since commit c7e614c438706fb3ed7520b4990ebb3973366942:

  useradd: Fix infinite build loop (2016-05-23 10:33:45 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib pkj/exact_git_refs
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=pkj/exact_git_refs

Peter Kjellerstedt (1):
  fetch2/git.py: References must match exactly

 bitbake/lib/bb/fetch2/git.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.1.0


