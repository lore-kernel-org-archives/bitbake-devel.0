Return-Path: <anibal@limonsoftware.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6255EE6446
	for <webhook@archiver.kernel.org>; Wed, 31 Dec 2025 14:43:32 +0000 (UTC)
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.86202.1767192204949280787
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 31 Dec 2025 06:43:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@limonsoftware-com.20230601.gappssmtp.com header.s=20230601 header.b=QO7plelZ;
 spf=pass (domain: limonsoftware.com, ip: 74.125.224.50, mailfrom: anibal@limonsoftware.com)
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6420c08f886so13137170d50.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 31 Dec 2025 06:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=limonsoftware-com.20230601.gappssmtp.com; s=20230601; t=1767192204; x=1767797004; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=axAU9I7R95N8ueMk7dqV474vA+vRzLxh/ihp9spdrcI=;
        b=QO7plelZdMZX8Upf39G7ANmzxpwMckyeuvZhtDuLkKWUYZggt904Obn5TFGc9emY/6
         6JlaXN+QqEBs6Ws1IUuKDo7KKab/s0AL4Ndn5TtMIDyVn+jnfn0VnV7OknDnWFePM6Jr
         Fupvy6lfEugeGFEnS0ztR51GrzCWdyg8WK6YICNSXSEHDMXrgc6tBg+dSpuRJubB3Xk1
         lMvUZtHjwkkANkDP+7LrYVjhL+I4YfU8um9L3SZ2NKbjJkfhyjFysmw8q/pXtXnOLN3Y
         4Fji5zg1Zk+IaDxXgivblHwaLXkl373OVggZ8qsoJo5FifiTeVFtd2E4dV9l2Ssq9k34
         wIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767192204; x=1767797004;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axAU9I7R95N8ueMk7dqV474vA+vRzLxh/ihp9spdrcI=;
        b=PK5vF8heftyQZrio6cN6USVWC1Nm2wSFcVPezfpvm6w2ToUus+MZhAX6s2uvKvjVb6
         f+N3qgzDCfLnFT7lQJHIhfmHzHAh97wk+XZ5u2YvUSaS0yGQIMIAGMCCSUrY2dSAbP2O
         0DLWapX5BklxhA3B4SQevnAGGF8L1Htq/g25i+g0faetJuMe0Tdm/0JhKIAFu0bUoR9Y
         XOwOV5pg1EhIK2jTqlWahzShqtXV4E3CidHC0/Kicx6FdOOuktbzd+ZIHSeSS6HFfQTJ
         kOm3+UyWwSc/FEKNxEWW6q0UAdTwi5y6eKSOxtq+AkVrwtXCOd+Op/2VTXiqADcHC5vK
         4pQA==
X-Gm-Message-State: AOJu0YwKiWx9/eW/1UU054SnyDBctHaACvLMdi4xzTtrasDLWj5NXD3S
	1CuZTWK4yKBIjkOFSSUXLq7PgKoCsxG7gCnm/svIXqfA2JUl2kI92dT7Wj/JjY4he9Q9efkzHdB
	FmR/dlTC7QVsQuLO+uIeML/APgTIQxE6kzxNn6ot6JQ==
X-Gm-Gg: AY/fxX4ZkqOZOr4qHPzwtpbJyr8DHu9NHyfaHLL/5OG+INi3swvWIVaSkRAT0XaDZOR
	mCSqFeFnpYrOToTcEH/lha86ZhLERZnBq+lszEC/UDBOYZ0AQn4u6sijkFvzk9eo/oq5n5Y/+1B
	h8JPuEC/ux/25luf4ikB6My8d++6hTFfHRvbdqA7Zfq70utOrxwy5AOeErdLrk0PZmdj33ARLil
	vuTMX7QeuiYl+vBUGp0bt/uyLHf+NWu5tHJBMAVhI7fKWnf6FDnh7l9JBFoH5ISRXVpSq0uoyZJ
	AZzI/fSwsZhCEaJQwuqH3kvelilYS+XBTeu/xrF1/FyKI92sAHzPoPc0zw==
X-Google-Smtp-Source: AGHT+IGqS0n2W0pPc+TBOyaWTBkRfHVqbc1ink7/69k8rwuLKYqAcJ/+T+9qQEI2UjPXZOCQpxjDqeIp3KgZ3rT8rVQ=
X-Received: by 2002:a05:690e:1387:b0:644:60d9:7530 with SMTP id
 956f58d0204a3-6466a8de5c9mr30238836d50.86.1767192204045; Wed, 31 Dec 2025
 06:43:24 -0800 (PST)
MIME-Version: 1.0
References: <20251222181527.2424323-1-anibal@limonsoftware.com>
 <CANNYZj-=2r9VFg4AGfKiYbOp5Eh57uvVQt11UTT0xVWPhfxbhw@mail.gmail.com>
 <CAOU5ZMthyn3+Y9axBKSdVy3qukFo2j_eU0VnJupTZ6pX7PoPag@mail.gmail.com> <CANNYZj-uV4ob-aCWH9uQGCnmMgq0p1RCh3qeBo_fp=a6iUtqBg@mail.gmail.com>
In-Reply-To: <CANNYZj-uV4ob-aCWH9uQGCnmMgq0p1RCh3qeBo_fp=a6iUtqBg@mail.gmail.com>
From: Anibal Limon <anibal@limonsoftware.com>
Date: Wed, 31 Dec 2025 08:43:13 -0600
X-Gm-Features: AQt7F2oYk1TEyQ_WDq9kTXikVND2QaK4fjh5Li8ppEtKrmcSVKHC7i8oOYKkDAM
Message-ID: <CAOU5ZMvki7BQQ9HKccMkyEMG1sCG2zWnrD9sVW9BMNXv7trXmg@mail.gmail.com>
Subject: Re: [PATCH] bitbake-setup: _symlink_local fix case when update
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, richard.purdie@linuxfoundation.org
Content-Type: multipart/alternative; boundary="000000000000927e250647407f7e"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 31 Dec 2025 14:43:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18668

--000000000000927e250647407f7e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 3:27=E2=80=AFAM Alexander Kanavin <alex.kanavin@gma=
il.com>
wrote:

> On Mon, 22 Dec 2025 at 20:53, Anibal Limon <anibal@limonsoftware.com>
> wrote:
>
> >> This and the previous patch expose a gap in testing, perhaps
> >> status/update tests should be extended to cover local sources?
> >
> >
> > Ack. I will look at the tests and send v2.
>
> Just wanted to give a heads-up that I'm working on a more extensive
> set of fixes and test coverage improvements that incorporates both of
> your patches. So you don't need to complete a v2, but reviewing my
> patchset would be appreciated. I'll follow up with a link once I send
> it out.
>

Thanks for the heads up, and feel free to cc me.

Best!,
Anibal

>
> Alex
>

--000000000000927e250647407f7e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Wed, Dec 31, 2025 at 3:27=E2=80=AFAM A=
lexander Kanavin &lt;<a href=3D"mailto:alex.kanavin@gmail.com" target=3D"_b=
lank">alex.kanavin@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">On Mon, 22 Dec 2025 at 20:53, Anibal Limon &lt;=
<a href=3D"mailto:anibal@limonsoftware.com" target=3D"_blank">anibal@limons=
oftware.com</a>&gt; wrote:<br>
<br>
&gt;&gt; This and the previous patch expose a gap in testing, perhaps<br>
&gt;&gt; status/update tests should be extended to cover local sources?<br>
&gt;<br>
&gt;<br>
&gt; Ack. I will look at the tests and send v2.<br>
<br>
Just wanted to give a heads-up that I&#39;m working on a more extensive<br>
set of fixes and test coverage improvements that incorporates both of<br>
your patches. So you don&#39;t need to complete a v2, but reviewing my<br>
patchset would be appreciated. I&#39;ll follow up with a link once I send<b=
r>
it out.<br></blockquote><div><br></div>Thanks for the heads up, and feel fr=
ee to cc me.<br><br>Best!,<br><div>Anibal=C2=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
<br>
Alex<br>
</blockquote></div>
</div>

--000000000000927e250647407f7e--

