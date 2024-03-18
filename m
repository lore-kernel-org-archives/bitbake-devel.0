Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819F3C54E58
	for <webhook@archiver.kernel.org>; Mon, 18 Mar 2024 15:17:35 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
 by mx.groups.io with SMTP id smtpd.web10.47411.1710775052055955876
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 Mar 2024 08:17:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile-fr.20230601.gappssmtp.com header.s=20230601 header.b=QgTwNOKL;
 spf=pass (domain: smile.fr, ip: 209.85.218.43, mailfrom: yoann.congal@smile.fr)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a4675aaa2e8so516949766b.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 18 Mar 2024 08:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1710775050; x=1711379850; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2Wx7xe8cvpAQyi5ozJb9yS38EBe09lyYDLmiBevXt/Y=;
        b=QgTwNOKLjptxOPxg6MOCLQ3DvfMQm8Z0kHHnD65HxCGB5Sg9Xbzyyjvgrt8xVEufq4
         x7OGN3M1SZIxXxvz4nlmcwY18YjDdINPyIdaUi7wUyDN0Nt5cvpY5YSJKpwce0649tpL
         MQ7YD/KskS/fxSMzUs5vRLXaJ25oV8nqsL/054gN1X0v6cnNr8crXoriek6R7N5aYA7N
         m6tY6KvLMNabbqj07vekAXvL+GOUNgEHkTgSOVAcZFt51o4Yw7HvfL+yvcbJeezH6GVE
         Hs6ERMjzoNrlEAIvrMHiMJL4+DV59Qqs8RXgYUPWlOSydRNMTOHM1xVHJfKilUwEbX3f
         VzIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710775050; x=1711379850;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Wx7xe8cvpAQyi5ozJb9yS38EBe09lyYDLmiBevXt/Y=;
        b=r2fDHn7XMRZHfEnburYrIgpX9gj20P7hDr48XlCEhX9tWbhBcFafSEe065UBknCXHE
         dO4NpTT5ov+Wilkt/O9VYuQhVOrS87q7+YkRWB8lfEH5CevEM6JCNtoK+mOAZfF/xLdQ
         JYaERI5+on6MTBBpdO6EQyzfkpZCWUgvIbZckjy6dQNNXLjTXayNt63lAaOYi94rulWL
         lJm1KZYDN5dasEza9u/SrEU+WFDTq5sa7aW7IPO3dM8e3M9wAWlydbYlYJlF0x+GTCFA
         ItPt9RP/nLtQg7OSOI10PwwTHboNWGlDrXCxOK6rUPpLe7xufuV8+ANVVjjJjfnfc86M
         ThuQ==
X-Gm-Message-State: AOJu0Yy5HTn6mUYJ0jLsh4TOEuJXieB+wRB/+9w7RwzUlNrJMARjKft8
	9izi4YfcSpasoaGjsxWk/NIgNlLHu4zH7VJW7ZP0bCkpt+I/8gBFgbljrgkYTK4QBbQYDqf3wry
	Lirfvs3aP6QLkd8+Y3vuqzme/3tUjndXS90HEgw==
X-Google-Smtp-Source: AGHT+IHmIMJEZqrmfe6YIzSG7cS8tA81l65fiYq27foJJ/6//9TrifZCJDRV9hJ2EMV9QYUOyYCOschre/yAqmZfFYs=
X-Received: by 2002:a17:906:fcb6:b0:a3e:da6:85f8 with SMTP id
 qw22-20020a170906fcb600b00a3e0da685f8mr7174756ejb.30.1710775050489; Mon, 18
 Mar 2024 08:17:30 -0700 (PDT)
MIME-Version: 1.0
References: <99f6d56b-8013-4255-bd96-5a66bb9130f4@bootlin.com>
In-Reply-To: <99f6d56b-8013-4255-bd96-5a66bb9130f4@bootlin.com>
From: Yoann CONGAL <yoann.congal@smile.fr>
Date: Mon, 18 Mar 2024 16:17:04 +0100
Message-ID: <CAMSfU+6=j7mzh0_WtRh5D-QNotqcwjEGMbYjqomaYRLs6G1LEg@mail.gmail.com>
Subject: Re: [bitbake-devel] How to turn a poky patch into a bitbake one?
To: michael.opdenacker@bootlin.com
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="0000000000002cf8e40613f0dbe4"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 Mar 2024 15:17:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16004

--0000000000002cf8e40613f0dbe4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 18 mars 2024 =C3=A0 15:41, Michael Opdenacker via lists.openembedde=
d.org
<michael.opdenacker=3Dbootlin.com@lists.openembedded.org> a =C3=A9crit :

> Greetings,
>
> For testing convenience, I made BitBake changes directly in the Poky tree=
.
>
> Before I re-apply my changes to a BitBake tree before submitting them,
> in a very manual way (like removing "bitbake/"  in the paths in my
> generated patches), would you have a nicer way to turn my changes under
> Poky's "bitbake/" subdirectory into a proper pathset for BitBake?
>
> Git tips appreciated. I guess I'm not the first one to do this :-}
>

FWIW, I do:
* patch/test/commit in poky
* git format-patch
* patchtest
* and then, I have repos for contribution (splitted poky : oe-core,
meta-yocto, yocto-docs, bitbake, ...). Those repos are set up with
git-configs to set the correct recipient and [tag][PATCH] when
git-send-email.
To import in the bitbake repo, I'd use "git am -p2 <patch from poky.git>"

I've tried to use combo-layer for this but never found the right process.


> Cheers
> Michael.
>
> --
> Michael Opdenacker, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16001):
> https://lists.openembedded.org/g/bitbake-devel/message/16001
> Mute This Topic: https://lists.openembedded.org/mt/105004317/4316185
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> yoann.congal@smile.fr]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--=20
Yoann Congal
Smile ECS - Tech expert

--0000000000002cf8e40613f0dbe4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Le=C2=A0lun. 18 mars 2024 =C3=A0=C2=
=A015:41, Michael Opdenacker via <a href=3D"http://lists.openembedded.org">=
lists.openembedded.org</a> &lt;michael.opdenacker=3D<a href=3D"mailto:bootl=
in.com@lists.openembedded.org">bootlin.com@lists.openembedded.org</a>&gt; a=
 =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">Greetings,<br>
<br>
For testing convenience, I made BitBake changes directly in the Poky tree.<=
br>
<br>
Before I re-apply my changes to a BitBake tree before submitting them, <br>
in a very manual way (like removing &quot;bitbake/&quot;=C2=A0 in the paths=
 in my <br>
generated patches), would you have a nicer way to turn my changes under <br=
>
Poky&#39;s &quot;bitbake/&quot; subdirectory into a proper pathset for BitB=
ake?<br>
<br>
Git tips appreciated. I guess I&#39;m not the first one to do this :-}<br><=
/blockquote><div><br></div><div>FWIW, I do:</div><div>* patch/test/commit i=
n poky</div><div>* git format-patch</div><div>* patchtest</div><div>* and t=
hen, I have repos for contribution (splitted poky : oe-core, meta-yocto, yo=
cto-docs, bitbake, ...). Those repos are set up with git-configs to set the=
 correct recipient and [tag][PATCH] when git-send-email.</div><div>To impor=
t in the bitbake repo, I&#39;d use &quot;git am -p2 &lt;patch from poky.git=
&gt;&quot;<br></div><div><br></div><div>I&#39;ve tried to use combo-layer f=
or this but never found the right process.<br></div><div>=C2=A0</div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
Cheers<br>
Michael.<br>
<br>
-- <br>
Michael Opdenacker, Bootlin<br>
Embedded Linux and Kernel engineering<br>
<a href=3D"https://bootlin.com" rel=3D"noreferrer" target=3D"_blank">https:=
//bootlin.com</a><br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#16001): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/16001" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/16001</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/105004317/431=
6185" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/105004317/4316185</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:yoann.congal@smile.fr" target=3D"_=
blank">yoann.congal@smile.fr</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"l=
tr"><font face=3D"Raleway, regular">Yoann Congal</font><div><font face=3D"R=
aleway, regular">Smile ECS - Tech expert<br></font></div></div></div></div>

--0000000000002cf8e40613f0dbe4--

