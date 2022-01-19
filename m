Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A689EC433F5
	for <webhook@archiver.kernel.org>; Wed, 19 Jan 2022 23:16:16 +0000 (UTC)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com
 [209.85.167.49])
 by mx.groups.io with SMTP id smtpd.web09.4362.1642634175913173166
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Jan 2022 15:16:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=R/Lst93j;
 spf=pass (domain: gmail.com, ip: 209.85.167.49,
 mailfrom: quaresma.jose@gmail.com)
Received: by mail-lf1-f49.google.com with SMTP id x22so14395599lfd.10
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Jan 2022 15:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=36G08H0rNWeZmoCetrl4MsakDc96mROfULFck/ns7fo=;
        b=R/Lst93jPQPBi9R5xbdp1MTB+0Bd4tXMFfI14PcAtRwLBj7ypwOPpANO0aANIfSBR+
         m+rm8QR4EAhf3IQH3qg1qgfLVscWAQvfrJYVuUmJXkS81nQ3/nwa2qXDkfBqQEMdyptC
         qBtr22S9SRJLuK/IJ1pFc9US6weSC9KdooPetRfAGVDqi7Dzy0Kj32ZKhWgVYMVD5An4
         QmCAL9fhz+fV1IKsah9vz6q7kXJGukZWPdyMTnM9OAJrsgwv5X3hGZhdzmFyS33xkpZo
         9EwM1su5CDSFTLEAO7mUsxOYae6QxU/VID/IUa+6/jD2vo40//cXs53OnwWU7o0k9WfA
         P4ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=36G08H0rNWeZmoCetrl4MsakDc96mROfULFck/ns7fo=;
        b=FTM4T3BRomo+oplOmqqgs/fV7R3xtt/ahgIIrkDd9m2Lviez8sy4iXGqPhGY4YIQFh
         a4a0kgnUA5p4ugtm/gPLKjJcsCXWGp+c7n8YiPhskVVyDx7l1i/iJzUWFqDlSRVAdM61
         D1+sol6VslKmwfjLe8oUhKY/pQCJTDYGaolyN0hiVm2z6jnDhN7KSOhtNLmTo/ApK7Bm
         CyvN+p2yGHva1Rx/fWqHfz+C2v29wy2QQvn3grWs16O0A4ouDdLEb5rLe7BctTUbv8Ii
         eKWNKCpEqp2XU/tZi8dmpcMBPzj0Q7TrxV6yqmqwC2zlW/NKTGG0O1qt2prGB7kTCSWY
         l/yA==
X-Gm-Message-State: AOAM531Pf+hsjAOYPHo0ozytUwAn3X0OYsggRdWjl8CvVMXUPQgXjbG1
	+rgsdPlsOyN2YzUvGK3rp+WTnX7750lyGHiYufI=
X-Google-Smtp-Source: 
 ABdhPJxhXTKK3pY9O53WrVLZlHofDBZhYeL/HZBMPZEtdqztx7Kp2kre7Th+5z/QYvtaPeflzerRbJEY556d1fAa7pE=
X-Received: by 2002:ac2:424b:: with SMTP id
 m11mr14954873lfl.447.1642634173947;
 Wed, 19 Jan 2022 15:16:13 -0800 (PST)
MIME-Version: 1.0
References: <20220107231526.1517563-1-richard.purdie@linuxfoundation.org>
 <20220107231526.1517563-2-richard.purdie@linuxfoundation.org>
In-Reply-To: <20220107231526.1517563-2-richard.purdie@linuxfoundation.org>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Wed, 19 Jan 2022 23:16:02 +0000
Message-ID: 
 <CANPvuRkZj_WKgLzUE8vu-15e8RMXWqLwg=5B3SzYeDhdkj+COw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 2/2] bitbake-worker: Add/support network
 task flag
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000006f21f505d5f792ab"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Jan 2022 23:16:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13248

--0000000000006f21f505d5f792ab
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Richard,

Unfortunately this patch breaks the usage of the icecc.bbclass.

Currently I build with icecc inside a container with network isolation and
my icecc demon runs outside of the container.
The only thing I need to do for using the icecc inside my build container i=
s
mounting the unix /var/run/icecc/iceccd.socket inside the container.

I think that we need something like this functionality to have access to
some sockets connections inside the tasks with the new namespace.

Jose


Richard Purdie <richard.purdie@linuxfoundation.org> escreveu no dia sexta,
7/01/2022 =C3=A0(s) 23:15:

> This patch changes behaviour. After this change any task which does not
> have the network flag set will have networking disabled on systems that
> support that (kernel version dependent).
>
> Add a "network" task specific flag which then triggers networking to
> be enabled for this task, it is otherwise disabled.
>
> This needs to happen before we enter the fakeroot environment of the task
> due to the need for the real uid/gid which we save in the parent process.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  bin/bitbake-worker | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/bin/bitbake-worker b/bin/bitbake-worker
> index bf96207edc..3aaf3c2444 100755
> --- a/bin/bitbake-worker
> +++ b/bin/bitbake-worker
> @@ -152,6 +152,10 @@ def fork_off_task(cfg, data, databuilder, workerdata=
,
> fn, task, taskname, taskha
>      fakeenv =3D {}
>      umask =3D None
>
> +    uid =3D os.getuid()
> +    gid =3D os.getgid()
> +
> +
>      taskdep =3D workerdata["taskdeps"][fn]
>      if 'umask' in taskdep and taskname in taskdep['umask']:
>          umask =3D taskdep['umask'][taskname]
> @@ -257,6 +261,10 @@ def fork_off_task(cfg, data, databuilder, workerdata=
,
> fn, task, taskname, taskha
>
>                  bb.utils.set_process_name("%s:%s" %
> (the_data.getVar("PN"), taskname.replace("do_", "")))
>
> +                if not the_data.getVarFlag(taskname, 'network', False):
> +                    logger.debug("Attempting to disable network")
> +                    bb.utils.disable_network(uid, gid)
> +
>                  # exported_vars() returns a generator which *cannot* be
> passed to os.environ.update()
>                  # successfully. We also need to unset anything from the
> environment which shouldn't be there
>                  exports =3D bb.data.exported_vars(the_data)
> --
> 2.32.0
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13225):
> https://lists.openembedded.org/g/bitbake-devel/message/13225
> Mute This Topic: https://lists.openembedded.org/mt/88273738/5052612
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> quaresma.jose@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--=20
Best regards,

Jos=C3=A9 Quaresma

--0000000000006f21f505d5f792ab
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Richard,<div><br></div><div>Unfortunately this patch br=
eaks the usage of the icecc.bbclass.</div><div><br></div><div>Currently I b=
uild with icecc inside a container with network isolation and</div><div>my =
icecc demon=C2=A0runs outside of the container.</div><div>The only thing I =
need to do for using the icecc inside my build container is<br></div><div>m=
ounting the unix /var/run/icecc/iceccd.socket inside the container.</div><d=
iv><br></div><div>I think that we need something like this functionality to=
 have access=C2=A0to</div><div>some sockets connections=C2=A0inside the tas=
ks with the new namespace.</div><div><br></div><div>Jose</div><div><br></di=
v></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr=
">Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org">=
richard.purdie@linuxfoundation.org</a>&gt; escreveu no dia sexta, 7/01/2022=
 =C3=A0(s) 23:15:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">This patch changes behaviour. After this change any task which does not<b=
r>
have the network flag set will have networking disabled on systems that<br>
support that (kernel version dependent).<br>
<br>
Add a &quot;network&quot; task specific flag which then triggers networking=
 to<br>
be enabled for this task, it is otherwise disabled.<br>
<br>
This needs to happen before we enter the fakeroot environment of the task<b=
r>
due to the need for the real uid/gid which we save in the parent process.<b=
r>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;<b=
r>
---<br>
=C2=A0bin/bitbake-worker | 8 ++++++++<br>
=C2=A01 file changed, 8 insertions(+)<br>
<br>
diff --git a/bin/bitbake-worker b/bin/bitbake-worker<br>
index bf96207edc..3aaf3c2444 100755<br>
--- a/bin/bitbake-worker<br>
+++ b/bin/bitbake-worker<br>
@@ -152,6 +152,10 @@ def fork_off_task(cfg, data, databuilder, workerdata, =
fn, task, taskname, taskha<br>
=C2=A0 =C2=A0 =C2=A0fakeenv =3D {}<br>
=C2=A0 =C2=A0 =C2=A0umask =3D None<br>
<br>
+=C2=A0 =C2=A0 uid =3D os.getuid()<br>
+=C2=A0 =C2=A0 gid =3D os.getgid()<br>
+<br>
+<br>
=C2=A0 =C2=A0 =C2=A0taskdep =3D workerdata[&quot;taskdeps&quot;][fn]<br>
=C2=A0 =C2=A0 =C2=A0if &#39;umask&#39; in taskdep and taskname in taskdep[&=
#39;umask&#39;]:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0umask =3D taskdep[&#39;umask&#39;][taskna=
me]<br>
@@ -257,6 +261,10 @@ def fork_off_task(cfg, data, databuilder, workerdata, =
fn, task, taskname, taskha<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.utils.set_=
process_name(&quot;%s:%s&quot; % (the_data.getVar(&quot;PN&quot;), taskname=
.replace(&quot;do_&quot;, &quot;&quot;)))<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not the_data.ge=
tVarFlag(taskname, &#39;network&#39;, False):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 logg=
er.debug(&quot;Attempting to disable network&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.u=
tils.disable_network(uid, gid)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# exported_va=
rs() returns a generator which *cannot* be passed to os.environ.update() <b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# successfull=
y. We also need to unset anything from the environment which shouldn&#39;t =
be there <br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exports =3D b=
b.data.exported_vars(the_data)<br>
-- <br>
2.32.0<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#13225): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/13225" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/13225</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/88273738/5052=
612" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/88273738/5052612</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:quaresma.jose@gmail.com" target=3D=
"_blank">quaresma.jose@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr">Best regards,<div><br>Jos=C3=A9=
 Quaresma</div></div></div>

--0000000000006f21f505d5f792ab--

