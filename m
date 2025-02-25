Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FC4C021B8
	for <webhook@archiver.kernel.org>; Tue, 25 Feb 2025 08:03:39 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.web10.3485.1740470609611745584
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Feb 2025 00:03:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=j4rmvau9;
 spf=pass (domain: gmail.com, ip: 209.85.219.48, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e67bc04a3bso58388376d6.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 25 Feb 2025 00:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740470608; x=1741075408; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h3fW6YDN1P4Qh2iMJEnqeN68LzUnYMK5pJLaqhdsQa0=;
        b=j4rmvau9DWvv5aITgFK5nz964Ab496W70DOX7IZQlO+jeRhaCIb/GLI4Da8Bia/uf5
         bwkZwb96GEMOrIXic5KniX5RwKh2YZYkv1UZB4UXVuAkzxjK5e4q9PfPXiKTu5fGWN3I
         WwkVPNWTJWcksK1F8vvxSa+uXW8lso3E2DqgVxXCO1kbybpALbty3PIzjTosrclUfRwn
         aenPYWb3pE/z/7/x1UyxsGE/4TMmx4ddkaxscPcgq6NJfYHY2HzLGgMwI5RQ4njKMG0A
         EGdEI7Le+CfSStVBpxa6ABAL3c15o+8KwU+Q6ZN7KOlTFPzdZPDi1PjCg3FyNs50vDmC
         IZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740470608; x=1741075408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h3fW6YDN1P4Qh2iMJEnqeN68LzUnYMK5pJLaqhdsQa0=;
        b=BQCi5qLk2tttH1M/LqIEb+ASFEQ0Jyady4PUG03d/2/5XspjI5jCgQP90EdPACLwar
         W5d8ggVaIFSG8BdWUkLcB/59NUDfn4ET95i46BNSjQ6BBriWqr7tKPTHiByClMdBg3N/
         fhEqMCWVDgnf58WcccyCRxFa+s++wFdhi8p00jyLVoslr32nvDwmeUEbhyE18M5feCyK
         PGht+0uYS7XFmvu8g+MlFQVDccf+xcTRV3xMPdgn3ZgUQw8FjQ49rqw3bkWie4DBN/dc
         AEqY0bftEM4dQC/kyWO1QKMeTaewT5EhrAq6UqcATig6loZ1jMUc/dq0PRwLYYPbCug+
         BMyQ==
X-Gm-Message-State: AOJu0YxhIYMPvHtZItc+nKUCEv/KaqiyuwR7kpKlpsCOXc7mWRXTRQP9
	NmjefBG6CayXO6iY03IzFT7HX+kAV43EonNronJIm9eUE4DyurOZzBJDp1FwrY8vNJynxIW8lYG
	mJ9H+SlM50MzQihGLVaANdqwWBvQ=
X-Gm-Gg: ASbGnctAkrotFTr3BEHMhUKaZ3zGBCD9YcMEh2N4Dc4jJzNRes7ku56HEumyw6HrOnb
	Ha0cumAW8u5hHOBWUw4kbj4Pr23ndETnUW2cH4Ei/KcXzLuRveiItBrwmT+5oE37H28Uq27mW93
	3EbL5CvB8NbDxStQgRLkXc/Ra2gpr24h7F7kdw3RdCtQ==
X-Google-Smtp-Source: AGHT+IGkikz42Y0ykhIQ5BpMHtCr6A2dzfNT+LRv8Glg+FbN+RVFKhM/3K+oNvKxuP/s0BoKc2dTPg/d4V7pa6iZ4sg=
X-Received: by 2002:a05:6214:246f:b0:6d8:a730:110c with SMTP id
 6a1803df08f44-6e87abafb28mr26274146d6.38.1740470608463; Tue, 25 Feb 2025
 00:03:28 -0800 (PST)
MIME-Version: 1.0
References: <20250225070631.2262115-1-l.goehrs@pengutronix.de> <20250225070631.2262115-2-l.goehrs@pengutronix.de>
In-Reply-To: <20250225070631.2262115-2-l.goehrs@pengutronix.de>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 25 Feb 2025 09:03:17 +0100
X-Gm-Features: AQ5f1JqUkkAZbWDV84TIvly4OmMz9iCwMfLtCEJs-BXTpRekrKh6BAiDcxQgEIs
Message-ID: <CANNYZj_Qk1ftZK36EcP-QxA6sWEexThj=th-iNA=EsoWA4ifAg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v1 2/5] fetch2/github_release_artifact:
 fetcher for (private) release artifacts
To: l.goehrs@pengutronix.de
Cc: bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Feb 2025 08:03:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17307

On Tue, 25 Feb 2025 at 08:06, Leonard G=C3=B6hrs via lists.openembedded.org
<l.goehrs=3Dpengutronix.de@lists.openembedded.org> wrote:
> Authentication is provided using tokens. In the simplest form a personal
> access token hardcoded in a recipe file:
>
>   GH_TOKEN =3D "github_pat_...
>   SRC_URI =3D "ghra://github.com/rauc/rauc/v1.13/rauc-1.13.tar.xz"
>   SRC_URI[sha256sum] =3D "1ddb218a5d713c8dbd6e04d5501d96629f1c8e252157...
>
> Or as part of the URI:
>
>   SRC_URI =3D "ghra://github.com/rauc/rauc/v1.13/rauc-1.13.tar.xz;token=
=3Dg...
>   SRC_URI[sha256sum] =3D "1ddb218a5d713c8dbd6e04d5501d96629f1c8e252157...

This is really insecure. You need to find a way for wget to pick up
the needed token and produce a header directly from netrc or similar
file that is managed outside of layer metadata.

Alex

