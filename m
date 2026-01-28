Return-Path: <anibal@limonsoftware.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD764D46BEF
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 18:30:53 +0000 (UTC)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1774.1769625050124499546
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 28 Jan 2026 10:30:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@limonsoftware-com.20230601.gappssmtp.com header.s=20230601 header.b=M4vSgalf;
 spf=pass (domain: limonsoftware.com, ip: 209.85.128.179, mailfrom: anibal@limonsoftware.com)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-78fb5764382so1629187b3.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 28 Jan 2026 10:30:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769625049; cv=none;
        d=google.com; s=arc-20240605;
        b=Vyhqn4ZgzsvII+4Mjxpk8yup1hkY+rDFriS1cfJayO3cftSQPwexawR4CbFAvrthMA
         xjueEBDfu1g4/BoXCi0V+wPhJ0pQ4RiEikZa5Xs/eMWPTatOFpQezf1Wo5f0x0M2z318
         zkQkd9XOe1PAya2tadh4m8KJQ148v5DZplias460P/GcrtPg2MN4naM1fPXReVzeC3r+
         /NnwUFi/feQHbTpPF0+GMe4XmJciuBDS5E4rWmfsqiuGEampPje2Um+OYTmGSXYXEHDR
         n7SGY95x/bWJe42VmDY+I6A6HKaY0NkGsm6nzy3Tqr3TEK1Fcn2w/gDmb0qwEwmXM5oV
         W0hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=h0+Z3t+UukNZ5J2LsPJ9tTptu4kqNUnwZoaXsetVLhE=;
        fh=wsVMgAj0ADi7P3UaxF8vk6SYLvGQwvLXdKbbomS8nmc=;
        b=SjEn+1/xKMbtHeG8bPmsrJ8a6LPYcud/cvPRu80gEXS/6MU3LYgVzCOWFj7HhqFiuD
         u12+SVvXzYRaSoTjxYsT//I/IX8hskuf/8qZwLxtVqBWFU0ni27lV+701ldmzhUyn35P
         OjgTv7ANK/bV1AT3Z+5ADxtR3uhPAabe1B0xWII04rtjWeI2PRI5fzkVjyczEkLe7dE7
         iiBY5jONbsw2kyQG62oR+4bBV1pewAU1pWWTDPA47tkFjuCPOqVTycF4VWvo4fH1CmrV
         AOjy5wFx8AvHZ/iFTuDi678YbAtV0mpb6e14E2MSJ/UkyOvk107CNcPIY3/hAXaMo/NT
         tEaQ==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=limonsoftware-com.20230601.gappssmtp.com; s=20230601; t=1769625049; x=1770229849; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h0+Z3t+UukNZ5J2LsPJ9tTptu4kqNUnwZoaXsetVLhE=;
        b=M4vSgalf9xCDbSLGFTYMdHfJCa1JjwtDwRD16loigDeUImlYTYaCTErBjPKcz37sbd
         IIbSmJS9+sNGye79dln+BhsGVz98MtCypa/tqqthf3XjYTitNI8ki5RhXKXvsUob4C/s
         cXppDmGQqbS6vPlhToo4AHD1UVvU3oou0I24ZK/FfSi1Kt2EeatevdeGNH1nSoWAbKAO
         kB/2W6fn1+erVN2WURfbsC/tIHHzrMmUoEVRJXj0ctK0JbLyhX0C8b5jpKnaitRHWDlb
         82uSv4zSVSkENJ8d+3H4oSxq0KvetBnXlvMwnt/xBL9y5Ed31Y6chU7WZpTxN9NgJ1Cg
         0vnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769625049; x=1770229849;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0+Z3t+UukNZ5J2LsPJ9tTptu4kqNUnwZoaXsetVLhE=;
        b=Ttyco7J3GOY7lIJRh3DxUoeBxiSjJpwKM9AClGo+eQ+6iGnEqbj8qCIpuHScsZuRlJ
         xssEM7oFRDSkmhmozVN6e+u1nFmsWt9E6UiLqxjAKGwkN8Vu/5OnWaNJ+Xp7qOBoN6hu
         2CJHRxc+HsvqkweYupzy5NAKvJ66kQj/AX0uubtP08L/HSkY4FVXHIrIHxmvsKmyRcvc
         PcjOh0JWE/e0SL8ilEkTY1ApSmfqOdfVBykvm+twxf+eNJLu78HmcmGUHG3xhZB8WDVd
         QYtx04/1a/lLMAVBsOaLZ0EtzMkKr+LP0xPZjVpKAis+R9LckF4XSk5L6Al7KBbj8L5M
         MLIg==
X-Forwarded-Encrypted: i=1; AJvYcCU7BLTezEgbEotuaRzQsTSLHr76Bjtc3MKKjwDZXxk37VM0NKCNPDQSXerIjkNprELCjQxjC8mIKA4N8epi@lists.openembedded.org
X-Gm-Message-State: AOJu0YyXAKhViKD5aIFnImObgp1yCp+EOpKwBEbf++une8Q8Onk07lr/
	0UFkKSxkQD8y8cz5UGVn8SHfM6EZ5WsoXF2MJX7mEYGOGf5FBzdJqPZI9fI3MC5cmY1M5iKQpBL
	PMVJ4edKuBWKXsvITxcI7IHlUl0ZSzdbCY8n7HF7emA==
X-Gm-Gg: AZuq6aJ8zppnOQoeM64amzWhWlOaPDDlcd7WKHP6tjW1d02VtocaEccBEsP9fbRJ0qM
	I3gAL3Ep6x3K1JPxsssJry9ZC7l99FeQJ2xyA4YZzjmveSEmmIM2e4k8/9qwwFahg3LFdlD1MlQ
	XBcqDQYMuQuq8gp7bwfMKX87HdgA9sqA8TlFsLErru2LpoiOTP0GvovQPpjCmCnPFNdEEiVvRwr
	Etuf3l5TlXC+yJDOMx1x2qB79zeo38g2pf9xkiVdF74yfrRkd0DDr++zVcIMKGpAjLtTIC4AmbE
	aKrqHmXD1URSRMfT1LW+BSZmh9XfRdhuORS6CY/mJ1lLwKyeR6CKFlWztw==
X-Received: by 2002:a05:690c:314:b0:794:2da0:9374 with SMTP id
 00721157ae682-7947aa17de4mr49012907b3.31.1769625049137; Wed, 28 Jan 2026
 10:30:49 -0800 (PST)
MIME-Version: 1.0
References: <20260128143336.1963432-1-anibal@limonsoftware.com>
 <CANNYZj9xAuhZK2+BfPdTJjmCoZBZ_1srxFUUrFRPi5d7zYi_GA@mail.gmail.com> <188EF863C74CB2B9.4042470@lists.openembedded.org>
In-Reply-To: <188EF863C74CB2B9.4042470@lists.openembedded.org>
From: Anibal Limon <anibal@limonsoftware.com>
Date: Wed, 28 Jan 2026 12:30:37 -0600
X-Gm-Features: AZwV_QhKiVn0ZUQGC9cejMFKmW84HlpEiZTDy2m2RJqAj1tRdBpL65uT9mO4Ge8
Message-ID: <CAOU5ZMvLpHs6ETo847GR2=N7iL8qPxwjuo15aLWpehpmpsucrQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: _has_local_modifications
 fix layer add on existing project
To: anibal@limonsoftware.com
Cc: Alexander Kanavin <alex.kanavin@gmail.com>, bitbake-devel@lists.openembedded.org, 
	alex@linutronix.de, jonas@limonsoftware.com
Content-Type: multipart/alternative; boundary="000000000000709342064976f0e7"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 28 Jan 2026 18:30:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18923

--000000000000709342064976f0e7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 12:26=E2=80=AFPM Anibal Limon via lists.openembedde=
d.org
<anibal=3Dlimonsoftware.com@lists.openembedded.org> wrote:

>
>
> On Wed, Jan 28, 2026 at 8:49=E2=80=AFAM Alexander Kanavin <alex.kanavin@g=
mail.com>
> wrote:
>
>> On Wed, 28 Jan 2026 at 15:33, Anibal Limon via lists.openembedded.org
>> <anibal=3Dlimonsoftware.com@lists.openembedded.org> wrote:
>> > +
>> > +        if not r_name in fixed_revisions['sources']:
>> > +            return False
>>
>> I'm not sure False is a correct value to return? My understanding is
>> that the scenario you have hit is as follows:
>>
>> - manually clone meta-freescale into layers/
>> - add meta-freescale to a configuration
>> - run bitbake-setup update
>
>
Info here,

- setup project with bitbake-setup
- add meta-freescale layer to the config
- setup project with bitbake-setup (fine)
- checkout previous revision  without meta-freescale
- setup project with bitbake-setup (break)


>
>> At this point bitbake-setup sees that meta-freescale already exists,
>> and it needs to decide whether to preserve it or not. As there is no
>> record in fixed revisions of what the original revision was, should it
>> default to preserving, so that any possible user modifications are
>> saved?
>>
>
> Yes, so returning True and may be a different message to the user?.
>
> Anibal
>
>
>>
>> Alex
>>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18921):
> https://lists.openembedded.org/g/bitbake-devel/message/18921
> Mute This Topic: https://lists.openembedded.org/mt/117508137/8181911
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> anibal@limonsoftware.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000709342064976f0e7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jan 28,=
 2026 at 12:26=E2=80=AFPM Anibal Limon via <a href=3D"http://lists.openembe=
dded.org">lists.openembedded.org</a> &lt;anibal=3D<a href=3D"mailto:limonso=
ftware.com@lists.openembedded.org">limonsoftware.com@lists.openembedded.org=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jan 28, 2026 at 8:49=E2=80=AF=
AM Alexander Kanavin &lt;<a href=3D"mailto:alex.kanavin@gmail.com" target=
=3D"_blank">alex.kanavin@gmail.com</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">On Wed, 28 Jan 2026 at 15:33, Anibal Limo=
n via <a href=3D"http://lists.openembedded.org" rel=3D"noreferrer" target=
=3D"_blank">lists.openembedded.org</a><br>
&lt;anibal=3D<a href=3D"mailto:limonsoftware.com@lists.openembedded.org" ta=
rget=3D"_blank">limonsoftware.com@lists.openembedded.org</a>&gt; wrote:<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not r_name in fixed_revisions[&#39;sou=
rces&#39;]:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return False<br>
<br>
I&#39;m not sure False is a correct value to return? My understanding is<br=
>
that the scenario you have hit is as follows:<br>
<br>
- manually clone meta-freescale into layers/<br>
- add meta-freescale to a configuration<br>
- run bitbake-setup update</blockquote></div></div></blockquote><div><br></=
div><div>Info here,</div><div><br></div><div>- setup project with bitbake-s=
etup</div><div>- add meta-freescale layer to the config</div><div>- setup p=
roject with bitbake-setup (fine)</div><div>- checkout previous revision=C2=
=A0 without meta-freescale</div><div>- setup project with bitbake-setup (br=
eak)</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
"><div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
<br>
At this point bitbake-setup sees that meta-freescale already exists,<br>
and it needs to decide whether to preserve it or not. As there is no<br>
record in fixed revisions of what the original revision was, should it<br>
default to preserving, so that any possible user modifications are<br>
saved?<br></blockquote><div><br></div><div>Yes, so returning True and may b=
e a different=C2=A0message to the user?.</div><div><br></div><div>Anibal</d=
iv><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Alex<br>
</blockquote></div></div>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#18921): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/18921" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/18921</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/117508137/818=
1911" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/117508137/8181911</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:anibal@limonsoftware.com" target=
=3D"_blank">anibal@limonsoftware.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div>

--000000000000709342064976f0e7--

