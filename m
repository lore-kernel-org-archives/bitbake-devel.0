Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC53CA5FA1
	for <webhook@archiver.kernel.org>; Tue, 29 Sep 2026 11:03:05 +0000 (UTC)
Received: from mail-ej2-f42.google.com (mail-ej2-f42.google.com [74.125.228.170])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4981.1790679781999056168
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Sep 2026 04:03:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=OR+zdOaZ;
 spf=pass (domain: linuxfoundation.org, ip: 74.125.228.170, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-ej2-f42.google.com with SMTP id a640c23a62f3a-c2b40e4744eso401439366b.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 29 Sep 2026 04:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1790679780; x=1791284580; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=N4NUMQ/UVS/C0PzkjLaE1icXuPA6JaWBGvzg1Ei5iW8=;
        b=OR+zdOaZqnc7EFsqjPRYr2OlrcKvPatjUKYbsSmBgYux+wqVncVEnjE4oAC8xob4Bg
         OOrDiE6bO9KGBisYABNJfEfvqg1vetoUQ0eL+HCqdASErxGde2+N0RgD3Kg4pnZxiibh
         f+fSqYF05BW1ikBqRr67wOlnPUWk01iFDgxtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790679780; x=1791284580;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N4NUMQ/UVS/C0PzkjLaE1icXuPA6JaWBGvzg1Ei5iW8=;
        b=veQlQrJjq84nbIgy4/s5+3YTrp2NbQ2ZFvLgDF4tO7Ij2/B9wZuAgFspC9YpiRnVeR
         EHpAiNsN06wYWzGSExg4DZ35gKp+tRqJcNcEyLSG2ab+/UOkDNguLsUGmA65l/GUJrjq
         Antjnssyed17EjpDacrCWWj9LagrlmldfBYo/R1MvogDCmWp5yI4bZTsLzNTUadOzyvi
         rl6b2WAx9qPe9YEc6z1+wi5yyQdvDcmv782PWpKKa5Vkwx6COVvl+nv7srkuQsIMHMbl
         xavlzV1tNRI0U/TgrmVHWogpnCR72AUjIoM97ZTRslvySmnplPF82xXYmnD4Eds/Fs2f
         rn0A==
X-Forwarded-Encrypted: i=1; AKwUvBz1+WrVpJbUFYxLZ89rwZrx3hx65X5Z3RAXC3dr2orevFj56ShHCLyYDihLGpkETXZ2PSvOFEoRcwH0uox9@lists.openembedded.org
X-Gm-Message-State: AFuF++lBUMuywcpm1TuqP9Tu9ZDPLIy+X/VM+/cpRoTk63lZ2qpZn4Xa
	IVggXshCfdwJCYzW82yk37ggy3jqCZq4KA2te/M2+RYxhOmrMky3cZ0bq4eHLcUoloA=
X-Gm-Gg: AYBFou2N8KslxZb4sd6lrQG8MLji2GT7QJCleNbTzNqOdNRv+MbZyQ38QX94VVhAhqR
	cWcbu7F0+ZArteIgezgozMDydLseBWSNyckPDUavWL2bD22ZGdfJ/ZhrJp85HxLuw4CqgG2ofpu
	pfJBiVnG14e1POkACdLWYruaUoqJMGUZrKZ9Nq9MDQHW6/+W2yX/x9zvt398SRfPQ3F4L0y+dbq
	QDd1u9pZ4ay8IQy9Xs3azfytQwK66KZ9v1TLiXtiRv9uXdgpKZ1mStBtgNqeKeKwwksGmmincCw
	Q2sqtfIII9EutVr/4KrI2hTWSm9ZfrWmYbdlLcUhTV4rV3yQ+C9+ArWD+sXKCbiAwl0S9lROF/g
	4H2VBxk7XAmKEEXlstGLoI/eKjRNBdoao6Ua53Qi4yMlgcAAcmiRZ3OMsJH3CNDlxRdsYekxtIJ
	CyCV7mlte9AJ1TttzW35ZU48nRIVarmd6e9XF+0B4DB73ojwkzHQmSqkNwAzOzdp7qcFf8L1djv
	2UHM/CJnPjgLF+4cZMNgct6yeJwZwkXHkUyAMiRe07tBVXjHhwgTeu5aim8
X-Received: by 2002:a17:907:c609:10b0:c2a:cf73:63fe with SMTP id a640c23a62f3a-c2acf7369d6mr828662566b.6.1790679780212;
        Tue, 29 Sep 2026 04:03:00 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:c2fb:8115:9b9:553a? ([2001:8b0:aba:5f3c:c2fb:8115:9b9:553a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dc0db75a0sm418094066b.48.2026.09.29.04.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 04:02:59 -0700 (PDT)
Message-ID: <1fe7b763a6e1731dc80fa311f9fe4463a21c35fa.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] cache: Reuse os.path.exists() results
 during dependency validation
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: ecordonnier@snap.com, bitbake-devel@lists.openembedded.org
Date: Tue, 29 Sep 2026 12:02:58 +0100
In-Reply-To: <20260923170633.1313487-1-ecordonnier@snap.com>
References: <20260923170633.1313487-1-ecordonnier@snap.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 29 Sep 2026 11:03:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20279

On Wed, 2026-09-23 at 19:06 +0200, Etienne Cordonnier via lists.openembedde=
d.org wrote:
> From: Etienne Cordonnier <ecordonnier@snap.com>
>=20
> cacheValidUpdate() checks each recipe's file_checksums entries with
> os.path.exists(). Many recipes reference the same optional class or
> checksum candidate paths, so the same path is checked repeatedly within
> one validation pass. In a warm parse of 5,112 recipes (poky, meta-yocto,
> meta-oe, meta-python), the real cache data shows 585,348 such calls
> against only 48,757 unique paths, with the hottest path checked 16,894
> times: 536,591 calls are redundant. At 3.5us per os.path.exists() call on
> a nonexistent path on this machine, that is about 1.9s of avoidable
> syscall time per validation pass. Cache the result per Cache instance,
> which is discarded and recreated at the start of each validation pass, so
> a filesystem change between passes is still observed.
>=20
> AI-Generated: Uses Claude Code (Claude Opus 5.5)
> Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
> ---
> =C2=A0lib/bb/cache.py | 10 +++++++++-
> =C2=A01 file changed, 9 insertions(+), 1 deletion(-)

I'm wondering if the existing mtime cache could be combined with this
so we only hit both once. That might improve the times a bit further
since any hit would then need the mtime data later anyway. I'd worry
about lifecycle of the data less too since we already clear the mtime
cache at the right times (I hope!).

Cheers,

Richard

