Return-Path: <Martin.Jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F17C433EF
	for <webhook@archiver.kernel.org>; Mon, 21 Mar 2022 17:20:33 +0000 (UTC)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com
 [209.85.217.47])
 by mx.groups.io with SMTP id smtpd.web11.34.1647883232235469430
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 21 Mar 2022 10:20:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=RYGexWK/;
 spf=pass (domain: gmail.com, ip: 209.85.217.47,
 mailfrom: martin.jansa@gmail.com)
Received: by mail-vs1-f47.google.com with SMTP id u198so8957357vsu.10
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 21 Mar 2022 10:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5hXmEtcEgluBSQW+cXFbR0Q08N+MM0iOQeMJ1/YZM/0=;
        b=RYGexWK/93zRWg0umsT3x8fSSeX1TAoFbkXaAAQJg0Xg2CeRq47NNRpNRJlAaOjpZ7
         13Do4T2zw1qHFTO9wHEW/93gZ/ORs/sm5wLNqysDUE7QNiCNP/wx0/G60vgpKuWREmH/
         8NstYlnQt5mKigi/l7fb0WfpwgmH310ip7gjygBXHFIHFqlRwGVdxp4vthBxaHIOBLn+
         w9ZVYz8heIQH4QSG+3M6DLTw3H2XS7yYkMXA951IJ3MzdjipHvk/CKkxqQ2iYVNQhbVf
         VDQl767V0uJB4vUs56JBKYoCneR/1YPxfIyMT/ZpxieXI8Z08eKETeqZS8DLC9j6sLGL
         Viuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5hXmEtcEgluBSQW+cXFbR0Q08N+MM0iOQeMJ1/YZM/0=;
        b=74QWK74NeiTfFvin5ZZcGbtWEuHZXtkDmcdOsOgxWk7eceoQThAZ7R8UMbWUTxhmBH
         VJJVK2UNjaGf+Mx5ufv8nKV++u/Tw4pkCohuVuEzfuj8Zd6l/wl7oTD03cRj7I0pfTGi
         csRRg49AXePWCdyLvSV9hC6NZLLAQMpMbwHHKV03Y9m8CqYHjMhAa622t/xBnuNz7ShM
         jRoQ5Ay5SVOVW2UtXtumOCaufWFU8LiSL1o9RSaSPVEs8FRtJ+aKRiygYlAsVWeSyo2r
         nrC+2N+L6XWRFjxM8b7r7bKjzaJOJnhaCCkY+UEqiAA0ov677k/ShtR/9Qn7+iqtIkY+
         9EyQ==
X-Gm-Message-State: AOAM530Ix/bl8LqZEllXUJqqJm+9kyLQwhY04bJNPgUPaNelPcnuoOoh
	0E45f9cTYOiGgKU7lN560D15vgSynKGuAZ4u3do=
X-Google-Smtp-Source: 
 ABdhPJy8ADtvYKackLtq23OWMxoyFMKdzu75dObT37TGweTHaTUnx53tS1qcE2l+VdLxupkPUvro8eeC+BIc9NcmrBc=
X-Received: by 2002:a05:6102:5594:b0:324:f7e8:a6df with SMTP id
 dc20-20020a056102559400b00324f7e8a6dfmr3153465vsb.62.1647883231334; Mon, 21
 Mar 2022 10:20:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220321170104.3371476-1-ross.burton@arm.com>
In-Reply-To: <20220321170104.3371476-1-ross.burton@arm.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Mon, 21 Mar 2022 18:19:59 +0100
Message-ID: 
 <CA+chaQfYrpNihF_BNx66f3cSoRbhfRTy2wLOjekq00G=Q=tE9A@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] knotty: display active tasks when
 printing keepAlive() message
To: Ross Burton <ross@burtonini.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000a2a15305dabdb66c"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 21 Mar 2022 17:20:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13492

--000000000000a2a15305dabdb66c
Content-Type: text/plain; charset="UTF-8"

I like this idea and with this implemented, it might be useful to
lower printinterval 5000s to something a bit shorter as well (or make it
configurable)

No output at all for 10+ minutes always looks strange and if I have a shell
on the builder I would check top/htop to see what's still running (if it's
something expected like chromium do_compile or something less expected like
linux-yocto do_fetch when the premirror should already be populated).
Printing this directly in knotty log file would very convenient for people
who cannot just run htop or similar on builder and tens extra lines in the
log file doesn't seem too bad.

Regards,

On Mon, Mar 21, 2022 at 6:01 PM Ross Burton <ross@burtonini.com> wrote:

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
>              sys.stdout.flush()
>
>      def updateFooter(self):
> --
> 2.25.1
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13490):
> https://lists.openembedded.org/g/bitbake-devel/message/13490
> Mute This Topic: https://lists.openembedded.org/mt/89932958/3617156
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> Martin.Jansa@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

--000000000000a2a15305dabdb66c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I like this idea and with this implemented, it might be us=
eful to lower=C2=A0printinterval 5000s to something a bit shorter as well (=
or make it configurable)<div><br></div><div>No output at all for 10+ minute=
s always looks strange and if I have a shell on the builder I would check t=
op/htop to see what&#39;s still running (if it&#39;s something expected lik=
e chromium do_compile or something less expected like linux-yocto do_fetch =
when the premirror should already be populated). Printing this directly in =
knotty log file would very convenient for people who cannot just run htop o=
r similar on builder and tens extra lines in the log file doesn&#39;t seem =
too bad.</div><div><br></div><div>Regards,</div></div><br><div class=3D"gma=
il_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 21, 2022 at 6:0=
1 PM Ross Burton &lt;<a href=3D"mailto:ross@burtonini.com">ross@burtonini.c=
om</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">In interactive bitbake sessions it is obvious what tasks are running<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(t)<br>
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
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/89932958/3617=
156" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/89932958/3617156</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:Martin.Jansa@gmail.com" target=3D"=
_blank">Martin.Jansa@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--000000000000a2a15305dabdb66c--

