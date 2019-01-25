Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 894F77C383
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Jan 2019 09:35:47 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x0P9Z3UN009478
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Jan 2019 01:35:38 -0800
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.408.0; Fri, 25 Jan 2019 01:35:19 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 25 Jan 2019 17:53:29 +0800
Message-ID: <833a1b5b2ac94de2f78ce14aec4dbf2cc02ed80c.1548409947.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1548409947.git.liezhi.yang@windriver.com>
References: <cover.1548409947.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] bitbake: ConfHandler: Don't strip leading spaces
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
X-List-Received-Date: Fri, 25 Jan 2019 09:35:47 -0000
Content-Type: text/plain

Fixed:
- Add the following lines to conf/local.conf:
  FOO = "BAR1"
  FOO_append = "\
      BAR2"

  $ bitbake -e | grep '^FOO'
  FOO="BAR1BAR2"

  The leading spaces in the second line have been removed.

- But if add the previous two lines to base.bbclass:
  $ bitbake -e | grep '^FOO'
  FOO="BAR1    BAR2"

  The leading spaces in the second line are preserved, this is inconsistent, now
  fix ConfHandler to preserve leading spaces.

[YOCTO #12380]

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/parse/parse_py/ConfHandler.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/parse/parse_py/ConfHandler.py b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
index 9d3ebe1..ea49f8c 100644
--- a/bitbake/lib/bb/parse/parse_py/ConfHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
@@ -147,7 +147,7 @@ def handle(fn, data, include):
             continue
         s = s.rstrip()
         while s[-1] == '\\':
-            s2 = f.readline().strip()
+            s2 = f.readline().rstrip()
             lineno = lineno + 1
             if (not s2 or s2 and s2[0] != "#") and s[0] == "#" :
                 bb.fatal("There is a confusing multiline, partially commented expression on line %s of file %s (%s).\nPlease clarify whether this is all a comment or should be parsed." % (lineno, fn, s))
-- 
2.7.4


