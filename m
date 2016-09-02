Return-Path: <evadeflow@gmail.com>
Received: from mail-it0-f46.google.com (mail-it0-f46.google.com
	[209.85.214.46])
	by mail.openembedded.org (Postfix) with ESMTP id C623E60746
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  2 Sep 2016 22:56:05 +0000 (UTC)
Received: by mail-it0-f46.google.com with SMTP id e124so63486289ith.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 02 Sep 2016 15:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=5MNVXq3+CRQli0nen/PXqRVp98uz39JqZHJBYloKi6k=;
	b=VYfCDLE+POBZexAANrJPTDEqfhkdjDr6+1YLxFPvU9cUiqM7kbiwFUvCpvfZK93iBj
	cytLo70hRE+4w6wBqxHAF4492sjdZ0hpBUVgOGUfjLJDeq74TqLpWsDNlOEVnxnxoUow
	AfH+6rPazUkHjS9PdG8LncCIAf7V8P5kbJhmgvD4RgDDhOR0J8hXc05Y0sVhbTEXbwU8
	Dvz/uirlgM9C+dTZP6pNR6vVUZCske9/ApRkXPzv7BUwqgMMNWTh96VcFReSSvOcJdSw
	DuJKUd56UG6Rw2FwOoJikHAL6oxSdstMNpjP24QsOwsunqj81y24RrwEW84fNni6aF5Q
	iTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=5MNVXq3+CRQli0nen/PXqRVp98uz39JqZHJBYloKi6k=;
	b=SvmLtfDh13AJdh8SZv4xChgZ+ZUIol3Abqpbi+NQ9gjiOadLVGotvOrlw9iHxWnfFB
	2T/LaruLYf0e2kC9H2lWkNpJFY8IV1a6/PjO8fiOvBtQ0Rka1vdDvY0fjtrkOpbBzamb
	2znWNa/ZZwavCgZtbSJ/ennr64q5EKnzQCJWVnsAnnkZky+7V5qnmm1h2/niZ/u+z6oB
	lQqy4lNCHL48zi4aEhV68awM9Hs68DUvs+BoPIBUxT0kbpbsLgCwWCs08FY6TgULHNoh
	M1tqXC47xCwWOv32oT3WRRbNeXaZW7jAZcUnhi5nerRoKVQCM6lxjCRs9d1sdcwddTcr
	O8Vg==
X-Gm-Message-State: AE9vXwOWzTt/4ZFbxCPx6evvxIpQbMieB2YppSqneKfjSnO5u34JzhcKHHkpjMA871yKXDGQhRiypk3uNSKkpA==
X-Received: by 10.36.98.199 with SMTP id d190mr7587475itc.39.1472856965944;
	Fri, 02 Sep 2016 15:56:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.36.147.4 with HTTP; Fri, 2 Sep 2016 15:56:05 -0700 (PDT)
In-Reply-To: <1472852794.29583.182.camel@linuxfoundation.org>
References: <CAMAb8ZNGCbyo+49tXBPZJy-jvSbwgShfbFjZ18OU4kARRLqVNw@mail.gmail.com>
	<1472817465.29583.164.camel@linuxfoundation.org>
	<CAMAb8ZP-oC0Pqgh22KjFk2Py1atsFCP-1KqaKod8XsdN9s0k9w@mail.gmail.com>
	<1472852794.29583.182.camel@linuxfoundation.org>
From: Evade Flow <evadeflow@gmail.com>
Date: Fri, 2 Sep 2016 18:56:05 -0400
Message-ID: <CAMAb8ZMOwjeWdU87EFzv4BSE9P3roCsFkOr_cgAnNf6UFVTAtw@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Conditionally inherit own-mirrors and set SOURCE_MIRROR_URL?
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
X-List-Received-Date: Fri, 02 Sep 2016 22:56:07 -0000
Content-Type: multipart/alternative; boundary=001a1145adbc4299d5053b8e3cac

--001a1145adbc4299d5053b8e3cac
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

> It is an annoying and somewhat artificial limitation. I have been known
> to work around it by adding a xxx.bbclass file in a classes directory
> and then INHERIT +=3D "xxx".

That's a really handy trick to know about, thanks! I will probably switch
to that approach soon since=E2=80=94now that I see the possibilities=E2=80=
=94I anticipate
I'll be adding more conditional config items so my teammates don't have to
worry about it.

The solution I managed to finger-mumble my way to in the meantime is a
little scary-looking:

SOURCE_MIRROR_URL =3D "${@'file:///demo/source-mirror' if
os.path.exists('/demo/source-mirror') else
'http://mycompany.com:1234/source-mirror'}"
INHERIT +=3D "own-mirrors"


About the best thing I can say about it is: it *does* work. And it's
actually pretty readable, aside from the line length being so long it won't
fit in a tweet(!)

On Fri, Sep 2, 2016 at 5:46 PM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Fri, 2016-09-02 at 15:26 -0400, Evade Flow wrote:
> > > You could do something like:
> > ...
> > >
> > SOURCE_MIRROR_URL ?=3D "{@base_contains('LOCALBUILD', 'local', '
> > file://xxx', 'http://xxx', d)}"
> >
> >
> > That's exactly what I was looking for, thanks. I gather I can't put
> > functions in local.conf, which is where our current build is setting
> > SOURCE_MIRROR_URL. Can I trouble you to recommend a home for such a
> > function? It 'feels weird' to put it in a recipe, is there some
> > other, semi-standard place to stuff helper functions?
>
> It is an annoying and somewhat artificial limitation. I have been known
> to work around it by adding a xxx.bbclass file in a classes directory
> and then INHERIT +=3D "xxx".
>
> Cheers,
>
> Richard
>

--001a1145adbc4299d5053b8e3cac
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>&gt; It is an annoying and somewhat artificial l=
imitation. I have been known<br>
&gt; to work around it by adding a xxx.bbclass file in a classes directory<=
br>
&gt; and then INHERIT +=3D &quot;xxx&quot;.<br><br></div>That&#39;s a reall=
y handy trick to know about, thanks! I will probably switch to that approac=
h soon since=E2=80=94now that I see the possibilities=E2=80=94I anticipate =
I&#39;ll be adding more conditional config items so my teammates don&#39;t =
have to worry about it.<br><br>The solution I managed to finger-mumble my w=
ay to in the meantime is a little scary-looking:<br><br><pre>SOURCE_MIRROR_=
URL =3D &quot;${@&#39;file:///demo/source-mirror&#39; if os.path.exists(&#3=
9;/demo/source-mirror&#39;) else &#39;<a href=3D"http://mycompany.com:1234/=
source-mirror&#39;">http://mycompany.com:1234/source-mirror&#39;</a>}&quot;
INHERIT +=3D &quot;own-mirrors&quot;</pre><br></div>About the best thing I =
can say about it is: it *does* work. And it&#39;s actually pretty readable,=
 aside from the line length being so long it won&#39;t fit in a tweet(!)<br=
></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Fri, Se=
p 2, 2016 at 5:46 PM, Richard Purdie <span dir=3D"ltr">&lt;<a href=3D"mailt=
o:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.purdie@linu=
xfoundation.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><sp=
an class=3D"">On Fri, 2016-09-02 at 15:26 -0400, Evade Flow wrote:<br>
&gt; &gt; You could do something like:<br>
&gt; ...<br>
&gt; &gt;<br>
&gt; SOURCE_MIRROR_URL ?=3D &quot;{@base_contains(&#39;LOCALBUILD&#39;, &#3=
9;local&#39;, &#39;<br>
&gt; file://xxx&#39;, &#39;<a href=3D"http://xxx" rel=3D"noreferrer" target=
=3D"_blank">http://xxx</a>&#39;, d)}&quot;<br>
&gt;<br>
&gt;<br>
&gt; That&#39;s exactly what I was looking for, thanks. I gather I can&#39;=
t put<br>
&gt; functions in local.conf, which is where our current build is setting<b=
r>
&gt; SOURCE_MIRROR_URL. Can I trouble you to recommend a home for such a<br=
>
&gt; function? It &#39;feels weird&#39; to put it in a recipe, is there som=
e<br>
&gt; other, semi-standard place to stuff helper functions?<br>
<br>
</span>It is an annoying and somewhat artificial limitation. I have been kn=
own<br>
to work around it by adding a xxx.bbclass file in a classes directory<br>
and then INHERIT +=3D &quot;xxx&quot;.<br>
<br>
Cheers,<br>
<br>
Richard<br>
</blockquote></div><br></div>

--001a1145adbc4299d5053b8e3cac--
