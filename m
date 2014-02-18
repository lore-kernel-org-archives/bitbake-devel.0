Return-Path: <alex.r.damian@gmail.com>
Received: from mail-qc0-f182.google.com (mail-qc0-f182.google.com
	[209.85.216.182])
	by mail.openembedded.org (Postfix) with ESMTP id EECAF6EB0A
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Feb 2014 17:42:22 +0000 (UTC)
Received: by mail-qc0-f182.google.com with SMTP id c9so25821797qcz.41
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Feb 2014 09:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=7b2v4uMgPhLncUrTyQlM2gtXHtTvQHipZ4p9YUzrwEg=;
	b=yksfysAuKheQxkvc0fFFxnmJy5NOZHRH6w0E3x2mBcDBQSOhu9GaK0V01VpzOTbgKh
	fhQU4/ghCVT33fKQU4Ompb2ROki2FiKneOa5HBnogij6B+sJ9EUYeE04DJ7n0Ex3f/Xs
	nKp2uaC15huWoSGPiFN/44QhfPDUBip3F0BNdmo7shgQXLDdZrV3ZJRTBz7frUumoxXx
	SL3OonQbR+JpDrgxto4AUAz7hTayZXtIudJltcqGO+L5hyUF/flszRRgyr0aGz/4OrOx
	GhrOT82nNc9fnqF2YGh7UXH6+4XD/4U12pzMXmfPQjFQiVP6p+0nl2mQN0oq1FspfBys
	0Mqw==
MIME-Version: 1.0
X-Received: by 10.224.53.198 with SMTP id n6mr44547846qag.41.1392745343664;
	Tue, 18 Feb 2014 09:42:23 -0800 (PST)
Received: by 10.224.8.9 with HTTP; Tue, 18 Feb 2014 09:42:23 -0800 (PST)
In-Reply-To: <1392734364-8388-1-git-send-email-marius.avram@intel.com>
References: <1392734364-8388-1-git-send-email-marius.avram@intel.com>
Date: Tue, 18 Feb 2014 17:42:23 +0000
Message-ID: <CAL7ttbdsLwSFAqfzV=D9+YE7mq9jvPT0UKRDr0_2vdRY6U1jNA@mail.gmail.com>
From: Alex Damian <alex.r.damian@gmail.com>
To: Marius Avram <marius.avram@intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bb/ui: store_dependency_information optimization
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
X-List-Received-Date: Tue, 18 Feb 2014 17:42:23 -0000
Content-Type: multipart/alternative; boundary=001a1132f03c78c74f04f2b1cbf8

--001a1132f03c78c74f04f2b1cbf8
Content-Type: text/plain; charset=ISO-8859-1

+1, works nice.


On Tue, Feb 18, 2014 at 2:39 PM, Marius Avram <marius.avram@intel.com>wrote:

> This optimization is in support of the bug #5485. The function called
> at the beginning of every build: store_dependency_information was taking
> approximately 20sec and it was delaying the arrival of events from the
> event queue. The change minimizes the calls to _save_a_task(),
> reducing the time to half.
>
> Signed-off-by: Marius Avram <marius.avram@intel.com>
> ---
>  bitbake/lib/bb/ui/buildinfohelper.py |   16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/bitbake/lib/bb/ui/buildinfohelper.py
> b/bitbake/lib/bb/ui/buildinfohelper.py
> index 0a8073f..da777f1 100644
> --- a/bitbake/lib/bb/ui/buildinfohelper.py
> +++ b/bitbake/lib/bb/ui/buildinfohelper.py
> @@ -605,11 +605,21 @@ class BuildInfoHelper(object):
>              task_info['task_name'] = taskname
>              task_obj = self.orm_wrapper.get_update_task_object(task_info)
>              return task_obj
> +
> +        # create tasks
> +        tasks = {}
> +        for taskdesc in event._depgraph['tdepends']:
> +            tasks[taskdesc] = _save_a_task(taskdesc)
>
> +        # create dependencies between tasks
>          for taskdesc in event._depgraph['tdepends']:
> -            target = _save_a_task(taskdesc)
> -            for taskdesc1 in event._depgraph['tdepends'][taskdesc]:
> -                dep = _save_a_task(taskdesc1)
> +            target = tasks[taskdesc]
> +            for taskdep in event._depgraph['tdepends'][taskdesc]:
> +                if taskdep not in tasks:
> +                    # Fetch tasks info is not collected previously
> +                    dep = _save_a_task(taskdep)
> +                else:
> +                    dep = tasks[taskdep]
>                  Task_Dependency.objects.get_or_create( task = target,
> depends_on = dep )
>
>      def store_build_package_information(self, event):
> --
> 1.7.9.5
>
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>

--001a1132f03c78c74f04f2b1cbf8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">+1, works nice.</div><div class=3D"gmail_extra"><br><br><d=
iv class=3D"gmail_quote">On Tue, Feb 18, 2014 at 2:39 PM, Marius Avram <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:marius.avram@intel.com" target=3D"_blan=
k">marius.avram@intel.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">This optimization is in support of the bug #=
5485. The function called<br>
at the beginning of every build: store_dependency_information was taking<br=
>
approximately 20sec and it was delaying the arrival of events from the<br>
event queue. The change minimizes the calls to _save_a_task(),<br>
reducing the time to half.<br>
<br>
Signed-off-by: Marius Avram &lt;<a href=3D"mailto:marius.avram@intel.com">m=
arius.avram@intel.com</a>&gt;<br>
---<br>
=A0bitbake/lib/bb/ui/buildinfohelper.py | =A0 16 +++++++++++++---<br>
=A01 file changed, 13 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/build=
infohelper.py<br>
index 0a8073f..da777f1 100644<br>
--- a/bitbake/lib/bb/ui/buildinfohelper.py<br>
+++ b/bitbake/lib/bb/ui/buildinfohelper.py<br>
@@ -605,11 +605,21 @@ class BuildInfoHelper(object):<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0task_info[&#39;task_name&#39;] =3D taskname<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0task_obj =3D self.orm_wrapper.get_update_task_ob=
ject(task_info)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0return task_obj<br>
+<br>
+ =A0 =A0 =A0 =A0# create tasks<br>
+ =A0 =A0 =A0 =A0tasks =3D {}<br>
+ =A0 =A0 =A0 =A0for taskdesc in event._depgraph[&#39;tdepends&#39;]:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0tasks[taskdesc] =3D _save_a_task(taskdesc)<br>
<br>
+ =A0 =A0 =A0 =A0# create dependencies between tasks<br>
=A0 =A0 =A0 =A0 =A0for taskdesc in event._depgraph[&#39;tdepends&#39;]:<br>
- =A0 =A0 =A0 =A0 =A0 =A0target =3D _save_a_task(taskdesc)<br>
- =A0 =A0 =A0 =A0 =A0 =A0for taskdesc1 in event._depgraph[&#39;tdepends&#39=
;][taskdesc]:<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dep =3D _save_a_task(taskdesc1)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0target =3D tasks[taskdesc]<br>
+ =A0 =A0 =A0 =A0 =A0 =A0for taskdep in event._depgraph[&#39;tdepends&#39;]=
[taskdesc]:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if taskdep not in tasks:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0# Fetch tasks info is not collecte=
d previously<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dep =3D _save_a_task(taskdep)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dep =3D tasks[taskdep]<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Task_Dependency.objects.get_or_create( t=
ask =3D target, depends_on =3D dep )<br>
<br>
=A0 =A0 =A0def store_build_package_information(self, event):<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.7.9.5<br>
<br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org">bitbake-devel@lists=
.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" ta=
rget=3D"_blank">http://lists.openembedded.org/mailman/listinfo/bitbake-deve=
l</a><br>
</font></span></blockquote></div><br></div>

--001a1132f03c78c74f04f2b1cbf8--
