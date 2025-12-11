Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513EFD3E786
	for <webhook@archiver.kernel.org>; Thu, 11 Dec 2025 08:51:21 +0000 (UTC)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5030.1765443075445086679
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Dec 2025 00:51:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=lt42G5qx;
 spf=pass (domain: gmail.com, ip: 209.85.219.52, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8826b83e405so11270656d6.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 11 Dec 2025 00:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765443074; x=1766047874; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BjcTBvDNAD6mjDRaVbeRzMUALtu/uTxifrB8sD4KmY0=;
        b=lt42G5qx7SZODoQHT6Oivrnj6fAf6DapIvFbBRiMQf5HsukzDzJQGp5U30xkC5/5HB
         ySvDNcc7G/vgEsZF8eKC1GpCq/k+GUbGvxkwiBQ0jzRf0vJpf1w4VQ9mY2mZnWl6u+sB
         MJkzSqaSFS00t2+CGy85VOINk8lyl/Sfgcw22bnPc4mr7uVMs6UT9E8PPq24AMrhr2uP
         rj05Y1RdgtUsHEQapHdeLcyDN6AD8aof87iZcuOhxnP/BZCLBJWN/3MDuHBOGO2qVo8q
         XEO7VrcuN92DLi0ruBI8JUJ/yUFtj1rhpS6qXf7djHltwC3snUtlawyINAkXeEUs9OAQ
         QCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765443074; x=1766047874;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BjcTBvDNAD6mjDRaVbeRzMUALtu/uTxifrB8sD4KmY0=;
        b=tYZsrdVitpVIrLWDWEsGcDFO1UaZtSlW0T0y+EfoqOI+r4Sy88KvCKcEpfVfTGNcGw
         wWgc+1CSCuVGZOGJAdBw8ki8kUsNZqGEmRmLMgWou3N0R/xlmZC5HCmUlmtIHp66s3rO
         v+iDr21mPJsItC03cJj+bkASV+EHGXNDiy3O3E4UUKH5l5Gud7ePjtrbDCkfkM16hvxl
         bmRPSQnai5U3UZNmlWBQYMOgyfOpLc4FlkhNjIzpxH00/QBJcgqkVxDp5Jo6GMwgZGbb
         UWY85M7NQx61XPAVMrCm9wBUb9NReeYz6gMmfXsOohI6lOv1n1gTYqH4vFg+SrA/JOPl
         s1CQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuFAKxpM0OfGQ3neakeFP4FltCXJQr2DzrhWZ4dXTVnXv5ma3fJpUKbuwd/XtUqAby2yzVVLFwHExn1oa/@lists.openembedded.org
X-Gm-Message-State: AOJu0YwFpxp67gcFR6CxYtQHzyckyvbnIxqfIkaDEZ7ojNBCwUZmYSVY
	BfMoq1A00BvCKeuPmL1a18GWcBBj2Z5b8knhqiEMaFrB0xr3GUfV4Le3T6MZFH0/f6EEXdDsUfE
	wolkDX1VRrAKQ6f/JWq97fBbnMn7ocVo=
X-Gm-Gg: AY/fxX7YMGCCeDqAG9Hj7PgWl485nSwtzms5aoOYUs7+QkHqI0f0NePkr+rJyvpBwgS
	uuDCYgwzLiV6oI7tjSwC40CyBc9YqIgvphj9aPZxcpxl5YHviAH1eH6wHw6+Fr40y+32Kbs0jdo
	7xfd1tZWTgkbT7zb6hRwagsy7ab+sWgskj228M6ivHeZRp4q/pGd21/NItOlsqggSEBikgHuCVQ
	ClWAJIDMCL9qNaFJ4VCp73Bh/C6sYHH+bnQTOUGdKA6UQIUOBDzENkSoiYlBmQU9ED4kb36GvX0
	LiY/iufLTIOon/Ifggd18lfFKmVa6Q==
X-Google-Smtp-Source: AGHT+IG2W2hQ5TkkJ1AtyYWznA3wy5vlvjGMrrIaGK85qRQkky/f2uuU+DrZoovobB2UXggCef5OYTFZR5rpgCvbl0s=
X-Received: by 2002:a05:6214:5003:b0:880:47e0:19e8 with SMTP id
 6a1803df08f44-88863aa6662mr82601186d6.42.1765443074394; Thu, 11 Dec 2025
 00:51:14 -0800 (PST)
MIME-Version: 1.0
References: <20251205234033.6363-1-swami310@gmail.com> <CA+-_CqnqT4roapfisF_6gt2P-OJ8gkw9GvRNEnWh9FQX6HU7Sw@mail.gmail.com>
 <CAMSfU+5enXOdO03=d2Nfx6infFOoema2Y7xQG9VErNN1DgbE9A@mail.gmail.com>
In-Reply-To: <CAMSfU+5enXOdO03=d2Nfx6infFOoema2Y7xQG9VErNN1DgbE9A@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 11 Dec 2025 09:51:02 +0100
X-Gm-Features: AQt7F2riJGGlUR-ojK6oEpqmIxAhOHBJbgQc3otRcgSeR3T_Kz7u1OO7DWivJfM
Message-ID: <CANNYZj_a=DgXvyRRr8igP6HLee819-DKfjTnWd8WHu9Fs5Wv9A@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v7] bitbake-user-manual: Document BB_CMDLINE
To: yoann.congal@smile.fr
Cc: swami310@gmail.com, bitbake-devel@lists.openembedded.org, 
	docs@lists.yoctoproject.org, michael.opdenacker@rootcommit.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Dec 2025 08:51:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18564

On Thu, 11 Dec 2025 at 08:50, Yoann Congal via lists.openembedded.org
<yoann.congal=smile.fr@lists.openembedded.org> wrote:
> > I have not heard anything after I submitted Patch V7. Is it accepted ?  How can I know the latest status ?
> > Please help me understand.
>
> Your patch is in the master-next branch :
> https://git.openembedded.org/bitbake/log/?h=master-next
>
> Which means it has been selected for review and tests. Once those
> happen you will either receive a review by mail or see your patch get
> merged on master.
> Merges usually happen after the patch review calls (which are on
> monday and thursday :
> https://www.yoctoproject.org/community/get-involved/).
> Ping back if nothing happens in a week or so.

While the process description is correct, all of this has already
happened, and the patch landed in master some days ago. Which can be
seen in the link above! It's just that master and master-next are the
same at the moment.

There are no separate notifications for when patches are accepted, you
just need to check the upstream branches, either get the latest
commits with git locally, or look at the commit log in a browser.

Alex

