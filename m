Return-Path: <pn@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by mail.openembedded.org (Postfix) with ESMTP id 8A4C66C424
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Nov 2018 18:07:36 +0000 (UTC)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 42xR606ftwz1qyLg;
	Fri, 16 Nov 2018 19:07:36 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
	by mail.m-online.net (Postfix) with ESMTP id 42xR6046Wgz1rJpd;
	Fri, 16 Nov 2018 19:07:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new,
	port 10024)
	with ESMTP id 9cqh2XQKGLMB; Fri, 16 Nov 2018 19:07:35 +0100 (CET)
X-Auth-Info: W5gjEKvdc3Qjw5dbSAuJBl33fGBx/BSnIDUJvrHgOkg=
Received: from parthiban.fritz.box (62.91.16.92.dsl.ffm.de.dialin.bisping.net
	[62.91.16.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Fri, 16 Nov 2018 19:07:35 +0100 (CET)
From: Parthiban Nallathambi <pn@denx.de>
To: peter.kjellerstedt@axis.com,
	bitbake-devel@lists.openembedded.org
Date: Fri, 16 Nov 2018 19:07:12 +0100
Message-Id: <20181116180712.4154-1-pn@denx.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Cc: wd@denx.de, sbabic@denx.de
Subject: [PATCH v2] bitbake: fetch2/npm.py: Allow shrinkwrap resolved relative URL which startswith 'http' (e.g http-proxy)
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
X-List-Received-Date: Fri, 16 Nov 2018 18:07:36 -0000
Content-Transfer-Encoding: 8bit

shrinkwrap resolved relative URL can start with http. For example,
"resolved: http-proxy/-/http-proxy-${PV}.tgz" is still relative URL
to npm registry, but starts with http.

Current if statement compares the startswith 'resolved' to 'http',
which makes impossible to use npm download. Condtional comparison
now strictly checks for "http://" and "https://"

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
---

Notes:
    Changelog since v1:
    - Use the proper conditional statement to avoid always success

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
2.19.1


