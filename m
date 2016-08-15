Return-Path: <kergoth@gmail.com>
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com
	[209.85.218.67])
	by mail.openembedded.org (Postfix) with ESMTP id 379687710C
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Aug 2016 17:26:34 +0000 (UTC)
Received: by mail-oi0-f67.google.com with SMTP id e80so4918161oig.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Aug 2016 10:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=mfYGZm6/BDgYumcHVtB6hLly7iNv6ZMoA2A+SNM6Bys=;
	b=elAzRAw8/fZwcEws62vjb5vMhL2nfQ4OHfWeV9rI5W14yJFIRGa9q7j6d6JSe7zTTi
	0ctCLKfOoRMlZF/xq4ZNDw8Nv+XynGClfn8ukExFPv5vMua2olVC9d6evoDRJLuXhyXx
	GK39FYD9M0geQGxz9qmkxmba08y3+noZ/kBaMoUwPd574O/DTJ2lpqAF0oQL4T1SonXj
	CVFXGJN4D3y0GFQUg9uP/lrn0VG/hzNlAAAWXsY/QJ8fcfrJxFEbQ3QgZo0qmdhTetpW
	AuuJxiM510FN0nWDM/w0k6mFMu7cwfQ9a7Y1mOgTBL/VeUy1dkq2+iZ0MriDWCO0l2Oc
	wxnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=mfYGZm6/BDgYumcHVtB6hLly7iNv6ZMoA2A+SNM6Bys=;
	b=MAhX44FbpeMHWgr1rsoJeUaAObwiMGLTlYzaO8q7a+ZfOAwoYnWPd8Cvd3KLMKiSzB
	I2f0czLEuu+STWtl7pQAFmkKqwGNp6u6CQ5gotAMsFVt52AU+WdI8OEoDy9/CCE6kwhi
	VkZOcAbT7LC+6FG309DGcXsjdbyr4NvMfcPYPRS1F3X35LYp8WJn/TMlII9J+NfvALP6
	cDCwF4NkjCLyyUbWi3dZAYX62pALfiMto1H7g1YTkgT8l2rmLsOa6nQK5FK3LzuXrKTy
	Npi6ymOxGsp6wYV/s5oQ38LrLAGu6YI2EFB1rNJ7hllKfdMp7dUGMOnFBe0pA1X9bOzm
	w5lg==
X-Gm-Message-State: AEkooutzvUxNcCrSK+EgQX2wZ+uasMSnpX2puCxMV94sNkxO+XY13a5md9znhFDhZdHayFYRlLYZkN3EfZTSIg==
X-Received: by 10.157.6.166 with SMTP id 35mr14069182otx.42.1471281994900;
	Mon, 15 Aug 2016 10:26:34 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.157.20.3 with HTTP; Mon, 15 Aug 2016 10:26:14 -0700 (PDT)
In-Reply-To: <1471280396.20391.95.camel@linuxfoundation.org>
References: <1471280396.20391.95.camel@linuxfoundation.org>
From: Christopher Larson <clarson@kergoth.com>
Date: Mon, 15 Aug 2016 10:26:14 -0700
X-Google-Sender-Auth: S0LU8J5xvxmbaywhzPdtVXR_CIU
Message-ID: <CABcZANkwV=U7dO1iAdoQixAf+jLOdskg797Kq-PNU1SVwx0RJg@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] cache/ast: Move __VARIANTS handling to parse cache function
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
X-List-Received-Date: Mon, 15 Aug 2016 17:26:34 -0000
Content-Type: multipart/alternative; boundary=94eb2c11f260abac01053a1f8844

--94eb2c11f260abac01053a1f8844
Content-Type: text/plain; charset=UTF-8

On Mon, Aug 15, 2016 at 9:59 AM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> Simple refactoring to allow for multiconfig support.
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

--94eb2c11f260abac01053a1f8844
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Mon, Aug 15, 2016 at 9:59 AM, Richard Purdie <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.=
purdie@linuxfoundation.org</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex"><div id=3D":2ff" class=3D"a3s aXjCH m1568f2552a086a75">Simple refac=
toring to allow for multiconfig support.<br>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org">richard.purdie@<wbr>linuxfoundation.org</a>&gt;</div></blockqu=
ote></div><br>Looks good.<br>-- <br><div class=3D"gmail_signature" data-sma=
rtmail=3D"gmail_signature">Christopher Larson<br>clarson at kergoth dot com=
<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Se=
nior Software Engineer, Mentor Graphics</div>
</div></div>

--94eb2c11f260abac01053a1f8844--
