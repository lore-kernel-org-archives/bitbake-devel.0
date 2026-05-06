Return-Path: <joaomarcos.costa@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B167FCD342C
	for <webhook@archiver.kernel.org>; Wed,  6 May 2026 08:46:37 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14051.1778057191521432416
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 May 2026 01:46:32 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bootlin.com header.s=dkim header.b=xcWKJaS7;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: joaomarcos.costa@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 811E1C5DC46
	for <bitbake-devel@lists.openembedded.org>; Wed,  6 May 2026 08:47:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5460A6053C
	for <bitbake-devel@lists.openembedded.org>; Wed,  6 May 2026 08:46:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 62348102F18EA;
	Wed,  6 May 2026 10:46:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778057188; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=969nLSpyOIupSlCJvdfP8Y3U3fcR/zvqYH2M+sQZhcY=;
	b=xcWKJaS79z4rJfe9DcbrVQbKNb4Dxo5O/uXhgGcu5TWvuVMtSOkbPpK728WUk+JvJ7KVNs
	H7DV6ZfBjxLKOhaXKJcHzTnNLXj8MKBgBBF073IzSjfBOpjY/ZPL5SobP7OVh95aqOOKM/
	iImCaIQCT6U6JgwvdnpP+kabtZ5llp7dm77vIPXfZzfDrMRyiMEafdSvHLI/NWHQ3uLvbi
	2cpkKQzDtPpjRzrt5oy9xkrd81YE+x7AIa9ZGHpxWr3GNhVknz2Hx4nivRuiXYDP7J3A4p
	Cho+4B8+Hfz9noTNc+9+F0Hc+ivdjeSBfHfZfs7VqYsH2Kaeks7vLO/xkPXf6g==
From: =?UTF-8?q?Jo=C3=A3o=20Marcos=20Costa?= <joaomarcos.costa@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: thomas.petazzoni@bootlin.com,
	=?UTF-8?q?Jo=C3=A3o=20Marcos=20Costa?= <joaomarcos.costa@bootlin.com>
Subject: [PATCH] layerindexlib: restapi.py: fix unbound variable
Date: Wed,  6 May 2026 10:46:05 +0200
Message-ID: <20260506084605.2345360-1-joaomarcos.costa@bootlin.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Last-TLS-Session-Version: TLSv1.3
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 May 2026 08:46:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19440

If the requested branch(es) is not found, a debugging message is
displayed to list it, so the expected behavior is something like this:

$ bitbake-layers layerindex-fetch meta-firefox
NOTE: Starting bitbake server...
Loading https://layers.openembedded.org/layerindex/api/;branch=3Dwrynose.=
..
ERROR: Remote layer index ['https://layers.openembedded.org/layerindex/']=
 is empty for branches ['wrynose']

However, the variable currently used is unbound, and the error below
comes up:

File "/src/bitbake/lib/layerindexlib/restapi.py", line 216, in load_index=
_web
    logger.debug("No valid branches (%s) found at url %s." % (branch, url=
))
                                                          ^^^^^^
UnboundLocalError: cannot access local variable 'branch' where it is not =
associated with a value

Replace 'branch' by 'branches' to fix this.

Signed-off-by: Jo=C3=A3o Marcos Costa <joaomarcos.costa@bootlin.com>
---
 lib/layerindexlib/restapi.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/layerindexlib/restapi.py b/lib/layerindexlib/restapi.py
index 81d99b02e..65405cb7e 100644
--- a/lib/layerindexlib/restapi.py
+++ b/lib/layerindexlib/restapi.py
@@ -213,7 +213,7 @@ class RestApiPlugin(layerindexlib.plugin.IndexPlugin)=
:
         pindex['branches'] =3D _get_json_response(index.apilinks['branch=
es'] + filter,
                                                     username=3Dup.userna=
me, password=3Dup.password)
         if not pindex['branches']:
-            logger.debug("No valid branches (%s) found at url %s." % (br=
anch, url))
+            logger.debug("No valid branches (%s) found at url %s." % (br=
anches, url))
             return index
         index.add_raw_element("branches", layerindexlib.Branch, pindex['=
branches'])
=20
--=20
2.47.0


