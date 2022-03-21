Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17DCC433F5
	for <webhook@archiver.kernel.org>; Mon, 21 Mar 2022 17:05:41 +0000 (UTC)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com
 [209.85.167.51])
 by mx.groups.io with SMTP id smtpd.web10.1013.1647882340822557509
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 21 Mar 2022 10:05:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=YhurLEJD;
 spf=pass (domain: gmail.com, ip: 209.85.167.51,
 mailfrom: quaresma.jose@gmail.com)
Received: by mail-lf1-f51.google.com with SMTP id bt26so25640632lfb.3
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 21 Mar 2022 10:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AVS/vFmSlbb05Utd/i+g1roK+di5pzlwQIYMhn9zKto=;
        b=YhurLEJDlj7bogr9sXEWo6RhrV92A3GWjfLHiUBjAAEuO/cpR/nk5sDGpg3CMTZSUF
         2t0YBm/xHHXHw68htFQ2oAkuLVksrRReuBpsaghJ7rg8/WoTdysxp0u791lWWVPNjIVp
         qiByJVCafV92ZxEXlWH6f5ppK9Td5Hyyw052aXpeDhfZRp8oVb2heddi+BUE5D4A2Btd
         LgOahs7br9K/8+tWeOJpjn88bk9J+hoyR0iUe02gScM0Lh6XljP5cr4V9Ab+uvJtjlQa
         vSRKWssyurGOZUReE24BIGw59h7gCd0PmEFGqYSOO+uVyHlyeq8wKeQ6Abeg+yH13tOc
         svWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AVS/vFmSlbb05Utd/i+g1roK+di5pzlwQIYMhn9zKto=;
        b=ChgK0jX4893Or4FRfHawtdR1tB5XE/6dluhMRYwvGOvvsKvyxovfXfZE++IG68tx+T
         DZYLGLR9gG0+xjxQtZhhZux5+QjLoxQKvS/FBL4JWZYErFZdGOgYicIybemWp3WRtPKp
         hb5wxwgM6XBwiyRctfB1afYX/qUHxnNDvg9ZQnzyAhNIxm1k2nQ/npMo1s3C1V+CVY/t
         jJfS8+Jr+Oa9k8rUumdAh0AedAcoDCrJfT1aN73Fx6QXro+OzrRRwF63ccjSJXAWgFVd
         afgXEGbD6GhkrEkjtYWjahfJ3MXaf5hXNElMiNKspeDVVLSYdBvaRYD6o4zT076uFtin
         sGMw==
X-Gm-Message-State: AOAM5307FmuwVNmq8BBHpvNml4OOR/WN4VPPA6cQRjfnFqf3CAZyAoro
	Jba+mHdqkka6Xd974eBGB6ZDTt3F2VZ9lJt5PCMeCdaptak=
X-Google-Smtp-Source: 
 ABdhPJyUT3Y/Y08gSpw508hKkH/b6kDNxUV6N7fNpoBM6OMbzvqlOIu0qtDJrAZB1cSv0SwSO8jMpQHZYF5UC1ii5DU=
X-Received: by 2002:a05:6512:acb:b0:44a:24b7:7fa4 with SMTP id
 n11-20020a0565120acb00b0044a24b77fa4mr6079467lfu.94.1647882338898; Mon, 21
 Mar 2022 10:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220321170104.3371476-1-ross.burton@arm.com>
In-Reply-To: <20220321170104.3371476-1-ross.burton@arm.com>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Mon, 21 Mar 2022 17:05:27 +0000
Message-ID: 
 <CANPvuRkLfOOtqe2a8roVRisq7Qxb6yyJLxiGFkHQ=sSzOFQ8Mw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] knotty: display active tasks when
 printing keepAlive() message
To: Ross Burton <ross@burtonini.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000711a8205dabd811e"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 21 Mar 2022 17:05:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13491

--000000000000711a8205dabd811e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ross,

Ross Burton <ross@burtonini.com> escreveu no dia segunda, 21/03/2022 =C3=A0=
(s)
17:01:

> In interactive bitbake sessions it is obvious what tasks are running
> when one of them hangs or otherwise takes a long time. However, in
> non-interactive sessions (such as automated builds) bitbake just prints
> a message saying that it is "still alive" with no clues as to what tasks
> are active still.
>
> By simply listing the active tasks when printing the keep alive message,
> we don't need to parse the bitbake log to identify which of the tasks
> is still active and has presumably hung.
>
> Signed-off-by: Ross Burton <ross.burton@arm.com>
> ---
>  bitbake/lib/bb/ui/knotty.py | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
> index 78888f8bdd3..50dd4229da4 100644
> --- a/bitbake/lib/bb/ui/knotty.py
> +++ b/bitbake/lib/bb/ui/knotty.py
> @@ -228,7 +228,9 @@ class TerminalFilter(object):
>
>      def keepAlive(self, t):
>          if not self.cuu:
> -            print("Bitbake still alive (%ds)" % t)
> +            print("Bitbake still alive (no events for %ds). Active
> tasks:" % t)
> +            for t in self.helper.running_tasks:
> +                print(t)
>

I think that building a new string with all tasks and call print at the end
is more efficient.

Jose

             sys.stdout.flush()
>
>      def updateFooter(self):
> --
> 2.25.1
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13490):
> https://lists.openembedded.org/g/bitbake-devel/message/13490
> Mute This Topic: https://lists.openembedded.org/mt/89932958/5052612
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> quaresma.jose@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--=20
Best regards,

Jos=C3=A9 Quaresma

--000000000000711a8205dabd811e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Ross,</div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">Ross Burton &lt;<a href=3D"mailto:ross@burton=
ini.com">ross@burtonini.com</a>&gt; escreveu no dia segunda, 21/03/2022 =C3=
=A0(s) 17:01:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">In=
 interactive bitbake sessions it is obvious what tasks are running<br>
when one of them hangs or otherwise takes a long time. However, in<br>
non-interactive sessions (such as automated builds) bitbake just prints<br>
a message saying that it is &quot;still alive&quot; with no clues as to wha=
t tasks<br>
are active still.<br>
<br>
By simply listing the active tasks when printing the keep alive message,<br=
>
we don&#39;t need to parse the bitbake log to identify which of the tasks<b=
r>
is still active and has presumably hung.<br>
<br>
Signed-off-by: Ross Burton &lt;<a href=3D"mailto:ross.burton@arm.com" targe=
t=3D"_blank">ross.burton@arm.com</a>&gt;<br>
---<br>
=C2=A0bitbake/lib/bb/ui/knotty.py | 4 +++-<br>
=C2=A01 file changed, 3 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py<br>
index 78888f8bdd3..50dd4229da4 100644<br>
--- a/bitbake/lib/bb/ui/knotty.py<br>
+++ b/bitbake/lib/bb/ui/knotty.py<br>
@@ -228,7 +228,9 @@ class TerminalFilter(object):<br>
<br>
=C2=A0 =C2=A0 =C2=A0def keepAlive(self, t):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not self.cuu:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Bitbake still alive =
(%ds)&quot; % t)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Bitbake still alive =
(no events for %ds). Active tasks:&quot; % t)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for t in self.helper.running_tas=
ks:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(t)<br></bloc=
kquote><div><br></div><div>I think that building a new string with all task=
s and call print at the end is more efficient.</div><div><br></div><div>Jos=
e</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sys.stdout.flush()<br>
<br>
=C2=A0 =C2=A0 =C2=A0def updateFooter(self):<br>
-- <br>
2.25.1<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#13490): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/13490" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/13490</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/89932958/5052=
612" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/89932958/5052612</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:quaresma.jose@gmail.com" target=3D=
"_blank">quaresma.jose@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr">Best regards,<div><br>Jos=C3=A9=
 Quaresma</div></div></div></div>

--000000000000711a8205dabd811e--

