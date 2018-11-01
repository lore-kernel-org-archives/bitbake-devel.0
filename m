Return-Path: <Awais_Belal@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
	by mail.openembedded.org (Postfix) with ESMTP id 1D5C079E3F
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  1 Nov 2018 13:34:49 +0000 (UTC)
Received: from nat-ies.mentorg.com ([192.94.31.2]
	helo=SVR-IES-MBX-03.mgc.mentorg.com)
	by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
	id 1gID7Z-0003yB-U4 from Awais_Belal@mentor.com 
	for bitbake-devel@lists.openembedded.org;
	Thu, 01 Nov 2018 06:34:49 -0700
Received: from P7520.world.mentorg.com (137.202.0.90) by
	SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3) with Microsoft SMTP
	Server (TLS) id 15.0.1320.4; Thu, 1 Nov 2018 13:34:45 +0000
From: Awais Belal <awais_belal@mentor.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 1 Nov 2018 18:34:30 +0500
Message-ID: <1541079270-28297-1-git-send-email-awais_belal@mentor.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2) To
	SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3)
Subject: [PATCH] bitbake: toaster: allow OE_ROOT to be provided through environment
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
X-List-Received-Date: Thu, 01 Nov 2018 13:34:49 -0000
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
 bin/toaster | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/toaster b/bin/toaster
index 9fffbc6..4e227cc 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -161,7 +161,7 @@ fi
 
 export BBBASEDIR=`dirname $TOASTER`/..
 MANAGE="python3 $BBBASEDIR/lib/toaster/manage.py"
-OE_ROOT=`dirname $TOASTER`/../..
+OE_ROOT=${OE_ROOT:-`dirname $TOASTER`/../..}
 
 # this is the configuraton file we are using for toaster
 # we are using the same logic that oe-setup-builddir uses
-- 
2.7.4


