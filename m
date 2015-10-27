Return-Path: <srifenbark@gmail.com>
Received: from mail-ob0-f173.google.com (mail-ob0-f173.google.com
	[209.85.214.173])
	by mail.openembedded.org (Postfix) with ESMTP id 4543475D4A
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Oct 2015 15:09:38 +0000 (UTC)
Received: by obcqt19 with SMTP id qt19so172435486obc.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Oct 2015 08:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=z4+JmQCbB139RPDdVqu6IKYRF0S/8FSw8KfI4VOy+Bg=;
	b=Mz/ZAOng0BFojJF7EsnycWzPllIB8yfS1S0eGiliWvXz2OyCLudgRQkjGtB06/zc+o
	jUWNBa/YqvtIBLy33WvN05y4M7GF6WSvmxrrltYUVxq+jlK/hydfUTNkTIhEPackPF0e
	MPzHiLJFO5AOwq6XSUENSLQbk//ixn4WtSAaJTZsyy3k6kMLtqFa7K9HHFQkCeS9MQWV
	/3Mb1BGAeOU2qViSgiR7NM7RySrZXXBY0RIAy3eson1MZaAuDyzzWIK20pNL+li0RTBi
	xdbKANTAy/hnkjRsFj4xncCXv32PGVxTEBqov/ZGGayfCVibqN1HFfHcBi1AagQJgqiM
	LcmA==
MIME-Version: 1.0
X-Received: by 10.182.130.234 with SMTP id oh10mr29867712obb.58.1445958578618; 
	Tue, 27 Oct 2015 08:09:38 -0700 (PDT)
Received: by 10.60.142.231 with HTTP; Tue, 27 Oct 2015 08:09:38 -0700 (PDT)
In-Reply-To: <D254DE63.4385C%brian.avery@intel.com>
References: <1445681946.21913.52.camel@linuxfoundation.org>
	<CAFNP8Ou+cT0_-AHbwOf2s-HgZgL8TWbx-_JpdxNLqJZ+n2HYQw@mail.gmail.com>
	<D254DE63.4385C%brian.avery@intel.com>
Date: Tue, 27 Oct 2015 08:09:38 -0700
Message-ID: <CAFNP8Ovd0MCZS8cpZGtoECxHDdzio1FLEwYLUcySJUDrXjoKyw@mail.gmail.com>
From: Scott Rifenbark <srifenbark@gmail.com>
To: "Avery, Brian" <brian.avery@intel.com>
X-Mailman-Approved-At: Wed, 28 Oct 2015 20:40:56 +0000
Cc: "Graydon, Tracy" <tracy.graydon@intel.com>, "Witt,
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
X-List-Received-Date: Tue, 27 Oct 2015 15:09:40 -0000
Content-Type: multipart/alternative; boundary=089e013a01127048630523177764

--089e013a01127048630523177764
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2015 at 7:59 AM, Avery, Brian <brian.avery@intel.com> wrote=
:

> Hi,
>
> It mostly appears as CFQ scheduler (Completely Fair Queuing).  Since we
> tell them to set it to cfq, it might be nice to tell them to do this by
> doing sudo sh -c =E2=80=9Cecho cfq > /sys/block/<device>/queu/scheduler; =
where
> device is the backing block device e.g. sda,sdb,=E2=80=A6
>

Brian - I updated that note accordingly.  Is "queu" correct?  Or should it
be "queue"?

Thanks

>
> -b
>
> From: Scott Rifenbark <srifenbark@gmail.com>
> Date: Tuesday, October 27, 2015 at 6:34 AM
> To: Richard Purdie <richard.purdie@linuxfoundation.org>
> Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>, Brian Avery <
> brian.avery@intel.com>, "Witt, Randy E" <randy.e.witt@intel.com>,
> "Flanagan, Elizabeth" <elizabeth.flanagan@intel.com>, "Graydon, Tracy" <
> tracy.graydon@intel.com>, Michael Halstead <michael@yoctoproject.org>
> Subject: Re: [PATCH] build/utils: Add BB_TASK_IONICE_LEVEL support
>
> Hi,
>
> See
> http://www.yoctoproject.org/docs/2.0/bitbake-user-manual/bitbake-user-man=
ual.html#var-BB_TASK_IONICE_LEVEL
> for the new variable description in the BitBake User Manual.  Note that I
> did not include the future implementation information at the bottom of
> Richard's explanation.  Also, there is a bit about the 'cfq scheduler' ne=
ar
> the end.  I did not know how to properly format this string (e.g. CFG
> Scheduler).
>
> Let me know of any changes or fixes.
>
> Thanks,
> Scott
>
> On Sat, Oct 24, 2015 at 3:19 AM, Richard Purdie <
> richard.purdie@linuxfoundation.org> wrote:
>
>> Similarly to BB_TASK_NICE_LEVEL, add BB_TASK_IONICE_LEVEL which allows
>> the ioprio
>> of tasks to be adjusted. This is in response to various qemu runtime
>> timeouts
>> which have been witnessed on the autobuilder, seemingly due to IO
>> starvation (we
>> already use NICE_LEVEL to adjust tasks). This has a fairly urgent need t=
o
>> deal
>> with certain 'random' failures we're seeing on the autobuilders in
>> testing.
>>
>> The format of the data in the variable is BB_TASK_IONICE_LEVEL =3D
>> "<class>.<prio>".
>>
>> For <class>, 2 is best effort (the default), 1 is real time and 3 is
>> idle. You'd
>> need superuser privileges to use realtime. The <prio> value is a default
>> of 4,
>> and can be set between 0 and 7 with 7 being lowest priority and 0 the
>> highest.
>> The user can set this freely with normal privileges
>>
>> Note that in order for this to take effect, you need the cfq scheduler
>> selected
>> for the backing block device.
>>
>> We could use nice wrapper functions for ioprio from modules like psutil
>> however
>> that would complicate bitbake dependencies. This version has some magic
>> numbers
>> but works on the main 32 and 64 bit x86 build architectures and can
>> easily be
>> extended if ever needed. When we move to python 3.x, we can likely
>> replace this
>> with standard calls.
>>
>> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>>
>> diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
>> index 948c395..22428a6 100644
>> --- a/bitbake/lib/bb/build.py
>> +++ b/bitbake/lib/bb/build.py
>> @@ -413,6 +413,13 @@ def _exec_task(fn, task, d, quieterr):
>>          nice =3D int(nice) - curnice
>>          newnice =3D os.nice(nice)
>>          logger.debug(1, "Renice to %s " % newnice)
>> +    ionice =3D localdata.getVar("BB_TASK_IONICE_LEVEL", True)
>> +    if ionice:
>> +        try:
>> +            cls, prio =3D ionice.split(".", 1)
>> +            bb.utils.ioprio_set(os.getpid(), int(cls), int(prio))
>> +        except:
>> +            bb.warn("Invalid ionice level %s" % ionice)
>>
>>      bb.utils.mkdirhier(tempdir)
>>
>> diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
>> index eb219c1..86a5328 100644
>> --- a/bitbake/lib/bb/utils.py
>> +++ b/bitbake/lib/bb/utils.py
>> @@ -1310,3 +1310,27 @@ def signal_on_parent_exit(signame):
>>      result =3D cdll['libc.so.6'].prctl(PR_SET_PDEATHSIG, signum)
>>      if result !=3D 0:
>>          raise PrCtlError('prctl failed with error code %s' % result)
>> +
>> +#
>> +# Manually call the ioprio syscall. We could depend on other libs like
>> psutil
>> +# however this gets us enough of what we need to bitbake for now withou=
t
>> the
>> +# dependency
>> +#
>> +_unamearch =3D os.uname()[4]
>> +IOPRIO_WHO_PROCESS =3D 1
>> +IOPRIO_CLASS_SHIFT =3D 13
>> +
>> +def ioprio_set(who, cls, value):
>> +    NR_ioprio_set =3D None
>> +    if _unamearch =3D=3D "x86_64":
>> +      NR_ioprio_set =3D 251
>> +    elif _unamearch[0] =3D=3D "i" and _unamearch[2:3] =3D=3D "86":
>> +      NR_ioprio_set =3D 289
>> +
>> +    if NR_ioprio_set:
>> +        ioprio =3D value | (cls << IOPRIO_CLASS_SHIFT)
>> +        rc =3D cdll['libc.so.6'].syscall(NR_ioprio_set,
>> IOPRIO_WHO_PROCESS, who, ioprio)
>> +        if rc !=3D 0:
>> +            raise ValueError("Unable to set ioprio, syscall returned %s=
"
>> % rc)
>> +    else:
>> +        bb.warn("Unable to set IO Prio for arch %s" % _unamearch)
>>
>>
>>
>

--089e013a01127048630523177764
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Tue, Oct 27, 2015 at 7:59 AM, Avery, Brian <span dir=3D"ltr">&lt;<a =
href=3D"mailto:brian.avery@intel.com" target=3D"_blank">brian.avery@intel.c=
om</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">



<div style=3D"word-wrap:break-word;color:rgb(0,0,0);font-size:14px;font-fam=
ily:Calibri,sans-serif">
<div>Hi,=C2=A0</div>
<div><br>
</div>
<div>It mostly appears as CFQ scheduler (Completely Fair Queuing).=C2=A0 Si=
nce we tell them to set it to cfq, it might be nice to tell them to do this=
 by doing sudo sh -c =E2=80=9Cecho cfq &gt; /sys/block/&lt;device&gt;/queu/=
scheduler; where device is the backing block device e.g.
 sda,sdb,=E2=80=A6</div></div></blockquote><div><br></div><div>Brian - I up=
dated that note accordingly.=C2=A0 Is &quot;queu&quot; correct?=C2=A0 Or sh=
ould it be &quot;queue&quot;?<br><br></div><div>Thanks <br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex"><div style=3D"word-wrap:break-word;color:rgb(0,0,0);fo=
nt-size:14px;font-family:Calibri,sans-serif">
<div><br>
</div>
<div>-b=C2=A0</div>
<div><br>
</div>
<span>
<div style=3D"font-family:Calibri;font-size:11pt;text-align:left;color:blac=
k;BORDER-BOTTOM:medium none;BORDER-LEFT:medium none;PADDING-BOTTOM:0in;PADD=
ING-LEFT:0in;PADDING-RIGHT:0in;BORDER-TOP:#b5c4df 1pt solid;BORDER-RIGHT:me=
dium none;PADDING-TOP:3pt">
<span style=3D"font-weight:bold">From: </span>Scott Rifenbark &lt;<a href=
=3D"mailto:srifenbark@gmail.com" target=3D"_blank">srifenbark@gmail.com</a>=
&gt;<br>
<span style=3D"font-weight:bold">Date: </span>Tuesday, October 27, 2015 at =
6:34 AM<br>
<span style=3D"font-weight:bold">To: </span>Richard Purdie &lt;<a href=3D"m=
ailto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.purdie@=
linuxfoundation.org</a>&gt;<br>
<span style=3D"font-weight:bold">Cc: </span>bitbake-devel &lt;<a href=3D"ma=
ilto:bitbake-devel@lists.openembedded.org" target=3D"_blank">bitbake-devel@=
lists.openembedded.org</a>&gt;, Brian Avery &lt;<a href=3D"mailto:brian.ave=
ry@intel.com" target=3D"_blank">brian.avery@intel.com</a>&gt;, &quot;Witt, =
Randy E&quot; &lt;<a href=3D"mailto:randy.e.witt@intel.com" target=3D"_blan=
k">randy.e.witt@intel.com</a>&gt;,
 &quot;Flanagan, Elizabeth&quot; &lt;<a href=3D"mailto:elizabeth.flanagan@i=
ntel.com" target=3D"_blank">elizabeth.flanagan@intel.com</a>&gt;, &quot;Gra=
ydon, Tracy&quot; &lt;<a href=3D"mailto:tracy.graydon@intel.com" target=3D"=
_blank">tracy.graydon@intel.com</a>&gt;, Michael Halstead &lt;<a href=3D"ma=
ilto:michael@yoctoproject.org" target=3D"_blank">michael@yoctoproject.org</=
a>&gt;<br>
<span style=3D"font-weight:bold">Subject: </span>Re: [PATCH] build/utils: A=
dd BB_TASK_IONICE_LEVEL support<br>
</div><div><div class=3D"h5">
<div><br>
</div>
<div>
<div>
<div dir=3D"ltr">
<div>
<div>
<div>
<div>Hi, <br>
<br>
</div>
See <a href=3D"http://www.yoctoproject.org/docs/2.0/bitbake-user-manual/bit=
bake-user-manual.html#var-BB_TASK_IONICE_LEVEL" target=3D"_blank">
http://www.yoctoproject.org/docs/2.0/bitbake-user-manual/bitbake-user-manua=
l.html#var-BB_TASK_IONICE_LEVEL</a> for the new variable description in the=
 BitBake User Manual.=C2=A0 Note that I did not include the future implemen=
tation information at the bottom of Richard&#39;s
 explanation.=C2=A0 Also, there is a bit about the &#39;cfq scheduler&#39; =
near the end.=C2=A0 I did not know how to properly format this string (e.g.=
 CFG Scheduler).<br>
<br>
</div>
Let me know of any changes or fixes. <br>
<br>
</div>
Thanks, <br>
</div>
Scott<br>
</div>
<div class=3D"gmail_extra"><br>
<div class=3D"gmail_quote">On Sat, Oct 24, 2015 at 3:19 AM, Richard Purdie =
<span dir=3D"ltr">
&lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank"=
>richard.purdie@linuxfoundation.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Similarly to BB_TASK_NICE_LEVEL, add BB_TASK_IONICE_LEVEL which allows the =
ioprio<br>
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
ndation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;<b=
r>
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
</blockquote>
</div>
<br>
</div>
</div>
</div>
</div></div></span>
</div>

</blockquote></div><br></div></div>

--089e013a01127048630523177764--
