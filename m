Return-Path: <Martin.Jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917BDC433EF
	for <webhook@archiver.kernel.org>; Thu, 30 Sep 2021 10:09:46 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web08.10235.1632996585209972169
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Sep 2021 03:09:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=ltFSmT76;
 spf=pass (domain: gmail.com, ip: 209.85.214.169,
 mailfrom: martin.jansa@gmail.com)
Received: by mail-pl1-f169.google.com with SMTP id y1so3624746plk.10
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Sep 2021 03:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T+35TOM3U532EwdoWEvC3us/AjW4McVg79QYfcwi5hU=;
        b=ltFSmT76gLlG8eWbGxh8bJIbMk0z3/qn+9Cvw83z43E3/FtdHPEsaDxGsCB1ytpIIa
         O2vMiwyl3Yizv9+eEDWPTcuw2fcra1gf9tkOUEph8Tps+6m45s2ZgQvSM5Oo7CMDv1A9
         XHIaSS3PB4FOnyRNGCwfNdykiuY/jCoUta0tbhuwQpAyY7wzubEZ51rt7N/iaj4hj5z2
         9sQtFgEaKc5DScTrIHg7GMjZUXM7qM3b2tpVWU4bjxm4GWXmZBiGvEHUtQW19PHN+XpV
         KoTlWvyzbFVwFzUzB+2fpt9YBgsxPys8Eblel4Nmo4tnpmbLfCI8hgnPlx3Qvo9Z6HvE
         Sr/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T+35TOM3U532EwdoWEvC3us/AjW4McVg79QYfcwi5hU=;
        b=xzzd3zCJe9mW+O3utybVvg6Pj8xor7we90J7MtsksdId52c1CHF3JZp0BDDGJbUCak
         BBZkDZZAlAvPNnjl8T3Okwc5WCCXOsLfWbeERLmMHhYAWdIyJ6jNGuywlRXmfPVdc/3l
         UeWOyygUamXPSpEIj13yCG7ym6lwUnS+/6IfhjlEOSkKZA1P7lLD60q4kosK3wtJedfD
         HmjASbAG/QhLnpe4UAYmlsAemDXFlPOKbrg5k6IacYxYBWWUwpIhgBSBaLtyff4Vn6+o
         w8BaEenUzlEhlLUAhYcSC/NWOUVuyCoP0Jwa7DQnSJuhD9T3TP10CSW5058lCB6lorSN
         nmOw==
X-Gm-Message-State: AOAM532VYWeyEQiwDIDp/3wUjekj/fxT9TXFoV3gM7+J4HdgeUWYSMn8
	oTCKmZZKHtJhwuzSonMLK7ofZ2KjBSEsLl5pSgc=
X-Google-Smtp-Source: 
 ABdhPJxpvAG3pmNEjndkJMYpS9+i6QZ+KQ0CBuUTuEzC6DSlNYHP6EX+IfddziBc6VIJMi6HOBy2D2b3aIyWQ7L4YWs=
X-Received: by 2002:a17:90a:c913:: with SMTP id
 v19mr12455198pjt.169.1632996584642;
 Thu, 30 Sep 2021 03:09:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1632493110.git.steve@sakoman.com>
 <e75169f7ef89cca94cefe9f0099a5b427b380a6d.1632493110.git.steve@sakoman.com>
In-Reply-To: 
 <e75169f7ef89cca94cefe9f0099a5b427b380a6d.1632493110.git.steve@sakoman.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Thu, 30 Sep 2021 12:09:33 +0200
Message-ID: 
 <CA+chaQebhx9aX1sKGct-XTQdLm-dWvUZpGwpUDxv0fTUmj5iiQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [bitbake][dunfell][1.46][PATCH 08/14] build:
 Avoid duplicating logs in verbose mode
To: Steve Sakoman <steve@sakoman.com>,
 Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="00000000000058dba805cd33a531"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 30 Sep 2021 10:09:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12718

--00000000000058dba805cd33a531
Content-Type: text/plain; charset="UTF-8"

I'm sorry for late review, but this patch won't work in 1.46 without this
commit from 1.48:

  commit 423c046f2173aaff3072dc3d0882d01b8a0b0212
  Author: Richard Purdie <richard.purdie@linuxfoundation.org>
  Date:   Mon Aug 24 12:28:27 2020 +0100

    build/msg: Cleanup verbose option handling

which defines verboseStdoutLogging

Without this when task fails it shows completely wrong error output e.g.:

ERROR: sysdig-0.26.6-r0 do_compile: Build of do_compile failed
ERROR: sysdig-0.26.6-r0 do_compile: Traceback (most recent call last):
  File "/jenkins/mjansa/build/webos/dunfell/bitbake/lib/bb/build.py", line
584, in _exec_task
    exec_func(task, localdata)
  File "/jenkins/mjansa/build/webos/dunfell/bitbake/lib/bb/build.py", line
251, in exec_func
    exec_func_shell(func, d, runfile, cwd=adir)
  File "/jenkins/mjansa/build/webos/dunfell/bitbake/lib/bb/build.py", line
452, in exec_func_shell
    bb.process.run(cmd, shell=False, stdin=stdin, log=logfile,
extrafiles=[(fifo,readfifo)])
  File "/jenkins/mjansa/build/webos/dunfell/bitbake/lib/bb/process.py",
line 184, in run
    raise ExecutionError(cmd, pipe.returncode, None, None)
bb.process.ExecutionError: Execution of
'/jenkins/mjansa/build/webos/dunfell/BUILD/work/qemux86-webos-linux/sysdig/0.26.6-r0/temp/run.do_compile.69208'
failed with exit code 1

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/jenkins/mjansa/build/webos/dunfell/bitbake/lib/bb/build.py", line
649, in exec_task
    return _exec_task(fn, task, d, quieterr)
  File "/jenkins/mjansa/build/webos/dunfell/bitbake/lib/bb/build.py", line
597, in _exec_task
    if verboseStdoutLogging:
NameError: name 'verboseStdoutLogging' is not defined

On Fri, Sep 24, 2021 at 4:22 PM Steve Sakoman <steve@sakoman.com> wrote:

> From: Richard Purdie <richard.purdie@linuxfoundation.org>
>
> With "bitbake -v", for task failures you'd see the log output twice. Avoid
> this by using the existing "did we print info" switch.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> (cherry picked from commit e2c1afda4cb8023ed4ffeb5dc5bee4f0055659a8)
> Signed-off-by: Steve Sakoman <steve@sakoman.com>
> ---
>  lib/bb/build.py | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/lib/bb/build.py b/lib/bb/build.py
> index 04971636..6e9c064e 100644
> --- a/lib/bb/build.py
> +++ b/lib/bb/build.py
> @@ -592,6 +592,10 @@ def _exec_task(fn, task, d, quieterr):
>                  event.fire(TaskFailedSilent(task, fn, logfn, localdata),
> localdata)
>              else:
>                  errprinted = errchk.triggered
> +                # If the output is already on stdout, we've printed the
> information in the
> +                # logs once already so don't duplicate
> +                if verboseStdoutLogging:
> +                    errprinted = True
>                  logger.error(str(exc))
>                  event.fire(TaskFailed(task, fn, logfn, localdata,
> errprinted), localdata)
>              return 1
> --
> 2.25.1
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#12697):
> https://lists.openembedded.org/g/bitbake-devel/message/12697
> Mute This Topic: https://lists.openembedded.org/mt/85840116/3617156
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> Martin.Jansa@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

--00000000000058dba805cd33a531
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I&#39;m sorry for late review, but this patch won&#39;t wo=
rk in 1.46 without this commit from 1.48:<div><br><div>=C2=A0 commit 423c04=
6f2173aaff3072dc3d0882d01b8a0b0212<br>=C2=A0 Author: Richard Purdie &lt;<a =
href=3D"mailto:richard.purdie@linuxfoundation.org">richard.purdie@linuxfoun=
dation.org</a>&gt;<br>=C2=A0 Date: =C2=A0 Mon Aug 24 12:28:27 2020 +0100<br=
><br>=C2=A0 =C2=A0 build/msg: Cleanup verbose option handling<br></div><div=
><br></div><div>which defines=C2=A0verboseStdoutLogging</div><div><br></div=
><div>Without this when task fails it shows completely wrong error output e=
.g.:</div><div><br></div><div>ERROR: sysdig-0.26.6-r0 do_compile: Build of =
do_compile failed<br>ERROR: sysdig-0.26.6-r0 do_compile: Traceback (most re=
cent call last):<br>=C2=A0 File &quot;/jenkins/mjansa/build/webos/dunfell/b=
itbake/lib/bb/build.py&quot;, line 584, in _exec_task<br>=C2=A0 =C2=A0 exec=
_func(task, localdata)<br>=C2=A0 File &quot;/jenkins/mjansa/build/webos/dun=
fell/bitbake/lib/bb/build.py&quot;, line 251, in exec_func<br>=C2=A0 =C2=A0=
 exec_func_shell(func, d, runfile, cwd=3Dadir)<br>=C2=A0 File &quot;/jenkin=
s/mjansa/build/webos/dunfell/bitbake/lib/bb/build.py&quot;, line 452, in ex=
ec_func_shell<br>=C2=A0 =C2=A0 bb.process.run(cmd, shell=3DFalse, stdin=3Ds=
tdin, log=3Dlogfile, extrafiles=3D[(fifo,readfifo)])<br>=C2=A0 File &quot;/=
jenkins/mjansa/build/webos/dunfell/bitbake/lib/bb/process.py&quot;, line 18=
4, in run<br>=C2=A0 =C2=A0 raise ExecutionError(cmd, pipe.returncode, None,=
 None)<br>bb.process.ExecutionError: Execution of &#39;/jenkins/mjansa/buil=
d/webos/dunfell/BUILD/work/qemux86-webos-linux/sysdig/0.26.6-r0/temp/run.do=
_compile.69208&#39; failed with exit code 1<br><br>During handling of the a=
bove exception, another exception occurred:<br><br>Traceback (most recent c=
all last):<br>=C2=A0 File &quot;/jenkins/mjansa/build/webos/dunfell/bitbake=
/lib/bb/build.py&quot;, line 649, in exec_task<br>=C2=A0 =C2=A0 return _exe=
c_task(fn, task, d, quieterr)<br>=C2=A0 File &quot;/jenkins/mjansa/build/we=
bos/dunfell/bitbake/lib/bb/build.py&quot;, line 597, in _exec_task<br>=C2=
=A0 =C2=A0 if verboseStdoutLogging:<br>NameError: name &#39;verboseStdoutLo=
gging&#39; is not defined<br></div></div></div><br><div class=3D"gmail_quot=
e"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 24, 2021 at 4:22 PM St=
eve Sakoman &lt;<a href=3D"mailto:steve@sakoman.com">steve@sakoman.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From:=
 Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org" t=
arget=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;<br>
<br>
With &quot;bitbake -v&quot;, for task failures you&#39;d see the log output=
 twice. Avoid<br>
this by using the existing &quot;did we print info&quot; switch.<br>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;<b=
r>
(cherry picked from commit e2c1afda4cb8023ed4ffeb5dc5bee4f0055659a8)<br>
Signed-off-by: Steve Sakoman &lt;<a href=3D"mailto:steve@sakoman.com" targe=
t=3D"_blank">steve@sakoman.com</a>&gt;<br>
---<br>
=C2=A0lib/bb/build.py | 4 ++++<br>
=C2=A01 file changed, 4 insertions(+)<br>
<br>
diff --git a/lib/bb/build.py b/lib/bb/build.py<br>
index 04971636..6e9c064e 100644<br>
--- a/lib/bb/build.py<br>
+++ b/lib/bb/build.py<br>
@@ -592,6 +592,10 @@ def _exec_task(fn, task, d, quieterr):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0event.fire(Ta=
skFailedSilent(task, fn, logfn, localdata), localdata)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0errprinted =
=3D errchk.triggered<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # If the output is=
 already on stdout, we&#39;ve printed the information in the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # logs once alread=
y so don&#39;t duplicate<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if verboseStdoutLo=
gging:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errp=
rinted =3D True<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger.error(=
str(exc))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0event.fire(Ta=
skFailed(task, fn, logfn, localdata, errprinted), localdata)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1<br>
-- <br>
2.25.1<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#12697): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/12697" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/12697</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/85840116/3617=
156" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/85840116/3617156</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:Martin.Jansa@gmail.com" target=3D"=
_blank">Martin.Jansa@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--00000000000058dba805cd33a531--

