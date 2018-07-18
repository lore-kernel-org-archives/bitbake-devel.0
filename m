Return-Path: <pn@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by mail.openembedded.org (Postfix) with ESMTP id F3F4E789B2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Jul 2018 14:14:17 +0000 (UTC)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 41Vzff1kR0z1r3kM;
	Wed, 18 Jul 2018 16:14:18 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
	by mail.m-online.net (Postfix) with ESMTP id 41Vzff1Ggnz1vB6k;
	Wed, 18 Jul 2018 16:14:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new,
	port 10024)
	with ESMTP id MzUVletBldnc; Wed, 18 Jul 2018 16:14:17 +0200 (CEST)
X-Auth-Info: 5cwWRSWgX3yn4XT3oWmJ7Jv7osdLY71DGqnSQKIS730=
Received: from xpert.denx.de (unknown [62.91.23.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Wed, 18 Jul 2018 16:14:17 +0200 (CEST)
From: Parthiban Nallathambi <pn@denx.de>
To: peter.kjellerstedt@axis.com,
	bitbake-devel@lists.openembedded.org
Date: Wed, 18 Jul 2018 16:14:01 +0200
Message-Id: <20180718141401.2690758-1-pn@denx.de>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <05b7fac8-2663-4032-ebc3-30f08ef46a3e@denx.de>
References: <05b7fac8-2663-4032-ebc3-30f08ef46a3e@denx.de>
Cc: wd@denx.de, sbabic@denx.de
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
X-List-Received-Date: Wed, 18 Jul 2018 14:14:18 -0000

shrinkwrap resolved relative URL can start with http. For example,
"resolved: http-proxy/-/http-proxy-${PV}.tgz" is still relative URL
to npm registry, but starts with http.

Current if statement compares the startswith 'resolved' to 'http',
which makes impossible to use npm download. Condtional comparison
now strictly checks for "http://" and "https://"

Changelog since v1:
- Use the proper conditional statement to avoid always success

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
---
 bitbake/lib/bb/fetch2/npm.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/npm.py b/bitbake/lib/bb/fetch2/npm.py
index 408dfc3d03..65bf5a3644 100644
--- a/bitbake/lib/bb/fetch2/npm.py
+++ b/bitbake/lib/bb/fetch2/npm.py
@@ -226,7 +226,7 @@ class Npm(FetchMethod):
                         self._getshrinkeddependencies(obj, data['dependencies'][obj], data['dependencies'][obj]['version'], d, ud, lockdown, manifest, False)
                         return
         outputurl = "invalid"
-        if ('resolved' not in data) or (not data['resolved'].startswith('http')):
+        if ('resolved' not in data) or (not data['resolved'].startswith('http://') and not data['resolved'].startswith('https://')):
             # will be the case for ${PN}
             fetchcmd = "npm view %s@%s dist.tarball --registry %s" % (pkg, version, ud.registry)
             logger.debug(2, "Found this matching URL: %s" % str(fetchcmd))
-- 
2.14.4


