Return-Path: <Joe.MacDonald@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 1D0B66AE12
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Jun 2013 15:05:14 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id r5SF5Eto002456
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Fri, 28 Jun 2013 08:05:14 -0700 (PDT)
Received: from burninator.wrs.com (128.224.146.166) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.2.342.3;
	Fri, 28 Jun 2013 08:05:12 -0700
From: Joe MacDonald <joe.macdonald@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 28 Jun 2013 11:05:07 -0400
Message-ID: <1372431907-10142-3-git-send-email-joe.macdonald@windriver.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1372431907-10142-1-git-send-email-joe.macdonald@windriver.com>
References: <1372431907-10142-1-git-send-email-joe.macdonald@windriver.com>
MIME-Version: 1.0
Subject: [bitbake][oe-core][RFC PATCH 2/2] sstate.bbclass: Add an extra check for sstate_mirrors
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
X-List-Received-Date: Fri, 28 Jun 2013 15:05:14 -0000
Content-Type: text/plain

BB_NO_NETWORK disables any fetching, however if we're using an external
sstate cache, we may want to be able to fetch those objects even if we are
not fetching the upstream sources.

Signed-off-by: Joe MacDonald <joe.macdonald@windriver.com>
---
 meta/classes/sstate.bbclass |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/meta/classes/sstate.bbclass b/meta/classes/sstate.bbclass
index 28dc312..759fb93 100644
--- a/meta/classes/sstate.bbclass
+++ b/meta/classes/sstate.bbclass
@@ -515,7 +515,7 @@ def pstaging_fetch(sstatefetch, sstatepkg, d):
                    'file://{0}.siginfo'.format(sstatefetch)]:
         localdata.setVar('SRC_URI', srcuri)
         try:
-            fetcher = bb.fetch2.Fetch([srcuri], localdata, cache=False)
+            fetcher = bb.fetch2.Fetch([srcuri], localdata, cache=False, sstate_cache=True)
             fetcher.download()
 
             # Need to optimise this, if using file:// urls, the fetcher just changes the local path
@@ -632,7 +632,7 @@ def sstate_checkhashes(sq_fn, sq_task, sq_hash, sq_hashfn, d):
             bb.debug(2, "SState: Attempting to fetch %s" % srcuri)
 
             try:
-                fetcher = bb.fetch2.Fetch(srcuri.split(), localdata)
+                fetcher = bb.fetch2.Fetch(srcuri.split(), localdata, sstate_cache=True)
                 fetcher.checkstatus()
                 bb.debug(2, "SState: Successful fetch test for %s" % srcuri)
                 ret.append(task)
-- 
1.7.10.4


