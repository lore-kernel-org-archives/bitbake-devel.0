Return-Path: <kergoth@gmail.com>
Received: from mail-qg0-f50.google.com (mail-qg0-f50.google.com
	[209.85.192.50])
	by mail.openembedded.org (Postfix) with ESMTP id 58F056013D
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Mar 2015 15:24:31 +0000 (UTC)
Received: by qgf60 with SMTP id 60so85030296qgf.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Mar 2015 08:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=H/oLS4yCOrYZA/b4MDtWZLUrMhb7E97PRF5m9G7V2K0=;
	b=bRzqzIWI5KGPXSeF+huIKUTyIp9R7NCqafpceGjsOIaoqAEwLH6NDFoLyONt/v9uNj
	rfEGv/YnqF6DMSPNXjKDJQDNYEBZem0LFeXtCtK/XqWZhEbnOryH9S1x9yOJ67zdJe1q
	r0vzfn1S1JZzhZhwrm3ckggr2FwHvB2cbomczkKhMQ2Ll7RSx19Czf99zsyKpG1NY5nI
	m/V6N6sb37hrd8U+WSO/wsrKLWDJoEXY/YVMGUs2niYFQx17vSjYG6OxoSUjN5MmDK9K
	Do/IOYwz0NgQCEldSx0ajNWbAQwg1EhSkwwgAebGYexXeXUQFb1U7944nyCKYMLKQtaq
	HItg==
X-Received: by 10.140.135.207 with SMTP id 198mr18974768qhh.71.1427383450073; 
	Thu, 26 Mar 2015 08:24:10 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.140.108.75 with HTTP; Thu, 26 Mar 2015 08:23:49 -0700 (PDT)
In-Reply-To: <1427380216.14020.100.camel@linuxfoundation.org>
References: <1427380216.14020.100.camel@linuxfoundation.org>
From: Christopher Larson <clarson@kergoth.com>
Date: Thu, 26 Mar 2015 08:23:49 -0700
X-Google-Sender-Auth: HsWRJlr-LLWmXvHsUwkdOhfoLms
Message-ID: <CABcZAN=1aidEyfdpeNOgb3SEJmNB6c8EKpArU+1kr-U-CAaf9w@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: Key expansion and overrides?
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
X-List-Received-Date: Thu, 26 Mar 2015 15:24:34 -0000
Content-Type: multipart/alternative; boundary=001a1135dfa28001290512329b57

--001a1135dfa28001290512329b57
Content-Type: text/plain; charset=UTF-8

On Thu, Mar 26, 2015 at 7:30 AM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> Two interesting test cases:
>
> OVERIDES = "myoverride"
> TESTME = "myoverride"
> FOO = "1"
> FOO_${TESTME} = "2"
>
> FOO = 1 or 2?
>
> OVERIDES = "myoverride"
> TESTME = "myoverride"
> FOO = "1 2"
> FOO_remove_${TESTME} = "2"
>
> FOO = "1 2" or "1"?
>
> Currently expansion in overrides doesn't work. I discovered this trying
> to do:
>
> X_remove_pn-gcc-cross-${TARGET_ARCH} = "Y"
>
> which I do believe is a valid thing to attempt.
>
> There are two ways of fixing this I guess. One is to call expandKeys()
> before and after update_data() but I suspect we can still cases which
> won't work. The other is to move to a model where overrides are applied
> more dynamically and we lose the need for update_data(). There may be
> some performance penalty for it.
>
> I'm leaning towards trying to kill off update_data() right now...
>

I also would lean towards removing update_data, at least prototyping it to
see what the performance penalties are.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a1135dfa28001290512329b57
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Thu, Mar 26, 2015 at 7:30 AM, Richard Purdie <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.=
purdie@linuxfoundation.org</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex"><div id=3D":23r" class=3D"a3s" style=3D"overflow:hidden">Two intere=
sting test cases:<br>
<br>
OVERIDES =3D &quot;myoverride&quot;<br>
TESTME =3D &quot;myoverride&quot;<br>
FOO =3D &quot;1&quot;<br>
FOO_${TESTME} =3D &quot;2&quot;<br>
<br>
FOO =3D 1 or 2?<br>
<br>
OVERIDES =3D &quot;myoverride&quot;<br>
TESTME =3D &quot;myoverride&quot;<br>
FOO =3D &quot;1 2&quot;<br>
FOO_remove_${TESTME} =3D &quot;2&quot;<br>
<br>
FOO =3D &quot;1 2&quot; or &quot;1&quot;?<br>
<br>
Currently expansion in overrides doesn&#39;t work. I discovered this trying=
<br>
to do:<br>
<br>
X_remove_pn-gcc-cross-${TARGET_ARCH} =3D &quot;Y&quot;<br>
<br>
which I do believe is a valid thing to attempt.<br>
<br>
There are two ways of fixing this I guess. One is to call expandKeys()<br>
before and after update_data() but I suspect we can still cases which<br>
won&#39;t work. The other is to move to a model where overrides are applied=
<br>
more dynamically and we lose the need for update_data(). There may be<br>
some performance penalty for it.<br>
<br>
I&#39;m leaning towards trying to kill off update_data() right now...</div>=
</blockquote></div><br>I also would lean towards removing update_data, at l=
east prototyping it to see what the performance penalties are.<br>-- <br><d=
iv class=3D"gmail_signature">Christopher Larson<br>clarson at kergoth dot c=
om<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>=
Senior Software Engineer, Mentor Graphics</div>
</div></div>

--001a1135dfa28001290512329b57--
