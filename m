Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFCCC9EC86
	for <webhook@archiver.kernel.org>; Mon, 12 Jan 2026 12:52:13 +0000 (UTC)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.32190.1768222323250875596
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Jan 2026 04:52:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=CdDtmUHG;
 spf=pass (domain: gmail.com, ip: 209.85.222.171, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8b2ea2b9631so732841085a.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 12 Jan 2026 04:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768222322; x=1768827122; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kirqxFLpJBVn5JmHIyCCQiuywr1GABm1ju/tMvEzakQ=;
        b=CdDtmUHG9yfFNCTryeqebOM+qxnv5XGU9tGWQ/03s0822jntoPjN3z8jimcdgVi0mn
         0gAtgu5x274J/NkhjmcQ3XW4pXPFEqdckYsAsXK87AKX05BddQe9Jwexvrir3uJ4VUGh
         rbY6cxuTRtvXkOLYpM4IId9icJYTRB8/5uZRjgvFHfCHXxrITpCl6xLt/WNEvtXZIHE+
         2J6Q0RXBH6IQNIrZhgHHJk6frPLh/UWuSbJ7DjuV3JOUAe5oyP7uMOlE6I1ThotJen9+
         jgxgU7XNYcCaDmPFMyCDy4y+KUatRFglUdAkfuMlqgtD1PX9zbWA4AJR7cn+77DFKl6b
         xqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768222322; x=1768827122;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kirqxFLpJBVn5JmHIyCCQiuywr1GABm1ju/tMvEzakQ=;
        b=mufYn11A/kuu/J1aZJnbYtZjPwvqx7uNcraVl1RWf5qfDDjChnovW0Z7Ev5+t3l9wb
         JXm9HL1TA297xiIG6jXjDf5p4mILH7azldy+mPdtUhx9nAZap2VBIvp+LYYWaa51VP4U
         FU9bfem9It3c46wGFqQygR3ffXjDVLMq2f8TAVS6BTbz6Ia0ITv3W4DazXxJH5sGGBjj
         TngbIDQ1oW+FUv3AK0r5jJFQX+17ksynwiuPyH9QCcMs+UQcuiR5kA9NhHmRYqz0Yv7W
         gP5FEB5x+UhuDB7CFHrjNIiw2esLKL07lWta0pGqR92jHz+l4BjweT8w6hbuohNJSiaf
         8XBg==
X-Forwarded-Encrypted: i=1; AJvYcCWU/D2/fN9de/6q9lyRtgWDLexVdvRN3Pai/w+sg06BUHr7fDMhGXQquP9bEQM7Aa/Ov4vSmIhra2GecLom@lists.openembedded.org
X-Gm-Message-State: AOJu0YyvaKETuJa6OTorvuYJ3A4KPDyxRUKQ8s9faUBFiY743jH3huiW
	SkcqIyoV78L1jbtdQbBgZ0mEduTARHGN9fcNtinR1C0vtgM2WPh3OTgdkuFK5VN17tYtFt0j6LW
	vwawagBHEG7KCQyAALQNEJLFlqydMkz0=
X-Gm-Gg: AY/fxX79nJSrL3+YSjituihFo4j5GpcFagyiRE1S8aqp8bB7/VheyOl7LvEjLoJKECu
	BiQAIGAXZuTUxOQy/nKx5we9OtSdqsjo72eWAgQ/ICqZvDrQQRlHGrSrIzOECHk/ZQvWB4cPqz1
	RnayrmwpBncqWBrU7KckrZZQIaD6BL98Phjle+F2Nq+ISsh+WI5kdG+rA2o6JUr8aW4l7m7A3TT
	sAIZZv7qjQJC9r/dS5SDYqVAI/kvdwpbCoTn0h3zyh138WDxBTnvj4BZUKnjpUhSSlMAA==
X-Google-Smtp-Source: AGHT+IGqarnxpLRaDcgzPoRkP7LggVLfNTWdVrEkCDa4L5Q9RzwsKXyeYEsWwy62qXf2olTjlgwrExbXTTP5zrzWniI=
X-Received: by 2002:a05:622a:114f:b0:4f1:cab1:9d3c with SMTP id
 d75a77b69052e-4ffb4a264c8mr250419901cf.57.1768222322247; Mon, 12 Jan 2026
 04:52:02 -0800 (PST)
MIME-Version: 1.0
References: <20251215145418.2680311-1-alex.kanavin@gmail.com>
 <20251215145418.2680311-2-alex.kanavin@gmail.com> <62e07a47b15a48f0e7d80f2dcb88fd37a52bd4c4.camel@pbarker.dev>
 <f5556fb80c2b70c2ca049dec616f086df1bbdc11.camel@linuxfoundation.org>
In-Reply-To: <f5556fb80c2b70c2ca049dec616f086df1bbdc11.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 12 Jan 2026 13:51:50 +0100
X-Gm-Features: AZwV_Qj_CanEk6Z3TQh77GIJUVT7Vsb7evtxdmm0nDOEwhpsVQRekEa256UoBX4
Message-ID: <CANNYZj-2ZfJyKdrbPCj9S9DnsSAL95hK8hBV7oYzqWKjnC0_CA@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC PATCH 2/2] bitbake-setup: share sstate by
 default between builds
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Paul Barker <paul@pbarker.dev>, bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 12 Jan 2026 12:52:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18730

On Thu, 18 Dec 2025 at 23:39, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:

> > The sqlite faq you linked (https://sqlite.org/faq.html#q5) says:
> >
> >   But use caution: this locking mechanism might not work correctly if
> >   the database file is kept on an NFS filesystem. This is because
> >   fcntl() file locking is broken on many NFS implementations. You should
> >   avoid putting SQLite database files on NFS if multiple processes might
> >   try to access the file at the same time.
> >
> > We do promote the sharing of the sstate directory over NFS as safe, so
> > we should be very careful about placing the hashequiv db file in the
> > sstate directory in light of the above.
>
> We've also been telling people they need a shared hashequiv instance if
> they have a shared sstate. The number of people who will therefore try
> and put this file on an NFS share is probably comparitively high even
> if we don't show any example of that.
>
> At the very least we need some kind of test of the filesystem it is on
> to ensure it is not NFS as I don't think we want to support that.

I've added restrictions and notices about NFS, patches will be sent soon.

Bitbake-setup basically would give two options:
- common-sstate = yes (the default): sstate and hash equivalency
database will be placed under a top directory,
- common-sstate = no: bitbake-setup does not do anything about sstate
or hash equivalency; the user is expected to write their own custom
settings into site.conf.

In both situations hash equivalency location is checked by bitbake for
not being a NFS mount with a hard error if it is.

I think this should be good enough for a start?

Alex

