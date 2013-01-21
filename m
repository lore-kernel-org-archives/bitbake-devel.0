Received: from anubis.se.axis.com ([195.60.68.12])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <olof.johansson@axis.com>) id 1TxDuE-0005yb-LP
	for bitbake-devel@lists.openembedded.org;
	Mon, 21 Jan 2013 10:43:10 +0100
Received: from localhost (localhost [127.0.0.1])
	by anubis.se.axis.com (Postfix) with ESMTP id 7AF9019DB0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Jan 2013 10:18:04 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at anubis.se.axis.com
Received: from anubis.se.axis.com ([127.0.0.1])
	by localhost (anubis.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id gTDcGGhs0tcL for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Jan 2013 10:18:04 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by anubis.se.axis.com (Postfix) with ESMTP id 44DF719DC3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Jan 2013 10:18:03 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by thoth.se.axis.com (Postfix) with ESMTP id D163634183
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Jan 2013 10:18:03 +0100 (CET)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.2.176.0; Mon, 21 Jan 2013
	10:18:03 +0100
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id A15699C076; 
	Mon, 21 Jan 2013 10:18:03 +0100 (CET)
From: Olof Johansson <olof.johansson@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 21 Jan 2013 10:17:58 +0100
Message-ID: <1358759883-7566-2-git-send-email-olof.johansson@axis.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1358759883-7566-1-git-send-email-olof.johansson@axis.com>
References: <1358759883-7566-1-git-send-email-olof.johansson@axis.com>
MIME-Version: 1.0
Subject: [PATCH 1/6] fetch2: Remove unused code in wget fetcher
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

Signed-off-by: Olof Johansson <olof.johansson@axis.com>
---
 lib/bb/fetch2/wget.py |    5 -----
 1 file changed, 5 deletions(-)

diff --git lib/bb/fetch2/wget.py lib/bb/fetch2/wget.py
index 2808df6..1fafc4a 100644
--- lib/bb/fetch2/wget.py
+++ lib/bb/fetch2/wget.py
@@ -32,8 +32,6 @@ import urllib
 from   bb import data
 from   bb.fetch2 import FetchMethod
 from   bb.fetch2 import FetchError
-from   bb.fetch2 import encodeurl
-from   bb.fetch2 import decodeurl
 from   bb.fetch2 import logger
 from   bb.fetch2 import runfetchcmd
 
@@ -77,9 +75,6 @@ class Wget(FetchMethod):
             fetchcmd = d.getVar("FETCHCOMMAND_wget", True) or d.expand(basecmd + " -P ${DL_DIR} '${URI}'")
 
         uri = uri.split(";")[0]
-        uri_decoded = list(decodeurl(uri))
-        uri_type = uri_decoded[0]
-        uri_host = uri_decoded[1]
 
         fetchcmd = fetchcmd.replace("${URI}", uri.split(";")[0])
         fetchcmd = fetchcmd.replace("${FILE}", ud.basename)
-- 
1.7.10.4



