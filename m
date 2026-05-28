Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB3CCD5BD1
	for <webhook@archiver.kernel.org>; Thu, 28 May 2026 10:48:44 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8177.1779965323598404305
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 28 May 2026 03:48:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=oO+ywMKF;
 spf=pass (domain: smile.fr, ip: 209.85.221.54, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45eeba68948so240275f8f.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 28 May 2026 03:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1779965322; x=1780570122; darn=lists.openembedded.org;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubX8ZQOdppf4ZcNFRqnyB+Ru3EXW97q9/QSXp+yavuI=;
        b=oO+ywMKFJUeaep5NFnBSy0LHvv1wTS7e5NJ/pURYAAOwNgbsy6ZQ52eVMIeZ688HoL
         zIDrNm1lZKAS2awYBJro6SSiKgox4vVdrdYWAqpN0CZP1RXoFccoxDzcUMYv7sOEhW6E
         5PSKmPQ1TzxSeX52cEJutoxz98QBoHGBuiC64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779965322; x=1780570122;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ubX8ZQOdppf4ZcNFRqnyB+Ru3EXW97q9/QSXp+yavuI=;
        b=g62LsuNPB0mnxOvAXVq7Xr/oX206bjHSPXL3Kyl8Qht/qFWvbjYQ/r/o+So5x47J5z
         fcGDTDBFFWswsYVcFsXimWm8Yxq+uLcpah3CtdzGuHjIwbvjFZbnH6UdV1H7PEn40NVw
         Y+Bi0VPOnfcjkzdgVs03cyaTpHqxO8WssehUxLUyI0zZpMLxT0J/7UOTHXE54ywf00IU
         IH3qY7OmR6m0EMnNvNuj3GujKEJ5ViHsabMhuEVIvpeqhpV7+7Wx6ICMiui97mtUMB1a
         tAvbQGIzhn8Sz7aZ8anPV0EBhwLAq5mtDhuYyD6K3HBWxpKfrq9E1XNhCD3x51Fkei5e
         5f9w==
X-Forwarded-Encrypted: i=1; AFNElJ8f5dYnnqXbOUIJQnYzhIsmPR82jsw+7aT7fECcWKqcciGj9tOMhrVlqVhOBQp6A+MpnLuUFaOoP5EAINl9@lists.openembedded.org
X-Gm-Message-State: AOJu0Yz0QxiLbth63yIxUOmU6mWOrfqfRJgBy/Gq63JT/or3kBm5CK67
	Y9aKe2yNPS7z2tL0MsElBoxaNiNWx2OjCiw5RNzNd/VCzC8e3UquKOE2E5A2die4CQo6MKgceQb
	+yxa8
X-Gm-Gg: Acq92OEYD0YS0MA5TxIwgy01ogtlMpOXNGpNYFTlm1OKxM45KyfxlnsrcCr2ITaob3f
	Fzo8MIdIIPWDegt2KiljWcq96g1YOgSsDMih+jKbGjQK0zrSGMhL3OjoEYkl6+HUyRvvPiMu2IF
	RwMUZcltXnOtHBqmPs/inUDhma//FBrAlVwiI3T/d5XoOd1ewkNETilhSI5u4FonbcP9HB70ux+
	76Nn1cLKDhhsJTAnGP5+F7NyKR5L0fiMAXxWDN2HJDbMdx82Lz4/3Dn6I+OvenEaZSTDDyMKPG4
	HBaRTQd4qP36y+XetDkomQHgtY8VI7HMbM6yCcOmoGZwdy3JBxr/awyQxPebeM2RINMpdsbLdbx
	lt3+dnsEZqO/EghfM7BJCwYogvqQxyNmTDeA2R7qEKPBIQBgHpsTnEemZ7x+wUY9ugT8WGJO8Kg
	1txKsE4Ud9H5s/uzvltDR8TpYfoC8dsc1HIVVyzOccO3i8tCzBby5cZ9Es8VjENdsZOh8n8QsI+
	fCi/s2fZu9SvHIt2Iz6r4Zg6s1K/QLJprrA
X-Received: by 2002:a05:6000:610:b0:452:c246:ab69 with SMTP id ffacd0b85a97d-45eb36909ecmr48834543f8f.13.1779965321811;
        Thu, 28 May 2026 03:48:41 -0700 (PDT)
Received: from localhost (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5579b8sm12982271f8f.9.2026.05.28.03.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 03:48:41 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 May 2026 12:48:41 +0200
Message-Id: <DIU91O1GOCDV.12EUARBGO3E31@smile.fr>
Subject: Re: [bitbake-devel] [PATCH v2 3/9] bitbake-setup.schema.json: Use
 anyOf for non-disjoint subschemas
From: "Yoann Congal" <yoann.congal@smile.fr>
To: <rob.woolley@windriver.com>, <bitbake-devel@lists.openembedded.org>
X-Mailer: aerc 0.20.0
References: <20260407150250.104135-1-rob.woolley@windriver.com>
 <20260407150250.104135-4-rob.woolley@windriver.com>
In-Reply-To: <20260407150250.104135-4-rob.woolley@windriver.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 28 May 2026 10:48:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19553

On Tue Apr 7, 2026 at 5:02 PM CEST, Rob Woolley via lists.openembedded.org =
wrote:
> The oneOf keyword is for matching exactly one subschema.
>
> However, the 2 possible BitBake configuration fragments
> are not disjoint. Since a simple example with type and
> description would match both. For this reason, we should
> use anyOf instead.
>
> This resolves the following jsonschema linting error:
>   A `oneOf` where all branches have disjoint types can be safely
>   converted to `anyOf` (oneof_to_anyof_disjoint_types)
>
> Signed-off-by: Rob Woolley <rob.woolley@windriver.com>

Reviewed-by: Yoann Congal <yoann.congal@smile.fr>
> ---
>  setup-schema/bitbake-setup.schema.json | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/setup-schema/bitbake-setup.schema.json b/setup-schema/bitbak=
e-setup.schema.json
> index 3324546de..f2e466c9b 100644
> --- a/setup-schema/bitbake-setup.schema.json
> +++ b/setup-schema/bitbake-setup.schema.json
> @@ -92,7 +92,7 @@
>                                  "type": "array",
>                                  "description": "List of BitBake configur=
ation fragments to enable",
>                                  "items": {
> -                                    "oneOf": [
> +                                    "anyOf": [
>                                          {
>                                              "type": "string",
>                                              "description": "Configuratio=
n fragment name"


--=20
Yoann Congal
Smile ECS


