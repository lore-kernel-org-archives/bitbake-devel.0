Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07AB6EB104B
	for <webhook@archiver.kernel.org>; Tue, 10 Mar 2026 11:25:17 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.37601.1773141916255701155
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 Mar 2026 04:25:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=eOrzgkbl;
 spf=pass (domain: gmail.com, ip: 209.85.222.177, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cd7284782dso223697585a.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 10 Mar 2026 04:25:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773141915; cv=none;
        d=google.com; s=arc-20240605;
        b=R0t9BmKxNubXMNTsiVas9o4HhOGyRQlEcTrtqeXDnItvX0GE0D3id/hsY1fzdVBIBC
         m/ViXTXkWP1gUb+g5fEFHMbr52eYWEgo2KZtcc3dL9l4V3bVMAE4qKlVx+kC2IbVPdnS
         wmlhk3jQJe0s1anEeNYStHHiIKoYjJh8u7avEqTjsFtsTNrGB/VTHSiQqKtQxLDF4LBq
         aAdrULTQ6a3CkJhNJCfzwCOUdgfHU0XeySrizZnJsF7Jwspn4QPXitC+AjbE7c0alRgc
         WeAk7+xAXomsUfxbtXvn582Ir2DOIxditKXYgANRTyOwzx4Y+R7pDpxvfZwfjfx/1Tvk
         nRgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5cFI8082XLiF+1+amnwn8QeiU1NuDlU8+0Uw4DfRMRY=;
        fh=P6X7hwXG2rRb7ceKR6Ks+7Ty10SFim8xJIuiSSB1DiI=;
        b=X3ofc500sUcNzGW7aQ8xxAheP3Zi92EEYL4nQ3OiETdqf4gclK/7d0MltZ0tE80n8p
         CwMnuUAs2SqaMSWXhQbmG38f+Wwrig09vrSzERr3wfzB0jhNDVKJjOm7EcJtXVTQizC6
         673bYKXcr1/0KPTP4C36rCbsgPgrPnWTrWJft/iJ+/scVFrWzYh9OspvEWgVnXVQjgox
         PLdf673d5If3FjumTRqrC9imgzfZSrdGfUDLXuVn0Lsi0M9mLT/0ifr2YJVvNNAlgKuF
         LsRKcPaaK+vSD/hNqiGoHQWjqxNGtA3BnUaVKIrAV9Qr1xedQgTX2ALNCw9WsecnlR31
         Fe0Q==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773141915; x=1773746715; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5cFI8082XLiF+1+amnwn8QeiU1NuDlU8+0Uw4DfRMRY=;
        b=eOrzgkblIUmmARweOKfoWd4/RYOm80RrCfqGaLSmn1V52AGfMBAWugrDnws3SBaXtG
         TzeWhGEh1tSsSI3xgQ7Xf1vMf0ENSd4ixOmYyU9hnzhJEfEl9ssVs/nHlb57kOjDAyKk
         1CZ1oR+nU4Sa1/2o8I/6cGeg8HFbWKim2MzAm0ZfLgJWBv3OwWnwWy5SbQoGXPIo5mMn
         +EpIyoKADT/L5w6WUKLgczuI1aIUBsftVU1dSpLlOc8wcPXYTM2wMXUI089skf4ExCdX
         n56lKb2/nYhcF2E8Q68usKzs3XvyiIGsFA9lOSOBljiid9M5j4YKvhHF5PbLmq3S/8WZ
         mAwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773141915; x=1773746715;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cFI8082XLiF+1+amnwn8QeiU1NuDlU8+0Uw4DfRMRY=;
        b=JidAiyo92OWv341n6Pq+RkLUKbAVRwhWVD4dR81XkNu91rWWzbQUaEkFi0K+09lb3o
         eyn2ohXyQjlLYRVP/JOB2XQZrbau2+q9kw7brHGDctYeSuluvS4f4nnwWaaaMs4f0Ezd
         MsApB9J1vial9YK4EXq33ZkooxOr0Pb6B0BOqxGg6+goWs1LOwIF90FsoJnFuEpMkv9c
         2EPY0hOuSWtEkTP37pFaoJ+hqkUno7WNgCSjV7uTe7PHZ8l69/WhDU994MYQk8++dgs2
         YknZv0HIdb8PZZaNtb5x+pA1P8nxVli5M0mBVyKkjbbBXfSKgj4xbK7dY4dCulXulGea
         by6w==
X-Gm-Message-State: AOJu0Yz68Mmtl1zD1YjdkLIloNqcI9YfzIsfTJ7TGT1buuz8f7fSEKE6
	Z0qTodSDMUXh64UrHxzb/QCmsMzkWMwshpvRbcuC1royJovEDcnebo4kTNCOL1AL2HPOERELQdG
	CMA62v+49Jn6m5milFl5Z5R6hff3zKq4=
X-Gm-Gg: ATEYQzwRvuZO7AhfjTyaaEIMbvuC+ZUxb47+ncRLmxFb9l6yA4/43rcqN4VHzWuf8ev
	4lYn6rVE5Us0wWCIupVylGyRCpAlMTSVW7GpnIjd7YTgwW/puBDls04wLrpl5ZcRjeHZlBv5erP
	OzQGCrekN7o1+UCw/7tCR4tasermrw6ThuvAb+c+pbcFqNi07vIw8HbOJl3F4P0gwnN1gxg9OhK
	87hbNhur01UNURMuYs0giCl3X60ZdNm70V7owMCH3nSGf3IJHOedTS8PUwUJytvt5sNcbWohWVE
	G1hwt6jCMJ87JfRf+7xxIa/RfYew5DRRvSHOPHaPyQ==
X-Received: by 2002:a05:620a:f07:b0:8c9:e989:9d97 with SMTP id
 af79cd13be357-8cd6d469a4amr1860957585a.68.1773141915166; Tue, 10 Mar 2026
 04:25:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260310-add_alt_fetch_method_curl-v2-0-4789639b28f1@se.com>
In-Reply-To: <20260310-add_alt_fetch_method_curl-v2-0-4789639b28f1@se.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 10 Mar 2026 12:25:03 +0100
X-Gm-Features: AaiRm53_ZfIxpAOoUiLa4e3RLuN_sI0GSXPqR0I0aaW7KFaG7dVbhbCs81TmUZ8
Message-ID: <CANNYZj8qw65AZ-LSTN2wYPfpCAoLeT-Uf2pHKTPRr6MRmY9FWQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2 0/4] fetch2: add alternative fetch
 method based on curl
To: pascal.eberhard@gmail.com
Cc: bitbake-devel@lists.openembedded.org, 
	Pascal Eberhard <pascal.eberhard@se.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 Mar 2026 11:25:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19139

On Tue, 10 Mar 2026 at 00:31, Pascal Eberhard via B4 Relay via
lists.openembedded.org
<pascal.eberhard=gmail.com@lists.openembedded.org> wrote:
> wget fetch method is used for web downloads with http, https, ftp, ftps
> protocols. wget cmdline tool is missing some features such as hostname
> resolution by the proxy when using SOCKS5 proxy. SSH tunnel provides
> this feature for example.
>
> This curl fetch method is based on curl cmdline tool and provides the
> same protocols as wget and supports SOCKS5 hostname resolution.
> This class inherits wget method in order to avoid code duplication as
> much as possible.

There has not been much demand for adding curl support (meaning, none :)

Would you be okay with just setting FETCHCMD_wget to a translation
wrapper to curl?

Alex

