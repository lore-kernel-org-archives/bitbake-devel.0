Return-Path: <kergoth@gmail.com>
Received: from mail-vk0-f65.google.com (mail-vk0-f65.google.com
	[209.85.213.65])
	by mail.openembedded.org (Postfix) with ESMTP id B4D2F786C1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 20 Feb 2018 15:14:50 +0000 (UTC)
Received: by mail-vk0-f65.google.com with SMTP id x203so7799934vkx.10
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 20 Feb 2018 07:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=JtZ212egsmtQZHQz9o+g//T2V3s4HBGrz2qIQUoOvvg=;
	b=SdaHr6abh0BMpxwv032zk4JrucXUo3QtFSBbsAlOW3ncRfacS/xA1JtQlyqSNes2Yj
	LDVRu8XbSW3zw6ihzJArOANCe9RKTWSXZt03IoKT+sll2Ra7SMNv8Xoakc8PL8ZLNn0N
	lWv30zr3HYCLYwLrU+RJCcgLRoc1OD1jZdf1WAoYe4XEV5VBA0Ma3o/RhR+pXW6113wf
	tbyFsuyzcot31f6XmZ3l6eBhhNUVkrIUKJ2i3XzymmvX70Np1nG+05DJA/aK4A69iHbE
	YHeZ62PNh94Pur9XhcYlKpbjZ3UOAL4t862i72aQGYQ6JL75sVjAhWy2qxlIaQlt/t7L
	kdJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=JtZ212egsmtQZHQz9o+g//T2V3s4HBGrz2qIQUoOvvg=;
	b=mMXfzR9Tzu0/mUGqKYtcCeCniLgHhjtS3H+OKWPdMUw/wKRXzzRkoIbFP+fhmsVPKx
	JKIF/eCQjL1HwsXpO/R/wq+C+9LlS2/JN6/yk5x/OYik8XklZ/kK+DzJNG3IiijvHcDh
	ZzXZGmwsFMDV/UqvysQvMrbxnfrP/Q4EoBGb6RWAqOye0fJlXynGBA3dwtINFSBeWJqS
	h8dYaoxYSfVP/NJZzT0J307q1hXr1VHQLSJEWf6a+VPfLCMokAUxwhrKeuDPptA19a92
	90y6OPdsLCy1W0pjbQsEQVfVmhSYLrVKjIIRbKN6/pXSYzPsyB3AbghWK/Vdp3UQdYxw
	YCpA==
X-Gm-Message-State: APf1xPAd6tgIsnjhgoKDOLq8za5/cvlTT8FxJD6GVKBHEoQHqgn12yc4
	9rF5FFTXgELxxrycMwduBAMTrfiCo35UgiWZ5OQ=
X-Google-Smtp-Source: AH8x224bnihOPtjp6zBpAWUT/+OBzlrjNVp4qNzzMCn6pI9qOTeG10Ak/RwOfM59dLf8ZXXF86TGUS4cyoyez6E6Nfc=
X-Received: by 10.31.146.148 with SMTP id u142mr13216000vkd.109.1519139691705; 
	Tue, 20 Feb 2018 07:14:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.61.25 with HTTP; Tue, 20 Feb 2018 07:14:31 -0800 (PST)
In-Reply-To: <1519128500.24236.291.camel@linuxfoundation.org>
References: <20180219181551.87750-1-stephano.cetola@linux.intel.com>
	<20180219181551.87750-2-stephano.cetola@linux.intel.com>
	<1519128500.24236.291.camel@linuxfoundation.org>
From: Christopher Larson <kergoth@gmail.com>
Date: Tue, 20 Feb 2018 08:14:31 -0700
Message-ID: <CABcZANnjaUwFr=CrMX6HgA1iYEhUnKxKAvZ2uYvKMYpDPZ0woQ@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH V2 1/1] utils.py: Add option for explode_dep_versions2 to return unsorted
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
X-List-Received-Date: Tue, 20 Feb 2018 15:14:51 -0000
Content-Type: multipart/alternative; boundary="001a11439378b03c050565a6451e"

--001a11439378b03c050565a6451e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2018 at 5:08 AM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Mon, 2018-02-19 at 10:15 -0800, Stephano Cetola wrote:
> > From: Amanda Brindle <amanda.r.brindle@intel.com>
> >
> > Before, explode_dep_versions2 would sort the OrderedDict before
> > returning. This function will still sort the OrderedDict by default,
> > but
> > will now have the option to return the OrderedDict unsorted. This
> > option will
> > allow us to check if the order of the package list has changed.
> >
> > Signed-off-by: Amanda Brindle <amanda.r.brindle@intel.com>
> > Acked-by: Stephano Cetola <stephano.cetola@linux.intel.com>
> > ---
> >  lib/bb/utils.py | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/bb/utils.py b/lib/bb/utils.py
> > index c540b49c..7adb4690 100644
> > --- a/lib/bb/utils.py
> > +++ b/lib/bb/utils.py
> > @@ -187,7 +187,7 @@ def explode_deps(s):
> >              #r[-1] +=3D ' ' + ' '.join(j)
> >      return r
> >
> > -def explode_dep_versions2(s):
> > +def explode_dep_versions2(s, unsorted=3DFalse):
> >      """
>
> Would:
>
> def explode_dep_versions2(s, sorted=3DTrue):
>
> make things easier to read/understand?
>
> The 'double' logic there currently confuses me a bit.


sorted=3DTrue seems clearer to me as well. I=E2=80=99d also recommend think=
ing about
making this a keyword-only argument, for readability=E2=80=99s sake.

explode_dep_versions2(s, False) reads pretty unclear, since it loses the
info about the meaning of False. Making it keyword only would ensure we=E2=
=80=99re
forced to called it as sorted=3DFalse instead.
--=20
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Senior Software Engineer, Mentor Graphics

--001a11439378b03c050565a6451e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Tue, Feb 20, 2018 at 5:08 AM, Richard Purdie <span dir=3D"ltr">&lt;<=
a href=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">rich=
ard.purdie@linuxfoundation.org</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><span class=3D"">On Mon, 2018-02-19 at 10:15 -0800, Stephano =
Cetola wrote:<br>
&gt; From: Amanda Brindle &lt;<a href=3D"mailto:amanda.r.brindle@intel.com"=
>amanda.r.brindle@intel.com</a>&gt;<br>
&gt;<br>
&gt; Before, explode_dep_versions2 would sort the OrderedDict before<br>
&gt; returning. This function will still sort the OrderedDict by default,<b=
r>
&gt; but<br>
&gt; will now have the option to return the OrderedDict unsorted. This<br>
&gt; option will<br>
&gt; allow us to check if the order of the package list has changed.<br>
&gt;<br>
&gt; Signed-off-by: Amanda Brindle &lt;<a href=3D"mailto:amanda.r.brindle@i=
ntel.com">amanda.r.brindle@intel.com</a>&gt;<br>
&gt; Acked-by: Stephano Cetola &lt;<a href=3D"mailto:stephano.cetola@linux.=
intel.com">stephano.cetola@linux.intel.<wbr>com</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0lib/bb/utils.py | 5 +++--<br>
&gt; =C2=A01 file changed, 3 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/lib/bb/utils.py b/lib/bb/utils.py<br>
&gt; index c540b49c..7adb4690 100644<br>
&gt; --- a/lib/bb/utils.py<br>
&gt; +++ b/lib/bb/utils.py<br>
&gt; @@ -187,7 +187,7 @@ def explode_deps(s):<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0#r[-1] +=3D &#39; &#39; + &#39; &#39;.join(j)<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return r<br>
&gt; =C2=A0<br>
&gt; -def explode_dep_versions2(s):<br>
&gt; +def explode_dep_versions2(s, unsorted=3DFalse):<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&quot;&quot;&quot;<br>
<br>
</span>Would:<br>
<br>
def explode_dep_versions2(s, sorted=3DTrue):<br>
<br>
make things easier to read/understand?<br>
<br>
The &#39;double&#39; logic there currently confuses me a bit.</blockquote><=
div><br></div><div>sorted=3DTrue seems clearer to me as well. I=E2=80=99d a=
lso recommend thinking about making this a keyword-only argument, for reada=
bility=E2=80=99s sake.</div><div><br></div><div>explode_dep_versions2(s, Fa=
lse) reads pretty unclear, since it loses the info about the meaning of Fal=
se. Making it keyword only would ensure we=E2=80=99re forced to called it a=
s sorted=3DFalse instead.</div></div>-- <br><div class=3D"gmail_signature" =
data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr">C=
hristopher Larson<br>kergoth at gmail dot com<br>Founder - BitBake, OpenEmb=
edded, OpenZaurus<br>Senior Software Engineer, Mentor Graphics</div></div><=
/div></div>
</div></div>

--001a11439378b03c050565a6451e--
