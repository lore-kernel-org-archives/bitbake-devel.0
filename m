Return-Path: <soemoe.a@gmail.com>
Received: from mail-io0-f193.google.com (mail-io0-f193.google.com
	[209.85.223.193])
	by mail.openembedded.org (Postfix) with ESMTP id 47E3771E10
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 30 Mar 2018 15:46:47 +0000 (UTC)
Received: by mail-io0-f193.google.com with SMTP id d5so11430239iob.9
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 30 Mar 2018 08:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=6e8oq3cz46o6LfYPGPj47LkTgaREPFM4xZClp8OmQR0=;
	b=uQd75bEPE5ec2NC01ru5xb4xWlFK+AfPonJcfX1eFAT1YCm2cIWEgGqoO6/Xkzd/x4
	FzzdEFkhZoiodWfJhAtU1iacBeK+HgyZAe3ze7F76XMqv4Uzp6L+tjDuRqDJSPFF7B5M
	sgjB2KMxyDAea5STlWYFNpY79wfAurD5FuGp0J+JidELjTfmLq+z/A8Kar20OWErrLLG
	QLkrrGcPh1Z123yTiWOUtCZzoJxzbFJXwBUdFKYVAlP6ao3Wtn2VJdbKqrWEklXFOoSc
	/RGBiSMfTvYeAYTAa1C0DVKhoCi1QF3PAomXLhuV/Jq0IowAUiwCj0F7i8CxgRE2Rckb
	z0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=6e8oq3cz46o6LfYPGPj47LkTgaREPFM4xZClp8OmQR0=;
	b=opbuXZMzC95FdPf3/ngXXpkhn/R8SuAvgZilf3YTwqF9SpXz5jqyxQjLpBe6RwMslQ
	1eP3ZRmqsq8x7wdTJ7wZckZWXvOIRpIA5Pxn6OnXHAQ/qLfdKkDSNYXFxFaQvL09wddR
	95NxuK7pAZY5eDVwBPXwIPbI+KeUDo5DZv23MJ1R8iSaFWaSQJwMnRBRE4cRbYkBmA9y
	7AE3BGgJgKUrwB+l3W9zo1s9qAhtE58aWQa1dAtPnOhwi2ic+9g8x+VjUJPCtlaEkPIU
	oiNLOXPfblbe9/oxbJPt9QtE38oKRJx071CzS0QmK28DAz+W+ro+uAUogpMno64W2w8c
	HA5g==
X-Gm-Message-State: AElRT7G0cPIEkuqzdO/PAunjcU/NSQA1sN8i1DAgKXlYeBS0fO7rilUb
	IsySYbUzVxU2twz8BPAchBcDW5m1n5xRDuYD3ZU=
X-Google-Smtp-Source: AG47ELs/neblZ5Ml99IFi5LBGkQ4cjZYk7f83AiWHhoUtHpzUXOtLgU2817jhrPh2ghN6smB9IN+L8LmGzgBe+ij5bs=
X-Received: by 10.107.169.81 with SMTP id s78mr55258938ioe.83.1522424808492;
	Fri, 30 Mar 2018 08:46:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.2.56.65 with HTTP; Fri, 30 Mar 2018 08:46:28 -0700 (PDT)
In-Reply-To: <de8d9c1dbc15412fbe62871ca826e78e@XBOX02.axis.com>
References: <cover.1522085586.git.soemoe.a@gmail.com>
	<1522230112838.18244@axis.com>
	<CAPTBsuX3NZmgqqE4bGTQ29k=yp7F6Z_Anwawue=W+3ab1fG3Og@mail.gmail.com>
	<de8d9c1dbc15412fbe62871ca826e78e@XBOX02.axis.com>
From: Soemoe Aung <soemoe.a@gmail.com>
Date: Fri, 30 Mar 2018 08:46:28 -0700
Message-ID: <CAPTBsuW-gUOLj=u0FwJdj0Ti-ejECRupwLhBpOOKXbW_nzzApQ@mail.gmail.com>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, Ola x Nilsson <olani@axis.com>
Subject: Re: [PULL] *** Fix build issue with html5lib in bitbake 1.26/1.28 ***
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
X-List-Received-Date: Fri, 30 Mar 2018 15:46:48 -0000
Content-Type: multipart/alternative; boundary="001a114271cee8556a0568a325a4"

--001a114271cee8556a0568a325a4
Content-Type: text/plain; charset="UTF-8"

Just saw that Richard Purdie backported Daniel Lublin's original commit to
1.26 and 1.28 (edd90cd858da5da564e9849ebc0849a8a8173d4f
<http://git.openembedded.org/bitbake/commit/?h=1.26&id=edd90cd858da5da564e9849ebc0849a8a8173d4f>
and 0d80cacb2b84ee059cee3caf8a5968033b9ce3c5
<http://git.openembedded.org/bitbake/commit/?h=1.28&id=0d80cacb2b84ee059cee3caf8a5968033b9ce3c5>).
I noticed it was pushed upstream to yocto-poky fido and jethro as well. I
did a fresh checkout of yocto-poky fido and jethro and got both to build
past that error out of the box. Thanks to Richard and Daniel and everyone
else!

On Thu, Mar 29, 2018 at 10:43 AM, Peter Kjellerstedt <
peter.kjellerstedt@axis.com> wrote:

> One way to create and send the patch is:
>
>
>
> git cherry-pick 1679188f9c55c615cae780f2b5e6852dea9cf2ec # Assuming you
> are in the bitbake repository, not poky
>
> git commit --amend  # To add your Signed-off-by footer
>
> git format-patch --subject-prefix='jethro][PATCH' 'HEAD^..HEAD'
>
> git send-email --to=openembedded-core@lists.openembedded.org
> --confirm=always --no-chain-reply-to --suppress-cc=all 000*
>
>
>
> //Peter
>
>
>
> *From:* bitbake-devel-bounces@lists.openembedded.org [mailto:
> bitbake-devel-bounces@lists.openembedded.org] *On Behalf Of *Soemoe Aung
> *Sent:* den 28 mars 2018 18:47
> *To:* Ola x Nilsson <Ola.x.Nilsson@axis.com>
> *Cc:* bitbake-devel@lists.openembedded.org
> *Subject:* Re: [bitbake-devel] [PULL] *** Fix build issue with html5lib
> in bitbake 1.26/1.28 ***
>
>
>
> Yes, that's essentially what I'm asking for. Sorry if that wasn't clear.
> That fix is in bitbake 1.30 but seems to be needed in 1.26 and 1.28 as
> well. My change literally took the html5lib file from 1.30 and copied it to
> the file in 1.26 and submitted it as a patch. Apologies if this was the
> wrong way to go about this.
>
>
>
> What are the steps to backport this change to 1.26 and 1.28 (and also to
> send these changes upstream to yocto-poky)? Is there anything I need to do?
>
>
>
> On Wed, Mar 28, 2018 at 2:41 AM, Ola x Nilsson <ola.x.nilsson@axis.com>
> wrote:
>
> This has already been fixed on a few branches with
>
> bitbake: lib/bs4: Fix imports from html5lib >= 0.9999999/1.0b8
>
> It might be better to backport that where needed.
>
> --
> Ola Nilsson
> ________________________________________
> From: bitbake-devel-bounces@lists.openembedded.org <
> bitbake-devel-bounces@lists.openembedded.org> on behalf of Soemoe Aung <
> soemoe.a@gmail.com>
> Sent: Tuesday, March 27, 2018 23:15
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PULL] *** Fix build issue with html5lib in
> bitbake    1.26/1.28 ***
>
>
> When I was running yocto-poky on the fido and jethro branches, I was
> getting build errors caused by the included html5lib in bitbake. It seems
> like a class is being called incorrectly there. I noticed the issue is
> resolved in the krogoth branch and the html5lib is indeed different there.
>
> yocto-poky fido includes bitbake version 1.26 and jethro includes bitbake
> version 1.28. Looking at the bitbake source repo for these versions
> confirms that these files are the same. yocto-poky krogoth, which has the
> issue fixed, uses bitbake 1.30, which also has the issue fixed in the
> bitbake repo.
>
> I originally created this patch in the yocto-poky contrib repo and was
> directed to send it to bitbake instead. Can someone here take a look at
> this and accept the changes into the 1.26 and 1.28 branches? Can you also
> send these changes upstream to the yocto-poky fido and jethro branches?
>
> Let me know if you need any changes here, like creating this patch from
> the bitbake repo directly instead of indirectly through yocto-poky.
>
> The following changes since commit ea6d21066a7cce2fef08ad66287170
> c5995bb1e2:
>
>   bitbake: bitbake-user-manual: Fixed porno hack for hello world example
> (2018-01-17 22:32:46 +0000)
>
> are available in the Git repository at:
>
>   git://push.yoctoproject.org/poky-contrib saung/bitbake-html5lib
>
> Soemoe Aung (2):
>   fix build error in included html5lib in bitbake
>   fix html5lib fix to be the same as in the krogoth branch
>
>  bitbake/lib/bs4/builder/_html5lib.py | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> --
> 2.17.0.rc0.231.g781580f067-goog
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>
>
>

--001a114271cee8556a0568a325a4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Just saw that Richard Purdie backported Daniel Lublin&#39;=
s original commit to 1.26 and 1.28 (<a href=3D"http://git.openembedded.org/=
bitbake/commit/?h=3D1.26&amp;id=3Dedd90cd858da5da564e9849ebc0849a8a8173d4f"=
 target=3D"_blank">edd90cd858da5da564e9849ebc084<wbr>9a8a8173d4f</a> and=C2=
=A0<a href=3D"http://git.openembedded.org/bitbake/commit/?h=3D1.28&amp;id=
=3D0d80cacb2b84ee059cee3caf8a5968033b9ce3c5" target=3D"_blank">0d80cacb2b84=
ee059cee3caf8a<wbr>5968033b9ce3c5</a>). I noticed it was pushed upstream to=
 yocto-poky fido and jethro as well. I did a fresh checkout of yocto-poky f=
ido and jethro and got both to build past that error out of the box. Thanks=
 to Richard and Daniel and everyone else!</div><div class=3D"gmail_extra"><=
br><div class=3D"gmail_quote">On Thu, Mar 29, 2018 at 10:43 AM, Peter Kjell=
erstedt <span dir=3D"ltr">&lt;<a href=3D"mailto:peter.kjellerstedt@axis.com=
" target=3D"_blank">peter.kjellerstedt@axis.com</a>&gt;</span> wrote:<br><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">





<div lang=3D"SV" link=3D"blue" vlink=3D"purple">
<div class=3D"m_-7694966196785305973WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#943634">One way=
 to create and send the patch is:<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#943634"><u></u>=
=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:Consolas;c=
olor:#943634">git cherry-pick 1679188f9c55c615cae780f2b5e685<wbr>2dea9cf2ec=
 # Assuming you are in the bitbake repository, not poky<u></u><u></u></span=
></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:Consolas;c=
olor:#943634">git commit --amend =C2=A0# To add your Signed-off-by footer<u=
></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:Consolas;c=
olor:#943634">git format-patch --subject-prefix=3D&#39;jethro][<wbr>PATCH&#=
39; &#39;HEAD^..HEAD&#39;<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:Consolas;c=
olor:#943634">git send-email --to=3D<a href=3D"mailto:openembedded-core@lis=
ts.openembedded.org" target=3D"_blank">openembedded-core@lists.<wbr>openemb=
edded.org</a> --confirm=3Dalways --no-chain-reply-to --suppress-cc=3Dall 00=
0*<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#943634"><u></u>=
=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#943634">//Peter=
<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#943634"><u></u>=
=C2=A0<u></u></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #e1e1e1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US">From:</span></b><span lang=
=3D"EN-US"> <a href=3D"mailto:bitbake-devel-bounces@lists.openembedded.org"=
 target=3D"_blank">bitbake-devel-bounces@lists.<wbr>openembedded.org</a> [m=
ailto:<a href=3D"mailto:bitbake-devel-bounces@lists.openembedded.org" targe=
t=3D"_blank">bitbake-devel-bounces@<wbr>lists.openembedded.org</a>]
<b>On Behalf Of </b>Soemoe Aung<br>
<b>Sent:</b> den 28 mars 2018 18:47<br>
<b>To:</b> Ola x Nilsson &lt;<a href=3D"mailto:Ola.x.Nilsson@axis.com" targ=
et=3D"_blank">Ola.x.Nilsson@axis.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=
=3D"_blank">bitbake-devel@lists.<wbr>openembedded.org</a><br>
<b>Subject:</b> Re: [bitbake-devel] [PULL] *** Fix build issue with html5li=
b in bitbake 1.26/1.28 ***<u></u><u></u></span></p>
</div>
</div><div><div class=3D"h5">
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<p class=3D"MsoNormal">Yes, that&#39;s essentially what I&#39;m asking for.=
 Sorry if that wasn&#39;t clear. That fix is in bitbake 1.30 but seems to b=
e needed in 1.26 and 1.28 as well. My change literally took the html5lib fi=
le from 1.30 and copied it to the file in 1.26
 and submitted it as a patch. Apologies if this was the wrong way to go abo=
ut this.<u></u><u></u></p>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">What are the steps to backport this change to 1.26 a=
nd 1.28 (and also to send these changes upstream to yocto-poky)? Is there a=
nything I need to do?<u></u><u></u></p>
</div>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<p class=3D"MsoNormal">On Wed, Mar 28, 2018 at 2:41 AM, Ola x Nilsson &lt;<=
a href=3D"mailto:ola.x.nilsson@axis.com" target=3D"_blank">ola.x.nilsson@ax=
is.com</a>&gt; wrote:<u></u><u></u></p>
<blockquote style=3D"border:none;border-left:solid #cccccc 1.0pt;padding:0c=
m 0cm 0cm 6.0pt;margin-left:4.8pt;margin-right:0cm">
<p class=3D"MsoNormal">This has already been fixed on a few branches with<b=
r>
<br>
bitbake: lib/bs4: Fix imports from html5lib &gt;=3D 0.9999999/1.0b8<br>
<br>
It might be better to backport that where needed.<br>
<br>
--<br>
Ola Nilsson<br>
______________________________<wbr>__________<br>
From: <a href=3D"mailto:bitbake-devel-bounces@lists.openembedded.org" targe=
t=3D"_blank">bitbake-devel-bounces@lists.<wbr>openembedded.org</a> &lt;<a h=
ref=3D"mailto:bitbake-devel-bounces@lists.openembedded.org" target=3D"_blan=
k">bitbake-devel-bounces@lists.<wbr>openembedded.org</a>&gt; on behalf of S=
oemoe Aung &lt;<a href=3D"mailto:soemoe.a@gmail.com" target=3D"_blank">soem=
oe.a@gmail.com</a>&gt;<br>
Sent: Tuesday, March 27, 2018 23:15<br>
To: <a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_blan=
k">bitbake-devel@lists.<wbr>openembedded.org</a><br>
Subject: [bitbake-devel] [PULL] *** Fix build issue with html5lib in bitbak=
e=C2=A0 =C2=A0 1.26/1.28 ***<u></u><u></u></p>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><br>
When I was running yocto-poky on the fido and jethro branches, I was gettin=
g build errors caused by the included html5lib in bitbake. It seems like a =
class is being called incorrectly there. I noticed the issue is resolved in=
 the krogoth branch and the html5lib
 is indeed different there.<br>
<br>
yocto-poky fido includes bitbake version 1.26 and jethro includes bitbake v=
ersion 1.28. Looking at the bitbake source repo for these versions confirms=
 that these files are the same. yocto-poky krogoth, which has the issue fix=
ed, uses bitbake 1.30, which also
 has the issue fixed in the bitbake repo.<br>
<br>
I originally created this patch in the yocto-poky contrib repo and was dire=
cted to send it to bitbake instead. Can someone here take a look at this an=
d accept the changes into the 1.26 and 1.28 branches? Can you also send the=
se changes upstream to the yocto-poky
 fido and jethro branches?<br>
<br>
Let me know if you need any changes here, like creating this patch from the=
 bitbake repo directly instead of indirectly through yocto-poky.<br>
<br>
The following changes since commit ea6d21066a7cce2fef08ad66287170<wbr>c5995=
bb1e2:<br>
<br>
=C2=A0 bitbake: bitbake-user-manual: Fixed porno hack for hello world examp=
le (2018-01-17 22:32:46 +0000)<br>
<br>
are available in the Git repository at:<br>
<br>
=C2=A0 git://<a href=3D"http://push.yoctoproject.org/poky-contrib" target=
=3D"_blank">push.yoctoproject.org/<wbr>poky-contrib</a> saung/bitbake-html5=
lib<br>
<br>
Soemoe Aung (2):<br>
=C2=A0 fix build error in included html5lib in bitbake<br>
=C2=A0 fix html5lib fix to be the same as in the krogoth branch<br>
<br>
=C2=A0bitbake/lib/bs4/builder/_<wbr>html5lib.py | 17 ++++++++++++-----<br>
=C2=A01 file changed, 12 insertions(+), 5 deletions(-)<br>
<br>
--<br>
2.17.0.rc0.231.g781580f067-<wbr>goog<u></u><u></u></p>
</div>
</div>
<p class=3D"MsoNormal">--<br>
______________________________<wbr>_________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_blank">b=
itbake-devel@lists.<wbr>openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" ta=
rget=3D"_blank">http://lists.openembedded.org/<wbr>mailman/listinfo/bitbake=
-devel</a><br>
<span class=3D"m_-7694966196785305973hoenzb"><span style=3D"color:#888888">=
--</span></span><span style=3D"color:#888888"><br>
<span class=3D"m_-7694966196785305973hoenzb">______________________________=
<wbr>_________________</span><br>
<span class=3D"m_-7694966196785305973hoenzb">bitbake-devel mailing list</sp=
an><br>
<span class=3D"m_-7694966196785305973hoenzb"><a href=3D"mailto:bitbake-deve=
l@lists.openembedded.org" target=3D"_blank">bitbake-devel@lists.<wbr>openem=
bedded.org</a></span><br>
<span class=3D"m_-7694966196785305973hoenzb"><a href=3D"http://lists.openem=
bedded.org/mailman/listinfo/bitbake-devel" target=3D"_blank">http://lists.o=
penembedded.org/<wbr>mailman/listinfo/bitbake-devel</a></span></span><u></u=
><u></u></p>
</blockquote>
</div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
</div></div></div>
</div>
</div>

</blockquote></div><br></div>

--001a114271cee8556a0568a325a4--
