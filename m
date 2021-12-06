Return-Path: <jsbronder@cold-front.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE96C433F5
	for <webhook@archiver.kernel.org>; Mon,  6 Dec 2021 21:24:45 +0000 (UTC)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 by mx.groups.io with SMTP id smtpd.web11.58206.1638825883459256416
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 06 Dec 2021 13:24:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cold-front.org header.s=mesmtp header.b=GPj1sNIg;
 spf=pass (domain: cold-front.org, ip: 66.111.4.26,
 mailfrom: jsbronder@cold-front.org)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 5F5185C0255;
	Mon,  6 Dec 2021 16:24:42 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 06 Dec 2021 16:24:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cold-front.org;
	 h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=mesmtp; bh=vFHCThAbbcf8liK8o2pG8sE
	/tLv8No+PTLTKMxi2qXU=; b=GPj1sNIg9Y2rsA+hMv5CGdN7lQHOZbNbNtoQquV
	bZUi+kgQXP4TZGS8IuwlM1AnoMGutHyz4NjrJg2T8p+QK+vSHxipsnSs0oL+EcmA
	MB3/5SZb7m06CVgnc1KJQjHE2I7T1zMM1r0oo5esgCS+eLevCk0bOsuwyyQOkSIv
	SR+Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:date:from
	:message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=vFHCThAbbcf8liK8o
	2pG8sE/tLv8No+PTLTKMxi2qXU=; b=dTKDcva4wS35loBwjJjJkgifvRr3vEQob
	Q+/EwO+bSLnFiG17J5+HghpZzwQFdjXEHWQTLWeYUPewx4fHURY+i2wkf1ynJUFz
	GkQ41uL/u72ffE9UyceCv9unRkfxx/HEncRydrJGLAH+4ziCHriNy3LfdbFym9W2
	3BkCw8hnohH6MkSAansuWjPo4ctoIOw5ZUrDhHV6Dza2EVWGp/wx8Q36gfd17lWg
	rwcuYKH7Ow7ZDZpY3MbxspKak3oZ0uwkkwJqX6q/wbxt0oeR60ia+weOcaLzzoha
	lHN9goESHj+umIwQ6e1RJF39atND1tC0OtWU7b18zdEF2op0cSAmw==
X-ME-Sender: <xms:mn-uYVZ-jlXj_ivFaoLVK4Nm-hVVoU-1J_ox1lo0P1ZL5cbcmQBwQA>
    <xme:mn-uYcYqa8YD1XxZnbYRn_pJnp-HShbgNjX82tRO-IXVjpGOva6gSv93KmIBWv77g
    6A17e83Maz7BQ-nMw>
X-ME-Received: 
 <xmr:mn-uYX9y990R0aJuM_AhB32cJYOngx0f2Cn_y2Rgpbd82jixLrT6Zx9KM6auMwckpCnmElFvcOBrRao_T1LxumlgRoxQKeqiDdvlTs4NTDwR>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvuddrjeefgddugeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomheplfhushhtihhnuceurhhonhguvghruceojhhssghrohhnuggvrhes
    tgholhguqdhfrhhonhhtrdhorhhgqeenucggtffrrghtthgvrhhnpefgieevfeeugeelvd
    dvveeghfetudfhkeegveeuteehudfgfffffeetueeggeeugeenucffohhmrghinhepkhgv
    rhhnvghlrdhorhhgpdhhrghnughhvghlughsrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhssghrohhnuggvrhestgholhguqdhf
    rhhonhhtrdhorhhg
X-ME-Proxy: <xmx:mn-uYTpGMcf5qHctcnVYr6fVSc1KW-HaZoZqz4kwGOE9z1KOLfdFCg>
    <xmx:mn-uYQrHzlq_jbN83h5UhvX7EjLN7w0yPJuDCPemzWEw6TMSNJTcRw>
    <xmx:mn-uYZRX_BqN9XZ0S07Hq-soPpv_l5DfS3YUVOlJL-fbXVcqIJQehA>
    <xmx:mn-uYdAesY_AN2IH8zcGDNyY0uiiQ1qEHNKBZjyVv2YgYlkQttQr1Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Dec 2021 16:24:41 -0500 (EST)
From: Justin Bronder <jsbronder@cold-front.org>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Justin Bronder <jsbronder@cold-front.org>
Subject: [PATCH] fetch2/wget: add redirectauth parameter
Date: Mon,  6 Dec 2021 16:24:37 -0500
Message-Id: <20211206212437.31332-1-jsbronder@cold-front.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 06 Dec 2021 21:24:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13136

Add a parameter that limits sending Basic authentication in the
Authorization header to only the first host and not any that we're
redirected to.  Ignoring potential security concerns, temporary AWS URLs
will reject any request that includes authentication details in both the
query parameters (from the redirect) and in the Authorization header.

Temporary AWS URLs are now being used for release assets from private
Github repositories.  According to the previous discussion linked below,
they're also in use by bitbucket.

See also:
https://lore.kernel.org/bitbake-devel/CAC9ffDEuZL-k8199bUyN+8frjw6bg-g=vrumxxtvt+RVParQ8Q@mail.gmail.com/

Signed-off-by: Justin Bronder <jsbronder@cold-front.org>
---
 .../bitbake-user-manual-fetching.rst                 |  5 +++++
 lib/bb/fetch2/wget.py                                | 12 +++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index 51ab233a..0fc2d5e6 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -229,6 +229,11 @@ downloaded file is useful for avoiding collisions in
 :term:`DL_DIR` when dealing with multiple files that
 have the same name.
 
+If a username and password are specified in the ``SRC_URI``, a Basic
+Authorization header will be added to each request, including across redirects.
+To instead limit the Authorization header to the first request, add
+"redirectauth=0" to the list of parameters.
+
 Some example URLs are as follows::
 
    SRC_URI = "http://oe.handhelds.org/not_there.aac"
diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index fd9b3049..d48998a9 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -112,7 +112,17 @@ class Wget(FetchMethod):
             fetchcmd += " -O %s" % shlex.quote(localpath)
 
         if ud.user and ud.pswd:
-            fetchcmd += " --user=%s --password=%s --auth-no-challenge" % (ud.user, ud.pswd)
+            fetchcmd += " --auth-no-challenge"
+            if ud.parm.get("redirectauth", "1") == "1":
+                # An undocumented feature of wget is that if the
+                # username/password are specified on the URI, wget will only
+                # send the Authorization header to the first host and not to
+                # any hosts that it is redirected to.  With the increasing
+                # usage of temporary AWS URLs, this difference now matters as
+                # AWS will reject any request that has authentication both in
+                # the query parameters (from the redirect) and in the
+                # Authorization header.
+                fetchcmd += " --user=%s --password=%s" % (ud.user, ud.pswd)
 
         uri = ud.url.split(";")[0]
         if os.path.exists(ud.localpath):
-- 
2.34.1


