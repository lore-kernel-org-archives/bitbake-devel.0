Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E82CA0FFE
	for <webhook@archiver.kernel.org>; Tue,  2 Sep 2025 12:33:38 +0000 (UTC)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
 by mx.groups.io with SMTP id smtpd.web11.76211.1756816411141741821
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Sep 2025 05:33:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=PNpD2bz4;
 spf=pass (domain: gmail.com, ip: 209.85.219.54, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-71a2d730d03so14498606d6.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 02 Sep 2025 05:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756816410; x=1757421210; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aaPEfGdlBJB+mPUaAP3QSqfOQ4xX+36jFgqZPs6o8Zs=;
        b=PNpD2bz4vA6/Wgom1MuX8smFOvWFyBc2XWq7eSi55p8yCuqJrSiPITvdcxx2F22ECI
         s9cXvv9TU3mHu2RzofkNL6PUff4xF/xHCS22V6cN2CxfCxU+uJk0M3EjhXCdwyjyODGj
         K5EPYhCJpNBrsB3n/HxafTgIys4WG5V3tfHMpQn3HaglZwRiE2CaKpdH6BKSUV65CXhy
         DnrLg3Mt+L1QnEilK5HwhksfSfz4BpVoYKSH1q5qdZLC2uvK69Tw4qR4UQU02+1yFb3i
         I6x8iQEPGMdJX6xnHXOA+W4soP+8xuGf0hGqbhIkUX8dFGTATGeIlrk6/7ffa2BL7UYl
         cySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756816410; x=1757421210;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aaPEfGdlBJB+mPUaAP3QSqfOQ4xX+36jFgqZPs6o8Zs=;
        b=h30gK+9l+UqPCTC5XljQYpvBbFQqt3faWr7YG3h9aNbJJlRkM1sU7kPkFUDxSNbL6W
         iDAVD7HpD5dK36KyHLp6qUThIRMULX3eCEdK8CMQIVHDYxlaBHNrVapxQvag7WTqizWc
         KOp5qf5cb17iosCDWXVoLCzDw0z4aN8O4SEhh/0XLBELV5cWjYyp1QhEsR+S/2E27JU4
         rlgL1nXBSorlYokeHRTTBziaExCDkHbS8S9949bgQOrC2u62d3onwgyaNmv0euoYq1kA
         R9aLfbLT9vpbqtXyRjPToY8KQVZnXFV4CnfTMJf5js1Nc6JpRU1FrGThCAQN1ePWJJOE
         G+Tw==
X-Gm-Message-State: AOJu0YynvJfLSJfKz/V7RNTnkbbZKIsKmWSw6yinZKjznYGDcN9X9pLP
	CbEuJvTFm1bBGJtjvvmSGQ6w8NBd6ydCwOag4B9wBWvOJgwqt8MGA5CDHEuhX17Sj0h33eY14gy
	J+cIHRpnxHA6kd3Qai1WTErLBf1LQFpY=
X-Gm-Gg: ASbGncviAkZMdavdgGq/l2NeSi+JYTlqJLMV8225NxP7rbVBNOe9CXZ1opnJRY3/Hic
	x9SWDfIuzVtI3i9iYtNX5xrX7qFi4zMDGseKKYjomPScbEYCuMIeCt1R5FyKHxAywguy2yAYO+v
	deJjxExxyS1tgbCWKC14gLYiFHrLS34M+w5DO5i9qty4kkgU85Yzp+Q5cauzqTR2LyHlnFbdGR6
	aD5062gs3BGLCp/XjV+TOc3dJu6P4uyjGQNNUnIe5LsXSsbfAYfJ68b44qqS0HXQ5dY3iBU3x1l
	DPtWvae0E3v0FM4oRTWx4c9uiXvpSi/fxPH5nYwz
X-Google-Smtp-Source: AGHT+IGuU4snMORG3MuFX/GJ8tebo3A68p3QOKbuu+u1s2E1J+AauWdlxiz/rj4BgCc11IqDgKtNr3pkd81aQfSz/ZI=
X-Received: by 2002:ad4:5fc5:0:b0:71f:f854:c0d3 with SMTP id
 6a1803df08f44-71ff854c186mr29791676d6.56.1756816409980; Tue, 02 Sep 2025
 05:33:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250901135836.2927686-1-alex.kanavin@gmail.com>
 <20250901135836.2927686-6-alex.kanavin@gmail.com> <DB5PR02MB1021363CFCC9D5EDC1217D085EF06A@DB5PR02MB10213.eurprd02.prod.outlook.com>
In-Reply-To: <DB5PR02MB1021363CFCC9D5EDC1217D085EF06A@DB5PR02MB10213.eurprd02.prod.outlook.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 2 Sep 2025 14:33:18 +0200
X-Gm-Features: Ac12FXxoT-DN0-hTsYAJdqorw0RaerAKJNuqdOh5cu82wkeANmms_CvTDdt7Joc
Message-ID: <CANNYZj_drPD8qO_7JfYLc7Px77OdOM3Mp1MUhtd+nU7h8mnFBQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 6/6] bitbake-setup: make sure git user is
 always configured
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Cc: "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>, 
	Gyorgy Sarvari <skandigraun@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Sep 2025 12:33:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17943

On Tue, 2 Sept 2025 at 13:49, Peter Kjellerstedt
<peter.kjellerstedt@axis.com> wrote:

> > +    bb.process.run("git -C {} config user.name bitbake-setup".format(confdir))
> > +    bb.process.run("git -C {} config user.email bitbake-setup@not.set".format(confdir))
> >      bb.process.run("git -C {} commit --allow-empty -m 'Initial commit'".format(confdir))
>
> Please only set the Git name and/or mail if they are not already set
> (see, e.g., oe.patch.gitCommandUserOptions(), and check_git_config() in
> utils.bbclass). We have a global Git hook that validates the name and
> email of the committer and the above git commit command will fail in
> our environment.

I'm not fully comfortable with doing that. The commits in this repo
are created by a program, and so the author should be the program, not
the user running it (who did not give consent to use their name and
email, regardless of how harmless the content is).

Can you fix the hook to run on pushes, and not commits? Or add
bitbake-setup to allowlist?

Alex

