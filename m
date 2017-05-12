Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 16AA777B27
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 May 2017 08:26:12 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v4C8QBd1029659
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Fri, 12 May 2017 09:26:12 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1d95tr-0001kN-6F; Fri, 12 May 2017 09:26:11 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 12 May 2017 09:26:10 +0100
Message-Id: <1494577570-6677-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Fri, 12 May 2017 09:26:12 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH] data_smart: Don't cache/process capitalised overrides
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
X-List-Received-Date: Fri, 12 May 2017 08:26:17 -0000

Bitbake now only processes overrides which are lowercase since
this allows variables like SRC_URI not to pollute the cache.

There was a corner case where XXX_append_SomeThing was still being
processed (yet XXX_append_SomeThing_SomeOtherThing would not be).

This patch ensures we're consistent and only process lowercase
_append/_prepend and _remove operators too.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data_smart.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 7dc1c68..7b09af5 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -39,7 +39,7 @@ from bb.COW  import COWDictBase
 logger = logging.getLogger("BitBake.Data")
 
 __setvar_keyword__ = ["_append", "_prepend", "_remove"]
-__setvar_regexp__ = re.compile('(?P<base>.*?)(?P<keyword>_append|_prepend|_remove)(_(?P<add>.*))?$')
+__setvar_regexp__ = re.compile('(?P<base>.*?)(?P<keyword>_append|_prepend|_remove)(_(?P<add>[^A-Z]*))?$')
 __expand_var_regexp__ = re.compile(r"\${[^{}@\n\t :]+}")
 __expand_python_regexp__ = re.compile(r"\${@.+?}")
 
-- 
2.7.4


