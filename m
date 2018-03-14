Return-Path: <pn@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by mail.openembedded.org (Postfix) with ESMTP id 2A15C7888F
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Mar 2018 16:52:06 +0000 (UTC)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 401d6v3TYbz1qwHq;
	Wed, 14 Mar 2018 17:52:07 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
	by mail.m-online.net (Postfix) with ESMTP id 401d6v36LXz1qwkS;
	Wed, 14 Mar 2018 17:52:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new,
	port 10024)
	with ESMTP id kNH3Dkq9TC1E; Wed, 14 Mar 2018 17:52:06 +0100 (CET)
X-Auth-Info: R6jDcO/fJ9CMSTK8ACNRgjYkef8lCqZXY0zEfsB6JMs=
Received: from xpert.denx.de (unknown [62.91.23.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Wed, 14 Mar 2018 17:52:06 +0100 (CET)
From: Parthiban Nallathambi <pn@denx.de>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Mar 2018 17:50:58 +0100
Message-Id: <20180314165058.2559191-1-pn@denx.de>
X-Mailer: git-send-email 2.14.3
Cc: lusus@denx.de, wd@denx.de, sbabic@denx.de
Subject: [PATCH] bitbake: fetch2/npm.py: Allow shrinkwrap resolved relative URL which startswith 'http' (e.g http-proxy)
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
X-List-Received-Date: Wed, 14 Mar 2018 16:52:07 -0000

shrinkwrap resolved relative URL can start with http. For example,
"resolved: http-proxy/-/http-proxy-${PV}.tgz" is still relative URL
to npm registry, but starts with http.

Current if statement compares the startswith 'resolved' to 'http',
which makes impossible to use npm download. Condtional comparison
now strictly checks for "http://" and "https://"

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
---
 bitbake/lib/bb/fetch2/npm.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/npm.py b/bitbake/lib/bb/fetch2/npm.py
index 730c346a93..95f7484444 100644
--- a/bitbake/lib/bb/fetch2/npm.py
+++ b/bitbake/lib/bb/fetch2/npm.py
@@ -227,7 +227,7 @@ class Npm(FetchMethod):
                         self._getshrinkeddependencies(obj, data['dependencies'][obj], data['dependencies'][obj]['version'], d, ud, lockdown, manifest, False)
                         return
         outputurl = "invalid"
-        if ('resolved' not in data) or (not data['resolved'].startswith('http')):
+        if ('resolved' not in data) or (not data['resolved'].startswith('http://')) or (not data['resolved'].startswith('https://')):
             # will be the case for ${PN}
             fetchcmd = "npm view %s@%s dist.tarball --registry %s" % (pkg, version, ud.registry)
             logger.debug(2, "Found this matching URL: %s" % str(fetchcmd))
-- 
2.14.3


