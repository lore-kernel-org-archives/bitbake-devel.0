Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161C1C021B8
	for <webhook@archiver.kernel.org>; Tue, 25 Feb 2025 08:29:50 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web10.3717.1740472187696573122
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Feb 2025 00:29:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=msFq+P5m;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 44F894316B;
	Tue, 25 Feb 2025 08:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740472186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dX3kf+KaMcVd0qjpGS56u0t93EZpiJFon7pHBnqPaMI=;
	b=msFq+P5mc7WUc8dMp7a3t/wwWlwet4NQ6tMsbBZn0XnIor4wyU7OpXaeYSzVpSA3ZiK3Sj
	1rDXzw0ZMf3BqBLk0szeWiJCuTRxsBUX0zO9yjf0vmdbSMMkH5VaauOTBfiCQK9R7ecvOL
	Ht/0UGCRj/SOVcVzBxR6wlwlxE/XNWCaNT4dOkD8iFh0ufIp0tHEcZfkQ+NVPzAg8VbNp0
	wl8pYnW4HVMmLCRSOh/HsbBESyAEUREIpkAO6c0zmRYN61HwzWBNtWAUjFvgtcAQDqBFGk
	+TJJkd/Ei7LQeeG9di8e/PGJW7Bju4fFonaXMxpx8dXCC8okuqmNaWu/VZ00nA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Feb 2025 09:29:45 +0100
Message-Id: <D81DWBWUSJD2.3TKLUDD9IMGQ9@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH v1 5/5] doc: document the GitHub Release
 Artifact fetcher and GH_TOKEN
Cc: <docs@lists.yoctoproject.org>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: =?utf-8?q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
 <bitbake-devel@lists.openembedded.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250225070631.2262115-1-l.goehrs@pengutronix.de>
 <20250225070631.2262115-5-l.goehrs@pengutronix.de>
In-Reply-To: <20250225070631.2262115-5-l.goehrs@pengutronix.de>
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekuddvfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpegggfgtfffkufevhffvofhfjgesthhqredtredtjeenucfhrhhomhepfdetnhhtohhnihhnucfiohgurghrugdfuceorghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedvhedtteetheefgfejleeiledvieevleduffejgeeufedujeeufeefjeefveegudenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeejtgehtgemiegruggvmeejleegkeemgedtheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeejtgehtgemiegruggvmeejleegkeemgedtheelpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedprhgtphhtthhopehlrdhgohgvhhhrshesphgvnhhguhhtrhhonhhigidruggvpdhrtghpthhtohepsghithgsrghkvgdquggvvhgvlheslhhishhtshdrohhpvghnvghmsggvugguvggurdhorhhgpdhrtghpthhtohepughotghssehlihhsthhsrdiho
 hgtthhophhrohhjvggtthdrohhrgh
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Feb 2025 08:29:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17309

Hi Leonard,

On Tue Feb 25, 2025 at 8:06 AM CET, Leonard G=C3=B6hrs wrote:
> The fetcher is quite niche, as it is only required when working with
> private GitHub repositories (public releases have a stable public downloa=
d
> URL and do not need any authentication).
>
> Hence it is only documented like a niche feature.
>
> Signed-off-by: Leonard G=C3=B6hrs <l.goehrs@pengutronix.de>
> ---
>  doc/bitbake-user-manual/bitbake-user-manual-fetching.rst  | 2 ++
>  .../bitbake-user-manual-ref-variables.rst                 | 8 ++++++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/d=
oc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> index fb4f0a23d..2f5224482 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> @@ -842,6 +842,8 @@ Fetch submodules also exist for the following:
> =20
>  -  Trees using Git Annex (``gitannex://``)
> =20
> +-  Private GitHub Release Artifacts (``ghra://``)
> +
>  No documentation currently exists for these lesser used fetcher
>  submodules. However, you might find the code helpful and readable.
> =20
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rs=
t b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index ad219b531..258c4035d 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -1078,6 +1078,14 @@ overview of their function and contents.
>        layer containing the recipe file. Code can use this to identify wh=
ich
>        layer a recipe is from.
> =20
> +   :term:`GH_TOKEN`
> +      GitHub Access Token. When using the
> +      :ref:`GitHub Release Artifact fetcher <bitbake-user-manual/bitbake=
-user-manual-fetching:fetchers>`
> +      This variable can be defined to be used by the fetcher to authenti=
cate
> +      and gain access to non-public release artifacts::
> +
> +        GH_TOKEN =3D "github_pat_..."

Nit: we indent code blocks with three spaces.

Should we also mention that the token can be passed a URL parameter? Someth=
ing
like:

"""
Alternatively, the token can be specified in :term:`SRC_URI` with the ``tok=
en``
parameter::

   SRC_URI =3D "ghra://github.com...;token=3Dgithub_pat_..."
"""

Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

