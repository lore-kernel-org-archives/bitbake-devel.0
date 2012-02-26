Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1S1duK-0004Xj-Pb; Sun, 26 Feb 2012 14:12:56 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q1QD4VJT013160;
	Sun, 26 Feb 2012 13:04:31 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 12449-05; Sun, 26 Feb 2012 13:04:25 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q1QD4NgE013154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 26 Feb 2012 13:04:24 GMT
Message-ID: <1330261465.31855.4.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sun, 26 Feb 2012 13:04:25 +0000
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: openembedded-core <openembedded-core@lists.openembedded.org>
Subject: [PATCH] bitbake/ConfHandler: Be more strict about variable quoting
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
X-List-Received-Date: Sun, 26 Feb 2012 13:12:57 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

[cross posted to OE-Core since this is a major change in behaviour but
in my opinion, probably a good one]

Currently, bitbake will accept variables in the forms:

X = 1
X = '1 \

X = "1"
X = '1'

which will all set X=1. This patch removes the first two possibilities
and makes quoting mandatory. There is little metadata out there which
doesn't quote properly and bitbake will exit with an error about the
exact line number and file with any problem so users can easily identify
and fix issues. OE-Core has already been checked/fixed.

The motivation for this is being able to give sane errors if a user
does something like:

IMAGE_INSTALL += # tslib mtd-utils"

which currently gives a really nasty failure.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/parse/parse_py/ConfHandler.py b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
index 9242632..64b8208 100644
--- a/bitbake/lib/bb/parse/parse_py/ConfHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
@@ -29,8 +29,7 @@ import logging
 import bb.utils
 from bb.parse import ParseError, resolve_file, ast, logger
 
-#__config_regexp__  = re.compile( r"(?P<exp>export\s*)?(?P<var>[a-zA-Z0-9\-_+.${}]+)\s*(?P<colon>:)?(?P<ques>\?)?=\s*(?P<apo>['\"]?)(?P<value>.*)(?P=apo)$")
-__config_regexp__  = re.compile( r"(?P<exp>export\s*)?(?P<var>[a-zA-Z0-9\-_+.${}/]+)(\[(?P<flag>[a-zA-Z0-9\-_+.]+)\])?\s*((?P<colon>:=)|(?P<lazyques>\?\?=)|(?P<ques>\?=)|(?P<append>\+=)|(?P<prepend>=\+)|(?P<predot>=\.)|(?P<postdot>\.=)|=)\s*(?P<apo>['\"]?)(?P<value>.*)(?P=apo)$")
+__config_regexp__  = re.compile( r"(?P<exp>export\s*)?(?P<var>[a-zA-Z0-9\-_+.${}/]+)(\[(?P<flag>[a-zA-Z0-9\-_+.]+)\])?\s*((?P<colon>:=)|(?P<lazyques>\?\?=)|(?P<ques>\?=)|(?P<append>\+=)|(?P<prepend>=\+)|(?P<predot>=\.)|(?P<postdot>\.=)|=)\s*(?P<apo>['\"])(?P<value>.*)(?P=apo)$")
 __include_regexp__ = re.compile( r"include\s+(.+)" )
 __require_regexp__ = re.compile( r"require\s+(.+)" )
 __export_regexp__ = re.compile( r"export\s+(.+)" )




