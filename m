Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1Rkvef-00040O-AC
	for bitbake-devel@lists.openembedded.org;
	Wed, 11 Jan 2012 11:43:41 +0100
Received: by opal (Postfix, from userid 111)
	id 6EB4A10331; Wed, 11 Jan 2012 10:44:38 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120111104438.6EB4A10331@opal>
Date: Wed, 11 Jan 2012 10:44:38 +0000 (UTC)
From: git@git.openembedded.org
Subject: Lianhao Lu : bitbake/PRservice: Added no_hist mode and export/import.
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
X-List-Received-Date: Wed, 11 Jan 2012 10:43:41 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 379567ee879dcdc09a51f7f1212bde1076147a6f
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=379567ee879dcdc09a51f7f1212bde1076147a6f

Author: Lianhao Lu <lianhao.lu@intel.com>
Date:   Tue Jan 10 14:13:49 2012 +0800

bitbake/PRservice: Added no_hist mode and export/import.

[YOCTO #1556]
1. Added the package_arch into the index to the DB table. Because the
change in PACKAGE_ARCH will results in different checksum, and it is
better to have seperate PR value domains for differnt PACKAGE_ARCH of
the same pakcage.

2. Changed the PR service to operate in no history mode. In this mode,
the for a given query tuple (version, pkgarch, checksum), the returned
value will be the largest among all the values of the same (version,
pkgarch). This means the PR value returned can NOT be decremented.

3. Added export function. For each (version, pkgarch) tuple, only the
record with the maximum value will be exported.

4. Added import function. The record will only be imported if the
imported value is larger than the value stored in the DB with the same
(version, pkgarch, checksum) tuple.

Signed-off-by: Lianhao Lu <lianhao.lu@intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 bin/bitbake-prserv     |   23 +++---
 lib/prserv/__init__.py |    5 +-
 lib/prserv/db.py       |  209 ++++++++++++++++++++++++++++++++++++++++--------
 lib/prserv/serv.py     |  106 ++++++++++++++++---------
 4 files changed, 263 insertions(+), 80 deletions(-)

Diff:   http://git.openembedded.org/?p=bitbake.git/?a=commitdiff;h=379567ee879dcdc09a51f7f1212bde1076147a6f


