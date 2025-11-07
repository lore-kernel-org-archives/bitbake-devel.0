Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69ACFCCFA05
	for <webhook@archiver.kernel.org>; Fri,  7 Nov 2025 10:15:09 +0000 (UTC)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8174.1762510505623888883
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Nov 2025 02:15:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Fwkbcjmn;
 spf=pass (domain: gmail.com, ip: 209.85.160.175, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4e89de04d62so4881731cf.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 07 Nov 2025 02:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762510505; x=1763115305; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4yr1y2mo4CN5/xH9jOAQ5bt9CFq/5LRK74Tv/19U7M=;
        b=FwkbcjmnTZNrl4GFUhhlcKjPGruV6WXLM+bhQoyZBC/kW0CGexSgSBdg2E2vYL/t+3
         eJxeKioOYYNuxcyGEWyNuM6KV14nGAyD4Tk71XmUDKkR9sCqmJqNVkgyMbFzBxFTyj8I
         n250MPeqZipOLVQMctVeCB61gS9rTFhAr1AB2i4K3NMxSU+PhvU+IfQ94GwW/tU9F6tG
         L6DAr6PZb7xhIqt/jITXnLEpCJvPZU+R5dF02MOifT+Ry76ZIEjBMQm2rFOpFEwHzcSp
         sm61uiZtk81RL3fWf15ODgdJBG5V+I+XxLRMZ+xfyZgFIRtRK0DcbXoAEHXQ2V5b2yuz
         3Www==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762510505; x=1763115305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m4yr1y2mo4CN5/xH9jOAQ5bt9CFq/5LRK74Tv/19U7M=;
        b=CXEAtKhSucQBqmY9wGyA+M8CsMDx0rJC0qeJMai9PmsrSAZJbw4n0rdoL3lO81Ag3n
         hVR9i2QK07N0FyiXiukR96Vf2A0oMNk7Ee4rAZKGn+h3uU3CpC/Ys7fTFmgIlofvDfWl
         MUnHzv9n8VwCZAd1UWaOHSRyyS3Vl0M8zF//E0+emvvQlnNEIuZxQm9xAQ+cKQGyiSwz
         G3G0jW7vB5KkZj898zvS5IKf1FePE5ZtcVge989pGR3RelLJtkaLyhQ96xxBiww+vgpm
         20tcRX1/mAG8GLkB5k3WfoaPijVy/nY+C+ULrFjxrx6YRczScYkf8Yn7SPmCJaRptwS2
         jC3g==
X-Forwarded-Encrypted: i=1; AJvYcCV6aLPKrvHmXS6g/4WY8dXY2NOZhIwzKRFlFMBMTGrjxrII5bNVmsO3MN6P5ETryMNtAGW5P5Jn+68JP9Zd@lists.openembedded.org
X-Gm-Message-State: AOJu0Ywb9toYs6FbZkSgeAXkwPcE0QqwzyCeCjP7FXfQY8vJf5sZZHuz
	dl+xlReukUab8cqS+s74BX/Qs6z4gq1xZo4gVeF/8oAsLSFZW0WzHM13xDiEg/MfyA2giFG+8fZ
	wBiBu7EUXJsioEF7MsIS76L79tt3duEU=
X-Gm-Gg: ASbGncsrzkE3lN7FgcRkQNUtOSmbo0gWcZ+poJh8w/dDACMQfeiSBUc45OM7r+uNbEh
	yZv2iVQGyjS6nlUBBTrhcovwks+/6g4H4TmVi2OcRM46zL3r8TXgqaB6GK8GO0ermMm/eyexa3V
	lTiS73wCJEZqfRPc4zzlQaZfa/WYeMa/E+SrilOOBTTSG5lb08rEa6meLF4UtzmRXB7JGy5yMIf
	4YEWHp5Xs0NASOJJ/H12rf66qgcurCbxa2aCjd6BfMpFV9NxHArYlaKsDMfwI0K2ybTDVmAUcBo
	k5NvOpg+k5QVc7VyXwt3IANbKOJhIQ==
X-Google-Smtp-Source: AGHT+IGdSnEqVP1oduvXo+14mGmuOme+7P3FJRKhvK42SN6E8lbV+nYyZK1owj80gwHZHBn91Plsv++ylA6yKmQn1Zc=
X-Received: by 2002:a05:622a:134c:b0:4ec:f9eb:ff8d with SMTP id
 d75a77b69052e-4ed94a83f62mr26400551cf.79.1762510504596; Fri, 07 Nov 2025
 02:15:04 -0800 (PST)
MIME-Version: 1.0
References: <20251106114714.918370-1-alex.kanavin@gmail.com>
 <DE1LO4GV39WM.156UBA1PODPOV@bootlin.com> <CANNYZj-pgb6SMxhzB4g-siGY7oWaNjb=jOSk3m-TRKLwHPytFQ@mail.gmail.com>
 <278bb2544a713588af57889f35197e0c6f424c8b.camel@linuxfoundation.org>
 <DB5PR02MB10213C5C0AD578C01BF7DB065EFC3A@DB5PR02MB10213.eurprd02.prod.outlook.com>
 <CANNYZj_qwFt6F-LEwMqe0D04dy7t9_FJMWf1tpCUZ0bayfdUZQ@mail.gmail.com> <daa19e97cfc92bdfdfdebc0b344dc11c6462d0fc.camel@linuxfoundation.org>
In-Reply-To: <daa19e97cfc92bdfdfdebc0b344dc11c6462d0fc.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 7 Nov 2025 11:14:52 +0100
X-Gm-Features: AWmQ_bksc7JtOlMY6rETi5KNom15AZUbM7RBry6zC2wGkOtJ_QnBKvCGqUH1bCA
Message-ID: <CANNYZj96A91YLjusG__6Nb0G+5xzsqTXSmPxha_H25J2H6RpVg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: replace {THISDIR} token
 with an explicit keyword
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Peter Kjellerstedt <peter.kjellerstedt@axis.com>, 
	Antonin Godard <antonin.godard@bootlin.com>, 
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Nov 2025 10:15:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18302

On Fri, 7 Nov 2025 at 10:55, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> > I tend to agree. I=E2=80=99d rather call them =E2=80=98bb-layers-in-sou=
rces=E2=80=99 and =E2=80=98bb-
> > layers-in-this-dir=E2=80=99. Patch is coming even though I=E2=80=99m te=
chnically on
> > holiday since midnight. This is important.
>
> I don't agree with "sources" in here.
>
> I think if we call them:
>
> bb-layers
>
> and
>
> bb-layers-file-relative
>
> then this should be ok? I agree we need to get this right.

That's not too bad, I'm ok with it. Sadly I'm running out out of time,
as travel is happening today, so this last tweak is on someone else
than me :-/

Alex

