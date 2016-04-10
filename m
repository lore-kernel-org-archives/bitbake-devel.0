Return-Path: <kergoth@gmail.com>
Received: from mail-io0-f178.google.com (mail-io0-f178.google.com
	[209.85.223.178])
	by mail.openembedded.org (Postfix) with ESMTP id 4F28F731F7
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 10 Apr 2016 17:12:37 +0000 (UTC)
Received: by mail-io0-f178.google.com with SMTP id 2so183388344ioy.1
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 10 Apr 2016 10:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to; 
	bh=6YeyicPiLzcmRTVxkQY+tlGc8K8/cHo7WRYBuJZfyRA=;
	b=h59Sl0MLAEV8gCyHvW5gZGlNK90yJP77t2qw4wi3KgGCDgINAhNatW/9x16BTn1W0r
	LBvQfCH9QSeQcRe9outnNzu0zJ7zTsyQhIAw7lqTXDj7Z/QjRqDyhP/W3gIicJAVNRXF
	flAByNLT//RbGDJu5QxrSWOdwg+yziVcu70S3D7bjPZQOwAk1TJQ6Bu1YOZOgRpOqK/t
	GIQFTWSa9B2fua8DSkwRnNwTPmEX+2zpae60YsuZg4/57PW2YPHAuCQFCWta/jtMdbBJ
	zbjoXSC1Ga2c8e+5GU697NxFcKbJSRUFEfgsr6sqhuvgHgVFHffDExZ/onwVXjdjla/r
	aL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to;
	bh=6YeyicPiLzcmRTVxkQY+tlGc8K8/cHo7WRYBuJZfyRA=;
	b=mt1UEs+JokzNVlkxMTLym+coNa6OIrcBNa4jzKd1LN/iNTPfquwXAM0m5s0cLfgHok
	OdA7irBYLSXmb4gNKoUIu8VTUg9QCP1Zgr3vePI6mDHaO7DE8RFwFnv5+viqQ24Peufn
	NkEemM3bkAj7F+oG6Q+an5sqaMIWmGw6XbktFoHPIYtkQdEeI8VuIkgkvXi6a8ZL8t7m
	NHvS5lSw2y/L0+Jam3XN6d2GiEa3erEvsjVEq/uiM2i4GrSMvgOlJxKIxkiRqIo/PXYv
	x21mgiT62DZRDUNxgEvU5EWhjcJy3qtlS3I7KwcGAI84KcF+Aq61DPbjn3D4i7BX6xTp
	Iizg==
X-Gm-Message-State: AD7BkJJP6ypkDLq0C/833VSwSIbm2JBVprzu0m3hCvkmrVzVkwCvc7dGP7hq/n0AriOCobFaxMEugKkbIr4EOQ==
X-Received: by 10.107.131.28 with SMTP id f28mr19395948iod.126.1460308357759; 
	Sun, 10 Apr 2016 10:12:37 -0700 (PDT)
MIME-Version: 1.0
References: <1460282961.9308.13.camel@linuxfoundation.org>
In-Reply-To: <1460282961.9308.13.camel@linuxfoundation.org>
From: Christopher Larson <kergoth@gmail.com>
Date: Sun, 10 Apr 2016 17:12:28 +0000
Message-ID: <CABcZANkv+KvK6mjuApbOQxAqmN6-2p5kqaieAnTKGk8Fri2MQA@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] runqueue: Improve 'mulitiple .bb files are due to be built' message
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
X-List-Received-Date: Sun, 10 Apr 2016 17:12:39 -0000
Content-Type: multipart/alternative; boundary=001a113ec5faed48ce05302488aa

--001a113ec5faed48ce05302488aa
Content-Type: text/plain; charset=UTF-8

On Sun, Apr 10, 2016 at 3:10 AM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> When multiple recipes which both provide something are being built, bitbake
> informs us that most likely one of them provides something the other
> doesn't,
> which is usually correct, but unfortunately it's rather painful to figure
> out
> exactly what that is.
>
> This patch dumps two sets of information, one is the provides information
> for
> each recipe, filtered so only common components are removed. The other is
> a list
> of dependees on the recipe, since sometimes this can easily identify why
> something
> is being built.
>
> Its not straightforward for bitbake to obtain the information but since the
> warning/error code path isn't the normal one, we can afford to go through
> some
> less than optimal processing to aid debugging.
>
> Also provide the same information even if we're showing a warning since
> its still
> useful.
>
> [YOCTO #8032]
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>

Nice work on this, thanks much. I think this will be a big help in
diagnosing issues of this sort. I have a few very minor comments below.

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
> index 2990de7..ac3cdae 100644
> --- a/bitbake/lib/bb/runqueue.py
> +++ b/bitbake/lib/bb/runqueue.py
> @@ -261,6 +261,13 @@ class RunQueueData:
>          taskname = self.runq_task[task] + task_name_suffix
>          return "%s, %s" % (fn, taskname)
>
> +    def get_short_user_idstring(self, task, task_name_suffix = ""):
> +        fn = self.taskData.fn_index[self.runq_fnid[task]]
> +        pn = self.dataCache.pkg_fn[fn]
> +        taskname = self.runq_task[task] + task_name_suffix
> +        return "%s:%s" % (pn, taskname)
> +
> +
>      def get_task_id(self, fnid, taskname):
>          for listid in xrange(len(self.runq_fnid)):
>              if self.runq_fnid[listid] == fnid and self.runq_task[listid]
> == taskname:
> @@ -753,11 +760,72 @@ class RunQueueData:
>                          seen_pn.append(pn)
>                      else:
>                          bb.fatal("Multiple versions of %s are due to be
> built (%s). Only one version of a given PN should be built in any given
> build. You likely need to set PREFERRED_VERSION_%s to select the correct
> version or don't depend on multiple versions." % (pn, "
> ".join(prov_list[prov]), pn))
> -                msg = "Multiple .bb files are due to be built which each
> provide %s (%s)." % (prov, " ".join(prov_list[prov]))
> +                msg = "Multiple .bb files are due to be built which each
> provide %s:\n  %s" % (prov, "\n  ".join(prov_list[prov]))
> +                #
> +                # Construct a list of things which uniquely depend on
> each provider
> +                # since this may help the user figure out which
> dependency is triggering this warning
> +                #
> +                msg += "\nA list of tasks depending on these providers is
> shown and may help explain where the dependency comes from."
> +                deplist = {}
> +                commondeps = None
> +                for provfn in prov_list[prov]:
> +                    deps = set()
> +                    for task in xrange(len(self.runq_fnid)):
> +                        fn = taskData.fn_index[self.runq_fnid[task]]
> +                        if fn != provfn:
> +                            continue
>


I think this would be more pythonic:

    for task, fnid in enumerate(self.runq_fnid):
       fn = taskData.fn_index[fnid]


+                        for dep in self.runq_revdeps[task]:
> +                            fn = taskData.fn_index[self.runq_fnid[dep]]
> +                            if fn == provfn:
> +                                continue
> +                            deps.add(self.get_short_user_idstring(dep))
>


Here we look up the fn of dep, but then get_short_user_idstring() does so
as well, might be worth passing it in instead, unless it's used elsewhere
where the fn isn't yet available.


+                    if not commondeps:
> +                        commondeps = set(deps)
> +                    else:
> +                        commondeps &= deps
> +                    deplist[provfn] = deps
> +                for provfn in deplist:
> +                    msg += "\n%s has unique dependees:\n  %s" % (provfn,
> "\n  ".join(deplist[provfn] - commondeps))
> +                #
> +                # Construct a list of provides and runtime providers for
> each recipe
> +                # (rprovides has to cover RPROVIDES, PACKAGES,
> PACKAGES_DYNAMIC)
> +                #
> +                msg += "\nIt could be that one recipe provides something
> the other doesn't and should. The following provider and runtime provider
> differences may be helpful."
> +                provlist = {}
>


Might want to rename this variable to improve readability, just because
there's also prov_list :)


+                rprovlist = {}
> +                commonprovs = None
> +                commonrprovs = None
> +                for provfn in prov_list[prov]:
> +                    provides = set(self.dataCache.fn_provides[provfn])
> +                    rprovides = set()
> +                    for rprovide in self.dataCache.rproviders:
> +                        if provfn in self.dataCache.rproviders[rprovide]:
> +                            rprovides.add(rprovide)
> +                    for package in self.dataCache.packages:
> +                        if provfn in self.dataCache.packages[package]:
> +                            rprovides.add(package)
> +                    for package in self.dataCache.packages_dynamic:
> +                        if provfn in
> self.dataCache.packages_dynamic[package]:
> +                            rprovides.add(package)
>


Minor and largely personal preference either way, but these loops are
simple enough they could be comprehensions. Don't feel too strongly either
way on that.


+                    if not commonprovs:
> +                        commonprovs = set(provides)
> +                    else:
> +                        commonprovs &= provides
> +                    provlist[provfn] = provides
> +                    if not commonrprovs:
> +                        commonrprovs = set(rprovides)
> +                    else:
> +                        commonrprovs &= rprovides
> +                    rprovlist[provfn] = rprovides
> +                #msg += "\nCommon provides:\n  %s" % ("\n
> ".join(commonprovs))
> +                #msg += "\nCommon rprovides:\n  %s" % ("\n
> ".join(commonrprovs))
> +                for provfn in prov_list[prov]:
> +                    msg += "\n%s has unique provides:\n  %s" % (provfn,
> "\n  ".join(provlist[provfn] - commonprovs))
> +                    msg += "\n%s has unique rprovides:\n  %s" % (provfn,
> "\n  ".join(rprovlist[provfn] - commonrprovs))



Might want to check to see if the list of uniques is empty before
displaying its message, just to reduce possible confusion.

Thanks again,

--001a113ec5faed48ce05302488aa
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr">On Sun, Apr 10=
, 2016 at 3:10 AM Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linux=
foundation.org">richard.purdie@linuxfoundation.org</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">When multiple recipes which both provide som=
ething are being built, bitbake<br>
informs us that most likely one of them provides something the other doesn&=
#39;t,<br>
which is usually correct, but unfortunately it&#39;s rather painful to figu=
re out<br>
exactly what that is.<br>
<br>
This patch dumps two sets of information, one is the provides information f=
or<br>
each recipe, filtered so only common components are removed. The other is a=
 list<br>
of dependees on the recipe, since sometimes this can easily identify why so=
mething<br>
is being built.<br>
<br>
Its not straightforward for bitbake to obtain the information but since the=
<br>
warning/error code path isn&#39;t the normal one, we can afford to go throu=
gh some<br>
less than optimal processing to aid debugging.<br>
<br>
Also provide the same information even if we&#39;re showing a warning since=
 its still<br>
useful.<br>
<br>
[YOCTO #8032]<br>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;<b=
r></blockquote><div><br></div><div>Nice work on this, thanks much. I think =
this will be a big help in diagnosing issues of this sort. I have a few ver=
y minor comments below.</div><div><br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py<br>
index 2990de7..ac3cdae 100644<br>
--- a/bitbake/lib/bb/runqueue.py<br>
+++ b/bitbake/lib/bb/runqueue.py<br>
@@ -261,6 +261,13 @@ class RunQueueData:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0taskname =3D self.runq_task[task] + task_=
name_suffix<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return &quot;%s, %s&quot; % (fn, taskname=
)<br>
<br>
+=C2=A0 =C2=A0 def get_short_user_idstring(self, task, task_name_suffix =3D=
 &quot;&quot;):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fn =3D self.taskData.fn_index[self.runq_fnid[t=
ask]]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pn =3D self.dataCache.pkg_fn[fn]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 taskname =3D self.runq_task[task] + task_name_=
suffix<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;%s:%s&quot; % (pn, taskname)<br>
+<br>
+<br>
=C2=A0 =C2=A0 =C2=A0def get_task_id(self, fnid, taskname):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for listid in xrange(len(self.runq_fnid))=
:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.runq_fnid[listid] =
=3D=3D fnid and self.runq_task[listid] =3D=3D taskname:<br>
@@ -753,11 +760,72 @@ class RunQueueData:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0seen_pn.append(pn)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0else:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0bb.fatal(&quot;Multiple versions of %s are due to be built=
 (%s). Only one version of a given PN should be built in any given build. Y=
ou likely need to set PREFERRED_VERSION_%s to select the correct version or=
 don&#39;t depend on multiple versions.&quot; % (pn, &quot; &quot;.join(pro=
v_list[prov]), pn))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg =3D &quot;Mult=
iple .bb files are due to be built which each provide %s (%s).&quot; % (pro=
v, &quot; &quot;.join(prov_list[prov]))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg =3D &quot;Mult=
iple .bb files are due to be built which each provide %s:\n=C2=A0 %s&quot; =
% (prov, &quot;\n=C2=A0 &quot;.join(prov_list[prov]))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 #<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Construct a list=
 of things which uniquely depend on each provider<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # since this may h=
elp the user figure out which dependency is triggering this warning<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 #<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg +=3D &quot;\nA=
 list of tasks depending on these providers is shown and may help explain w=
here the dependency comes from.&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 deplist =3D {}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 commondeps =3D Non=
e<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for provfn in prov=
_list[prov]:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 deps=
 =3D set()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for =
task in xrange(len(self.runq_fnid)):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 fn =3D taskData.fn_index[self.runq_fnid[task]]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if fn !=3D provfn:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 continue<br></blockquote><div><br></div><div><br><=
/div><div>I think this would be more pythonic:</div><div><br></div><div>=C2=
=A0 =C2=A0 for task, fnid in enumerate(self.runq_fnid):</div><div>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0fn =3D taskData.fn_index[fnid]</div><div>=C2=A0</div><d=
iv><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 for dep in self.runq_revdeps[task]:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 fn =3D taskData.fn_index[self.runq_fnid[dep]]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 if fn =3D=3D provfn:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 deps.add(self.get_short_user_idstring(dep))<br></b=
lockquote><div><br></div><div><br></div><div>Here we look up the fn of dep,=
 but then get_short_user_idstring() does so as well, might be worth passing=
 it in instead, unless it&#39;s used elsewhere where the fn isn&#39;t yet a=
vailable.</div><div>=C2=A0</div><div><br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if n=
ot commondeps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 commondeps =3D set(deps)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else=
:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 commondeps &amp;=3D deps<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 depl=
ist[provfn] =3D deps<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for provfn in depl=
ist:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg =
+=3D &quot;\n%s has unique dependees:\n=C2=A0 %s&quot; % (provfn, &quot;\n=
=C2=A0 &quot;.join(deplist[provfn] - commondeps))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 #<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Construct a list=
 of provides and runtime providers for each recipe<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # (rprovides has t=
o cover RPROVIDES, PACKAGES, PACKAGES_DYNAMIC)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 #<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg +=3D &quot;\nI=
t could be that one recipe provides something the other doesn&#39;t and sho=
uld. The following provider and runtime provider differences may be helpful=
.&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 provlist =3D {}<br=
></blockquote><div><br></div><div><br></div><div>Might want to rename this =
variable to improve readability, just because there&#39;s also prov_list :)=
</div><div>=C2=A0</div><div><br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rprovlist =3D {}<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 commonprovs =3D No=
ne<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 commonrprovs =3D N=
one<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for provfn in prov=
_list[prov]:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prov=
ides =3D set(self.dataCache.fn_provides[provfn])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rpro=
vides =3D set()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for =
rprovide in self.dataCache.rproviders:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if provfn in self.dataCache.rproviders[rprovide]:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 rprovides.add(rprovide)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for =
package in self.dataCache.packages:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if provfn in self.dataCache.packages[package]:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 rprovides.add(package)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for =
package in self.dataCache.packages_dynamic:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if provfn in self.dataCache.packages_dynamic[package]:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 rprovides.add(package)<br></blockquote><div><br></=
div><div><br></div><div>Minor and largely personal preference either way, b=
ut these loops are simple enough they could be comprehensions. Don&#39;t fe=
el too strongly either way on that.</div><div>=C2=A0</div><div><br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if n=
ot commonprovs:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 commonprovs =3D set(provides)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else=
:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 commonprovs &amp;=3D provides<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prov=
list[provfn] =3D provides<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if n=
ot commonrprovs:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 commonrprovs =3D set(rprovides)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else=
:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 commonrprovs &amp;=3D rprovides<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rpro=
vlist[provfn] =3D rprovides<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 #msg +=3D &quot;\n=
Common provides:\n=C2=A0 %s&quot; % (&quot;\n=C2=A0 &quot;.join(commonprovs=
))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 #msg +=3D &quot;\n=
Common rprovides:\n=C2=A0 %s&quot; % (&quot;\n=C2=A0 &quot;.join(commonrpro=
vs))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for provfn in prov=
_list[prov]:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg =
+=3D &quot;\n%s has unique provides:\n=C2=A0 %s&quot; % (provfn, &quot;\n=
=C2=A0 &quot;.join(provlist[provfn] - commonprovs))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg =
+=3D &quot;\n%s has unique rprovides:\n=C2=A0 %s&quot; % (provfn, &quot;\n=
=C2=A0 &quot;.join(rprovlist[provfn] - commonrprovs))</blockquote><div><br>=
</div><div><br></div><div>Might want to check to see if the list of uniques=
 is empty before displaying its message, just to reduce possible confusion.=
</div><div><br></div><div>Thanks again,</div></div></div>

--001a113ec5faed48ce05302488aa--
