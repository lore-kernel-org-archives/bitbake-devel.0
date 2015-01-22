Return-Path: <ross.burton@intel.com>
Received: from mail-qa0-f54.google.com (mail-qa0-f54.google.com
	[209.85.216.54])
	by mail.openembedded.org (Postfix) with ESMTP id 9E2AF71144
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Jan 2015 12:50:29 +0000 (UTC)
Received: by mail-qa0-f54.google.com with SMTP id w8so904030qac.13
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Jan 2015 04:50:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=8kyrh2GePrKvlHX1Tm52maBPgFNxe/ha1eAoO7S+aRE=;
	b=Q1F/wjWvIVDghzVT/wMDAQU5JPrjj0B9w2KgA+PuHlhayKyCJakygEpYnT93mJoImK
	LnEwAAjk10fWf8jiKBlLENjVBTgkvXWV1vX/yudzpialldBoY+z6hxojfnS+mbhShwDs
	p3INjpSGkWyzjQ7RD9bt5qyUKe51LT5Uh/Zwmn3hxu+XJxN6W2yf89pjDU6V1CNrsTrW
	ZJA5XOChzRUmJKJnuNBKhcm3xtVHv/vc8R3tY3lanKHbsQzoEeuezS9dLeMUe+bxknM2
	Y/GYT+kCodDH6qhnTT7DLmlXOjsroCkPAFVzbgKk4wNk4hrmY7T9DzhGy48Br1Pd3nu0
	ewlA==
X-Gm-Message-State: ALoCoQnXvtLHFtAQuFnI1sNVKt40VtKsCNE34/dsdIUfnVHhq5cikLE7NDgFjtf2qniuypw85Fvn
X-Received: by 10.224.93.6 with SMTP id t6mr1968047qam.93.1421931030293; Thu,
	22 Jan 2015 04:50:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.96.166 with HTTP; Thu, 22 Jan 2015 04:50:09 -0800 (PST)
In-Reply-To: <54C0BE76.7030601@windriver.com>
References: <1421158296.31262.17.camel@linuxfoundation.org>
	<54BCBBF6.4020904@windriver.com>
	<1421663325.1798.31.camel@linuxfoundation.org>
	<54BDBC83.9030007@windriver.com> <54C0BE76.7030601@windriver.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Thu, 22 Jan 2015 12:50:09 +0000
Message-ID: <CAJTo0LboyFeOwwSJANbXjwfQ88C_SeaFq1EMUn2xRwu6Byi+ug@mail.gmail.com>
To: Robert Yang <liezhi.yang@windriver.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] bitbake: Add pyinotify to lib/
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
X-List-Received-Date: Thu, 22 Jan 2015 12:50:36 -0000
Content-Type: multipart/alternative; boundary=089e01495028f4cebd050d3d1d80

--089e01495028f4cebd050d3d1d80
Content-Type: text/plain; charset=UTF-8

On 22 January 2015 at 09:10, Robert Yang <liezhi.yang@windriver.com> wrote:

> I run 5 builds on the same host, each of them is BB_NUMBER_THREADS=32 and
> PARALLEL_MAKE="-j32", I can get the error every time when "bitbake image".
> Then I use "ulimit -u 10000", the "bitbake image" works well, and the
> world is in building.
>

I'd suggest option (3), reducing the amount of parallelism. If you're
expecting five builds on the machine, then reducing those values would
reduce wasted parallelism - after all you've got over 3000 tasks sleeping.

Ross

--089e01495028f4cebd050d3d1d80
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On 22 January 2015 at 09:10, Robert Yang <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:liezhi.yang@windriver.com" target=3D"_blank">liezhi.yang@windriver.co=
m</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D":59e" =
class=3D"a3s" style=3D"overflow:hidden">I run 5 builds on the same host, ea=
ch of them is BB_NUMBER_THREADS=3D32 and<br>
PARALLEL_MAKE=3D&quot;-j32&quot;, I can get the error every time when &quot=
;bitbake image&quot;.<br>
Then I use &quot;ulimit -u 10000&quot;, the &quot;bitbake image&quot; works=
 well, and the<br>
world is in building.</div></blockquote></div><br>I&#39;d suggest option (3=
), reducing the amount of parallelism. If you&#39;re expecting five builds =
on the machine, then reducing those values would reduce wasted parallelism =
- after all you&#39;ve got over 3000 tasks sleeping.</div><div class=3D"gma=
il_extra"><br></div><div class=3D"gmail_extra">Ross</div></div>

--089e01495028f4cebd050d3d1d80--
