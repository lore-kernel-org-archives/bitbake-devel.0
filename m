Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24F8CCF9EE
	for <webhook@archiver.kernel.org>; Wed, 29 Oct 2025 17:26:29 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web01.10784.1761758781193900511
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 Oct 2025 10:26:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=V3ZPVkgr;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4298bada5bdso79962f8f.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 29 Oct 2025 10:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1761758779; x=1762363579; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SKgWePM3N+jmj5izvG4xDXQlpJSs9l6LdOPt/tJOMNo=;
        b=V3ZPVkgrFjDv9EwG0NNS53ELAPwZuQ0ca/kbG5X/yiGK2lJL4JB5YLvVzfA/n1KNZA
         oNRKxmEIdQNajHo8RFXfU/bDHATYhmdWJmqrDR10kpXJXCsYtIhHh5xFAvwVTGRr8Yfs
         QruaiiOTO7zngo3cuU/liQyGJ2J+SkqiGmPz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761758779; x=1762363579;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SKgWePM3N+jmj5izvG4xDXQlpJSs9l6LdOPt/tJOMNo=;
        b=FQty+XxEfBjHUG9IEUMwmjRtTAk0oYOj/RMY7UeTdp0CFqq1TwiCy2K9vWdkS6SISi
         WiQX7zdBChdQFWnPY/pDVDYI6y66ZduFDGD6n5lKGzAXGxZ9rKnGdQOiPQ25y4WkkwWw
         bhd9TL80Ton++xU3af1eiwlxoZmJ3W++AMdpjVdY3/1LkvJy/0UBAJVdwklP5wtJSZhy
         GwHLQzTJ+WipA/EwQk6QLMAe4pxwx0rIe6j3cwuy8i84uoISmzvtnCuAnmfuB9NWcTFt
         3qAtWtYMbu0uWtbcpnfxIQdC9SbMEBvC9J7vxgLznjld0kjmzge/R2V3XBhObzo8G50x
         0GLA==
X-Forwarded-Encrypted: i=1; AJvYcCWiaIFoIKONV+2+VKo2NbTBEbliED/xqt2ueAiWHYfiQWwxy7L8DK49rS42KstwquM6Fv6NSH+7+FSoHuAy@lists.openembedded.org
X-Gm-Message-State: AOJu0YyDhJFYc57wySJ/78gSwacxkUFKbUWJdpF0ONAc2NzTXwlTvW3W
	hVOHGDaAjOWdpKX60a/d1mfaqAC82w+VCpYs7NoEr+KdQYFM/ZpB3wAy5PUZR71b6RE=
X-Gm-Gg: ASbGncs4/30nvVNzd0+tlTB2jVkmpehRnYhrQED0Lf27PKsnCiBdyiQ+W/KjOgcYdeU
	sYaNhttu1VfU5HucfxCzyU2FTQqd2jv49ECOF+C8J62xdz0bvlttOEyD0lDzfS86Dl2nwpgDAM1
	9oCgLJ3cX27tDJZKJwiSb6VrS+u5b1SceDIENPkV1T0cl5OuvfHJNC57xMQS7av+GxbiwE93Rny
	w/sVjLwJzU82063R/lONg4BjvtJi4FivsIPtr7BF4i6jB6OKy6FzQDcyRnyJhSap2j+/7K9Klzo
	4DHciLooEPtDG5rULq5tVrMfkaRzXTU73xXv7UQiK+i0MKde4ObFFXwKuWhSv+l21j+/RaKwK7B
	6G8Fgc1rsJfVYHOrlpY5B2r34igkHSDT4Cl92lT1gExui9XyAchCrA9LKcMrzpwH21Zy2CcOwBS
	rkJkkJx7FXi6EMJoeWvpzoziRRssZB83oIGUlBPrV1mugG4UWPBgtWUe9WoPq75rfe
X-Google-Smtp-Source: AGHT+IF5w/YoF/l4YnOghW3t05bnka4pN6WE7be1pmQOQO0/B1OqzfxBtxbyELav4S3GQ0OrfrmJSA==
X-Received: by 2002:a05:6000:2f86:b0:426:dbef:9abf with SMTP id ffacd0b85a97d-429aef7e610mr3128194f8f.23.1761758779487;
        Wed, 29 Oct 2025 10:26:19 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:20a6:9403:5f14:a9f7? ([2001:8b0:aba:5f3c:20a6:9403:5f14:a9f7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952da645sm26114361f8f.30.2025.10.29.10.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 10:26:18 -0700 (PDT)
Message-ID: <cc2529069117bfeb9b66101c4227dc6ce3f3bb4d.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] parse: add bitbake version check via
 bitbake_min_version keyword
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: alex.kanavin@gmail.com, bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Date: Wed, 29 Oct 2025 17:26:17 +0000
In-Reply-To: <20251027181206.3798705-1-alex.kanavin@gmail.com>
References: <20251027181206.3798705-1-alex.kanavin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 Oct 2025 17:26:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18224

On Mon, 2025-10-27 at 19:12 +0100, Alexander Kanavin via lists.openembedded=
.org wrote:
From: Alexander Kanavin <alex@linutronix.de>

Layers (e.g. openembedded-core) can specify in conf/layer.conf:

bitbake_min_version 2.15.2

and if bitbake has a lesser version it will stop itself, as early
as possible, to avoid hitting cryptic compatibility issues later on,
with this error:

bb.parse.ParseError: ParseError at /home/alex/bitbake-builds/poky-master-po=
ky-distro_poky-machine_qemux86-64/layers/openembedded-core/meta/conf/layer.=
conf:1: Bitbake version 2.15.3 is required and version 2.15.2 is used

Note that sanity.bbclass in oe-core has a similar check, but as
this thread [1] highlighted, compatibility issues can stop bitbake
sooner and the check is never reached, leaving the user with
confusing errors.

[1] https://lists.openembedded.org/g/openembedded-core/topic/115724008

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
=C2=A0bitbake/lib/bb/parse/ast.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 12 +++++++++=
+++
=C2=A0bitbake/lib/bb/parse/parse_py/ConfHandler.py | 10 ++++++++++
=C2=A02 files changed, 22 insertions(+)

Why not just allow a BB_MINVERSION variable in layer.conf which we
check? Do we really need a special new syntax just for this which then
has to be documented?

Cheers,

Richard

