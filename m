Return-Path: <kergoth@gmail.com>
Received: from mail-lb0-f182.google.com (mail-lb0-f182.google.com
	[209.85.217.182])
	by mail.openembedded.org (Postfix) with ESMTP id 7956F7041E
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Jul 2014 18:54:30 +0000 (UTC)
Received: by mail-lb0-f182.google.com with SMTP id c11so4211039lbj.41
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 08 Jul 2014 11:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=3bKiFQf6NZFBjRpETCDxQRaQ4wVbrJ+oIXwhkpU50AM=;
	b=WF0XA59BwX6nVfsrJFCgRfnu7phN/f+lr3s5aoGwXwhiOhEspSxnSjvRJo94csKUOo
	PhhO+GS4MqdUvTuzaCj3VUqp2jhR6Us4521+fr/KLh+gxCqesZgkMDozdqpT3lp+HH2Y
	a2qkxnWFkozV9SWFROHTnbEw+7UxbQ+2lDtPXCxpaL1jyPZlJRddyoM9Y6buWNY3dYIc
	8kyMBWV2Tv9bzGGrNWAfZeJMlHfUu45DToHBqdypZkT2PA/ANWszlQADk7/xlC0T/uSR
	BGVaHh48rR67FKcz4cGIvADyJWvolMZju/jZfWTvxdXISQZ6O9qQsBNBeMCG4ugAH7ok
	xhog==
X-Received: by 10.112.198.161 with SMTP id jd1mr12288925lbc.56.1404845671315; 
	Tue, 08 Jul 2014 11:54:31 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.168.66 with HTTP; Tue, 8 Jul 2014 11:54:11 -0700 (PDT)
In-Reply-To: <1404832184-16471-1-git-send-email-vitaliy.kharin@lge.com>
References: <1404832184-16471-1-git-send-email-vitaliy.kharin@lge.com>
From: Christopher Larson <clarson@kergoth.com>
Date: Tue, 8 Jul 2014 11:54:11 -0700
X-Google-Sender-Auth: ntXBY4JBDyOSiDMlAoMGJCk24eU
Message-ID: <CABcZANmdpjjGExdJktZUz0owXynDmqhmLVWZnZMqq0GqWx6YRQ@mail.gmail.com>
To: Vitaliy Kharin <kvserr@gmail.com>
Cc: Vitaliy Kharin <vitaliy.kharin@lge.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] bb.utils.which is intend to locate regular file only as it is written in comment
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
X-List-Received-Date: Tue, 08 Jul 2014 18:54:32 -0000
Content-Type: multipart/alternative; boundary=001a11c34b8833ffe604fdb31f42

--001a11c34b8833ffe604fdb31f42
Content-Type: text/plain; charset=UTF-8

On Tue, Jul 8, 2014 at 8:09 AM, Vitaliy Kharin <kvserr@gmail.com> wrote:

> Signed-off-by: Vitaliy Kharin <vitaliy.kharin@lge.com>
> ---
>  bitbake/lib/bb/utils.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
> index 0be45e1..c48b237 100644
> --- a/bitbake/lib/bb/utils.py
> +++ b/bitbake/lib/bb/utils.py
> @@ -809,7 +809,7 @@ def which(path, item, direction = 0, history = False):
>      for p in paths:
>          next = os.path.join(p, item)
>          hist.append(next)
> -        if os.path.exists(next):
> +        if os.path.isfile(next):
>              if not os.path.isabs(next):
>                  next = os.path.abspath(next)
>              if history:
>

This seems questionable to me. With this, it wouldn't find symlinks, no?
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a11c34b8833ffe604fdb31f42
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Jul 8, 2014 at 8:09 AM, Vitaliy Kharin <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:kvserr@gmail.com" target=3D"_blank">kvserr@gmail.com</a>&gt;</s=
pan> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div id=3D":4jo" class=3D"a3s" style=3D"over=
flow:hidden">Signed-off-by: Vitaliy Kharin &lt;<a href=3D"mailto:vitaliy.kh=
arin@lge.com">vitaliy.kharin@lge.com</a>&gt;<br>


---<br>
=C2=A0<span class=3D"il">bitbake</span>/lib/bb/utils.py | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/<span class=3D"il">bitbake</span>/lib/bb/utils.py b/<span clas=
s=3D"il">bitbake</span>/lib/bb/utils.py<br>
index 0be45e1..c48b237 100644<br>
--- a/<span class=3D"il">bitbake</span>/lib/bb/utils.py<br>
+++ b/<span class=3D"il">bitbake</span>/lib/bb/utils.py<br>
@@ -809,7 +809,7 @@ def which(path, item, direction =3D 0, history =3D Fals=
e):<br>
=C2=A0 =C2=A0 =C2=A0for p in paths:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0next =3D os.path.join(p, item)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hist.append(next)<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0if os.path.exists(next):<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if os.path.isfile(next):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not os.path.isabs(next):=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0next =3D os.p=
ath.abspath(next)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if history:</div></blockquo=
te></div><br></div><div class=3D"gmail_extra">This seems questionable to me=
. With this, it wouldn&#39;t find symlinks, no?<br>-- <br>Christopher Larso=
n<br>clarson at kergoth dot com<br>

Founder - BitBake, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior=
 Software Engineer, Mentor Graphics
</div></div>

--001a11c34b8833ffe604fdb31f42--
