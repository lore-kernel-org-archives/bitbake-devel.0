Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37349CDE016
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 06:49:27 +0000 (UTC)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12446.1763102964203459646
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Nov 2025 22:49:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ZbSSNT9k;
 spf=pass (domain: gmail.com, ip: 209.85.219.43, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-88244d1559eso25122436d6.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 13 Nov 2025 22:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763102963; x=1763707763; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sAagdi5DLxuytM9GJwx/SUJ/+/IxjOBXVej1Kdsv6SM=;
        b=ZbSSNT9k7XKanOFd/XvtukoT0Ew3TfZfejngDZvE+P8DgYxJ2bJ/G81hLTbBhdlj/J
         kuxJ06rJAY7BpnpzeFppLB16Zgel2Le8HoYPpEOe2nFtnWHoCG21gjAySbEJhayLqiqw
         ACoFcBao39Snk5UDFZhYtmfTfhQRuMQA/JM6B5okkxSzHMxapocxxQ+MHFD2yU0khaY/
         UTjtNg+QFM6y6TpsZ1BPBjwW8Vv6sWfWmSouiRFrABSBAqWRq1JhjpUUHHbGAp2sA1TR
         2cK1s4xkw2YBST6bXSzYsEx7SFYeqIRB7G3IPJRwMc7WkkVCrGs1WCpnshhpWWsFqAQS
         SLPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763102963; x=1763707763;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAagdi5DLxuytM9GJwx/SUJ/+/IxjOBXVej1Kdsv6SM=;
        b=jJV/8B6llS0Ic42oBRFRPvjqmGrZqrV14IzGiJaHvhVCmoa8iB0NMbXJEIhkX6E7fU
         93lmlPT8imH2H9KkP/TabfStFF5Bu0pp96m++Fxc+2a4qrCTMyrgkVkXSGyVe7QyLGA1
         ugRL35btYar6091njf+RpV+m9j6pJAiCSessyNRISaMWymeviF6nNIiaq4c9QQwhm550
         gtPZEVX3MdYZbFN2T2mjCqq8RW58To6rtZ9RJwRILNucB8qSl75fJKSI1PLifZ6Eu9c5
         cJknM2/NikWdM9uysGUSeGx5fYV+/Zw2Da4TQj8cAluQIXW2q7XQfaXeoRnk5TlelE16
         lxBQ==
X-Gm-Message-State: AOJu0YzOVDy8MtbM1wyTz4w6gwMbAjYvHV5RSsCAea9IHKTtB01egTx9
	fmnGVjgRG56OsMLzYV25Jlm3/5CJDz/6WaSbFTu3lxZwPCw+TvQYVBP5dYdMEAydwhjVN85gD4n
	NVTfC5M7UC2g4sv9069b0tx0sWeYbpb0=
X-Gm-Gg: ASbGncvbTMYFfasEJeR72T4tS6yekO8x1RQJlupzJgtbseps37DJ7MJb3LMnsIk5iA0
	veB1x2fxGziQ23SXvxZ2zhPpQCBiXb1rn5W7qmPiANw/ZfkOaipga9y2nw+PITTP8h6eVX9V39C
	tCTI1kcIQ4c2a27XgDEKt2FaIN3JL7E7b0BTOYn6+fEVdOYHisXhYVt3V4+4jYKW43T8sZ5qLMl
	YucFJuR0bRuKmNlae3u+mkM3weG5WZ9XGQzvBc/NonF41dEp8Wp6+tIm28UJReS4MmM9sGxlEP6
	rd5jy/v+ceMMgS0ePDaIRb1EOnLUNA==
X-Google-Smtp-Source: AGHT+IHGWxf3pDCCvZ+nkKzFD/DGGhHxGX3ZImJP+Hmg7Hga3MQQpjMKtXt3WmnqQQzrdPK2YIwWO0VjfkTCjNqionE=
X-Received: by 2002:a05:6214:1c8e:b0:87d:f969:6aac with SMTP id
 6a1803df08f44-88290c359bemr33570106d6.0.1763102963155; Thu, 13 Nov 2025
 22:49:23 -0800 (PST)
MIME-Version: 1.0
References: <20251114060211.1742728-1-Qi.Chen@windriver.com>
 <CANNYZj_J6oJOpdYsX7Rnz8ViL4==q4ktLhfx5MZHQNe1s9SF-g@mail.gmail.com>
 <a0e64b88-cb5b-4dcc-8b6f-147765f373e0@windriver.com> <CANNYZj8tDk8izGO2f_8ADHsaN9VudG_hsQrcw2N2O8NnXtdCCQ@mail.gmail.com>
 <5fffd119-5b6c-462d-9f1e-5b2b30f81715@windriver.com>
In-Reply-To: <5fffd119-5b6c-462d-9f1e-5b2b30f81715@windriver.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 14 Nov 2025 07:49:12 +0100
X-Gm-Features: AWmQ_bl3pY6egP9dt1hKWF3cx5B_qmJxW_rScAAxg5G2BeeqIMsIVkxAKYUAJQI
Message-ID: <CANNYZj8eqw8QF8eWCoLki7XXWZ197pVZHckLtQ5aQx29aU+o4A@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH V2] lib/bb/parse/ast.py: error out for
 internal fragment in case of a previous value
To: ChenQi <Qi.Chen@windriver.com>
Cc: bitbake-devel@lists.openembedded.org, richard.purdie@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 06:49:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18386

On Fri, 14 Nov 2025 at 07:37, ChenQi <Qi.Chen@windriver.com> wrote:
> When machine/qemux86-64 fragment is enabled and users use 'MACHINE=xxx
> bitbake <pkg>', the expected behavior is to error out and recommend user
> to use 'bitbake-config-build disable-fragment'.
>
> Here comes the problem. bitbake-config-build makes use of tinfoil and
> when setting up tinfoil, the above error will appear again. We can't
> recommend users to use 'bitbake-config-build disable-fragment' while the
> recommended method still errors out. This is the reason for the special
> exception.

But why would users be running 'MACHINE=xxx bitbake-config-build
disable-fragment ...' ? That prefix is intended only for bitbake
invocations.

Alex

