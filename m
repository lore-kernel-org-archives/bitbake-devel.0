Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 400627318A
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  8 Apr 2016 22:48:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u38Mm0E6003406 for <bitbake-devel@lists.openembedded.org>;
	Fri, 8 Apr 2016 23:48:00 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id hncBSVMM1TP8 for <bitbake-devel@lists.openembedded.org>;
	Fri,  8 Apr 2016 23:48:00 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u38MlwDc003403
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 8 Apr 2016 23:48:00 +0100
Message-ID: <1460155678.9308.2.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 08 Apr 2016 23:47:58 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] data_smart: Restrict expansion regexp to not include : characters
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
X-List-Received-Date: Fri, 08 Apr 2016 22:48:01 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Bitbake variables don't include ":" characters so exclude these from the variable
expansion regexp.

This assists when parsing shell code which does A=${B:-C} as we don't want a
dependency on a variable called "B:-C".

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index d61ad53..fa1e794 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -40,7 +40,7 @@ logger = logging.getLogger("BitBake.Data")
 
 __setvar_keyword__ = ["_append", "_prepend", "_remove"]
 __setvar_regexp__ = re.compile('(?P<base>.*?)(?P<keyword>_append|_prepend|_remove)(_(?P<add>.*))?$')
-__expand_var_regexp__ = re.compile(r"\${[^{}@\n\t ]+}")
+__expand_var_regexp__ = re.compile(r"\${[^{}@\n\t :]+}")
 __expand_python_regexp__ = re.compile(r"\${@.+?}")
 
 def infer_caller_details(loginfo, parent = False, varval = True):



