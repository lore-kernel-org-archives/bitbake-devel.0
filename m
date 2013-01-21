Received: from anubis.se.axis.com ([195.60.68.12])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <olof.johansson@axis.com>) id 1TxDuE-0005ye-Nm
	for bitbake-devel@lists.openembedded.org;
	Mon, 21 Jan 2013 10:43:10 +0100
Received: from localhost (localhost [127.0.0.1])
	by anubis.se.axis.com (Postfix) with ESMTP id 59F2A19DD3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Jan 2013 10:18:04 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at anubis.se.axis.com
Received: from anubis.se.axis.com ([127.0.0.1])
	by localhost (anubis.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id JhclLnRzIseP for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Jan 2013 10:18:04 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by anubis.se.axis.com (Postfix) with ESMTP id 4294019DB0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Jan 2013 10:18:03 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by thoth.se.axis.com (Postfix) with ESMTP id D0ADA34175
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Jan 2013 10:18:03 +0100 (CET)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.2.176.0; Mon, 21 Jan 2013
	10:18:03 +0100
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id 9241A9C077; 
	Mon, 21 Jan 2013 10:18:03 +0100 (CET)
From: Olof Johansson <olof.johansson@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 21 Jan 2013 10:17:57 +0100
Message-ID: <1358759883-7566-1-git-send-email-olof.johansson@axis.com>
X-Mailer: git-send-email 1.7.10.4
MIME-Version: 1.0
Subject: [PATCH 0/6] fetch2: SFTP fetcher and restructure of decodeurl
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
X-List-Received-Date: Mon, 21 Jan 2013 09:43:15 -0000
Content-Type: text/plain

Hi,

In our early work in migrating to poky we realized that bitbake's current SSH
fetcher doesn't really suite our needs. It suffers from some specification
conformance bugs --- some which may be easily worked around. However, this
patch series instead introduces a new "SFTP" fetcher, meant to in a way,
replace the SSH fetcher, with stricter conformance to the SECSH URI spec [1].

The SSH fetcher has its own URI parsing, and can not rely on
bb.fetch2.decodeurl. I found that decodeurl was hard to extend, with it
returning a tuple. This prompted me to write a generic URI class, with
attributes for the various URI components (and some general bitbake kludges,
like support relative file:// uris).

I realize that these changes are a bit bold and non-trivial, but I hope you'll
find time to review them and point out problems to fix. If my reasoning is
completely wrong, please let me know and I can try to solve our direct problems
with the SSH fetcher with minimal changes instead.

The changes come with unittests for the URI class; it passes all the tests in
bb.tests.fetch and all other tests under bb.tests, except
bb.tests.data.DataExpansions, but the same errors are present on master as
well. I've also tested running bitbake core-image-minimal in a new tree without
any issues.


Olof Johansson (6):
  fetch2: Remove unused code in wget fetcher
  fetch2: Add a class representing a generic URI
  fetch2: unittests for bb.fetch2.URI class
  fetch2: Adapt encode/decode url to use URI class
  fetch2: Add editor modelines for bb.tests.*
  fetch2: Add SFTP fetcher

 lib/bb/fetch2/__init__.py  |  262 +++++++++++++++++++++++++++++++++++---------
 lib/bb/fetch2/sftp.py      |  104 ++++++++++++++++++
 lib/bb/fetch2/wget.py      |    5 -
 lib/bb/tests/codeparser.py |    2 +
 lib/bb/tests/cow.py        |    2 +
 lib/bb/tests/data.py       |    2 +
 lib/bb/tests/fetch.py      |  228 ++++++++++++++++++++++++++++++++++++++
 lib/bb/tests/utils.py      |    2 +
 8 files changed, 553 insertions(+), 54 deletions(-)
 create mode 100644 lib/bb/fetch2/sftp.py


References:
1: http://tools.ietf.org/html/draft-ietf-secsh-scp-sftp-ssh-uri-04

-- 
Olof Johansson
Tools engineer
(IRC: zibri on Freenode)


