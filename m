Return-Path: <kergoth@gmail.com>
Received: from mail-ig0-f180.google.com (mail-ig0-f180.google.com
	[209.85.213.180])
	by mail.openembedded.org (Postfix) with ESMTP id 79791601B8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Mar 2016 18:10:31 +0000 (UTC)
Received: by mail-ig0-f180.google.com with SMTP id ig19so24809738igb.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Mar 2016 10:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kergoth-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=bcyr4jo6Vr7BdjltEo2PKtjQ34rrq+nhgTmIohilRtU=;
	b=biHltd5RYPCPLZV/LPAD5gXAU6W1nnz0D6JdRSLnyj2OHjJYYW95+8n4jcSi2ssNYa
	CQ/QURitA8hJmMVRR/fqEQhlRqM0gBXTq3hZy3BtxVQP+WdtUr6CjudysvZz2DeM3iqA
	yHgUG0IS7M+rO16QCCuzCBn6ZutLppijWnYGwbvL8r3xbJ7B3mhaQhHICiKEADbo0bgL
	2OY8Q79dd5l0qKJp1lZUehMM7hIaKXBf2P+as9j2bQPegTHZqjUzXVA9N0kTKH6G1KPa
	GDY1EUumgNBl6sifYcFnKdVxRoJpiB8ISy7tl6O+6f8Dljxp/GiJRR28bpYkzqB23Eec
	psdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=bcyr4jo6Vr7BdjltEo2PKtjQ34rrq+nhgTmIohilRtU=;
	b=MbG69drDkCsoR76RtpUX6vUe81JyEnujOygpoahXaiU/SlULOnG2qsZXhhxU/Q7Z9+
	Y9sSOsJkt+lcpfmjXpCd94ECpLCAbdghZfDzxoyb+23Xq2DRy6R5B/w2ofiKgo8YuwDq
	pAebiAV1YbjyuBtFuwQEH4VkIr4JmZxzNpAJLIvw/nRA2lWLStR8pHBEMynOO0ziMFTI
	V9Ye2rMmFj3bFCLysgsaxCGtopfdFyEQkgXTpLJcXFuixaoYLDKY3YEE8WG9AvLnNffM
	92hCDapzS1bf3pdD+lv3Y8OOJA3ZLORdf+j2GsX91nHEuq2r4emXl4ZQ/xC86XrOSBIw
	opjg==
X-Gm-Message-State: AD7BkJKp122LSNWyPCiqpsv2yeQuRLoGikl9dQU/wmId3RTWgkeOJBhcuJsczai7cO/HTZDwC/nrBF4h36KEfQ==
X-Received: by 10.50.61.234 with SMTP id t10mr5681411igr.20.1457633431881;
	Thu, 10 Mar 2016 10:10:31 -0800 (PST)
MIME-Version: 1.0
References: <1457626532-11121-1-git-send-email-armccurdy@gmail.com>
	<20160310170350.GL2573@jama>
	<CAJ86T=WeQg_r6jNk2KK5En09mFQX3m0aNtwwtxUyzGpzRFqZGQ@mail.gmail.com>
In-Reply-To: <CAJ86T=WeQg_r6jNk2KK5En09mFQX3m0aNtwwtxUyzGpzRFqZGQ@mail.gmail.com>
From: Christopher Larson <clarson@kergoth.com>
Date: Thu, 10 Mar 2016 18:10:22 +0000
Message-ID: <CABcZANkfUrM+=k26SohUFM9c359+tHTPD_yKZLMqF3sg5ntKuQ@mail.gmail.com>
To: Andre McCurdy <armccurdy@gmail.com>, Martin Jansa <martin.jansa@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] fetch2: include PV in 'Unable to get checksum for SRC_URI entry' warnings
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
X-List-Received-Date: Thu, 10 Mar 2016 18:10:31 -0000
Content-Type: multipart/alternative; boundary=047d7bdc07e2eb9228052db5baec

--047d7bdc07e2eb9228052db5baec
Content-Type: text/plain; charset=UTF-8

On Thu, Mar 10, 2016 at 10:38 AM Andre McCurdy <armccurdy@gmail.com> wrote:

> On Thu, Mar 10, 2016 at 9:03 AM, Martin Jansa <martin.jansa@gmail.com>
> wrote:
> > On Thu, Mar 10, 2016 at 08:15:32AM -0800, Andre McCurdy wrote:
> >> Referencing PN only is ambiguous if multiple versions of a recipe are
> >> present.
> >
> > Would it work with FILE to get immediate pointer to file where to update
> > them?
>
> Yes, that works. It's a bit more verbose but having the full path to
> the recipe is useful.
>

It's worth noting that current bitbake master includes PN/PV in all log
messages coming from tasks for the knotty UI already.

--047d7bdc07e2eb9228052db5baec
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Thu=
, Mar 10, 2016 at 10:38 AM Andre McCurdy &lt;<a href=3D"mailto:armccurdy@gm=
ail.com">armccurdy@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">On Thu, Mar 10, 2016 at 9:03 AM, Martin Jansa &lt;<a href=3D"mailt=
o:martin.jansa@gmail.com" target=3D"_blank">martin.jansa@gmail.com</a>&gt; =
wrote:<br>
&gt; On Thu, Mar 10, 2016 at 08:15:32AM -0800, Andre McCurdy wrote:<br>
&gt;&gt; Referencing PN only is ambiguous if multiple versions of a recipe =
are<br>
&gt;&gt; present.<br>
&gt;<br>
&gt; Would it work with FILE to get immediate pointer to file where to upda=
te<br>
&gt; them?<br>
<br>
Yes, that works. It&#39;s a bit more verbose but having the full path to<br=
>
the recipe is useful.<br></blockquote><div><br></div><div>It&#39;s worth no=
ting that current bitbake master includes PN/PV in all log messages coming =
from tasks for the knotty UI already.=C2=A0</div></div></div>

--047d7bdc07e2eb9228052db5baec--
