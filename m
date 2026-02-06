Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7B5EE20A2
	for <webhook@archiver.kernel.org>; Fri,  6 Feb 2026 13:16:42 +0000 (UTC)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10909.1770383795262061123
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 06 Feb 2026 05:16:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Vs49zhrc;
 spf=pass (domain: gmail.com, ip: 209.85.219.49, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-895071c5527so8779536d6.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 06 Feb 2026 05:16:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770383794; cv=none;
        d=google.com; s=arc-20240605;
        b=O3CSOqSEJkowU0t31t87OL8coj5FrFLW0xMHubampdnnwNklkMzCEIAVQwIOBcd7WO
         yQm/UiQeucRLkDmnR4AsPviqANN1+SA3Lw5x3n6DFkubjX6K4EICGtSXYUe/UejFDVhD
         q89coRVa7FPY3wbD6qHKcWgapKhpYKktZP5/B1pwovzxCBwn1VUkDWbsEk/md5/Youvj
         RQgtRgaV0hyxZSzAxusu5C+pVAGdbBmvvfiOJISTYD6VvQ3TNOw/+hzRQFGDlhn/Ne1h
         apSa0p/4ZkMVs7TAsht4OVKvh378Ii5u2Y0mIqWqZFkNHecRK/8ZE6PGpqj+Kp57D6m+
         QwqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MjceHFabuEO96K+R0cZPAoaOnWTkmEq/3gneEEpVtdg=;
        fh=UKjg7+e1ASFE/E0YQLQJQIfgNiDcwCEt4xLjmEy9+m8=;
        b=lr0ja9m876qH9HryPPYsP9en6qyYW+TKKs4qBr8azOYStSoVYDzKdioghgDjkVMnC0
         bYpq+h73nM7yWZ4NGb7huhmQHCxfNrwqXC8y828CUW2JsVCO6HXfFAPFL2O1g9ZF0kOT
         JjyAZQ2KnHjwpoc82FLKZVcHN5BEWpBwgfwnoW53RpMHT7y8swS/q6xwI5gXTiHd1Dba
         03u0sMuTIs5N52OFfxjk+lfXxh5XEIj4xVJ4dUdD1MYUxQoJOROYprDw9HEEAb90mRfa
         VF067DVpKwJDxZS/oVVT/ZYvBQ/2aznT9OrDJBOpY1cVr0Ck3sEhF2poiCvna5kmO6Gu
         lUPw==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770383794; x=1770988594; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MjceHFabuEO96K+R0cZPAoaOnWTkmEq/3gneEEpVtdg=;
        b=Vs49zhrcne2yUPUAMiMa2+xoXt2EREOscm33QGrGl/+cq6mkjRpAXqxwrX0r0SJXhj
         //7rfi3FxpLMtN4wz35gM6N9/Ue57aNeLx4PJk4VZ6XJEQ1hsiu1WHv/b812mogGVHJV
         EIQjqTCdiqWAYi+mbtBroWtBHiLLEvc8aHwSDEDZrpWkzkMN3+aUCZsOHIA25rl+3OkP
         waPIJCmTNHQEQpA4HMFZ23JRkbOAWy1fkvSEuI5CVCLa4gHirCjgoTnMxH8+75Mf30Wy
         7KCBvMkM7JUY8H3JqoBVlWnvrpPjJtdQVewI3f6JNHBgwiMbk2oXVZYUkDMV8kZv0wxJ
         P9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770383794; x=1770988594;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MjceHFabuEO96K+R0cZPAoaOnWTkmEq/3gneEEpVtdg=;
        b=Q1L0+lfdyXbmN3ROn2LOajeUGGQUmsX08Kf4Mr9QmOFv38lrCbrnm9kvX3zqWrxK2j
         n9wJZ6lKxajTY1hIIjUWsYTPSRp04HRQUEJh+4mfvcSVaD8ad7I/Zm8HwWQXrBCZ5hAy
         1BmuaidJjOm/e+oiw5RdcJroq0+fCrfdVMNHzzhU3g3oUdkBZRvNywW7xL2FadjYFfXJ
         K65a8EBW8qopUbLk6a1BVk5Pqy1Cn8+M5ozmE3hHVQezQuHny4yO6t05/YpwGZMlNr4m
         aoYZtoM3BCT4qooTMYEoMjdIB/zVSvG8SGR5S0O8KTjpO9UAJiJV4djfsr1TTRTkchMn
         GKxw==
X-Forwarded-Encrypted: i=1; AJvYcCV/lqX2Vnj4qKGMMFZtOMEQgEUl4RhNEqtho/rpvC5cR5yL6bLhFML13DTGDX/b/Z92OjUlokNz2xm1ynyc@lists.openembedded.org
X-Gm-Message-State: AOJu0Yz62l6VMXZ3Q9OYRU9CU0LR+m/L8SLe5EsnFMXfFDceNKnyBJYn
	jeo+RtMEnL6fIqrIdFh0kQnTG3suFR0C9Jh3FwzMSDWxpEmM2wIq7/QFwG2gKrTJ6nDg7RpTI/Z
	xZrE9z46FytWw1bhmskcidEAyXCaU4p8=
X-Gm-Gg: AZuq6aJ5gmqC52yS/Ox6wKLJ0PgwC/RkmXgkHzoEws63AuuVGFgdsHVBva+KHFAiPm3
	JJOhB1n9VC1MC2vQ4FyXFACyArG9vgIR3Yl3u+xy/1hGgA89FdnjwPg3AHqIcrtdMmF8HLGHbvj
	MWvGHssxvv0x0dRB2U33PivRJ5ShfTqBmxvMTPKfnQIwNh6qWlz2FF52j80W5l9LQD1WTwk2WjL
	j1GplkrTM74SLVhZPmBhxj+nYvIHtvax/MAfAY7/O0C4rbt3D8KsfA3huJzvdzSrwDdClfBSbx/
	/4FSRnwIZYKJXrESFgE/nOedAMMp+RZbnZXEsPDR
X-Received: by 2002:a05:6214:19ed:b0:894:3c22:e790 with SMTP id
 6a1803df08f44-8953cd9118cmr39304526d6.58.1770383794092; Fri, 06 Feb 2026
 05:16:34 -0800 (PST)
MIME-Version: 1.0
References: <20260206075522.5620-1-liuyd.fnst@fujitsu.com> <CANNYZj-O91BPn5KMaO0FVcpLqdtU7MF5RfVLQmJQyXvEjfd0Xw@mail.gmail.com>
 <DB5PR02MB10213463E2A774597488AEC60EF66A@DB5PR02MB10213.eurprd02.prod.outlook.com>
In-Reply-To: <DB5PR02MB10213463E2A774597488AEC60EF66A@DB5PR02MB10213.eurprd02.prod.outlook.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 6 Feb 2026 14:16:23 +0100
X-Gm-Features: AZwV_Qinv16vrGurpNFEigEuZMRpsL1GDpWStuyFIZw7BD0Id6Nk_P1jtdCC1io
Message-ID: <CANNYZj_PMgx+FR9jMVSuJgTKCaYe3n0yDf=y4drtypZYi4wgAA@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH v2] bitbake-setup: Add strip to value from settings.conf
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Cc: "liuyd.fnst@fujitsu.com" <liuyd.fnst@fujitsu.com>, 
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 06 Feb 2026 13:16:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18982

On Fri, 6 Feb 2026 at 13:50, Peter Kjellerstedt
<peter.kjellerstedt@axis.com> wrote:
> > > +        for section in settings.sections():
> > > +            for key in settings[section]:
> > > +                value = settings[section][key]
> > > +                settings[section][key] = value.strip('"')
> >
> > I think this is okay, but should we strip both single ' and double "
> > quotes? Sorry I didn't realize this earlier.
> Maybe it would be better to abort if any odd characters are found in any
> of the settings? Because I assume the situation would be equally bad if
> someone somehow has ended up with a path like foo/"bar", i.e., with a
> quote in the middle. Aborting would allow bitbake-setup to give a
> meaningful error, rather than silently hiding the misconfiguration.

But on what condition would the abort happen? I'm not sure I can come
up with a simple one.

Now that you say it, I'm not sure how paths with spaces in them should
be handled, as those do need to be quoted or do they? This can turn
out into a rabbit hole :-/

Alex

