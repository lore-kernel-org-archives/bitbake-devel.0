Return-Path: <anibal.limon@linaro.org>
Received: from mail-ua1-f68.google.com (mail-ua1-f68.google.com
	[209.85.222.68])
	by mail.openembedded.org (Postfix) with ESMTP id D34467FC2D
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Nov 2019 22:22:37 +0000 (UTC)
Received: by mail-ua1-f68.google.com with SMTP id o9so4993794uat.8
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Nov 2019 14:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=UgJUbBDR/JNnpMQGuEj9pmNayvz4qvaj6ERuPxw8auo=;
	b=wfGcY8Tkq4WUnB1JJnujpwK5+DQnwBWP4H/YA0zkB0056KEWfyK7j4f0l3270Xw7d9
	Q0/WmjO8mxLlANeh5hEzBVADxSXWP614fyuBOKc0jkv4+6cVwlmj5hgNGgHagnsJfY/n
	QQEj6FiMWSorJ3vskle7hmoOJbqV6vc8uMXAmNkIAE67bpp0O7GC+saDW5QWRW8UOUzm
	LB6znSdLFrgmCn+gTlf+0GjkUtQzo1Fqv7Nj1tW8clS9VEAuIdfmlRR5Q0Jk+dXPScO5
	RU2YIp3heOoMj/oZjt+XY69rIJQZutKc1sRvHxlNyj5MXGDAdAoN1lqEZenp1i2nvbqx
	BwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=UgJUbBDR/JNnpMQGuEj9pmNayvz4qvaj6ERuPxw8auo=;
	b=C5cDuDX5HvVp22ykXWQfDYtD7D9RgsxnqjKQd+59PvI0ToslIoKGHBPpR5eGA8/3lX
	FSsrEGDyFF0AVblsgNG6b+z0NEdiNGeX+O7Q48/YWUF05tmq16sg7A5uFZOKxexKonta
	n9MDvSZx40vgCx2Kgw9QQon8XQVxjNzhDgfjR7vGYtyYsOMq2my0cKkMm4+t6UZefaLK
	Bc1HALt8CrFnJy41/s0KgNKZX5VIlKGwbL06WNnpuze278BbtxpDFVNBgCFgiMJjGrlG
	4xHGNVc74b8mnxbhcqY2pt3E1DHUa1Z7OXMeUx0No7XATFhpSKxSwY3SQ86DZ1i6Ztev
	fF0Q==
X-Gm-Message-State: APjAAAXua+PQIfmB+RK1OD49iwGdu4Y1rjSpceLs0+ro322qwgVAzW4L
	tSmh47E+GOohos+4ICad3PE0TpC+JdGVcDBI9utMv/JPZ/c=
X-Google-Smtp-Source: APXvYqzm0I8hwLtvaT0O851tm3lxVgvum/BNEtPKcmmxKt8S1qCAIV8dQUJ0WMXcT+7fHZvmpt+DwMQKOXagpujtWyg=
X-Received: by 2002:ab0:41c2:: with SMTP id 60mr11123088uap.36.1574720558170; 
	Mon, 25 Nov 2019 14:22:38 -0800 (PST)
MIME-Version: 1.0
References: <20191113232303.29047-1-anibal.limon@linaro.org>
	<CAMKF1sqvx_ttxt+AhJ+1r+o4rt-z7VYNfSge5Du3N6mgjaYxJA@mail.gmail.com>
	<3ba6b1a5788f453aa1974a13342d148c@XBOX03.axis.com>
	<CA+_AqistmpdU+yAShaA7ypfng2r=d7xo_5t1UUOQE5Jj=X3Y8g@mail.gmail.com>
	<CA+_AqitPgjjOt1C8FTxd9FtjR_2V9Mgx5h9CYPNc53YuPkAmhA@mail.gmail.com>
In-Reply-To: <CA+_AqitPgjjOt1C8FTxd9FtjR_2V9Mgx5h9CYPNc53YuPkAmhA@mail.gmail.com>
From: Anibal Limon <anibal.limon@linaro.org>
Date: Mon, 25 Nov 2019 16:22:27 -0600
Message-ID: <CA+_Aqiszk=VG1gmvuNc6P44G2ZMoj7JP_nhvg1d3VttPE=TsUw@mail.gmail.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] lib/bb: Add BB_SIGNATURE_LOCAL_DIRS_EXCLUDE to speed-up taskhash on directories
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
X-List-Received-Date: Mon, 25 Nov 2019 22:22:38 -0000
Content-Type: multipart/alternative; boundary="0000000000007da088059833335a"

--0000000000007da088059833335a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Regarding some comments in PATCHv2 where default value was set [1], I agree
that this patch will be better and then set default value
in oe-core.

[1]
http://lists.openembedded.org/pipermail/bitbake-devel/2019-November/020519.=
html

On Thu, 14 Nov 2019 at 12:08, Anibal Limon <anibal.limon@linaro.org> wrote:

>
>
> On Thu, 14 Nov 2019 at 12:07, Anibal Limon <anibal.limon@linaro.org>
> wrote:
>
>>
>> On Thu, 14 Nov 2019 at 10:54, Peter Kjellerstedt <
>> peter.kjellerstedt@axis.com> wrote:
>>
>>> > -----Original Message-----
>>> > From: bitbake-devel-bounces@lists.openembedded.org <bitbake-devel-
>>> > bounces@lists.openembedded.org> On Behalf Of Khem Raj
>>> > Sent: den 14 november 2019 03:55
>>> > To: An=C3=ADbal Lim=C3=B3n <anibal.limon@linaro.org>
>>> > Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
>>> > Subject: Re: [bitbake-devel] [PATCH] lib/bb: Add
>>> > BB_SIGNATURE_LOCAL_DIRS_EXCLUDE to speed-up taskhash on directories
>>> >
>>> > On Wed, Nov 13, 2019 at 3:23 PM An=C3=ADbal Lim=C3=B3n <anibal.limon@=
linaro.org>
>>> > wrote:
>>> > >
>>> > > The new BB_SIGNATURE_LOCAL_DIRS_EXCLUDE allows you to specify a lis=
t
>>> > > of directories to exclude when making taskhash, our specific case
>>> > > is using SRC_URI that points local VCS directory.
>>> > >
>>> > > In OE-Core this variable could be set by default to:
>>> > >
>>> > > BB_SIGNATURE_LOCAL_DIRS_EXCLUDE =3D ".cvs .git .svn"
>>>
>>> That should be:
>>>
>>> BB_SIGNATURE_LOCAL_DIRS_EXCLUDE =3D "CVS .git .svn"
>>>
>>
>> So I will change to,
>>
>> + self.localdirsexclude =3D (data.getVar("BB_SIGNATURE_LOCAL_DIRS_EXCLUD=
E")
>> or "CVS .git .svn").split()
>>
>> Any other directory to add it?
>>
>
> Replying myself...
>
> What about add all VCS directories that we support in fetcher.
>
>
>>
>> Cheers,
>> Anibal
>>
>>
>>>
>>> > I like the approach.  perhaps a sane default would be nice.
>>>
>>> //Peter
>>>
>>>

--0000000000007da088059833335a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Regarding some comments in PATCHv2 where default valu=
e was set [1], I agree that this patch will be better and then set default =
value</div><div>in oe-core.</div><div><br></div><div>[1]=C2=A0<a href=3D"ht=
tp://lists.openembedded.org/pipermail/bitbake-devel/2019-November/020519.ht=
ml">http://lists.openembedded.org/pipermail/bitbake-devel/2019-November/020=
519.html</a></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"=
gmail_attr">On Thu, 14 Nov 2019 at 12:08, Anibal Limon &lt;<a href=3D"mailt=
o:anibal.limon@linaro.org">anibal.limon@linaro.org</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=
=3D"ltr"><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">On Thu, 14 Nov 2019 at 12:07, Anibal Limon &lt;<a href=3D"mail=
to:anibal.limon@linaro.org" target=3D"_blank">anibal.limon@linaro.org</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div d=
ir=3D"ltr"><div dir=3D"ltr"></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Thu, 14 Nov 2019 at 10:54, Peter Kjellerst=
edt &lt;<a href=3D"mailto:peter.kjellerstedt@axis.com" target=3D"_blank">pe=
ter.kjellerstedt@axis.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">&gt; -----Original Message-----<br>
&gt; From: <a href=3D"mailto:bitbake-devel-bounces@lists.openembedded.org" =
target=3D"_blank">bitbake-devel-bounces@lists.openembedded.org</a> &lt;bitb=
ake-devel-<br>
&gt; <a href=3D"mailto:bounces@lists.openembedded.org" target=3D"_blank">bo=
unces@lists.openembedded.org</a>&gt; On Behalf Of Khem Raj<br>
&gt; Sent: den 14 november 2019 03:55<br>
&gt; To: An=C3=ADbal Lim=C3=B3n &lt;<a href=3D"mailto:anibal.limon@linaro.o=
rg" target=3D"_blank">anibal.limon@linaro.org</a>&gt;<br>
&gt; Cc: bitbake-devel &lt;<a href=3D"mailto:bitbake-devel@lists.openembedd=
ed.org" target=3D"_blank">bitbake-devel@lists.openembedded.org</a>&gt;<br>
&gt; Subject: Re: [bitbake-devel] [PATCH] lib/bb: Add<br>
&gt; BB_SIGNATURE_LOCAL_DIRS_EXCLUDE to speed-up taskhash on directories<br=
>
&gt; <br>
&gt; On Wed, Nov 13, 2019 at 3:23 PM An=C3=ADbal Lim=C3=B3n &lt;<a href=3D"=
mailto:anibal.limon@linaro.org" target=3D"_blank">anibal.limon@linaro.org</=
a>&gt;<br>
&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; The new BB_SIGNATURE_LOCAL_DIRS_EXCLUDE allows you to specify a l=
ist<br>
&gt; &gt; of directories to exclude when making taskhash, our specific case=
<br>
&gt; &gt; is using SRC_URI that points local VCS directory.<br>
&gt; &gt;<br>
&gt; &gt; In OE-Core this variable could be set by default to:<br>
&gt; &gt;<br>
&gt; &gt; BB_SIGNATURE_LOCAL_DIRS_EXCLUDE =3D &quot;.cvs .git .svn&quot;<br=
>
<br>
That should be:<br>
<br>
BB_SIGNATURE_LOCAL_DIRS_EXCLUDE =3D &quot;CVS .git .svn&quot;<br></blockquo=
te><div><br></div><div>So I will change to,</div><div><br></div><div>+ self=
.localdirsexclude =3D (data.getVar(&quot;BB_SIGNATURE_LOCAL_DIRS_EXCLUDE&qu=
ot;) or &quot;CVS .git .svn&quot;).split()<br></div><div><br></div><div>Any=
 other directory to add it?</div></div></div></blockquote><div><br></div><d=
iv>Replying myself...</div><div><br></div><div>What about add all VCS direc=
tories that we support in fetcher.</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote=
"><div><br></div><div>Cheers,</div><div>Anibal</div><div>=C2=A0</div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; I like the approach.=C2=A0 perhaps a sane default would be nice.<br>
<br>
//Peter<br>
<br>
</blockquote></div></div>
</blockquote></div></div>
</blockquote></div></div>

--0000000000007da088059833335a--
