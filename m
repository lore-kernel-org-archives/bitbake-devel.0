Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED65EC43458
	for <webhook@archiver.kernel.org>; Thu,  2 Jul 2026 17:29:49 +0000 (UTC)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.74717.1783013384771363369
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 02 Jul 2026 10:29:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=qSoc2Vsh;
 spf=pass (domain: gmail.com, ip: 209.85.219.46, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8f23e851626so17301496d6.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 02 Jul 2026 10:29:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783013384; cv=none;
        d=google.com; s=arc-20260327;
        b=nLUh1y0zjrMjN/V1blG/VRYdhCuJokc/AJZsRjYL+5/D8PmcTkbWN/R1lJ4U9y0UMK
         IMTVfGsMgfdhL+Ax60Ohxm3KewA0QpH+Hq4vtAmIZNcfOWUTjpPQEekekTsny2GT7H8v
         nJLjv94ukgodb+8FB2aVO7hIzyiX2TbD78WuCdlG7jKDBaqLjM64vWxxjuHTgpFLiy51
         6S8oPVyVVfy6iSRgCJQ2P/IDBobkUylNcOSF/XmwgcQRUmyh+MR9hJiek5FvnL1j8bEx
         5eOUdh2K4VkFFTjDeEbvxsavCJ/DFQYRW71y+an6FeDO07dgOEkJlv7FfGrnw4nlW+PI
         MfNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ErKCOxbj9tBWCfsdmlbm02mtxRSN5PQBR22ABWcXpRU=;
        fh=cEZwQmRD5QCvvS/ITJgi2zXY9cGcfoQhcZanEtMKQAs=;
        b=J/7wTmd48NXhlp3PtCBW7LPdinP34jrghUGUKeLXnrQVcHOkX8hYHhBTiutjo3Uz7r
         rl0GwtNK7YJ+l//OgrxWD9y9kYTrHyGElwkpb841x4hD0xRiBaUSS1FcxT+Dp84ns7pr
         kdeeYNnyyoan9Uzgij1R07P9f98++LWUcUaapSwxkAPFCHRboiorqXCsA+BmQIT/c6qA
         7U3yNllfMVB7bjRvWPrk67BnuElfFY0QYw8JBCCCM/s4NvgftvMWe/OSy+lrNS3hgbgf
         eUARLzHYZSHDNt7s+eBfgIISiwNmuiU3HnPOGBxdRONrXvg37/Mp37GFHUQ50VLyYxOm
         HPlw==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783013384; x=1783618184; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ErKCOxbj9tBWCfsdmlbm02mtxRSN5PQBR22ABWcXpRU=;
        b=qSoc2Vshew3qjzXVNwjZvRNE+LGAcLgD28PkM1Oo3roD/kLvHioK8Y6s+o/EHJh2uv
         FCEonYfTgwJMTOcgu8ebc/driqeToF2mAfa3sBgqjddh7RoF754u2rRRLFCGwSZP971W
         YKGrKb3+ch5tAStpTo3HlA3bRFQne/CMGSlniiIRNQSji7EmV21bqG16j5WXrQp4NuJW
         JOXLDL2QYMbGYnSPXxNt49JDyUHYTZLLJ5DBnjWnBwPKHVW2ta//EaQ3dB5yTPNceCGj
         B4xD0Eez90vR9xNUUkLMauE2qaC2p8iA3SSfLLE0PHjac79Z4hrObZmbQj/cCBwGVXuj
         9mmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783013384; x=1783618184;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ErKCOxbj9tBWCfsdmlbm02mtxRSN5PQBR22ABWcXpRU=;
        b=eWCAdda8BqFs2fvhSkbzBVia8su9qPYN9Z7ZsTX+jSmBzvb0Rn+ETrqudjK/0ykopN
         CwnJ9icXrulN+bCHw0vX6SjF6K7FSaG22Jm/lPQfUlDmzo+DEVao/irbTyGFwM4KnTak
         kD03d0dkrRvPvDALyRCBRVQsCYbDdIslvCWSGr0+kNh0QKJ9KbOS2mOenxA1Q8wJvLQ6
         QVyfwc+oEHNxw/7BOUDvLtnRGUYb7kgEBQEzYhl3CvQZUASdFefMoFPQjltfEVhmENBu
         91whwL+3azidwgTmP4M9XGHMSt+QBhK5hF/x2l3cvgjEkdhC2yK/o320HUU1tmyrzLn/
         6ASQ==
X-Gm-Message-State: AOJu0Yy0HiRzuzux7Px6FMzo7odx7Xli6A077s0WGe8/bJMF1M9Vagu1
	yAVedvsVu6ELEV8jIgEd/+aIDv5nh/RhzhRaezojmQL9HaQnucNHksmiiCdi6FnpCSqZnU/q6YV
	cibt/+TqNfl2Vd63THUgKsssmIpsxiLc=
X-Gm-Gg: AfdE7cn5ExxCUhqxKUTG8aqGupcq9b7qyQHNIGTDT2hmk6UiJYt5NFg1HPH6CzRwgbm
	UkoAeGPTQX/QVqE+p2jyf3kZgk8Y8akegO5QQ278F4k2u5OY5+6tSTxkT2qhIft7vXX3Y8yqkTt
	pUHOtF7WpctBylY2oew76puRY6d48krRXgrpFXdZRDn5OAKM6R1NEPb6zr/U/6GT561dGIcNXte
	MaI+CTl2/IppYQUMxhEQeKDzNycdX+zNkMRhEs0g5vSVPAL8fSylRDcHtcgeGfgbSO6zpyY5fqW
	NXfwkkK0dw/Fw/7i26GvixJX9Q+3
X-Received: by 2002:a0c:c351:0:b0:8dc:40bc:b593 with SMTP id
 6a1803df08f44-8f3c70b6576mr74172176d6.10.1783013383414; Thu, 02 Jul 2026
 10:29:43 -0700 (PDT)
MIME-Version: 1.0
References: <CANDCFSwD88aPfsKDqZE_SdybCn5xYBF1VpRqgwmhTEuJK=eLcQ@mail.gmail.com>
In-Reply-To: <CANDCFSwD88aPfsKDqZE_SdybCn5xYBF1VpRqgwmhTEuJK=eLcQ@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 2 Jul 2026 19:29:31 +0200
X-Gm-Features: AVVi8CfobjzB0nzq3UqrK-97V0qX_Lmxg3Cyxse49YykMsk-5EQZoZJ5zGRH39Y
Message-ID: <CANNYZj86QwsETbi-Lq8r_8BX4UnadF+02jNrJ1BVT2cw785Rjg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: support --update-bb-conf
 on init and fix site.conf symlink for setup-dir == top-dir
To: dchvs11@gmail.com
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>, Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 02 Jul 2026 17:29:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19815

On Thu, 2 Jul 2026 at 16:23, Daniel via lists.openembedded.org
<dchvs11=gmail.com@lists.openembedded.org> wrote:
>   Two fixes that work together to let "bitbake-setup init" preserve an
>   existing bitbake build configuration (local.conf, bblayers.conf):
>
>   1. Expose the existing update_bb_conf parameter through a new
>      --update-bb-conf CLI flag on init, matching the semantics of
>      "bitbake-setup update". This lets downstream projects re-run init
>      (e.g. to refresh layers via --source-overrides) without losing
>      their tracked conf files. The default remains "yes" for backward
>      compatibility, so a fresh init is unaffected.

'Init' is explicitly meant for initializing a new setup, not for
operating on something that was already initialized before. There's
even code to check for it:

    if os.path.exists(os.path.join(setupdir, "layers")):
        logger.info(f"Setup already initialized in:\n
{setupdir}\nUse 'bitbake-setup status' to check if it needs to be
updated, or 'bitbake-setup update' to perform the update.\nIf you
would like to start over and re-initialize in this directory, remove
it, and run 'bitbake-setup init' again.")
        return

So I think such after-the-fact tweaks should be in 'update'.

>   2. Fix the site.conf symlink target when the setup directory is the
>      same as the top directory. The target was always computed as
>      setupdir/../site.conf, which only matches the actual site.conf
>      location (top_dir/site.conf) when the setup directory is exactly
>      one level below the top directory. When --setup-dir-name is given
>      an absolute path equal to the top directory, the symlink ends up
>      broken, which causes "diff -uNr" to fail with exit code 2 inside
>      setup_bitbake_build(). That exception is raised before the
>      update_bb_conf == 'no' branch can restore the original conf,
>      defeating the new flag from #1. Prefer setupdir/site.conf when it
>      exists, falling back to the previous behaviour otherwise.

Setup directory is as well meant to be exactly one level under the top
directory, not the same as the top directory or somewhere else
entirely. We probably should add more guards and useful messages when
that is not the case, but we shouldn't try to support that.

Apologies if this answer is not what you expected, but perhaps you can
describe the use case first?

Alex

