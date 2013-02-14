Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1U5wVl-0002FV-I6 for bitbake-devel@lists.openembedded.org;
	Thu, 14 Feb 2013 11:57:54 +0100
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r1EAleSQ032357 for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Feb 2013 10:47:40 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id oZWbA2DrjkPo for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Feb 2013 10:47:40 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r1EAlXKM032330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Feb 2013 10:47:36 GMT
Message-ID: <1360838484.11225.102.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 14 Feb 2013 10:41:24 +0000
X-Mailer: Evolution 3.6.3-1 
Mime-Version: 1.0
Subject: [PATCH] ConfHandler: Improve regexp to fix mis-parsing of += and no whitespace
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
X-List-Received-Date: Thu, 14 Feb 2013 10:57:55 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If you have:

FOO = "a"
FOO += "b"
FOO+= "c"

The expected result is "a b c" however we were seeing "a b" with the FOO+
variable being assigned the value "c". This isn't the expected result.

We need to make the name part of the variale non-greedy so that any + character
becomes part of the operator. This patch does that. I compared the configuration
in OE-Core before and after the change and only the test case changed.

[YOCTO #3834]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/parse/parse_py/ConfHandler.py b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
index b3d10c6..4b62a3a 100644
--- a/bitbake/lib/bb/parse/parse_py/ConfHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
@@ -29,7 +29,7 @@ import logging
 import bb.utils
 from bb.parse import ParseError, resolve_file, ast, logger
 
-__config_regexp__  = re.compile( r"(?P<exp>export\s*)?(?P<var>[a-zA-Z0-9\-~_+.${}/]+)(\[(?P<flag>[a-zA-Z0-9\-_+.]+)\])?\s*((?P<colon>:=)|(?P<lazyques>\?\?=)|(?P<ques>\?=)|(?P<append>\+=)|(?P<prepend>=\+)|(?P<predot>=\.)|(?P<postdot>\.=)|=)\s*(?!'[^']*'[^']*'$)(?!\"[^\"]*\"[^\"]*\"$)(?P<apo>['\"])(?P<value>.*)(?P=apo)$")
+__config_regexp__  = re.compile( r"(?P<exp>export\s*)?(?P<var>[a-zA-Z0-9\-~_+.${}/]+?)(\[(?P<flag>[a-zA-Z0-9\-_+.]+)\])?\s*((?P<colon>:=)|(?P<lazyques>\?\?=)|(?P<ques>\?=)|(?P<append>\+=)|(?P<prepend>=\+)|(?P<predot>=\.)|(?P<postdot>\.=)|=)\s*(?!'[^']*'[^']*'$)(?!\"[^\"]*\"[^\"]*\"$)(?P<apo>['\"])(?P<value>.*)(?P=apo)$")
 __include_regexp__ = re.compile( r"include\s+(.+)" )
 __require_regexp__ = re.compile( r"require\s+(.+)" )
 __export_regexp__ = re.compile( r"export\s+([a-zA-Z0-9\-_+.${}/]+)$" )




