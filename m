Return-Path: <pavel@zhukoff.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC01C433FE
	for <webhook@archiver.kernel.org>; Wed, 25 May 2022 14:43:16 +0000 (UTC)
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 by mx.groups.io with SMTP id smtpd.web09.7582.1653489792630801147
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 25 May 2022 07:43:13 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@zhukoff.net header.s=fm1
 header.b=CvmCjJUQ;
 spf=pass (domain: zhukoff.net, ip: 64.147.123.25,
 mailfrom: pavel@zhukoff.net)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 81D993200936;
	Wed, 25 May 2022 10:43:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 25 May 2022 10:43:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zhukoff.net; h=
	cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1653489789; x=1653576189; bh=JG
	acXPoAOH5/VaAQM56r7BY35AbTVK3U9VsdjHCVsdA=; b=CvmCjJUQH7xtJsIl71
	ycyJMvm5t0EQm5rTvsagE03FCtWA6G4U9ANa0PU9YrvUYhXtmzAi3Ejr7+bFapec
	hRzPEQBufH1kraBGAAJgNTQ4ntqK3fFzSGZY19mwvfDTOqON1MUluW+Eu8E72Vw8
	EuRqoYFWHbKy+ENdx7/UhRz7k733OTSAPt1dHcmYMvysm28ImrMhicDW9zbNQ+b2
	mx+u2cQ9QoVmTvanRp/70BmuohKOY+OOr81NH+VQtcEmq9J7zF/7ucFhYt/L+1Em
	+zL5lUl6O29cIPp5pOQFvNnkRQajx0q8I9pnv2Lq3mUccNFcuQKtaRK8uf2Ez4JY
	GwlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1653489789; x=1653576189; bh=JGacXPoAOH5/V
	aAQM56r7BY35AbTVK3U9VsdjHCVsdA=; b=Um4LEdKxtIx/OE1EYnGQDp0AUD94Q
	XhAenAQ7nYmwtmuzppRmC+aO+AM+d+lm4WCWR07c7rgbakmNgrAdzXa9QKm+8XWx
	BBF9zVH7Iw3B3lepoFSJcJha3FO/0zDwY/4qykbUGRaIbsiMVlCHmgxhnAjocleq
	z8NDZsMQhtUpRGp8eLwugnI3aBYlai4RVQPQb176IkKbOfjIRK40fodzAGqXrh05
	gOSXkz83gCp2XlZM0UAQ3ZT/lKirwIS5q/U4MA+iIb9FWFMYJ1OOnRAf//IAEcUS
	hj9JTYHJee9K0ZBZ2kjuHJrqlzF+AyYJaCAaZLyPoFjQdQu1GAYFdQXDw==
X-ME-Sender: <xms:fECOYgZpfKHLC5p9f5b5E_B_DhZaQi-rQykASjqb1cnqlOhQxB9umg>
    <xme:fECOYrY30tXEO4t5Yv8FCndzBY9yeSdR6aVX-Xd5gPXb_b3pFKTyVhXP5ix0PmxB8
    U-uJHv-LRUTTyG_qdM>
X-ME-Received: 
 <xmr:fECOYq-Utw9R1Ttdmkt3qQZGnS_K_-Z-7C7srgpLbfVXyok1-daPUCNU6U2orw-kK4aTMminRovlrFVXgLhXpvI>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvfedrjeehgdejkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefrrghvvghl
    ucgkhhhukhhovhcuoehprghvvghlseiihhhukhhofhhfrdhnvghtqeenucggtffrrghtth
    gvrhhnpeegieevvdeiieekheekfeeigfdtueejffeugedutdeutdetffdvgfetledtleek
    veenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehprg
    hvvghlseiihhhukhhofhhfrdhnvght
X-ME-Proxy: <xmx:fECOYqr09rjXIPGpznDbhh391kw_dKeyZRB5xKFsBAtBleKO76lR3A>
    <xmx:fECOYrqs8tX972Z7MuX-n-M550YkiyrauTm0jMupY7np182HtcaJdw>
    <xmx:fECOYoRD4SdV1MiKfjlIGtwM6Nf2uE7TN4qQ6KbRBS-_BxRTD3lgPQ>
    <xmx:fUCOYi3XPIfHf2dxT-n7zCYMSEItnnYQC9pnLyUWDNZYor3FBOLV8Q>
Feedback-ID: ib94946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 May 2022 10:43:07 -0400 (EDT)
From: Pavel Zhukov <pavel@zhukoff.net>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
	pavel@zhukoff.net,
	Pavel Zhukov <pavel.zhukov@huawei.com>
Subject: [PATCH v4] Honour BB_FETCH_PREMIRRORONLY option
Date: Wed, 25 May 2022 16:42:45 +0200
Message-Id: <20220525144243.19999-1-pavel@zhukoff.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: 
 <f09538e33bbae7eca1ff6365492f165c2da32b0b.camel@linuxfoundation.org>
References: 
 <f09538e33bbae7eca1ff6365492f165c2da32b0b.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 25 May 2022 14:43:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13713

This should fix [Yocto 13353] and related to [Yocto 13233] as well.
Previously if git repo mirror has been updated in between of two builds
fetcher of the second build didn't try updated mirror but switched to
git clone from upstream instead. This is problem for offline builds.
Fix this to raise MirrorException if BB_FETCH_PREMIRRORONLY has been
specified by the mirror doesn't contain SRC_REV.

Signed-off-by: Pavel Zhukov <pavel.zhukov@huawei.com>
---
 lib/bb/fetch2/__init__.py |  2 ++
 lib/bb/fetch2/git.py      | 16 ++++++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index ac557176..c99cd104 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1745,6 +1745,8 @@ class Fetch(object):
                             done = False
 
                 if premirroronly:
+                    if not done:
+                        raise FetchError("Failed to download premirror {} and BB_FETCH_PREMIRRORONLY has been set to 1.".format(self.d.getVar("PREMIRRORS")))
                     self.d.setVar("BB_NO_NETWORK", "1")
 
                 firsterr = None
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 23f8c0da..bf7c9d26 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -353,10 +353,18 @@ class Git(FetchMethod):
         if ud.shallow and os.path.exists(ud.fullshallow) and self.need_update(ud, d):
             ud.localpath = ud.fullshallow
             return
-        elif os.path.exists(ud.fullmirror) and not os.path.exists(ud.clonedir):
-            bb.utils.mkdirhier(ud.clonedir)
-            runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdir=ud.clonedir)
-
+        elif os.path.exists(ud.fullmirror) and self.need_update(ud, d):
+            if not os.path.exists(ud.clonedir):
+                bb.utils.mkdirhier(ud.clonedir)
+                runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdir=ud.clonedir)
+            else:
+                tmpdir = tempfile.mkdtemp(dir=d.getVar('DL_DIR'))
+                runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdir=tmpdir)
+                fetch_cmd = "LANG=C %s fetch -f --progress %s " % (ud.basecmd, shlex.quote(tmpdir))
+                runfetchcmd(fetch_cmd, d, workdir=ud.clonedir)
+            if self.try_premirror(ud, d) and self.need_update(ud, d):
+                    raise bb.fetch2.FetchError("Premirror doesn't contain revisions {} and "\
+                            "upstream cannot be used due to BB_FETCH_PREMIRRORONLY setting".format(ud.revisions))
         repourl = self._get_repo_url(ud)
 
         # If the repo still doesn't exist, fallback to cloning it
-- 
2.35.1


