Return-Path: <kergoth@gmail.com>
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com
	[209.85.218.67])
	by mail.openembedded.org (Postfix) with ESMTP id 2520B65CBF
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2016 16:20:22 +0000 (UTC)
Received: by mail-oi0-f67.google.com with SMTP id w11so7227533oia.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2016 09:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=K2tAPpI6qdWZvDULMp0hjTRRv8n/BmKAA+4ZdOCyFMU=;
	b=JmmEMjRnVmLreWvU1MoHGcFxVo7QY9JBCfntKXZ/ncwcAHdGM74MxcjR5CeO0FAa+I
	WGeP9MLJ/S6QW/usV8zoizku7xLG81TZxZv37b3W7HedRkoIxhZLurSZd83d2JdP/zPV
	U+wsK7mR6TfC9zFs40MRAlgrbdCE8xgWN7DjeeGwoGoeEFq/6hoLnoWF1rZn2p4rrjzm
	WlkpL0fgB4z5nUQwH8LO/ORpb6qBMwr24ZI5KdPZA+q6IwtovvozLznP5z3dj3WpWvH3
	4IA1+wmzRu0yyRkxNJVXjn59kozcc/KGznkB5HyJp5Yd5fVCkYecJ4Ysfa7gxRs1/jv5
	ROyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=K2tAPpI6qdWZvDULMp0hjTRRv8n/BmKAA+4ZdOCyFMU=;
	b=UxhIe2HZgGxbpXvRlruaR/rgu/GNaVMkO/9MYvXYkhZZxqBBM7KupqvvJNAeS4fCAC
	5M+nFPo8qHY9fdNIbBO2ffRpO9MDrSTsjws7MuaSV6x6TSS8NmZwuYBmHixDdW9iOWQF
	cl/k8wXGbi1m5VuvbdrKj/LRcB+gui2csdBetRY9J5QZoCC/3bIwU8eARZNMB0YCaKWM
	t7PEFg1YrjNUjbW9x265uBg1pckWKfOQKThWaOFn7UMQdZm7G/oyggqiW7QewPqG2nlp
	UZcrl+vCQoEdSbMsq9I+C0MtJju3uEGNywPqnncejav7eHTc4uP/QEU/q3gGiifIpewV
	3AMA==
X-Gm-Message-State: AE9vXwN91mQj8epabWsAy5mzcGKQX2HR/9G0uib/aDhnc06MmIVu79xWyV6TzfgbpodBZmk3AxYgjCwn60H6uw==
X-Received: by 10.157.16.82 with SMTP id o18mr6973448oto.111.1474042823127;
	Fri, 16 Sep 2016 09:20:23 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.157.13.194 with HTTP; Fri, 16 Sep 2016 09:20:01 -0700 (PDT)
In-Reply-To: <1474016293-26538-1-git-send-email-pascal.bach@siemens.com>
References: <1474016293-26538-1-git-send-email-pascal.bach@siemens.com>
From: Christopher Larson <clarson@kergoth.com>
Date: Fri, 16 Sep 2016 09:20:01 -0700
X-Google-Sender-Auth: 4aDSMlXNfk9eEvSmPehwp7QhhxU
Message-ID: <CABcZAN=E+cw8Dvay34EObcDcyoUh7OPUmrvx6iuQQ89jTHYk_A@mail.gmail.com>
To: Pascal Bach <pascal.bach@siemens.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] fetch2/git: always use premirror first if update is required
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
X-List-Received-Date: Fri, 16 Sep 2016 16:20:23 -0000
Content-Type: multipart/alternative; boundary=001a1140bcd2db3990053ca25683

--001a1140bcd2db3990053ca25683
Content-Type: text/plain; charset=UTF-8

On Fri, Sep 16, 2016 at 1:58 AM, Pascal Bach <pascal.bach@siemens.com>
wrote:

> When an update of the local copy is required always try to fetch the update
> from a premirror first.
> The premirror should always have precedence over the upstream repository
> as updating from there might not work if BB_FETCH_PREMIRRORONLY,
> BB_NO_NBB_ALLOWED_NETWORKS or BB_NO_NETWORK is set.
>
> This also gets rid of the special case for BB_FETCH_PREMIRRORONLY.
>
> Signed-off-by: Pascal Bach <pascal.bach@siemens.com>
> ---
>  lib/bb/fetch2/git.py | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index 1bec60a..cac2a87 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -227,13 +227,8 @@ class Git(FetchMethod):
>          return False
>
>      def try_premirror(self, ud, d):
> -        # If we don't do this, updating an existing checkout with only
> premirrors
> -        # is not possible
> -        if d.getVar("BB_FETCH_PREMIRRORONLY", True) is not None:
> -            return True
> -        if os.path.exists(ud.clonedir):
> -            return False
> -        return True
> +        # Always try premirror if an update is required
> +        return self.need_update(ud, d)
>

Will this result in fetching a mirror tarball even if you already have a
clone in ud.clonedir? The previous logic always returned False if the
clonedir existed..
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a1140bcd2db3990053ca25683
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Sep 16, 2016 at 1:58 AM, Pascal Bach <span dir=3D"ltr">&lt;<a href=
=3D"mailto:pascal.bach@siemens.com" target=3D"_blank">pascal.bach@siemens.c=
om</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D":1n1"=
 class=3D"a3s aXjCH m15732581c0425444">When an update of the local copy is =
required always try to fetch the update<br>
from a premirror first.<br>
The premirror should always have precedence over the upstream repository<br=
>
as updating from there might not work if BB_FETCH_PREMIRRORONLY,<br>
BB_NO_NBB_ALLOWED_NETWORKS or BB_NO_NETWORK is set.<br>
<br>
This also gets rid of the special case for BB_FETCH_PREMIRRORONLY.<br>
<br>
Signed-off-by: Pascal Bach &lt;<a href=3D"mailto:pascal.bach@siemens.com">p=
ascal.bach@siemens.com</a>&gt;<br>
---<br>
=C2=A0lib/<span class=3D"il">bb</span>/fetch2/git.py | 9 ++-------<br>
=C2=A01 file changed, 2 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/lib/<span class=3D"il">bb</span>/fetch2/git.py b/lib/<span cla=
ss=3D"il">bb</span>/fetch2/git.py<br>
index 1bec60a..cac2a87 100644<br>
--- a/lib/<span class=3D"il">bb</span>/fetch2/git.py<br>
+++ b/lib/<span class=3D"il">bb</span>/fetch2/git.py<br>
@@ -227,13 +227,8 @@ <span class=3D"il">class</span> Git(FetchMethod):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return False<br>
<br>
=C2=A0 =C2=A0 =C2=A0def try_premirror(self, ud, d):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 # If we don&#39;t do this, updating an existin=
g checkout with only premirrors<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 # is not possible<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if d.getVar(&quot;BB_FETCH_<wbr>PREMIRRORONLY&=
quot;, True) is not None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return True<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if os.path.exists(ud.clonedir):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return False<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return True<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Always try premirror if an update is require=
d<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self.need_update(ud, d)</div></blockquo=
te></div><br>Will this result in fetching a mirror tarball even if you alre=
ady have a clone in ud.clonedir? The previous logic always returned False i=
f the clonedir existed..<br>-- <br><div class=3D"gmail_signature" data-smar=
tmail=3D"gmail_signature">Christopher Larson<br>clarson at kergoth dot com<=
br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Sen=
ior Software Engineer, Mentor Graphics</div>
</div></div>

--001a1140bcd2db3990053ca25683--
