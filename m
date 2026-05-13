Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A53CD4F21
	for <webhook@archiver.kernel.org>; Wed, 13 May 2026 20:21:27 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6560.1778703683757592494
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 May 2026 13:21:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=jPxFFgf2;
 spf=pass (domain: gmail.com, ip: 209.85.219.48, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8b7f937ef44so41834096d6.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 13 May 2026 13:21:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778703683; cv=none;
        d=google.com; s=arc-20240605;
        b=blPH4rK15EcA/6PrejzjUrgukfbGPoU7YuKYlR1RimW2D5EXZRyb1qoXK0oUHZ2QIX
         o06DJkZJ2hxv1PC55YAnrPSUSy33kNGoFL/ixu+ndIR9BIdcopnAnJ0ka2GFI129kCp/
         sQQZrA/Jqna6wwrFwjGXX/RCHAGq/O1PTbQ4/f38Y2/j66OPQPLbxwXunMt0BnTEQ4hZ
         T8JNNaFDVMoDVQfaFCwdABJWVE/Z4/1fNWli+qERN1FV0e4hIL1do5e0qX1IIvY5juFR
         95b4E3BXbm2Bz4mFR9JmdSpRGqsE4QEF8Lcfi/jbQ6r+fClM43AMWLHdoMhIIZ2RUxWI
         6YnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NR9lJvw13OjnQIlU2foCLnHJwUkUj8O81pB007spZMY=;
        fh=vUPusTZBnNPqecT4tj9VXZ0DnIpbWmoimmr81sHgWdI=;
        b=EuI5JT8Yu7bFE3cjrXdOD4QuSSL/WtF+vFhXUxbOpYAZBpk6D9/26OTVL6Ui4zbjGb
         55PXC+wiYuISJtXBKWXpCGYM6j/s8FNEfcMhLlzio+xJsYnkNj8fwiW3SaoNfrvxfLui
         WZA/ms2Vl3FBLA0x2Q4NpN7Po0Xtm+j+gRnWGulZOdkMmkNNl/fvIXqbw01E2xs7sYj+
         0HB4Tqc12M2wiheAzUOl7lb9Ciu2M0Fa3lkiUvicZW9Mz4SXvVN897yho5cgd90dbGyg
         Rbx0x5kPO1LcQmJ6kDf33yRW3boNBBKXZwnPmgyL6yEhCIFJHJXKGn1iuD79G9zDhTMW
         zBHA==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778703683; x=1779308483; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NR9lJvw13OjnQIlU2foCLnHJwUkUj8O81pB007spZMY=;
        b=jPxFFgf2H8d3RerUeyLovgBYZt4tpYpoO1U5ATqpAUzMR7BN7ji82iqPV5mfDumUWl
         kohfshNYo+meZqVPLRiZDxzlLcpXh9LNdiZDaNR840sEj6AlvL/AT9pbbV+ZRrIDkpUU
         B3HPn0iOk1D2t3QHb/djlEPkfyLhMPgC+2Q6m+RdmdylZ/pVUVv/1bAwFpl866eKJjOu
         ndNEFoPE2mTiObYgOLPOP8ghI7WqidBTrAmifKiSjsinvrsDYJ+BA4lI+hRev/+Ln60a
         WXoLBPoSBDU8ScsuNwW9iAln2BNutLpoRzh67kIHD9CVHGFwfMu5NGukfrXrgLEKXXoL
         obaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778703683; x=1779308483;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NR9lJvw13OjnQIlU2foCLnHJwUkUj8O81pB007spZMY=;
        b=MJeVCTVNPBuGlviaTulbnt3Yknr49rFh26fRRm9e+00/ByWXR+9ZbF8fN9RJS/b3Uw
         p+NVA4mRdHvuTrRreukMWDxfAKxvDCsxPr7keOOnBLr6lVdOqlYUonCImxfqM/B22ox4
         ydLOmc+4vDNXXXS3VPW523qCcGX6Nuxq+fLHxLBXjP7OFaDgFLPU7reajVn83P52qv4I
         OoMaluQCb8Bh4HIaMWURpn2y5/+IacI13PRyy+pMu+uONnYCrbnG5rmA3E3B74AuKbKM
         ldc94p/OhBstuyRrKor1uLzgs+b6Tr2VdDl4S5kHOZhzEtmrvQkDoSipui+62qRrIdjm
         1a9A==
X-Gm-Message-State: AOJu0Yxuy7Uz4llduGY/YBcJu4dK7G5HSD8jdQyyNS3X60r3bMCeOskD
	TPqnJLEpJ8giSobZ9wklj2vZP6qTzoXRMiKiYrhe6Q5/KiueAzkq6zNL8wS+8nscAKDmF3rKehR
	K4CTe7aGQt9+Po5/8k1RJQgAJ3ED+Eoc=
X-Gm-Gg: Acq92OHxZHqGPL8FfCvl5GkSuS5Y7gaIEtiV2eAHDSBF7IdLSZH/0VWHWrKayCZdhR7
	P0wzXmKAtYNwGPO5I7IEoGOPeQ79PfwyI0oOLV2JxiY6c/9k7V3vDHvXYqFqVkeMdQ4ybUjxf4Q
	TsJgCAzNB7lLuZaCQNi06sdl3GEh6xqTLz7tk5WMI/dX0bAH0IvCUsOEIa0rKWO7mTWfBn8uv+L
	dVUOQVmPOG79ack8NAqL9AR9rYLtrVnDHLrsPmF6zgRfaXSJtBfDlwctfIZ9+aeFxpKJDqpTFcs
	y7r5Cpan5qRrQNwD0i5up8cpnzo2dhLyfWCkVR+ldw==
X-Received: by 2002:a05:6214:19cd:b0:8ba:b699:9e54 with SMTP id
 6a1803df08f44-8c7e0294f07mr76252046d6.47.1778703682604; Wed, 13 May 2026
 13:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260513144621.440431-1-JPEWhacker@gmail.com>
In-Reply-To: <20260513144621.440431-1-JPEWhacker@gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 13 May 2026 22:21:11 +0200
X-Gm-Features: AVHnY4JEQOguNfe-72-1TxwMFm_ry1ZMNPD8sojBi6DVwG7eaRrao4OzlJnENUI
Message-ID: <CANNYZj-vJB83dvkE-Bt_EDFLdmVxu3gEx5mXg=PXstXKkOt4=w@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH] fetch: Upgrade shown checksum to SHA-512
To: JPEWhacker@gmail.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 May 2026 20:21:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19514

On Wed, 13 May 2026 at 16:46, Joshua Watt via lists.openembedded.org
<JPEWhacker=gmail.com@lists.openembedded.org> wrote:
>  CHECKSUM_LIST = [ "goh1", "md5", "sha256", "sha1", "sha384", "sha512" ]
> -SHOWN_CHECKSUM_LIST = ["sha256"]
> +SHOWN_CHECKSUM_LIST = ["sha256", "sha512"]

This raises so many questions :)
- why suggest adding/fixing both sha256 and sha512 to users, and not
just sha512? One checksum is enough, and causes less visual clutter in
recipes
- if sha512 is suggested, should devtool be tweaked to add that in
version upgrades and newly added recipes? (something similar was
previously done to assist md5 to sha256 transition)
- last but not least, should we look into adding support for better,
newer ways to identify commits in git, replacing the classic,
not-that-secure sha1 ?

Alex

