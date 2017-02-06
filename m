Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by mail.openembedded.org (Postfix) with ESMTP id 9794471999
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  6 Feb 2017 20:08:56 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga105.jf.intel.com with ESMTP; 06 Feb 2017 12:08:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,342,1477983600"; d="scan'208";a="222023480"
Received: from mmurr6x-mobl1.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.252.199.82])
	by fmsmga004.fm.intel.com with ESMTP; 06 Feb 2017 12:08:56 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  7 Feb 2017 09:08:50 +1300
Message-Id: <f499f8c82a0692a68a54daa884c658eb2c65742a.1486411669.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1486411669.git.paul.eggleton@linux.intel.com>
References: <cover.1486411669.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/3] fetch2/npm: handle items only in optionalDependencies
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
X-List-Received-Date: Mon, 06 Feb 2017 20:08:56 -0000

An npm package.json file has two dependency fields: dependencies and
optionalDependencies. An item in optionalDependencies *may* also be
listed in dependencies, but this is not required (and not necessary
since if it's in optionalDependencies it will be optional, adding it to
dependencies won't do anything). The code here was assuming that an
optional dependency would always be in both, that's probably because
that was true of the examples I was looking at at the time. To fix it,
just add the optional ones to the list we're iterating over.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/fetch2/npm.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index 3e35292..8c32f81 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -195,6 +195,7 @@ class Npm(FetchMethod):
 
         dependencies = pdata.get('dependencies', {})
         optionalDependencies = pdata.get('optionalDependencies', {})
+        dependencies.update(optionalDependencies)
         depsfound = {}
         optdepsfound = {}
         data[pkg]['deps'] = {}
-- 
2.9.3


