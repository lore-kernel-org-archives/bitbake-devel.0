Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1U2IXA-0005UC-93
	for bitbake-devel@lists.openembedded.org;
	Mon, 04 Feb 2013 10:40:18 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id r149OSET009617
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 4 Feb 2013 01:24:28 -0800 (PST)
Received: from pek-usp-3.wrs.com (128.224.163.124) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.318.4;
	Mon, 4 Feb 2013 01:24:26 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 4 Feb 2013 17:27:47 +0800
Message-ID: <9d21459877d1d94bdaff1cbe8ca4dd84f5f692fd.1359948771.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <cover.1359948771.git.liezhi.yang@windriver.com>
References: <cover.1359948771.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Cc: Zhenfeng.Zhao@windriver.com
Subject: [PATCH 1/1] perforce.py: fix the perforce fetcher
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
X-List-Received-Date: Mon, 04 Feb 2013 09:40:22 -0000
Content-Type: text/plain

The bb.process.run() will return one tuple, e.g:

p4file = ('strA\nStrB\nstrC\n'), then there will be an iteration on p4file:

for i in p4file:
	[snip]

The i will be 's t r A ...', this is incorrect. use:

p4file = p4file.splitlines()

will fix the problem.

[YOCTO #3619]

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/fetch2/perforce.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/perforce.py b/bitbake/lib/bb/fetch2/perforce.py
index df3a3a3..86ec9ba 100644
--- a/bitbake/lib/bb/fetch2/perforce.py
+++ b/bitbake/lib/bb/fetch2/perforce.py
@@ -170,7 +170,7 @@ class Perforce(FetchMethod):
         logger.info("Fetch " + loc)
         logger.info("%s%s files %s", p4cmd, p4opt, depot)
         p4file, errors = bb.process.run("%s%s files %s" % (p4cmd, p4opt, depot))
-        p4file = p4file.strip()
+        p4file = p4file.splitlines()
 
         if not p4file:
             raise FetchError("Fetch: unable to get the P4 files from %s" % depot, loc)
-- 
1.7.11.2



