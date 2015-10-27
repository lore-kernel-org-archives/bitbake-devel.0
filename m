Return-Path: <srifenbark@gmail.com>
Received: from mail-oi0-f53.google.com (mail-oi0-f53.google.com
	[209.85.218.53])
	by mail.openembedded.org (Postfix) with ESMTP id 26D3275D4A
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Oct 2015 13:34:06 +0000 (UTC)
Received: by oies66 with SMTP id s66so119633929oie.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Oct 2015 06:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=CwsUwpE2KezOrJUHWl9JXu5KBnCqt2+mmHqvOFaHjos=;
	b=zYvQeFD4kiB88YumlLNk9ZLoiBehJYhR7PRkIApHO5eZF9FpZbZ7LwjYrbC/9yJJDX
	JIV5uIm/PmqIePq/d9ot5gjqwyYD4BFMhhw+U8WOpzAho8q5F4BwVOvsUzYFEwZxnKW1
	yFZqTQkAtlMzEQMSDNfvdP/q0mnop07LDp6LikPhYU88hp/sM9m3NQMCsb+F++6Jx6Lt
	gDyse1mYJ9QZQXQn+w1Tz2hS104T+pOJa/hfO477U39zeldRtxQnisKOjNQXFpmtl91t
	YyhnVTOIjIi3q7PYa8WoWDzHx1R10sp+9HHDAfJYrv65fuT6xeipRBQCriSMgwcJDK05
	FR3Q==
MIME-Version: 1.0
X-Received: by 10.202.105.84 with SMTP id e81mr6183715oic.30.1445952846897;
	Tue, 27 Oct 2015 06:34:06 -0700 (PDT)
Received: by 10.60.142.231 with HTTP; Tue, 27 Oct 2015 06:34:06 -0700 (PDT)
In-Reply-To: <1445681946.21913.52.camel@linuxfoundation.org>
References: <1445681946.21913.52.camel@linuxfoundation.org>
Date: Tue, 27 Oct 2015 06:34:06 -0700
Message-ID: <CAFNP8Ou+cT0_-AHbwOf2s-HgZgL8TWbx-_JpdxNLqJZ+n2HYQw@mail.gmail.com>
From: Scott Rifenbark <srifenbark@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
X-Mailman-Approved-At: Wed, 28 Oct 2015 20:40:56 +0000
Cc: "Avery, Brian" <brian.avery@intel.com>,
	Tracy Graydon <tracy.graydon@intel.com>, "Witt,
	Randy E" <randy.e.witt@intel.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] build/utils: Add BB_TASK_IONICE_LEVEL support
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
X-List-Received-Date: Tue, 27 Oct 2015 13:34:07 -0000
Content-Type: multipart/alternative; boundary=001a1141b624cd27860523162166

--001a1141b624cd27860523162166
Content-Type: text/plain; charset=UTF-8

Hi,

See
http://www.yoctoproject.org/docs/2.0/bitbake-user-manual/bitbake-user-manual.html#var-BB_TASK_IONICE_LEVEL
for the new variable description in the BitBake User Manual.  Note that I
did not include the future implementation information at the bottom of
Richard's explanation.  Also, there is a bit about the 'cfq scheduler' near
the end.  I did not know how to properly format this string (e.g. CFG
Scheduler).

Let me know of any changes or fixes.

Thanks,
Scott

On Sat, Oct 24, 2015 at 3:19 AM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> Similarly to BB_TASK_NICE_LEVEL, add BB_TASK_IONICE_LEVEL which allows the
> ioprio
> of tasks to be adjusted. This is in response to various qemu runtime
> timeouts
> which have been witnessed on the autobuilder, seemingly due to IO
> starvation (we
> already use NICE_LEVEL to adjust tasks). This has a fairly urgent need to
> deal
> with certain 'random' failures we're seeing on the autobuilders in testing.
>
> The format of the data in the variable is BB_TASK_IONICE_LEVEL =
> "<class>.<prio>".
>
> For <class>, 2 is best effort (the default), 1 is real time and 3 is idle.
> You'd
> need superuser privileges to use realtime. The <prio> value is a default
> of 4,
> and can be set between 0 and 7 with 7 being lowest priority and 0 the
> highest.
> The user can set this freely with normal privileges
>
> Note that in order for this to take effect, you need the cfq scheduler
> selected
> for the backing block device.
>
> We could use nice wrapper functions for ioprio from modules like psutil
> however
> that would complicate bitbake dependencies. This version has some magic
> numbers
> but works on the main 32 and 64 bit x86 build architectures and can easily
> be
> extended if ever needed. When we move to python 3.x, we can likely replace
> this
> with standard calls.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>
> diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
> index 948c395..22428a6 100644
> --- a/bitbake/lib/bb/build.py
> +++ b/bitbake/lib/bb/build.py
> @@ -413,6 +413,13 @@ def _exec_task(fn, task, d, quieterr):
>          nice = int(nice) - curnice
>          newnice = os.nice(nice)
>          logger.debug(1, "Renice to %s " % newnice)
> +    ionice = localdata.getVar("BB_TASK_IONICE_LEVEL", True)
> +    if ionice:
> +        try:
> +            cls, prio = ionice.split(".", 1)
> +            bb.utils.ioprio_set(os.getpid(), int(cls), int(prio))
> +        except:
> +            bb.warn("Invalid ionice level %s" % ionice)
>
>      bb.utils.mkdirhier(tempdir)
>
> diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
> index eb219c1..86a5328 100644
> --- a/bitbake/lib/bb/utils.py
> +++ b/bitbake/lib/bb/utils.py
> @@ -1310,3 +1310,27 @@ def signal_on_parent_exit(signame):
>      result = cdll['libc.so.6'].prctl(PR_SET_PDEATHSIG, signum)
>      if result != 0:
>          raise PrCtlError('prctl failed with error code %s' % result)
> +
> +#
> +# Manually call the ioprio syscall. We could depend on other libs like
> psutil
> +# however this gets us enough of what we need to bitbake for now without
> the
> +# dependency
> +#
> +_unamearch = os.uname()[4]
> +IOPRIO_WHO_PROCESS = 1
> +IOPRIO_CLASS_SHIFT = 13
> +
> +def ioprio_set(who, cls, value):
> +    NR_ioprio_set = None
> +    if _unamearch == "x86_64":
> +      NR_ioprio_set = 251
> +    elif _unamearch[0] == "i" and _unamearch[2:3] == "86":
> +      NR_ioprio_set = 289
> +
> +    if NR_ioprio_set:
> +        ioprio = value | (cls << IOPRIO_CLASS_SHIFT)
> +        rc = cdll['libc.so.6'].syscall(NR_ioprio_set, IOPRIO_WHO_PROCESS,
> who, ioprio)
> +        if rc != 0:
> +            raise ValueError("Unable to set ioprio, syscall returned %s"
> % rc)
> +    else:
> +        bb.warn("Unable to set IO Prio for arch %s" % _unamearch)
>
>
>

--001a1141b624cd27860523162166
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div>Hi, <br><br></div>See <a href=3D"http:=
//www.yoctoproject.org/docs/2.0/bitbake-user-manual/bitbake-user-manual.htm=
l#var-BB_TASK_IONICE_LEVEL">http://www.yoctoproject.org/docs/2.0/bitbake-us=
er-manual/bitbake-user-manual.html#var-BB_TASK_IONICE_LEVEL</a> for the new=
 variable description in the BitBake User Manual.=C2=A0 Note that I did not=
 include the future implementation information at the bottom of Richard&#39=
;s explanation.=C2=A0 Also, there is a bit about the &#39;cfq scheduler&#39=
; near the end.=C2=A0 I did not know how to properly format this string (e.=
g. CFG Scheduler).<br><br></div>Let me know of any changes or fixes. <br><b=
r></div>Thanks, <br></div>Scott<br></div><div class=3D"gmail_extra"><br><di=
v class=3D"gmail_quote">On Sat, Oct 24, 2015 at 3:19 AM, Richard Purdie <sp=
an dir=3D"ltr">&lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org" ta=
rget=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;</span> wrote:<br=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">Similarly to BB_TASK_NICE_LEVEL, add BB_TAS=
K_IONICE_LEVEL which allows the ioprio<br>
of tasks to be adjusted. This is in response to various qemu runtime timeou=
ts<br>
which have been witnessed on the autobuilder, seemingly due to IO starvatio=
n (we<br>
already use NICE_LEVEL to adjust tasks). This has a fairly urgent need to d=
eal<br>
with certain &#39;random&#39; failures we&#39;re seeing on the autobuilders=
 in testing.<br>
<br>
The format of the data in the variable is BB_TASK_IONICE_LEVEL =3D &quot;&l=
t;class&gt;.&lt;prio&gt;&quot;.<br>
<br>
For &lt;class&gt;, 2 is best effort (the default), 1 is real time and 3 is =
idle. You&#39;d<br>
need superuser privileges to use realtime. The &lt;prio&gt; value is a defa=
ult of 4,<br>
and can be set between 0 and 7 with 7 being lowest priority and 0 the highe=
st.<br>
The user can set this freely with normal privileges<br>
<br>
Note that in order for this to take effect, you need the cfq scheduler sele=
cted<br>
for the backing block device.<br>
<br>
We could use nice wrapper functions for ioprio from modules like psutil how=
ever<br>
that would complicate bitbake dependencies. This version has some magic num=
bers<br>
but works on the main 32 and 64 bit x86 build architectures and can easily =
be<br>
extended if ever needed. When we move to python 3.x, we can likely replace =
this<br>
with standard calls.<br>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org">richard.purdie@linuxfoundation.org</a>&gt;<br>
<br>
diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py<br>
index 948c395..22428a6 100644<br>
--- a/bitbake/lib/bb/build.py<br>
+++ b/bitbake/lib/bb/build.py<br>
@@ -413,6 +413,13 @@ def _exec_task(fn, task, d, quieterr):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nice =3D int(nice) - curnice<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0newnice =3D os.nice(nice)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger.debug(1, &quot;Renice to %s &quot;=
 % newnice)<br>
+=C2=A0 =C2=A0 ionice =3D localdata.getVar(&quot;BB_TASK_IONICE_LEVEL&quot;=
, True)<br>
+=C2=A0 =C2=A0 if ionice:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cls, prio =3D ionice.split(&quot=
;.&quot;, 1)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.utils.ioprio_set(os.getpid(),=
 int(cls), int(prio))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 except:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.warn(&quot;Invalid ionice lev=
el %s&quot; % ionice)<br>
<br>
=C2=A0 =C2=A0 =C2=A0bb.utils.mkdirhier(tempdir)<br>
<br>
diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py<br>
index eb219c1..86a5328 100644<br>
--- a/bitbake/lib/bb/utils.py<br>
+++ b/bitbake/lib/bb/utils.py<br>
@@ -1310,3 +1310,27 @@ def signal_on_parent_exit(signame):<br>
=C2=A0 =C2=A0 =C2=A0result =3D cdll[&#39;libc.so.6&#39;].prctl(PR_SET_PDEAT=
HSIG, signum)<br>
=C2=A0 =C2=A0 =C2=A0if result !=3D 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise PrCtlError(&#39;prctl failed with e=
rror code %s&#39; % result)<br>
+<br>
+#<br>
+# Manually call the ioprio syscall. We could depend on other libs like psu=
til<br>
+# however this gets us enough of what we need to bitbake for now without t=
he<br>
+# dependency<br>
+#<br>
+_unamearch =3D os.uname()[4]<br>
+IOPRIO_WHO_PROCESS =3D 1<br>
+IOPRIO_CLASS_SHIFT =3D 13<br>
+<br>
+def ioprio_set(who, cls, value):<br>
+=C2=A0 =C2=A0 NR_ioprio_set =3D None<br>
+=C2=A0 =C2=A0 if _unamearch =3D=3D &quot;x86_64&quot;:<br>
+=C2=A0 =C2=A0 =C2=A0 NR_ioprio_set =3D 251<br>
+=C2=A0 =C2=A0 elif _unamearch[0] =3D=3D &quot;i&quot; and _unamearch[2:3] =
=3D=3D &quot;86&quot;:<br>
+=C2=A0 =C2=A0 =C2=A0 NR_ioprio_set =3D 289<br>
+<br>
+=C2=A0 =C2=A0 if NR_ioprio_set:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ioprio =3D value | (cls &lt;&lt; IOPRIO_CLASS_=
SHIFT)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D cdll[&#39;libc.so.6&#39;].syscall(NR_io=
prio_set, IOPRIO_WHO_PROCESS, who, ioprio)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if rc !=3D 0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise ValueError(&quot;Unable to=
 set ioprio, syscall returned %s&quot; % rc)<br>
+=C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.warn(&quot;Unable to set IO Prio for arch %=
s&quot; % _unamearch)<br>
<br>
<br>
</blockquote></div><br></div>

--001a1141b624cd27860523162166--
