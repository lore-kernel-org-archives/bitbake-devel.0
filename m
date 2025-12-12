Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FACD49201
	for <webhook@archiver.kernel.org>; Fri, 12 Dec 2025 11:30:24 +0000 (UTC)
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10775.1765539019144662468
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Dec 2025 03:30:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=VJsiR1ZN;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=rHodYU9z;
 spf=pass (domain: pbarker.dev, ip: 103.168.172.145, mailfrom: paul@pbarker.dev)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 4D117EC04C1;
	Fri, 12 Dec 2025 06:30:18 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 12 Dec 2025 06:30:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765539018; x=1765625418; bh=Uz+9cxFCgd
	eqiPcb1wvKVXa9iAB5xlrro+9U//b2OeE=; b=VJsiR1ZNy5leFAP4dxhgzkecKs
	dhjRGPe50GRXUz0Du2RsgdZAq0AimVwbP/yZ758CRLjCBd3ir1pNUl6kP2zso8SO
	K4mM4E0hQdOmSq+rvJd9qIMSF7Q0gx/mR9lRA/JzIwyeqObZD+78NbWA2sfPVpo/
	9x96ORnd2NoM/xcXpILJes1muZCLQtYLYXrkZ3i1jpY0CUI3buX0dycuHPk7WFdn
	SeruC8FrY+RS6Yq+YHBN11J1uQI2+5wJG/YP85/q/jLWHQsLzSpGnFzPwJHPFkTy
	oDVfA02Q77monPc1td1IbpcpYTznX8MRhb3RpZHxa8MkjFLbdOlCRG5MOoZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765539018; x=1765625418; bh=Uz+9cxFCgdeqiPcb1wvKVXa9iAB5xlrro+9
	U//b2OeE=; b=rHodYU9zQALzrwOLPVy05bY0gDT9Xj00JuRUsdZjOkoCM0cfYcT
	m9I+Cia4wbqUGTwQn6W0W5CSy5Mr9XyXrlvX2M8pB5BEMlbpaiGqog/35vr1DXIT
	1PCMQDeLQ9dBazwBAYBTVSnO9eO6sCGZsRI4B2vpS3TJQQUEEggO10jYozXNMorK
	Np4hKNUoP4y6RuKHasiBmYPr/Zqn85Tka/tnaB+8ii/TLhlcj7sxzjjm9L598BGe
	qRulnQQexj6OCEhYouvn213MZ/WP7jjmBRsLDu7eZEwPSm/zvw/8bqTydh3isJ4l
	Ure7BSaF9xkE/+NvXB9E5+fTv3Z9eDbYunw==
X-ME-Sender: <xms:yvw7aQ2faqVZrQe4Ym9OMF_dQoL5DIGW_hsUZCw8kLlhuDr6FYQ8Jw>
    <xme:yvw7aSheGdFD8ggh0PjADtD1_DlvAWLqReVzrOS01a4wbRdxHJBI0WoKh4ua-h6ih
    v9kJCy2CnmuZzMB_Jj6U-e_hwdu08IBPvbPY8-8-fL9jImsPGpQSw>
X-ME-Received: <xmr:yvw7aWQPw4P4zqZiDGCudAcDsYEoYlpXNmi_7GldOk_HXdzB06Hm6YuYNuGZKbY7521yLo_2n6HgrsDn_Rn1fvSlpsV5jr-Xu-lmFvsAfaI1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkuffhvfevffgjfhgtfgggsehgtderredtreejnecuhfhrohhmpefrrghulhcuuegr
    rhhkvghruceophgruhhlsehpsggrrhhkvghrrdguvghvqeenucggtffrrghtthgvrhhnpe
    efffdvfeegveekudfhteeuhefhieekvdeiueefveeiffeukedtledutdfggeevheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehprghulhesph
    gsrghrkhgvrhdruggvvhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheprghlvgigrdhkrghnrghvihhnsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepsghithgsrghkvgdquggvvhgvlheslhhishhtshdrohhpvghnvghmsggvugguvggu
    rdhorhhgpdhrtghpthhtoheprghlvgigsehlihhnuhhtrhhonhhigidruggv
X-ME-Proxy: <xmx:yvw7aTjp2yqZPYE2DNtp7I6d6FbClvLb31BRSk3Cey7G8oyhwK2Htw>
    <xmx:yvw7aW4YLM162mO6dki1Sw1hZIWo0LQzv7ZIuuk7p6eiLzSOH-7vOg>
    <xmx:yvw7aQC8su2wg_l-tLd8f_oQTLKFpSojcOageQHlAPoKhN_ue2Yulw>
    <xmx:yvw7adYV1YfTbwzg6o-AQDQ3mVwNXIV2SGrG0D_poHnAmu0W82UMIg>
    <xmx:yvw7afXb9CHuR39lfWF_wOY0x_QYpUuBMRpxSx0gIFLZyFBoinHJjgtm>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Dec 2025 06:30:17 -0500 (EST)
Message-ID: <0a4abf6d3dc39a15d3a901842446fc38c7c17d31.camel@pbarker.dev>
Subject: Re: [PATCH 1/4] setup-schema/layers.schema.json: correct indentation
From: Paul Barker <paul@pbarker.dev>
To: Alexander Kanavin <alex.kanavin@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Date: Fri, 12 Dec 2025 11:30:15 +0000
In-Reply-To: <20251211142532.983960-1-alex.kanavin@gmail.com>
References: <20251211142532.983960-1-alex.kanavin@gmail.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 ep0k17xg==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-m/F/CUiYePdBI+iQ2hv6"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Dec 2025 11:30:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18574


--=-m/F/CUiYePdBI+iQ2hv6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-12-11 at 15:25 +0100, Alexander Kanavin wrote:
> From: Alexander Kanavin <alex@linutronix.de>
>=20
> Shift one of the inner blocks 8 spaces to the left, so that
> everything is indented by 4 spaces.
>=20
> Signed-off-by: Alexander Kanavin <alex@linutronix.de>
> ---
>  setup-schema/layers.schema.json | 72 ++++++++++++++++-----------------
>  1 file changed, 36 insertions(+), 36 deletions(-)
>=20
> diff --git a/setup-schema/layers.schema.json b/setup-schema/layers.schema=
.json
> index 144ea6d9f..9a0b4ed61 100644
> --- a/setup-schema/layers.schema.json
> +++ b/setup-schema/layers.schema.json
> @@ -27,44 +27,44 @@
>                          "type": "boolean"
>                      },
>                      "git-remote": {
> -                                "description": "A remote git source from=
 which to fetch",
> +                        "description": "A remote git source from which t=
o fetch",
> +                        "type": "object",
> +                        "additionalProperties": false,
> +                        "required": [
> +                            "rev"
> +                        ],
> +                        "properties": {
> +                            "branch": {
> +                                "description": "The git branch to fetch =
(optional)",
> +                                "type": "string"
> +                            },
> +                            "rev": {
> +                                "description": "The git revision to chec=
kout",
> +                                "type": "string"
> +                            },
> +                            "describe": {
> +                                "description": "The output of 'git descr=
ibe' (human readable description of the revision using tags in revision his=
tory).",
> +                                "type": "string"
> +                            },
> +                            "remotes": {
> +                                "description": "The dict of git remotes =
to add to this repository",
>                                  "type": "object",
> -                                "additionalProperties": false,
> -                                "required": [
> -                                    "rev"
> -                                ],
> -                                "properties": {
> -                                    "branch": {
> -                                        "description": "The git branch t=
o fetch (optional)",
> -                                        "type": "string"
> -                                    },
> -                                    "rev": {
> -                                        "description": "The git revision=
 to checkout",
> -                                        "type": "string"
> -                                    },
> -                                    "describe": {
> -                                        "description": "The output of 'g=
it describe' (human readable description of the revision using tags in revi=
sion history).",
> -                                        "type": "string"
> -                                    },
> -                                    "remotes": {
> -                                        "description": "The dict of git =
remotes to add to this repository",
> -                                        "type": "object",
> -                                        "patternProperties": { ".*" : {
> -                                            "description": "A git remote=
",
> -                                            "type": "object",
> -                                            "addtionalProperties": false=
,
> -                                            "required": [
> -                                                "uri"
> -                                            ],
> -                                            "properties": {
> -                                                "uri": {
> -                                                    "description": "The =
URI for the remote, using git URL syntax",
> -                                                    "type": "string"
> -                                                }
> -                                            }
> -                                        }}
> +                                "patternProperties": { ".*" : {
> +                                    "description": "A git remote",
> +                                    "type": "object",
> +                                    "addtionalProperties": false,
> +                                    "required": [
> +                                        "uri"
> +                                    ],
> +                                    "properties": {
> +                                        "uri": {
> +                                            "description": "The URI for =
the remote, using git URL syntax",
> +                                            "type": "string"
> +                                        }
>                                      }
> -                                }
> +                                }}
> +                            }
> +                        }
>                      }
>                  }
>              }

Reviewed-by: Paul Barker <paul@pbarker.dev>

Best regards,

--=20
Paul Barker



--=-m/F/CUiYePdBI+iQ2hv6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCaTv8xxEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bi4BAQDptPXxYwO9AF+/Nc2AmrVnT3+tQQQcgL4+
kbQLTtSHOgD/dYYrvZqzREj/MQt+0fbQgGPJ/kzEWoGIxJ9cwlfAVAk=
=+Y7L
-----END PGP SIGNATURE-----

--=-m/F/CUiYePdBI+iQ2hv6--

