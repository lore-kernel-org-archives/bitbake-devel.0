Return-Path: <matt.hoosier@gmail.com>
Received: from mail-yb0-f170.google.com (mail-yb0-f170.google.com
	[209.85.213.170])
	by mail.openembedded.org (Postfix) with ESMTP id 3CC4C7841B
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 May 2018 19:33:11 +0000 (UTC)
Received: by mail-yb0-f170.google.com with SMTP id w14-v6so2194464ybm.5
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 May 2018 12:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to; 
	bh=t14sHdqUlfyFnvd3PXgPPuZ/p86bQ0sJGAvo4pNSQA0=;
	b=pnAHktSiyCeYyQZWedrfT8JCPkDzgYPId7jRGG5x7K/jMlxjWUtsemCxE01M1QJ3eb
	qsXuyqCTwaGySNfGx8vp6XfiAVzLhQdVFQBXzQkL3f7FXjGVklN/6fp21o3mlY8WQVN0
	3mjhGEQE07bRxAaO5JhrIvYesq/rXfC4PQ4hu7Bi+KB8U6mPTAVQzpIwMYGWv5B57qiC
	hjmvlB8Ur33aVOxt66ZKDBBYMzGQu4zS4eFQLuLgAFDzrlb/r/K24Q+zNQYWjt4oDjCt
	9Lkj9F/IKRNGKEGIBasaUkjk3wJK01rdczLwVZKYktstyS0fl/aefd7uEjsy5hOo9RKi
	RRKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to;
	bh=t14sHdqUlfyFnvd3PXgPPuZ/p86bQ0sJGAvo4pNSQA0=;
	b=M3AWP+BvA0KneEt9suumOMnLYYfB0vZlDgJ8205i8HPfnEEBoycVd/zOGDW2KaVhNC
	gNq+/xWBa1jJcEGDuW+OExSt3AmrTCYTgMhBPFddwGNsdefyjsKUUp0LHZY44tedB5+F
	X5Iv8NmauvAg5Qmv137EJ3hcb+GhSCpiyy/N0kVPnz28Z4L64JRde4X+UZUiTPnZzXWj
	WjhSbyDpM/cz/waZNePH9/QMA0JLeNCbOLYhCwtkmHmwSOpz+1SRbhGNSnNfa4M6Loiq
	1qRiGiFjSD9o3m+wrKZ8SxxiuywsMWYSV45kfU7m9EfKB/rb57wNdIhwFHBWW3vCzhNF
	b2NQ==
X-Gm-Message-State: ALKqPwcBTOFnymohaAUKFo1WqIlvWuRxLUOFMELrKXW1r9s3+gl78nQi
	boBcZKsfmce95fAVny8+er/cOFuuUca6w+dY0ePZiwJl
X-Google-Smtp-Source: AB8JxZoCkdHfavPAm73G9RgNYwxybK2/hfoyZn38DIReeiRgTKFKTtTCq9ec8ZaD5lEpWDltOfYeimUREKwUss6+kKM=
X-Received: by 2002:a25:b3cc:: with SMTP id
	x12-v6mr1868182ybf.181.1526067192648; 
	Fri, 11 May 2018 12:33:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:748c:0:0:0:0:0 with HTTP; Fri, 11 May 2018 12:32:32
	-0700 (PDT)
In-Reply-To: <20180511135346.3476-1-matt.hoosier@gmail.com>
References: <20180511135346.3476-1-matt.hoosier@gmail.com>
From: Matt Hoosier <matt.hoosier@gmail.com>
Date: Fri, 11 May 2018 14:32:32 -0500
Message-ID: <CAJgxT3_2V4R=qz2fOGVUJs=yWHSLbC=paP3ztXdSy21J_f4MFQ@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] fetch/gitsm: avoid live submodule fetching during unpack()
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
X-List-Received-Date: Fri, 11 May 2018 19:33:12 -0000
Content-Type: multipart/alternative; boundary="000000000000ebdc47056bf33436"

--000000000000ebdc47056bf33436
Content-Type: text/plain; charset="UTF-8"

I had a snafu when prepping the submission of this revision. Ignore it;
I've submitted rev3 now:
http://lists.openembedded.org/pipermail/bitbake-devel/2018-May/009325.html.

On Fri, May 11, 2018 at 8:53 AM, Matt Hoosier <matt.hoosier@gmail.com>
wrote:

> Although the submodules' histories have been fetched during the
> do_fetch() phase, the mechanics used to clone the workdir copy
> of the repo haven't been transferring the actual .git/modules
> directory from the repo fetched into downloads/ during the
> fetch task.
>
> Fix that, and for good measure also explicitly tell Git to avoid
> hitting the network during do_unpack() of the submodules.
>
> Rev2 changes:
>
> - Fixed a failure when unpacking a shallow cloned mirror repository.
>
> [YOCTO #12739]
>
> Signed-off-by: Matt Hoosier <matt.hoosier@gmail.com>
> ---
>  lib/bb/fetch2/gitsm.py | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
> index 0aff1008..1f3fc443 100644
> --- a/lib/bb/fetch2/gitsm.py
> +++ b/lib/bb/fetch2/gitsm.py
> @@ -132,4 +132,14 @@ class GitSM(Git):
>
>          if self.uses_submodules(ud, d, ud.destdir):
>              runfetchcmd(ud.basecmd + " checkout " +
> ud.revisions[ud.names[0]], d, workdir=ud.destdir)
> -            runfetchcmd(ud.basecmd + " submodule update --init
> --recursive", d, workdir=ud.destdir)
> +
> +            # Copy over the submodules' fetched histories too.
> +            if ud.bareclone:
> +                repo_conf = ud.destdir
> +            else:
> +                repo_conf = os.path.join(ud.destdir, '.git')
> +            runfetchcmd("cp -pr %s %s" % (os.path.join(ud.clonedir,
> 'modules'), repo_conf), d)
> +
> +            # Careful not to hit the network during unpacking; all
> history should already
> +            # be fetched.
> +            runfetchcmd(ud.basecmd + " submodule update --init
> --recursive --no-fetch", d, workdir=ud.destdir)
> --
> 2.13.6
>
>

--000000000000ebdc47056bf33436
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I had a snafu when prepping the submission of this revisio=
n. Ignore it; I&#39;ve submitted rev3 now:=C2=A0<a href=3D"http://lists.ope=
nembedded.org/pipermail/bitbake-devel/2018-May/009325.html">http://lists.op=
enembedded.org/pipermail/bitbake-devel/2018-May/009325.html</a>.</div><div =
class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Fri, May 11, 2018 a=
t 8:53 AM, Matt Hoosier <span dir=3D"ltr">&lt;<a href=3D"mailto:matt.hoosie=
r@gmail.com" target=3D"_blank">matt.hoosier@gmail.com</a>&gt;</span> wrote:=
<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">Although the submodules&#39; histories h=
ave been fetched during the<br>
do_fetch() phase, the mechanics used to clone the workdir copy<br>
of the repo haven&#39;t been transferring the actual .git/modules<br>
directory from the repo fetched into downloads/ during the<br>
fetch task.<br>
<br>
Fix that, and for good measure also explicitly tell Git to avoid<br>
hitting the network during do_unpack() of the submodules.<br>
<br>
Rev2 changes:<br>
<br>
- Fixed a failure when unpacking a shallow cloned mirror repository.<br>
<br>
[YOCTO #12739]<br>
<br>
Signed-off-by: Matt Hoosier &lt;<a href=3D"mailto:matt.hoosier@gmail.com">m=
att.hoosier@gmail.com</a>&gt;<br>
---<br>
=C2=A0lib/bb/fetch2/gitsm.py | 12 +++++++++++-<br>
=C2=A01 file changed, 11 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py<br>
index 0aff1008..1f3fc443 100644<br>
--- a/lib/bb/fetch2/gitsm.py<br>
+++ b/lib/bb/fetch2/gitsm.py<br>
@@ -132,4 +132,14 @@ class GitSM(Git):<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.uses_submodules(ud, d, ud.destdir=
):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0runfetchcmd(ud.basecmd + &q=
uot; checkout &quot; + ud.revisions[ud.names[0]], d, workdir=3Dud.destdir)<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(ud.basecmd + &quot; =
submodule update --init --recursive&quot;, d, workdir=3Dud.destdir)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Copy over the submodules&#39; =
fetched histories too.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ud.bareclone:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 repo_conf =3D ud.d=
estdir<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 repo_conf =3D os.p=
ath.join(ud.destdir, &#39;.git&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(&quot;cp -pr %s %s&q=
uot; % (os.path.join(ud.clonedir, &#39;modules&#39;), repo_conf), d)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Careful not to hit the network=
 during unpacking; all history should already<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # be fetched.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(ud.basecmd + &quot; =
submodule update --init --recursive --no-fetch&quot;, d, workdir=3Dud.destd=
ir)<br>
<span class=3D"HOEnZb"><font color=3D"#888888">-- <br>
2.13.6<br>
<br>
</font></span></blockquote></div><br></div>

--000000000000ebdc47056bf33436--
