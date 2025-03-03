Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EF3C282C6
	for <webhook@archiver.kernel.org>; Mon,  3 Mar 2025 08:10:33 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web10.48703.1740989426415604669
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 03 Mar 2025 00:10:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=g77YEU2E;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2E33C44327;
	Mon,  3 Mar 2025 08:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740989424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aYimXQgVn4Gg0410vDLGdpQbrVz/j0DBOoCbNm1Dyj8=;
	b=g77YEU2EC7JO1rw6tDJU+VUx0WDGJSCI68IdFQm/HeBw5t2leFY0XnVIWB8/HnLl/eGJW/
	HDDj9lnNvcTaJroqJOvXLFCYMz90dWuYG8+hsrGufo9GmxlNLX1v7eftbsUttNlNMtuZ9C
	VL5hoemRZbR2BXShaPKdHWsxphKLyR7UKBa7UPpa5IVrgPiKkd780KaJvYnFTFFjk+bdMC
	JdkJegl6RCVF4tUhLMj3xcIdWJ0DN/0/ifuWziMUgTPr4hRVscWMPEO9UdBcSp6DRpMYgs
	Z2gExOu//XRTqqKTyL79UtYsPtXgp3rCgX5/sejMn5DG6Xu3TEp3fU3KytfIQA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Mar 2025 09:10:23 +0100
Message-Id: <D86H8RV7JZRF.28W6GBPN0PDI6@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH v2 5/5] doc: document the GitHub Release
 Artifact fetcher and GH_TOKEN
Cc: <docs@lists.yoctoproject.org>, <yocto@pengutronix.de>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: =?utf-8?q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
 <bitbake-devel@lists.openembedded.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250227090853.1632280-1-l.goehrs@pengutronix.de>
 <20250227090853.1632280-6-l.goehrs@pengutronix.de>
In-Reply-To: <20250227090853.1632280-6-l.goehrs@pengutronix.de>
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelkeeiudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpegggfgtfffkufevhffvofhfjgesthhqredtredtjeenucfhrhhomhepfdetnhhtohhnihhnucfiohgurghrugdfuceorghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedvhedtteetheefgfejleeiledvieevleduffejgeeufedujeeufeefjeefveegudenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeejtgehtgemiegruggvmeejleegkeemgedtheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeejtgehtgemiegruggvmeejleegkeemgedtheelpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepgedprhgtphhtthhopehlrdhgohgvhhhrshesphgvnhhguhhtrhhonhhigidruggvpdhrtghpthhtohepsghithgsrghkvgdquggvvhgvlheslhhishhtshdrohhpvghnvghmsggvugguvggurdhorhhgpdhrtghpthhtohepughotghssehlihhsthhsrdiho
 hgtthhophhrohhjvggtthdrohhrghdprhgtphhtthhopeihohgtthhosehpvghnghhuthhrohhnihigrdguvg
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 03 Mar 2025 08:10:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17367

Hi Leonard,

On Thu Feb 27, 2025 at 10:08 AM CET, Leonard G=C3=B6hrs wrote:
> The fetcher is quite niche, as it is only required when working with
> private GitHub repositories (public releases have a stable public downloa=
d
> URL and do not need any authentication).
>
> Hence it is only documented like a niche feature.
>
> Signed-off-by: Leonard G=C3=B6hrs <l.goehrs@pengutronix.de>
> ---
>  .../bitbake-user-manual-fetching.rst                |  2 ++
>  .../bitbake-user-manual-ref-variables.rst           | 13 +++++++++++++
>  2 files changed, 15 insertions(+)
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
> index 858de6347..228443e0b 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -1083,6 +1083,19 @@ overview of their function and contents.
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
> +         GH_TOKEN =3D "github_pat_..."
> +
> +      Alternatively, the token can be specified in :term:`SRC_URI` with =
the ``token``
> +      parameter::
> +
> +         SRC_URI =3D "ghra://github.com...;token=3Dgithub_pat_..."
> +
>     :term:`GITDIR`
>        The directory in which a local copy of a Git repository is stored
>        when it is cloned.

Reviewed-by: Antonin Godard <antonin.godard@bootlin.com>

Thank you for the changes!
Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

