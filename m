Received: from mail-la0-f49.google.com ([209.85.215.49])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1TtJ5P-0007nE-DQ
	for bitbake-devel@lists.openembedded.org;
	Thu, 10 Jan 2013 15:26:28 +0100
Received: by mail-la0-f49.google.com with SMTP id fk20so627952lab.36
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Jan 2013 06:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=Ji2ZiQkSzpkBQ9woQXWZGsNGCloZ7VLi7uDxAKITpuY=;
	b=cppc+f52fWY0O2a9NQwwR9f/P0LuK3O3sF7nrbejwMZ+85tHIuJgtEBZIU7x2RVeKx
	DhxjimE0PkQqHKpH1lDwJEu046zbwhsI76PhAK+NaEoNQPSmgKFel/vKdy1DkD5NtRp2
	gqoO4x+0ppdDUAT1i3FSmbQ6N+jKB71z78yy+mGyHm1fsDHQ/r74JhGk1HC/reXBZccS
	MhtfQPySrVom/UzA2amsBUSaap5eedbpKnkR1p7l3Up9CgiCZEu9c8/yg2Ti0emFKULh
	Fb5MBmKQZQ32jXqnwhZMymkw5+G5+G9BewGkt+MgNAwHcOxJYapmOZCeo4CgoCeBUOz1
	kk8g==
Received: by 10.112.28.65 with SMTP id z1mr29301257lbg.119.1357827073785; Thu,
	10 Jan 2013 06:11:13 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.34.10 with HTTP; Thu, 10 Jan 2013 06:10:53 -0800 (PST)
In-Reply-To: <1357807596-31587-1-git-send-email-martiert@gmail.com>
References: <1357807596-31587-1-git-send-email-martiert@gmail.com>
From: Chris Larson <clarson@kergoth.com>
Date: Thu, 10 Jan 2013 07:10:53 -0700
X-Google-Sender-Auth: BxrruSgAnQ1RKrCgGJAQRYm7HKE
Message-ID: <CABcZANkgffV7FwXX4NVyBA2mm1YOg+1en9x_oidsey+AkqdGBg@mail.gmail.com>
To: Martin Ertsaas <martiert@gmail.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] utils.py: Use shutil.rmtree if the path we wish to remove is a directory.
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 10 Jan 2013 14:26:30 -0000
Content-Type: multipart/alternative; boundary=bcaec554d9d666409404d2efc0da

--bcaec554d9d666409404d2efc0da
Content-Type: text/plain; charset=UTF-8

On Thu, Jan 10, 2013 at 1:46 AM, Martin Ertsaas <martiert@gmail.com> wrote:

> On mac, os.unlink does not remove directories, and we therefor have
> to explicitly use shutil.rmtree if the path is a directory.
> ---
>  lib/bb/utils.py |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/lib/bb/utils.py b/lib/bb/utils.py
> index cef0fdd..8b6d3f5 100644
> --- a/lib/bb/utils.py
> +++ b/lib/bb/utils.py
> @@ -561,7 +561,10 @@ def remove(path, recurse=False):
>      import os, errno, shutil, glob
>      for name in glob.glob(path):
>          try:
> -            os.unlink(name)
> +            if os.path.isdir(name):
> +                shutil.rmtree(name)
> +            else:
> +                os.unlink(name)
>          except OSError as exc:
>              if recurse and exc.errno == errno.EISDIR:
>                  shutil.rmtree(name)
>


Look 2 lines down, where it checks to see if the os.unlink failed due to it
being a directory and runs shutil.rmtree if that's the case.
-- 
Christopher Larson

--bcaec554d9d666409404d2efc0da
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Thu, Jan 10, 2013 at 1:46 AM, Martin Ertsaas <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:martiert@gmail.com" target=3D"_blank">martiert@gmail.com</a>&g=
t;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div id=3D":13o">On mac, os.unlink does not =
remove directories, and we therefor have<br>
to explicitly use shutil.rmtree if the path is a directory.<br>
---<br>
=C2=A0lib/bb/utils.py | =C2=A0 =C2=A05 ++++-<br>
=C2=A01 file changed, 4 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/lib/bb/utils.py b/lib/bb/utils.py<br>
index cef0fdd..8b6d3f5 100644<br>
--- a/lib/bb/utils.py<br>
+++ b/lib/bb/utils.py<br>
@@ -561,7 +561,10 @@ def remove(path, recurse=3DFalse):<br>
=C2=A0 =C2=A0 =C2=A0import os, errno, shutil, glob<br>
=C2=A0 =C2=A0 =C2=A0for name in glob.glob(path):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0os.unlink(name)<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if os.path.isdir(name):<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0shutil.rmtree(name=
)<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0os.unlink(name)<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except OSError as exc:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if recurse and exc.errno =
=3D=3D errno.EISDIR:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0shutil.rmtree=
(name)</div></blockquote></div><br><br>Look 2 lines down, where it checks t=
o see if the os.unlink failed due to it being a directory and runs shutil.r=
mtree if that&#39;s the case.<br>-- <br>

Christopher Larson</div></div>

--bcaec554d9d666409404d2efc0da--
