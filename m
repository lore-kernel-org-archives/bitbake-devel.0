Return-Path: <gowrishankarstg@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90391E7E648
	for <webhook@archiver.kernel.org>; Tue, 26 Sep 2023 14:59:34 +0000 (UTC)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
 by mx.groups.io with SMTP id smtpd.web11.21256.1695740372828357272
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 26 Sep 2023 07:59:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=I+05EKfz;
 spf=pass (domain: gmail.com, ip: 209.85.217.48, mailfrom: gowrishankarstg@gmail.com)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4527d7f7305so3722999137.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 26 Sep 2023 07:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695740372; x=1696345172; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ozipjF/yahqP29Hp+eg73ghJDUB5VYSE297dYFtNA7o=;
        b=I+05EKfzA9QXMl1vPF/O/9T5NDO7XFYnxDlKjBWP7YOxkc3nQIs4gc0qenwSEpk/t0
         b1gkkUl22Bgj/q0pTMj4YE21MS3jesTAa9JCZNgohyeNkBmnBJJj5te2g54I5QSfS5NM
         BsgNRF2NdDw38Tq9LbMEGopXre+0dnUynqh1f7nC0Y/6HTZR9t1b+v0fhWF7lU5S9yMN
         ClKwtVZKa+C/gSWiV5SGBmEhbdBI4d02nRLcWv/qrZArBSm16gBBjtq5w1iG4kxIdX7S
         R3CcMmbZhVa//SJAoj1gzzYnLmWCn5D2ZrnaWsHj+iHDjNyFpJ/EnAMcXbyS0vYOYHQW
         FSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695740372; x=1696345172;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ozipjF/yahqP29Hp+eg73ghJDUB5VYSE297dYFtNA7o=;
        b=Rz0Xok5ujfGlFRIV81e86mv2Ci8azPZkMygUWi25iK/thq40dYMC2wmReNLiMILk//
         QClcjZrtbuo+jaI71wKnIB3bmUZmrzrHPNrv5kIPut8ojHdKoafXH70e2sL+BlJLIGTW
         QTeibKHUrVSiSGKd1ltxwGmlUr4HQ+/qQUkYwiUS+bc3ds7D8tBTra42bgeuC9SO+1Ol
         Bb1BQydK677Sz7kjAqkLE9cChbMlIfxe/SpVgy+DqkJiEdkhDHS1LrSaZnmX9TVP4FWV
         7mZ9dNVGjGEpv9pXSJTe3AMigeuWNVLIlNXh0TooAekVIToJ4TYMDpcK0w33V7n36iBT
         YlMA==
X-Gm-Message-State: AOJu0Yx5pJJxpMapI0vLSaUut0npqC9Q6Xkr7KE1wg70QGzOQ0dCO9md
	A/OLsHk1j/cr6wqfurLpsgPzpkxw0Wf18hDhhJYno7kwfo/2PQ==
X-Google-Smtp-Source: AGHT+IFyXC0zi+zsJ6buXuIabUKiPvt45w5cxQvmiM/j0kUi28gtOV1cP0+OvnXJ+zd5SGW9i1/ah9aUEl6B0nnifh0=
X-Received: by 2002:a05:6102:3a6e:b0:452:9988:5cc7 with SMTP id
 bf14-20020a0561023a6e00b0045299885cc7mr6902556vsb.15.1695740371566; Tue, 26
 Sep 2023 07:59:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230924203958.35361-1-gowrishankarstg@gmail.com> <9fffc17ec1ff6a4248f5d9eb8cd6a7243f93d899.camel@linuxfoundation.org>
In-Reply-To: <9fffc17ec1ff6a4248f5d9eb8cd6a7243f93d899.camel@linuxfoundation.org>
From: Gowrishankar Saminathan <gowrishankarstg@gmail.com>
Date: Tue, 26 Sep 2023 20:29:41 +0530
Message-ID: <CACTJJZN_8MrG5jkFF+0xfq3wQNTSpOi4cM-5VvGVxm8XDQPAOQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/1] runqueue: Fix task execution
 dependency issue
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000007a85ba06064452ef"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 26 Sep 2023 14:59:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15132

--0000000000007a85ba06064452ef
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Richard,

I am facing this issue in the BitBake version tagged as yocto-3.1.27 when I
used it in Yocto of the same version.
Upon reviewing the master branch, it appears to have a similar
implementation to yocto-3.1.27 regarding this issue case. Consequently, I
believe this issue should also apply to the master branch.

It would be great if the master branch already includes this fix. If
possible, kindly provide the commit which addresses this issue.

Thanks for reaching me out!

Thanks and regards,
Gowrishankar Saminathan

On Tue, Sep 26, 2023 at 5:00=E2=80=AFPM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Mon, 2023-09-25 at 02:09 +0530, Gowrishankar Saminathan wrote:
> > When the recipe metadata is updated, and the Sstate cache remains
> unchanged,
> > a problem arises where tasks dependent on this particular task are foun=
d
> in
> > both the 'covered' and 'notcovered' lists within the runqueue.
> >
> > For instance, consider the example of 'base-passwd.bb:
> do_populate_sysroot',
> > which serves as a dependent task for both 'systemd.bb:do_populate_sysro=
ot'
> and
> > 'dbus.bb:do_populate_sysroot.' Due to the lack of ordered task ID
> storage in the runqueue,
> > it often leads to the execution of 'systemd.bb::do_populate_sysroot'
> prior to
> > 'base-passwd.bb:do_populate_sysroot.' This results in 'systemd.bb:
> do_populate_sysroot'
> > being erroneously flagged as 'notcovered' by the runqueue.
> > Nevertheless, sstate later marks it as 'covered' if there is no change
> in the task output.
> >
> > To address this issue, this commit enhances the runqueue to store task
> IDs in an ordered list,
> > ensuring tasks are carried out in their correct dependency order.
> > This adjustment will execute 'base-passwd.bb:do_populate_sysroot' as
> the initial
> > task and then 'systemd.bb:do_populate_sysroot.'
> > This strategic execution ensures that 'systemd.bb:do_populate_sysroot'
> won't
> > receive an incorrect 'notcovered' status, as 'base-passwd.bb:
> do_populate_sysroot'
> > will have already been executed beforehand.
> >
> > Signed-off-by: Gowrishankar Saminathan <gowrishankarstg@gmail.com>
> > ---
> >  lib/bb/runqueue.py | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
> > index c40a3be2..446b1667 100644
> > --- a/lib/bb/runqueue.py
> > +++ b/lib/bb/runqueue.py
> > @@ -1789,7 +1789,7 @@ class RunQueueExecute:
> >          self.sq_live =3D set()
> >
> >          self.updated_taskhash_queue =3D []
> > -        self.pending_migrations =3D set()
> > +        self.pending_migrations =3D []
> >
> >          self.runq_buildable =3D set()
> >          self.runq_running =3D set()
> > @@ -2422,7 +2422,7 @@ class RunQueueExecute:
> >
> >      def process_possible_migrations(self):
> >
> > -        changed =3D set()
> > +        changed =3D []
> >          toprocess =3D set()
> >          for tid, unihash in self.updated_taskhash_queue.copy():
> >              if tid in self.runq_running and tid not in
> self.runq_complete:
> > @@ -2492,7 +2492,7 @@ class RunQueueExecute:
> >                      #logger.debug("Task %s hash changes: %s->%s %s->%s=
"
> % (tid, orighash, newhash, origuni, newuni))
> >                      self.rqdata.runtaskentries[tid].hash =3D newhash
> >                      self.rqdata.runtaskentries[tid].unihash =3D newuni
> > -                    changed.add(tid)
> > +                    changed.append(tid)
> >
> >                  next |=3D self.rqdata.runtaskentries[tid].revdeps
> >                  total.remove(tid)
> > @@ -2510,7 +2510,7 @@ class RunQueueExecute:
> >              if tid not in self.rqdata.runq_setscene_tids:
> >                  continue
> >              if tid not in self.pending_migrations:
> > -                self.pending_migrations.add(tid)
> > +                self.pending_migrations.append(tid)
> >
> >          update_tasks =3D []
> >          for tid in self.pending_migrations.copy():
>
> Thanks for the patch. Which release of bitbake did you find this issue
> with? There were fixes for issues like this which were made in master.
> I'm worried this patch was developed against an older release and isn't
> applicable to master.
>
> Cheers,
>
> Richard
>
>

--0000000000007a85ba06064452ef
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello Richard,</div><div><br></div><div>
I am facing this issue in the BitBake version tagged as yocto-3.1.27 when I=
 used it in Yocto of the same version.=C2=A0</div><div>Upon reviewing the m=
aster
 branch, it appears to have a similar implementation to yocto-3.1.27 regard=
ing this issue case. Consequently, I believe this issue should also apply t=
o the master branch.</div><div><br></div><div>It would be great if the mast=
er branch already includes this fix. If possible, kindly provide the commit=
 which addresses this issue.<br></div><div><br></div><div>Thanks for reachi=
ng me out!</div><div><br></div><div>Thanks and regards,</div><div>Gowrishan=
kar Saminathan<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Sep 26, 2023 at 5:00=E2=80=AFPM Richard Pur=
die &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org">richard.purdi=
e@linuxfoundation.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">On Mon, 2023-09-25 at 02:09 +0530, Gowrishankar Samina=
than wrote:<br>
&gt; When the recipe metadata is updated, and the Sstate cache remains unch=
anged,<br>
&gt; a problem arises where tasks dependent on this particular task are fou=
nd in<br>
&gt; both the &#39;covered&#39; and &#39;notcovered&#39; lists within the r=
unqueue.<br>
&gt; <br>
&gt; For instance, consider the example of &#39;base-passwd.bb:do_populate_=
sysroot&#39;,<br>
&gt; which serves as a dependent task for both &#39;systemd.bb:do_populate_=
sysroot&#39; and<br>
&gt; &#39;dbus.bb:do_populate_sysroot.&#39; Due to the lack of ordered task=
 ID storage in the runqueue,<br>
&gt; it often leads to the execution of &#39;systemd.bb::do_populate_sysroo=
t&#39; prior to<br>
&gt; &#39;base-passwd.bb:do_populate_sysroot.&#39; This results in &#39;sys=
temd.bb:do_populate_sysroot&#39;<br>
&gt; being erroneously flagged as &#39;notcovered&#39; by the runqueue.<br>
&gt; Nevertheless, sstate later marks it as &#39;covered&#39; if there is n=
o change in the task output.<br>
&gt; <br>
&gt; To address this issue, this commit enhances the runqueue to store task=
 IDs in an ordered list,<br>
&gt; ensuring tasks are carried out in their correct dependency order.<br>
&gt; This adjustment will execute &#39;base-passwd.bb:do_populate_sysroot&#=
39; as the initial<br>
&gt; task and then &#39;systemd.bb:do_populate_sysroot.&#39;<br>
&gt; This strategic execution ensures that &#39;systemd.bb:do_populate_sysr=
oot&#39; won&#39;t<br>
&gt; receive an incorrect &#39;notcovered&#39; status, as &#39;base-passwd.=
bb:do_populate_sysroot&#39;<br>
&gt; will have already been executed beforehand.<br>
&gt; <br>
&gt; Signed-off-by: Gowrishankar Saminathan &lt;<a href=3D"mailto:gowrishan=
karstg@gmail.com" target=3D"_blank">gowrishankarstg@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 lib/bb/runqueue.py | 8 ++++----<br>
&gt;=C2=A0 1 file changed, 4 insertions(+), 4 deletions(-)<br>
&gt; <br>
&gt; diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py<br>
&gt; index c40a3be2..446b1667 100644<br>
&gt; --- a/lib/bb/runqueue.py<br>
&gt; +++ b/lib/bb/runqueue.py<br>
&gt; @@ -1789,7 +1789,7 @@ class RunQueueExecute:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.sq_live =3D set()<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.updated_taskhash_queue =3D []<b=
r>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.pending_migrations =3D set()<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.pending_migrations =3D []<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.runq_buildable =3D set()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.runq_running =3D set()<br>
&gt; @@ -2422,7 +2422,7 @@ class RunQueueExecute:<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 def process_possible_migrations(self):<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 changed =3D set()<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 changed =3D []<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 toprocess =3D set()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for tid, unihash in self.updated_tas=
khash_queue.copy():<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if tid in self.runq_ru=
nning and tid not in self.runq_complete:<br>
&gt; @@ -2492,7 +2492,7 @@ class RunQueueExecute:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 #logger.debug(&quot;Task %s hash changes: %s-&gt;%s %s-&gt;%s&quot; =
% (tid, orighash, newhash, origuni, newuni))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 self.rqdata.runtaskentries[tid].hash =3D newhash<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 self.rqdata.runtaskentries[tid].unihash =3D newuni<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 changed.add(tid)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 changed.append(tid)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 next |=
=3D self.rqdata.runtaskentries[tid].revdeps<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 total.re=
move(tid)<br>
&gt; @@ -2510,7 +2510,7 @@ class RunQueueExecute:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if tid not in self.rqd=
ata.runq_setscene_tids:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if tid not in self.pen=
ding_migrations:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.pending_=
migrations.add(tid)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.pending_=
migrations.append(tid)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 update_tasks =3D []<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for tid in self.pending_migrations.c=
opy():<br>
<br>
Thanks for the patch. Which release of bitbake did you find this issue<br>
with? There were fixes for issues like this which were made in master.<br>
I&#39;m worried this patch was developed against an older release and isn&#=
39;t<br>
applicable to master.<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
</blockquote></div>

--0000000000007a85ba06064452ef--

