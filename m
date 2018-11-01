Return-Path: <Awais_Belal@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
	by mail.openembedded.org (Postfix) with ESMTP id 82DBF79EC9
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  1 Nov 2018 21:40:33 +0000 (UTC)
Received: from nat-ies.mentorg.com ([192.94.31.2]
	helo=SVR-IES-MBX-03.mgc.mentorg.com)
	by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
	id 1gIKhe-0002or-H5 from Awais_Belal@mentor.com 
	for bitbake-devel@lists.openembedded.org;
	Thu, 01 Nov 2018 14:40:34 -0700
Received: from P7520.world.mentorg.com (137.202.0.90) by
	SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3) with Microsoft SMTP
	Server (TLS) id 15.0.1320.4; Thu, 1 Nov 2018 21:40:30 +0000
From: Awais Belal <awais_belal@mentor.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 2 Nov 2018 02:40:15 +0500
Message-ID: <1541108415-15634-1-git-send-email-awais_belal@mentor.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-08.mgc.mentorg.com (139.181.222.8) To
	SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3)
Subject: [PATCH v2] bitbake: toaster: allow OE_ROOT to be provided through environment
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
X-List-Received-Date: Thu, 01 Nov 2018 21:40:33 -0000
Content-Type: text/plain

Updates for YOCTO #12891 allowed a user to have a directory
structure different to that of yocto (bitbake isn't inside
oe-core) whereas the definition of OE_ROOT in the main toaster
binary still assumes the same while checking for .templateconf
and hence we see an error on the cmdline in such cases:
bash: <repo-path>/bitbake/bin/../../.templateconf: No such file or directory
The change here now allows the user to provide OE_ROOT through
the environment in such cases and otherwise defaults to the older
mechanism to fix this issue.

Signed-off-by: Awais Belal <awais_belal@mentor.com>
---
 bin/toaster | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/bin/toaster b/bin/toaster
index 9fffbc6..ecf66fa 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -161,7 +161,9 @@ fi
 
 export BBBASEDIR=`dirname $TOASTER`/..
 MANAGE="python3 $BBBASEDIR/lib/toaster/manage.py"
-OE_ROOT=`dirname $TOASTER`/../..
+if [ -z "$OE_ROOT" ]; then
+    OE_ROOT=`dirname $TOASTER`/../..
+fi
 
 # this is the configuraton file we are using for toaster
 # we are using the same logic that oe-setup-builddir uses
-- 
2.7.4


