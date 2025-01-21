Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FB8C0218B
	for <webhook@archiver.kernel.org>; Tue, 21 Jan 2025 21:43:45 +0000 (UTC)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
 by mx.groups.io with SMTP id smtpd.web11.27924.1737495817824960238
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Jan 2025 13:43:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=R1aM3FyP;
 spf=pass (domain: gmail.com, ip: 209.85.160.173, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-46785fbb949so60909271cf.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 21 Jan 2025 13:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737495817; x=1738100617; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fiZhptFoCWyc7vRrqKu83d+lIeaKgfFAccokjfaWuiU=;
        b=R1aM3FyPfKUhhKm9uBg+wExOsxW83WMvrE51PSI4PgDveL4LVvCNg5Emc2qHHpdI0H
         f5Obljtjgj+mzzGtoDX34RrBu2namYaBkHg4mW7qFYYXOSdQ0V6hZoASIBNaOzdWnMvX
         RB73QWFnymryAPe6Xf3BU2xPGd1Wb9S3j/v33h2XLct2PKHrhvjfx07aFsF67Phg1saQ
         UxMIhPcqFRuI1uWn56/L94y6bK3phA/LDM6rh0GkUXd3lZWCV0LKGShe/I0372wTR0zg
         q4mldlEYWsyNFDMHrQGbDYMXjjKudqFfOzg6dyld9OHupJK3hfQCNkzWKg4b57r7+spZ
         9tvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737495817; x=1738100617;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fiZhptFoCWyc7vRrqKu83d+lIeaKgfFAccokjfaWuiU=;
        b=JhHdgOl0T4TG9pfnQ6QUGbu9C7l/GQmoL3CIxK7n/RVOWdi2BTXhA88GduTGrM+SKE
         Sblow4BqgoRoJUNwQbCUDcHMqGWYqLiW+CWWktrrg6WucjObquQsh/1qcd8TG1QSAXcQ
         bBLdOU48FNYYugKNMZKZ2q6SD9D2ejHQCswdHwfDuCXQycT5Ug1FJjJEeEFM/RgQEmzF
         eg0UKnYyuMIY/66rPPbG0+oVoVxCKCgS36pS8anIaYJjAZMUcmOvyCwWZK+Zm1k2fope
         NT1h5fvLWBiAKtRssA6QKREkybyycRO833r+FnvS/gm/PKqNBlyxy14dOB7N/x64AafK
         2/hA==
X-Gm-Message-State: AOJu0Yweqyn58vfEnzrJ94lAMs09E4Rmrm0aRLcGZw1SbVP3zdn9IFFE
	pjg+gllTTGpk4g+y/Kj573xGk4E46P/WtA9Oqpo5zr+NY8DUAcrVaT0t1bDjbAOdDOU71xSQl3X
	I6/uBPjIkb9+5hQyNML0UyYfpwtQ7tpJD
X-Gm-Gg: ASbGncuDowgDbCtNIl70OvGipMn1NPv/byxvgvba9a4xjlfx4sKNhJ49StgfiQPLyXY
	RFAhDuPNLF2wDTbhlm7NZzwzzAwEBkb+rgaWMDBClcDe4VN4esGqSBDuIhFN1aZPy4GcsWLAQIV
	pJSSQwSN/8pQ==
X-Google-Smtp-Source: AGHT+IGzNmK5K1VZS2lNAZtBRXiLY79EQGlBHNCz7kjOqbEuL5rlXI6AWYu1I6U758vLj4e1Ffnz/KBURiV4U444Qq0=
X-Received: by 2002:a05:6214:29cc:b0:6d4:1e43:f3a5 with SMTP id
 6a1803df08f44-6e1b217a2cdmr304851036d6.13.1737495816873; Tue, 21 Jan 2025
 13:43:36 -0800 (PST)
MIME-Version: 1.0
References: <20973.1737493163596337097@lists.openembedded.org>
 <Groupsio.2.20973.1737493163596337097@lists.openembedded.org> <181CD31953633E83.28835@lists.openembedded.org>
In-Reply-To: <181CD31953633E83.28835@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 21 Jan 2025 22:43:25 +0100
X-Gm-Features: AbW1kvaCL-PnP1cmN2iRDTXm6yC2vqmLdR_Y3dqJV7MXhlTzpkBM7uOBaOgokSs
Message-ID: <CANNYZj_upH_xzgMkeaowx4XpM_0faOvcZqtft0jXiqbojA1KPw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2/wget.py: use default wget
 user-agent in upstream version checks
To: egyszeregy@freemail.hu
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Jan 2025 21:43:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17051

On Tue, 21 Jan 2025 at 22:41, Alexander Kanavin via
lists.openembedded.org <alex.kanavin=gmail.com@lists.openembedded.org>
wrote:
> The correct solution is to fix meta-java. Please focus your energy
> there, rather than trying to portray this as some kind of persistent,
> wide-spread issue (it isn't).

Specifically, this means adjusting SRC_URIs according to
https://lists.openembedded.org/g/bitbake-devel/message/16359

Alex

