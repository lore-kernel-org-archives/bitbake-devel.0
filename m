Return-Path: <peter.kjellerstedt@axis.com>
Received: from anubis.se.axis.com (anubis.se.axis.com [195.60.68.12])
	by mail.openembedded.org (Postfix) with ESMTP id DCD5D6BB3A
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  6 Sep 2013 15:53:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by anubis.se.axis.com (Postfix) with ESMTP id 4F6F019E4B
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  6 Sep 2013 17:53:28 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at anubis.se.axis.com
Received: from anubis.se.axis.com ([127.0.0.1])
	by localhost (anubis.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id zcOIuJwiL+a2 for <bitbake-devel@lists.openembedded.org>;
	Fri,  6 Sep 2013 17:53:23 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by anubis.se.axis.com (Postfix) with ESMTP id 9996219E0C
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  6 Sep 2013 17:53:23 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 79B805DF
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  6 Sep 2013 17:53:23 +0200 (CEST)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id 6E8204C1
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  6 Sep 2013 17:53:23 +0200 (CEST)
Received: from saur-2.se.axis.com (saur-2.se.axis.com [10.92.3.2])
	by seth.se.axis.com (Postfix) with ESMTP id 6278F3E06F
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  6 Sep 2013 17:53:23 +0200 (CEST)
Received: from saur-2.se.axis.com (localhost [127.0.0.1])
	by saur-2.se.axis.com (8.14.5/8.14.5) with ESMTP id r86FrNwv031413
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 6 Sep 2013 17:53:23 +0200
Received: (from pkj@localhost)
	by saur-2.se.axis.com (8.14.5/8.14.5/Submit) id r86FrNJU031388
	for bitbake-devel@lists.openembedded.org; Fri, 6 Sep 2013 17:53:23 +0200
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  6 Sep 2013 17:53:19 +0200
Message-Id: <cover.1378482725.git.pkj@axis.com>
X-Mailer: git-send-email 1.8.2.1
Subject: [PATCH 0/1] Make ${DATE} and ${TIME} consistent
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
X-List-Received-Date: Fri, 06 Sep 2013 15:53:27 -0000

This fixes a problem with ${DATE} and ${TIME} not being consistent
between different workers. E.g., a fakerooted task had a different time
than a non-fakerooted one...

//Peter

The following changes since commit ed3ef0823fde89371a473d20c0127c0bd16d062b:

  qemumips: fix keyboard entry in graphical boots (2013-09-05 16:27:54 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib pkj/consistent_date_and_time
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=pkj/consistent_date_and_time

Peter Kjellerstedt (1):
  bitbake: Ensure ${DATE} and ${TIME} are consistent

 bitbake/bin/bitbake-worker | 2 ++
 bitbake/lib/bb/runqueue.py | 2 ++
 2 files changed, 4 insertions(+)

-- 
1.8.2.1


