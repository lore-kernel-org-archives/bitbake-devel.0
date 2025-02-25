Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192D3C021B6
	for <webhook@archiver.kernel.org>; Tue, 25 Feb 2025 11:48:31 +0000 (UTC)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
 by mx.groups.io with SMTP id smtpd.web10.6215.1740484110679505123
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Feb 2025 03:48:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=gvXv4pta;
 spf=pass (domain: gmail.com, ip: 209.85.222.181, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c22ac6d856so214489185a.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 25 Feb 2025 03:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740484110; x=1741088910; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e34GDD5RL84Y3UgPQwsDJWdOcLGlzHpSdJQRTcKva7I=;
        b=gvXv4ptaPt5zJMlsZ6C/exoLK4Lejvf8JeKQ4I0csxmGL+Chf/KT5McSIzsNX/qxcM
         11vQWXTgw/y6HKvKZ6a+pmbhhmNOZKPoiozooj2Fk21zUzI0cYuGT2LkiKCpQv1MFkla
         PYElEkr/ufqY+kzyVcdHGXyISHtDz4/VQiEDENi9BkJZ1958C0VXhfuR6dxSMqnCIaL0
         NavxA6E8gLB8PGdYJXCuLZVk7owl9HI7BxGY04ZEqBOyIC4sVra9O3UdMBWlFx79r6WX
         sBIqPT7V7bP2iWvztlzsO42vjePiWpyHxcrv5ClJnJNEh9S2B98GhnroxRPqy/3uXJya
         BVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740484110; x=1741088910;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e34GDD5RL84Y3UgPQwsDJWdOcLGlzHpSdJQRTcKva7I=;
        b=IcojZKWpEvrT7nIUmu1HTxPYhZGSf1LyXgZyvdpygv3HpXiDRHRCr/4p6YfheEOXGk
         zrTcd2CRXew4XEHaTGfsC0Yk/1/+fLqTq3VmwbTPKN7LSCl/EYZ5TMXsoYGqJMBgvBrd
         DPPv9g+e0TvLEl1X1V9W7xXz1noDjibznFXmA1UEm83lSCM4jOJ4iGfO0D2kzdsFE2bT
         rIdFj98oak5Bqi8jY+PsMVGf98motof6HCHvaVsjzXbnRD4LMTtczEGjW6l8VCkITdOA
         aP3mnn5v07PDOIfdFGRpnlJumRQMtJKlgv96AX2AChVdxw6qMFXqdMcqmfSMQA09WUFM
         bizA==
X-Forwarded-Encrypted: i=1; AJvYcCVu2k7EUioGtjlixaO84IwtJ4HWOFBCkxdTlk+YkSFD4tWdBca9phXaUN6L84wsgCjFug0gJpHQX4krd7aT@lists.openembedded.org
X-Gm-Message-State: AOJu0YwGu32GGsLoqGj+D2EnIAziMPtYk2gCg+THmd7wcff69CfUMpsq
	RlisPlVLfsbJETGtP5wxAOFTG7zyswhjRDc1SGuVATjHETgTFXQ6AAwd/kosnx/q/h2wZ05SELe
	2YH00GTVjqzbbA5GwHLjQRevVyG8=
X-Gm-Gg: ASbGncuX0+mRpxxgehlUMnGajvGfIe0T0V7qqM7GW0/Vs+8Ju6wxPbYv5dJ5IjsylWk
	7shIg4TAbLhUOaSdvz9sMe3BnLg/Q2yfgVQEVDH3zwZNhaRmy8Gb403y0SdiB87KDq2JILTSUP1
	DZ2gCXgA==
X-Google-Smtp-Source: AGHT+IHoCngojlYIueEwozSbTpojyua03DdS6IkqZkHB8fuvMsHcBC7uJ8ouGRMNJj8l6kuY7laZkVdofJzao1/EzFQ=
X-Received: by 2002:a05:620a:2b8b:b0:7c0:ad62:2367 with SMTP id
 af79cd13be357-7c0ceeff2dcmr2366290985a.18.1740484109262; Tue, 25 Feb 2025
 03:48:29 -0800 (PST)
MIME-Version: 1.0
References: <20240502183501.1216856-1-JPEWhacker@gmail.com>
 <CANNYZj8aM+mydGDSpMhrvbt8XxKDLzMywVyfKOdxdxrAPgSs2w@mail.gmail.com>
 <416aa1661cd94d9787fec39012c4c94634a38b4c.camel@linuxfoundation.org>
 <CAJdd5GbZh7au+VtM_ueBs4MskkJtcx0pFYJG-36nUFW+=KxD=g@mail.gmail.com>
 <CANNYZj-G+j6yQXm0RCW5M2LcRxqVegsXuAPkLusO9+oueH2t=g@mail.gmail.com>
 <f81c98f506e531db8b119e5b30a091d10e916aed.camel@linuxfoundation.org>
 <CANNYZj9nsLOLGMoH9WykwuETM7U5wen-KWbqFnPSVgN--U_Yag@mail.gmail.com> <bdc5729820853195b796dc21444eadee95c8c0c2.camel@linuxfoundation.org>
In-Reply-To: <bdc5729820853195b796dc21444eadee95c8c0c2.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 25 Feb 2025 12:48:17 +0100
X-Gm-Features: AQ5f1JpMV_u6a2NqKKq3BSd3yQ37ARD9mbCB6s1IvqNrbApHkLCNwLTvxyywaR8
Message-ID: <CANNYZj_g1woZTONGomxfgwNSRax0hfinbxNVqSUF0Y_CiiWhRg@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH] cooker: Handle ImportError for websockets
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Joshua Watt <jpewhacker@gmail.com>, bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Feb 2025 11:48:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17313

On Tue, 25 Feb 2025 at 11:52, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:

> Could bitbake-setup actually run the sanity tests before the build and
> wrap the result with a message about buildtools?

Perhaps it could run 'bitbake -p', e.g. parse the recipes and quit.
This can be done already in 'bitbake-setup init', which will make it
slower but will give early feedback if something isn't working, and
then bitbake-setup can detect a fail and add a hint about buildtools.

I'm going on holiday starting tomorrow, so I'll send the latest
revision (without any special handling for buildtools), and we can
come back to it later.

Alex

