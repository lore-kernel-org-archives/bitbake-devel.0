Return-Path: <anibal.limon@linaro.org>
Received: from mail-vs1-f65.google.com (mail-vs1-f65.google.com
	[209.85.217.65])
	by mail.openembedded.org (Postfix) with ESMTP id 4EBF47F986
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Nov 2019 18:08:27 +0000 (UTC)
Received: by mail-vs1-f65.google.com with SMTP id c25so4511750vsp.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Nov 2019 10:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=RZLE7MDmCeu9nC+jBQWcz48MXzBP0WpSNYCHOhr1vyc=;
	b=DeKi6z22WiQX38A0D5lsZxVT8Os52/Y4hzHJLAhOzNgBj1MT0XOdYcj4v8PTMse2Hy
	kIgOnnRhG46IeBQSY9tZ3EzfCVOP+xLNSZHF/O3hC5pXLAxwodOeSTRqxDJTgDSTGU5E
	YuYJE6uoZHY7ceBSqQglcH9hgbDEzLMaK0rFDisM1Emsx8J2VcIYn9rRhRQWmboiLNDG
	3Vh/XZRedxpSPHay+Y2VPnlyxkzXoq1hgIYkSw+sgLAZwfk5yrJILi8RkqdYoqImXpH8
	NYknu8lJNUjX+dru7pC61Xm1aubeCVh3iVjP+Ellq3i9JrSdZ5lZhr2cOx8VbnBfNz2q
	zo7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=RZLE7MDmCeu9nC+jBQWcz48MXzBP0WpSNYCHOhr1vyc=;
	b=LSBdO0Vel6K3rU+7XO1C8qbRSpTbiRqmrFC3FWp/LWT5kgIiod8CYZ+ietzCedZs5e
	Zokh9WdA3O1D2EYOuwpu7KZ1TYnXcGcTFiSleB5ZTz6zIuemPjl4NIlNd+PLbO0UlwSY
	wtzWz2k9ourmmlK/nNO5olWWYZaFCpK2nCrqWUaQ9s0zTrZIxsbR3rJVBQVHiC5fmRDr
	DZI2hCa8EOYzlxORMn7xUoUlmVcYKGdcsh4Rr//azoZS9YvDCpmYCl6QreT4v0nhiR1k
	UkJJiUvbrT50QZ4wnHywn+KSc4TgSVar0n2E9nmjIv+ADTn3QCTOnE7suYpUmVVb6Kqo
	A8UA==
X-Gm-Message-State: APjAAAWbTilhFySRO4A5WpIPhwOrlusAt4++ZDgKZ4JfxU3/Hp2OYuV5
	UHc4g9WIGeKQdowsV+nGPa2vqeJ16FMGS8tLCrPkRUsl
X-Google-Smtp-Source: APXvYqxyr8UqATsui0FepWpUK+bPD7cpSIBtM6ApdE1wHK/f0M7u6s9jF6ILWWbBv4g9dWQbxR7o7mTkq644As4sIzs=
X-Received: by 2002:a67:77d4:: with SMTP id s203mr6530831vsc.118.1573754908031;
	Thu, 14 Nov 2019 10:08:28 -0800 (PST)
MIME-Version: 1.0
References: <20191113232303.29047-1-anibal.limon@linaro.org>
	<CAMKF1sqvx_ttxt+AhJ+1r+o4rt-z7VYNfSge5Du3N6mgjaYxJA@mail.gmail.com>
	<3ba6b1a5788f453aa1974a13342d148c@XBOX03.axis.com>
	<CA+_AqistmpdU+yAShaA7ypfng2r=d7xo_5t1UUOQE5Jj=X3Y8g@mail.gmail.com>
In-Reply-To: <CA+_AqistmpdU+yAShaA7ypfng2r=d7xo_5t1UUOQE5Jj=X3Y8g@mail.gmail.com>
From: Anibal Limon <anibal.limon@linaro.org>
Date: Thu, 14 Nov 2019 12:08:16 -0600
Message-ID: <CA+_AqitPgjjOt1C8FTxd9FtjR_2V9Mgx5h9CYPNc53YuPkAmhA@mail.gmail.com>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
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
X-List-Received-Date: Thu, 14 Nov 2019 18:08:27 -0000
Content-Type: multipart/alternative; boundary="00000000000041d6a60597525e7b"

--00000000000041d6a60597525e7b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Nov 2019 at 12:07, Anibal Limon <anibal.limon@linaro.org> wrote:

>
> On Thu, 14 Nov 2019 at 10:54, Peter Kjellerstedt <
> peter.kjellerstedt@axis.com> wrote:
>
>> > -----Original Message-----
>> > From: bitbake-devel-bounces@lists.openembedded.org <bitbake-devel-
>> > bounces@lists.openembedded.org> On Behalf Of Khem Raj
>> > Sent: den 14 november 2019 03:55
>> > To: An=C3=ADbal Lim=C3=B3n <anibal.limon@linaro.org>
>> > Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
>> > Subject: Re: [bitbake-devel] [PATCH] lib/bb: Add
>> > BB_SIGNATURE_LOCAL_DIRS_EXCLUDE to speed-up taskhash on directories
>> >
>> > On Wed, Nov 13, 2019 at 3:23 PM An=C3=ADbal Lim=C3=B3n <anibal.limon@l=
inaro.org>
>> > wrote:
>> > >
>> > > The new BB_SIGNATURE_LOCAL_DIRS_EXCLUDE allows you to specify a list
>> > > of directories to exclude when making taskhash, our specific case
>> > > is using SRC_URI that points local VCS directory.
>> > >
>> > > In OE-Core this variable could be set by default to:
>> > >
>> > > BB_SIGNATURE_LOCAL_DIRS_EXCLUDE =3D ".cvs .git .svn"
>>
>> That should be:
>>
>> BB_SIGNATURE_LOCAL_DIRS_EXCLUDE =3D "CVS .git .svn"
>>
>
> So I will change to,
>
> + self.localdirsexclude =3D (data.getVar("BB_SIGNATURE_LOCAL_DIRS_EXCLUDE=
")
> or "CVS .git .svn").split()
>
> Any other directory to add it?
>

Replying myself...

What about add all VCS directories that we support in fetcher.


>
> Cheers,
> Anibal
>
>
>>
>> > I like the approach.  perhaps a sane default would be nice.
>>
>> //Peter
>>
>>

--00000000000041d6a60597525e7b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, 14 Nov 2019 at 12:07, Anibal =
Limon &lt;<a href=3D"mailto:anibal.limon@linaro.org">anibal.limon@linaro.or=
g</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
><div dir=3D"ltr"><div dir=3D"ltr"></div><br><div class=3D"gmail_quote"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Thu, 14 Nov 2019 at 10:54, Peter Kjel=
lerstedt &lt;<a href=3D"mailto:peter.kjellerstedt@axis.com" target=3D"_blan=
k">peter.kjellerstedt@axis.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">&gt; -----Original Message-----<br>
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

--00000000000041d6a60597525e7b--
