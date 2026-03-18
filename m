Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792F110854DC
	for <webhook@archiver.kernel.org>; Wed, 18 Mar 2026 09:36:53 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10283.1773826608186536355
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 18 Mar 2026 02:36:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=JHmi6yub;
 spf=pass (domain: gmail.com, ip: 209.85.218.45, mailfrom: quaresma.jose@gmail.com)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b8d7f22d405so880468566b.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 18 Mar 2026 02:36:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773826606; cv=none;
        d=google.com; s=arc-20240605;
        b=aePQDub0k26dWmfpiG/kDpWaillr72wgcex3tMC7RFpbmZGQT7nCq0JKzMZKNmRYnC
         Cnng0hrbzNhzTovATWpyw+yu3i+zkEw/OuS9K+Os2ZofumQEmQJbv4BVQrDNwsOE6W1T
         iQvu8uzxicjdexB6hpAXX4lcgI0KrY9DvWl/7KTpudh+++ZzZfgCE0W786JaGm3ByC8r
         41YnldMvW39xH/4jTEyI3OYHJ4OxYDfEtbppc2vZzS2F3PRw0oiYYJakeHdKphy6/0VE
         R8Iei4LNlJebwyCERaSJOFwY8DmvRPIcaqyFVLhzhzFoAkFr+fTxZpgCNZ6X1ru+0h+/
         xDKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NfCvLi6P/QnTnO3k6anGIpZO7fNnezhpzJTrj5aSEpU=;
        fh=/f5DFgojgmc3xmSn3U9XtQme7/5CyISuGk/hqhxUGKQ=;
        b=UsbCE7coOkbmc4+AWJWXyrJ1H9XlFrLACOUqfk1oD+lwzOt0G+8a0EDb+PK3NxOO4z
         OHjz8DL6ys8/YI/vdHGRrbH/ougN3CbA/f81BR/hdQ1/bhL9yCScg5a+FLFiovHZYif5
         n5/LeIpYb4g21DRwJash02EzwPiIfez2bdutdGo4+23gcItY/OsZ6fxaEuYEa0Btar9X
         k+dzfFfXD3ZCE10xpNm7FPIW5W8mEcNRLIIYYOzw2tPtSrJnTvjXfgV+kAXheBKyxoon
         8/kz/4Ch1uRtbdhso+8VqYbxkOP7YkN/bZaJZvlfKomHwNUqcyDhMZcP1UUt3V3UKKF4
         HDig==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773826606; x=1774431406; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NfCvLi6P/QnTnO3k6anGIpZO7fNnezhpzJTrj5aSEpU=;
        b=JHmi6yubcoU6rBsepm0jAawysPfnCVbhcizpCuEjX5KJJCsQph6Mr60Ps555XW1ws0
         4iJPDc6Xvo5FstVPYaj48V8ZP4Auqui6Tq9AXzDz8iyS2rdUGOgRwfcq3MwwZ6PDvm3u
         sivbTh4qGNv37KJTa4LbDuM58vVN5ejL8aDRniWCIk9SrUHVqaHw1C7MDrsU7RtXsjVs
         gs1td5NjXQTeIr58IwjWLC8o+Bp2uFjCQua/OJdnlh2ZmmEbD7DO0GPsaNw7EM5T3tQY
         v8+RQYtpqazh+pM+iJ2O8onssgs/pw66dFBisfFV/oHDDxXnNWPyOyg77uqwk93e+plY
         jxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773826606; x=1774431406;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NfCvLi6P/QnTnO3k6anGIpZO7fNnezhpzJTrj5aSEpU=;
        b=kXHYfpcnXQMm7Smr+phYadMuppid8OAZgAVExqQh8lvO3rBOn5XfZHa+gEN7oLvBM7
         1eyw1LSUiGFLwaiI/fnF0X5I/n9cJqs91GCcpV49MsTMffXJ7BP0mdxKdf3Jk2BXX+AH
         8glH2TKNadjMZNg4g7urLpvpiCv3rblzh6BFGZqdOhzF86IJomA8v0mWoc+3LB1uVRai
         5OlnH8Rt7EFdgWnCPUoCRJ6R1ZWTTQZELraeVE99wK5eh95ZX9IeUd6v6Y943wy4Aqo4
         EFIvTyb9PHwaffuF9echPpvDT/D3xkQa7OlF0xa4N68mJ8+8t+Qs3hScNAqcCYD/FfDS
         Nmmw==
X-Gm-Message-State: AOJu0YzqJnoFyO09r37naPOh3/PaUyqSdxVScUtdXeRlkprmvz7Mbc+T
	FN59DEgGZgh7P9oFIovCrS7EdXlCZKi6Cl4abqTpEKuy/5Ed2MFytpb7GTSEVDTWE7ebuWEOS1X
	vZFGrT5zrA0GX//0zG89zWoAfhvLLTvU=
X-Gm-Gg: ATEYQzwzTyiXaLG/iYqJnC0fSw8H6hrh7ioOAqkG2QqlQAy2jrTSmiEsMw7Nmqn3/p+
	Ccc+e6cMXItSPDVoWud45jZkbFyZMqMiwvOn3I5LdWKToY4ccE5j5e8NcW+cboeLyuEw73NVXVk
	vHJIj0L0TLImBMqg8SzT6psGJGs1cZyzdeR/iQ1zOl3NV5putq92Y2RVLBLtp09mhjJOGC7cQYn
	PUueDkWCV5Gr2/TgoUk+/G7ZqYGmclJXKVYmMwTW7Hl1t7OwVjgG0cz35XHYPC3I/BfRiKzUIpS
	+CAX8evrxQ==
X-Received: by 2002:a17:907:20e2:b0:b97:2a5:8a48 with SMTP id
 a640c23a62f3a-b97f4a84451mr138303566b.37.1773826606008; Wed, 18 Mar 2026
 02:36:46 -0700 (PDT)
MIME-Version: 1.0
References: <564bef12d9c423c71beccc5f2dfe9d50bf8ff8a2.1773815612.git.joerg.sommer@navimatix.de>
In-Reply-To: <564bef12d9c423c71beccc5f2dfe9d50bf8ff8a2.1773815612.git.joerg.sommer@navimatix.de>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Wed, 18 Mar 2026 09:36:28 +0000
X-Gm-Features: AaiRm52oSpH7gTVAvKAPZ3rVQTMOHyy_1N3F6udIUJZbTVvec38k0Afe05kB3NE
Message-ID: <CANPvuRkHkM6meK47ne6=RrX+YhTc=WhZTBJ2SCL8MkuskVRcdQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] data: Add exception details if
 build_dependencies catches one
To: joerg.sommer@navimatix.de
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000be8ebb064d4930b2"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 18 Mar 2026 09:36:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19166

--000000000000be8ebb064d4930b2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

J=C3=B6rg Sommer via lists.openembedded.org <joerg.sommer=3D
navimatix.de@lists.openembedded.org> escreveu (quarta, 18/03/2026 =C3=A0(s)
06:33):

> From: J=C3=B6rg Sommer <joerg.sommer@navimatix.de>
>
> Without this information, you'll only get messages like this, which don't
> indicate what might be wrong:
>
>     WARNING: =E2=80=A6.bb: Exception during build_dependencies for do_pat=
ch:00:17
>     WARNING: =E2=80=A6.bb: Error during finalise of =E2=80=A6.bb
>     ERROR: ParseError in None: Not all recipes parsed, parser thread
> killed/died? Exiting.
>     ERROR: Parsing halted due to errors, see error messages above
>
> Signed-off-by: J=C3=B6rg Sommer <joerg.sommer@navimatix.de>
> ---
>  lib/bb/data.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/bb/data.py b/lib/bb/data.py
> index 061e63386..2eb8e0aa6 100644
> --- a/lib/bb/data.py
> +++ b/lib/bb/data.py
> @@ -367,7 +367,7 @@ def build_dependencies(key, keys, mod_funcs,
> shelldeps, varflagsexcl, ignored_va
>      except bb.parse.SkipRecipe:
>          raise
>      except Exception as e:
> -        bb.warn("Exception during build_dependencies for %s" % key)
> +        bb.warn("Exception during build_dependencies for %s: %s" % (key,
> e))
>

It was better to use 'repr(e)' Instead of assuming that 'e' will always be
a string.

Jose


>          raise
>      return frozenset(deps), value
>      #bb.note("Variable %s references %s and calls %s" % (key, str(deps),
> str(execs)))
> --
> 2.53.0
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#19165):
> https://lists.openembedded.org/g/bitbake-devel/message/19165
> Mute This Topic: https://lists.openembedded.org/mt/118378834/5052612
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> quaresma.jose@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--=20
Best regards,

Jos=C3=A9 Quaresma

--000000000000be8ebb064d4930b2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">J=C3=B6rg Somme=
r via <a href=3D"http://lists.openembedded.org">lists.openembedded.org</a> =
&lt;joerg.sommer=3D<a href=3D"mailto:navimatix.de@lists.openembedded.org">n=
avimatix.de@lists.openembedded.org</a>&gt; escreveu (quarta, 18/03/2026 =C3=
=A0(s) 06:33):<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">F=
rom: J=C3=B6rg Sommer &lt;<a href=3D"mailto:joerg.sommer@navimatix.de" targ=
et=3D"_blank">joerg.sommer@navimatix.de</a>&gt;<br>
<br>
Without this information, you&#39;ll only get messages like this, which don=
&#39;t<br>
indicate what might be wrong:<br>
<br>
=C2=A0 =C2=A0 WARNING: =E2=80=A6.bb: Exception during build_dependencies fo=
r do_patch:00:17<br>
=C2=A0 =C2=A0 WARNING: =E2=80=A6.bb: Error during finalise of =E2=80=A6.bb<=
br>
=C2=A0 =C2=A0 ERROR: ParseError in None: Not all recipes parsed, parser thr=
ead killed/died? Exiting.<br>
=C2=A0 =C2=A0 ERROR: Parsing halted due to errors, see error messages above=
<br>
<br>
Signed-off-by: J=C3=B6rg Sommer &lt;<a href=3D"mailto:joerg.sommer@navimati=
x.de" target=3D"_blank">joerg.sommer@navimatix.de</a>&gt;<br>
---<br>
=C2=A0lib/bb/data.py | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/lib/bb/data.py b/lib/bb/data.py<br>
index 061e63386..2eb8e0aa6 100644<br>
--- a/lib/bb/data.py<br>
+++ b/lib/bb/data.py<br>
@@ -367,7 +367,7 @@ def build_dependencies(key, keys, mod_funcs, shelldeps,=
 varflagsexcl, ignored_va<br>
=C2=A0 =C2=A0 =C2=A0except bb.parse.SkipRecipe:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise<br>
=C2=A0 =C2=A0 =C2=A0except Exception as e:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.warn(&quot;Exception during build_dependenc=
ies for %s&quot; % key)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.warn(&quot;Exception during build_dependenc=
ies for %s: %s&quot; % (key, e))<br></blockquote><div><br></div><div>It was=
 better to use &#39;repr(e)&#39; Instead of assuming that &#39;e&#39; will =
always be a string.</div><div><br></div><div>Jose</div><div>=C2=A0</div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise<br>
=C2=A0 =C2=A0 =C2=A0return frozenset(deps), value<br>
=C2=A0 =C2=A0 =C2=A0#bb.note(&quot;Variable %s references %s and calls %s&q=
uot; % (key, str(deps), str(execs)))<br>
-- <br>
2.53.0<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#19165): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/19165" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/19165</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/118378834/505=
2612" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/118378834/5052612</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:quaresma.jose@gmail.com" target=3D=
"_blank">quaresma.jose@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr">Best regards,<div><br>Jos=C3=A9 Quaresma</div></=
div></div></div>

--000000000000be8ebb064d4930b2--

