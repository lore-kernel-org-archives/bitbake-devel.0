Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DFED59D65
	for <webhook@archiver.kernel.org>; Fri, 12 Dec 2025 15:28:06 +0000 (UTC)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15260.1765553277756131947
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Dec 2025 07:27:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=WTIZ10UG;
 spf=pass (domain: gmail.com, ip: 209.85.219.51, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8824a756771so16106446d6.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 12 Dec 2025 07:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765553277; x=1766158077; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+OdTRzHxdUh+aXFvliIQImHsrHiJUYXGpTFUKqEv4sM=;
        b=WTIZ10UGKlbIok85sqKMldpKqkF44T9ZuCNpnUsmC77A7PYYlVSGlbaSrnUqhRwbLs
         jt9V3Q3lpuldd0Nj0GK1uM/Z7wPlDW1gDW6eW5FCTyW4n+9nL82LSk0qNqchTzpifjHG
         2v5nux9cgI75+TsjkNNABYppt0Ge1AMnsB1RI/SBJY+CzgD39paCV8cR7Oa3t3S+wDEG
         mjPzCW15BwpH6G+Oo+zkuq463lgO5LBLtIHMHc4ezJErM8EbwtwuJX9TVJfkpM2wR9ri
         jQP6CgdsS74lAyC1NXKbTSwoRmwp8RFAn3COyCO99yUrCx38pw2m8x5sMKdiK2n1TlnT
         P1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765553277; x=1766158077;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+OdTRzHxdUh+aXFvliIQImHsrHiJUYXGpTFUKqEv4sM=;
        b=P62zNjHE39CeJaKEvr2gvE9l7Xyo/pD+9T1NVjgYQrpvqcsakgvKVZ0lOj1NQJJMRO
         jOu1Mkf3O9dg2FIGmqPfdFjwmmft40/FJwxJvGYkrtLzvMYtCXBVzuVq4rQTtIUYTrIw
         8wmauM/vCw6ZrNN0zGMkrJCyacG5mLebC2+b8T03eHSrIp3LtctwfrpIgCftNHv1eYCE
         CKRByveSJDHQf8c2yoRfEeb9MKLg2A3+CFz/NTvR5M+/P15hV/AC1JecygM5nF5ry2Lu
         mu50g6AYglq5XCTrRun3A7DDLQ0iG+0X2t1fsb8PSM2ON0EtiUUkn1jSdOaGmVsWzDgl
         ax2A==
X-Gm-Message-State: AOJu0YyZadwF1bGw90m2n1UaztjuTrB3XzKA2W/Mb/dAqmqumyeXYWdV
	NYkHQo6sKhHOTo1CQxbvsWxE1TEXR4i2BfIMY10qtYw+De+FZmZ1gkgv8ioF8zoQXNZrMbc19UR
	gH+fEVI8DbEH5Jt+3O7ql+YlLR2E8pFE=
X-Gm-Gg: AY/fxX5fQmiHy7BZoRgu4Gbj3kounz4RUtMlZO2Yw9xlm/RM5goH0Rg6leFhPH7D1fK
	UfAJTHJJHZwSjZYjqtasSJeKr3hyvbIE6PBXLbdjb8gzYWsve67cuGtK9+PYi/Hvnc7MOo5p4rh
	qHdkB4IPdXya1wiiZAc7HXbFFYbByByARDRFoLq4al8CONx09ZczcWKQ/agu9QNmIL9kOf/1VdC
	m6MAXpdb1KF7zdmQVSZpyioFGowukTgOtvKaNUV/Zud+pY8UVL9rvSdsRhcG9n6VA+jxA==
X-Google-Smtp-Source: AGHT+IFUqT4H/SS4BgGsnTK8sq7w2JqjArNZXCie+ugmKoYU/gNdoEHLSlxAACIXGS5Hozw2dZ9GZ5RY2FmA1Io4Rdo=
X-Received: by 2002:a05:6214:f2b:b0:882:6d1a:eaea with SMTP id
 6a1803df08f44-888715ac8e2mr100425866d6.30.1765553276696; Fri, 12 Dec 2025
 07:27:56 -0800 (PST)
MIME-Version: 1.0
References: <20251211142532.983960-1-alex.kanavin@gmail.com>
 <20251211142532.983960-4-alex.kanavin@gmail.com> <DEW346OSAIK5.1JC1QR7QCHUHD@bootlin.com>
In-Reply-To: <DEW346OSAIK5.1JC1QR7QCHUHD@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 12 Dec 2025 16:27:45 +0100
X-Gm-Features: AQt7F2peWpe37ShgPVv-PoyGZs4b4F2fiM5YrU9waFOVceNBNeeLP1T2Bf5yal0
Message-ID: <CANNYZj9E_ef2h2wXUUW=MNsqkmmWX_H9jtAHGOLg4SnGM6rXmQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 4/4] bitbake-setup: implement symlinking
 local sources into builds
To: Antonin Godard <antonin.godard@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org, paul@pbarker.dev, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Dec 2025 15:28:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18578

On Fri, 12 Dec 2025 at 09:11, Antonin Godard <antonin.godard@bootlin.com> wrote:

> Likewise, I would put this under the description of "local", like git-remote. In
> the end it will group and makes things a bit easier to follow IMO.
>
> Otherwise LGTM, thanks for the docs update. :)

Thanks, I'll address these all in v2.

Alex

