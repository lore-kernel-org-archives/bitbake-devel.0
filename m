Return-Path: <kergoth@gmail.com>
Received: from mail-oi0-f66.google.com (mail-oi0-f66.google.com
	[209.85.218.66])
	by mail.openembedded.org (Postfix) with ESMTP id 66DBD65CBA
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2016 16:35:11 +0000 (UTC)
Received: by mail-oi0-f66.google.com with SMTP id 2so7299598oif.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2016 09:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=ZUevaZ2itxvCd+TJia+TUX5dnudfLv4st5Tyn1Pj2zw=;
	b=ef3Y+bvZeY5f80er0t8cp+uPSbIOquWeOgCjHpJHwyHkfhjfXkKL+8bPhafCr4TEG9
	AfrBLXOEUIqlZGyN29lzA/YLAAmzBNtQiVN8gTJs9YHNZOjJpgo1mEuClNMInlgoxYXG
	Sn89Otq7dpZSlPWSyxfN3MvEBOkCxSTG2IcCwd48Hx8Ho35YFBiRY6TDVUpXgOAyU0KO
	VwzH6L0/RbsqnvhbsUgLIcHL2vkPdBV8N3C5QoNLIeYBdtuih9NY+9fdhNQkebimr0ke
	b5ef5V+cBrC5DKvI4q+ZTpM1PoCniRbG3s9+TWRFi+1HkcdsP9+AKsxZUxq5Z5kg/Mv3
	X71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=ZUevaZ2itxvCd+TJia+TUX5dnudfLv4st5Tyn1Pj2zw=;
	b=FoOKFnpBl+Z/aBwfe6EDcfMJ5e/T/u0cqpO0D+WEcGrz+E7KdGTWoJ/zbpWUqfD4K/
	h1KdFmkb0R/sJRW7Y6n8czTybTTdgS3KM0atvdPeZeok+XuQUcRfmRBii9dQSRONj5Pw
	0JZamXVIqQ5mhOIEr4ZSQ4+zfJVcyoyCT3RGwRwekbIZoV+Yc+mo0EAEY1QCAT8KapIG
	VgQ3dBi32XvPyNhkvSuR674p8taQbkHi2jfESvPMxflw8LYD5D9lbhoe9Ua4OsyADH/T
	IlRLYnxxtQ/Rr9EoDyw7Yu2dDUeYK9/LqwNn9ecm+Wl8ptrVTvjQxBpYgpgJoObSgg58
	NMSw==
X-Gm-Message-State: AE9vXwNQWjXPa76YS4H9EuAvvmRHW531WZRjAoOUrUYceN4WywkAONa427ggJdvqxla2juSQtwqvsU9ACMZEUA==
X-Received: by 10.202.206.73 with SMTP id e70mr13875015oig.183.1474043711781; 
	Fri, 16 Sep 2016 09:35:11 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.157.13.194 with HTTP; Fri, 16 Sep 2016 09:34:51 -0700 (PDT)
In-Reply-To: <1473974147-29966-2-git-send-email-kergoth@gmail.com>
References: <1473974147-29966-1-git-send-email-kergoth@gmail.com>
	<1473974147-29966-2-git-send-email-kergoth@gmail.com>
From: Christopher Larson <chris_larson@mentor.com>
Date: Fri, 16 Sep 2016 09:34:51 -0700
X-Google-Sender-Auth: CjWQu-E3li3_uAlZlDBrdIi3unc
Message-ID: <CABcZANkH_ONvZXW2b930nKTTbRqvLpyszHL=B6W4E2zEJws40g@mail.gmail.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: Re: [PATCH 2/2] bb.build: in _exec_task, catch BBHandledException
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
X-List-Received-Date: Fri, 16 Sep 2016 16:35:13 -0000
Content-Type: multipart/alternative; boundary=001a113d2920d30224053ca28b0c

--001a113d2920d30224053ca28b0c
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 15, 2016 at 2:15 PM, Christopher Larson <kergoth@gmail.com>
wrote:

> From: Christopher Larson <chris_larson@mentor.com>
>
> We don't want a traceback for this exception, we need to catch it, fire
> TaskFailed, and return failure.
>
> Signed-off-by: Christopher Larson <chris_larson@mentor.com>
> ---
>  lib/bb/build.py | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/lib/bb/build.py b/lib/bb/build.py
> index 28401b3..8581e72 100644
> --- a/lib/bb/build.py
> +++ b/lib/bb/build.py
> @@ -575,6 +575,9 @@ def _exec_task(fn, task, d, quieterr):
>              logger.error(str(exc))
>              event.fire(TaskFailed(task, logfn, localdata, errprinted),
> localdata)
>          return 1
> +    except bb.BBHandledException:
> +        event.fire(TaskFailed(task, logfn, localdata, True), localdata)
> +        return 1
>

Don=E2=80=99t merge this, v2 is forthcoming. Apparently firing the TaskFail=
ed is
problematic if it was the TaskStarted event handler which failed, as the UI
won=E2=80=99t have the pid of the task, resulting in this:

Traceback (most recent call last):
  File "/scratch/dogwood/pdk-licensing/poky/bitbake/lib/bb/ui/knotty.py",
line 426, in main
    helper.eventHandler(event)
  File "/scratch/dogwood/pdk-licensing/poky/bitbake/lib/bb/ui/uihelper.py",
line 48, in eventHandler
    del self.running_tasks[event.pid]
--=20
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a113d2920d30224053ca28b0c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Thu, Sep 15, 2016 at 2:15 PM, Christopher Larson <span dir=3D"ltr">&lt;<=
a href=3D"mailto:kergoth@gmail.com" target=3D"_blank">kergoth@gmail.com</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);bor=
der-left-style:solid;padding-left:1ex"><div id=3D"gmail-:9u" class=3D"gmail=
-a3s gmail-aXjCH gmail-m1572fb4b491cc4a4">From: Christopher Larson &lt;<a h=
ref=3D"mailto:chris_larson@mentor.com">chris_larson@mentor.com</a>&gt;<br>
<br>
We don&#39;t want a traceback for this exception, we need to catch it, fire=
<br>
TaskFailed, and return failure.<br>
<br>
Signed-off-by: Christopher Larson &lt;<a href=3D"mailto:chris_larson@mentor=
.com">chris_larson@mentor.com</a>&gt;<br>
---<br>
=C2=A0lib/bb/build.py | 3 +++<br>
=C2=A01 file changed, 3 insertions(+)<br>
<br>
diff --git a/lib/bb/build.py b/lib/bb/build.py<br>
index 28401b3..8581e72 100644<br>
--- a/lib/bb/build.py<br>
+++ b/lib/bb/build.py<br>
@@ -575,6 +575,9 @@ def _exec_task(fn, task, d, quieterr):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger.error(str(exc))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0event.fire(TaskFailed(task,=
 logfn, localdata, errprinted), localdata)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1<br>
+=C2=A0 =C2=A0 except bb.BBHandledException:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 event.fire(TaskFailed(task, logfn, localdata, =
True), localdata)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1</div></blockquote></div><br>Don=E2=80=
=99t merge this, v2 is forthcoming. Apparently firing the TaskFailed is pro=
blematic if it was the TaskStarted event handler which failed, as the UI wo=
n=E2=80=99t have the pid of the task, resulting in this:</div><div class=3D=
"gmail_extra"><br></div><div class=3D"gmail_extra"><div class=3D"gmail_extr=
a">Traceback (most recent call last):</div><div class=3D"gmail_extra">=C2=
=A0 File &quot;/scratch/dogwood/pdk-licensing/poky/bitbake/lib/bb/ui/knotty=
.py&quot;, line 426, in main</div><div class=3D"gmail_extra">=C2=A0 =C2=A0 =
helper.eventHandler(event)</div><div class=3D"gmail_extra">=C2=A0 File &quo=
t;/scratch/dogwood/pdk-licensing/poky/bitbake/lib/bb/ui/uihelper.py&quot;, =
line 48, in eventHandler</div><div class=3D"gmail_extra">=C2=A0 =C2=A0 del =
self.running_tasks[event.pid]</div>-- <br><div class=3D"gmail_signature"><d=
iv dir=3D"ltr">Christopher Larson<br>kergoth at gmail dot com<br>Founder - =
BitBake, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior Software =
Engineer, Mentor Graphics</div></div>
</div></div>

--001a113d2920d30224053ca28b0c--
