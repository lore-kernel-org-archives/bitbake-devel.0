Return-Path: <alex.kanavin@gmail.com>
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com
	[209.85.217.52])
	by mail.openembedded.org (Postfix) with ESMTP id B32EA7FF1F
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Jan 2020 15:10:46 +0000 (UTC)
Received: by mail-vs1-f52.google.com with SMTP id p6so4334881vsj.11
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Jan 2020 07:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=kPFts5aWY8m5kn1dI0H2H7baGygP9Tn6SiTgi+Jhk7Y=;
	b=IukIT6ZGF9OK53H8E0bqAptNQMw4lHr25vZi8RNsHncpelgYZqsin+qqeZoXicBbyt
	T4heJp/3wUPlrfsSZjwQ8x/AoYv4FPQL6pUg+xpK817aT21cRdyGUQNVxIGdyWTMVr4B
	L8ZxqQDqnzXHWk+hlmx17yBvBXxGAO/PqcUbk1Q3bQHH8MEricN0Bju1Ow1S0LIByYY5
	gkQ9HekokWkkmuiPGIrAIcvZbQ8vvs37VL2vYD/m0dP+H+DNSK1NJtL+Gpx0dq/RF+Vp
	WvfGPQ6UyOcIbe60IPy5hKyDeWu2OK8kqia0S/OaPiI430A3XG95qydBIb2CO8M82tsZ
	gdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=kPFts5aWY8m5kn1dI0H2H7baGygP9Tn6SiTgi+Jhk7Y=;
	b=tvqzbPxGSyBD3iZwf3hOO74tOl8ESQkLWCVKkz+VEAVa0ZgopoHlr1m/H745uh33mr
	0VZsPkCRzZ8Jph9YQ+3ncIT5h0l7hr/HHaKNuhn8soNHeTgGomf5cqUoaUrxiYaBfPy9
	VYOFfco9qV3EkMweF5+tTwowwV1sc6fpUSy6F5Kz7cqNQMHzWidImMxuC/q5IkQYmjD6
	Mhk6+u1QuEAtCv+InxhDOmH1zFjN4UK6yf2uXnHAxQAlqQ53/yR1i26OOotyTL2ta8kw
	nhbh8FtdKy/+eOE1WNmgFOjZ6TgKWzYoHazeL4v10QaurYOjbDvlHTy+ZW86d6joiFZA
	6z+Q==
X-Gm-Message-State: APjAAAWtQ4Lj8JvCr07ijcGytfjsqQNgTvucvEgBaf/nbcRg8+riixwc
	NhnTA2wnrZMdxOAaEta7HnFJ+QmNI1iOObJgQShgqA==
X-Google-Smtp-Source: APXvYqyvz+Z/aHQA3IjkJ0v+vKmDIswFw2w9U8y6fsgwgIJILGiIUyHJ3epJLQHNWNfUq/RblZeZlZcE9MluYWbt4U0=
X-Received: by 2002:a05:6102:405:: with SMTP id
	d5mr2792234vsq.94.1579705847449; 
	Wed, 22 Jan 2020 07:10:47 -0800 (PST)
MIME-Version: 1.0
References: <4bee3ba1-3608-5598-b168-1e6009bdc986@linux.intel.com>
	<CANNYZj8CRSC3V8K08-dpEmGg5zbY9N4jiJPQhia04d7NRKiTEw@mail.gmail.com>
	<b64ada55-a892-09a5-13b2-f76e2b0507d1@linux.intel.com>
	<a4d78a27-50e6-ee87-bcd7-71694b7da60f@linux.intel.com>
In-Reply-To: <a4d78a27-50e6-ee87-bcd7-71694b7da60f@linux.intel.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 22 Jan 2020 16:10:36 +0100
Message-ID: <CANNYZj8S5A1qKy8m_=pPfP_Hbqs7qzYqE-rwMf+DGE0ivnBxpA@mail.gmail.com>
To: =?UTF-8?Q?Adrian_Ambro=C5=BCewicz?= <adrian.ambrozewicz@linux.intel.com>
Cc: Bitbake-Devel <bitbake-devel@lists.openembedded.org>
Subject: Re: devtool hardcodes using 'git' patchtool which causes errors
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
X-List-Received-Date: Wed, 22 Jan 2020 15:10:46 -0000
Content-Type: multipart/alternative; boundary="000000000000e30cf3059cbbed4b"

--000000000000e30cf3059cbbed4b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 22 Jan 2020 at 16:06, Adrian Ambro=C5=BCewicz <
adrian.ambrozewicz@linux.intel.com> wrote:

>
> My question is - is there a way to have both of these patchers working
> with such folder structure? Maybe 'S' overwriting was not a good idea
> after all?
>

I guess the problem here is that S is used for both patching and building,
and the 'root' for these may not necessarily match. Maybe there could be a
variable that, when set, overrides S for the purpose of patching.

Alex

--000000000000e30cf3059cbbed4b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Wed, 22 Jan 2020 at 16:06, Adrian Ambr=
o=C5=BCewicz &lt;<a href=3D"mailto:adrian.ambrozewicz@linux.intel.com">adri=
an.ambrozewicz@linux.intel.com</a>&gt; wrote:<br></div><div class=3D"gmail_=
quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
My question is - is there a way to have both of these patchers working <br>
with such folder structure? Maybe &#39;S&#39; overwriting was not a good id=
ea <br>
after all?<br></blockquote><div><br></div><div>I guess the problem here is =
that S is used for both patching and building, and the &#39;root&#39; for t=
hese may not necessarily match. Maybe there could be a variable that, when =
set, overrides S for the purpose of patching.</div><div><br></div><div>Alex=
<br></div></div></div>

--000000000000e30cf3059cbbed4b--
