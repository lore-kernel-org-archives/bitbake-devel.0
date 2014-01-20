Return-Path: <olof.johansson@axis.com>
Received: from anubis.se.axis.com (anubis.se.axis.com [195.60.68.12])
	by mail.openembedded.org (Postfix) with ESMTP id F421D6E7BE
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 11:03:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by anubis.se.axis.com (Postfix) with ESMTP id C1F0219D8B
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 12:03:48 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at anubis.se.axis.com
Received: from anubis.se.axis.com ([127.0.0.1])
	by localhost (anubis.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id uj6yZtmILpMm for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 12:03:48 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by anubis.se.axis.com (Postfix) with ESMTP id 3E1AF19DC8
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 12:03:25 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 1E8EFC6B
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 12:03:25 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id 13920BB0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 12:03:25 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by seth.se.axis.com (Postfix) with ESMTP id 10CA73E070
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 12:03:25 +0100 (CET)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.2.255.0; Mon, 20 Jan 2014
	12:03:24 +0100
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id C71909C079; 
	Mon, 20 Jan 2014 12:03:24 +0100 (CET)
From: Olof Johansson <olof.johansson@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 20 Jan 2014 12:03:19 +0100
Message-ID: <1390215804-20578-1-git-send-email-olof.johansson@axis.com>
X-Mailer: git-send-email 1.8.5.2
MIME-Version: 1.0
Subject: [PATCH 0/5] Improvements to bb.fetch2.URI class
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
X-List-Received-Date: Mon, 20 Jan 2014 11:03:48 -0000
Content-Type: text/plain

This patch series fixes some issues that was encountered after the URI class
was integrated to Bitbake's fetch2 package. Notably, it adds support for query
parameters. This patch series does *not* make encode/decodeurl use the URI
class, as I had issues getting uri_replace to work with it.


Olof Johansson (5):
  fetch2.URI: Coerce urlparse to use netloc for all schemes
  tests.fetch: Remove debug assert
  fetch2.URI: add support for query parameters
  fetch2.URI: Support URIs with both query strings and params
  fetch2.URI: Set username/password should not change the other

 lib/bb/fetch2/__init__.py | 80 +++++++++++++++++++++++++++--------------------
 lib/bb/tests/fetch.py     | 62 +++++++++++++++++++++++++++++++++++-
 2 files changed, 107 insertions(+), 35 deletions(-)

-- 
1.8.5.2


