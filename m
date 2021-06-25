Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
 by mx.groups.io with SMTP id smtpd.web12.1740.1624585731483109613
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 24 Jun 2021 18:48:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=Q8b0xN1y;
 spf=pass (domain: gmail.com, ip: 209.85.210.46, mailfrom: krussell7711@gmail.com)
Received: by mail-ot1-f46.google.com with SMTP id 6-20020a9d07860000b02903e83bf8f8fcso7692717oto.12
        for <bitbake-devel@lists.openembedded.org>; Thu, 24 Jun 2021 18:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/HtDftCASf9rxQryRqCLxCB28DB14eG5kOVTB+INDbQ=;
        b=Q8b0xN1yxStxfJZj8cemgjJBCjlgUmxDWGN/xjtcKyqYKUIflf8DzMRm40yUdMt8Is
         2THlBj5EzRBqRw/xBtjGay5QeQJrVGb4SpuQCfAVI8cKfDsP9hk+9rNZ48wNycdaUdP8
         ed5aX5+1uO/B9izbWS/2HaLsaEKKnfvMaeW37i5mcMWi8JBRrm8soM1Cx/DrRE6V4KiQ
         77P+dz58RTNG3ZihQvS/xnG4iSbYa82rKJijOh1TMMvxOPqcPZ2Tow5/LPpvMordfsAZ
         9riWvaJMNc4BrsLrqya68dy2oPMkQ9BVeWP4dox/Y1mPBMn1o3yz434Wm2qPGJEuIyog
         efvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/HtDftCASf9rxQryRqCLxCB28DB14eG5kOVTB+INDbQ=;
        b=ZEHcEhorTwmuGuCTvDBSuCJdmweIUcR/XGGpC70VTjsq//hId1Ei9aJFQCYX/dOq9t
         168uaNhkCKpBo3ukwgo8MYz+jymrMR5drOPgu3eoGGmZoE0oD1WNt3HcVEOr3J7gpQmY
         PjvYxp/FkizzWQCmPKuoih2jgOmfJpmdo4rzaQk/n30P9+GGOqZJu5zPhoswOEaOq5zw
         EHv/1OiPlEwzflI0ZpwYtT2dXVEPeHMiuWXqpEqVrC0dUmrUZBquPsJSYG8Ibbu/fcE/
         PeL1oovXI1vOxSlaZbSEV5UV1Q6icXJYqlDh4rRhJTUCGumxJ15oo9w9UM1dyrUmIQpz
         Bvaw==
X-Gm-Message-State: AOAM533fHZQJvNDu+2cy9h8R8xNWLf+Bsselrd7CH2I1wP0lYDzTxNx2
	3iLFFw7GIDWkcIFp53AInj3YrVr52IjhFnAYPt4=
X-Google-Smtp-Source: ABdhPJxDXxB/yeApOiHgBxOWW1LKaOKWASKv2oJ/BKnp6SrhQT5j0SQpMfbkpnCNCI4tsjcVpTumgUbXXzVSorL4kiE=
X-Received: by 2002:a9d:4105:: with SMTP id o5mr7228995ote.20.1624585730666;
 Thu, 24 Jun 2021 18:48:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210508091457.2084843-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20210508091457.2084843-1-richard.purdie@linuxfoundation.org>
From: bkylerussell@gmail.com
Date: Thu, 24 Jun 2021 21:48:37 -0400
Message-ID: <CAFrQVPMHson5cyOgmcDZHFTbzYHVPrdebiSZ5Ad8AtjkfmhGvw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] runqueue: Improve multiconfig deferred task issues
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000062325f05c58d5752"

--00000000000062325f05c58d5752
Content-Type: text/plain; charset="UTF-8"

What's the status on this patch?

I have an issue on dunfell where two valid setscene tasks are getting
scheduled for native packages even though the hashes are equivalent.  When
both configs' do_populate_sysroot_setscene tasks get scheduled near the
same time, one config often fails with an unpack error.  One config sees
that the other config's task has already started downloading sstate, so it
immediately starts unpacking the tgz it finds.  However, if wget hasn't
actually finished, tar errors on EOF during run.sstate_unpack_package.  I
can readily reproduce this on my setup.

I think bitbake rev a75c5fd6d4ec5 attempted to address this with
pending_hash_index() in runqueue.py, but it seems that over time, that
block has been pushed further to the bottom of update_scenequeue_data.  I
think in my case, both tasks are being marked as valid, so the following
case appears to prevent one of the tasks from being deferred until later.

            if tid in sqdata.valid:
                continue

I have seen some instances where native sstate tasks are actually deferred
because the bb.note is printed in the log, but not always, so I'm not sure
under what circumstances update_scenequeue_data is supposed to execute the
pending_hash_index check.

It looks like this patch might take a step towards fixing that, but I
haven't followed all the recent multiconfig discussions completely.  I'm
not confident on the current state of things and wondered if you could
provide any insight.

Thanks!

Kyle


On Sat, May 8, 2021 at 5:14 AM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> The previous patches have exposed new issues with this code path,
> the issues being around what should happen when the hash of a task
> changes and the task is or is not on the deferred task list.
>
> Rather than rebuilding the deferred task list during each rehash
> event, build it once at the start of a build. This avoids the problem
> of tasks being added back after they have run and also avoids problems
> of always ensuring the same task is deferred. It also allows the
> 'outrightfail' codepath to be handled separately as the conditions
> are subtly differnt.
>
> One significant win for the new approch is the build is not continually
> printing out lists of deferred tasks, that list remains fairly static
> from the start of the build. Logic is added in to ensure a rehashed
> task with a hash matching other deferred tasks is deferred along with
> them as a small optimization.
>
> An interesting test case for this code was reported by Mark Hatle
> with four multiconfigs, each the same apart from TMPDIR and running a
> build of:
>
> bitbake buildtools-tarball mc:{one,two,three,four}:core-image-minimal
>
> which is interesting in that the build of buildtools partially overlaps
> core-image-minimal and the build has a rehash event for qemuwrapper-cross
> even without any external hash equivalence server or preexisting data.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/runqueue.py | 56 +++++++++++++++++++++++++---------------------
>  1 file changed, 30 insertions(+), 26 deletions(-)
>
> diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
> index 6c41fe6d43..88983eba1a 100644
> --- a/lib/bb/runqueue.py
> +++ b/lib/bb/runqueue.py
> @@ -2443,6 +2443,11 @@ class RunQueueExecute:
>
>          if update_tasks:
>              self.sqdone = False
> +            for tid in [t[0] for t in update_tasks]:
> +                h = pending_hash_index(tid, self.rqdata)
> +                if h in self.sqdata.hashes and tid !=
> self.sqdata.hashes[h]:
> +                    self.sq_deferred[tid] = self.sqdata.hashes[h]
> +                    bb.note("Deferring %s after %s" % (tid,
> self.sqdata.hashes[h]))
>              update_scenequeue_data([t[0] for t in update_tasks],
> self.sqdata, self.rqdata, self.rq, self.cooker, self.stampcache, self,
> summary=False)
>
>          for (tid, harddepfail, origvalid) in update_tasks:
> @@ -2786,6 +2791,19 @@ def build_scenequeue_data(sqdata, rqdata, rq,
> cooker, stampcache, sqrq):
>      sqdata.stamppresent = set()
>      sqdata.valid = set()
>
> +    sqdata.hashes = {}
> +    sqrq.sq_deferred = {}
> +    for mc in sorted(sqdata.multiconfigs):
> +        for tid in sorted(sqdata.sq_revdeps):
> +            if mc_from_tid(tid) != mc:
> +                continue
> +            h = pending_hash_index(tid, rqdata)
> +            if h not in sqdata.hashes:
> +                sqdata.hashes[h] = tid
> +            else:
> +                sqrq.sq_deferred[tid] = sqdata.hashes[h]
> +                bb.note("Deferring %s after %s" % (tid, sqdata.hashes[h]))
> +
>      update_scenequeue_data(sqdata.sq_revdeps, sqdata, rqdata, rq, cooker,
> stampcache, sqrq, summary=True)
>
>      # Compute a list of 'stale' sstate tasks where the current hash does
> not match the one
> @@ -2850,32 +2868,18 @@ def update_scenequeue_data(tids, sqdata, rqdata,
> rq, cooker, stampcache, sqrq, s
>
>      sqdata.valid |= rq.validate_hashes(tocheck, cooker.data,
> len(sqdata.stamppresent), False, summary=summary)
>
> -    sqdata.hashes = {}
> -    sqrq.sq_deferred = {}
> -    for mc in sorted(sqdata.multiconfigs):
> -        for tid in sorted(sqdata.sq_revdeps):
> -            if mc_from_tid(tid) != mc:
> -                continue
> -            if tid in sqdata.stamppresent:
> -                continue
> -            if tid in sqdata.valid:
> -                continue
> -            if tid in sqdata.noexec:
> -                continue
> -            if tid in sqrq.scenequeue_notcovered:
> -                continue
> -            if tid in sqrq.scenequeue_covered:
> -                continue
> -
> -            h = pending_hash_index(tid, rqdata)
> -            if h not in sqdata.hashes:
> -                if tid in tids:
> -                    sqdata.outrightfail.add(tid)
> -                sqdata.hashes[h] = tid
> -            else:
> -                sqrq.sq_deferred[tid] = sqdata.hashes[h]
> -                bb.note("Deferring %s after %s" % (tid, sqdata.hashes[h]))
> -
> +    for tid in tids:
> +        if tid in sqdata.stamppresent:
> +            continue
> +        if tid in sqdata.valid:
> +            continue
> +        if tid in sqdata.noexec:
> +            continue
> +        if tid in sqrq.scenequeue_covered:
> +            continue
> +        if tid in sqrq.sq_deferred:
> +            continue
> +        sqdata.outrightfail.add(tid)
>
>  class TaskFailure(Exception):
>      """
> --
> 2.30.2
>
>
> 
>
>

--00000000000062325f05c58d5752
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>What&#39;s the status on this patch?</div><div><br></=
div><div><div>I have an issue on dunfell where two valid setscene tasks are=
 getting scheduled for native packages even though the hashes are equivalen=
t.=C2=A0 When both configs&#39; do_populate_sysroot_setscene tasks get sche=
duled near the same time, one config often fails with an unpack error.=C2=
=A0 One config sees that the other config&#39;s task has already started d=
ownloading sstate, so it immediately starts unpacking the tgz it finds.=C2=
=A0 However, if wget hasn&#39;t actually finished, tar errors on EOF durin=
g run.sstate_unpack_package.=C2=A0 I can readily reproduce this on my setup=
.</div><div><br></div><div>I think bitbake rev a75c5fd6d4ec5 attempted to a=
ddress this with pending_hash_index() in runqueue.py, but it seems that ove=
r time, that block has been pushed further to the bottom of update_sceneque=
ue_data.=C2=A0 I think in my case, both tasks are being marked as valid, so=
 the following case appears to prevent one of the tasks from being deferred=
 until later.</div><div><br></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if tid in sqdata.valid:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 continue<br></div><div><br></div><div>I have seen some i=
nstances where native sstate tasks are actually deferred because the bb.not=
e is printed in the log, but not always, so I&#39;m not sure under what cir=
cumstances update_scenequeue_data is supposed to execute the pending_hash_i=
ndex check.</div><div><br></div><div>It looks like this patch might take a =
step towards fixing that, but I haven&#39;t followed all the recent multico=
nfig discussions completely.=C2=A0 I&#39;m not confident on the current sta=
te of things and wondered if you could provide any insight.</div><div><br><=
/div><div>Thanks!</div><div><br></div><div>Kyle</div></div><br></div><br><d=
iv class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, May =
8, 2021 at 5:14 AM Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linu=
xfoundation.org">richard.purdie@linuxfoundation.org</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">The previous patches hav=
e exposed new issues with this code path,<br>
the issues being around what should happen when the hash of a task<br>
changes and the task is or is not on the deferred task list.<br>
<br>
Rather than rebuilding the deferred task list during each rehash<br>
event, build it once at the start of a build. This avoids the problem<br>
of tasks being added back after they have run and also avoids problems<br>
of always ensuring the same task is deferred. It also allows the<br>
&#39;outrightfail&#39; codepath to be handled separately as the conditions=
<br>
are subtly differnt.<br>
<br>
One significant win for the new approch is the build is not continually<br=
>
printing out lists of deferred tasks, that list remains fairly static<br>
from the start of the build. Logic is added in to ensure a rehashed<br>
task with a hash matching other deferred tasks is deferred along with<br>
them as a small optimization.<br>
<br>
An interesting test case for this code was reported by Mark Hatle<br>
with four multiconfigs, each the same apart from TMPDIR and running a<br>
build of:<br>
<br>
bitbake buildtools-tarball mc:{one,two,three,four}:core-image-minimal<br>
<br>
which is interesting in that the build of buildtools partially overlaps<br=
>
core-image-minimal and the build has a rehash event for qemuwrapper-cross<=
br>
even without any external hash equivalence server or preexisting data.<br>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfo=
undation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;<=
br>
---<br>
=C2=A0lib/bb/runqueue.py | 56 +++++++++++++++++++++++++-------------------=
--<br>
=C2=A01 file changed, 30 insertions(+), 26 deletions(-)<br>
<br>
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py<br>
index 6c41fe6d43..88983eba1a 100644<br>
--- a/lib/bb/runqueue.py<br>
+++ b/lib/bb/runqueue.py<br>
@@ -2443,6 +2443,11 @@ class RunQueueExecute:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if update_tasks:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.sqdone =3D False<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for tid in [t[0] for t in updat=
e_tasks]:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 h =3D pending_has=
h_index(tid, self.rqdata)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if h in self.sqda=
ta.hashes and tid !=3D self.sqdata.hashes[h]:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sel=
f.sq_deferred[tid] =3D self.sqdata.hashes[h]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.=
note(&quot;Deferring %s after %s&quot; % (tid, self.sqdata.hashes[h]))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0update_scenequeue_data([t[=
0] for t in update_tasks], self.sqdata, self.rqdata, self.rq, self.cooker, =
self.stampcache, self, summary=3DFalse)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (tid, harddepfail, origvalid) in upd=
ate_tasks:<br>
@@ -2786,6 +2791,19 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooke=
r, stampcache, sqrq):<br>
=C2=A0 =C2=A0 =C2=A0sqdata.stamppresent =3D set()<br>
=C2=A0 =C2=A0 =C2=A0sqdata.valid =3D set()<br>
<br>
+=C2=A0 =C2=A0 sqdata.hashes =3D {}<br>
+=C2=A0 =C2=A0 sqrq.sq_deferred =3D {}<br>
+=C2=A0 =C2=A0 for mc in sorted(sqdata.multiconfigs):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for tid in sorted(sqdata.sq_revdeps):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if mc_from_tid(tid) !=3D mc:<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 h =3D pending_hash_index(tid, r=
qdata)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if h not in sqdata.hashes:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sqdata.hashes[h] =
=
=3D tid<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sqrq.sq_deferred[=
tid] =3D sqdata.hashes[h]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.note(&quot;Def=
erring %s after %s&quot; % (tid, sqdata.hashes[h]))<br>
+<br>
=C2=A0 =C2=A0 =C2=A0update_scenequeue_data(sqdata.sq_revdeps, sqdata, rqda=
ta, rq, cooker, stampcache, sqrq, summary=3DTrue)<br>
<br>
=C2=A0 =C2=A0 =C2=A0# Compute a list of &#39;stale&#39; sstate tasks where=
 the current hash does not match the one<br>
@@ -2850,32 +2868,18 @@ def update_scenequeue_data(tids, sqdata, rqdata, r=
q, cooker, stampcache, sqrq, s<br>
<br>
=C2=A0 =C2=A0 =C2=A0sqdata.valid |=3D rq.validate_hashes(tocheck, cooker.d=
ata, len(sqdata.stamppresent), False, summary=3Dsummary)<br>
<br>
-=C2=A0 =C2=A0 sqdata.hashes =3D {}<br>
-=C2=A0 =C2=A0 sqrq.sq_deferred =3D {}<br>
-=C2=A0 =C2=A0 for mc in sorted(sqdata.multiconfigs):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for tid in sorted(sqdata.sq_revdeps):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if mc_from_tid(tid) !=3D mc:<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if tid in sqdata.stamppresent:<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if tid in sqdata.valid:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if tid in sqdata.noexec:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if tid in sqrq.scenequeue_notco=
vered:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if tid in sqrq.scenequeue_cover=
ed:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 h =3D pending_hash_index(tid, r=
qdata)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if h not in sqdata.hashes:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if tid in tids:<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sqd=
ata.outrightfail.add(tid)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sqdata.hashes[h] =
=
=3D tid<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sqrq.sq_deferred[=
tid] =3D sqdata.hashes[h]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.note(&quot;Def=
erring %s after %s&quot; % (tid, sqdata.hashes[h]))<br>
-<br>
+=C2=A0 =C2=A0 for tid in tids:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if tid in sqdata.stamppresent:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if tid in sqdata.valid:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if tid in sqdata.noexec:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if tid in sqrq.scenequeue_covered:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if tid in sqrq.sq_deferred:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sqdata.outrightfail.add(tid)<br>
<br>
=C2=A0class TaskFailure(Exception):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
-- <br>
2.30.2<br>
<br>
<br>
<br>
<br>
</blockquote></div>

--00000000000062325f05c58d5752--
