Return-Path: <sam@liddicott.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACE0C5478C
	for <webhook@archiver.kernel.org>; Wed, 28 Feb 2024 22:56:58 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
 by mx.groups.io with SMTP id smtpd.web11.11397.1709161011919505256
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 28 Feb 2024 14:56:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@liddicott-com.20230601.gappssmtp.com header.s=20230601 header.b=Ehn8kMKi;
 spf=none, err=SPF record not found (domain: liddicott.com, ip: 209.85.218.46, mailfrom: sam@liddicott.com)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so54394066b.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 28 Feb 2024 14:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=liddicott-com.20230601.gappssmtp.com; s=20230601; t=1709161010; x=1709765810; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LMGhengoTVt606RfGrjanPv61epd/ADy/LX8L7zcyok=;
        b=Ehn8kMKi5bJ6J+zp4NtFX7GI32uTDJAy+Q6J1eUQ4o6+TdkRsLkg9G82F/VYPVuON6
         HFRxGANAitoQSBh+uUCrbXOkypWITx8/+8cp6vmEaBiiQeJpQXtvhhcOPagFWUJE/kba
         aVvjJ/5lUx2mbJnLao756D6en4N+1Q30FfgXbZ/wkmWBQV0FJxhFmTWfCbsymTbrKOrY
         9NthKRpnKSqIYGnaJaod2FGQxaZDUwVSeTvcH/IvFgoSKRapXBfIz7/76VZFlFXLIxsE
         yG270VPylCXB9BjDLVvagOpcZg9cT6DGNfmf0+/jXQvIDcxSpwhcX4reS5mR7VSfD4dj
         vAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709161010; x=1709765810;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LMGhengoTVt606RfGrjanPv61epd/ADy/LX8L7zcyok=;
        b=pklb6t28bcfjFlpVotypfqgxKq5mqMl9YBk1rGXZ3z0P/5g6f3BCixMJekaHiiWBr2
         3MHFf2hY+aTAS6mGrD3YHgK9tBXjvfoFC4bjpbheVAIUsftXuuDDDtQlZe7IpH5/6YLw
         AfrZU3gPIAhJDmHFkWdjE8X4GKy/wSQLf8Eb4EE+NWen8dwGKUjlgq34fmbv1kPcEeH3
         C3sDOH7U7DzKjrMrV590aPGXS9oOl0GiaGhNmg+pyRSrSwJghv1wMLnd3kpUQjxJmBPS
         faZ2ecCDI22uR1pnMSvumcGLGsZ/jXPaNWjd0seILOKAMdWrTQbbi9Ta8L4Do8jbnfVV
         d8cA==
X-Gm-Message-State: AOJu0Yy3UieXT8SOXvsowegQevJgddiKpacJSVQfwjMYolqiX8RcvXSL
	HyvA1VbpMwrEQdXEBfpKrHAeugmQJRG9BVu1XxxZ/WNxMyMlX3Lak0lVkTwuvrC20IQmLyiq+TS
	mpb38W4wuLl6ntlgJqPGzuGN8vkgTNJzgfEgQ
X-Google-Smtp-Source: AGHT+IHbVGI4ZGtfayKzWW0NcZHenNIax4ljveYKBizSvZ8ECgPqDlsE6h46SiOQAx/vkuAl4I3y8bMluyPNrPiR7Ys=
X-Received: by 2002:a17:906:3e0d:b0:a3f:4eaf:ec66 with SMTP id
 k13-20020a1709063e0d00b00a3f4eafec66mr200575eji.25.1709161010042; Wed, 28 Feb
 2024 14:56:50 -0800 (PST)
MIME-Version: 1.0
References: <17B810A24531435C.23432@lists.openembedded.org>
In-Reply-To: <17B810A24531435C.23432@lists.openembedded.org>
From: Sam Liddicott <sam@liddicott.com>
Date: Wed, 28 Feb 2024 22:56:38 +0000
Message-ID: <CAOj-5WAohNpyHRFFWbBkm2CWnFnfzAit4Kxm2=9WsbKcSPeb+Q@mail.gmail.com>
Subject: Re: [bitbake-devel] pseudo abort with req '/proc/self/fd/3'
To: Sam Liddicott <sam@liddicott.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000de320a0612790e26"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 28 Feb 2024 22:56:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15978

--000000000000de320a0612790e26
Content-Type: text/plain; charset="UTF-8"

Despite my hints I don't think it is safe to use dev_t as part of the key
because I don't think it is guaranteed to be consistent across reboots or
even remounts for the case where temporary file system mounts (e.g.
overlayfs) might be in use for the build workspace or subdirs.

(I am using bind mounting in a mount namespace during bitbake to make sure
all workspaces appear as the same path in order to get better caching of
sstate artifacts compile and install steps).

So maybe we want to limit pseudo caching only to the workdir filesystem by
default, but certainly exclude /proc /dev etc

Sam

On Wed, 28 Feb 2024, 15:32 Sam Liddicott via lists.openembedded.org, <sam=
liddicott.com@lists.openembedded.org> wrote:

> On a kirkstone build I just got an unexpected and reproducible do_install
> abort:
>
> | abort()ing pseudo client by server request. See
> https://wiki.yoctoproject.org/wiki/Pseudo_Abort for more details on this.
> ... path mismatch [1 link]: ino 594677 db '/.../common/config/private' req
> '/proc/self/fd/3'
> A conflict with /proc is most surprising, why is that even in the pseudo
> database?
>
> Adding this line to the global config fixed it consistently:
> PSEUDO_IGNORE_PATHS:append=",/proc,/dev,/sys"
>
> But I wondered how there was a conflict, and then I looked again at the
> abort message.
>
> Is it possible that pseudo only uses inode number without the dev node as
> the key?
>
>            struct stat {
>                dev_t     st_dev;         /* ID of device containing file */
>                ino_t     st_ino;         /* Inode number */
>
> I would think that only the combination of both is unique across the
> system.
>
> If dev_t is not part of the key, then I suggest that all paths are ignored
> that are not on the same dev_t as the workspace.
>
> Sam
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15975):
> https://lists.openembedded.org/g/bitbake-devel/message/15975
> Mute This Topic: https://lists.openembedded.org/mt/104624826/7497305
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> sam@liddicott.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

--000000000000de320a0612790e26
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Despite my hints I don&#39;t think it is safe to use=
 dev_t as part of the key because I don&#39;t think it is guaranteed to be =
consistent across reboots or even remounts for the case where temporary fil=
e system mounts (e.g. overlayfs) might be in use for the build workspace or=
 subdirs.</div><div dir=3D"auto"><br></div><div dir=3D"auto">(I am using bi=
nd mounting in a mount namespace during bitbake to make sure all workspaces=
 appear as the same path in order to get better caching of sstate artifacts=
 compile and install steps).</div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">So maybe we want to limit pseudo caching only to the workdir filesyste=
m by default, but certainly exclude /proc /dev etc</div><div dir=3D"auto"><=
br></div><div dir=3D"auto">Sam<br><br><div class=3D"gmail_quote" dir=3D"aut=
o"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, 28 Feb 2024, 15:32 Sam Lid=
dicott via <a href=3D"http://lists.openembedded.org">lists.openembedded.org=
</a>, &lt;sam=3D<a href=3D"mailto:liddicott.com@lists.openembedded.org">lid=
dicott.com@lists.openembedded.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><div dir=3D"ltr">On a kirkstone build I just got an unexpecte=
d and reproducible do_install abort:<div><br></div><div><code style=3D"font=
-family:SFMono-Medium,&quot;SF Mono&quot;,&quot;Segoe UI Mono&quot;,&quot;R=
oboto Mono&quot;,&quot;Ubuntu Mono&quot;,Menlo,Consolas,Courier,monospace;f=
ont-size:0.875em;color:rgb(23,43,77);border-style:none;display:inline;paddi=
ng:2px 0.5ch 2px 0.5ch;overflow:auto;background-image:initial;background-po=
sition:initial;background-size:initial;background-repeat:initial;background=
-origin:initial;background-clip:initial;line-height:1.33333;letter-spacing:=
-0.07px">| abort()ing pseudo client by server request. See <a href=3D"https=
://wiki.yoctoproject.org/wiki/Pseudo_Abort" target=3D"_blank" rel=3D"norefe=
rrer">https://wiki.yoctoproject.org/wiki/Pseudo_Abort</a> for more details =
on this.
...
path mismatch [1 link]: ino 594677 db &#39;/.../common/config/private&#39; =
req &#39;/proc/self/fd/3&#39;

</code><div>A conflict=C2=A0with=C2=A0/proc is most surprising, why is that=
 even in the pseudo database?</div></div><div><br></div><div>Adding this li=
ne to the global config fixed it consistently:</div><div>PSEUDO_IGNORE_PATH=
S:append=3D&quot;,/proc,/dev,/sys&quot;<br></div><div><br></div><div>But I =
wondered how there was a conflict, and then I looked again at the abort mes=
sage.</div><div><br></div><div>Is it possible that pseudo only uses inode n=
umber without the dev node as the key?</div><div><br></div><div>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct stat {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_t =C2=A0 =C2=A0 st_dev; =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* ID of device containing file */<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ino_t =C2=A0 =C2=A0 st_ino; =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 /* Inode number */<br></div><div><br></div><div>I would think=
 that only the combination of both is unique across the system.</div><div><=
br></div><div>If dev_t is not part of the key, then I suggest that all path=
s are ignored that are not on the same dev_t as the workspace.</div><div><b=
r></div><div>Sam</div></div>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#15975): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/15975" rel=3D"noreferrer noreferrer" target=3D"_blank">h=
ttps://lists.openembedded.org/g/bitbake-devel/message/15975</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/104624826/749=
7305" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lists.openemb=
edded.org/mt/104624826/7497305</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank" rel=3D"noreferrer">bitbake-devel+owner@lists.openembedd=
ed.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lists.openembedd=
ed.org/g/bitbake-devel/unsub</a> [<a href=3D"mailto:sam@liddicott.com" targ=
et=3D"_blank" rel=3D"noreferrer">sam@liddicott.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div></div>

--000000000000de320a0612790e26--

