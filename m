Return-Path: <l.goehrs@pengutronix.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CFDC021BE
	for <webhook@archiver.kernel.org>; Tue, 25 Feb 2025 07:06:49 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
 by mx.groups.io with SMTP id smtpd.web11.3055.1740467202925958859
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Feb 2025 23:06:43 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: pengutronix.de, ip: 185.203.201.7, mailfrom: lgo@pengutronix.de)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <lgo@pengutronix.de>)
	id 1tmp1d-0006LX-48; Tue, 25 Feb 2025 08:06:41 +0100
Received: from dude03.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::39])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <lgo@pengutronix.de>)
	id 1tmp1c-002jLZ-2b;
	Tue, 25 Feb 2025 08:06:40 +0100
Received: from lgo by dude03.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <lgo@pengutronix.de>)
	id 1tmp1c-009cII-0Y;
	Tue, 25 Feb 2025 08:06:40 +0100
From: =?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	=?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>
Subject: [PATCH v1 1/5] fetch2/wget: enable classes derived from Wget to set custom http headers
Date: Tue, 25 Feb 2025 08:06:26 +0100
Message-Id: <20250225070631.2262115-1-l.goehrs@pengutronix.de>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: lgo@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: bitbake-devel@lists.openembedded.org
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Feb 2025 07:06:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17305

This allows derived fetchers to e.g. set a `Authorization: Bearer ...`
header for token based authentication, or `Accept:` headers to restrict
which file type the fetcher expects.

Signed-off-by: Leonard Göhrs <l.goehrs@pengutronix.de>
---
 lib/bb/fetch2/__init__.py | 1 +
 lib/bb/fetch2/wget.py     | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index bd87f18be..64f87b3ec 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1272,6 +1272,7 @@ class FetchData(object):
         self.basename = None
         self.basepath = None
         (self.type, self.host, self.path, self.user, self.pswd, self.parm) = decodeurl(d.expand(url))
+        self.headers = None
         self.date = self.getSRCDate(d)
         self.url = url
         if not self.user and "user" in self.parm:
diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 6cb728ab4..fdf1f2860 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -121,6 +121,10 @@ class Wget(FetchMethod):
                 # Authorization header.
                 fetchcmd += " --user=%s --password=%s" % (ud.user, ud.pswd)
 
+        if ud.headers:
+            for key, value in ud.headers.items():
+                fetchcmd += " --header='%s: %s'" % (key, value)
+
         uri = ud.url.split(";")[0]
         if os.path.exists(ud.localpath):
             # file exists, but we didnt complete it.. trying again..
@@ -394,6 +398,10 @@ class Wget(FetchMethod):
                 if ud.user and ud.pswd:
                     add_basic_auth(ud.user + ':' + ud.pswd, r)
 
+                if ud.headers:
+                    for key, value in ud.headers.items():
+                        r.add_header(key, value)
+
                 try:
                     import netrc
                     auth_data = netrc.netrc().authenticators(urllib.parse.urlparse(uri).hostname)
-- 
2.39.5


