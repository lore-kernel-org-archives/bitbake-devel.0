Return-Path: <martin.jansa@gmail.com>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail.openembedded.org (Postfix) with ESMTP id 15DFE7DC62
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 30 Apr 2019 12:13:01 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id l2so5076186wrb.9
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 30 Apr 2019 05:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=qokJoPeWRQ/Ph8byJIft4MPNoqJATAMuCmI7af0eKIo=;
	b=nwxGbBos5fYEKBuMaR69dY+Zi3zTBLb/Zj2iCHlnSeYHUJbVeWnfC6W6wX8kVuXx6/
	IODTW7hUIwYJOtaLQOLzZzboB1QPCWquJhTdhfaJ76GR/015+a39LhZi+6DGJlDUbPk7
	7HXW9/Suwh1SiosRw/XRLN8THlSTXK0wTD+ktZjAgqR3Ij9xnLm1783G5RSCPaRGRN8Y
	UBhxwX9Zd0h9rYb22cckmdaZxK+P7HxMjrx5pRr64LTpant2GrewjHniGctkM28zGgA9
	ZhVUA95qewvwPwlD4vTOcXCVcxpAaKr/rrvSDVofCE3J/fo3vSzIkLIE1BI0LI2nF7Nc
	cTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=qokJoPeWRQ/Ph8byJIft4MPNoqJATAMuCmI7af0eKIo=;
	b=rtacyq2pZcho9UIYkIw6WhzFo397Pb+3fjxzsuYebad5xRD2LznpHBp6Q6RxmheBdm
	SWyMhHAjRso8NHuDZGYdt9fB1aG301FyJED5S5cJaYQGIR0KTF7H0Fj+PNvpRN1yeMwL
	num1wItV/f/iQ7smLQlI2Vhc+IgxA64lPAivXv52LU5uAjkKNJuvC5FUqk1k6Z5GfrqO
	mcFfP+J5MsWbYygzgdwduoOR0H8Wy433rYDSw+HRSu9Sh3kq9BugVpuovai2w5o0yeuC
	rCBzV+kIsZgl4bIDGeR83EsDvepjnKqRKJujG/G4nkeKFnEpx82t6fUrJC8bXPlzOOID
	1FKg==
X-Gm-Message-State: APjAAAVtgkPtACUmnkBNIrLete0OwNkYlHXylW6Ve7Lrr1zTIGVnQH7V
	qRjUyS4+rHrbuSUO5oKFz9w2xw9ZuASzhIKwa2AfUXTG
X-Google-Smtp-Source: APXvYqx15uLM7n2Cg7AJcysKJgkJnw/ufmXre6Bi2zFDE4m3CGLpKb43PO53pSNO5zRkoqXmMOgP6GxbAN08TihtUVE=
X-Received: by 2002:adf:eb84:: with SMTP id t4mr9795616wrn.43.1556626382645;
	Tue, 30 Apr 2019 05:13:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556186399.git.liezhi.yang@windriver.com>
	<d37712258af9b6fedb9e1586ace28908bec88391.1556186399.git.liezhi.yang@windriver.com>
	<9f8a038abf7b7eff75038ccef5f066bfd37e58f5.camel@linuxfoundation.org>
	<0c45f88f-6056-2fa6-1db1-f7ce413ba0f3@windriver.com>
In-Reply-To: <0c45f88f-6056-2fa6-1db1-f7ce413ba0f3@windriver.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Tue, 30 Apr 2019 14:13:00 +0200
Message-ID: <CA+chaQfactCL00D9QaVch3BRp4vN2ZFcWYnK9uVsRQcjTCOfrQ@mail.gmail.com>
To: Robert Yang <liezhi.yang@windriver.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 2/2] bitbake: build.py: check dependendent task for addtask
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
X-List-Received-Date: Tue, 30 Apr 2019 12:13:02 -0000
Content-Type: multipart/alternative; boundary="00000000000095ed5a0587be5275"

--00000000000095ed5a0587be5275
Content-Type: text/plain; charset="UTF-8"

I just got few thousands of warnings thanks to this, they might be
legitimate as write_bom_data and write_abi_xml_data are our own tasks added
in
https://github.com/webosose/meta-webosose/blob/master/meta-webos/classes/webos_base.bbclass
very
long time ago (based on fetchall task which was added in 2006 :)) - there
might be better way to add them now, I'll check how to do it better or else
I might need to disable this warning locally.

Based on "utility-tasks: Drop fetchall and checkuriall tasks" I guess the
right way to do the same now will be to convert our scripts to call it
with --runall.

It's pity that the warning is shown repeatedly.

grep -c WARNING:.*dependent.task BUILD/log/cooker/m16p3/console-latest.log
30409

and that was only very small build not even finished yet:
Currently  7 running tasks (1142 of 2514)

..
WARNING: cross-localedef-native: dependent task do_deploy does not exist
WARNING: cross-localedef-native: dependent task do_package_write_ipk does
not exist
WARNING: cross-localedef-native: dependent task do_deploy does not exist
WARNING: cross-localedef-native: dependent task do_package_write_ipk does
not exist
WARNING: cross-localedef-native: dependent task write_bom_data does not
exist
WARNING: cross-localedef-native: dependent task write_abi_xml_data does not
exist
WARNING: autoconf-archive-native: dependent task do_deploy does not exist
WARNING: autoconf-archive-native: dependent task do_package_write_ipk does
not exist
WARNING: autoconf-archive-native: dependent task do_deploy does not exist
WARNING: autoconf-archive-native: dependent task do_package_write_ipk does
not exist
WARNING: autoconf-archive-native: dependent task write_bom_data does not
exist
WARNING: autoconf-archive-native: dependent task write_abi_xml_data does
not exist
WARNING: cross-localedef-native: dependent task do_deploy does not exist
WARNING: cross-localedef-native: dependent task do_package_write_ipk does
not exist
WARNING: cross-localedef-native: dependent task do_deploy does not exist
WARNING: cross-localedef-native: dependent task do_package_write_ipk does
not exist
WARNING: cross-localedef-native: dependent task write_bom_data does not
exist
WARNING: cross-localedef-native: dependent task write_abi_xml_data does not
exist
WARNING: cross-localedef-native: dependent task do_deploy does not exist
WARNING: cross-localedef-native: dependent task do_package_write_ipk does
not exist
WARNING: cross-localedef-native: dependent task do_deploy does not exist
WARNING: cross-localedef-native: dependent task do_package_write_ipk does
not exist
WARNING: cross-localedef-native: dependent task write_bom_data does not
exist
WARNING: cross-localedef-native: dependent task write_abi_xml_data does not
exist
WARNING: cross-localedef-native: dependent task do_deploy does not exist
WARNING: cross-localedef-native: dependent task do_package_write_ipk does
not exist
WARNING: cross-localedef-native: dependent task do_deploy does not exist
WARNING: cross-localedef-native: dependent task do_package_write_ipk does
not exist
WARNING: cross-localedef-native: dependent task write_bom_data does not
exist
WARNING: cross-localedef-native: dependent task write_abi_xml_data does not
exist
..

On Fri, Apr 26, 2019 at 4:49 AM Robert Yang <liezhi.yang@windriver.com>
wrote:

>
>
> On 4/25/19 6:50 PM, Richard Purdie wrote:
> > On Thu, 2019-04-25 at 18:01 +0800, Robert Yang wrote:
> >> The following command is incorrect, but was ignored silently, that may
> suprise
> >> users:
> >>
> >> addtask task after task_not_existed
> >>
> >> This patch can check and warn for it. It would be better to also check
> "before"
> >> tasks, but there is no easier way to do it.
> >>
> >> [YOCTO #13282]
> >>
> >> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> >> ---
> >>   bitbake/lib/bb/build.py | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
> >> index 7571421..861e9a9 100644
> >> --- a/bitbake/lib/bb/build.py
> >> +++ b/bitbake/lib/bb/build.py
> >> @@ -815,6 +815,9 @@ def add_tasks(tasklist, d):
> >>           task_deps['parents'][task] = []
> >>           if 'deps' in flags:
> >>               for dep in flags['deps']:
> >> +                # Check and warn for "addtask task after foo" while
> foo does not exist
> >> +                if not dep in tasklist:
> >> +                    bb.warn('%s: dependent task %s does not exist!' %
> (d.getVar('PN'), dep))
> >>                   dep = d.expand(dep)
> >>                   task_deps['parents'][task].append(dep)
> >
> > I can't help wonder if this change has races, depending on the order of
> > the addtask and deltask expressions. Do most layers parse cleanly with
> > this?
>
> The bb.build.add_tasks() is only called by ast.py's finalize(), I think
> that
> everything should be ready in finalize stage, and there should be no races.
> I tested this with meta-oe, python perl, selinux and others, didn't see
> any problems (unless I depended on an invalid task).
>
> >
> > At one point bitbake did support "floating" invalid tasks, I can't
> > remember if we changed that or not though.
>
> This warning is good for checking typos during development, I think that
> user can call "bb.build.addtask()" dynamically in a function to fix the
> warning
> for floating tasks?
>
> // Robert
>
> >
> > Cheers,
> >
> > Richard
> >
> >
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>

--00000000000095ed5a0587be5275
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div di=
r=3D"ltr"><div dir=3D"ltr">I just got few thousands of warnings thanks to t=
his, they might be legitimate as write_bom_data and write_abi_xml_data are =
our own tasks added in=C2=A0<a href=3D"https://github.com/webosose/meta-web=
osose/blob/master/meta-webos/classes/webos_base.bbclass">https://github.com=
/webosose/meta-webosose/blob/master/meta-webos/classes/webos_base.bbclass</=
a>=C2=A0very long time ago (based on fetchall task which was added in 2006 =
:)) - there might be better way to add them now, I&#39;ll check how to do i=
t better or else I might need to disable this warning locally.</div><div di=
r=3D"ltr"><br></div><div>Based on &quot;utility-tasks: Drop fetchall and ch=
eckuriall tasks&quot; I guess the right way to do the same now will be to c=
onvert our scripts to call it with=C2=A0--runall.</div><div dir=3D"ltr"><br=
></div><div dir=3D"ltr">It&#39;s pity that the warning is shown repeatedly.=
</div><div dir=3D"ltr"><br></div><div dir=3D"ltr"><div dir=3D"ltr">grep -c =
WARNING:.*dependent.task BUILD/log/cooker/m16p3/console-latest.log=C2=A0</d=
iv><div dir=3D"ltr">30409</div><div><br></div><div>and that was only very s=
mall build not even finished yet:</div><div>Currently=C2=A0 7 running tasks=
 (1142 of 2514)</div><div><br></div><div>..</div><div><div>WARNING: cross-l=
ocaledef-native: dependent task do_deploy does not exist</div><div>WARNING:=
 cross-localedef-native: dependent task do_package_write_ipk does not exist=
</div><div>WARNING: cross-localedef-native: dependent task do_deploy does n=
ot exist</div><div>WARNING: cross-localedef-native: dependent task do_packa=
ge_write_ipk does not exist</div><div>WARNING: cross-localedef-native: depe=
ndent task write_bom_data does not exist</div><div>WARNING: cross-localedef=
-native: dependent task write_abi_xml_data does not exist</div><div>WARNING=
: autoconf-archive-native: dependent task do_deploy does not exist</div><di=
v>WARNING: autoconf-archive-native: dependent task do_package_write_ipk doe=
s not exist</div><div>WARNING: autoconf-archive-native: dependent task do_d=
eploy does not exist</div><div>WARNING: autoconf-archive-native: dependent =
task do_package_write_ipk does not exist</div><div>WARNING: autoconf-archiv=
e-native: dependent task write_bom_data does not exist</div><div>WARNING: a=
utoconf-archive-native: dependent task write_abi_xml_data does not exist</d=
iv><div>WARNING: cross-localedef-native: dependent task do_deploy does not =
exist</div><div>WARNING: cross-localedef-native: dependent task do_package_=
write_ipk does not exist</div><div>WARNING: cross-localedef-native: depende=
nt task do_deploy does not exist</div><div>WARNING: cross-localedef-native:=
 dependent task do_package_write_ipk does not exist</div><div>WARNING: cros=
s-localedef-native: dependent task write_bom_data does not exist</div><div>=
WARNING: cross-localedef-native: dependent task write_abi_xml_data does not=
 exist</div><div>WARNING: cross-localedef-native: dependent task do_deploy =
does not exist</div><div>WARNING: cross-localedef-native: dependent task do=
_package_write_ipk does not exist</div><div>WARNING: cross-localedef-native=
: dependent task do_deploy does not exist</div><div>WARNING: cross-localede=
f-native: dependent task do_package_write_ipk does not exist</div><div>WARN=
ING: cross-localedef-native: dependent task write_bom_data does not exist</=
div><div>WARNING: cross-localedef-native: dependent task write_abi_xml_data=
 does not exist</div><div>WARNING: cross-localedef-native: dependent task d=
o_deploy does not exist</div><div>WARNING: cross-localedef-native: dependen=
t task do_package_write_ipk does not exist</div><div>WARNING: cross-localed=
ef-native: dependent task do_deploy does not exist</div><div>WARNING: cross=
-localedef-native: dependent task do_package_write_ipk does not exist</div>=
<div>WARNING: cross-localedef-native: dependent task write_bom_data does no=
t exist</div><div>WARNING: cross-localedef-native: dependent task write_abi=
_xml_data does not exist</div></div><div>..</div></div></div></div></div></=
div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Fri, Apr 26, 2019 at 4:49 AM Robert Yang &lt;<a href=3D"mailto:liezh=
i.yang@windriver.com">liezhi.yang@windriver.com</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
On 4/25/19 6:50 PM, Richard Purdie wrote:<br>
&gt; On Thu, 2019-04-25 at 18:01 +0800, Robert Yang wrote:<br>
&gt;&gt; The following command is incorrect, but was ignored silently, that=
 may suprise<br>
&gt;&gt; users:<br>
&gt;&gt;<br>
&gt;&gt; addtask task after task_not_existed<br>
&gt;&gt;<br>
&gt;&gt; This patch can check and warn for it. It would be better to also c=
heck &quot;before&quot;<br>
&gt;&gt; tasks, but there is no easier way to do it.<br>
&gt;&gt;<br>
&gt;&gt; [YOCTO #13282]<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Robert Yang &lt;<a href=3D"mailto:liezhi.yang@windr=
iver.com" target=3D"_blank">liezhi.yang@windriver.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 =C2=A0bitbake/lib/bb/build.py | 3 +++<br>
&gt;&gt;=C2=A0 =C2=A01 file changed, 3 insertions(+)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py<br>
&gt;&gt; index 7571421..861e9a9 100644<br>
&gt;&gt; --- a/bitbake/lib/bb/build.py<br>
&gt;&gt; +++ b/bitbake/lib/bb/build.py<br>
&gt;&gt; @@ -815,6 +815,9 @@ def add_tasks(tasklist, d):<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0task_deps[&#39;parents&#39=
;][task] =3D []<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if &#39;deps&#39; in flags=
:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for dep in f=
lags[&#39;deps&#39;]:<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Check a=
nd warn for &quot;addtask task after foo&quot; while foo does not exist<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not de=
p in tasklist:<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 bb.warn(&#39;%s: dependent task %s does not exist!&#39; % (d.getVar(=
&#39;PN&#39;), dep))<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0dep =3D d.expand(dep)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0task_deps[&#39;parents&#39;][task].append(dep)<br>
&gt; <br>
&gt; I can&#39;t help wonder if this change has races, depending on the ord=
er of<br>
&gt; the addtask and deltask expressions. Do most layers parse cleanly with=
<br>
&gt; this?<br>
<br>
The bb.build.add_tasks() is only called by ast.py&#39;s finalize(), I think=
 that<br>
everything should be ready in finalize stage, and there should be no races.=
<br>
I tested this with meta-oe, python perl, selinux and others, didn&#39;t see=
<br>
any problems (unless I depended on an invalid task).<br>
<br>
&gt; <br>
&gt; At one point bitbake did support &quot;floating&quot; invalid tasks, I=
 can&#39;t<br>
&gt; remember if we changed that or not though.<br>
<br>
This warning is good for checking typos during development, I think that<br=
>
user can call &quot;bb.build.addtask()&quot; dynamically in a function to f=
ix the warning<br>
for floating tasks?<br>
<br>
// Robert<br>
<br>
&gt; <br>
&gt; Cheers,<br>
&gt; <br>
&gt; Richard<br>
&gt; <br>
&gt; <br>
-- <br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_blank">b=
itbake-devel@lists.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/mailman/li=
stinfo/bitbake-devel</a><br>
</blockquote></div>

--00000000000095ed5a0587be5275--
