Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard@rpsys.net>) id 1ShLqJ-0007wt-PG
	for bitbake-devel@lists.openembedded.org;
	Wed, 20 Jun 2012 16:25:11 +0200
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2ubuntu2) with ESMTP id
	q5KEH0mA007947 for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jun 2012 15:17:01 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id bXgQaZ6szXHH for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jun 2012 15:17:00 +0100 (BST)
Received: from ted (ted.config [192.168.1.66]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.2/Debian-2build1) with ESMTP id
	q5KEGwi1007940
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jun 2012 15:16:59 +0100
Received: from richard by ted with local (Exim 4.76)
	(envelope-from <richard@dan.rpsys.net>) id 1ShLeh-0002SN-2P
	for bitbake-devel@lists.openembedded.org;
	Wed, 20 Jun 2012 15:13:11 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 20 Jun 2012 15:12:51 +0100
Message-Id: <cover.1340200207.git.richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 1.7.5.4
Subject: [PATCH 00/14] Bitbake fetcher mirror handling overhaul
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
X-List-Received-Date: Wed, 20 Jun 2012 14:25:12 -0000

The following commits overhaul bitbake's mirror handling in the fetcher
bring various correctness fixes and improvements.

Richard Purdie (14):
  fetch2/__init__: Make it clearer when uri_replace doesn't return a
    match
  fetch2: Fix error handling in uri_replace()
  fetch2: Only cache data if fn is set, its pointless caching it
    against a None value
  fetch2: Ensure when downloading we are consistently in the same
    directory
  fetch2: Split try_mirrors into two parts
  fetch2: Explicitly check for mirror tarballs in mirror handling code
  fetch2: Improve mirror looping to consider more cases
  fetch2: Simplify some looping constructs in uri_replace()
  fetch2: Remove basestring test and simplify uri_replace
  fetch2: Add parameter handling to uri_replace()
  fetch2: uri_replace() remove what amounts to a null operation and add
    some comments
  fetch2: uri_replace() improve mirrortarball handling
  fetch2: uri_replace() only consider ud.localpath where its a file
  test/fetch: Add in unit tests for uri_replace() and git premirrors

 bitbake/lib/bb/fetch2/__init__.py |  203 ++++++++++++++++++++++---------------
 bitbake/lib/bb/tests/fetch.py     |   55 ++++++++++-
 2 files changed, 175 insertions(+), 83 deletions(-)

-- 
1.7.5.4



