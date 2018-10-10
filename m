Return-Path: <peter.marko@siemens.com>
X-Greylist: delayed 939 seconds by postgrey-1.34 at layers.openembedded.org;
	Wed, 10 Oct 2018 10:50:49 UTC
Received: from david.siemens.de (david.siemens.de [192.35.17.14])
	by mail.openembedded.org (Postfix) with ESMTP id A86237455D
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Oct 2018 10:50:49 +0000 (UTC)
Received: from mail1.siemens.de (mail1.siemens.de [139.23.33.14])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id w9AAZAUF029533
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Oct 2018 12:35:10 +0200
Received: from dev-6.vm6.ccp.siemens.com ([163.242.52.226])
	by mail1.siemens.de (8.15.2/8.15.2) with ESMTP id w9AAZASG020820;
	Wed, 10 Oct 2018 12:35:10 +0200
Received: from dev-6.vm6.ccp.siemens.com (localhost [127.0.0.1])
	by dev-6.vm6.ccp.siemens.com (Postfix) with ESMTP id 601019550DC;
	Wed, 10 Oct 2018 12:35:10 +0200 (CEST)
From: Peter Marko <peter.marko@siemens.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 10 Oct 2018 12:34:40 +0200
Message-Id: <20181010103440.14201-2-peter.marko@siemens.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181010103440.14201-1-peter.marko@siemens.com>
References: <20181010103440.14201-1-peter.marko@siemens.com>
Subject: [PATCH 1/1] fetch2: avoid circular recursion with SRCPV in PR
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
X-List-Received-Date: Wed, 10 Oct 2018 10:50:50 -0000

Some recent changes broke SRCPV and workaround was introduced
to avoid circular dependency if SRCPV is in PV.
However there is still the same error if SRCPV is in PR.

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 lib/bb/fetch2/__init__.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index a83526a5..cb2f325a 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -837,14 +837,16 @@ def runfetchcmd(cmd, d, quiet=False, cleanup=None, log=None, workdir=None):
     if not cleanup:
         cleanup = []
 
-    # If PATH contains WORKDIR which contains PV which contains SRCPV we
+    # If PATH contains WORKDIR which contains PV-PR which contains SRCPV we
     # can end up in circular recursion here so give the option of breaking it
     # in a data store copy.
     try:
         d.getVar("PV")
+        d.getVar("PR")
     except bb.data_smart.ExpansionError:
         d = bb.data.createCopy(d)
         d.setVar("PV", "fetcheravoidrecurse")
+        d.setVar("PR", "fetcheravoidrecurse")
 
     origenv = d.getVar("BB_ORIGENV", False)
     for var in exportvars:
-- 
2.11.0


