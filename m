Return-Path: <garbados@gmail.com>
Received: from mail-pf0-f177.google.com (mail-pf0-f177.google.com
	[209.85.192.177])
	by mail.openembedded.org (Postfix) with ESMTP id 23FCF77D6B
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Jun 2017 20:48:57 +0000 (UTC)
Received: by mail-pf0-f177.google.com with SMTP id c73so5668216pfk.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Jun 2017 13:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=3u7LvpkiS5Wt4TklXuq9lVAoUTMffasoa6V3ZPZyMeE=;
	b=T/bIWS7Ga5yqykHY3LBY5DuOkbC9x3hOSXG62GlJ/zpzzrfQQN9Mj1sOkFuxagJ5Ua
	nPEn4eOTMG5Cs0VwrnjueCCESIfZXSeXkOQ0HTEvdr9yoRIvKi1iKbY4zHIM4Qc7m4V3
	BjFQ/lCquodeRCN7dKJqX9XWogXodNNYeFeHITraev7SJlGvMCD2ZjOrqD5SKrhAijig
	Xqw9ICP4ho7yUqq7tTJrBpsPpbMugor3Y1LPTpPnS45IS7KqZM3Q+jidFqJyobPGHDsT
	NsbD1sFkQpP15tykOOqyDaZxV/LziPYMlXcSrAglF3XmdmLpWZDCZTHNnBXHBH+Q+1oX
	X9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=3u7LvpkiS5Wt4TklXuq9lVAoUTMffasoa6V3ZPZyMeE=;
	b=tvJeuhVIRf+6ITBFIxhkEH8QexJzgqPqXr3JYQgVa3Hq4euDMiKGZcyLq4freCxodV
	03hVV4gEMHZXmvkS7oGEYZo/NXTFi5Xyl48BWhYO+lWEKKnIkgX6bJ5L2V4SOqR7R+WD
	AqZMjOnF/HUiLtIhlAEkicyFVhSYm/17wQdfnjQ6bn5R2g9L4C05/swRZX5l2nb2tgf+
	NqCdTuf0CI4TFe0oF/uTJcXtWhr2JrVBqR4UDAKAS/kd0N5dAwnbuQ2qWmc1F2RP8abl
	V+mbdCEaDXEDD590Av3ZaJOhLVVe1IvuNlF63YJW8SOl492oHtrnkv4cenPfX8CO6jWv
	AO2g==
X-Gm-Message-State: AKS2vOwkBlahDBGCkHERgF9I4z+eF6kKwGGwKolSVD1FWZ70wTv2m5D4
	hkhpl0E5flvvcGNlFWqC0ryWapVZww==
X-Received: by 10.84.135.1 with SMTP id 1mr2119448pli.185.1498510139177; Mon,
	26 Jun 2017 13:48:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.225 with HTTP; Mon, 26 Jun 2017 13:48:18 -0700 (PDT)
In-Reply-To: <f4460c4f34ab4bfd9e888f8bd82981c4@XBOX02.axis.com>
References: <1497934470-12092-1-git-send-email-garbados@gmail.com>
	<CAJTo0LYy-VBcrqnx4k2uF5nETq2bhf75vdpMvxZ7mKrU1du93g@mail.gmail.com>
	<f4460c4f34ab4bfd9e888f8bd82981c4@XBOX02.axis.com>
From: Diana Thayer <garbados@gmail.com>
Date: Mon, 26 Jun 2017 13:48:18 -0700
Message-ID: <CA++8a_CjpqxQM+1xw_s5o+QX0VO1GS0PWBEQtnvxBXXJ9==GgA@mail.gmail.com>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] bitbake : Paginate 'bitbake -e' using less.
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
X-List-Received-Date: Mon, 26 Jun 2017 20:48:58 -0000
Content-Type: multipart/alternative; boundary="94eb2c11a65489c1060552e3145d"

--94eb2c11a65489c1060552e3145d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for the feedback!

I've added lines to check $OE_PAGER and $PAGER, such that `PAGER=3Dcat
bitbake -e` effectively disables pagination.

Regarding the option '--paginate', would it capture output from whatever
command has run? I'm not sure how to capture stdout at such a scope.


On Tue, Jun 20, 2017 at 6:39 AM, Peter Kjellerstedt <
peter.kjellerstedt@axis.com> wrote:

> Basically, this change needs to be aware of the destination for the
> output. If it is a tty, then it is fine to output to a viewer such as les=
s,
> but otherwise it should go to stdout as before. This should of course not
> be hardcoded, but use environment variables, e.g., $OE_PAGER || $PAGER ||
> less (inspired by git_pager() in the git source). You should also not
> expect that everyone wants the options you have used for less. Looking
> again at how git handles this, they use =E2=80=9CLESS=3DFRX <command>=E2=
=80=9D if the $LESS
> environment variable is not set, and does not modify it if it is set. You
> also want to add options such as --paginate and --no-pager (yet again
> inspired by git) to bitbake.
>
>
>
> All in all, look at and be inspired by how git handles pagers, they have
> this pretty well covered.
>
>
>
> //Peter
>
>
>
> *From:* bitbake-devel-bounces@lists.openembedded.org [mailto:
> bitbake-devel-bounces@lists.openembedded.org] *On Behalf Of *Burton, Ross
> *Sent:* den 20 juni 2017 12:06
> *To:* Diana Thayer <garbados@gmail.com>
> *Cc:* bitbake-devel <bitbake-devel@lists.openembedded.org>
> *Subject:* Re: [bitbake-devel] [PATCH] bitbake : Paginate 'bitbake -e'
> using less.
>
>
>
>
>
> On 20 June 2017 at 05:54, Diana Thayer <garbados@gmail.com> wrote:
>
> +        pager =3D subprocess.Popen(['less', '-F', '-R', '-S', '-X', '-K'=
],
> +                                 stdin=3Dsubprocess.PIPE,
> +                                 stdout=3Dsys.stdout,
> +                                 universal_newlines=3DTrue)
>
>
> What if I'm piping bitbake -e though grep or into a file already?
>
>
>
> Ross
>

--94eb2c11a65489c1060552e3145d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thank you for the feedback!<div><br></div><div>I&#39;ve ad=
ded lines to check $OE_PAGER and $PAGER, such that `PAGER=3Dcat bitbake -e`=
 effectively disables pagination.</div><div><br></div><div>Regarding the op=
tion &#39;--paginate&#39;, would it capture output from whatever command ha=
s run? I&#39;m not sure how to capture stdout at such a scope.</div><div><b=
r></div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On =
Tue, Jun 20, 2017 at 6:39 AM, Peter Kjellerstedt <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:peter.kjellerstedt@axis.com" target=3D"_blank">peter.kjellers=
tedt@axis.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">





<div lang=3D"SV" link=3D"blue" vlink=3D"purple">
<div class=3D"m_-2171653402677448379WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;color:#943634">Basically, this change=
 needs to be aware of the destination for the output. If it is a tty, then =
it is fine to output
 to a viewer such as less, but otherwise it should go to stdout as before. =
This should of course not be hardcoded, but use environment variables, e.g.=
, $OE_PAGER || $PAGER || less (inspired by git_pager() in the git source). =
You should also not expect that
 everyone wants the options you have used for less. Looking again at how gi=
t handles this, they use =E2=80=9CLESS=3DFRX &lt;command&gt;=E2=80=9D if th=
e $LESS environment variable is not set, and does not modify it if it is se=
t. You also want to add options such as --paginate and --no-pager
 (yet again inspired by git) to bitbake.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;color:#943634"><u></u>=C2=A0<u></u></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;color:#943634">All in all, look at an=
d be inspired by how git handles pagers, they have this pretty well covered=
.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;color:#943634"><u></u>=C2=A0<u></u></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;color:#943634">//Peter<u></u><u></u><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;color:#943634"><u></u>=C2=A0<u></u></=
span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #e1e1e1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span lang=3D"EN-=
US" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"> =
<a href=3D"mailto:bitbake-devel-bounces@lists.openembedded.org" target=3D"_=
blank">bitbake-devel-bounces@lists.<wbr>openembedded.org</a> [mailto:<a hre=
f=3D"mailto:bitbake-devel-bounces@lists.openembedded.org" target=3D"_blank"=
>bitbake-devel-bounces@<wbr>lists.openembedded.org</a>]
<b>On Behalf Of </b>Burton, Ross<br>
<b>Sent:</b> den 20 juni 2017 12:06<br>
<b>To:</b> Diana Thayer &lt;<a href=3D"mailto:garbados@gmail.com" target=3D=
"_blank">garbados@gmail.com</a>&gt;<br>
<b>Cc:</b> bitbake-devel &lt;<a href=3D"mailto:bitbake-devel@lists.openembe=
dded.org" target=3D"_blank">bitbake-devel@lists.<wbr>openembedded.org</a>&g=
t;<br>
<b>Subject:</b> Re: [bitbake-devel] [PATCH] bitbake : Paginate &#39;bitbake=
 -e&#39; using less.<u></u><u></u></span></p>
</div>
</div><div><div class=3D"h5">
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<p class=3D"MsoNormal">On 20 June 2017 at 05:54, Diana Thayer &lt;<a href=
=3D"mailto:garbados@gmail.com" target=3D"_blank">garbados@gmail.com</a>&gt;=
 wrote:<u></u><u></u></p>
<blockquote style=3D"border:none;border-left:solid #cccccc 1.0pt;padding:0c=
m 0cm 0cm 6.0pt;margin-left:4.8pt;margin-right:0cm">
<div id=3D"m_-2171653402677448379:9ou">
<p class=3D"MsoNormal">+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pager =3D subprocess.Po=
pen([&#39;less&#39;, &#39;-F&#39;, &#39;-R&#39;, &#39;-S&#39;, &#39;-X&#39;=
, &#39;-K&#39;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stdin=3Dsubprocess.PIPE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stdout=3Dsys.stdout,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0universal_newlines=3DTrue)<u><=
/u><u></u></p>
</div>
</blockquote>
</div>
<p class=3D"MsoNormal"><br>
What if I&#39;m piping bitbake -e though grep or into a file already?<u></u=
><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Ross<u></u><u></u></p>
</div>
</div>
</div></div></div>
</div>
</div>

</blockquote></div><br></div>

--94eb2c11a65489c1060552e3145d--
