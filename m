Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
 by mx.groups.io with SMTP id smtpd.web09.18816.1612696502231739660
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 07 Feb 2021 03:15:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=JeMrGmHP;
 spf=pass (domain: gmail.com, ip: 209.85.208.48, mailfrom: martin.jansa@gmail.com)
Received: by mail-ed1-f48.google.com with SMTP id t5so14737036eds.12;
        Sun, 07 Feb 2021 03:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U2oriLcbV8tzcafj4UFImGXtGK2gT9xn52hJtjOBLog=;
        b=JeMrGmHPY2ln2uqKTR5G3ysJTm+FvnCu02q9DDWFrk4bhHwNje+ndIi7akayf/DpPX
         8UMTk8ELxpvx0R74ep1Cb1bM1cyJARb9YdTcB9sChWp1oz3T6nXGG/jwJ0OebW9q12PU
         hErqInBS9H5cTtrnoC5w9rIUBsaDnOitRyNrAEeGS/Asfo1MLDflz0Q+vRBRcMsORRiW
         SFGNnRGKa7INyw9xXmfPJXqait3bqnErpDyZg65qG5wbXf2CVamLyBSe4Eehp0tdaA4D
         yvqGW4yq+eFQvmsM/AqP2+K4UuApY+ykQE2warcjUlKgSxpvzP3I2pqoqLizCqfDRjP8
         rm7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U2oriLcbV8tzcafj4UFImGXtGK2gT9xn52hJtjOBLog=;
        b=Dac0DygZkuOTaw6+8LEEwR49w3MaECoREYcpr34iKD1rTrX3m9pRLq7CLxd+P/O3mF
         pa4KPDPPyIGyfIdonT3C6peoQDWKDWz/5WbGXiycqGj6yH5NCislRAk04CUW4GsjSv8r
         0xQ4LREzSl+lHTpLSh4pP6sOUnxzbfDAlycnl0Sl1VNQ+WJuteN2yarmGaw3fhXPXi/t
         PxBnC1LtATRfb3kUfhZKHETu9LwNwkfDy1YGLub5Er6htjw/e1ctDzTbV2SyXrHWtpnL
         LAvxvO8/BIzXEhrD3ANE3tT8GpEjzkJbVpRO9CB02OoKqGfr8HPw3+L6wK/va+WvcjGA
         ideQ==
X-Gm-Message-State: AOAM531LDzhCvnfksaTQErjNpVdMohciQEplDYdAy3WwdWNCuQGq+w3P
	HzJ2LqOv4Z/AXdStVuehpAeAljcNLAYZwpcOdqo=
X-Google-Smtp-Source: ABdhPJz8bVvgDF+eqEWMyW0lOAj7UtJHg+zQ8E0GdNDOOrpbEc7YVyqWiZoDB/+zkIs4XKbumIC/K6RxyHfTsEe+ewE=
X-Received: by 2002:a05:6402:5193:: with SMTP id q19mr12238517edd.264.1612696500575;
 Sun, 07 Feb 2021 03:15:00 -0800 (PST)
MIME-Version: 1.0
References: <17b543581ffb421b812323891405dcfb@XBOX03.axis.com>
 <CA+chaQc0anOg2E=o1ouEca-QJDGqKxDoXm6aPVXzsc8TELW3zA@mail.gmail.com>
 <d9185d19-1f09-a1b6-2926-f54309190b24@gmail.com> <16614BA6A53B3779.25597@lists.openembedded.org>
In-Reply-To: <16614BA6A53B3779.25597@lists.openembedded.org>
From: "Martin Jansa" <Martin.Jansa@gmail.com>
Date: Sun, 7 Feb 2021 12:14:49 +0100
Message-ID: <CA+chaQdbZwyBTbyctEh_y8x_p=txiwqy8gjmkwDrh6rqX_ztng@mail.gmail.com>
Subject: Re: [oe] [bitbake-devel] Backport changes for _PYTHON_SYSCONFIGDATA_NAME to Gatesgarth and Dunfell
To: Martin Jansa <Martin.Jansa@gmail.com>
Cc: akuster808 <akuster808@gmail.com>, Peter Kjellerstedt <peter.kjellerstedt@axis.com>, 
	Steve Sakoman <steve@sakoman.com>, "Mittal, Anuj" <anuj.mittal@intel.com>, 
	"OE Core (openembedded-core@lists.openembedded.org)" <openembedded-core@lists.openembedded.org>, 
	"OE Development (openembedded-devel@lists.openembedded.org)" <openembedded-devel@lists.openembedded.org>, 
	"BitBake Development (bitbake-devel@lists.openembedded.org)" <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="0000000000000c233605babd2af0"

--0000000000000c233605babd2af0
Content-Type: text/plain; charset="UTF-8"

On Sun, Feb 7, 2021 at 12:15 AM Martin Jansa via lists.openembedded.org
<Martin.Jansa=gmail.com@lists.openembedded.org> wrote:

> On Sat, Jan 16, 2021 at 6:52 PM akuster808 <akuster808@gmail.com> wrote:
>
>>
>>
>> On 1/16/21 9:44 AM, Martin Jansa wrote:
>> > Aren't the missing spaces in appends fixes also needed for meta-oe
>> > recipes?
>>
>>
>> >
>> > I think at least top 5 commits from:
>> >
>> https://git.openembedded.org/meta-openembedded/log/?qt=grep&q=space.*append
>> > were also follow-up from these changes in oe-core.
>> >
>> Do you mean something beyond the meta-openembedded commits mentioned
>> near the bottom of the email?
>>
>
> Yes I mean these 5 commits at least.
>

50bbf80abf python3-pykwalify: Do not unset _PYTHON_SYSCONFIGDATA_NAME
6b3e3bdaf8 python-grpcio-tools: Add missing space for append

The first one is just an additional cleanup, but without the 2nd one and
with the cherry-picks from the first e-mail applied you would get:
ERROR: Nothing PROVIDES 'python3python3-grpcio' (but
meta-oe/meta-python/recipes-devtools/python/python3-grpcio-tools_1.14.1.bb
DEPENDS on or otherwise requires it). Close matches:
  python-grpcio
  python3-grpcio

my world build is still running..


> with c99bb790 DEPENDS variable doesn't end with a space, so the missing
> leading space in these appends (which was fine until now because of
> trailing space from DEPENDS set in bbclass) is now causing wrong dependency
> (should be easily reproducible with the patches backported, just by parsing
> the recipes).
>
>
>> I need clarity so I can open an issue in gitlab for tracking purposes as
>> I am sure I will forget this
>>
>
> we're using gitlab?
>
> 
>
>

--0000000000000c233605babd2af0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Sun, Feb 7, 2021 at 12:15 AM Martin Ja=
nsa via <a href=3D"http://lists.openembedded.org">lists.openembedded.org</a=
> &lt;Martin.Jansa=3D<a href=3D"mailto:gmail.com@lists.openembedded.org">gm=
ail.com@lists.openembedded.org</a>&gt; wrote:<br></div><div class=3D"gmail_=
quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><=
div dir=3D"ltr">On Sat, Jan 16, 2021 at 6:52 PM akuster808 &lt;<a href=3D"m=
ailto:akuster808@gmail.com" target=3D"_blank">akuster808@gmail.com</a>&gt; =
wrote:<br></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex"><br>
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
rep&amp;q=3Dspace.*append" rel=3D"noreferrer" target=3D"_blank">https://git=
.openembedded.org/meta-openembedded/log/?qt=3Dgrep&amp;q=3Dspace.*append</a=
><br>
&gt; were also follow-up from these changes in oe-core.<br>
&gt;<br>
Do you mean something beyond the meta-openembedded commits mentioned<br>
near the bottom of the email?<br></blockquote><div><br></div><div>Yes I me=
an these 5 commits at least.</div></div></div></blockquote><div><br></div><=
div>50bbf80abf python3-pykwalify: Do not unset _PYTHON_SYSCONFIGDATA_NAME</=
div>6b3e3bdaf8 python-grpcio-tools: Add missing space for append</div><div =
class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">The first one is=
 just an additional cleanup, but without the 2nd one and with the cherry-pi=
cks from the first e-mail applied you would get:</div><div class=3D"gmail_q=
uote">ERROR: Nothing PROVIDES &#39;python3python3-grpcio&#39; (but meta-oe/=
meta-python/recipes-devtools/python/<a href=3D"http://python3-grpcio-tools_=
1.14.1.bb">python3-grpcio-tools_1.14.1.bb</a> DEPENDS on or otherwise requi=
res it). Close matches:<br>=C2=A0 python-grpcio<br>=C2=A0 python3-grpcio<br=
></div><div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">my w=
orld build is still running..</div><div class=3D"gmail_quote"><br><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gma=
il_quote"><div><br></div><div>with c99bb790 DEPENDS variable doesn&#39;t en=
d with a space, so the missing leading space in these appends (which was fi=
ne until now because of trailing space from DEPENDS set in bbclass) is now =
causing wrong dependency (should be easily reproducible with the patches ba=
ckported, just by parsing the recipes).</div><div>=C2=A0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
I need clarity so I can open an issue in gitlab for tracking purposes as<b=
r>
I am sure I will forget this<br></blockquote><div><br></div><div>we&#39;re=
 using gitlab?=C2=A0</div></div></div>
<br>
<br>
<br>
</blockquote></div></div>

--0000000000000c233605babd2af0--
