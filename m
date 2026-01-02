Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7393AFA3738
	for <webhook@archiver.kernel.org>; Fri,  2 Jan 2026 11:54:48 +0000 (UTC)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3835.1767354884473889883
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Jan 2026 03:54:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=lt63RwrH;
 spf=pass (domain: gmail.com, ip: 209.85.219.43, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-88a37cb5afdso157091036d6.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 02 Jan 2026 03:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767354883; x=1767959683; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ej6YsVDGPrJgnvHyGv/o9bMwArcvyrbbpY/bovHJXCM=;
        b=lt63RwrHSJvf5JBJHYIzUcaO+3wb8i2FuHNBnKMvgaeGovhuvqvZ88j5Dpi7lIcq77
         EEXrfqbrlUXathbYOn4hJ/OixSuLbl3z94NEg46YA0dSokA6xlRki+YsKfEvbrcd4j6L
         +Yz2Y33jFXMMV0zCw42wof21iNcvLk8UZCGOkbMZS4UycBCPSJ2HnKBmC75O/PTlnvlJ
         v/NuWKzAA/VD48QxAaOvnQR0jNty5cR+iSor0x7GagAjkqHkexUSFMUZQ8F2Uk2uOWB/
         +mSjNX6WjJX3XsgqITZitgh7s8SB7d3UZ/CL2xS/dR2hHErzkzc+SJqi7afV5Gvp6Bbg
         XycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767354883; x=1767959683;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ej6YsVDGPrJgnvHyGv/o9bMwArcvyrbbpY/bovHJXCM=;
        b=uEKTssvTHFAvzkSOPP+DWACiqdQwUyRiM/l4xWBD1R/SYAc7J3xy0q3IlGibD2gtxK
         BqOxoBo2imskDjWd4mr0uCagoYBuLiFOoIGKK0cqLjXMNizolC95GzH/qP9pzXvUxRRZ
         Gw04iKmrTC7bSYKRvedLyZNczUjXYeMlNHUDpts2hMh454X016RkPyO839U6AuMiYfRD
         emI+W9v6BPNwimDu/MF0YaS6xWC3n/x6Xv7NGVLqb6f7W53bnVfHkbQY6dY5uE6br2uR
         jz+s77P7Qimat7t4ROFumYB71HLbeZE1H3yH7YqFgp25mDYptB6Pm7IF1fE5kpMLV92T
         VDnA==
X-Gm-Message-State: AOJu0YyFO4rcCWogoYiLv5ACu4iJDDJlK1OsMGP55JUnm2RwM2C8wrW3
	Wv/za6NDp7o1KoNqZ/IdiatK/qyvac1WIzA5IYjQrHvXVhrG+5DzrRtJQTB0HuZj1Hx/b+dkOOB
	UiXHEn5Cg5bAI7b9YIT/ldIW2erF7oIU=
X-Gm-Gg: AY/fxX76ZuHTm8S8/jsrkr/1HrSzbNVEQxLvu3V9P2iWqdmaqjwB8Sc9J52cU8cT4Tl
	nBB2vTALF8zLRqq63bhevhFhJ64XDesIQDiHDPML5futAxFHKIShlCo13Wwpnmz4R0UIBWkkbcV
	zfbXeKbYhhXJtqPm6ZAquIMkW/CZQKakC/UrDsjvCi4DeIniwmTKVLtn3m2PI7KwOXtE1dQLyo9
	wmV3ynFNNVVv7u0FthPxDYSomifHwJ2kgNFEtIcJz7D/3XbX5x+/ec9sT8YdPwA71HQXE+ZqSDr
	WyzsB+yH6RIF3aauDo8KNrDwvYdTGA==
X-Google-Smtp-Source: AGHT+IGnEQzDtDaRT/eDoRN27fjvUllEbdmosROX4MAMTFQ8oZk+Xi2ClH4G32GFqdRrtTr6YCmvqdn2Dnlj4aQ1J04=
X-Received: by 2002:a0c:cd91:0:b0:88f:ce0b:a008 with SMTP id
 6a1803df08f44-88fce0ba2dbmr427898146d6.3.1767354883422; Fri, 02 Jan 2026
 03:54:43 -0800 (PST)
MIME-Version: 1.0
References: <20251230235724epcms1p84d784e88ac7f220b8e1e5a6ee09e83a9@epcms1p8>
 <CGME20251230234958epcms1p5f6e7ba1c00c63d05a1b71fcdbcb7a18a@epcms1p2>
 <CANNYZj_8kRAM0rFdtFyXbfR=NWhBE7RnwRObWesT945tNW_RMg@mail.gmail.com> <20251231152535epcms1p259b6e8d7eb72f7c1416edeffdb3b57e4@epcms1p2>
In-Reply-To: <20251231152535epcms1p259b6e8d7eb72f7c1416edeffdb3b57e4@epcms1p2>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 2 Jan 2026 12:54:32 +0100
X-Gm-Features: AQt7F2r69hIUFWX1GwmNthbHpeve2j0WdO7D6tp9NzQIyNWExjdaZYpGeU08lys
Message-ID: <CANNYZj80xgLiqcTrxicomF11pwtmA3VSKErYTX4WRNvw_D35yw@mail.gmail.com>
Subject: Re: (2) [bitbake-devel] [PATCH] Enhance shell_trap_code to support
 custom shebang
To: sangmin5.lee@samsung.com
Cc: "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="00000000000004bc47064766607f"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 02 Jan 2026 11:54:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18670

--00000000000004bc47064766607f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 31 Dec 2025 at 16:25, =EC=9D=B4=EC=83=81=EB=AF=BC <sangmin5.lee@sam=
sung.com> wrote:

>
> The main reason for this is to handle "Bashisms" in recipes that we can't
> easily refactor.
>
> In our case, we're collaborating with partners who provide recipes that
> rely on Bash-specific features (like arrays or [[ ]]).
>
> Currently, even if we set SHELL =3D "/bin/bash" in the config, BitBake's
> still forces #!/bin/sh.
>
> This causes tasks to fail on systems where points to dash (like Ubuntu),
> giving us errors like Syntax error: "(" unexpected. shell_trap_code/bin/s=
h
>

Thanks for the explanation. I have two concerns:
- it's a global setting that changes behavior for every shell task (bash
behaves differently depending on whether it's called as /bin/sh or
/bin/bash). So you'll get potentially different build outcomes, and
confusing failures that some people see and other people do not.
- it will de facto impose a bash requirement on the whole yocto build when
a layer that needs the setting is added to that build. Layers should not
impose things like this, and their 'special needs' should be contained.

Bash execution should be enabled per-function, when that function is known
to need bash.

Note that there's also scripts/verify-bashisms in oe-core/poky, which was
written specifically to catch bash-isms in layers. You could ask your
suppliers to run their code through it before it's submitted.


>
> Example:
>
> do_install() {
>     local libs=3D("liba.so" "libb.so") # Fails with "Syntax error: "("
> unexpected" on dash
> for l in "${libs[@]}"; do
> install -m 0755 $l ${D}${libdir}
>     done
> }
>

I think this can be fixed without too much difficulty? Instead of running
the code directly, do something like:

cat << END > install.sh
... (code above)
END
bash install.sh


Alex

>

--00000000000004bc47064766607f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Wed, 31 Dec 2025 at 16:25, =EC=9D=B4=EC=83=
=81=EB=AF=BC &lt;<a href=3D"mailto:sangmin5.lee@samsung.com">sangmin5.lee@s=
amsung.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><div class=3D"msg-8211689720461595998"><u></u>





<div><br><p style=3D"box-sizing:content-box;font-family:Gulim,=EA=B5=B4=EB=
=A6=BC,sans-serif;color:rgb(0,0,0);font-size:10.5pt;vertical-align:top;disp=
lay:block;font-weight:400;margin:0px;padding:0px;background-color:rgb(255,2=
55,255);background-image:none;background-position:0% 0%;background-repeat:r=
epeat"><span>The main reason for this is to handle &quot;Bashisms&quot; in =
recipes that we can&#39;t easily refactor.=C2=A0</span></p>
<p style=3D"box-sizing:content-box;font-family:Gulim,=EA=B5=B4=EB=A6=BC,san=
s-serif;color:rgb(0,0,0);font-size:10.5pt;vertical-align:top;display:block;=
font-weight:400;margin:0px;padding:0px;background-color:rgb(255,255,255);ba=
ckground-image:none;background-position:0% 0%;background-repeat:repeat"><sp=
an>In our case, we&#39;re collaborating with partners who provide recipes t=
hat rely on Bash-specific features (like arrays or</span><span>=C2=A0</span=
><span style=3D"font-size:10.5pt">[[ ]]</span><span>).</span></p>
<p style=3D"box-sizing:content-box;font-family:Gulim,=EA=B5=B4=EB=A6=BC,san=
s-serif;color:rgb(0,0,0);font-size:10.5pt;vertical-align:top;display:block;=
font-weight:400;margin:0px;padding:0px;background-color:rgb(255,255,255);ba=
ckground-image:none;background-position:0% 0%;background-repeat:repeat"><sp=
an>Currently, even if we set</span><span>=C2=A0</span><span style=3D"font-s=
ize:10.5pt">SHELL =3D &quot;/bin/bash&quot;</span><span>=C2=A0</span><span>=
in the config, BitBake&#39;s still forces</span><span>=C2=A0</span><span st=
yle=3D"font-size:10.5pt">#!/bin/sh</span><span>.=C2=A0</span></p>
<p style=3D"box-sizing:content-box;font-family:Gulim,=EA=B5=B4=EB=A6=BC,san=
s-serif;color:rgb(0,0,0);font-size:10.5pt;vertical-align:top;display:block;=
font-weight:400;margin:0px;padding:0px;background-color:rgb(255,255,255);ba=
ckground-image:none;background-position:0% 0%;background-repeat:repeat"><sp=
an>This causes tasks to fail on systems where points to</span><span>=C2=A0<=
/span><span style=3D"font-size:10.5pt">dash</span><span>=C2=A0</span><span>=
(like Ubuntu), giving us errors like</span><span>=C2=A0</span><span style=
=3D"font-size:10.5pt">Syntax error: &quot;(&quot; unexpected</span><span>.<=
/span><span>=C2=A0</span><span style=3D"font-size:10.5pt">shell_trap_code</=
span><span style=3D"font-size:10.5pt">/bin/sh</span></p></div></div></block=
quote><div><br></div><div>Thanks for the explanation. I have two concerns:<=
/div><div>- it&#39;s a global setting that changes behavior for every shell=
 task (bash behaves differently depending on whether it&#39;s called as /bi=
n/sh or /bin/bash). So you&#39;ll get potentially different build outcomes,=
 and confusing failures that some people see and other people do not.<br></=
div><div>- it will de facto impose a bash requirement on the whole yocto bu=
ild when a layer that needs the setting is added to that build. Layers shou=
ld not impose things like this, and their &#39;special needs&#39; should be=
 contained.<br></div><div><br></div><div>Bash execution should be enabled p=
er-function, when that function is known to need bash.</div><div><br></div>=
<div><div>Note that there&#39;s also scripts/verify-bashisms in oe-core/pok=
y,=20
which was written specifically to catch bash-isms in layers. You could=20
ask your suppliers to run their code through it before it&#39;s submitted.<=
/div><div></div></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex"><div class=3D"msg-8211689720461595998"><div>
<p style=3D"box-sizing:content-box;font-family:Gulim,=EA=B5=B4=EB=A6=BC,san=
s-serif;color:rgb(0,0,0);font-size:10.5pt;vertical-align:top;display:block;=
font-weight:400;margin:0px;padding:0px;background-color:rgb(255,255,255);ba=
ckground-image:none;background-position:0% 0%;background-repeat:repeat"><sp=
an style=3D"font-size:10.5pt"><br></span></p>
<p style=3D"box-sizing:content-box;font-family:Gulim,=EA=B5=B4=EB=A6=BC,san=
s-serif;color:rgb(0,0,0);font-size:10.5pt;vertical-align:top;display:block;=
font-weight:400;margin:0px;padding:0px;background-color:rgb(255,255,255);ba=
ckground-image:none;background-position:0% 0%;background-repeat:repeat"><sp=
an style=3D"box-sizing:content-box;font-weight:bold;margin:0px;padding:0px"=
>Example:</span></p>
<table class=3D"m_-8211689720461595998cui-div" style=3D"border-collapse:col=
lapse"><colgroup><col></colgroup><tbody><tr><td style=3D"box-sizing:content=
-box;font-family:Gulim,=EA=B5=B4=EB=A6=BC,sans-serif;color:rgb(188,190,196)=
;font-size:10.5pt;vertical-align:top;font-weight:400;margin:0px;padding:0px=
;background-color:rgb(30,31,34);background-image:none;background-position:0=
% 0%;background-repeat:repeat;border:0px rgb(188,190,196)"><p><span style=
=3D"font-family:&quot;JetBrains Mono&quot;,monospace;font-size:13.5pt"><spa=
n style=3D"box-sizing:content-box;color:rgb(86,168,245);margin:0px;padding:=
0px">do_install</span>() {<br>=C2=A0 =C2=A0 <span style=3D"box-sizing:conte=
nt-box;color:rgb(197,118,51);margin:0px;padding:0px">local </span>libs=3D(<=
span style=3D"box-sizing:content-box;color:rgb(106,171,115);margin:0px;padd=
ing:0px">&quot;liba.so&quot; &quot;libb.so&quot;</span>) <span style=3D"box=
-sizing:content-box;color:rgb(122,126,133);margin:0px;padding:0px"># Fails =
with &quot;Syntax error: &quot;(&quot; unexpected&quot; on dash<br></span><=
span style=3D"box-sizing:content-box;color:rgb(122,126,133);margin:0px;padd=
ing:0px">    </span><span style=3D"box-sizing:content-box;color:rgb(207,142=
,109);margin:0px;padding:0px">for </span>l <span style=3D"box-sizing:conten=
t-box;color:rgb(207,142,109);margin:0px;padding:0px">in </span><span style=
=3D"box-sizing:content-box;color:rgb(106,171,115);margin:0px;padding:0px">&=
quot;</span><span style=3D"box-sizing:content-box;color:rgb(207,142,109);ma=
rgin:0px;padding:0px">$</span>{libs[@]}<span style=3D"box-sizing:content-bo=
x;color:rgb(106,171,115);margin:0px;padding:0px">&quot;</span>; <span style=
=3D"box-sizing:content-box;color:rgb(207,142,109);margin:0px;padding:0px">d=
o<br></span><span style=3D"box-sizing:content-box;color:rgb(207,142,109);ma=
rgin:0px;padding:0px">        </span><span style=3D"box-sizing:content-box;=
color:rgb(197,118,51);margin:0px;padding:0px">install </span>-m <span style=
=3D"box-sizing:content-box;color:rgb(42,172,184);margin:0px;padding:0px">07=
55 </span>$l <span style=3D"box-sizing:content-box;color:rgb(207,142,109);m=
argin:0px;padding:0px">$</span>{D}<span style=3D"box-sizing:content-box;col=
or:rgb(207,142,109);margin:0px;padding:0px">$</span>{libdir}<br>=C2=A0 =C2=
=A0 <span style=3D"box-sizing:content-box;color:rgb(207,142,109);margin:0px=
;padding:0px">done<br></span>}</span></p>
</td></tr></tbody></table></div></div></blockquote><div><br></div><div>I th=
ink this can be fixed without too much difficulty? Instead of running the c=
ode directly, do something like:</div><div><br></div><div>cat &lt;&lt; END =
&gt; install.sh</div><div>... (code above)</div><div>END</div><div>bash ins=
tall.sh<br></div><div></div><div>=C2=A0</div><br><div>Alex</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex"><div class=3D"msg-821168972046159599=
8"><div><table id=3D"m_-8211689720461595998confidentialsignimg"><tbody><tr>=
<td></td></tr></tbody></table></div>
<table style=3D"display:none"><tbody><tr><td><img style=3D"display: none;" =
border=3D"0" src=3D"http://ext.samsung.net/mail/ext/v1/external/status/upda=
te?userid=3Dsangmin5.lee&amp;do=3DbWFpbElEPTIwMjUxMjMxMTUyNTM1ZXBjbXMxcDI1O=
WI2ZThkN2ViNzJmN2MxNDE2ZWRlZmZkYjNiNTdlNCZyZWNpcGllbnRBZGRyZXNzPWFsZXgua2Fu=
YXZpbkBnbWFpbC5jb20_" width=3D"0" height=3D"0"></td></tr></tbody></table></=
div></blockquote></div></div>

--00000000000004bc47064766607f--

