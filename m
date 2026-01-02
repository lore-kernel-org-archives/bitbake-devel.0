Return-Path: <anibal@limonsoftware.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D01FC6165
	for <webhook@archiver.kernel.org>; Fri,  2 Jan 2026 23:09:51 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15813.1767395382486724606
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Jan 2026 15:09:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@limonsoftware-com.20230601.gappssmtp.com header.s=20230601 header.b=GuueBVzP;
 spf=pass (domain: limonsoftware.com, ip: 209.85.128.177, mailfrom: anibal@limonsoftware.com)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-78fdb90b670so78311087b3.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 02 Jan 2026 15:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=limonsoftware-com.20230601.gappssmtp.com; s=20230601; t=1767395381; x=1768000181; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GUkgl0sHXLOTVatG3c7iiYyMgMy7vpPUoNsOVXZaBO4=;
        b=GuueBVzPeQdpBDHguhmZZF4vjHm6XXp+MZEqFJUoa0sOQblqbChtZqzG5o93LlldgT
         Ewn7KaTqIsvP5rjkZK9oWI/4LUCNb8UEs71Gne6YRGalgcdvIqlVHFr1UuyTfx1HOHFy
         c7XBLGwoy1q6pQS3H194sqE3hR+2EFhthk0m0sFurT7RdzXC/if9kgu1IGerwaCXyIsc
         Apyl3m0yZgcocSEUC/0juiiTcl7QuY3qyzOxIDG7kqfhMc9zyQ78MXHlUVUMbOWv43iq
         yHCrKn/Ff0CjT+W9x9j0m1KIh0KohYh/Uky5AKuDnFuACosLULUgvK+NqLNxnTkDbWOK
         pt0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767395381; x=1768000181;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUkgl0sHXLOTVatG3c7iiYyMgMy7vpPUoNsOVXZaBO4=;
        b=ZhBWTR6J+zZ26H9VN4OioGpx67bJNihadhMA3pJDcbF7nODEj2uEHkqsVv7OXIWbbr
         +KcnDwD5nYoC7UgNCmJ76xgMVfWd7OHuNKachH1ThT4BU2WiC7S3pOL7GXsGUrvhPciu
         AHQ7IO4b1eJ7rsv9RjDUFFK4Mrgrf7taS8OC4Z2d/CVCqHpfN/7A1xg/EpVL1ySIJJzb
         J41GYgIiSFodE6loZq1IUMeV7f+hi/MlPVdZBjxTLK7z7KOrxBODrjPKCx1mfm5ZH6w9
         EQavvQYVcNxGxlY6LDXEajVGTizUELdofVaetpEs7qMhsBLPF6RpvvWpcUdSib+cy+DH
         N2uw==
X-Gm-Message-State: AOJu0YxT7Q73MiE5VeDmtfhZbsXj1hYxx5aM9cIM79jrOeAoVc96hz9N
	mHMDrDljOubeSCSgYNfNLEmvUweZ02hL9rqyTLwuusYw3LIyy0R0LKof+pRu5D5gQqb2dB5fv6m
	eWJZbPj+br7kZSZOj3S8yENUyRyfYIxbiJJLJQk39Lg==
X-Gm-Gg: AY/fxX4BaY6Tc3Y1dAylmGSeqpykXOnhZlxgoBw2vUJhjVPdL1HiKIx5ymU42hM5Hci
	b3LJNecjiTNwaSu8wbiZ5WWzfGClE+i7G0/FfnRhl9ptu1+JoObIGz0zMAGyqEqEJPvDy3JFPao
	wbUPMkP5Xph8kvHNuTMQ5bVrz0TKesowQY2aTkCeftO+dncn6uDTMg3lKvG+rmh/ztd70VsIOfh
	+QoOTFlN0M7eOlfaGRDgevv6H06lKHLJVJj2qcXYGta+WDpZrCbktwFW78T3Mo9pB/C1J8KhTQ9
	jUtTaPRqlNy7mRo9CbNDKZMPiRz6UY+R2GxbWdMLN59SYK+zD/z5NNr/zi0=
X-Google-Smtp-Source: AGHT+IGz1e4kiZQDZQw6t3krqw/CbaRjaMHZ+zBulki6uvWHnhJHKHW5lOIEGUaej/SgiBeYjEsdrK4Cgw7cgVRX3rc=
X-Received: by 2002:a05:690c:4d88:b0:787:ab13:eedd with SMTP id
 00721157ae682-78fb4131778mr329391497b3.40.1767395381571; Fri, 02 Jan 2026
 15:09:41 -0800 (PST)
MIME-Version: 1.0
References: <20260102193438.2960561-1-alex.kanavin@gmail.com> <20260102193438.2960561-8-alex.kanavin@gmail.com>
In-Reply-To: <20260102193438.2960561-8-alex.kanavin@gmail.com>
From: Anibal Limon <anibal@limonsoftware.com>
Date: Fri, 2 Jan 2026 17:09:30 -0600
X-Gm-Features: AQt7F2pZhl5XWP2AXqhNAH08n17UJQ6LP5wLmTuNkzSCYAGhkk1h-l1F60d9F8c
Message-ID: <CAOU5ZMssE3bAzH=o7CnL=7qyjPmX72R8AwLRJVQTCamSo=HmAQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 08/10] bitbake-setup: symlink json with
 fixed revisions into layers/
To: alex.kanavin@gmail.com
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: multipart/alternative; boundary="000000000000e5813b06476fcd7d"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 02 Jan 2026 23:09:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18683

--000000000000e5813b06476fcd7d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Just hit the case fixed by this commit,

...
  File "/workspaces/ls/bitbake/bin/bitbake-setup", line 121, in
_has_local_modifications
    fixed_revisions =3D json.load(open(os.path.join(layerdir,
"sources-fixed-revisions.json")))
FileNotFoundError: [Errno 2] No such file or directory:
'/workspaces/ls/bitbake-setup/ls-master/stm32-sdk-stm32h503/la
yers/sources-fixed-revisions.json
...

Thanks!,
Anibal

On Fri, Jan 2, 2026 at 1:34=E2=80=AFPM Alexander Kanavin via lists.openembe=
dded.org
<alex.kanavin=3Dgmail.com@lists.openembedded.org> wrote:

> From: Alexander Kanavin <alex@linutronix.de>
>
> This makes the file more visible for users, and allows easier
> checks of layers current content against what was checked out
> by bitbake-setup (to ensure local modifications aren't wiped out).
>
> Signed-off-by: Alexander Kanavin <alex@linutronix.de>
> ---
>  bin/bitbake-setup | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/bin/bitbake-setup b/bin/bitbake-setup
> index 0d33f0896..06255b112 100755
> --- a/bin/bitbake-setup
> +++ b/bin/bitbake-setup
> @@ -69,11 +69,15 @@ def write_upstream_config(config_dir, config_data):
>      with open(os.path.join(config_dir, "config-upstream.json"),'w') as s=
:
>          json.dump(config_data, s, sort_keys=3DTrue, indent=3D4)
>
> -def write_sources_fixed_revisions(config_dir, config_data):
> +def write_sources_fixed_revisions(config_dir, layer_dir, config_data):
> +    json_path =3D os.path.join(config_dir, "sources-fixed-revisions.json=
")
> +    json_link =3D os.path.join(layer_dir, "sources-fixed-revisions.json"=
)
>      sources =3D {}
>      sources['sources'] =3D config_data
>      with open(os.path.join(config_dir,
> "sources-fixed-revisions.json"),'w') as s:
>          json.dump(sources, s, sort_keys=3DTrue, indent=3D4)
> +    if not os.path.lexists(json_link):
> +        os.symlink(os.path.relpath(json_path ,layer_dir), json_link)
>
>  def commit_config(config_dir):
>      bb.process.run("git -C {} add .".format(config_dir))
> @@ -344,7 +348,7 @@ def update_build(config, confdir, setupdir, layerdir,
> d, update_bb_conf=3D"prompt"
>      bitbake_config =3D config["bitbake-config"]
>      thisdir =3D os.path.dirname(config["path"]) if config["type"] =3D=3D
> 'local' else None
>      setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir,
> update_bb_conf)
> -    write_sources_fixed_revisions(confdir, sources_fixed_revisions)
> +    write_sources_fixed_revisions(confdir, layerdir,
> sources_fixed_revisions)
>      commit_config(confdir)
>
>  def int_input(allowed_values, prompt=3D''):
> --
> 2.47.3
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18678):
> https://lists.openembedded.org/g/bitbake-devel/message/18678
> Mute This Topic: https://lists.openembedded.org/mt/117046548/8181911
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> anibal@limonsoftware.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000e5813b06476fcd7d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Just hit the case fixed by this commit,</div><div><br=
></div><div>...=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0</div><div>=C2=A0 File &quot;/=
workspaces/ls/bitbake/bin/bitbake-setup&quot;, line 121, in _has_local_modi=
fications =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>=
=C2=A0 =C2=A0 fixed_revisions =3D json.load(open(os.path.join(layerdir, &qu=
ot;sources-fixed-revisions.json&quot;)))=C2=A0 =C2=A0=C2=A0</div><div>FileN=
otFoundError: [Errno 2] No such file or directory: &#39;/workspaces/ls/bitb=
ake-setup/ls-master/stm32-sdk-stm32h503/la<br>yers/sources-fixed-revisions.=
json</div><div>...</div><div><br></div><div>Thanks!,</div><div>Anibal</div>=
</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Fri, Jan 2, 2026 at 1:34=E2=80=AFPM Alexander Kana=
vin via <a href=3D"http://lists.openembedded.org">lists.openembedded.org</a=
> &lt;alex.kanavin=3D<a href=3D"mailto:gmail.com@lists.openembedded.org">gm=
ail.com@lists.openembedded.org</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">From: Alexander Kanavin &lt;<a href=3D"mailto=
:alex@linutronix.de" target=3D"_blank">alex@linutronix.de</a>&gt;<br>
<br>
This makes the file more visible for users, and allows easier<br>
checks of layers current content against what was checked out<br>
by bitbake-setup (to ensure local modifications aren&#39;t wiped out).<br>
<br>
Signed-off-by: Alexander Kanavin &lt;<a href=3D"mailto:alex@linutronix.de" =
target=3D"_blank">alex@linutronix.de</a>&gt;<br>
---<br>
=C2=A0bin/bitbake-setup | 8 ++++++--<br>
=C2=A01 file changed, 6 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/bin/bitbake-setup b/bin/bitbake-setup<br>
index 0d33f0896..06255b112 100755<br>
--- a/bin/bitbake-setup<br>
+++ b/bin/bitbake-setup<br>
@@ -69,11 +69,15 @@ def write_upstream_config(config_dir, config_data):<br>
=C2=A0 =C2=A0 =C2=A0with open(os.path.join(config_dir, &quot;config-upstrea=
m.json&quot;),&#39;w&#39;) as s:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0json.dump(config_data, s, sort_keys=3DTru=
e, indent=3D4)<br>
<br>
-def write_sources_fixed_revisions(config_dir, config_data):<br>
+def write_sources_fixed_revisions(config_dir, layer_dir, config_data):<br>
+=C2=A0 =C2=A0 json_path =3D os.path.join(config_dir, &quot;sources-fixed-r=
evisions.json&quot;)<br>
+=C2=A0 =C2=A0 json_link =3D os.path.join(layer_dir, &quot;sources-fixed-re=
visions.json&quot;)<br>
=C2=A0 =C2=A0 =C2=A0sources =3D {}<br>
=C2=A0 =C2=A0 =C2=A0sources[&#39;sources&#39;] =3D config_data<br>
=C2=A0 =C2=A0 =C2=A0with open(os.path.join(config_dir, &quot;sources-fixed-=
revisions.json&quot;),&#39;w&#39;) as s:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0json.dump(sources, s, sort_keys=3DTrue, i=
ndent=3D4)<br>
+=C2=A0 =C2=A0 if not os.path.lexists(json_link):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 os.symlink(os.path.relpath(json_path ,layer_di=
r), json_link)<br>
<br>
=C2=A0def commit_config(config_dir):<br>
=C2=A0 =C2=A0 =C2=A0bb.process.run(&quot;git -C {} add .&quot;.format(confi=
g_dir))<br>
@@ -344,7 +348,7 @@ def update_build(config, confdir, setupdir, layerdir, d=
, update_bb_conf=3D&quot;prompt&quot;<br>
=C2=A0 =C2=A0 =C2=A0bitbake_config =3D config[&quot;bitbake-config&quot;]<b=
r>
=C2=A0 =C2=A0 =C2=A0thisdir =3D os.path.dirname(config[&quot;path&quot;]) i=
f config[&quot;type&quot;] =3D=3D &#39;local&#39; else None<br>
=C2=A0 =C2=A0 =C2=A0setup_bitbake_build(bitbake_config, layerdir, setupdir,=
 thisdir, update_bb_conf)<br>
-=C2=A0 =C2=A0 write_sources_fixed_revisions(confdir, sources_fixed_revisio=
ns)<br>
+=C2=A0 =C2=A0 write_sources_fixed_revisions(confdir, layerdir, sources_fix=
ed_revisions)<br>
=C2=A0 =C2=A0 =C2=A0commit_config(confdir)<br>
<br>
=C2=A0def int_input(allowed_values, prompt=3D&#39;&#39;):<br>
-- <br>
2.47.3<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#18678): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/18678" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/18678</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/117046548/818=
1911" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/117046548/8181911</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:anibal@limonsoftware.com" target=
=3D"_blank">anibal@limonsoftware.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--000000000000e5813b06476fcd7d--

