Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950BFC0219D
	for <webhook@archiver.kernel.org>; Thu, 13 Feb 2025 07:54:09 +0000 (UTC)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
 by mx.groups.io with SMTP id smtpd.web10.6269.1739433246522072813
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Feb 2025 23:54:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=hWxRbNxb;
 spf=pass (domain: gmail.com, ip: 209.85.219.50, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e65baef2edso4953376d6.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 12 Feb 2025 23:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739433245; x=1740038045; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23+Qb2jxwUG3p1mn93Jt/xkd2UpFwjCA0pZOrM8LQ1U=;
        b=hWxRbNxbd9UbN1iE3G5QbI5BMLhmlDfiNWxbu0knMWxE82+jZiFu07D8ZJsNmYp1pe
         sK4F8XgE9twmxbeVayyiN070wUgCBKRMG52ma6oJePAwkaHXVwlb9SICeY7UeE6RhoD5
         2qG7OGKKiCTX07rN1f84TrhEo4ivazoNoWM5b1v2ItljacJiylf7quOwzzmErICTVpqt
         bA++yjNOgTv/+ZywyCFhSBwHsuo+vf/xLMpTXfI7NOTP7OoyfmyDksqEWCRWdGA1pdHg
         94Z5feWgWjHhCUV9rsk5+ZqXc5sS+n8RgjD5DOh2EReR6H12qHkEkvMlh9FVlrELmQtL
         sxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739433245; x=1740038045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=23+Qb2jxwUG3p1mn93Jt/xkd2UpFwjCA0pZOrM8LQ1U=;
        b=QAhPhkS1pS2r2qEQz9dD7V86BzAGMxDMEUrHrqAgKt5nig+qOBRes1vW1AsdZHgtZF
         gNKqI36QRofuQVbUhvwRE9XD1l5Gxa/Gdg+vFDOC0uiRqySzrphwUhKHl6qrIf6XtpL+
         tJ6NUCUuAyyCRFHGopG0Lv4/T8XatTezo5rac1yobsKsQpBCdXQICPnSzFATzVd1jd0t
         aJkRlG0IXoVptcQbg0cKiDocG4LymdzUDETDr4SI1AAvMdHsmJFih1Bm1LymAtuV6y+P
         pOFD2fxDrN+C1WMYDlu3L0acn22kYwbk1ltKwtglyFiEfmUu8oT18sXNhp3pAmnn1t/l
         FrnA==
X-Gm-Message-State: AOJu0YwL1U/YKxnv/TCek3CbiTaLNYG65H5IsXgjJ9R0I/Mnf4wJcNLj
	DGTwdu/dWarVQ8Bge62hyu8xKkaALIADYgFBJi/0HZKAmnPhtbQnRn955Fi5vUQPl3pT0d2k9dD
	JygHjFRmVeiSQ2hZ15wSjsaAtkYY=
X-Gm-Gg: ASbGncuiteJ1w4i/SWeWaInxV/rr04+lANeeVk1dviCfQEocSjEzym2l0kznojemDBt
	HVNp/KU+SniaVzRZ19R3GFkRs7KN7/j0bI4rSdY9FXkgjL43aVv46vwU2WtaRAclEC7mIRf7tup
	hP/kc0DUXoWKWsoMdgrXuhFamjMHaaja4=
X-Google-Smtp-Source: AGHT+IFuSGdYMt6mk4xJobFqp46Z4UqKodrswDbm4m3yuq+o3FQekej7HMdbG/rRLwqiQ6NoZ44bDF2RDC9m+Lt7nck=
X-Received: by 2002:a05:6214:2685:b0:6e4:4331:aae6 with SMTP id
 6a1803df08f44-6e46f8d5ccemr88598136d6.39.1739433245387; Wed, 12 Feb 2025
 23:54:05 -0800 (PST)
MIME-Version: 1.0
References: <20250211150034.18696-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <20250211150034.18696-11-stefan.herbrechtsmeier-oss@weidmueller.com>
 <DB5PR02MB10213E77A6A5281EE044BA688EFFD2@DB5PR02MB10213.eurprd02.prod.outlook.com>
 <81801173-8a60-4278-a8b1-70715fa5accc@weidmueller.com> <CANNYZj-D--g+ChmBH-9kP7vj7cSNrJ=fKVmSUi8zHoLJ_EUZ3w@mail.gmail.com>
 <39c5f882-3502-465d-bb66-f4da5f97e434@weidmueller.com>
In-Reply-To: <39c5f882-3502-465d-bb66-f4da5f97e434@weidmueller.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 13 Feb 2025 08:53:54 +0100
X-Gm-Features: AWEUYZk8Z77IkbBTSL_1oYWYXG1il9WsK6opEWFrVjB0uforpzG7PKD3CxQvcLA
Message-ID: <CANNYZj-BdH7fjA9o5GdFEMQKyDV8C4heXALdY-yRnf0QOsDfZw@mail.gmail.com>
Subject: Re: [OE-core] [bitbake-devel] [RFC PATCH 10/30] conf: bitbake: add
 SRC_URI_FILES variable
To: stefan.herbrechtsmeier-oss@weidmueller.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Feb 2025 07:54:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17210

On Thu, 13 Feb 2025 at 08:43, Stefan Herbrechtsmeier via
lists.openembedded.org
<stefan.herbrechtsmeier-oss=3Dweidmueller.com@lists.openembedded.org>
wrote:
> The variable holds paths to files which contains dynamic generated SRC_UR=
Is. The dynamic SRC_URIs are unknown at parse time and only the file paths =
are fix. The files are filled with generated SRC_URIs via a separate task.
>
> This doesn't explain why we need this separate new variable to begin
> with. In what scenarios it would be useful? How does the
> implementation rely on it?
>
> We can't manipulate a global variable value inside a task. We need a file=
 to exchange values between task. The vendor classes resolve the SRC_URIs o=
f the dependency in the resolve task. The new variable contains the list of=
 files with SRC_URIs inside it. The later tasks read the additional SRC_URI=
s from the files and merge them with the recipe SRC_URIs.
>
> I'd suggest SRC_URI_DYNAMIC, we have a precedent in PACKAGES_DYNAMIC.
>
> The variable doesn't contain a dynamic for the SRC_URI but instead a list=
 of files with SRC_URIs inside the file.

Thanks. But all of this should be in a commit message. And actually
even that is not enough: you need to tell where the variable is set,
show an example value, show an example content of the file(s) it
references, and also tell where the value of the variable is used to
do further processing, and what that processing is, and refer to
commits doing it.

The code is obvious to you because you've worked with it for several
weeks now. It's not obvious to any of the reviewers and you need to
help them at every step, otherwise few people will look and even fewer
will comment, and the whole thing is at risk of fizzling out due to
lack of interest.

Alex

