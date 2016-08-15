Return-Path: <kergoth@gmail.com>
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com
	[209.85.218.67])
	by mail.openembedded.org (Postfix) with ESMTP id C44997710C
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Aug 2016 17:22:12 +0000 (UTC)
Received: by mail-oi0-f67.google.com with SMTP id e80so4909412oig.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Aug 2016 10:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=R45QpLz/0ZxpsFy9hbXAKu5WHryyHMcJREzlTVSLI5I=;
	b=MkplG6Q5e3lzTyC7F6E3G6zXAzeK1AkwLHPPB5XkEwvS/73hGOiZz/vBKQpy65eMdl
	0kvd/lpsbQmPEIvEvAKqp9lekfFUf9RxXuLGKruvo01j7qIDsLYsRVKRVvx17a18KmgS
	c6/z8GV4GFG10iweIFE8zXgWEEA6xEYl3FkrYjUTAVjvO778UAo+mPObO/Yd81ihViDC
	m/faXbV4BkqPOzSQGXATzljMfANBtr2MIeFI5jgbWpDxgGH98fC+PFxpsWYhV0JMnFFl
	WvV2TKdZ9G2W/o9Qqd/7k8WUSUJ0V39F+pz1gKre2/hliEfeQEckO7En1KXC0DIlBnnj
	SHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=R45QpLz/0ZxpsFy9hbXAKu5WHryyHMcJREzlTVSLI5I=;
	b=iIiimdVAebtA1yzACQW7YmL3ZWLym5j5aeGd4rBgmDl9XOzJ03bqdz9H4PNHWhQEvi
	VDINk1DoNvRS2q96L2ODSJQkV1IemQUBHGZlTs70WT79nx4VL8kXrLDKZ8YOSF1N52Q7
	CfVEB00mVQaMpndN0EQSaFQgVEW3fyOwz4McwK8kDpsGSDkDXBTuimMp+0Fl/GYSs0qr
	zpgp3Ir2gi94q3GMizP2u0mXKuzWOx9XpSFj9WXc9Simkzefcx8feqBz5ebZbHohiUsS
	WA3CkvfHJsQJaOQ9/Hhch/mDjT2dR0J7A2uNkoTMO87Keubtrf4TW/QDU/xZAyS669aA
	fUiQ==
X-Gm-Message-State: AEkoouuKgwbUvaCC4zozSZ88Ur6r0OFNKy0s8jKdJ3CyBHE3KREyDpg7KY/+kh3aeHFGgELKO9sdfjK6KwOKrQ==
X-Received: by 10.157.25.165 with SMTP id k34mr9008101otk.169.1471281733512;
	Mon, 15 Aug 2016 10:22:13 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.157.20.3 with HTTP; Mon, 15 Aug 2016 10:21:53 -0700 (PDT)
In-Reply-To: <1471280445.20391.96.camel@linuxfoundation.org>
References: <1471280445.20391.96.camel@linuxfoundation.org>
From: Christopher Larson <clarson@kergoth.com>
Date: Mon, 15 Aug 2016 10:21:53 -0700
X-Google-Sender-Auth: cco0lJbYjRYIy_oCnufhyIM6z3s
Message-ID: <CABcZANkY_x1AQvRZyRuVeZyD3C_LxUEWihhCQ+qiLoxaSczV+A@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] cache: Make virtualfn2realfn/realfn2virtual standalone functions
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
X-List-Received-Date: Mon, 15 Aug 2016 17:22:13 -0000
Content-Type: multipart/alternative; boundary=94eb2c09d0b41732d1053a1f79a0

--94eb2c09d0b41732d1053a1f79a0
Content-Type: text/plain; charset=UTF-8

On Mon, Aug 15, 2016 at 10:00 AM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> Needing to build an object to access these static methods doesn't
> make sense. Move these to become module level standalone functions.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>

Might want to tweak this message -- you don't need to build an object to
access the static methods, they're static :) You do need to reference the
class, so it's a pointless namespacing, however.


-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--94eb2c09d0b41732d1053a1f79a0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Mon, Aug 15, 2016 at 10:00 AM, Richard Purdie <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard=
.purdie@linuxfoundation.org</a>&gt;</span> wrote:<br><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex"><div id=3D":39i" class=3D"a3s aXjCH m1568f261ee812914">Needing to =
build an object to access these static methods doesn&#39;t<br>
make sense. Move these to become module level standalone functions.<br>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org">richard.purdie@<wbr>linuxfoundation.org</a>&gt;<br></div></blo=
ckquote></div><br>Might want to tweak this message -- you don&#39;t need to=
 build an object to access the static methods, they&#39;re static :) You do=
 need to reference the class, so it&#39;s a pointless namespacing, however.=
<br><br clear=3D"all"><div><br></div>-- <br><div class=3D"gmail_signature" =
data-smartmail=3D"gmail_signature">Christopher Larson<br>clarson at kergoth=
 dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Maintainer - Tsl=
ib<br>Senior Software Engineer, Mentor Graphics</div>
</div></div>

--94eb2c09d0b41732d1053a1f79a0--
