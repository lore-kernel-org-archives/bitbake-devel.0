Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79FECD98E1
	for <webhook@archiver.kernel.org>; Tue, 16 Jun 2026 14:26:48 +0000 (UTC)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.155771.1781620003135572677
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Jun 2026 07:26:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=oy8WXX+c;
 spf=pass (domain: gmail.com, ip: 209.85.219.47, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8ce65629acaso54287646d6.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2026 07:26:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781620002; cv=none;
        d=google.com; s=arc-20240605;
        b=XNhXKOfLgPm6XSiLfCf4Y9M/fk4N3LIs2DSAuVzo/SSN1ECHiT/9V5UXd0VK+sxLp1
         dl8HvcHvmG8CQioO/9evoEvpUecWfVE9cAmpUqKg+MtQSJ3VXuUpD2RCb5ln4nOqSj8D
         LgOP0ZxoHxcV0DzhPtKwAYqTF4mge8IsrHleuh7lYrB2ZvhvbnZrl4CSbvuow5qdxv+Q
         vQ/hjX4zx5oCbBM4FLzQGt4TAPpvt20ywbRWTyaUIkD1xIq+F61kSLIsPeyZhXp0dK0V
         4CSMnkvmr85oiRUHxjoyLEL7Hndpjn9p58UlEpv2FB1eoOQGVJzeqhPYqUD+dAP4QVqo
         q1MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G/nlRMvHYl+qzhnLdHIAFGlHaOSoxYsIuHafd9R8P90=;
        fh=KpRHvgqWW61aEsjGeK4POuCheHSQY0FDOA87uagZ87g=;
        b=ectMjOYaL5FogkpzALS4D+CjvmGQ8KDBPSl0IJoXONtTLNmMnvIPouV9OyqLhifwX3
         6E7soZ3M5ScmYHxlwGOnebohjePUcx44mZa9qf8pBhLz2MqRsMfCFTeC2xrVTsLIcvzV
         NH4bxX90voCM9Zy2Nu9Rs3slNm1eZ2tjK3h0+lxGg0v/n4jA8GUzgIQlAci8Ea2nbCdY
         XpAyuzroiQ8HYO6X67XDM66cvP3WWVfPXpWGOv6VgnUm9B3bHQL+ENBrZGA3xoclBNg2
         z8KkTS/5rDuei7vWa28utqMP/RU7x0BPVD5lmpKrdsVaRCUO8x/bt1xc4brw9PPNhERM
         9F3w==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781620002; x=1782224802; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/nlRMvHYl+qzhnLdHIAFGlHaOSoxYsIuHafd9R8P90=;
        b=oy8WXX+cKIPYrSZIdjwGPvbziaoi5NV8zW4IPkWyKOMLMj02EILlQ3zcQl8tmo0iUT
         lSKxAFKIFGGBAaKBzjVEJHKGe1KDmU72auFHhvpPcAbbczmnrqSfASMT3I5Xu5byvT7T
         wtvmX/byikyISRK0TuWhBEJySzuJKJZaRN+XmAMGyU/Wlx/eHowxTXfNQtknOM/ze5rp
         iinxpONQNYtqw6hdMFY6qqrnqaS+W31eirZZ6dL/afpAsijurNklZIFFUqUt61AVPNBE
         YRM2ShDN9cCCNR0F4OX00g6fjzJ90dKnysm6ghxX2YQNFqM3vThgbiIkMz7OKmPddiee
         m91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781620002; x=1782224802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G/nlRMvHYl+qzhnLdHIAFGlHaOSoxYsIuHafd9R8P90=;
        b=XrrY2UE5xbyYxFYI7onZk2HaZA0L9GjNPPcTUIT0eIIF5v+ZgdLfdsJ39StJMMqzQu
         nyq+l8B3U/TcqrA6h7vcfipyQnRJlvr43KCWLmhdMZNoK3z6TOc7a//PiUmuQm+CTPf1
         OzsKVT/mAikgMkQ1Few5BgjsrkrUZ/DR0qZRIKIoEu7NY7k1qkIWCTHrjEIZJa+Ouwuv
         71eRCyF1axTXiSzva/wTDsnWifLeFv79u0SWDHoLwPbAGFbMCU2zPyIyDSkEHplo8MxR
         vWMppVy3wPtXWfijHZyoD/DIgdPTeQ4L/z4xUvrZsOo7EHMIrCbdjQ/1Q/DljevcRlAU
         Nq3A==
X-Forwarded-Encrypted: i=1; AFNElJ/BC+6jkKtwC08bVo8jF/0J1w+f7wL7rAVudjFGal6GqbTaO/uWp8zQ418UeFQRTS1eiImhmD4rIq7tvYnh@lists.openembedded.org
X-Gm-Message-State: AOJu0Yyyh5YvDl1WX2uzOjEkyb/NjVPIzkgGI6G1ES1jcJmD0ILVEzl5
	UfI3SpwWakXhgvrkZDPT4X7gpKo7FCu2GAitT1L/LOrPbla7BC79u1sbNAD0ZRdUVjCsBUlTrBn
	BxJeRzlUm59+K/dXsuPHgaSdgFUGfqoU=
X-Gm-Gg: Acq92OEd/NX5Zu4LZF0gmYR4YQ18FRcfNPxrdY6ST56GDxyAv3q9uv1N2kUIg5++dwv
	35x3+euitm6rRQXtIlO2Umv4Fj0zaFhoJg/tHNQXwW9Di/o8YJGVdGYUxN4/nCAjVJ9hX1TYhOx
	4/ZxQ3RFSZuTbFevZWJdVqvLy4BvH2BPueAhq89BZKl5mWYlYjMstJGTRT6TdyXgjbtE+Wi/+AH
	NrVZ8MrpH09+glhZmNxlKA/feU7C9QtNNedE/GvdX8jG7stLlEQuHquaMwbAuIDDQw7DA0N0cAj
	2vSr1V1F3PDvUpDGe31Qd2/nRCCoQGCdDEi53K/BFg==
X-Received: by 2002:a05:6214:590d:b0:8cc:ed49:bdd4 with SMTP id
 6a1803df08f44-8da1b439235mr61842936d6.7.1781620001941; Tue, 16 Jun 2026
 07:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260615121856.96250-1-jaipaul.cheernam@est.tech>
 <4beac8227f89f57e5ae0984a5163685132577583.camel@linuxfoundation.org> <DU7PPF66507B2D7CFA2CD308AAA2C04622AF3E52@DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM>
In-Reply-To: <DU7PPF66507B2D7CFA2CD308AAA2C04622AF3E52@DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 16 Jun 2026 16:26:29 +0200
X-Gm-Features: AVVi8CcCzCMy5avPhq0seETLpniSgg6pgeXsg-C13NxI43g5kxPcDEr5YgXXGb8
Message-ID: <CANNYZj_j7irKNRdeGDpF6mfKit_78ML5=XQJ3CeZckcM3924ZA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: pass install-buildtools
 options from config and CLI
To: jaipaul.cheernam@est.tech
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2026 14:26:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19709

On Tue, 16 Jun 2026 at 16:18, Jaipaul Cheernam via
lists.openembedded.org
<jaipaul.cheernam=3Dest.tech@lists.openembedded.org> wrote:
> Agreed on removing --sdk-name  and I have sent Patch v2 for review in oe-=
core.
>
> For --no-check =E2=80=94 I'm fine removing it and having the install-buil=
dtools auto-detect, but we need to decide on the failure mode: if the check=
sum file can't be fetched
> (404 or network error), should we:
>
> (a) warn and continue the install without verification, or
> (b) hard fail and refuse to install?
>
> If (a), we're effectively auto---no-check on failure, which may silently =
skip validation on transient network issues. If (b), users with custom/loca=
l
> URLs that don't host checksum files would have no way to install without =
us re-adding an override flag or having them to add checksum file.
>
> I checked the history why "--no-check=E2=80=9D was added and it was part =
of bf902a810f98f55dd9e8cb9e6c6b0903f9902157
>
> What's your preference?

Please note my comment in this thread. If we use bitbake fetcher with
checksum in a bitbake-setup config file, then the checksum would be
enforced in a way that is secure against tampering or accidental
replacement.

Alex

