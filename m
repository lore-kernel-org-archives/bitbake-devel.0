Return-Path: <Martin.Jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9E0C433FE
	for <webhook@archiver.kernel.org>; Fri, 21 Oct 2022 08:43:16 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web11.7897.1666341787192717911
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Oct 2022 01:43:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=kbKpTO/t;
 spf=pass (domain: gmail.com, ip: 209.85.221.50, mailfrom: martin.jansa@gmail.com)
Received: by mail-wr1-f50.google.com with SMTP id b4so3788013wrs.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 21 Oct 2022 01:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PTdsGSA0AF2+u+g1n2jEJbYj5hivQOWamh0VTNvtsXM=;
        b=kbKpTO/tPMmMvvy++hJjiBY0xNgKYYgGWLY1ZCg4IwI8nEVwlRRWYjBNTL19BEyNwJ
         qgIB35jFVR7NxfXlknFRGOL3eWuIE5tzJoa93qYADI7lh9ZrU3jCGMloGbh74zT7Uqba
         VbSEnwRtL54zdhHexzG9iWyKg+XGHYMEvQt2FQTy5BMhIaYLefd0muiUnnJXlUw3mva8
         qhGdO49TqioalocNt/0DqrphlBCiyvAs55E4qGNC+m88aO8YcID+YKxuLljAjLBgm5NU
         ZZIQkl0oobCB3uHbQuPSgRkj9s2kO2oIOsThtt09Ng8o0OlDkJV9XyHAXmR8GlzeyAkc
         OUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PTdsGSA0AF2+u+g1n2jEJbYj5hivQOWamh0VTNvtsXM=;
        b=MeUY03MBcIbNkwnVGgFRLUZf21mooJ5MDMpJM2FhrCkAmTrMzaGp1eiJmGrjKkVUR1
         P6uEliiwzlvJIhj+nBBky8ojruxB+6yjhPLNQ7vE7NJR3fhqqrbUQDsSKExX4dhFClt/
         yvsWHveb6xXmB8C7LVdPMt36XZz2EzoS9yVa9aRzsNQ5abYO5KDCzbvj2vrvOVh/+q1Z
         AP93DdbIGzBxKCNR76QxFzZFgNZZZoZYEM+GDuE25FSyYN8o48IHsewYuleWA4rxSr5N
         SvDF/vRU+mU/916UffyZ5L0X+gVhAgzk1FtrQ9zowmJPWENjfGzE62d6fZtXQ3+dWxgo
         HBwQ==
X-Gm-Message-State: ACrzQf046xu/FELCjOMRgQHP24DDVRJTkA9sm/URQhcXc8xpxut6cSTO
	p7+G0BPnSXoSv1ZPUmD8UZBUJojAQPB41Dngt8s=
X-Google-Smtp-Source: AMsMyM68ttWBSXsW2fQmCOVhXj5LzVcnNutfzosxqqYpXPIhjgTWXScXN2LiGo5DWSY0GlVCc8XyTRATReazeV+uzXw=
X-Received: by 2002:a5d:64e2:0:b0:22e:7060:b4a7 with SMTP id
 g2-20020a5d64e2000000b0022e7060b4a7mr10896837wri.129.1666341785516; Fri, 21
 Oct 2022 01:43:05 -0700 (PDT)
MIME-Version: 1.0
References: <20221021083401.2940299-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20221021083401.2940299-1-alexandre.belloni@bootlin.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Fri, 21 Oct 2022 10:42:45 +0200
Message-ID: <CA+chaQeTRVgWi9GVFvoYAGuR5EZPWOVMdwii0Dpcf_aueNXokw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bb.tests.fetch.GitShallowTest: always
 allow file transport
To: alexandre.belloni@bootlin.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000033414a05eb876e9c"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Oct 2022 08:43:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14045

--00000000000033414a05eb876e9c
Content-Type: text/plain; charset="UTF-8"

Not sure how to fix it, but before adding more "-c
core.fsyncobjectfiles=0", please check
https://bugzilla.yoctoproject.org/show_bug.cgi?id=14939

On Fri, Oct 21, 2022 at 10:34 AM Alexandre Belloni via
lists.openembedded.org <alexandre.belloni=bootlin.com@lists.openembedded.org>
wrote:

> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
>
> Following CVE-2022-39253, distributions are disabling file:// transport for
> submodules. See
> https://git.launchpad.net/ubuntu/+source/git/tree/debian/patches/CVE-2022-39253-11.patch?h=applied/ubuntu/jammy-security
>
> [YOCTO #14941]
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  lib/bb/tests/fetch.py | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
> index b4ed691f3319..4ef2ed2b66b8 100644
> --- a/lib/bb/tests/fetch.py
> +++ b/lib/bb/tests/fetch.py
> @@ -1865,6 +1865,9 @@ class GitShallowTest(FetcherTest):
>          # Make this look like it was cloned from a remote...
>          self.git('config --add remote.origin.url "%s"' % smdir, cwd=smdir)
>          self.git('config --add remote.origin.fetch
> "+refs/heads/*:refs/remotes/origin/*"', cwd=smdir)
> +
> +        self.d.setVar('FETCHCMD_git', "git -c core.fsyncobjectfiles=0 -c
> gc.autoDetach=false -c core.pager=cat -c protocol.file.allow=always")
> +
>          self.add_empty_file('asub', cwd=smdir)
>          self.add_empty_file('bsub', cwd=smdir)
>
> @@ -1898,6 +1901,8 @@ class GitShallowTest(FetcherTest):
>          self.add_empty_file('asub', cwd=smdir)
>          self.add_empty_file('bsub', cwd=smdir)
>
> +        self.d.setVar('FETCHCMD_git', "git -c core.fsyncobjectfiles=0 -c
> gc.autoDetach=false -c core.pager=cat -c protocol.file.allow=always")
> +
>          self.git('submodule init', cwd=self.srcdir)
>          self.git('submodule add file://%s' % smdir, cwd=self.srcdir)
>          self.git('submodule update', cwd=self.srcdir)
> --
> 2.37.3
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14044):
> https://lists.openembedded.org/g/bitbake-devel/message/14044
> Mute This Topic: https://lists.openembedded.org/mt/94472006/3617156
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> Martin.Jansa@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

--00000000000033414a05eb876e9c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Not sure how to fix it, but before adding more &quot;-c co=
re.fsyncobjectfiles=3D0&quot;, please check=C2=A0<a href=3D"https://bugzill=
a.yoctoproject.org/show_bug.cgi?id=3D14939">https://bugzilla.yoctoproject.o=
rg/show_bug.cgi?id=3D14939</a></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Fri, Oct 21, 2022 at 10:34 AM Alexandre Be=
lloni via <a href=3D"http://lists.openembedded.org">lists.openembedded.org<=
/a> &lt;alexandre.belloni=3D<a href=3D"mailto:bootlin.com@lists.openembedde=
d.org">bootlin.com@lists.openembedded.org</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">From: Alexandre Belloni &lt;<a hre=
f=3D"mailto:alexandre.belloni@bootlin.com" target=3D"_blank">alexandre.bell=
oni@bootlin.com</a>&gt;<br>
<br>
Following CVE-2022-39253, distributions are disabling file:// transport for=
<br>
submodules. See <a href=3D"https://git.launchpad.net/ubuntu/+source/git/tre=
e/debian/patches/CVE-2022-39253-11.patch?h=3Dapplied/ubuntu/jammy-security"=
 rel=3D"noreferrer" target=3D"_blank">https://git.launchpad.net/ubuntu/+sou=
rce/git/tree/debian/patches/CVE-2022-39253-11.patch?h=3Dapplied/ubuntu/jamm=
y-security</a><br>
<br>
[YOCTO #14941]<br>
<br>
Signed-off-by: Alexandre Belloni &lt;<a href=3D"mailto:alexandre.belloni@bo=
otlin.com" target=3D"_blank">alexandre.belloni@bootlin.com</a>&gt;<br>
---<br>
=C2=A0lib/bb/tests/fetch.py | 5 +++++<br>
=C2=A01 file changed, 5 insertions(+)<br>
<br>
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py<br>
index b4ed691f3319..4ef2ed2b66b8 100644<br>
--- a/lib/bb/tests/fetch.py<br>
+++ b/lib/bb/tests/fetch.py<br>
@@ -1865,6 +1865,9 @@ class GitShallowTest(FetcherTest):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Make this look like it was cloned from =
a remote...<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.git(&#39;config --add remote.origin.=
url &quot;%s&quot;&#39; % smdir, cwd=3Dsmdir)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.git(&#39;config --add remote.origin.=
fetch &quot;+refs/heads/*:refs/remotes/origin/*&quot;&#39;, cwd=3Dsmdir)<br=
>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.d.setVar(&#39;FETCHCMD_git&#39;, &quot;gi=
t -c core.fsyncobjectfiles=3D0 -c gc.autoDetach=3Dfalse -c core.pager=3Dcat=
 -c protocol.file.allow=3Dalways&quot;)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.add_empty_file(&#39;asub&#39;, cwd=
=3Dsmdir)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.add_empty_file(&#39;bsub&#39;, cwd=
=3Dsmdir)<br>
<br>
@@ -1898,6 +1901,8 @@ class GitShallowTest(FetcherTest):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.add_empty_file(&#39;asub&#39;, cwd=
=3Dsmdir)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.add_empty_file(&#39;bsub&#39;, cwd=
=3Dsmdir)<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.d.setVar(&#39;FETCHCMD_git&#39;, &quot;gi=
t -c core.fsyncobjectfiles=3D0 -c gc.autoDetach=3Dfalse -c core.pager=3Dcat=
 -c protocol.file.allow=3Dalways&quot;)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.git(&#39;submodule init&#39;, cwd=3D=
self.srcdir)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.git(&#39;submodule add file://%s&#39=
; % smdir, cwd=3Dself.srcdir)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.git(&#39;submodule update&#39;, cwd=
=3Dself.srcdir)<br>
-- <br>
2.37.3<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#14044): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/14044" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/14044</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/94472006/3617=
156" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/94472006/3617156</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:Martin.Jansa@gmail.com" target=3D"=
_blank">Martin.Jansa@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--00000000000033414a05eb876e9c--

