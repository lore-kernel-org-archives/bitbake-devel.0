Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RsbqC-000756-Cu
	for bitbake-devel@lists.openembedded.org;
	Wed, 01 Feb 2012 16:11:20 +0100
Received: by opal (Postfix, from userid 111)
	id 048C010332; Wed,  1 Feb 2012 15:03:46 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120201150346.048C010332@opal>
Date: Wed,  1 Feb 2012 15:03:46 +0000 (UTC)
From: git@git.openembedded.org
Subject: Paul Eggleton : bitbake-layers: add copyright notice
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
X-List-Received-Date: Wed, 01 Feb 2012 15:11:20 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 69ed02b645bdc28c1bf24e436beeed37d226b56b
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=69ed02b645bdc28c1bf24e436beeed37d226b56b

Author: Paul Eggleton <paul.eggleton@linux.intel.com>
Date:   Mon Jan 30 16:25:49 2012 +0000

bitbake-layers: add copyright notice

This ought to have been added earlier. (I consulted with Chris Larson on
the notice covering his work.)

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 bin/bitbake-layers |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index b4cfd55..3007d51 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -4,6 +4,9 @@
 # displaying useful information, or acting against them.
 # See the help output for details on available commands.
 
+# Copyright (C) 2011 Mentor Graphics Corporation
+# Copyright (C) 2012 Intel Corporation
+
 import cmd
 import logging
 import os



