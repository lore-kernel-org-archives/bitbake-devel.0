Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 626456B262
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 19 Jul 2013 08:11:11 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id r6J8BDq6017849
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 19 Jul 2013 01:11:13 -0700 (PDT)
Received: from pek-hostel-vm02.wrs.com (128.224.153.172) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
	14.2.342.3; Fri, 19 Jul 2013 01:11:11 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 19 Jul 2013 04:11:07 -0400
Message-ID: <2917b6580c7655656d551b185f092042c035e87d.1374204011.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <cover.1374204011.git.liezhi.yang@windriver.com>
References: <cover.1374204011.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] providers.py: print a debug message for dynamic pacakge
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 19 Jul 2013 08:11:11 -0000
Content-Type: text/plain

We can't know the dynamic pacakge's name exactly, there might be a
problem, for example, when we use:

IMAGE_INSTALL_append += "ncurses-lib12344"

The ncurses-lib12344 matches ncurses' dynamic packages pattern:

PACKAGES_DYNAMIC = "^${PN}-lib.*"

so there is no errors before the rootfs creation though there is no
ncurses-lib12344.

We can warn this, but I think that we'd better not since there are many
dynamic packages, or there would be too many warnings, for example, the
perl and kernel modules, maybe we can print a debug message for it.

[YOCTO #4798]

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/providers.py |    1 +
 1 file changed, 1 insertion(+)

diff --git a/bitbake/lib/bb/providers.py b/bitbake/lib/bb/providers.py
index 3d0fb48..cac13ac 100644
--- a/bitbake/lib/bb/providers.py
+++ b/bitbake/lib/bb/providers.py
@@ -376,5 +376,6 @@ def getRuntimeProviders(dataCache, rdepend):
             regexp_cache[pattern] = regexp
         if regexp.match(rdepend):
             rproviders += dataCache.packages_dynamic[pattern]
+            logger.debug(1, "Assuming %s is a dynamic package, but it may not exist" % rdepend)
 
     return rproviders
-- 
1.7.10.4


