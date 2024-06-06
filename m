Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7C4C27C52
	for <webhook@archiver.kernel.org>; Thu,  6 Jun 2024 20:34:25 +0000 (UTC)
Received: from smtp-out.freemail.hu (smtp-out.freemail.hu [46.107.16.239])
 by mx.groups.io with SMTP id smtpd.web10.25537.1717705879050125553
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Jun 2024 13:31:19 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@freemail.hu header.s=20181004 header.b=a0xaA9ty;
 spf=pass (domain: freemail.hu, ip: 46.107.16.239, mailfrom: egyszeregy@freemail.hu)
Received: from localhost.localdomain (catv-80-98-74-198.catv.fixed.vodafone.hu [80.98.74.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.freemail.hu (Postfix) with ESMTPSA id 4VwGFH6L8lz82Y;
	Thu,  6 Jun 2024 22:31:15 +0200 (CEST)
From: "Livius" <egyszeregy@freemail.hu>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	=?UTF-8?q?Benjamin=20Sz=C5=91ke?= <egyszeregy@freemail.hu>
Subject: [PATCH] fetch2/wget: Add user_agent parameter so it can be used optionally
Date: Thu,  6 Jun 2024 22:31:02 +0200
Message-ID: <20240606203103.910-1-egyszeregy@freemail.hu>
X-Mailer: git-send-email 2.45.2.windows.1
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1717705876;
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Jun 2024 20:34:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16326

	s=20181004; d=freemail.hu;

	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;

	l=4435; bh=Mu06w9kxAPEAY8SODpXy14jCOZmzgdOZm+/km5JWeR0=;

	b=a0xaA9tyY+IEZXE/3UykqdrKoGzJJHKhn/TPRPmGwWyviw4ZNG+y+P1huJ1vc3IT

	y5buIB1SvhQ6lhwE0nD36bSmJ+K16nkWAX69SFXal3DsSQyTWEcDcm5fYW/i/EBkwx+

	fLVIaxxQswizZVXpMM2qr9/pVWQGMV8GCZzfLt76NHYcTlXS4c9QmGUDtIi2CyrS/QA

	Ck8bjo1YcsFUtBptXWdAkmE5mpgQ7GcEYIFqYl21I6Vw3y0pxxE9BUsRI96kgXHJ0pB

	ponoYNEF/XdYC+1Sbz6KXsVCB+gh3nn6MhwbFAXQNTgvhg2AQsMwKmySdul1cWIqbzz

	XLHQ0YPhnw==
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>

Add "user_agent" optional parameter for wget fetcher to able
to use it if HTTP servers block requests with the default wget
user agent.

Signed-off-by: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
---
 .../bitbake-user-manual-fetching.rst          | 20 ++++++++++++-------
 .../bitbake-user-manual-ref-variables.rst     |  4 ++++
 lib/bb/fetch2/wget.py                         | 11 +++++++++-
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/d=
oc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index fb4f0a23d..899fa2f33 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -221,13 +221,18 @@ HTTP/FTP wget fetcher (``http://``, ``ftp://``, ``h=
ttps://``)
 This fetcher obtains files from web and FTP servers. Internally, the
 fetcher uses the wget utility.
=20
-The executable and parameters used are specified by the
-``FETCHCMD_wget`` variable, which defaults to sensible values. The
-fetcher supports a parameter "downloadfilename" that allows the name of
-the downloaded file to be specified. Specifying the name of the
-downloaded file is useful for avoiding collisions in
-:term:`DL_DIR` when dealing with multiple files that
-have the same name.
+The executable and parameters used are specified by the ``FETCHCMD_wget`=
`
+variable, which defaults to sensible values. The fetcher supports
+parameters, "downloadfilename" that allows the name of the downloaded
+file to be specified and "user_agent" parameter which enable to use
+a default ``Mozilla/5.0`` user-agent or a custom string value
+via usage of :term:`BB_USER_AGENT`.
+
+Specifying the name of the downloaded file is useful for avoiding
+collisions in :term:`DL_DIR` when dealing with multiple files
+that have the same name. A few HTTP servers block requests with
+the default wget user-agent, in this case specifying a valid
+user-agent can solve this issue.
=20
 If a username and password are specified in the ``SRC_URI``, a Basic
 Authorization header will be added to each request, including across red=
irects.
@@ -239,6 +244,7 @@ Some example URLs are as follows::
    SRC_URI =3D "http://oe.handhelds.org/not_there.aac"
    SRC_URI =3D "ftp://oe.handhelds.org/not_there_as_well.aac"
    SRC_URI =3D "ftp://you@oe.handhelds.org/home/you/secret.plan"
+   SRC_URI =3D "https://oe.handhelds.org/not_there.aac;user_agent=3D1"
=20
 .. note::
=20
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rs=
t b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 899e584f9..a6c05a6bf 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -699,6 +699,10 @@ overview of their function and contents.
       Within an executing task, this variable holds the hash of the task=
 as
       returned by the currently enabled signature generator.
=20
+   :term:`BB_USER_AGENT`
+      Specifies a user-agent string which BitBake uses if "user_agent"
+      parameter is enabled for HTTP/FTP wget fetcher.
+
    :term:`BB_VERBOSE_LOGS`
       Controls how verbose BitBake is during builds. If set, shell scrip=
ts
       echo commands and shell script output appears on standard out
diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index d76b1d0d3..db4327ead 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -56,7 +56,7 @@ class Wget(FetchMethod):
     # CDNs like CloudFlare may do a 'browser integrity test' which can f=
ail
     # with the standard wget/urllib User-Agent, so pretend to be a moder=
n
     # browser.
-    user_agent =3D "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:84.0) Gec=
ko/20100101 Firefox/84.0"
+    user_agent =3D "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:126.0) Ge=
cko/20100101 Firefox/126.0"
=20
     def check_certs(self, d):
         """
@@ -89,6 +89,15 @@ class Wget(FetchMethod):
=20
         self.basecmd =3D d.getVar("FETCHCMD_wget") or "/usr/bin/env wget=
 -t 2 -T 30"
=20
+        is_user_agent_enabled =3D ud.parm.get("user_agent","0") =3D=3D "=
1"
+        if is_user_agent_enabled:
+            bb_user_agent =3D d.getVar("BB_USER_AGENT")
+            if bb_user_agent is not None:
+                cmd_user_agent =3D bb_user_agent
+            else:
+                cmd_user_agent =3D self.user_agent
+            self.basecmd +=3D f" --user-agent=3D'{cmd_user_agent}'"
+
         if ud.type =3D=3D 'ftp' or ud.type =3D=3D 'ftps':
             self.basecmd +=3D " --passive-ftp"
=20
--=20
2.45.2.windows.1


