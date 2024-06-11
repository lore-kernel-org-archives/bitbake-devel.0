Return-Path: <egyszeregy@freemail.hu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46202C41513
	for <webhook@archiver.kernel.org>; Tue, 11 Jun 2024 23:07:13 +0000 (UTC)
Received: from smtp-out.freemail.hu (smtp-out.freemail.hu [46.107.16.208])
 by mx.groups.io with SMTP id smtpd.web11.1861.1718147224868143039
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Jun 2024 16:07:05 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@freemail.hu header.s=20181004 header.b=gazu0kjF;
 spf=pass (domain: freemail.hu, ip: 46.107.16.208, mailfrom: egyszeregy@freemail.hu)
Received: from localhost.localdomain (catv-80-98-74-198.catv.fixed.vodafone.hu [80.98.74.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.freemail.hu (Postfix) with ESMTPSA id 4VzPSj4WGJz16M;
	Wed, 12 Jun 2024 01:07:01 +0200 (CEST)
From: egyszeregy@freemail.hu
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	=?UTF-8?q?Benjamin=20Sz=C5=91ke?= <egyszeregy@freemail.hu>
Subject: [PATCH v3] fetch2/wget: Add user_agent parameter so it can be used optionally
Date: Wed, 12 Jun 2024 01:06:49 +0200
Message-ID: <20240611230649.1473-1-egyszeregy@freemail.hu>
X-Mailer: git-send-email 2.45.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1718147222;
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 11 Jun 2024 23:07:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16352

	s=20181004; d=freemail.hu;

	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;

	l=4816; bh=zfRHegVF38ufPjMVJivZbqGVpzjQjOKlpALoiB7N0UE=;

	b=gazu0kjFemdHJHl/KdnUsHHN6JcNUig1mM88ohsgn7ia5CF+SAgtfKCt4ZlkQUdJ

	4mGUEZEekwpVB2ML1ipcgCtlJFstu+/SGMD/y3vV7XuUm+8Fnyh8O3wPB3mL5lqa/Vt

	AEzRCG91/jlQgzF0spvPDGyGUplpB10sAP8FRyr7m2epMNrFg1F1IYZvDV/DyeQgJrx

	vuJsdM+TL861rMoQdt2GkuICzD9TkRnppImLTeRDSa2IsstY46Unv4Tt1bwSvBm4SrY

	PuzWpw091KHGT/6dpzfSww6rpKrQtppkB7QJaXnOFn4Pe53XjBkKgc+fnERwUUfOqAT

	J3YpcaFzZg==
Content-Transfer-Encoding: quoted-printable

From: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>

Add "user_agent" optional parameter for wget fetcher to able
to use it if HTTP servers block requests with the default wget
user-agent.

Signed-off-by: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
---
 conf/bitbake.conf                             |  1 +
 .../bitbake-user-manual-fetching.rst          | 23 +++++++++++++------
 .../bitbake-user-manual-ref-variables.rst     |  5 ++++
 lib/bb/fetch2/wget.py                         | 11 +++++----
 4 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/conf/bitbake.conf b/conf/bitbake.conf
index f5a5a333a..a16f72d25 100644
--- a/conf/bitbake.conf
+++ b/conf/bitbake.conf
@@ -44,3 +44,4 @@ TARGET_ARCH =3D "${BUILD_ARCH}"
 TMPDIR =3D "${TOPDIR}/tmp"
 WORKDIR =3D "${TMPDIR}/work/${PF}"
 GITPKGV =3D "${@bb.fetch2.get_srcrev(d, 'gitpkgv_revision')}"
+BB_FETCH_USER_AGENT ??=3D "bitbake/${BB_VERSION}"
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/d=
oc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index fb4f0a23d..0ee07992f 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -221,13 +221,21 @@ HTTP/FTP wget fetcher (``http://``, ``ftp://``, ``h=
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
+parameters:
+
+-  *downloadfilename:* That allows the name of the downloaded file
+   to be specified.
+
+-  *user_agent:* Enable to use a default ``bitbake/${BB_VERSION}`` user-=
agent
+   which is defined in :term:`BB_FETCH_USER_AGENT`.
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
@@ -239,6 +247,7 @@ Some example URLs are as follows::
    SRC_URI =3D "http://oe.handhelds.org/not_there.aac"
    SRC_URI =3D "ftp://oe.handhelds.org/not_there_as_well.aac"
    SRC_URI =3D "ftp://you@oe.handhelds.org/home/you/secret.plan"
+   SRC_URI =3D "https://oe.handhelds.org/not_there.aac;user_agent=3D1"
=20
 .. note::
=20
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rs=
t b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 899e584f9..3f310bd72 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -699,6 +699,11 @@ overview of their function and contents.
       Within an executing task, this variable holds the hash of the task=
 as
       returned by the currently enabled signature generator.
=20
+   :term:`BB_FETCH_USER_AGENT`
+      Specifies a user-agent string which BitBake uses if "user_agent"
+      parameter is enabled for HTTP/FTP wget fetcher. Default value can
+      be found in ``conf/bitbake.conf``.
+
    :term:`BB_VERBOSE_LOGS`
       Controls how verbose BitBake is during builds. If set, shell scrip=
ts
       echo commands and shell script output appears on standard out
diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 2e9211763..30a56df71 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -52,11 +52,8 @@ class WgetProgressHandler(bb.progress.LineFilterProgre=
ssHandler):
=20
 class Wget(FetchMethod):
     """Class to fetch urls via 'wget'"""
-
-    # CDNs like CloudFlare may do a 'browser integrity test' which can f=
ail
-    # with the standard wget/urllib User-Agent, so pretend to be a moder=
n
-    # browser.
-    user_agent =3D "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:84.0) Gec=
ko/20100101 Firefox/84.0"
+    def init(self, d):
+        self.user_agent =3D d.getVar("BB_FETCH_USER_AGENT")
=20
     def check_certs(self, d):
         """
@@ -89,6 +86,10 @@ class Wget(FetchMethod):
=20
         self.basecmd =3D d.getVar("FETCHCMD_wget") or "/usr/bin/env wget=
 -t 2 -T 30"
=20
+        is_user_agent_enabled =3D ud.parm.get("user_agent","0") =3D=3D "=
1"
+        if is_user_agent_enabled:
+            self.basecmd +=3D f" --user-agent=3D'{self.user_agent}'"
+
         if ud.type =3D=3D 'ftp' or ud.type =3D=3D 'ftps':
             self.basecmd +=3D " --passive-ftp"
=20
--=20
2.45.2.windows.1


