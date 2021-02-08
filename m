Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
 by mx.groups.io with SMTP id smtpd.web10.3110.1612828495935477502
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Feb 2021 15:54:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZRDlREoR;
 spf=pass (domain: gmail.com, ip: 209.85.218.46, mailfrom: martin.jansa@gmail.com)
Received: by mail-ej1-f46.google.com with SMTP id p20so28492533ejb.6;
        Mon, 08 Feb 2021 15:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HnXXVPT2TA3uY+mdqfRn5YguOMM5H71OxLi0uWiDbhw=;
        b=ZRDlREoReHW88MLip1qSNqgblHhOj4WHsIEa+7L7210cPZpw8mn9O4LByYMvcpzdPc
         QOdrJbLSF5qL7PUqIBH7GBgeV2PAw08pSJd9spG99ubH2/kVAbhIllQwWP/CShh3SAuM
         VOPLE/afUHB4BTNZEB2Nb7UiNw23F38Wzz8MMS5WZD3hp6BSrKoiOsh15kMVIXIahFuE
         wwsaOYHW33Xqr2cKhGw0IiYZOKdhZvevowCY5VZVpgK3BZNXgWW5vhgs9UwTrLpJqpID
         rd/jmCFTAIjKZ9eggr/mitLuGLVhAa3mofBKJ/9Yea51EZcges1zkGSmQfhuWrJXWhkC
         R9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HnXXVPT2TA3uY+mdqfRn5YguOMM5H71OxLi0uWiDbhw=;
        b=JZGPzQU9Lv6vaBt4pU54nnNWOSBuYBi8DMajSIAKu6PGpM7to0b015uTFkWwQIPy7a
         4K3p+G9OgmQitWQaOVysUKSaJhzOilzRS1j8uhJZzbRfbukTANAUMRsGaNEg0u2WerQo
         BPUeTRYWhTViQLRTNmxYtbkVVHnJpHSmvaT/hlcIFz51PzxpIWgE9Xwz10mR6I8dyCng
         Ttdbd3IL+iPT1R+oaqdEDYBq7DWWyPRIjDGZwQAygQucNXu/XZ4twC53mDMh++NwGSPi
         O18sGSmSHy7iygkGdnzqFrTuJfDVxOi+nnpyKnZG1GN0tWhxmN8giIM16ShD0BnNyRtk
         z2Dg==
X-Gm-Message-State: AOAM533wYaUYAFHXxk/YIT1kLSTnMACMEk+F2jjUP5vyYW+48r1+gs8q
	C1bvYKb2dw237PUwe24AqcaMTdd6zOFmsYZ9+9E=
X-Google-Smtp-Source: ABdhPJxP6LSpr5URhM00hKNLqDD+54QcPLdL/KqeLlzgD8/V+W04ri15lOZ6uWWbFWS63vMRUtJf5mCAbCJvGjIqtw4=
X-Received: by 2002:a17:906:da0b:: with SMTP id fi11mr19867483ejb.392.1612828494329;
 Mon, 08 Feb 2021 15:54:54 -0800 (PST)
MIME-Version: 1.0
References: <17b543581ffb421b812323891405dcfb@XBOX03.axis.com>
 <CA+chaQc0anOg2E=o1ouEca-QJDGqKxDoXm6aPVXzsc8TELW3zA@mail.gmail.com>
 <d9185d19-1f09-a1b6-2926-f54309190b24@gmail.com> <16614BA6A53B3779.25597@lists.openembedded.org>
 <CA+chaQdbZwyBTbyctEh_y8x_p=txiwqy8gjmkwDrh6rqX_ztng@mail.gmail.com> <f190d3e175a9413994caf1c73a9f9125@XBOX03.axis.com>
In-Reply-To: <f190d3e175a9413994caf1c73a9f9125@XBOX03.axis.com>
From: "Martin Jansa" <Martin.Jansa@gmail.com>
Date: Tue, 9 Feb 2021 00:54:43 +0100
Message-ID: <CA+chaQcneQg2M7obLb-ucgGu95a8muoXDkeKa8W3iDrts1F5QA@mail.gmail.com>
Subject: Re: [oe] [bitbake-devel] Backport changes for _PYTHON_SYSCONFIGDATA_NAME to Gatesgarth and Dunfell
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Cc: akuster808 <akuster808@gmail.com>, Steve Sakoman <steve@sakoman.com>, 
	"Mittal, Anuj" <anuj.mittal@intel.com>, 
	"OE Core (openembedded-core@lists.openembedded.org)" <openembedded-core@lists.openembedded.org>, 
	"OE Development (openembedded-devel@lists.openembedded.org)" <openembedded-devel@lists.openembedded.org>, 
	"BitBake Development (bitbake-devel@lists.openembedded.org)" <bitbake-devel@lists.openembedded.org>, 
	Bruce Ashfield <bruce.ashfield@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000007cf9e105badbe501"

--0000000000007cf9e105badbe501
Content-Type: text/plain; charset="UTF-8"

Hi,

I believe I have the same set of patches in jansa/dunfell and
jansa/gatesgarth branchesand bitbake world passed OK with them (with my set
of layers).

The only new issue I see in dunfell is libvirt from meta-virtualization
failing, because it uses hosts gcc to build python module, from quick look
I guess it shouldn't be using host's gcc and instead it should inherit
python3targetconfig or something to keep the old behavior. In the
meta-virtualization master branch there is this patch:
https://git.yoctoproject.org/cgit/cgit.cgi/meta-virtualization/commit/?id=08b5de42f9216a10bb2f83263b7e6789686b4c3d
which works for dunfell, but before backporting it I will double check if
this is really caused by these changes.

Cheers,

On Tue, Feb 9, 2021 at 12:45 AM Peter Kjellerstedt <
peter.kjellerstedt@axis.com> wrote:

> As agreed upon on the Yocto Project Technical Team Meeting a week ago, I
> have created branches for both Gatesgarth and Dunfell in
> openembedded-core-contrib and meta-openembedded-contrib with the required
> patches. The branches are called pkj/_PYTHON_SYSCONFIGDATA_NAME-gatesgarth
> and pkj/_PYTHON_SYSCONFIGDATA_NAME-dunfell (ok, horrible names, but they
> should be easy to spot). There is one additional patch for bitbake, but I
> forgot to ask for access to bitbake-contrib, so you will have to
> cherry-pick it from commit 47b64cfa (it is not strictly necessary as it is
> just clean up made possible after the changes in OE-Core).
>
>
>
> @jansa, @akuster: I have included the two extra patches in
> meta-openembedded that Martin mentioned, which were lacking from my
> original mail. There were other patches mentioned, which fixed missing
> spaces related to the use of _append. However, as they were not necessary
> (they changed other variables than DEPENDS for target), I did not include
> them.
>
>
>
> I have not done any excessive testing of these branches. I have verified
> that I can run `devtool modify libxml2`, which I could not do before, and I
> have run `bitbake core-image-minimal`.
>
>
>
> //Peter
>
>
>
> *From:* Martin Jansa <martin.jansa@gmail.com>
> *Sent:* den 7 februari 2021 12:15
> *To:* Martin Jansa <Martin.Jansa@gmail.com>
> *Cc:* akuster808 <akuster808@gmail.com>; Peter Kjellerstedt <
> peter.kjellerstedt@axis.com>; Steve Sakoman <steve@sakoman.com>; Mittal,
> Anuj <anuj.mittal@intel.com>; OE Core (
> openembedded-core@lists.openembedded.org) <
> openembedded-core@lists.openembedded.org>; OE Development (
> openembedded-devel@lists.openembedded.org) <
> openembedded-devel@lists.openembedded.org>; BitBake Development (
> bitbake-devel@lists.openembedded.org) <
> bitbake-devel@lists.openembedded.org>
> *Subject:* Re: [oe] [bitbake-devel] Backport changes for
> _PYTHON_SYSCONFIGDATA_NAME to Gatesgarth and Dunfell
>
>
>
> On Sun, Feb 7, 2021 at 12:15 AM Martin Jansa via lists.openembedded.org
> <Martin.Jansa=gmail.com@lists.openembedded.org> wrote:
>
> On Sat, Jan 16, 2021 at 6:52 PM akuster808 <akuster808@gmail.com> wrote:
>
>
>
> On 1/16/21 9:44 AM, Martin Jansa wrote:
> > Aren't the missing spaces in appends fixes also needed for meta-oe
> > recipes?
>
>
> >
> > I think at least top 5 commits from:
> >
> https://git.openembedded.org/meta-openembedded/log/?qt=grep&q=space.*append
> > were also follow-up from these changes in oe-core.
> >
> Do you mean something beyond the meta-openembedded commits mentioned
> near the bottom of the email?
>
>
>
> Yes I mean these 5 commits at least.
>
>
>
> 50bbf80abf python3-pykwalify: Do not unset _PYTHON_SYSCONFIGDATA_NAME
>
> 6b3e3bdaf8 python-grpcio-tools: Add missing space for append
>
>
>
> The first one is just an additional cleanup, but without the 2nd one and
> with the cherry-picks from the first e-mail applied you would get:
>
> ERROR: Nothing PROVIDES 'python3python3-grpcio' (but
> meta-oe/meta-python/recipes-devtools/python/python3-grpcio-tools_1.14.1.bb
> DEPENDS on or otherwise requires it). Close matches:
>   python-grpcio
>   python3-grpcio
>
>
>
> my world build is still running..
>
>
>
>
>
> with c99bb790 DEPENDS variable doesn't end with a space, so the missing
> leading space in these appends (which was fine until now because of
> trailing space from DEPENDS set in bbclass) is now causing wrong dependency
> (should be easily reproducible with the patches backported, just by parsing
> the recipes).
>
>
>
> I need clarity so I can open an issue in gitlab for tracking purposes as
> I am sure I will forget this
>
>
>
> we're using gitlab?
>
>
> 
>
>

--0000000000007cf9e105badbe501
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I believe I have the same set of pa=
tches in jansa/dunfell and jansa/gatesgarth branchesand bitbake world passe=
d OK with them (with my set of layers).</div><div><br></div><div>The only n=
ew issue I see in dunfell is libvirt from meta-virtualization failing, beca=
use it uses hosts gcc to build python module, from quick look I guess it sh=
ouldn&#39;t be using host&#39;s gcc and instead it should inherit python3ta=
rgetconfig or something to keep the old behavior. In the meta-virtualizatio=
n master branch there is this patch:</div><div><a href=3D"https://git.yocto=
project.org/cgit/cgit.cgi/meta-virtualization/commit/?id=3D08b5de42f9216a10=
bb2f83263b7e6789686b4c3d">https://git.yoctoproject.org/cgit/cgit.cgi/meta-v=
irtualization/commit/?id=3D08b5de42f9216a10bb2f83263b7e6789686b4c3d</a><br>=
</div><div>which works for dunfell, but before backporting it I will double=
 check if this is really caused by these changes.</div><div><br></div><div>=
Cheers,</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">On Tue, Feb 9, 2021 at 12:45 AM Peter Kjellerstedt &lt;<a href=
=
=3D"mailto:peter.kjellerstedt@axis.com">peter.kjellerstedt@axis.com</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">





<div lang=3D"SV">
<div class=3D"gmail-m_608887548665860737WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:rgb(148,54,52)"=
>As agreed upon on the Yocto Project Technical Team Meeting a week ago, I h=
ave created branches for both Gatesgarth and Dunfell in openembedded-core-c=
ontrib and meta-openembedded-contrib
 with the required patches. The branches are called pkj/_PYTHON_SYSCONFIGD=
ATA_NAME-gatesgarth and pkj/_PYTHON_SYSCONFIGDATA_NAME-dunfell (ok, horribl=
e names, but they should be easy to spot). There is one additional patch fo=
r bitbake, but I forgot to ask for
 access to bitbake-contrib, so you will have to cherry-pick it from commit=
 47b64cfa (it is not strictly necessary as it is just clean up made possibl=
e after the changes in OE-Core).<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:rgb(148,54,52)"=
><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:rgb(148,54,52)"=
>@jansa, @akuster: I have included the two extra patches in meta-openembedd=
ed that Martin mentioned, which were lacking from my original mail. There w=
ere other patches mentioned,
 which fixed missing spaces related to the use of _append. However, as the=
y were not necessary (they changed other variables than DEPENDS for target)=
, I did not include them.
<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:rgb(148,54,52)"=
><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:rgb(148,54,52)"=
>I have not done any excessive testing of these branches. I have verified t=
hat I can run `devtool modify libxml2`, which I could not do before, and I =
have run `bitbake core-image-minimal`.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:rgb(148,54,52)"=
><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:rgb(148,54,52)"=
>//Peter<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:rgb(148,54,52)"=
><u></u>=C2=A0<u></u></span></p>
<div style=3D"border-top:none;border-right:none;border-bottom:none;border-=
left:1.5pt solid blue;padding:0cm 0cm 0cm 4pt">
<div>
<div style=3D"border-right:none;border-bottom:none;border-left:none;border=
-top:1pt solid rgb(225,225,225);padding:3pt 0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US">From:</span></b><span lang=
=3D"EN-US"> Martin Jansa &lt;<a href=3D"mailto:martin.jansa@gmail.com" tar=
get=3D"_blank">martin.jansa@gmail.com</a>&gt;
<br>
<b>Sent:</b> den 7 februari 2021 12:15<br>
<b>To:</b> Martin Jansa &lt;<a href=3D"mailto:Martin.Jansa@gmail.com" targ=
et=3D"_blank">Martin.Jansa@gmail.com</a>&gt;<br>
<b>Cc:</b> akuster808 &lt;<a href=3D"mailto:akuster808@gmail.com" target=
=3D"_blank">akuster808@gmail.com</a>&gt;; Peter Kjellerstedt &lt;<a href=
=3D"mailto:peter.kjellerstedt@axis.com" target=3D"_blank">peter.kjellerste=
dt@axis.com</a>&gt;; Steve Sakoman &lt;<a href=3D"mailto:steve@sakoman.com"=
 target=3D"_blank">steve@sakoman.com</a>&gt;; Mittal, Anuj &lt;<a href=3D"m=
ailto:anuj.mittal@intel.com" target=3D"_blank">anuj.mittal@intel.com</a>&gt=
;; OE Core (<a href=3D"mailto:openembedded-core@lists.openembedded.org" tar=
get=3D"_blank">openembedded-core@lists.openembedded.org</a>) &lt;<a href=3D=
"mailto:openembedded-core@lists.openembedded.org" target=3D"_blank">openemb=
edded-core@lists.openembedded.org</a>&gt;;
 OE Development (<a href=3D"mailto:openembedded-devel@lists.openembedded.o=
rg" target=3D"_blank">openembedded-devel@lists.openembedded.org</a>) &lt;<a=
 href=3D"mailto:openembedded-devel@lists.openembedded.org" target=3D"_blank=
">openembedded-devel@lists.openembedded.org</a>&gt;; BitBake Development (<=
a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_blank">bi=
tbake-devel@lists.openembedded.org</a>) &lt;<a href=3D"mailto:bitbake-devel=
@lists.openembedded.org" target=3D"_blank">bitbake-devel@lists.openembedded=
.org</a>&gt;<br>
<b>Subject:</b> Re: [oe] [bitbake-devel] Backport changes for _PYTHON_SYSC=
ONFIGDATA_NAME to Gatesgarth and Dunfell<u></u><u></u></span></p>
</div>
</div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<div>
<p class=3D"MsoNormal">On Sun, Feb 7, 2021 at 12:15 AM Martin Jansa via <a=
 href=3D"http://lists.openembedded.org" target=3D"_blank">
lists.openembedded.org</a> &lt;Martin.Jansa=3D<a href=3D"mailto:gmail.com@=
lists.openembedded.org" target=3D"_blank">gmail.com@lists.openembedded.org<=
/a>&gt; wrote:<u></u><u></u></p>
</div>
<div>
<blockquote style=3D"border-top:none;border-right:none;border-bottom:none;=
border-left:1pt solid rgb(204,204,204);padding:0cm 0cm 0cm 6pt;margin-left:=
4.8pt;margin-right:0cm">
<div>
<div>
<p class=3D"MsoNormal">On Sat, Jan 16, 2021 at 6:52 PM akuster808 &lt;<a h=
ref=3D"mailto:akuster808@gmail.com" target=3D"_blank">akuster808@gmail.com<=
/a>&gt; wrote:<u></u><u></u></p>
</div>
<div>
<blockquote style=3D"border-top:none;border-right:none;border-bottom:none;=
border-left:1pt solid rgb(204,204,204);padding:0cm 0cm 0cm 6pt;margin-left:=
4.8pt;margin-right:0cm">
<p class=3D"MsoNormal"><br>
<br>
On 1/16/21 9:44 AM, Martin Jansa wrote:<br>
&gt; Aren&#39;t the missing spaces in appends fixes also needed for meta-o=
e<br>
&gt; recipes?<br>
<br>
<br>
&gt;<br>
&gt; I think at least top 5 commits from:<br>
&gt; <a href=3D"https://git.openembedded.org/meta-openembedded/log/?qt=3Dg=
rep&amp;q=3Dspace.*append" target=3D"_blank">
https://git.openembedded.org/meta-openembedded/log/?qt=3Dgrep&amp;q=3Dspac=
e.*append</a><br>
&gt; were also follow-up from these changes in oe-core.<br>
&gt;<br>
Do you mean something beyond the meta-openembedded commits mentioned<br>
near the bottom of the email?<u></u><u></u></p>
</blockquote>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Yes I mean these 5 commits at least.<u></u><u></u><=
/p>
</div>
</div>
</div>
</blockquote>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">50bbf80abf python3-pykwalify: Do not unset _PYTHON_=
SYSCONFIGDATA_NAME<u></u><u></u></p>
</div>
<p class=3D"MsoNormal">6b3e3bdaf8 python-grpcio-tools: Add missing space f=
or append<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">The first one is just an additional cleanup, but wi=
thout the 2nd one and with the cherry-picks from the first e-mail applied y=
ou would get:<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">ERROR: Nothing PROVIDES &#39;python3python3-grpcio&=
#39; (but meta-oe/meta-python/recipes-devtools/python/<a href=3D"http://pyt=
hon3-grpcio-tools_1.14.1.bb" target=3D"_blank">python3-grpcio-tools_1.14.1.=
bb</a> DEPENDS on or otherwise requires it). Close matches:<br>
=C2=A0 python-grpcio<br>
=C2=A0 python3-grpcio<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">my world build is still running..<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<blockquote style=3D"border-top:none;border-right:none;border-bottom:none;=
border-left:1pt solid rgb(204,204,204);padding:0cm 0cm 0cm 6pt;margin-left:=
4.8pt;margin-right:0cm">
<div>
<div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">with c99bb790 DEPENDS variable doesn&#39;t end with=
 a space, so the missing leading space in these appends (which was fine unt=
il now because of trailing space from DEPENDS set in bbclass) is now causin=
g wrong dependency (should be easily reproducible
 with the patches backported, just by parsing the recipes).<u></u><u></u><=
/p>
</div>
<div>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
</div>
<blockquote style=3D"border-top:none;border-right:none;border-bottom:none;=
border-left:1pt solid rgb(204,204,204);padding:0cm 0cm 0cm 6pt;margin-left:=
4.8pt;margin-right:0cm">
<p class=3D"MsoNormal">I need clarity so I can open an issue in gitlab for=
 tracking purposes as<br>
I am sure I will forget this<u></u><u></u></p>
</blockquote>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">we&#39;re using gitlab?=C2=A0<u></u><u></u></p>
</div>
</div>
</div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12pt"><br>
<u></u><u></u></p>
</blockquote>
</div>
</div>
</div>
</div>
</div>

</blockquote></div>

--0000000000007cf9e105badbe501--
