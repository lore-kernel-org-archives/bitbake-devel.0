Received: from anubis.se.axis.com ([195.60.68.12])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <olof.johansson@axis.com>) id 1U06CZ-0002zv-6L
	for bitbake-devel@lists.openembedded.org;
	Tue, 29 Jan 2013 09:06:07 +0100
Received: from localhost (localhost [127.0.0.1])
	by anubis.se.axis.com (Postfix) with ESMTP id EC57D19DDA
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Jan 2013 08:50:15 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at anubis.se.axis.com
Received: from anubis.se.axis.com ([127.0.0.1])
	by localhost (anubis.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id YQlN3NVDT7zX for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Jan 2013 08:50:12 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by anubis.se.axis.com (Postfix) with ESMTP id 734B419DD0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Jan 2013 08:50:12 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by thoth.se.axis.com (Postfix) with ESMTP id 36B653416B
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Jan 2013 08:50:12 +0100 (CET)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.2.176.0; Tue, 29 Jan 2013
	08:50:12 +0100
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id 8DB759C078; 
	Tue, 29 Jan 2013 08:50:11 +0100 (CET)
From: Olof Johansson <olof.johansson@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 29 Jan 2013 08:50:05 +0100
Message-ID: <1359445811-6394-1-git-send-email-olof.johansson@axis.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1358759883-7566-1-git-send-email-olof.johansson@axis.com>
References: <1358759883-7566-1-git-send-email-olof.johansson@axis.com>
MIME-Version: 1.0
Subject: [PATCH v2 0/6] fetch2: Updated SFTP fetcher
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
X-List-Received-Date: Tue, 29 Jan 2013 08:06:14 -0000
Content-Type: text/plain

Changes since the first draft (thanks Martin Jansa for the feedback):

 * Rebase against current master
 * Regenerate diffs without git config diff.noprefix
 * Support /~/ (home relative URIs) in SFTP fetcher
 * Add an example section in the SFTP fetcher documentation
 * Remove "checkstatus" method from SFTP fetcher (wasn't meant to be there)

Olof Johansson (6):
  fetch2: Remove unused code in wget fetcher
  fetch2: Add a class representing a generic URI
  fetch2: unittests for bb.fetch2.URI class
  fetch2: Adapt encode/decode url to use URI class
  fetch2: Add editor modelines for bb.tests.*
  fetch2: Add SFTP fetcher

 lib/bb/fetch2/__init__.py  |  262 +++++++++++++++++++++++++++++++++++---------
 lib/bb/fetch2/sftp.py      |  129 ++++++++++++++++++++++
 lib/bb/fetch2/wget.py      |    5 -
 lib/bb/tests/codeparser.py |    2 +
 lib/bb/tests/cow.py        |    2 +
 lib/bb/tests/data.py       |    2 +
 lib/bb/tests/fetch.py      |  228 ++++++++++++++++++++++++++++++++++++++
 lib/bb/tests/utils.py      |    2 +
 8 files changed, 578 insertions(+), 54 deletions(-)
 create mode 100644 lib/bb/fetch2/sftp.py

-- 
1.7.10.4



