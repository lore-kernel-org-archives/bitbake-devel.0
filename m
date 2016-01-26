Return-Path: <peter.kjellerstedt@axis.com>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id 8B17071951
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Jan 2016 10:19:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id 9FBD22E135
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Jan 2016 11:19:59 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id zlicBV8EEQrt for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Jan 2016 11:19:59 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bes.se.axis.com (Postfix) with ESMTP id 0A5AF2E0CE
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Jan 2016 11:19:59 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id E20C91458
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Jan 2016 11:19:58 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id D6AC54AD
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Jan 2016 11:19:58 +0100 (CET)
Received: from saur-2.se.axis.com (saur-2.se.axis.com [10.92.3.2])
	by seth.se.axis.com (Postfix) with ESMTP id C914B3E37A
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Jan 2016 11:19:58 +0100 (CET)
Received: from saur-2.se.axis.com (localhost [127.0.0.1])
	by saur-2.se.axis.com (8.14.5/8.14.5) with ESMTP id u0QAJwVH002150
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Jan 2016 11:19:58 +0100
Received: (from pkj@localhost)
	by saur-2.se.axis.com (8.14.5/8.14.5/Submit) id u0QAJwsl002149
	for bitbake-devel@lists.openembedded.org;
	Tue, 26 Jan 2016 11:19:58 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 26 Jan 2016 11:19:55 +0100
Message-Id: <cover.1453803559.git.pkj@axis.com>
X-Mailer: git-send-email 2.1.0
Subject: [PATCH 0/1] Fixes for verify_checksum()
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
X-List-Received-Date: Tue, 26 Jan 2016 10:20:02 -0000

This simplifies the logic in verify_checksum() in fetch2.

//Peter

The following changes since commit 72f98ba5775f6faa2bcad80b913948c1b953111b:

  bitbake: toaster: Update UI test runner (2016-01-25 16:29:10 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib pkj/verify_checksum
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=pkj/verify_checksum

Peter Kjellerstedt (1):
  fetch2: Simplify logic in verify_checksum()

 bitbake/lib/bb/fetch2/__init__.py | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

-- 
2.1.0


