Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BC1C2BD09
	for <webhook@archiver.kernel.org>; Tue,  9 Jul 2024 19:08:29 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
 by mx.groups.io with SMTP id smtpd.web10.4120.1720552102792745413
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Jul 2024 12:08:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=k/rMeQkW;
 spf=pass (domain: gmail.com, ip: 209.85.208.44, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa6c4so5899651a12.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 09 Jul 2024 12:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720552101; x=1721156901; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6mPsVIljXXObgr80n2jUsSzH2PLxFLoxWjqFiad7dF4=;
        b=k/rMeQkWQGVEqxStXHLqS6J3q4I57oYaWK5DUM5bSWwfdWbCTwFJcODSPU4zpOCEh3
         +7cwTmKgDruIZJASovIP7/byLR6ih2C65bZt+/5bbJFTkhlpbk04hGAry5madsPP1FXA
         108DDca/90iNiGl0XLBkfttlH/Hbt7P67Ph1kAliKy3kr4qOgnHOe4Y+rva7uGTHP2HD
         y2GYTXYsAv3lR62lsM6sGBm507KRR8Z2X9vRy+T0YNu5REDdw8H44KS/6z2HrQSxmspL
         hdVzP3RUB2HCD4PBuzt6A1DGGwf6t+x7Ju5s1o7y/p7fvTvJBaK8WGL1ZgyXHUMAXX4U
         lfBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720552101; x=1721156901;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6mPsVIljXXObgr80n2jUsSzH2PLxFLoxWjqFiad7dF4=;
        b=kSG2l6UvXFTx3xRokaGo26klGnsYnqQOJoe121F8X+u1LsXsEvOAc7NFdcskfY0s/o
         7aWE65r0dAZcqaMU4WUaEmdm+orfXoRN09SzcIU41ANYQqP7CAMcKdXRzlP61e+vhe+s
         5iSsZK06cAIuFigwYfB2D/ckfIUekCv5gD+n89ey5eI+fXOl4/mv9C+KCij7rOFC2IYm
         pl/bwzZHPCInIcQtpkkU0bR192YPPOZkuiPXMU2r0+iga8MFdbr0ZLRfSUPKDjU48jYl
         r/Mpdx5JjBd5OeXm+aaNTL8xMyCB1Hv/5NGLOPAnbOnN7U866tXryIN7ZJd732mdj01P
         r9lg==
X-Gm-Message-State: AOJu0Yz6pD6njHcb+rUDPQs4i+xImaDbj2qLX6r41QyMWBZN0TAGke6J
	QOfndTFg2/QuANd2fRaRRGufhurKfVeRiWEe4M9sBNgiAWlfqz0vS9ym/i3qRuX/kEuww2Cdnro
	6IBhQE6L1TxPM+fD6ZKbA0WccIzk=
X-Google-Smtp-Source: AGHT+IHRmQc9+mTxJq6RWTDDG8gn+LMUWbqoBTuTg7Y63qQyHpdTeaCJXIGdBkHK/n57JthD9nRI2ch3yaIWZLRQSao=
X-Received: by 2002:a05:6402:1ed6:b0:584:a6f8:c0c5 with SMTP id
 4fb4d7f45d1cf-594b7d81a1emr2898922a12.0.1720552101000; Tue, 09 Jul 2024
 12:08:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240709182057.141231-2-wavexx@thregr.org> <CANNYZj8zZNAwgdA3C1yxesKLX=seZ7FiUWrRHxM7n8_Sm7pLOQ@mail.gmail.com>
 <877cdu2y66.fsf@wavexx.thregr.org>
In-Reply-To: <877cdu2y66.fsf@wavexx.thregr.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 9 Jul 2024 21:08:09 +0200
Message-ID: <CANNYZj_aQ1ufVTFkKBOymAkuvVi211Vq4faESE1pqmiJyjm=HA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2/git: Sanitize git configuration
To: wavexx@thregr.org
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Jul 2024 19:08:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16412

On Tue, 9 Jul 2024 at 21:00, Yuri D'Elia via lists.openembedded.org
<wavexx=thregr.org@lists.openembedded.org> wrote:
> I'm new to bitbake. I see why, although this seems a departure from the
> explicitly-allowed list of settings passing through the build.
>
> Seems like we explicitly need to set defaultRemoteName then.
>
> Would that be acceptable?

I think so. There are indeed numerous places where the fetcher code
assumes the remote name is 'origin' so we need to enforce that.

Alex

