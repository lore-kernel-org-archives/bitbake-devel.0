Return-Path: <kergoth@gmail.com>
Received: from mail-ig0-f174.google.com (mail-ig0-f174.google.com
	[209.85.213.174])
	by mail.openembedded.org (Postfix) with ESMTP id 4514A77184
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  3 Feb 2016 15:57:00 +0000 (UTC)
Received: by mail-ig0-f174.google.com with SMTP id 5so39247384igt.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 03 Feb 2016 07:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=mXniMQGb23RVX7ooX+A+7RiiXbY/idqM/OcxrsrYlHo=;
	b=uN1ZeTaTmzisJgmmcWJR8JulLPHPv0CejpHY6CF7XqlIqqh5zaNoHNp3z21wwX1XJR
	YTjX8guUB6ixSige2uPaPsEKkEuLDymhA1GuzHOgjWUc5q62RJhsd1M7zMV/SYSUAj3m
	LKQ4sKr2DlvbwPK2maSQ0p97+KZbtP1roz6t6lVqeaTV8yxJvfclGvJqAEqQ1jLtZg35
	0bQXJ1Cy7x4RKD/FTX+DPSSmMqgrMwLdELz6ScZiqBsfjB+8lMqL5+WtQ6GikgE0EVtZ
	r9yv1DueI2FTJY0NZcaGoBvGWREiuJvfMRv+vk6sCeqaYyPpit416KhNT02Meo7kKOsv
	wDqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kergoth-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=mXniMQGb23RVX7ooX+A+7RiiXbY/idqM/OcxrsrYlHo=;
	b=m6mitKlsgXlqr1CTWnZNXW6SRc7f50ZX6CIXIphFdyz7lXLq1A9zHLs46HFpNz7wFj
	f40aEQlOLWVhcdgfc2ziONZ82aPGGIc1G6nZz6/1O3BkDwPwjcoVybx96uSkh9TRckP0
	8PEZmoq4jjlheeHqsAecaoo69yuuT2mF23XVlmBGWlmjZyJcPorZzCUmklaA5n2LZFDN
	cYftohaIKV/ureiiRwuGamy7dzv02pI3FHDTDXWBjnFxrtckwfv6mE3wmPqdBFPEO1mm
	rDX3CD58r1l4u+XkICx5LK+cWw9+PPW4JN6IftR4/DKcrJvMln+xSsQ+kpQ7PGNgRP1N
	66ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc:content-type;
	bh=mXniMQGb23RVX7ooX+A+7RiiXbY/idqM/OcxrsrYlHo=;
	b=IYid0hgE88ZYU5wfG4w8gkHqwKSfC2hyg111bDTTUo3xsPL0r0DX36vmRXW/A1aiu3
	vpY98JSv+uF5bHynUgEej9X4XDHNHkpOmH4YHHcE71MFUs/DrtK1o2nE05INR6r6bKzX
	yt+BVAJnLrDezBiABH7ouF8VCsE9hoc9+TPilJPlaEKSO3KpOqO6+IlmaBjgfGVXhf10
	F7XNjeARJ6KZS7QpjZYUY3hitYn6Y0Ke7SmaINYWTKBnIVAwJIT2UR/2u1TmGF9av0sh
	cALHWEgVE60SoQorj2Vp0d8K2yB/n/4a/X5bx5dRxx1eFrwrKiQ+nQUb/OBlu4zUTNht
	v2Hg==
X-Gm-Message-State: AG10YOTFTVZHN6bnTscxRzwOSUbUiJlOHEKjKuNk6LoahKTD5Pb6/wfd8WZ0gG8RHX6h3DULDxF1vzOye2Ewgg==
X-Received: by 10.50.26.5 with SMTP id h5mr4160182igg.25.1454515021604; Wed,
	03 Feb 2016 07:57:01 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.91.133 with HTTP; Wed, 3 Feb 2016 07:56:42 -0800 (PST)
In-Reply-To: <1454495619-15453-2-git-send-email-markus.lehtonen@linux.intel.com>
References: <1454495619-15453-1-git-send-email-markus.lehtonen@linux.intel.com>
	<1454495619-15453-2-git-send-email-markus.lehtonen@linux.intel.com>
From: Christopher Larson <clarson@kergoth.com>
Date: Wed, 3 Feb 2016 08:56:42 -0700
X-Google-Sender-Auth: MnEfGh7U6jiQ6w81ttshrRa5DtA
Message-ID: <CABcZANkJ4Ta=_YuU5yOk55XGH0mBpSD6VCcNiSX9aZY2ixLcpA@mail.gmail.com>
To: Markus Lehtonen <markus.lehtonen@linux.intel.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 1/2] data_smart: simple bracket matching inside python expressions
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
X-List-Received-Date: Wed, 03 Feb 2016 15:57:03 -0000
Content-Type: multipart/alternative; boundary=047d7bd7598c2f1250052adfab67

--047d7bd7598c2f1250052adfab67
Content-Type: text/plain; charset=UTF-8

On Wed, Feb 3, 2016 at 3:33 AM, Markus Lehtonen <
markus.lehtonen@linux.intel.com> wrote:

> This expands the python expansion regex by matching curly brackets
> inside python expressions. In its simplicity it is limited: e.g. it does
> not correctly handle nested curly brackets or open curly brackets (i.e.
> '{' without a matching '}') inside python expressions. Making python
> parsing inside data_smart fully error-free would require significantly
> more work, basically using/implementing python parser to correctly
> handle python strings etc.
>
> [YOCTO #8849]
>
> Signed-off-by: Markus Lehtonen <markus.lehtonen@linux.intel.com>
>

Will this cause problems with regular variable expansion nested inside of
inline python, which is allowed? I.e. ${@ ... '${FOO}'}
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--047d7bd7598c2f1250052adfab67
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, Feb 3, 2016 at 3:33 AM, Markus Lehtonen <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:markus.lehtonen@linux.intel.com" target=3D"_blank">markus.leht=
onen@linux.intel.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
"><div id=3D":175" class=3D"a3s" style=3D"overflow:hidden">This expands the=
 python expansion regex by matching curly brackets<br>
inside python expressions. In its simplicity it is limited: e.g. it does<br=
>
not correctly handle nested curly brackets or open curly brackets (i.e.<br>
&#39;{&#39; without a matching &#39;}&#39;) inside python expressions. Maki=
ng python<br>
parsing inside data_smart fully error-free would require significantly<br>
more work, basically using/implementing python parser to correctly<br>
handle python strings etc.<br>
<br>
[YOCTO #8849]<br>
<br>
Signed-off-by: Markus Lehtonen &lt;<a href=3D"mailto:markus.lehtonen@linux.=
intel.com">markus.lehtonen@linux.intel.com</a>&gt;</div></blockquote></div>=
<br></div><div class=3D"gmail_extra">Will this cause problems with regular =
variable expansion nested inside of inline python, which is allowed? I.e. $=
{@ ... &#39;${FOO}&#39;}<br>-- <br><div class=3D"gmail_signature">Christoph=
er Larson<br>clarson at kergoth dot com<br>Founder - BitBake, OpenEmbedded,=
 OpenZaurus<br>Maintainer - Tslib<br>Senior Software Engineer, Mentor Graph=
ics</div>
</div></div>

--047d7bd7598c2f1250052adfab67--
