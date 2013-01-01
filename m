Received: from mail-la0-f48.google.com ([209.85.215.48])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1Tq7am-0007bn-JQ
	for bitbake-devel@lists.openembedded.org;
	Tue, 01 Jan 2013 20:33:40 +0100
Received: by mail-la0-f48.google.com with SMTP id ej20so5083964lab.21
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 01 Jan 2013 11:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=oY2vW6TkKVdgOdgIAzOur0j3bmMce/9GiwCOkHzs+sU=;
	b=n2vUqHEW/kraSxESUMK+S8Q8F+K6qFr7S87BO2lgRXUiZIk9ooUYebodVcx33pO1Jy
	Z4hwK8sHmWUzGnxwYrTIUv6RTKYvpiRUUlZYDDlb9sKDn2djcaPOYa+LjlrUZQSKG3j5
	ZXWbn+B1KV4kbHjjJChHwLnWptV58msZg+0fYN+i0jU1Nvxerq/W1P+OLzQab3EP5dtr
	kZ8Tmjj8/DQrhS6OzH7j5cmoLPHOK/lPWzcTNhjk0Rcm/U1ACDryWJoEs5tGIAmAE3ez
	uvbubuY8QRVJ6mfdurNzzi/z+enq9Y6RzG+i33ohjjKbLDht8jwT6BLdtNqbZxcH/y48
	LeXA==
Received: by 10.112.49.202 with SMTP id w10mr17137615lbn.2.1357067919055; Tue,
	01 Jan 2013 11:18:39 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.34.10 with HTTP; Tue, 1 Jan 2013 11:18:18 -0800 (PST)
In-Reply-To: <alpine.DEB.2.02.1301010855180.18858@oneiric>
References: <alpine.DEB.2.02.1301010855180.18858@oneiric>
From: Chris Larson <clarson@kergoth.com>
Date: Tue, 1 Jan 2013 12:18:18 -0700
X-Google-Sender-Auth: DmMoEkfwAXIe6jRAEVIWE9S8HJc
Message-ID: <CABcZANmLcgOzqOCUrGmeFMeM=GAg5jFm7+t-opF7uxZ43c0m=A@mail.gmail.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: still confused about _append and OVERRIDES and = and +=, argh
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 01 Jan 2013 19:33:40 -0000
Content-Type: multipart/alternative; boundary=bcaec554daa2405cc804d23eff08

--bcaec554daa2405cc804d23eff08
Content-Type: text/plain; charset=UTF-8

On Tue, Jan 1, 2013 at 7:12 AM, Robert P. J. Day <rpjday@crashcourse.ca>wrote:

>   again, so far, so good -- the second override superseded the first,
> correct?
>
>         test 4:
>
> BLAH = "A"
> BLAH_rday = "B"
> BLAH_rday_append = "C"
>
> $ bitbake-env BLAH
> BLAH="B"
> $
>
>    ?????  that confuses me.  according to section 2.2.1 in bitbake
> manual (very first example):
>

> OVERRIDES = "foo"
>
> A_foo_append = "X"
>
> "In this case, X is unconditionally appended to the variable A_foo.
> Since foo is an override, A_foo would then replace A."
>
> according to that, i should expect BLAH to have the value "BC", no?
>

Yeah, as far as I'm aware that's what should have happened, but as you
noticed, this form is extremely unusual. Usually if one wants to do this,
they just use an immediate operator like .= or += instead of _append.
Sounds like a bitbake "bug", but one that one is unlikely to hit in
practice. Honestly, we should really cut back on the overuse of _append and
_prepend in general, as a janitorial task, if for no other reason than to
reduce confusion :)
-- 
Christopher Larson

--bcaec554daa2405cc804d23eff08
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quo=
te">On Tue, Jan 1, 2013 at 7:12 AM, Robert P. J. Day <span dir=3D"ltr">&lt;=
<a href=3D"mailto:rpjday@crashcourse.ca" target=3D"_blank">rpjday@crashcour=
se.ca</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div id=3D":78">=C2=A0 again, so far, so goo=
d -- the second override superseded the first,<br>
correct?<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 test 4:<br>
<br>
BLAH =3D &quot;A&quot;<br>
BLAH_rday =3D &quot;B&quot;<br>
BLAH_rday_append =3D &quot;C&quot;<br>
<br>
$ bitbake-env BLAH<br>
BLAH=3D&quot;B&quot;<br>
$<br>
<br>
=C2=A0 =C2=A0????? =C2=A0that confuses me. =C2=A0according to section 2.2.1=
 in bitbake<br>
manual (very first example):=C2=A0</div></blockquote><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex"><div id=3D":78">
<br>
OVERRIDES =3D &quot;foo&quot;<br>
<br>
A_foo_append =3D &quot;X&quot;<br>
<br>
&quot;In this case, X is unconditionally appended to the variable A_foo.<br=
>
Since foo is an override, A_foo would then replace A.&quot;<br>
<br>
according to that, i should expect BLAH to have the value &quot;BC&quot;, n=
o?<br></div></blockquote><div><br></div><div style>Yeah, as far as I&#39;m =
aware that&#39;s what should have happened, but as you noticed, this form i=
s extremely unusual. Usually if one wants to do this, they just use an imme=
diate operator like .=3D or +=3D instead of _append. Sounds like a bitbake =
&quot;bug&quot;, but one that one is unlikely to hit in practice. Honestly,=
 we should really cut back on the overuse of _append and _prepend in genera=
l, as a janitorial task, if for no other reason than to reduce confusion :)=
</div>

</div>-- <br>Christopher Larson</div></div>

--bcaec554daa2405cc804d23eff08--
