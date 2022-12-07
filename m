Return-Path: <kergoth@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E5CC352A1
	for <webhook@archiver.kernel.org>; Wed,  7 Dec 2022 15:31:32 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web11.18331.1670427087757252957
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 07 Dec 2022 07:31:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=QmQbotNB;
 spf=pass (domain: gmail.com, ip: 209.85.214.179, mailfrom: kergoth@gmail.com)
Received: by mail-pl1-f179.google.com with SMTP id s7so17337574plk.5
        for <bitbake-devel@lists.openembedded.org>; Wed, 07 Dec 2022 07:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ddm+Kox4Uio03LF7/LuuGBVOYwMVmmnCmVxg/W1dMVA=;
        b=QmQbotNByNIGK8yN+1zUqFfCsjrkQY4Rm9XWt/HDMjLjOSZdT+pQXdesohb8mu6Kt2
         OCXo1C5Hz+ueNGJDBjWSxWF02FfbBnzh7lC0wsvhsrt1f4dxGNFOsOEfyPsRniybEY0O
         r4sH4e8dZ8nObo7KkD4YGcXVGePmzt5yalZdwYozg8do5p8MEQDm5055aHWQBRz2BUMF
         oWQwBZ8sJa6KCnynm8EPTNyuNiGYJjwLETZdRsH2DBTBMT5kuyrhUKcW5CqIXvr2ISK7
         qgK5PhmnvbWKZyImMZAeUQ2OjGKQDj3omYsxBjVu2uSwf4SsRASeOrnSgtZM8LySdPvg
         fm2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ddm+Kox4Uio03LF7/LuuGBVOYwMVmmnCmVxg/W1dMVA=;
        b=c6TnDnVL90g4voeX1PLw8fKuQn94Lr0Qfg1rWxZUIQJfeT7rAb1vtoFo22IgOYci8b
         tHIV+duRPzWds41bOzqnBnnIuhNazuZr2+sqoduqGzKjetF8n4scJ3hg8wg7A6Lntu+o
         7slKp8gBHNSRG7AfVkuawyy2gvlIY2Mib47/PbmsXXyIeTBv/R9DOLBZfkImv2OW+Kg2
         d5uYBku/c5Nez4zmAYQXF1373mmmMW+SnndB9P4AwXNzts4dJCNXb6WprXHGj8rclVhv
         gnLyAxiVAIjLtcIDi4nwOMKvSuw4/MH9nk6J8f3aVAipbBrpSp4IieDrRqEYASCpzBsW
         qHYQ==
X-Gm-Message-State: ANoB5pmJojJjlgFkI1JPcJ2UxavCsxLXSQbiREZ1uW2OTohZZ23be8yp
	GzJRG6tdJfyxR72osBIJDRF1ll8PVPpcEQprVF+Rm+Ah5uY=
X-Google-Smtp-Source: AA0mqf7C11uRYd2+2astq9vg0LAltjawuDCv8QG2gYWrmsdr30MwhMgkK7OPBySzkg/hMN4GItb6h+49zK6YNT4JvSY=
X-Received: by 2002:a17:903:2693:b0:189:e206:2223 with SMTP id
 jf19-20020a170903269300b00189e2062223mr11605076plb.97.1670427087188; Wed, 07
 Dec 2022 07:31:27 -0800 (PST)
MIME-Version: 1.0
References: <20221207141539.2129083-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20221207141539.2129083-1-richard.purdie@linuxfoundation.org>
From: Christopher Larson <kergoth@gmail.com>
Date: Wed, 7 Dec 2022 08:31:15 -0700
Message-ID: <CABcZANkBcRoqU3nk=i+Jv+343UtKeyJuDGCN_jjVjhGBw+UZgA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] parse: Add support for addpylib conf file
 directive and BB_GLOBAL_PYMODULES
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000027b85605ef3e9db5"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 07 Dec 2022 15:31:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14145

--00000000000027b85605ef3e9db5
Content-Type: text/plain; charset="UTF-8"

On Wed, Dec 7, 2022 at 7:15 AM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> For many years OE-Core has injected it's own python modules into the
> python namespace using an immediate expansion of a variable in
> base.bbclass.
>
> We really need this to become a first class citizen of the langauge, this
> new
> addpylib directive allows that. Usage is of the form:
>
> addpylib <directory> <namespace>
>
> The namespace is imported and if there is an attribute BBIMPORT, that
> list of names is iterated and imported too.
>
> This mirrors what OE-Core has done for a long time with one difference in
> implmentation, sys.path is only appended to. This means later imported
> namespaces can't overwrite an earlier one and can't overwrite the main
> python module space. In practice we've never done that and it isn't
> something we should encourage or support.
>
> The new directive is only applied for .conf files and not other filetypes
> as it only makes sense in that context. It is also only allowed in the
> "base configuration" context of cookerdata since adding it at the recipe
> level wouldn't work properly due to the way it changes the global
> namespace.
>
> At the same time, move the list of modules to place in the global namespace
> into a BB_GLOBAL_PYMODULES variable. It is intended that only the core
> layer
> should touch this and it is meant to be a very small list, usually os and
> sys.
>

This looks great in general, thanks for working on this. Anything is better
than the current hack, and using a proper directive seems clean. It seems
like BB_GLOBAL_PYMODULES and BBIMPORT will be checked in every addpylib
directive, though, which seems to indicate that metadata which doesn't have
any addpylib directives won't get those variables processed, is that
correct? The semantics there don't seem entirely clear. It also seems like
the import happens right there at the addpylib line, so it's an immediate
operation, right? To be expected, but we might want to mention that
specifically in the docs and/or commit message.
-- 
Christopher Larson
chris_larson@mentor.com, chris.larson@siemens.com, kergoth@gmail.com
Principal Software Engineer, Embedded Linux Solutions, Siemens Digital
Industries Software

--00000000000027b85605ef3e9db5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Dec 7, 2022 at 7:15 AM Richar=
d Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org">richard.=
purdie@linuxfoundation.org</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">For many years OE-Core has injected it&#39;s own =
python modules into the<br>
python namespace using an immediate expansion of a variable in base.bbclass=
.<br>
<br>
We really need this to become a first class citizen of the langauge, this n=
ew<br>
addpylib directive allows that. Usage is of the form:<br>
<br>
addpylib &lt;directory&gt; &lt;namespace&gt;<br>
<br>
The namespace is imported and if there is an attribute BBIMPORT, that<br>
list of names is iterated and imported too.<br>
<br>
This mirrors what OE-Core has done for a long time with one difference in<b=
r>
implmentation, sys.path is only appended to. This means later imported<br>
namespaces can&#39;t overwrite an earlier one and can&#39;t overwrite the m=
ain<br>
python module space. In practice we&#39;ve never done that and it isn&#39;t=
<br>
something we should encourage or support.<br>
<br>
The new directive is only applied for .conf files and not other filetypes<b=
r>
as it only makes sense in that context. It is also only allowed in the<br>
&quot;base configuration&quot; context of cookerdata since adding it at the=
 recipe<br>
level wouldn&#39;t work properly due to the way it changes the global names=
pace.<br>
<br>
At the same time, move the list of modules to place in the global namespace=
<br>
into a BB_GLOBAL_PYMODULES variable. It is intended that only the core laye=
r<br>
should touch this and it is meant to be a very small list, usually os and s=
ys.<br></blockquote><div><br></div><div>This looks great in general, thanks=
 for working on this. Anything is better than the current hack, and using a=
 proper directive seems clean. It seems like BB_GLOBAL_PYMODULES and BBIMPO=
RT will be checked in every addpylib directive, though, which seems to indi=
cate that metadata which doesn&#39;t have any addpylib directives won&#39;t=
 get those variables processed, is that correct? The semantics there don&#3=
9;t seem entirely clear. It also seems like the import happens right there =
at the addpylib line, so it&#39;s an immediate operation, right? To be expe=
cted, but we might want to mention that specifically in the docs and/or com=
mit message.</div></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><=
div dir=3D"ltr"><div dir=3D"ltr"><font color=3D"#333333">Christopher Larson=
<br><a>chris_larson@mentor.com</a>,=C2=A0<a>chris.larson@siemens.com</a>,=
=C2=A0<a>kergoth@gmail.com</a><br>Principal Software Engineer,=C2=A0Embedde=
d Linux Solutions,=C2=A0Siemens Digital Industries Software</font><br></div=
></div></div></div>

--00000000000027b85605ef3e9db5--

