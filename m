Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1Rkveg-00040P-7F
	for bitbake-devel@lists.openembedded.org;
	Wed, 11 Jan 2012 11:43:42 +0100
Received: by opal (Postfix, from userid 111)
	id 8921C10333; Wed, 11 Jan 2012 10:44:38 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120111104438.8921C10333@opal>
Date: Wed, 11 Jan 2012 10:44:38 +0000 (UTC)
From: git@git.openembedded.org
Subject: Lianhao Lu : bitbake: Automatically start local PR service.
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
X-List-Received-Date: Wed, 11 Jan 2012 10:43:42 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 9d8f45407c67ed0d3c4f820cf646de3c385067c7
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=9d8f45407c67ed0d3c4f820cf646de3c385067c7

Author: Lianhao Lu <lianhao.lu@intel.com>
Date:   Tue Jan 10 14:13:50 2012 +0800

bitbake: Automatically start local PR service.

[YOCTO #1126]
A local PR service will be started and stopped automatically along
with the bitbake invocation/ternimation.

This local PR service will be started only and if only when the
PRSERV_HOST is set to 'localhost' and PRSERV_PORT is set to '0'.

When started, the sqlite3 database is stored at
"${PERSISTEN_DIR}/prserv.sqlite3" or "${CACHE}/prserv.sqlite3".

Signed-off-by: Lianhao Lu <lianhao.lu@intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 bin/bitbake-prserv |    9 ++--
 lib/bb/cooker.py   |    3 +
 lib/prserv/db.py   |   12 +++--
 lib/prserv/serv.py |  144 +++++++++++++++++++++++++++++++++++++++-------------
 4 files changed, 123 insertions(+), 45 deletions(-)

Diff:   http://git.openembedded.org/?p=bitbake.git/?a=commitdiff;h=9d8f45407c67ed0d3c4f820cf646de3c385067c7


