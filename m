Return-Path: <alex.kanavin@gmail.com>
Received: from mail-vk1-f194.google.com (mail-vk1-f194.google.com
	[209.85.221.194])
	by mail.openembedded.org (Postfix) with ESMTP id 92AB261B18
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  6 Mar 2020 11:18:26 +0000 (UTC)
Received: by mail-vk1-f194.google.com with SMTP id y125so499003vkc.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 06 Mar 2020 03:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=fjrthkpg4Hn4pNB7cUcBo7qyK0FLgkwy0mJRqtryeMA=;
	b=Kc4Ko14oO7YDShklnjMayJ8qCfvrQ21J2tZLsQU6XfdQebqrUKU8a7ekGaqaHUgq1r
	2Ul5n9TQ44PEK3C87BdmWDVxcP3Wc9q21JqjmkcjJuQ/r9pqN5ULXbZpnPdpolZQEIHE
	BSY0NIgQGRGBa12eRFOzdP02GVsQtddymI0/Wpi9MYmqPRFobDhkRaCrDFjCYLIS/Abw
	nv4lxnB3rtyQnT3mtoYJn9WipvEyaEf1Asmm1+sSm1cDc1uev+sv3qiwceJBRyyHCGbm
	KXeIviKNlloFWhc4UJFNEBk0NNcVxnsVZ8hMxSh45GCRpOqJ9Xq5On/Occo8Nnpx7l+N
	VL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=fjrthkpg4Hn4pNB7cUcBo7qyK0FLgkwy0mJRqtryeMA=;
	b=MAaZ10+90x0+4HPxiVIzTb3td8p69iE/hPRa4s9V/kbr5uz9YdUAANvRH3y25kxJgI
	BbPTS9xmUix11YpfBNzFMDhTz9cIUJCecmkHTLc4y51DpFN9Ch5I/K0QikxLKFJo4QvV
	SeCnUBgCJS/s+zUTw5FqzF2uXSVtDKGe1ijgh+4kcilocxd5UdDaucKkJA2zYb39IOGB
	n03LzM+T77hBo+Pwqb2WoVweBWY7A0UIeEkIihAPkv5+hhs+dRBjwIOBzft1ifhl+Ooc
	2OL/Hrof4qVj9FvK0SeKS07C/f6a13sRdOnlLMfpZCFP+k+8lUtKfkWMgERmtoiqjcyp
	qpOg==
X-Gm-Message-State: ANhLgQ1HZ3jq0NB9Wg7r+fY1h+NzwRY0MV4XMPDlfWlcbvPQngWYVtkz
	dicGGf8s0mRyPl5+Zj1BXqCkFhcbLPCEzzDzSbkthw==
X-Google-Smtp-Source: ADFU+vuw+3QfpBHj1oXb25yY9ineXcwEOEVtfBgfiJQd4JA2s4dtPUkPxU4QX2H7YTEAJF2j5pR3RN10AnN7BDleQKE=
X-Received: by 2002:a1f:38cb:: with SMTP id f194mr1260478vka.29.1583493507446; 
	Fri, 06 Mar 2020 03:18:27 -0800 (PST)
MIME-Version: 1.0
References: <20200221205213.16130-1-bunk@stusta.de>
	<e349f1cc1d3b36fdff330dc7eab1f213a67d32b1.camel@linuxfoundation.org>
	<20200223195148.GB3444@localhost>
	<49d09c50265086a49798d59c8569323c37bba430.camel@linuxfoundation.org>
	<20200224054945.GB6683@localhost>
	<f5a7208c16b4df00445cb280b3a556923c07db97.camel@linuxfoundation.org>
	<20200306102420.GB17785@localhost>
	<c6f30f1b074af551a0b46837237c21e44e699c19.camel@linuxfoundation.org>
In-Reply-To: <c6f30f1b074af551a0b46837237c21e44e699c19.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 6 Mar 2020 12:18:16 +0100
Message-ID: <CANNYZj-YKaO6seiURmbz79HRwT98DE9wKtTseHncYgOKA8CWDA@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Adrian Bunk <bunk@stusta.de>
Subject: Re: [PATCH] Lower priority of debug messages that should not be shown on the console
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
X-List-Received-Date: Fri, 06 Mar 2020 11:18:27 -0000
Content-Type: multipart/alternative; boundary="00000000000003fd4105a02dd08a"

--00000000000003fd4105a02dd08a
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Mar 2020 at 11:48, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> You'd be amazed at
> the work in writing public statements and your reaction to the LTS
> announcement will sadly be held as an example of why I shouldn't talk
> about resourcing.
>

I am fairly sure that example is an outlier, and not a common data point.
Both in substance (claiming that it's easy to misrepresent the LTS
announcement - not true), and in tone (various toxic accusations).

Alex

--00000000000003fd4105a02dd08a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Fri, 6 Mar 2020 at 11:48, Richard Purd=
ie &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org">richard.purdie=
@linuxfoundation.org</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">You&#39;d be amazed at<br>
the work in writing public statements and your reaction to the LTS<br>
announcement will sadly be held as an example of why I shouldn&#39;t talk<b=
r>
about resourcing.<br></blockquote><div><br></div><div>I am fairly sure that=
 example is an outlier, and not a common data point. Both in substance (cla=
iming that it&#39;s easy to misrepresent the LTS announcement - not true), =
and in tone (various toxic accusations).</div><div><br></div><div>Alex<br><=
/div></div></div>

--00000000000003fd4105a02dd08a--
