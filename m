Return-Path: <kergoth@gmail.com>
Received: from mail-ua0-f180.google.com (mail-ua0-f180.google.com
	[209.85.217.180])
	by mail.openembedded.org (Postfix) with ESMTP id 835657828F
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Aug 2017 16:45:55 +0000 (UTC)
Received: by mail-ua0-f180.google.com with SMTP id n29so24797255uai.5
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Aug 2017 09:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=yIhwH6D3Z18McRVuohy1Fvg8KuLUzZjJIGTgmsjV6Z8=;
	b=MEcdy6z6OEEWxnrTqDyIKNR9NU3d/wkVwNCzvDMcbdyDs6E1US01GD2TidemVKBW4V
	k1oTEx2zxefL/xEh03LndlrhQlv2QF5H4zsf9ZD7Xk8DBqGgvlu7B7syb4gAOHoSQieL
	8XKOc817tPzoiq0rrD9fecELuro+PucOJO13Bce4apBgSjVTKqvsWsZ1QXA7RKWCLsve
	pT6/Pt3noa17NZdypVm3OsPKsIJ5urTlrTXYvhaJPUKDOzzvQkOisz3w0TsjGa0ZVT13
	QyMKvKskSKg7/IT9i/Er40nT02rAGdhCqA2v5Aq4ua3DNl7i+zwIW646Sd81NEtQvjLh
	9lig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=yIhwH6D3Z18McRVuohy1Fvg8KuLUzZjJIGTgmsjV6Z8=;
	b=jlBFmgjbS9+RWszTuFjmqXaLsaYmHz7rhMUPYhv+pYBj56p5wlV0e6VvGhXnnXUAjK
	cWY8Rhu966fV4XVfEH/nqlJRML5LgKRp5gOEh6buZkgW5pzThZyyjhi4SSleSXIeIWSx
	bVEWXcAGkiXyijaIUnKt+P6cQyyWwBz2TOiVXFTVZFwKxaSu9ajexUXlekrkedg8ICqz
	hz+7HRcxVvLXxLPPB/RJupr9wWBEZn2bFi8rUmb2ZpMMK6RD/1fzNKyKpcGon2eZ+RZO
	sp0mIpd7o89UYR/yObPajW/YVhj85s4luaXFkZze8pFLYQnhweYnIC4mDFK+yScIWRcG
	uf5A==
X-Gm-Message-State: AHYfb5ivMF19O/ZCkcgVnnehoQfgG3SH0wumQPBxw9hBma2zcRnbgbnf
	ooRKlORHm7/Q07lfg/I4vPI+PA+CumGa
X-Received: by 10.159.33.97 with SMTP id 88mr11874897uab.5.1503333957064; Mon,
	21 Aug 2017 09:45:57 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.176.16.12 with HTTP; Mon, 21 Aug 2017 09:45:36 -0700 (PDT)
In-Reply-To: <20170821163741.28301-2-kergoth@gmail.com>
References: <20170821163741.28301-1-kergoth@gmail.com>
	<20170821163741.28301-2-kergoth@gmail.com>
From: Christopher Larson <chris_larson@mentor.com>
Date: Mon, 21 Aug 2017 09:45:36 -0700
X-Google-Sender-Auth: wXGQReVX3w6wDXiNY_lehEoBEdw
Message-ID: <CABcZANm7gGjDbwWJbLTXYn_zSM6G9phHfgxA3Tp78CDVwzT9Og@mail.gmail.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: Re: [PATCH 2/2] Revert "fetch2/gitsm: Fix when repository change submodules"
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
X-List-Received-Date: Mon, 21 Aug 2017 16:45:56 -0000
Content-Type: multipart/alternative; boundary="94eb2c0b321a7d60b305574636b4"

--94eb2c0b321a7d60b305574636b4
Content-Type: text/plain; charset="UTF-8"

On Mon, Aug 21, 2017 at 9:37 AM, Christopher Larson <kergoth@gmail.com>
wrote:

> From: Christopher Larson <chris_larson@mentor.com>
>
> This reverts commit 12f6c0651af8bd5d6efb751690571cf2fcd3eeb0.
>
> This commit caused the gitsm fetcher to download submodules from upstream
> in
> do_unpack, rather than using the previously fetched submodules from DL_DIR.
>
> [YOCTO #11830]
>
> Signed-off-by: Christopher Larson <chris_larson@mentor.com>


Hold off on this for the moment, looks like it broke use of gitshallow.
Fixing now.
-- 
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Senior Software Engineer, Mentor Graphics

--94eb2c0b321a7d60b305574636b4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Mon, Aug 21, 2017 at 9:37 AM, Christopher Larson <span dir=3D"ltr">&=
lt;<a href=3D"mailto:kergoth@gmail.com" target=3D"_blank">kergoth@gmail.com=
</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">From: Christopher =
Larson &lt;<a href=3D"mailto:chris_larson@mentor.com">chris_larson@mentor.c=
om</a>&gt;<br>
<br>
This reverts commit 12f6c0651af8bd5d6efb751690571c<wbr>f2fcd3eeb0.<br>
<br>
This commit caused the gitsm fetcher to download submodules from upstream i=
n<br>
do_unpack, rather than using the previously fetched submodules from DL_DIR.=
<br>
<br>
[YOCTO #11830]<br>
<br>
Signed-off-by: Christopher Larson &lt;<a href=3D"mailto:chris_larson@mentor=
.com">chris_larson@mentor.com</a>&gt;</blockquote><div><br></div><div>Hold =
off on this for the moment, looks like it broke use of gitshallow. Fixing n=
ow.</div></div>-- <br><div class=3D"gmail_signature" data-smartmail=3D"gmai=
l_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><=
div>Christopher Larson<br>kergoth at gmail dot com<br>Founder - BitBake, Op=
enEmbedded, OpenZaurus<br>Senior Software Engineer, Mentor Graphics</div></=
div></div></div></div></div></div>
</div></div>

--94eb2c0b321a7d60b305574636b4--
