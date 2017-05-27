Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 9855B78184
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 27 May 2017 10:21:50 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id v4RALmEb018743
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Sat, 27 May 2017 03:21:48 -0700 (PDT)
Received: from ala-blade47.wrs.com (147.11.105.67) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.294.0;
	Sat, 27 May 2017 03:21:48 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sat, 27 May 2017 03:21:48 -0700
Message-ID: <20170527102148.15448-1-liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.10.2
MIME-Version: 1.0
Cc: paul.eggleton@linux.intel.com
Subject: [PATCH] bb/tinfoil.py: import bb.msg
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
X-List-Received-Date: Sat, 27 May 2017 10:21:50 -0000
Content-Type: text/plain

It uses bb.msg without import it, so there might be errors like:
AttributeError: 'module' object has no attribute 'logger_create'

We can't reproduce the problem everytime, I think that it depends on the order.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 lib/bb/tinfoil.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index 928333a..a0d8a16 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -33,6 +33,7 @@ import bb.remotedata
 from bb.cookerdata import CookerConfiguration, ConfigParameters
 from bb.main import setup_bitbake, BitBakeConfigParameters, BBMainException
 import bb.fetch2
+import bb.msg
 
 
 # We need this in order to shut down the connection to the bitbake server,
-- 
2.10.2


