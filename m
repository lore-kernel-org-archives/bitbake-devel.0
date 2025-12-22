Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2333CD711D5
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 09:10:20 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.76885.1766394610604528627
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Dec 2025 01:10:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=Uq6QblGr;
 spf=pass (domain: smile.fr, ip: 209.85.221.54, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42e2e628f8aso1535778f8f.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 22 Dec 2025 01:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1766394609; x=1766999409; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wwe+ORJDnu0wJh/cepW4nfojbGKjj6HBxGGkhfFViVc=;
        b=Uq6QblGrOu8x3VdeqTqMhc+qTnBsTzqSoh8G60mHBb21DZhBUYfGtpv4k9VrBElRoK
         G89k7rE1j4WPZvjoY5dU0TIUadq2ug2DeUJ+zW/SFFRULDR2JWXwqUROabQBa1MwFkAO
         MNkQfmcj/y0NsVev3UQZHaHaL6xq6yWvQS99o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766394609; x=1766999409;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwe+ORJDnu0wJh/cepW4nfojbGKjj6HBxGGkhfFViVc=;
        b=RvuozQBiw4LMCZ1OuXEpkJnGir+DF/OUCX6YbImt5MIL5kfr3AxX/NRqnN3HB/ZSuI
         fKsih8JHIkB3T/WRN3rrSac04NFG+hDb6FE2uM+NE/8/3EY+2XS6U0uY/ZSbVBzuan7x
         ruJbdp2lkPUkJdo5DGbzDRFQ//5uuk4vo250MI/u2yWCZOOEUB9V/y1BLUNwHOKUY8Ux
         ID9DytlkECzrJlDjUayJYfLMgBdKvlZLM+b4KCieix5g+XIeoOdKQx93eioC4xvagS/t
         jES502/AvWrFQCA0F5T4OkDlFaoQiHoLFndbE4McPwBv7ZvZccOZXyOMkJ1g7Wkyq/Yr
         8Fmg==
X-Gm-Message-State: AOJu0YxBEs8RuQiopLyCk48Wf2KtKp9o8DmT+7HdbvwtwjPHIbATPxwX
	36MhJcBBS+uLy6ArsovHJvdJpUwE3Tf8H6Utubkyzx8r7jEEcfg4BqPaOGjgwpMZ4gssWjSKTS7
	IlQyB6AkVWwEL2T2A9XktcdYKewFu5sWwbQBo5ximqA==
X-Gm-Gg: AY/fxX7ju++HhLca4fgiEbkB7Su3e96Zq5pR04p1iSaPMzQwLvaSbOk/BIc/XJFInq+
	lGcPCUw75KVl4T0YkpKn/BjF5x3f6B9jR9eK5KRxGZ/kHmhhRODTqustIOyLzymLEU34aWgGR2k
	ixtM7YgVTXb+ZZ0dHD/Xb0RUNR/R0WnTKITdRvp12KK0+x7oSg9wUo3dGnDFQ0sNpG1wytnd0hD
	iIxZ1o8lIntweAuusktq5iDmWUIrJkk7H3ZXQz37TrEc401pUsLLpWk524sJFmu5g6HnQbOyxpP
	0R19JZrouV8GSZUDPtLYwWLyLi0F
X-Google-Smtp-Source: AGHT+IFm4eDHQDnKtBiHWIF+lOABNWjmICjje941kGDIlvnthrAVLWsY0mfQNh6KD9vXJwihNoamfhPRsBasjbIHO+I=
X-Received: by 2002:a05:6000:2203:b0:430:8583:d182 with SMTP id
 ffacd0b85a97d-4324e5015d9mr12135738f8f.29.1766394608834; Mon, 22 Dec 2025
 01:10:08 -0800 (PST)
MIME-Version: 1.0
References: <a0cf0864-dd61-48db-b856-575f8fc4c149@gmail.com>
In-Reply-To: <a0cf0864-dd61-48db-b856-575f8fc4c149@gmail.com>
From: Yoann Congal <yoann.congal@smile.fr>
Date: Mon, 22 Dec 2025 10:09:42 +0100
X-Gm-Features: AQt7F2rPe4WjtrkbVB3X252ad0GywSBBZkkt-ZxlCEG5PqOgmm4LaPO4riJiv1s
Message-ID: <CAMSfU+71B0VQvP7U5BPDcgY++q=PMY3pfTOWdOREXorwAAU9bA@mail.gmail.com>
Subject: Re: [bitbake-devel] bitbake-setup update problem
To: uvv.mail@gmail.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000316fd6064686cb39"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Dec 2025 09:10:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18632

--000000000000316fd6064686cb39
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 22 d=C3=A9c. 2025 =C3=A0 09:56, Vyacheslav Yurkov via lists.openemb=
edded.org
<uvv.mail=3Dgmail.com@lists.openembedded.org> a =C3=A9crit :

> It turned out to be a painful discovery.
> I wanted to rebase my custom branch in oe-core on top of latest master
> before publishing a set of patches. But it seems like after running
> 'bitbake-setup update' my branch is nowhere to be seen. Is it supposed
> to be like that? Any chance to get it restored?
>

Try "git reflog HEAD", you should see every commit HEAD has been on (and,
in theory, the commit at the tip of your branch)


>
> Regards,
> Slava
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18631):
> https://lists.openembedded.org/g/bitbake-devel/message/18631
> Mute This Topic: https://lists.openembedded.org/mt/116898936/4316185
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> yoann.congal@smile.fr]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--=20
Yoann Congal
Smile ECS

--000000000000316fd6064686cb39
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Le=C2=A0lun. 22=
 d=C3=A9c. 2025 =C3=A0=C2=A009:56, Vyacheslav Yurkov via <a href=3D"http://=
lists.openembedded.org">lists.openembedded.org</a> &lt;uvv.mail=3D<a href=
=3D"mailto:gmail.com@lists.openembedded.org">gmail.com@lists.openembedded.o=
rg</a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">It turned out to be a painful discovery.<br>
I wanted to rebase my custom branch in oe-core on top of latest master <br>
before publishing a set of patches. But it seems like after running <br>
&#39;bitbake-setup update&#39; my branch is nowhere to be seen. Is it suppo=
sed <br>
to be like that? Any chance to get it restored?<br></blockquote><div><br></=
div><div>Try &quot;git reflog HEAD&quot;, you should see every commit HEAD =
has been on (and, in theory, the commit at the tip of your branch)</div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Regards,<br>
Slava<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#18631): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/18631" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/18631</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/116898936/431=
6185" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/116898936/4316185</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:yoann.congal@smile.fr" target=3D"_=
blank">yoann.congal@smile.fr</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"Raleway, regular">Yoann Congal</font><div><fon=
t face=3D"Raleway, regular">Smile ECS</font></div></div></div></div>

--000000000000316fd6064686cb39--

