Return-Path: <kergoth@gmail.com>
Received: from mail-oi0-f53.google.com (mail-oi0-f53.google.com
	[209.85.218.53])
	by mail.openembedded.org (Postfix) with ESMTP id 5B951771B8
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 29 Aug 2018 13:44:46 +0000 (UTC)
Received: by mail-oi0-f53.google.com with SMTP id t68-v6so9147470oie.12
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 29 Aug 2018 06:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=hGzmzTp8+UZv4NvIt5mBDI8KnXTYxm4vEjzzsNP4p7I=;
	b=AJDcElhRT++g9zH1ZqtIWsKClraQMvv2AgOe5sNdQOBx34jPf+diyG1f8XET2umve0
	sCgoVKpaFzRN/FepptcxFLTv2s8GFFuKsgCWT7sNJq34e/O3fcCdaAtTtOU23d0WshhG
	J/zZjtUCVZLoxeT1zsX4OHVctPzxwpXnll45xdObF9fzTAiy1qJzfvZUa30R7EkiSMhJ
	ViGzPbV5w7/1VLydA/zXqwDK3/XH8z0DvoNzQCdBGBBSlDkV7IJ84Mh5kHSuT3RDnpsI
	+ZL2wsSNhGbSChYTBofMFVbuj228SExqxCuij+Kq9Zedxon+zYVR/1+l2DBsIyUnHJN0
	s5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=hGzmzTp8+UZv4NvIt5mBDI8KnXTYxm4vEjzzsNP4p7I=;
	b=Y0IALRyvtZH6teebOqCAGSsomoGZcGhGDC/rFDqK6HK5EEeFcAyy1rkUeAxjfjzlMf
	OpU2RThEaqkf1pZq4qxdunz1i+GhkSRQjvMFRTiWcAzzydIjOcW1STlhYG7PM7lgC+3Q
	W3gQnIwZD61cgOdkyLHqw3VSP4NorPDJqASfHzRwHZRJ3VwRrHghjon2ERyhcCg4E6qn
	bL1JoB1sZf5vyECn8GFoEgTgIDy3XAAp/r+/aCKqHtmdZUHnVFkvMNcKaytQmVvM0mcZ
	mGvalCoLOylP3r73UbmuueTVHDHh7jMfr9YjfDLo1zKS38WtwqiwqDxZ/0HUEM2+3SV6
	GtIw==
X-Gm-Message-State: APzg51AD+RA2XEPuXNfFZPVxbDNdqTHdbstk4O5c0UaY5LHDkl4gnLtF
	KtAUUybgc4vj8LIHPTAosu2Q+Y/FQr5L5afaNOo=
X-Google-Smtp-Source: ANB0VdZnIm+dwye+XsCxnRqIb5GYX4RECQbxPwky3NaYz+LcqkSwTgRIAaRgfb8y9R5GXT7QrZzLnmbI2sG+4HEuWZc=
X-Received: by 2002:aca:bdc4:: with SMTP id
	n187-v6mr2641673oif.3.1535550287249; 
	Wed, 29 Aug 2018 06:44:47 -0700 (PDT)
MIME-Version: 1.0
References: <1535398739-17159-1-git-send-email-ptsneves@gmail.com>
In-Reply-To: <1535398739-17159-1-git-send-email-ptsneves@gmail.com>
From: Christopher Larson <kergoth@gmail.com>
Date: Wed, 29 Aug 2018 06:44:34 -0700
Message-ID: <CABcZANmpqFtGm3s6ULcFgz8kTo1YjB259FaN1exExnnGAK8+Gw@mail.gmail.com>
To: ptsneves@gmail.com
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] fetcher: Fixed remote removal not throwing exception.
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 29 Aug 2018 13:44:46 -0000
Content-Type: multipart/alternative; boundary="0000000000006809de05749329ce"

--0000000000006809de05749329ce
Content-Type: text/plain; charset="UTF-8"

This will try to rm origin even if there's an 'originfoo' remote, as you
don't check for an exact match on a line, but a general substring search.
Unlikely, I admit, but we should still work as correctly as possible, I
think.

On Mon, Aug 27, 2018 at 12:39 PM Paulo Neves <ptsneves@gmail.com> wrote:

> Before this fix it is assumed that the removal of the
> remote can only fail because there is not remote to remove. This
> is a false assumption. Example error which would be ignored:
>
> git -c core.fsyncobjectfiles=0 remote rm origin failed with exit code 1,
> output:
> Note: A branch outside the refs/remotes/ hierarchy was not removed;
> to delete it, use:
>   git branch -d master
> error: could not lock config file config
> error: Could not remove config section 'remote.origin'
>
> Due to the masking of this error a stranger error will be
> presented to the user, because this time we do not mask the
> exception:
>
> git -c core.fsyncobjectfiles=0 remote add --mirror=fetch origin
> https://github.com/ptsneves/tl-wn722.git failed with exit code 128,
> output:
> fatal: remote origin already exists.
>
> The most likely reason that the remote cannot be removed nor
> modified is that the DL_DIR/git2 does not have permissions
> compatible with the user running bitbake.
>
> This commit fixes:
> https://bugzilla.yoctoproject.org/show_bug.cgi?id=12728
>
> Signed-off-by: Paulo Neves <ptsneves@gmail.com>
> ---
>  bitbake/lib/bb/fetch2/git.py | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
> index 612aac4..35da14d 100644
> --- a/bitbake/lib/bb/fetch2/git.py
> +++ b/bitbake/lib/bb/fetch2/git.py
> @@ -353,10 +353,9 @@ class Git(FetchMethod):
>                  break
>
>          if needupdate:
> -            try:
> -                runfetchcmd("%s remote rm origin" % ud.basecmd, d,
> workdir=ud.clonedir)
> -            except bb.fetch2.FetchError:
> -                logger.debug(1, "No Origin")
> +            output = runfetchcmd("%s remote" % ud.basecmd, d, quiet=True,
> workdir=ud.clonedir)
> +            if "origin" in output:
> +              runfetchcmd("%s remote rm origin" % ud.basecmd, d,
> workdir=ud.clonedir)
>
>              runfetchcmd("%s remote add --mirror=fetch origin %s" %
> (ud.basecmd, repourl), d, workdir=ud.clonedir)
>              fetch_cmd = "LANG=C %s fetch -f --prune --progress %s
> refs/*:refs/*" % (ud.basecmd, repourl)
> --
> 2.7.4
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>


-- 
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Senior Software Engineer, Mentor Graphics

--0000000000006809de05749329ce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">This will try to rm origin even if there&#39;s an &#39;ori=
ginfoo&#39; remote, as you don&#39;t check for an exact match on a line, bu=
t a general substring search. Unlikely, I admit, but we should still work a=
s correctly as possible, I think.<br></div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr">On Mon, Aug 27, 2018 at 12:39 PM Paulo Neves &lt;<a href=3D=
"mailto:ptsneves@gmail.com">ptsneves@gmail.com</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">Before this fix it is assumed that the removal o=
f the<br>
remote can only fail because there is not remote to remove. This<br>
is a false assumption. Example error which would be ignored:<br>
<br>
git -c core.fsyncobjectfiles=3D0 remote rm origin failed with exit code 1, =
output:<br>
Note: A branch outside the refs/remotes/ hierarchy was not removed;<br>
to delete it, use:<br>
=C2=A0 git branch -d master<br>
error: could not lock config file config<br>
error: Could not remove config section &#39;remote.origin&#39;<br>
<br>
Due to the masking of this error a stranger error will be<br>
presented to the user, because this time we do not mask the<br>
exception:<br>
<br>
git -c core.fsyncobjectfiles=3D0 remote add --mirror=3Dfetch origin <a href=
=3D"https://github.com/ptsneves/tl-wn722.git" rel=3D"noreferrer" target=3D"=
_blank">https://github.com/ptsneves/tl-wn722.git</a> failed with exit code =
128, output:<br>
fatal: remote origin already exists.<br>
<br>
The most likely reason that the remote cannot be removed nor<br>
modified is that the DL_DIR/git2 does not have permissions<br>
compatible with the user running bitbake.<br>
<br>
This commit fixes:<br>
<a href=3D"https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D12728" rel=
=3D"noreferrer" target=3D"_blank">https://bugzilla.yoctoproject.org/show_bu=
g.cgi?id=3D12728</a><br>
<br>
Signed-off-by: Paulo Neves &lt;<a href=3D"mailto:ptsneves@gmail.com" target=
=3D"_blank">ptsneves@gmail.com</a>&gt;<br>
---<br>
=C2=A0bitbake/lib/bb/fetch2/git.py | 7 +++----<br>
=C2=A01 file changed, 3 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py<br=
>
index 612aac4..35da14d 100644<br>
--- a/bitbake/lib/bb/fetch2/git.py<br>
+++ b/bitbake/lib/bb/fetch2/git.py<br>
@@ -353,10 +353,9 @@ class Git(FetchMethod):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if needupdate:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try: <br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(&quot;=
%s remote rm origin&quot; % ud.basecmd, d, workdir=3Dud.clonedir)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 except bb.fetch2.FetchError:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 logger.debug(1, &q=
uot;No Origin&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 output =3D runfetchcmd(&quot;%s =
remote&quot; % ud.basecmd, d, quiet=3DTrue, workdir=3Dud.clonedir)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;origin&quot; in output:=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(&quot;%s remo=
te rm origin&quot; % ud.basecmd, d, workdir=3Dud.clonedir)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0runfetchcmd(&quot;%s remote=
 add --mirror=3Dfetch origin %s&quot; % (ud.basecmd, repourl), d, workdir=
=3Dud.clonedir)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fetch_cmd =3D &quot;LANG=3D=
C %s fetch -f --prune --progress %s refs/*:refs/*&quot; % (ud.basecmd, repo=
url)<br>
-- <br>
2.7.4<br>
<br>
-- <br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_blank">b=
itbake-devel@lists.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/mailman/li=
stinfo/bitbake-devel</a><br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div><d=
iv dir=3D"ltr">Christopher Larson<br>kergoth at gmail dot com<br>Founder - =
BitBake, OpenEmbedded, OpenZaurus<br>Senior Software Engineer, Mentor Graph=
ics</div></div></div></div>

--0000000000006809de05749329ce--
