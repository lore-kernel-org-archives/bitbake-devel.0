Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 727F66C52C
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  4 Dec 2018 01:48:56 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id wB41mvNL005905
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 3 Dec 2018 17:48:57 -0800 (PST)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.408.0; Mon, 3 Dec 2018 17:48:57 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 4 Dec 2018 10:06:01 +0800
Message-ID: <3388f1e1c1b2a062ab1a2008e80e605f98150edc.1543889029.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543889029.git.liezhi.yang@windriver.com>
References: <cover.1543889029.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 2/4] pysh/sherrors.py: Remove unused classes
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
X-List-Received-Date: Tue, 04 Dec 2018 01:48:56 -0000
Content-Type: text/plain

The only two that we need are ShellSyntaxError and ShellError, others are not
used, so remove them.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/pysh/sherrors.py | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/bitbake/lib/bb/pysh/sherrors.py b/bitbake/lib/bb/pysh/sherrors.py
index 49d0533..3fe8e47 100644
--- a/bitbake/lib/bb/pysh/sherrors.py
+++ b/bitbake/lib/bb/pysh/sherrors.py
@@ -13,29 +13,3 @@ class ShellError(Exception):
 
 class ShellSyntaxError(ShellError):
     pass
-    
-class UtilityError(ShellError):
-    """Raised upon utility syntax error (option or operand error)."""
-    pass
-   
-class ExpansionError(ShellError):
-    pass
-     
-class CommandNotFound(ShellError):
-    """Specified command was not found."""
-    pass
-    
-class RedirectionError(ShellError):
-    pass
-    
-class VarAssignmentError(ShellError):
-    """Variable assignment error."""
-    pass
-    
-class ExitSignal(ShellError):
-    """Exit signal."""
-    pass
-    
-class ReturnSignal(ShellError):
-    """Exit signal."""
-    pass
-- 
2.7.4


