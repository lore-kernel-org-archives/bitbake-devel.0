Return-Path: <kergoth@gmail.com>
Received: from mail-ua0-f193.google.com (mail-ua0-f193.google.com
	[209.85.217.193])
	by mail.openembedded.org (Postfix) with ESMTP id 7323377BE4
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Sep 2017 15:24:33 +0000 (UTC)
Received: by mail-ua0-f193.google.com with SMTP id c27so2302599uah.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Sep 2017 08:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=AEKynBZBkgYlP3f9YrSHlfouzeRLimIWmqAh9R9dyLg=;
	b=e+LJOvGOsfTmQqxG8FDu/j6kHgX2FlvNbPyDCD7Y7z5OY06xYY0h5CP4fCdT1b/He8
	5Nfzwj4I1b4krMEN0y7+o0Qz6tZxtddnFn9zJRTJf1rHdAXtrX4DkKRUmqsUCjGz3c9L
	px4cYyG5Iow5HC0s2qYtJjA7lVYSfWHTFr9m7gAmsZkDvT9bpt5NVhe/s2IqdZ9rE9ug
	BHv1X82Miav1cLvQ+BOHPxRBjE2UPRZEFu/eGhp0G452WNtcCoyI6WkeYLvsvoA/ObBp
	iPlJVxMS4xTiYNXzIolA5X9oFrpYXZ53RGVFTUabHUzy8YNqHwV1FMEIh1gRbhG+SnHi
	OItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=AEKynBZBkgYlP3f9YrSHlfouzeRLimIWmqAh9R9dyLg=;
	b=QQSgkTS5JpK1ppBzSYBFSkt6hb2vGOKZFacsmqK2CMkxlS48xaaHwqTHI+zMfmI86P
	D0wEgkC4L2x23c1foCAJ06oZpCCN7dr1WvwLrgAX9j4wRpVKxUWwxcBT+5JR4H1Hk26Q
	5YtapeYntAB5SCCkykizOjFhpuGEc341KWGO1gotiuDZ3A7qgTQKPdefzkdJbeiNi0+6
	Q9YDSh4edAl3xCwQTYW8xvUNH8qkLQ+r4wcdVGzKH9UM77spux2nT55V8761L0fNjIay
	hPrXj9Dmw39Intg2TiFuvB8afO4MYGUyOHsttvstxat8cONUICkLEGD7p1NBpLpxfZOS
	2YKA==
X-Gm-Message-State: AHPjjUhtdfNHhZnsePRYqm2Vplnw2JmjXap/gF6qGaOo8YSMrTewd67A
	qogar5KN5yjolWkp4CooZCatWFMHHQ==
X-Google-Smtp-Source: ADKCNb4cksuqV2u4ulwW7SHP3nXV3jmV69kdHkWOPoG4F7Nueoml157FioPICia1h6wRGmm2jWToySi+ob9N46Fxm44=
X-Received: by 10.159.33.2 with SMTP id 2mr1592598uab.68.1504711474556; Wed,
	06 Sep 2017 08:24:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.18.67 with HTTP; Wed, 6 Sep 2017 08:24:14 -0700 (PDT)
In-Reply-To: <1504701210-10424-2-git-send-email-mikko.rapeli@bmw.de>
References: <1504701210-10424-1-git-send-email-mikko.rapeli@bmw.de>
	<1504701210-10424-2-git-send-email-mikko.rapeli@bmw.de>
From: Christopher Larson <kergoth@gmail.com>
Date: Wed, 6 Sep 2017 08:24:14 -0700
Message-ID: <CABcZANnvs4pZ5Ziuh3zNJjy1vbO4mk14+VNyOw_XaQnN+E0YFQ@mail.gmail.com>
To: Mikko Rapeli <mikko.rapeli@bmw.de>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH v2 2/2] gitsm.py: support BB_NO_NETWORK during do_unpack
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
X-List-Received-Date: Wed, 06 Sep 2017 15:24:33 -0000
Content-Type: multipart/alternative; boundary="001a114fefceee354b055886f063"

--001a114fefceee354b055886f063
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 6, 2017 at 5:33 AM, Mikko Rapeli <mikko.rapeli@bmw.de> wrote:

> 'git submodule update --init -recursive' will clone remote repositories
> if local tree does not have the referenced commits. Add --no-fetch
> to git submodule update if BB_NO_NETWORK is defined and only local
> download caches should be used.
>
> Signed-off-by: Mikko Rapeli <mikko.rapeli@bmw.de>
>

If we=E2=80=99re unpacking, there=E2=80=99s no reason to be contacting anyt=
hing remote
regardless of the value of BB_NO_NETWORK. We should be passing =E2=80=94no-=
fetch
all the time. We also need to be running a submodule sync to update any
changes urls in the submodule remotes, but there are other issues to be
resolved beyond that.
--=20
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Senior Software Engineer, Mentor Graphics

--001a114fefceee354b055886f063
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Wed, Sep 6, 2017 at 5:33 AM, Mikko Rapeli <span dir=3D"=
ltr">&lt;<a href=3D"mailto:mikko.rapeli@bmw.de" target=3D"_blank">mikko.rap=
eli@bmw.de</a>&gt;</span> wrote:<br><div class=3D"gmail_extra"><div class=
=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">&#39;git s=
ubmodule update --init -recursive&#39; will clone remote repositories<br>
if local tree does not have the referenced commits. Add --no-fetch<br>
to git submodule update if BB_NO_NETWORK is defined and only local<br>
download caches should be used.<br>
<br>
Signed-off-by: Mikko Rapeli &lt;<a href=3D"mailto:mikko.rapeli@bmw.de">mikk=
o.rapeli@bmw.de</a>&gt;<br></span></blockquote><div><br></div><div>If we=E2=
=80=99re unpacking, there=E2=80=99s no reason to be contacting anything rem=
ote regardless of the value of BB_NO_NETWORK. We should be passing =E2=80=
=94no-fetch all the time. We also need to be running a submodule sync to up=
date any changes urls in the submodule remotes, but there are other issues =
to be resolved beyond that.</div></div>-- <br><div class=3D"gmail_signature=
" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"=
>Christopher Larson<br>kergoth at gmail dot com<br>Founder - BitBake, OpenE=
mbedded, OpenZaurus<br>Senior Software Engineer, Mentor Graphics</div></div=
></div></div>
</div></div>

--001a114fefceee354b055886f063--
