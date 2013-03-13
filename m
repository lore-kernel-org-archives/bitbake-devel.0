Received: from mail-la0-f43.google.com ([209.85.215.43])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1UFuym-00040Y-Mm
	for bitbake-devel@lists.openembedded.org;
	Thu, 14 Mar 2013 00:21:48 +0100
Received: by mail-la0-f43.google.com with SMTP id ek20so1781626lab.30
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 Mar 2013 16:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=hdmIkKGr0kG+NnrixEfL01gLdof4+tP0SczOT8mbuuc=;
	b=Ep0QFjaq3VBFZks3JxsP8D4avFoQUVlmXtf6/8RGG222OzFD4JsPx4Pni1nsQ/3vB3
	Ayca6oCCiLJgEcAWD5e6eI91ry1BjfnlTAhgRUKeh1Ge48TTf0rlmR36CEvbxc0guR96
	lowkxtsYx59nEwlYZI2c7xjfPelomiy/L2HfHrHx4YefvWqHgl6nSZSbDtG6UOm6JSit
	/sPSTe9bwzv3gVP6p1IU9/SnetbdI+9oYZ72Y5FQ4CpTrPLl+cfdmPgcIGvZ1TYJXBQG
	eC+Voo8UDQJobtYXXDM+aTqgf79DbpDxrLWUP10qTQsyLWECf3lD0DO13mvyI515paP1
	pi/Q==
X-Received: by 10.112.69.75 with SMTP id c11mr221222lbu.119.1363215863033;
	Wed, 13 Mar 2013 16:04:23 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.25.195 with HTTP; Wed, 13 Mar 2013 16:04:02 -0700 (PDT)
In-Reply-To: <20130313132857.505e0f96@e6410-2>
References: <1362833241.9443.208.camel@ted>
	<CABcZANmT5Z6B=PoD9k06aqFq08nzDjUt9DYkBUwdgSTFLKM+6w@mail.gmail.com>
	<2406047.qZssv5BGAg@helios> <20130313132857.505e0f96@e6410-2>
From: Chris Larson <clarson@kergoth.com>
Date: Wed, 13 Mar 2013 16:04:02 -0700
X-Google-Sender-Auth: QDKelld5rq9zusJqj86NTGwevq0
Message-ID: <CABcZANkUwODfNVkar0FeKh5st1A5QV5WHxzjvxxYDKA8Sy6Z=g@mail.gmail.com>
To: Peter Seebach <peter.seebach@windriver.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] data_smart: Add _remove operator
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
X-List-Received-Date: Wed, 13 Mar 2013 23:22:34 -0000
Content-Type: multipart/alternative; boundary=90e6ba3091cc44ba1904d7d66d11

--90e6ba3091cc44ba1904d7d66d11
Content-Type: text/plain; charset=UTF-8

On Wed, Mar 13, 2013 at 11:28 AM, Peter Seebach <peter.seebach@windriver.com
> wrote:

> On Sun, 10 Mar 2013 20:39:07 +0000
> Paul Eggleton <paul.eggleton@linux.intel.com> wrote:
>
> > I can't recall if we've discussed this before, but shouldn't we be
> looking at
> > introducing some understanding of list type variables into BitBake
> itself? If
> > BitBake knew the variable was a list it would be possible to have
> language
> > elements that understood how to behave in this situation.
>

Yeah, this gets brought up from time to time, it's something we've wanted
for a while, but nobody has taken the time to make it happen. I would love
to see some form of typing go in, and I know Richard has expressed a desire
to see this as well in the past.

I rather like this. I would like to have _remove, and it may even make sense
> to adopt _remove in the short term, but really I think most of the things
> where we're using append/remove should probably be lists, which would also
> eliminate the entire category of bugs in which it is unclear whether or not
> to add a space.
>
> Rough thoughts about implementation: Listness could be a flag.
>
> LIST[list] = " "
> LIST = "blah blah blah"
> # Oh, hey, what if...
> PATH[list] = ":"
>

We do have a flag-based typing implementation in the metadata, just not in
bitbake itself, see
http://git.yoctoproject.org/cgit/cgit.cgi/poky/commit/?h=e4921fd for the
original implementation. I particularly like the bits that automatically
convert the function signature of the type callback (or class) into a
request for additional information via flags. An added required argument to
the function = a required flag of that name, same for optional. See
http://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/meta/lib/oe/types.py#n27
 or
http://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/meta/lib/oe/types.py#n13
for
examples of that particular implementation.

or as shorthand:
>
> LIST = [blah blah blah]
>

I played briefly around with a *really* preliminary prototype of something
similar to this. See https://gist.github.com/kergoth/2788410 - any unquoted
values are interpreted as json types, and the append/prepend operations are
switched to better work with non-string values. It works surprisingly well
considering how naive the implementation is, see the functional local.conf
snippet in the gist.
-- 
Christopher Larson

--90e6ba3091cc44ba1904d7d66d11
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, Mar 13, 2013 at 11:28 AM, Peter Seebach <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:peter.seebach@windriver.com" target=3D"_blank">peter.seebach@w=
indriver.com</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex"><div class=3D"im">On Sun, 10 Mar 2013 20:39:07 +0000<br>
Paul Eggleton &lt;<a href=3D"mailto:paul.eggleton@linux.intel.com">paul.egg=
leton@linux.intel.com</a>&gt; wrote:<br>
<br>
&gt; I can&#39;t recall if we&#39;ve discussed this before, but shouldn&#39=
;t we be looking at<br>
&gt; introducing some understanding of list type variables into BitBake its=
elf? If<br>
&gt; BitBake knew the variable was a list it would be possible to have lang=
uage<br>
&gt; elements that understood how to behave in this situation.<br></div></b=
lockquote><div><br></div><div style>Yeah, this gets brought up from time to=
 time, it&#39;s something we&#39;ve wanted for a while, but nobody has take=
n the time to make it happen. I would love to see some form of typing go in=
, and I know Richard has expressed a desire to see this as well in the past=
.</div>

<div style><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);bord=
er-left-style:solid;padding-left:1ex">I rather like this. I would like to h=
ave _remove, and it may even make sense<br>


to adopt _remove in the short term, but really I think most of the things<b=
r>
where we&#39;re using append/remove should probably be lists, which would a=
lso<br>
eliminate the entire category of bugs in which it is unclear whether or not=
<br>
to add a space.<br>
<br>
Rough thoughts about implementation: Listness could be a flag.<br>
<br>
LIST[list] =3D &quot; &quot;<br>
LIST =3D &quot;blah blah blah&quot;<br>
# Oh, hey, what if...<br>
PATH[list] =3D &quot;:&quot;<br></blockquote><div><br></div><div style>We d=
o have a flag-based typing implementation in the metadata, just not in bitb=
ake itself, see=C2=A0<a href=3D"http://git.yoctoproject.org/cgit/cgit.cgi/p=
oky/commit/?h=3De4921fd">http://git.yoctoproject.org/cgit/cgit.cgi/poky/com=
mit/?h=3De4921fd</a>=C2=A0for the original implementation. I particularly l=
ike the bits that automatically convert the function signature of the type =
callback (or class) into a request for additional information via flags. An=
 added required argument to the function =3D a required flag of that name, =
same for optional. See=C2=A0<a href=3D"http://git.yoctoproject.org/cgit/cgi=
t.cgi/poky/tree/meta/lib/oe/types.py#n27">http://git.yoctoproject.org/cgit/=
cgit.cgi/poky/tree/meta/lib/oe/types.py#n27</a>=C2=A0or=C2=A0<a href=3D"htt=
p://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/meta/lib/oe/types.py#n13">=
http://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/meta/lib/oe/types.py#n1=
3</a>=C2=A0for examples of that particular implementation.</div>

<div style><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);bord=
er-left-style:solid;padding-left:1ex">
or as shorthand:<br>
<br>
LIST =3D [blah blah blah]<br></blockquote></div><br>I played briefly around=
 with a *really* preliminary prototype of something similar to this. See=C2=
=A0<a href=3D"https://gist.github.com/kergoth/2788410">https://gist.github.=
com/kergoth/2788410</a>=C2=A0- any unquoted values are interpreted as json =
types, and the append/prepend operations are switched to better work with n=
on-string values. It works surprisingly well considering how naive the impl=
ementation is, see the functional local.conf snippet in the gist.<br>

-- <br>Christopher Larson</div></div>

--90e6ba3091cc44ba1904d7d66d11--
