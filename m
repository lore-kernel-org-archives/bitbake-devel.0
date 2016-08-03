Return-Path: <Liam.Howlett@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 03D8C760AC
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  3 Aug 2016 19:57:54 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id u73JvtNe001192
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 3 Aug 2016 12:57:55 -0700 (PDT)
Received: from yow-lhowlett-d0.wrs.com (128.224.56.205) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
	14.3.248.2; Wed, 3 Aug 2016 12:57:54 -0700
From: "Liam R. Howlett" <Liam.Howlett@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 3 Aug 2016 15:57:50 -0400
Message-ID: <1470254270-5368-3-git-send-email-Liam.Howlett@WindRiver.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1470254270-5368-1-git-send-email-Liam.Howlett@WindRiver.com>
References: <1470254270-5368-1-git-send-email-Liam.Howlett@WindRiver.com>
MIME-Version: 1.0
Cc: Liam.Howlett@WindRiver.com
Subject: [PATCH 2/2] bin/toaster: set shwordsplit if using zsh.
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
X-List-Received-Date: Wed, 03 Aug 2016 19:57:55 -0000
Content-Type: text/plain

Since this script is meant to be sourced, shwordsplit has to be
explicitly set to ensure the variable MANAGE is set correctly and
functions independent of the users shwordsplit setting.

Signed-off-by: Liam R. Howlett <Liam.Howlett@WindRiver.com>
---
 bin/toaster | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bin/toaster b/bin/toaster
index 66157d0..038e93b 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -130,6 +130,7 @@ if [ -n "$BASH_SOURCE" ] ; then
     TOASTER=${BASH_SOURCE}
 elif [ -n "$ZSH_NAME" ] ; then
     TOASTER=${(%):-%x}
+    set -o shwordsplit
 else
     TOASTER=$0
 fi
-- 
1.9.1


