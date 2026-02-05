Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36374EC1E84
	for <webhook@archiver.kernel.org>; Thu,  5 Feb 2026 09:35:50 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17086.1770284144601937163
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Feb 2026 01:35:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Z/qM4U/W;
 spf=pass (domain: gmail.com, ip: 209.85.222.170, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8c710439535so43240785a.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 05 Feb 2026 01:35:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770284143; cv=none;
        d=google.com; s=arc-20240605;
        b=EF6rMhb+TuqXfIjJJaPQeaWMWg5TlYWvaEBstSvTSDr3psVuqYha91jVIdds9pF36J
         bGkFQJa96n+UdlpRoCxgVORkvvmZqeOppWF8XHkXNlnOD+b8pnS3ytj326tY80poU9ZT
         qL2vant1RmLXoXG015YfRFx5CMicVPBAP2sQ+fv0wdSAIE/ue65TWY6o8lLgL4qkRLaT
         e/H0wATPVXgphmVSCH0CdYVrOTj83A71c3SyN7n3IzVwJ5XAXTg5liRxrUfcFK9N3aNR
         lMKHbwBGUpIoEGSu0JO8i59Gt8ohSf3ZtIGd6app0asu+oo29yuMSRWCMG4U3RvE1DU6
         0pJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=080WQVp/W6QrlL09GJuedeR4nzMbpjQ5pF4Bgh5N/YU=;
        fh=AzhvQHsntPIv1eM1lpjGIR2sWw2cIaM7npVj0FDUl9k=;
        b=cRR1TLb1mB7yqf4dqwhaDtif2yFhlawi9pblU34NXOayGlnvlPjFa24fpnqUvazbj4
         rNF6TrrNsA3RQkmkfHCb7w7kzFYvsie+8zIxPKWH2yMK/tUX8SV4dqRqFyHpoAu1XtgH
         B1qlr1D3LPdoNikWaSigChtXrbN9zZVSHcIUshguJmozzfh4JFK5t7bA4EJaKPfWwioa
         CcVIR+TNCsxZrFeXcG7ehR+0GRKdJPio2vSnAXdnSH/sgWJLTW7Z3IJ/IXQKcBgHo8nH
         mfOgvOojqSOKLs2H7jYSJUHAJRFzzUo6MbmJ6mst6HAuAuxpQKiHdrYgdNie/u/XewK6
         Z8mQ==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770284143; x=1770888943; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=080WQVp/W6QrlL09GJuedeR4nzMbpjQ5pF4Bgh5N/YU=;
        b=Z/qM4U/Wz1h4OOjHBQBKf+xnph9DDv8+BwqnOMZnxk4p+hjfbW95xgLAyBcIPSF2qr
         IHOG/B306rljO5Kw9oNGOZyxXE3f5Q2+AzbxlzlDTM7NKe/BHxzFGHYqWK7PwRIQj0hh
         F3ra9YFmmMY+CaSjDBNTX11E+TuR4mRf3TBi+DCGx1m4XtsRSk02pxRnthV0mVnrj4H/
         HkVs7b1tRXxEuKaNusttYZmFo1fh4WpFY9uRRjv1B92M02iY0X+5L8NsLSUR5nJmRzrF
         UwkbuHg3rJIm3cr8Qup8XBNcp4gRr3NMgGe9OQ7F5YcIHL81riFOf6A9rAmag2UdADp5
         7hSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770284143; x=1770888943;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=080WQVp/W6QrlL09GJuedeR4nzMbpjQ5pF4Bgh5N/YU=;
        b=GwR+8lKIav0egt1Nu6x9ew47VGMRiuw0XFxuXZxCknNUxjLOLEa5eExCCDiTxRRFoW
         2JzPpGpcdzNYAp6LW6Zw14Ch+lou4oK77cUWQYMUtCkqaI8LEQt4LNDJqaL5v6zA4Xyj
         E8r9frKyb9pdgpcWg/rPCBgH+grFrSUMRnqFD3qtqtLmZqcimaCVT1ZPiMG8FokWxwRu
         ApRGtmIlk6aaeHr/U8TkSX9dhykgxwMKplEla9mjsNWf7wP9TbHouypPTQvMmjU/yQaz
         k9SH379lBZtUs4ghMVKe66vaZp7BZVx1ka9PPbejZyxDRCppGUrC+R2xc4D9SyRlO5NS
         Nt7g==
X-Gm-Message-State: AOJu0YzEH0YbMF3flf6thYhCerUpgGePuxm+BDRJ/VASQipfYjCYa+zz
	ENJnLjKNB+oM3HkaqkP4Ifzgxy3GKy+s6MzmCKed+3lzUHZ04b6JbwBIkaoOCsYw22tdQGTXMfG
	Vak25Zq7SQT/Ru0f6Z+gdBnl75uiNaog=
X-Gm-Gg: AZuq6aK9VLGDNWpAvN/60lV6+3qeUJjy0YEjL8XBRDcTlSz1pl2WIDr3E1e3Z091g9r
	3GoVKHGRwOOleB19loHtpyCz43+GqiGjUqa2jh0wpFTzRH/w9oWOTdKc9PXTS5jY95DdKQpY427
	EuoLlIKhYGU5Woa0a0X43+hB+gjlkF8WZp3W7es7LKgCta3gPKdfcDJShIqbsusFY5FZ48t9HFl
	t9HNtB2/UHZ8+wmoN6ycHGc73WrUvTLCs3HJ1cgtLGCQqWkO3NPG+hzVo1mZT/44S8SlIBo4hkc
	6RTT3wH5C/B3w669yv5rMZQMO8dgkQ==
X-Received: by 2002:a05:620a:8b17:b0:8ca:305b:748f with SMTP id
 af79cd13be357-8ca305b7555mr490053685a.79.1770284143494; Thu, 05 Feb 2026
 01:35:43 -0800 (PST)
MIME-Version: 1.0
References: <20260205024502.2382-1-liuyd.fnst@fujitsu.com>
In-Reply-To: <20260205024502.2382-1-liuyd.fnst@fujitsu.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 5 Feb 2026 10:35:32 +0100
X-Gm-Features: AZwV_Qj8cXuw8mTTiMqTJgc9DL6_uU7ZPZKW1GoJ20ttCfPro1of9zCXZcm-VDc
Message-ID: <CANNYZj-fajvqP6k1HONj45Cq-PQDUZh-fw3DiZQnFNt641hB=Q@mail.gmail.com>
Subject: Re: [bitbake-devel] [OE-core][PATCH] bitbake-setup: Add strip to dldir
To: liuyd.fnst@fujitsu.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 05 Feb 2026 09:35:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18961

On Thu, 5 Feb 2026 at 08:03, Yiding Liu (Fujitsu) via
lists.openembedded.org <liuyd.fnst=fujitsu.com@lists.openembedded.org>
wrote:
> -    dldir = settings["default"]["dl-dir"]
> +    dldir = settings["default"]["dl-dir"].strip('"')

This makes sense, but we should be doing it consistently with all the
settings that are strings, particularly top dir prefix and name would
have the same issue. Can you look into it please?

Alex

