Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RoHeT-0003tx-LL
	for bitbake-devel@lists.openembedded.org;
	Fri, 20 Jan 2012 17:51:24 +0100
Received: by opal (Postfix, from userid 111)
	id F003410333; Fri, 20 Jan 2012 16:35:55 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120120163555.F003410333@opal>
Date: Fri, 20 Jan 2012 16:35:55 +0000 (UTC)
From: git@git.openembedded.org
Subject: Christopher Larson : Add dependency on the backported python 3.2 concurrent .futures
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 20 Jan 2012 16:51:24 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 774f59f06e65a35df597aa77c0fa06ab66c46906
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=774f59f06e65a35df597aa77c0fa06ab66c46906

Author: Christopher Larson <chris_larson@mentor.com>
Date:   Sun Jan  8 17:17:23 2012 -0600

Add dependency on the backported python 3.2 concurrent.futures

Signed-off-by: Christopher Larson <chris_larson@mentor.com>

---

 lib/concurrent/__init__.py         |    3 +
 lib/concurrent/futures/__init__.py |   18 ++
 lib/concurrent/futures/_base.py    |  575 ++++++++++++++++++++++++++++++++++++
 lib/concurrent/futures/_compat.py  |  101 +++++++
 lib/concurrent/futures/process.py  |  345 +++++++++++++++++++++
 lib/concurrent/futures/thread.py   |  144 +++++++++
 setup.py                           |    2 +-
 7 files changed, 1187 insertions(+), 1 deletions(-)

Diff:   http://git.openembedded.org/?p=bitbake.git/?a=commitdiff;h=774f59f06e65a35df597aa77c0fa06ab66c46906


