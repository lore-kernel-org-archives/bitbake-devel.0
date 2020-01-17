Return-Path: <kergoth@gmail.com>
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com
	[209.85.210.68])
	by mail.openembedded.org (Postfix) with ESMTP id 00F117FC0C
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 Jan 2020 20:44:10 +0000 (UTC)
Received: by mail-ot1-f68.google.com with SMTP id k14so23733521otn.4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 Jan 2020 12:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=uOXPgyMg0cVIeYwfbqgoq3FUSUZei1XDGw7TFRofMZw=;
	b=GF1hXSyUaHfxWR2JXE7n+RVnhdD6wQqfgEkySLsmVXlpN1cs0aTBcWFlEkXkfJ6zJ2
	2O2OlDZNtHstgyylC+Bry2jprNJEWkvhVB1XyyL+tJL0WpF0Ev2gxabFmUSxw2bDdt57
	8Tg9Dy+bHyhRjd40BR0jHvvjGeEn8zkAF6qtYOR0QsaWw7NzCE/BFrUEQF2ld20gvqnd
	o9et9HmMLZFhRICP4wIxns6z9DBRmU1+T8p6W0MqKAIpky7loydCjI/RQcSfepXSzPMB
	8WgnrbKJkjSQjIpRGvJKrbjMIg9zfrQ8UFmfOjw3YsjED5NxB1w0elq69NoIwHZh9krn
	EDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=uOXPgyMg0cVIeYwfbqgoq3FUSUZei1XDGw7TFRofMZw=;
	b=Q+g50x+l/5lo4CMKbAVa4GbM55MGNtr9hrOM1zzJPbIfVVFMpRS7ZPgRoknFzP2r/+
	SwOwuBLdq1Rl3knjo6UmK0qfttNZYV50Wq7kS6Q9v0izwcVHlGwl/3iCTENvqqFMfoTa
	3JnSSQw1WN8vP3UBPXnbYpPcNfQw9qKLw9JxIFNiv8mtVIGWUe6Ni+BW42N+zA++M1OC
	mPFC4Pt+ChdNoyBOT3VccbrXOGZgWwtNnusiTmlNpSebQjLG93UXtdGiWkhMDigZRMoh
	I7b8a6tBCYTDbXvCPihotUGJp8+3/K8yw7JT6r7zyL8lj+FzsVmDCpJTyJTHn3XEp7JL
	yAbw==
X-Gm-Message-State: APjAAAWr/5gLOqghK5nGlvRedeG7F3kQko6jqAK53H5jibWDR/Iwidf2
	fa8xCECZiaUCynSIo1j0xTVky+P/iO3Sft6XMSA=
X-Google-Smtp-Source: APXvYqwI00nPk20Y34TmJuU41jRupfxG7tag0Yv9tyfYHJ2PDokwk9peECyf6HdZ2yqpGUf3Ng4Cj8yT1yeQdmWSsFU=
X-Received: by 2002:a05:6830:1e16:: with SMTP id
	s22mr7555520otr.340.1579293851929; 
	Fri, 17 Jan 2020 12:44:11 -0800 (PST)
MIME-Version: 1.0
References: <20200117164548.28453-1-jean-marie.lemetayer@savoirfairelinux.com>
	<20200117164548.28453-9-jean-marie.lemetayer@savoirfairelinux.com>
In-Reply-To: <20200117164548.28453-9-jean-marie.lemetayer@savoirfairelinux.com>
From: Christopher Larson <kergoth@gmail.com>
Date: Fri, 17 Jan 2020 13:44:00 -0700
Message-ID: <CABcZANkG0e9z_pZrzOq--oNP=JPTk9UmnOfWOGaXVQU2MyCXWg@mail.gmail.com>
To: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinux.com>
Cc: Paul Eggleton <paul.eggleton@linux.intel.com>,
	bitbake-devel@lists.openembedded.org, rennes-dev@savoirfairelinux.com
Subject: Re: [PATCH v4 08/12] bitbake: fetch2/wget: fix downloadfilename parameter
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
X-List-Received-Date: Fri, 17 Jan 2020 20:44:11 -0000
Content-Type: multipart/alternative; boundary="0000000000000a5086059c5c011a"

--0000000000000a5086059c5c011a
Content-Type: text/plain; charset="UTF-8"

This doesn't escape the filename, it quotes it, so should probably correct
the message, and will almost certainly break if the name contains a single
quote. I'd suggest using subprocess.list2cmdline(), pipes.quote(), or
similar instead of doing it manually. Definitely a good fix, just likely
best done with an existing mechanism :) Thanks for the contribution.

On Fri, Jan 17, 2020 at 9:52 AM Jean-Marie LEMETAYER <
jean-marie.lemetayer@savoirfairelinux.com> wrote:

> When using a download filename with characters which can be interpreted
> by the shell ('(', ')', '&', ';', ...) the command fails. Escaping the
> filename fixes the issue.
>
> Signed-off-by: Jean-Marie LEMETAYER <
> jean-marie.lemetayer@savoirfairelinux.com>
> ---
>  lib/bb/fetch2/wget.py | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
> index 725586d2..6506e1e2 100644
> --- a/lib/bb/fetch2/wget.py
> +++ b/lib/bb/fetch2/wget.py
> @@ -94,9 +94,9 @@ class Wget(FetchMethod):
>          fetchcmd = self.basecmd
>
>          if 'downloadfilename' in ud.parm:
> -            dldir = d.getVar("DL_DIR")
> -            bb.utils.mkdirhier(os.path.dirname(dldir + os.sep +
> ud.localfile))
> -            fetchcmd += " -O " + dldir + os.sep + ud.localfile
> +            localpath = os.path.join(d.getVar("DL_DIR"), ud.localfile)
> +            bb.utils.mkdirhier(os.path.dirname(localpath))
> +            fetchcmd += " -O '%s'" % localpath
>
>          if ud.user and ud.pswd:
>              fetchcmd += " --user=%s --password=%s --auth-no-challenge" %
> (ud.user, ud.pswd)
> --
> 2.20.1
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>


-- 
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Senior Software Engineer, Mentor Graphics

--0000000000000a5086059c5c011a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">This doesn&#39;t escape the filename, it quotes it, so sho=
uld probably correct the message, and will almost certainly break if the na=
me contains a single quote. I&#39;d suggest using subprocess.list2cmdline()=
, pipes.quote(), or similar instead of doing it manually. Definitely a good=
 fix, just likely best done with an existing mechanism :) Thanks for the co=
ntribution.</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"g=
mail_attr">On Fri, Jan 17, 2020 at 9:52 AM Jean-Marie LEMETAYER &lt;<a href=
=3D"mailto:jean-marie.lemetayer@savoirfairelinux.com">jean-marie.lemetayer@=
savoirfairelinux.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-sty=
le:solid;border-left-color:rgb(204,204,204);padding-left:1ex">When using a =
download filename with characters which can be interpreted<br>
by the shell (&#39;(&#39;, &#39;)&#39;, &#39;&amp;&#39;, &#39;;&#39;, ...) =
the command fails. Escaping the<br>
filename fixes the issue.<br>
<br>
Signed-off-by: Jean-Marie LEMETAYER &lt;<a href=3D"mailto:jean-marie.lemeta=
yer@savoirfairelinux.com" target=3D"_blank">jean-marie.lemetayer@savoirfair=
elinux.com</a>&gt;<br>
---<br>
=C2=A0lib/bb/fetch2/wget.py | 6 +++---<br>
=C2=A01 file changed, 3 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py<br>
index 725586d2..6506e1e2 100644<br>
--- a/lib/bb/fetch2/wget.py<br>
+++ b/lib/bb/fetch2/wget.py<br>
@@ -94,9 +94,9 @@ class Wget(FetchMethod):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fetchcmd =3D self.basecmd<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if &#39;downloadfilename&#39; in ud.parm:=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dldir =3D d.getVar(&quot;DL_DIR&=
quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.utils.mkdirhier(os.path.dirna=
me(dldir + os.sep + ud.localfile))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fetchcmd +=3D &quot; -O &quot; +=
 dldir + os.sep + ud.localfile<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 localpath =3D os.path.join(d.get=
Var(&quot;DL_DIR&quot;), ud.localfile)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.utils.mkdirhier(os.path.dirna=
me(localpath))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fetchcmd +=3D &quot; -O &#39;%s&=
#39;&quot; % localpath<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ud.user and ud.pswd:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fetchcmd +=3D &quot; --user=
=3D%s --password=3D%s --auth-no-challenge&quot; % (ud.user, ud.pswd)<br>
-- <br>
2.20.1<br>
<br>
-- <br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_blank">b=
itbake-devel@lists.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/mailman/li=
stinfo/bitbake-devel</a><br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr">Christoph=
er Larson<br>kergoth at gmail dot com<br>Founder - BitBake, OpenEmbedded, O=
penZaurus<br>Senior Software Engineer, Mentor Graphics</div></div></div></d=
iv>

--0000000000000a5086059c5c011a--
