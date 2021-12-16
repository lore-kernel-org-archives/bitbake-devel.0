Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC88C433F5
	for <webhook@archiver.kernel.org>; Thu, 16 Dec 2021 17:32:38 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net
 [217.70.183.195])
 by mx.groups.io with SMTP id smtpd.web09.13599.1639675957262148169
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Dec 2021 09:32:37 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=none, err=permanent DNS error (domain: 0leil.net, ip: 217.70.183.195,
 mailfrom: foss+yocto@0leil.net)
Received: (Authenticated sender: foss@0leil.net)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 1FD3D6000D;
	Thu, 16 Dec 2021 17:32:33 +0000 (UTC)
Date: Thu, 16 Dec 2021 18:32:31 +0100
From: Quentin Schulz <foss+yocto@0leil.net>
To: docs@lists.yoctoproject.org,
 Michael Opdenacker <michael.opdenacker@bootlin.com>,
 bitbake-devel@lists.openembedded.org
Subject: =?US-ASCII?Q?Re=3A_=5Bdocs=5D_=5BPATCH_v2=5D_doc?=
 =?US-ASCII?Q?=3A_bitbake-user-manual=3A_exp?=
 =?US-ASCII?Q?and_BB=5FHASHSERVE_and_document_BB=5FHASHSERVE=5FUPSTREAM?=
In-Reply-To: <20211216095204.2016867-1-michael.opdenacker@bootlin.com>
References: <16C0F955FEA53DE5.26558@lists.yoctoproject.org>
 <20211216095204.2016867-1-michael.opdenacker@bootlin.com>
Message-ID: <4F7DB4A6-D4E6-4849-9DB9-6B24C21E1459@0leil.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 16 Dec 2021 17:32:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13187

Hi Michael,

On December 16, 2021 10:52:04 AM GMT+01:00, Michael Opdenacker <michael=2E=
opdenacker@bootlin=2Ecom> wrote:
>Signed-off-by: Michael Opdenacker <michael=2Eopdenacker@bootlin=2Ecom>
>---
> =2E=2E=2E/bitbake-user-manual-ref-variables=2Erst     | 23 +++++++++++++=
++++--
> 1 file changed, 21 insertions(+), 2 deletions(-)
>
>diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables=2E=
rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables=2Erst
>index bb996e84=2E=2Efdcd08d8 100644
>--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables=2Erst
>+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables=2Erst
>@@ -374,12 +374,31 @@ overview of their function and contents=2E
>       Specifies the Hash Equivalence server to use=2E
>=20
>       If set to ``auto``, BitBake automatically starts its own server
>-      over a UNIX domain socket=2E
>+      over a UNIX domain socket=2E An option is to connect this server
>+      to an upstream one, by setting :term:`BB_HASHSERVE_UPSTREAM`=2E
>=20
>-      If set to ``host:port``, BitBake will use a remote server on the
>+      If set to ``unix://path``, BitBake will connect to an existing a

s/a//

>+      hash server available over a UNIX domain socket=2E
>+
>+      If set to ``host:port``, BitBake will connect to a remote server o=
n the
>       specified host=2E This allows multiple clients to share the same
>       hash equivalence data=2E
>=20
>+      This last kind of server can be started manually through

s/This last kind of server/The remote server/

>+      the ``bin/bitbake-hashserv`` script provided by BitBake,
>+      which supports UNIX domain sockets too=2E
>+
>+   :term:`BB_HASHSERVE_UPSTREAM`
>+      Specifies an upstream Hash Equivalence server=2E
>+
>+      This optional setting is only useful when a local Hash Equivalence
>+      server is started (setting :term:`BB_HASHSERVE` to ``auto``),
>+      and you wish the local server to query an upstream server for
>+      Hash Equivalence data=2E
>+
>+      Example usage::

Do we not need a newline after the ::?

>+         BB_HASHSERVE_UPSTREAM =3D "typhoon=2Eyocto=2Eio:8687"
>+

Is this the address of an actual hashserver? Is this supposed to be used? =
Is it able to handle many requests? Basically asking if we should have a re=
al hashserver here?

Cheers,
Quentin

