Return-Path: <sam@liddicott.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B711C47DDF
	for <webhook@archiver.kernel.org>; Thu,  1 Feb 2024 11:15:51 +0000 (UTC)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
 by mx.groups.io with SMTP id smtpd.web10.13134.1706786147677014676
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 01 Feb 2024 03:15:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@liddicott-com.20230601.gappssmtp.com header.s=20230601 header.b=lzwmXTqF;
 spf=none, err=SPF record not found (domain: liddicott.com, ip: 209.85.208.170, mailfrom: sam@liddicott.com)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2cf588c4dbcso10527911fa.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 01 Feb 2024 03:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=liddicott-com.20230601.gappssmtp.com; s=20230601; t=1706786146; x=1707390946; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8JpHQ9/pUz0/OCDhRjLdCFN8GHqtDhXw/U1dfX7XSjY=;
        b=lzwmXTqFZFFr4FtT5xZM4f+qT7rvkr7Gyi6lgN4qDjvGsqimQ61hI9AGVWc2SNhERI
         XtE6jChvoUBvmgSVyuEVTYJSsSB2NKsAXuEXX/VI9ZXR0tFi5ctHDWLDuLnGo14lSKi5
         X0AO4u48FuKVNH5udmnkbLl/SKum6az1XYdfACgoJHjyT78PBVTK/TY3WFFhsB+VVVoN
         o4WFIiU5nPRFRUcMu+t7qqDhUsry/2G1D3EgoIrjqXef2JnQoDBpZ100xlFplZinBx/R
         VLdqjS0sWuYRaYtHKeBctqUCH7Knlp32v+LX9eWiKhVpWo0yIa6ZIJNXjffiyGadip0p
         v9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706786146; x=1707390946;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8JpHQ9/pUz0/OCDhRjLdCFN8GHqtDhXw/U1dfX7XSjY=;
        b=q2tArWA29+Y2tGaPg86Rl8yqrdO7s7aW2KSTCZTujXvgBxJmH+XTZ0puBd0TjQ/59Y
         0q+bAtdUC9LiyL7QQCpkJNwIrw3Z+O356KKqx+8KIeEuaIOV3NWwOivRtmemm3n5H28q
         DTnjY6wacNUAO4q84rHuPMD1jFo/VS7UdTgVSwwjC7C+CfxIOeVpI+CoNF5O5S9VB8K+
         Jy4RDskttAnsk/i9jtoBteu9RQP+mkHi4XRLEtMVzlrLrrpLZFZ1E3KRfHozLNGlgpYb
         gVmCgLxzTn1BWGFPq8ieqqEriKaChtMDdc1abgbn6irV08KDr8DduJhPNXivqrAvaexA
         QWHA==
X-Gm-Message-State: AOJu0Yw9MiWU6NGxxq22d26en6E+9TIwgIJUhnfnToif+Rzjiig+BEoH
	sM2/YmLqQaIexZrWBxStcLM52n3czQZJBAF6oPve5YWGYOTojI4QNY2+DhUYen2jNuSFmi4Mk1E
	C8t8t7/TnwGDcRn/bfEzWnArhf3A7Ptxr1G7q
X-Google-Smtp-Source: AGHT+IHTMLgt+DWNTzq0bzt+26BiS1aFulEeBfAjkeh74PjH6zNbRwC5qh+34K+oU8qABiw/iPKNDfrqRm4M22BuNOk=
X-Received: by 2002:a2e:92c6:0:b0:2cf:56b:18c6 with SMTP id
 k6-20020a2e92c6000000b002cf056b18c6mr2913383ljh.50.1706786145221; Thu, 01 Feb
 2024 03:15:45 -0800 (PST)
MIME-Version: 1.0
References: <20240201033100.3617421-1-Qi.Chen@windriver.com> <20240201033100.3617421-3-Qi.Chen@windriver.com>
In-Reply-To: <20240201033100.3617421-3-Qi.Chen@windriver.com>
From: Sam Liddicott <sam@liddicott.com>
Date: Thu, 1 Feb 2024 11:15:08 +0000
Message-ID: <CAOj-5WBWkddTbtEXiHvKZvCjbxijaC244N07TwniJDM8ZR8ftw@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH 3/3] fetch2/git.py: add comment in try_premirrors
To: Qi.Chen@windriver.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000e4d7a30610501d2f"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 01 Feb 2024 11:15:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15819

--000000000000e4d7a30610501d2f
Content-Type: text/plain; charset="UTF-8"

This reminds me of a case while using a kirkstone branch, where a git
submodule was the same repo but a different branch as the parent module,
and the fetcher was not able to complete even without mirrors.

It was a go project where vendor modules were kept in a branch whose name
was vendor/ prefixed to the branch of the main project. This allowed the
module dependencies to be regulated (and not fetched during compile) while
still being associated with the project branch without tainting the project
branch or history - but it meant that the fetcher would hang.

Would these changes address that?

Sam

On Thu, 1 Feb 2024 at 03:31, Chen Qi via lists.openembedded.org <Qi.Chen=
windriver.com@lists.openembedded.org> wrote:

> From: Chen Qi <Qi.Chen@windriver.com>
>
> The purpose of ensuring 'incremental fetch' is not easy to see from
> the codes. So add comments to explain this.
>
> Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
> ---
>  bitbake/lib/bb/fetch2/git.py | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
> index 322a9366da..fa8c597ea2 100644
> --- a/bitbake/lib/bb/fetch2/git.py
> +++ b/bitbake/lib/bb/fetch2/git.py
> @@ -361,6 +361,11 @@ class Git(FetchMethod):
>          # we need to try premirrors first as using upstream is destined
> to fail.
>          if not trusted_network(d, ud.url):
>              return True
> +        # the following check is to ensure incremental fetch in
> downloads, this is
> +        # because the premirror might be old and does not contain the new
> rev required,
> +        # and this will cause a total removal and new clone. So if we can
> reach to
> +        # network, we prefer upstream over premirror, though the
> premirror might contain
> +        # the new rev.
>          if os.path.exists(ud.clonedir):
>              return False
>          return True
> --
> 2.42.0
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15818):
> https://lists.openembedded.org/g/bitbake-devel/message/15818
> Mute This Topic: https://lists.openembedded.org/mt/104090273/7497305
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> sam@liddicott.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

--000000000000e4d7a30610501d2f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">This reminds me of a case while using a kirkstone branch, =
where a git submodule was the same repo but a different branch as the paren=
t module, and the fetcher was not able to complete even without mirrors.<di=
v><div><br></div><div>It was a go project where vendor modules were kept in=
 a branch whose name was vendor/ prefixed to the branch of the main project=
. This allowed the module dependencies to be regulated (and not fetched dur=
ing compile) while still being associated with the project branch without t=
ainting the project branch or history - but it meant that the fetcher would=
 hang.</div></div><div><br></div><div>Would these changes address that?</di=
v><div><br></div><div>Sam</div></div><br><div class=3D"gmail_quote"><div di=
r=3D"ltr" class=3D"gmail_attr">On Thu, 1 Feb 2024 at 03:31, Chen Qi via <a =
href=3D"http://lists.openembedded.org">lists.openembedded.org</a> &lt;Qi.Ch=
en=3D<a href=3D"mailto:windriver.com@lists.openembedded.org">windriver.com@=
lists.openembedded.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">From: Chen Qi &lt;<a href=3D"mailto:Qi.Chen@windriver=
.com" target=3D"_blank">Qi.Chen@windriver.com</a>&gt;<br>
<br>
The purpose of ensuring &#39;incremental fetch&#39; is not easy to see from=
<br>
the codes. So add comments to explain this.<br>
<br>
Signed-off-by: Chen Qi &lt;<a href=3D"mailto:Qi.Chen@windriver.com" target=
=3D"_blank">Qi.Chen@windriver.com</a>&gt;<br>
---<br>
=C2=A0bitbake/lib/bb/fetch2/git.py | 5 +++++<br>
=C2=A01 file changed, 5 insertions(+)<br>
<br>
diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py<br=
>
index 322a9366da..fa8c597ea2 100644<br>
--- a/bitbake/lib/bb/fetch2/git.py<br>
+++ b/bitbake/lib/bb/fetch2/git.py<br>
@@ -361,6 +361,11 @@ class Git(FetchMethod):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# we need to try premirrors first as usin=
g upstream is destined to fail.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not trusted_network(d, ud.url):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return True<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # the following check is to ensure incremental=
 fetch in downloads, this is<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # because the premirror might be old and does =
not contain the new rev required,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # and this will cause a total removal and new =
clone. So if we can reach to<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # network, we prefer upstream over premirror, =
though the premirror might contain<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # the new rev.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if os.path.exists(ud.clonedir):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return False<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return True<br>
-- <br>
2.42.0<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#15818): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/15818" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/15818</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/104090273/749=
7305" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/104090273/7497305</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:sam@liddicott.com" target=3D"_blan=
k">sam@liddicott.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--000000000000e4d7a30610501d2f--

