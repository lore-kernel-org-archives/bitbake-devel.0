Return-Path: <jacob.kroon@gmail.com>
Received: from mail-la0-f53.google.com (mail-la0-f53.google.com
	[209.85.215.53])
	by mail.openembedded.org (Postfix) with ESMTP id DDE5265EC3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Apr 2014 11:55:48 +0000 (UTC)
Received: by mail-la0-f53.google.com with SMTP id ec20so4858606lab.26
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Apr 2014 04:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=B9n/9FCxrEAyZxj5r2eFZ1++GN+9tVId9/XscNj3Z9I=;
	b=B22qcyOG3UiNvPfhUC8iAs+Qi69cWtu+QfZ/hh0g2AjK/MvPxvi4rf4qoFxCmbFdoA
	VAtum7p5AXTsF0QdZ6CMeEBSFsa4Gw9NvN3pzYuLQYHcQEpC8oiO+FUS3/qkoF6NVHIA
	84XMDN+OTEwHZ/Euw5O6B8Q/g59AbURdenOO6TpJIhKyl6AheRwF8276LaBN+hijNC4v
	hyserWEa1FEkGQnsiNMSayc02f8jD+mPbx7HSh1qrELDDYIKt70xUGXCCfv3cmgGPr0r
	ZLmZn3JE+IOf1YjDRmom+RM0d7uRbL180X+kLtxtWyZQeshmVT7/R4I+Z8uSXIInmJkH
	HIBw==
MIME-Version: 1.0
X-Received: by 10.112.171.67 with SMTP id as3mr18163449lbc.10.1398686148488;
	Mon, 28 Apr 2014 04:55:48 -0700 (PDT)
Received: by 10.112.53.73 with HTTP; Mon, 28 Apr 2014 04:55:48 -0700 (PDT)
In-Reply-To: <4256087.6AVRx8IQuU@peggleto-mobl5.ger.corp.intel.com>
References: <1398522738-8979-1-git-send-email-jacob.kroon@mikrodidakt.se>
	<4256087.6AVRx8IQuU@peggleto-mobl5.ger.corp.intel.com>
Date: Mon, 28 Apr 2014 13:55:48 +0200
Message-ID: <CAPbeDCk-0ajUc+1XryV-JqhQkg=_kFcrtiVJy3Tg=__rV0jBLg@mail.gmail.com>
From: Jacob Kroon <jacob.kroon@gmail.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Jacob Kroon <jacob.kroon@mikrodidakt.se>
Subject: Re: [PATCH] fetch2: Cleanup file checksum generation
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
X-List-Received-Date: Mon, 28 Apr 2014 11:55:50 -0000
Content-Type: multipart/alternative; boundary=001a11c2620c0873dd04f818ff81

--001a11c2620c0873dd04f818ff81
Content-Type: text/plain; charset=UTF-8

On Mon, Apr 28, 2014 at 1:23 PM, Paul Eggleton <
paul.eggleton@linux.intel.com> wrote:

> On Saturday 26 April 2014 16:32:18 Jacob Kroon wrote:
> > Cleanup the fix done in f9416e76e272ba3249abff099f6f3a47fe82e03e.
> >
> > Instead of adding continue statements we can just move the last
> > statements into the final else-clause.
> >
> > Signed-off-by: Jacob Kroon <jacob.kroon@mikrodidakt.se>
> > ---
> >  lib/bb/fetch2/__init__.py | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> > index 5a03a0e..bc4e8fd 100644
> > --- a/lib/bb/fetch2/__init__.py
> > +++ b/lib/bb/fetch2/__init__.py
> > @@ -985,15 +985,12 @@ def get_file_checksums(filelist, pn):
> >                      checksum = checksum_file(f)
> >                      if checksum:
> >                          checksums.append((f, checksum))
>
> Note the above, then see below.
>
> > -            continue
> >          elif os.path.isdir(pth):
> >              checksums.extend(checksum_dir(pth))
> > -            continue
> >          else:
> >              checksum = checksum_file(pth)
> > -
> > -        if checksum:
> > -            checksums.append((pth, checksum))
> > +            if checksum:
> > +                checksums.append((pth, checksum))
> >
> >      checksums.sort(key=operator.itemgetter(1))
> >      return checksums
>
> This cleanup seems innocuous but unfortunately it does cause a change in
> behaviour - now for the glob case we will get the last item duplicated
> because
> it will be added to the list a second time at the end.
>
>
Sorry..
But I can't see why this would cause a different behaviour. Both previous
'continue' statements applied to the outer for-loop. Unless they have an
effect on the if-statements aswell ?

--001a11c2620c0873dd04f818ff81
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On M=
on, Apr 28, 2014 at 1:23 PM, Paul Eggleton <span dir=3D"ltr">&lt;<a href=3D=
"mailto:paul.eggleton@linux.intel.com" target=3D"_blank">paul.eggleton@linu=
x.intel.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"">On Saturday 26 April 2014 16=
:32:18 Jacob Kroon wrote:<br>
&gt; Cleanup the fix done in f9416e76e272ba3249abff099f6f3a47fe82e03e.<br>
&gt;<br>
&gt; Instead of adding continue statements we can just move the last<br>
&gt; statements into the final else-clause.<br>
&gt;<br>
&gt; Signed-off-by: Jacob Kroon &lt;<a href=3D"mailto:jacob.kroon@mikrodida=
kt.se">jacob.kroon@mikrodidakt.se</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0lib/bb/fetch2/__init__.py | 7 ++-----<br>
&gt; =C2=A01 file changed, 2 insertions(+), 5 deletions(-)<br>
&gt;<br>
&gt; diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py<br>
&gt; index 5a03a0e..bc4e8fd 100644<br>
&gt; --- a/lib/bb/fetch2/__init__.py<br>
&gt; +++ b/lib/bb/fetch2/__init__.py<br>
&gt; @@ -985,15 +985,12 @@ def get_file_checksums(filelist, pn):<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0checksum =3D checksum_file(f)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0if checksum:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0checksums.append((f, checksum))<br>
<br>
</div>Note the above, then see below.<br>
<div class=3D""><br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0elif os.path.isdir(pth):<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0checksums.extend(check=
sum_dir(pth))<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0checksum =3D checksum_=
file(pth)<br>
&gt; -<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0if checksum:<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0checksums.append((pth, chec=
ksum))<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if checksum:<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0checksums.app=
end((pth, checksum))<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0checksums.sort(key=3Doperator.itemgetter(1))<br>
&gt; =C2=A0 =C2=A0 =C2=A0return checksums<br>
<br>
</div>This cleanup seems innocuous but unfortunately it does cause a change=
 in<br>
behaviour - now for the glob case we will get the last item duplicated beca=
use<br>
it will be added to the list a second time at the end.<br>
<br></blockquote><br></div><div class=3D"gmail_quote">Sorry..<br>But I can&=
#39;t see why this would cause a different behaviour. Both previous &#39;co=
ntinue&#39; statements applied to the outer for-loop. Unless they have an e=
ffect on the if-statements aswell ?<br>
</div></div></div>

--001a11c2620c0873dd04f818ff81--
