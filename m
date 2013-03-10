Received: from anubis.se.axis.com ([195.60.68.12])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <olof.johansson@axis.com>) id 1UEjGv-0006qs-38
	for bitbake-devel@lists.openembedded.org;
	Sun, 10 Mar 2013 17:38:53 +0100
Received: from localhost (localhost [127.0.0.1])
	by anubis.se.axis.com (Postfix) with ESMTP id 123C819DEB
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 10 Mar 2013 17:22:16 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at anubis.se.axis.com
Received: from anubis.se.axis.com ([127.0.0.1])
	by localhost (anubis.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 4WRXKDkh59DA for <bitbake-devel@lists.openembedded.org>;
	Sun, 10 Mar 2013 17:22:15 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by anubis.se.axis.com (Postfix) with ESMTP id 3894B19DC9
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 10 Mar 2013 17:22:14 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by seth.se.axis.com (Postfix) with ESMTP id EE9A93E2AC
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 10 Mar 2013 17:22:14 +0100 (CET)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.2.176.0; Sun, 10 Mar 2013
	17:22:14 +0100
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id 113509C078; 
	Sun, 10 Mar 2013 17:22:23 +0100 (CET)
From: Olof Johansson <olof.johansson@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sun, 10 Mar 2013 17:22:17 +0100
Message-ID: <1362932543-3737-1-git-send-email-olof.johansson@axis.com>
X-Mailer: git-send-email 1.7.10.4
MIME-Version: 1.0
Subject: [PATCH 0/5] bb.fetch2.URI class fixes
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
X-List-Received-Date: Sun, 10 Mar 2013 16:38:55 -0000
X-List-Received-Date: Sun, 10 Mar 2013 16:38:55 -0000
Content-Type: text/plain

During ELC, RP reverted the change where the encode- and
decodeurl were replaced with wrappers around the URI class
because of build failures in some corner cases. The cause of that
issue was my failure to take query strings in to account, and
that should now be solved.

This patch serie also includes some minor bug fixes to the URI
class.

On a last note, if you know of any weird/complex/unconventional
URLs in use somewhere, please let me know, and I'll add them to
the unit tests to make sure they are parsed ok.

Olof Johansson (5):
  fetch2.URI: Coerce urlparse to use netloc for all schemes
  tests.fetch: Remove debug assert
  fetch2.URI: add support for query parameters
  fetch2.URI: Support URIs with both query strings and params
  fetch2.URI: Set username/password should not change the other

 lib/bb/fetch2/__init__.py |   80 ++++++++++++++++++++++++++-------------------
 lib/bb/tests/fetch.py     |   62 ++++++++++++++++++++++++++++++++++-
 2 files changed, 107 insertions(+), 35 deletions(-)

-- 
1.7.10.4



