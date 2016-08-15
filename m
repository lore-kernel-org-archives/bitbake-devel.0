Return-Path: <kergoth@gmail.com>
Received: from mail-oi0-f65.google.com (mail-oi0-f65.google.com
	[209.85.218.65])
	by mail.openembedded.org (Postfix) with ESMTP id 053227710C
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Aug 2016 17:26:25 +0000 (UTC)
Received: by mail-oi0-f65.google.com with SMTP id s207so4919035oie.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Aug 2016 10:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=9CokGgFl1N+wsjiB4qI6gvY3KQy55RaOUMtnbn/U6Hg=;
	b=WKDJo7Ua8IKD3aJVHcUNl029m4DvSSpPrGGMkpuMsRIhtkUcxo4gFqoSeBUOyfj9Vg
	hn++DfDBtS7KQwAnXispYO6S0o30fiIHd+dD/wGvePjjrjnf9sAwvADZSCyOgaKmFbWu
	DmqbQhs41EedTNcibOKChvCEt5Q/0KDVE2H4LJKFmoSf3qy4AMe7A/+QVdOKLlywJWvy
	GFHSdP51Y3kH0UWrjMjf9q4KbM1dUSakaZhd1L0YVr/h8Nb4rhywDSnZHglmvUIv0/Bm
	MdZXHMVc1npigS+cuJkp+KEGt34jkN2hBZeSD14PLHbEK9DDtXqkphTykTUUIXKyTKXl
	GGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=9CokGgFl1N+wsjiB4qI6gvY3KQy55RaOUMtnbn/U6Hg=;
	b=d1tC18UITuruh7/E632zw2uPuihtcQVuN/72aiZRXVxFBgzBYZNZIAokdjoMS5xVdu
	IWdhrkmkgNWe8YPgzw3/IoidbL0VxJ5DzmH6JRXEaLqSvbAlDrHFoN4hexo3+AGUlVjE
	F+uganDJJmGOgcRu0xLg17ijv1ZdzXo07xdhtKATPIZmKzBHVTdtWOy8hB22HWlZLAUP
	Eq8xxWRXj0TdbPM/qsLL1XJsPl4Cv8RiPUqHuL4Mc4HrnaSeNbD8dA+J2gROkrMNzSD1
	VPLjlUlxERnhDZUXQP2jN9yfYSexVD7XpHpKnLRvaO0BHqq51y+cxJCEUjCYZlmuTMzg
	hLOA==
X-Gm-Message-State: AEkooutYUdR7jiZ/vpG6v2+Vb1+k7lvNeulWQ2aoJ2iJdF1K3xU/7sApfk249i4NF2fNdyAALNnA4dtQ3BkP7g==
X-Received: by 10.202.84.195 with SMTP id i186mr1595817oib.200.1471281986348; 
	Mon, 15 Aug 2016 10:26:26 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.157.20.3 with HTTP; Mon, 15 Aug 2016 10:26:05 -0700 (PDT)
In-Reply-To: <1471280240.20391.91.camel@linuxfoundation.org>
References: <1471280240.20391.91.camel@linuxfoundation.org>
From: Christopher Larson <clarson@kergoth.com>
Date: Mon, 15 Aug 2016 10:26:05 -0700
X-Google-Sender-Auth: CRDGvXR1bZvWUfSNHB-GEUUDzqw
Message-ID: <CABcZANmZXsUytJS9q6uCB7ewQPHY2CPN85rtbNCmeBqAxW08gw@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] cookerdata: Simplify prefiles/postfiles
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 15 Aug 2016 17:26:26 -0000
Content-Type: multipart/alternative; boundary=001a113de352292d64053a1f88a6

--001a113de352292d64053a1f88a6
Content-Type: text/plain; charset=UTF-8

On Mon, Aug 15, 2016 at 9:57 AM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> The current codepaths are rather confusing. Stop passing these
> as parameters and use the ones from when the object is created.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>

Looks good.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a113de352292d64053a1f88a6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Mon, Aug 15, 2016 at 9:57 AM, Richard Purdie <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.=
purdie@linuxfoundation.org</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex"><div id=3D":39i" class=3D"a3s aXjCH m1568f233b37324b8">The current =
codepaths are rather confusing. Stop passing these<br>
as parameters and use the ones from when the object is created.<br>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org">richard.purdie@<wbr>linuxfoundation.org</a>&gt;</div></blockqu=
ote></div><br>Looks good.<br>-- <br><div class=3D"gmail_signature" data-sma=
rtmail=3D"gmail_signature">Christopher Larson<br>clarson at kergoth dot com=
<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Se=
nior Software Engineer, Mentor Graphics</div>
</div></div>

--001a113de352292d64053a1f88a6--
