Return-Path: <kergoth@gmail.com>
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
	[209.85.210.66])
	by mail.openembedded.org (Postfix) with ESMTP id 2D5A76011A
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Oct 2018 18:05:49 +0000 (UTC)
Received: by mail-ot1-f66.google.com with SMTP id o14so8491187oth.4
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Oct 2018 11:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=4FCPxUTh8oETNET0m9il2TUG7C/fqloSo/0Lcx6ZS94=;
	b=dBZZVYlPpYlDAq1LOG7jW9YV8aSRkG75RMkRnMZMRL4WLDxU84RfSZqkX9OmuZmeQ1
	6i/T9VomfERP16sI20b/yY5etFc60FZ7Qy3PWe+6F8CucwXWBxxq4ZUt+sgyWBdJ9DMn
	v7It85FJOv4RkfczgNBvNpRtmoc0dMdjbjgprReYdZUBJ1SCxJrgYCEntWfGemoEKXSX
	TXR07hXjnwOTCMASqZ7oCt/fG+VHbqRkUk0vSgrvOm7zr6rylWx6lZ2fHCmpvjTYqbfk
	TpHnO/4NUoKGxSQsuOdRO6ZsTkCl5pM9v4RavTZf4OFRelfpdOtzI+G09u5gDD4oM1uJ
	oG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=4FCPxUTh8oETNET0m9il2TUG7C/fqloSo/0Lcx6ZS94=;
	b=qg93L4pNcwAGPpHnrSBcn/Jr8uUF4WaPbU1KxZeLkGk9qiBiNjtCfosfLIKQg6u64c
	uc3QLc0y5NIE5NAUwhi5YJDNjyJYZJKTvDgfCuBL7CUAA/qUMNoJMhEOo5qL6uWYTcc6
	p8CcrxTjHnCy7DNbnzOe6CsCcjXyl31XJe/G25iGg4HJeddR0BqsPV0WQjYozpvc2WQU
	/vtdgDI72J4v9JkDIITzuvtkGyX90nfRyq352/nnhKhzpFkJU6ZMAI+yB/PMydUxty+1
	c4cOFSTqbTJvj802mgbZpEfKiBHVx893I9SGfYc6yWGQet/4EcmOPTr+4iWYQF7Le526
	e2hQ==
X-Gm-Message-State: AGRZ1gKadpSRbPN3wefUYohyEBWgU6GogPrGuW/kuyIvfxNIihzlgJ2F
	dbhFUQFagTGb0X7w67j1FW1X42wY4DWtoYMrklM=
X-Google-Smtp-Source: AJdET5ci8Tu+wBvhe6v9CnU7EQ0sw39k45kcN1cOI/+hDHWe9IMS9MSWoKA9mFRs/plNiX7bEaPIguypQuBwWNaGPzM=
X-Received: by 2002:a9d:62cb:: with SMTP id z11mr5513200otk.342.1540836350688; 
	Mon, 29 Oct 2018 11:05:50 -0700 (PDT)
MIME-Version: 1.0
References: <20181029163933.26646-1-tomasz.meresinski@comarch.pl>
	<20181029163933.26646-3-tomasz.meresinski@comarch.pl>
In-Reply-To: <20181029163933.26646-3-tomasz.meresinski@comarch.pl>
From: Christopher Larson <kergoth@gmail.com>
Date: Mon, 29 Oct 2018 11:05:39 -0700
Message-ID: <CABcZANk7p-Fefxi8y2P2GHa22Y=RifxA4VnWAAyGxN2vPP8pJA@mail.gmail.com>
To: tomasz.meresinski@comarch.pl
Cc: bitbake-devel@lists.openembedded.org, tomasz.meresinski@comarch.com
Subject: Re: [PATCH 2/3] runqueue: Fix base class for sceneQueueComplete
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
X-List-Received-Date: Mon, 29 Oct 2018 18:05:50 -0000
Content-Type: multipart/alternative; boundary="0000000000005702d4057961ebc1"

--0000000000005702d4057961ebc1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This looks wrong. Fix the __init__ instead.

On Mon, Oct 29, 2018 at 10:22 AM Tomasz Meresi=C5=84ski <
tomasz.meresinski@comarch.pl> wrote:

> __init__ method initialized bb.event.Event not sceneQueueEvent.
> Change base class to bb.event.Event.
>
> Signed-off-by: Tomasz Meresi=C5=84ski <tomasz.meresinski@comarch.com>
> ---
>  lib/bb/runqueue.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
> index 9ce06c40..e138a5c2 100644
> --- a/lib/bb/runqueue.py
> +++ b/lib/bb/runqueue.py
> @@ -2615,7 +2615,7 @@ class sceneQueueTaskFailed(sceneQueueEvent):
>      def __str__(self):
>          return "Setscene task (%s) failed with exit code '%s' - real tas=
k
> will be run instead" % (self.taskstring, self.exitcode)
>
> -class sceneQueueComplete(sceneQueueEvent):
> +class sceneQueueComplete(bb.event.Event):
>      """
>      Event when all the sceneQueue tasks are complete
>      """
> --
> 2.17.1
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>


--=20
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Senior Software Engineer, Mentor Graphics

--0000000000005702d4057961ebc1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">This looks wrong. Fix the __init__ instead.</div><br><div =
class=3D"gmail_quote"><div dir=3D"ltr">On Mon, Oct 29, 2018 at 10:22 AM Tom=
asz Meresi=C5=84ski &lt;<a href=3D"mailto:tomasz.meresinski@comarch.pl">tom=
asz.meresinski@comarch.pl</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">__init__ method initialized bb.event.Event not sceneQueueEvent.<br>
Change base class to bb.event.Event.<br>
<br>
Signed-off-by: Tomasz Meresi=C5=84ski &lt;<a href=3D"mailto:tomasz.meresins=
ki@comarch.com" target=3D"_blank">tomasz.meresinski@comarch.com</a>&gt;<br>
---<br>
=C2=A0lib/bb/runqueue.py | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py<br>
index 9ce06c40..e138a5c2 100644<br>
--- a/lib/bb/runqueue.py<br>
+++ b/lib/bb/runqueue.py<br>
@@ -2615,7 +2615,7 @@ class sceneQueueTaskFailed(sceneQueueEvent):<br>
=C2=A0 =C2=A0 =C2=A0def __str__(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return &quot;Setscene task (%s) failed wi=
th exit code &#39;%s&#39; - real task will be run instead&quot; % (self.tas=
kstring, self.exitcode)<br>
<br>
-class sceneQueueComplete(sceneQueueEvent):<br>
+class sceneQueueComplete(bb.event.Event):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0Event when all the sceneQueue tasks are complete<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
-- <br>
2.17.1<br>
<br>
-- <br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_blank">b=
itbake-devel@lists.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/mailman/li=
stinfo/bitbake-devel</a><br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"l=
tr"><div><div dir=3D"ltr">Christopher Larson<br>kergoth at gmail dot com<br=
>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Senior Software Engineer, M=
entor Graphics</div></div></div></div>

--0000000000005702d4057961ebc1--
