Return-Path: <kergoth@gmail.com>
Received: from mail-qt0-f170.google.com (mail-qt0-f170.google.com
	[209.85.216.170])
	by mail.openembedded.org (Postfix) with ESMTP id 8BC1677FC1
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Jul 2017 21:45:22 +0000 (UTC)
Received: by mail-qt0-f170.google.com with SMTP id 32so37574141qtv.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 07 Jul 2017 14:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=+Gx8NCORW6xm7jOk8KsHi4at8Xr4vLOZv2hKcDmXbUU=;
	b=JQ8L8ALwG6X63vvQmtpOAagQ4pIdCa+2BeHZ3OJaZc8EHFh9njaCpmCh9aTt24rfvU
	opqwOwgcdDyKSZZJmyrkv/4+Kr7KAXpfR70FOfpo2Yad7d16zMi8tCqz5zO/7ovjZK8Q
	RrtKWxvCO9WKZgSDw2FZkIDFIpD1EhM4MPtpRcmfJgu0jSIMvfGo+DPbQ108f24QBy2t
	cJCkFbjIVAZqov3EdTuaZHtahl3HNvoM2LxZAsGo7fyLR6lJFYyM3Vevy49nEPzufErE
	PQebnOPt9N6HaePyurhSKS7mDJ1zCdrU1U+o3HuQzjuaU8P5MuMrH+o9T9x0LerYnU5L
	rE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=+Gx8NCORW6xm7jOk8KsHi4at8Xr4vLOZv2hKcDmXbUU=;
	b=TgHqhkn3wRu4yRA9WEr+1FE/YoBT+u+jKxDzNknRqUehjWaV+6QdfKNNTb1khEiyrR
	7EJ+YY+hy5nYlisgeWkjlGIS8DyphDEdblBseMh6srcIxL3eVdFGX4qn8bKpU+ljxw5J
	3yVhSB0nmCQetgMh+XiNbXFB4ca8oxhbWYxe6E0ZF0xgcn775tN25goxcFkpi5KMumjU
	xUU9SjKeoL9vRdphlIAgzCSj0oge7wk0FYnnHaWzdb9EXYxBK1ukX+0zFEcJdNFvauPj
	iYI7yFj9ktdcQYPb/FSwGm5vGNF9Tcz02Lpb1vHzC/l05rcDUtHfiAF3fe6ZeHwPaZtZ
	febQ==
X-Gm-Message-State: AKS2vOzwHi02IKpHgLKWq8pJNAB871C8Jtwu3u6XSACUqEXb3voU87+M
	blvgmanJUWsyQdizHIWTam9uqZzdFw==
X-Received: by 10.237.57.163 with SMTP id m32mr69085370qte.117.1499463923523; 
	Fri, 07 Jul 2017 14:45:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.21.230 with HTTP; Fri, 7 Jul 2017 14:45:03 -0700 (PDT)
In-Reply-To: <1499435989-28699-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1499435989-28699-1-git-send-email-richard.purdie@linuxfoundation.org>
From: Christopher Larson <kergoth@gmail.com>
Date: Fri, 7 Jul 2017 14:45:03 -0700
Message-ID: <CABcZANn2td4WAQon776Rj84SMBdKL=5e-qWYdBAKTa6-VkSfog@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] server/process: Fix waitEvent() calls with 0 timeout
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
X-List-Received-Date: Fri, 07 Jul 2017 21:45:22 -0000
Content-Type: multipart/alternative; boundary="001a113b99e083e5780553c126f0"

--001a113b99e083e5780553c126f0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 7, 2017 at 6:59 AM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> You might think Queue.Queue.get(True, 0) would return an event immediatel=
y
> if present and otherwise return. It doesn't, it immediately "times out"
> and returns with nothing from the queue.
>

=E2=80=A6 wow, that=E2=80=99s .. not intuitive at all.
--=20
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Senior Software Engineer, Mentor Graphics

--001a113b99e083e5780553c126f0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Fri, Jul 7, 2017 at 6:59 AM, Richard Purdie <span dir=
=3D"ltr">&lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org" target=
=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;</span> wrote:<br><di=
v class=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex">You might think Queue.Queue.get(True, 0) would return an event immed=
iately<br>
if present and otherwise return. It doesn&#39;t, it immediately &quot;times=
 out&quot;<br>
and returns with nothing from the queue.<br></blockquote><div><br></div><di=
v>=E2=80=A6 wow, that=E2=80=99s .. not intuitive at all.</div></div>-- <br>=
<div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=
=3D"ltr"><div><div dir=3D"ltr">Christopher Larson<br>kergoth at gmail dot c=
om<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Senior Software Engine=
er, Mentor Graphics</div></div></div></div>
</div></div>

--001a113b99e083e5780553c126f0--
