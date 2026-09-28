Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1E8C9833E
	for <webhook@archiver.kernel.org>; Mon, 28 Sep 2026 09:59:17 +0000 (UTC)
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.54060.1790589555125663358
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Sep 2026 02:59:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=NDPwnfij;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=A9epsr9C;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.159, mailfrom: paul@pbarker.dev)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3AB667A00FE;
	Mon, 28 Sep 2026 05:59:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 28 Sep 2026 05:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790589554;
	 x=1790675954; bh=fQPUdaDK92E6WppGRBLRe6sJ9+LOKXg8tdU3WPTbCKs=; b=
	NDPwnfijF9a3rSg1eqj36fWCww6n9Jfy1JxBv4zpwvc3l7ndMYJE4wyN+avVa5qL
	2bhehhR7H35u9ugB64dVelCpJa7hFnB8G9SZnScjj5rDYQMRzXrqfjtH75wn7MnH
	XKUyy+eemzoXRsenoilJnUlRQrc+iLSEEj8U+mPW2MQ9++bzekO3oTOyQZjmWK7S
	VPztEyNHevaOLSB4hlEhBiBJtUAWYOSPV2OSBGrV4C9ckHHdKpPigZkOvTGvL793
	2aMRPSzz0cVgsJy1292wV9w/8RIbHS3cIEDnxyaEtdoJOvTLLPpF2HNZYBieRh0O
	mOijseBOEB2ERLd+bbRVzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790589554; x=1790675954; bh=f
	QPUdaDK92E6WppGRBLRe6sJ9+LOKXg8tdU3WPTbCKs=; b=A9epsr9CxXdShcAdc
	JyABXjkwZIsK+DTdrmI2o0bbC/BY7qF5k1+9q0q9X7K/dDpwIHwrVbdeD2WmbjpD
	EF9w6uQKTNHh2+FBsDq5gKZBq5v8+2YQhDqkO//u26LX/KMkhSGpgktRzm7SZ4tf
	KupM2Y7c6XRwlaBX+AVaskaiuvig9x0biLSTPU85dcIUKhGNAk4Rt1sxtvY8a7sm
	k08AhxE5HmBAYutcQhHZ6P+arYBVn9xU0SI8/qepFrQkJio5QVTQIL2GqPoc6NVS
	dsyx4GNP/qqNF/I7F6jPtdtCSSpKVRUWXgRWSGR0NX//EQ0QXX+AioGBAB/4vA/q
	1MSRg==
X-ME-Sender: <xms:cTq6alM6JhyDKeQG69kI-pA4kfzCXEpCdj5F63weiUAogQaJUHHRnQ>
    <xme:cTq6at8GxevRzyqLr7zycfmcsQYMZfbpf1m8nHNbnamEA6MCrF6bTySqqR_yOPSCY
    DE34AvN77OLda0zXXNeLZxChlr2sD8_3VcEh3FfyqiGARehrGbt9n4o>
X-ME-Received: <xmr:cTq6ah497VJjlvO6PRirDzgJvcL91HUStykOE1Uqo3O_4ovbw_Hqs7j69uZAEiV5W0e89KTSG3W5WO0UGexl33bWeJNsjUaHZQ7m18s>
X-ME-Proxy-Cause: dmFkZTFS3WVCfeiCQ54/0lsY6kXL/YaA6QjmBar5o4CHIqeX6zwgC9ys/HM8srAfXHE/9Y
    NNqePstXzHeRMVorJRBBgPCA+1KSHnI3lIcfEwPB2hz0fh80cGF08OJ5THwgixg0b/AJ0m
    kiigS8dPvR1IoT4DCoJST8TE+Fsxtz7Khkyi++lRO640EViBkqHUEVMw0nmUrSdIkhVEgX
    wwIKxXJfoF2V19c21reUOnoaxFTA2sNTp6BQZ8ruZ71+C5N42stE6TpjaN6IAYus0KXFw4
    1xMKQvR687h+W+nJ8LftHhUqSYBQ0GXy5vi3pxqM2kMWG6nWziRoCTaeG+4WhXUh1FQ4gb
    zqKZ2Q8LSXlHcDE14ryDyXwFyJ5C6sunD2ppdJlFthpMyJcZx+cxAhI3pbNkQVEhqhWtQU
    sUaDFUDUV5gOuGg7BkPv8GSca4b2T9R6BGRjFwBPaPYGpCTANgHAnWi9qVrL55gwFFrHso
    xzYoks743KBgbJ9yIIRcP4mhBBv/DZOYNMK/9iVxoeJAA8kzZEMHiVwZKRCdlcncwiCiz2
    KDx+jdnEsjV6xFQuFpDLjx925qJMgbnTuoM1ucfk5isa0qQWnYAbIBIps77GtfLU6SrlZe
    regI+wtcvAYKqs1uJH13/aZ9MInvkOPLl7A13pvpKtXoj1yrg4Jo5B4Mk+yw
X-ME-Proxy: <xmx:cTq6as1CbvennEvhY0aN2Uptrh33f9lgCFp1_iP3KrKaBFSWj_p79w>
    <xmx:cTq6agAdua4adUfEC2xTONjeU0aVitoq4MkzEhsSF1EKO-gU1hh78g>
    <xmx:cTq6am1Edw5HZr9maDW6GwQBzN9MHNOWcAbY8CWI4QU4h3dk9b7XNQ>
    <xmx:cTq6aivDUsZPmyZS2XA0fMhquSm0SikrNXB4KGLWctlLJxNJKuReLQ>
    <xmx:cjq6atkQH_a9PoOz5mws5436NDXv03-qGL9lNvJq8RjiLatKkKd15U2G>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 05:59:13 -0400 (EDT)
Message-ID: <8af7260e8e2d80ff6c597c0598e37b2a01c97dea.camel@pbarker.dev>
Subject: Re: [PATCH] fetch/wget: Reuse the checkstatus() urllib opener
From: Paul Barker <paul@pbarker.dev>
To: ecordonnier@snap.com, bitbake-devel@lists.openembedded.org
Date: Mon, 28 Sep 2026 10:59:12 +0100
In-Reply-To: <20260923170846.1360600-1-ecordonnier@snap.com>
References: <20260923170846.1360600-1-ecordonnier@snap.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 28 Sep 2026 09:59:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20268

On Wed, 2026-09-23 at 19:08 +0200, ecordonnier@snap.com wrote:
> From: Etienne Cordonnier <ecordonnier@snap.com>
>=20
> checkstatus() builds a new urllib opener with its redirect, proxy and
> connection cache handlers on every call, although sstate.bbclass calls it
> for every object in an sstate mirror check with the same settings. Keep
> the opener on the FetchConnectionCache, keyed on the certificate checking
> setting and the fetcher environment, and rebuild it only when those
> change. The handlers now refer to the connection cache directly rather
> than through the first Fetch object, so a cached opener does not keep it
> alive. A connection cache is only used by one thread at a time, so no
> locking is needed.
>=20
> Checking 2,114 objects on the Yocto sstate mirror with BB_NUMBER_THREADS =
=3D "8"
> reduced the time to task execution from 26.9s to 25.1s on average.
>=20
> AI-Generated: Uses Claude Code (Claude Opus 5.5)
> Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
> ---
>  lib/bb/fetch/__init__.py |  2 ++
>  lib/bb/fetch/wget.py     | 45 ++++++++++++++++++++++++----------------
>  2 files changed, 29 insertions(+), 18 deletions(-)
>=20
> diff --git a/lib/bb/fetch/__init__.py b/lib/bb/fetch/__init__.py
> index 55ab710f3..0eb660685 100644
> --- a/lib/bb/fetch/__init__.py
> +++ b/lib/bb/fetch/__init__.py
> @@ -2090,6 +2090,8 @@ class FetchConnectionCache(object):
>      """
>      def __init__(self):
>          self.cache =3D {}
> +        # urllib openers built by the wget fetcher, see Wget.checkstatus=
()
> +        self.opener_cache =3D {}
> =20
>      def get_connection_name(self, host, port, connection_id=3DNone):
>          if connection_id is None:
> diff --git a/lib/bb/fetch/wget.py b/lib/bb/fetch/wget.py
> index 972c84048..9cb4a4f32 100644
> --- a/lib/bb/fetch/wget.py
> +++ b/lib/bb/fetch/wget.py
> @@ -178,23 +178,24 @@ class Wget(FetchMethod):
>      def checkstatus(self, fetch, ud, d, try_again=3DTrue):
>          check_certs =3D self.check_certs(d)
>          newenv =3D bb.fetch.get_fetcher_environment(d)
> +        connection_cache =3D fetch.connection_cache

Hi,

Is this refactoring a necessary part of the urllib opener caching? If
not it would be better to move it to a separate commit so that this
patch is easier to understand.

Best regards,

--=20
Paul Barker


