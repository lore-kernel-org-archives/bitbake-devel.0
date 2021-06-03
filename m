Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
 by mx.groups.io with SMTP id smtpd.web11.1195.1622737035014448956
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 03 Jun 2021 09:17:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=UuVILWEm;
 spf=pass (domain: gmail.com, ip: 209.85.218.52, mailfrom: martin.jansa@gmail.com)
Received: by mail-ej1-f52.google.com with SMTP id l1so10091624ejb.6
        for <bitbake-devel@lists.openembedded.org>; Thu, 03 Jun 2021 09:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1sJdg+G4TJYx2JYvfMilbjzHwGVj2NsOeJu70WSVNDI=;
        b=UuVILWEmM38fJ8Fc9FRARjkXxo07prL5iYEvew9ax6bJplvlDjkUBRSpm4yTNsY44H
         TledkqzOj2KwEjZehgEg7zpfVB8jgvpctsiHTeRTFLcQ0SVfmyvdKLo84G9i8CwzG9hC
         1wX/ZZevjdtcMtRGWW34BrnIvoUV7uE6bwqBcZa4BoaIgpJhW9Awz3clO0nf1s5+TOs8
         d9didNOQC0dEHAwdE17+H0Z7zp+pwLQJ2GbKPKYS+44dtTAH4Ommpp6XTsf4efxA0Epf
         8Ey1blrXtGr9OtPaWFrAioRQGQyQQsVxk8/p/viCnnbBZsvfDTtM8x5lP3uO6g+xud1t
         PsFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1sJdg+G4TJYx2JYvfMilbjzHwGVj2NsOeJu70WSVNDI=;
        b=cSJnTLf8hck0FoYxWiNsq4I/i90QV9bRwlaXFwoY2yXBMuOmGDUEqpqkbOX7uyLZY5
         /aqItmnTl9JyF0cIvLZQ8YfSxqcnsazldXFq6sa6fVqi3Pzl89+KevlEZ+lynwdKhC27
         4DbOX2I+ho975WuwaAYOScrrgGYm7lEhyLz+0S2C+Xivl19vTVV5rEO4oRppjuyyWT4k
         CnU1Q4wUTXfL1hxk3pLceLoCXzZxcPjQcVbiALruPrSW+3OJ+mstBqNtWcHRGnq54J4C
         KHVnXlFzpkebrGPVJ4qQEIZ5ZeZtPFLlALEzyL25ax1vWhog3T7RBPJXtQ+ofU1cV6uY
         8/fg==
X-Gm-Message-State: AOAM531GV0w4zAK4fVIdRDaVXBqB30KaBmEpDtgeFYx5wQNROBoOi/Xk
	liw3CjCvyQCOMpBs+EX5VmAri3xXJje/qMClQDA=
X-Google-Smtp-Source: ABdhPJxErVb3uT1+XYcRnGwqiC+mie5WRtKdyPyCQgzgDtNbqPWmw8YUw8DJRWB/0Bb5/XNdbPy1Ac3qczwVbcF+NdM=
X-Received: by 2002:a17:906:8688:: with SMTP id g8mr166561ejx.470.1622737033199;
 Thu, 03 Jun 2021 09:17:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210603114543.98044-1-Martin.Jansa@gmail.com> <CAOSpxdaLzBr-cO2KhD5-JETRxDYnV=-Ykg12YWZa1AH1bzAGmQ@mail.gmail.com>
In-Reply-To: <CAOSpxdaLzBr-cO2KhD5-JETRxDYnV=-Ykg12YWZa1AH1bzAGmQ@mail.gmail.com>
From: "Martin Jansa" <Martin.Jansa@gmail.com>
Date: Thu, 3 Jun 2021 18:17:02 +0200
Message-ID: <CA+chaQcfQt2m+3=bFnqDHekPs4Ts26tpkRhVOGE0dDjBvqVcDQ@mail.gmail.com>
Subject: Re: [1.46][PATCH 1/4] cooker: Ensure parse_quit thread is closed down
To: Steve Sakoman <steve@sakoman.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: multipart/alternative; boundary="0000000000006d848d05c3dee85f"

--0000000000006d848d05c3dee85f
Content-Type: text/plain; charset="UTF-8"

Yes, on big build with a lot of recipes and also multilib enabled I'm
seeing bitbake getting stuck quite often after parsing errors (usually when
developers use wrong version in SRCPV fails to expand). Unfortunately this
means that such jenkins jobs are stuck forever until someone notices that
they are running way too long and aborts them manually (which is quite bad
as the regular builds can take between 1-20 hours, so the stuck build
really stands-out only after it was blocking whole builder for a day or 2.

I've also asked RP about these earlier today:
09:32 < JaMa> RP: any bad memories about top 4 commits in
https://git.openembedded.org/bitbake-contrib/log/?h=jansa/1.46-cooker-backports
? It seems to fix parser deadlock
              I'm seeing quite often with dunfell after parsing exceptions
(maybe only the last commit is needed), I'll do more testing and then would
like to suggest them
              to Steve
09:42 < RP> JaMa: I think it may lead to more autobuilder hangs/timeouts
due to the hanging writer thread we wait on :/
09:42 < RP> JaMa: but I can understand why they may be a good idea

and I've shared more details with JPEW few days ago #yocto/2021-05-28:

00:13 < JaMa> JPEW: I have a question about your last bitbake fix
https://lists.openembedded.org/g/bitbake-devel/message/12343 does this
happen always or only rarely? I'm seeing bitbake hanging after early
parsing errors (typically b.data_smart.ExpansionError: Failure expanding
variable SRCPV, expression was ${@bb.fetch2.get_srcrev(d)} which triggered
exception FetchError: Fetcher failure: Unable to resolve 'foo' in
00:13 < JaMa> upstream git repository in git ls-remote output for ...
00:14 < JaMa> but it's quite rare and I haven't found a reliable way to
trigger this yet
00:15 < JPEW> It seems like it's always
00:16 < JPEW> It came up a lot in the YP summit when the students would
mistype something
00:16 < JaMa> rm -rf tmp-glibc cache/ __pycache__/; bitbake
--runall=write_bom_data lib32-some-big-image; in for loop was able to
eventually reproduce it, but when I try to replicate it on something
smaller with less layers it doesn't happen (or I wasn't patient enough)
00:18 < JPEW> JaMa: Interesting. It could be related... Its caused by the
client not sending an message to the server, perhaps there is something
else that could cause it
00:19 < JPEW> Something more likely with a lot of layers
00:19 < JaMa> it left 3 processes behind, strace -p shows:
00:19 < JaMa> select(12, [10 11], [], [], {tv_sec=30, tv_usec=0}) = 0
(Timeout)
00:19 < JaMa> 2nd one:
00:20 < JaMa> futex(0x12e9930,
FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 0, {tv_sec=1622142706,
tv_nsec=509127000}, 0xffffffff) = -1 ETIMEDOUT (Connection timed out)
00:20 < JaMa> 3rd:
00:20 < JaMa> read(20,
00:21 < JPEW> JaMa: The defining characteristic was that bitbake-server
didn't exit and you had to kill it...I didn't look for other processes
00:21 < JaMa> ok, possibly different path then, here bitbake-server is
already gone
00:22 < JPEW> Probably then
00:22 < JPEW> Sorry :)
00:22 < JaMa> will continue to debug this, it's also worth noting that I
see it on dunfell, but that's just because most our developers produce
those parsing errors on dunfell based builds :)
00:23 < JaMa> no problem, thanks anyway


In the end I was able to trigger this hang after parsing error (wrong tag
in SRCREV intentionally included in conf/local.conf) in less then 10
iterations of:
for i in `seq -w 1 1000`; do rm -rf tmp-glibc/ bitbake-cookerdaemon.log
 cache/ __pycache__/; echo $i; bitbake --runall=write_bom_data
lib32-big-image >log.parse.$i 2>&1; done

and was surprised that it passed all 1000 iterations with gatesgarth and
newer. Then confirmed that it can also pass 1000 iterations when using 1.48
bitbake with dunfell based build. First I was backporting process.py
related changes as originally I was hoping that already backported
https://git.openembedded.org/bitbake/commit/?h=1.46&id=017a39ed05d065bf28fd38f91bcde8a098300551
will fix these stuck jenkins jobs.

Then I did git bisect on 1.46..1.48 just to discover the same commit in
1.48:
https://git.openembedded.org/bitbake/commit/?h=1.48&id=5d02c98489d3a5836676b9c3fb3bd0157449db2b
to be the "final piece" to fix this, but this change without the cooker
changes didn't fix it in 1.46.

I've also tried to remove some of these commits and backport only the last
4/4 commit, but that only makes the conflicts bigger and diverges from 1.48
behavior, so I've kept all 4. To apply all without conflicts we would need
to backport
https://git.openembedded.org/bitbake/commit/?h=1.48&id=5272f2489586479880ae8d046dfcdbe0963ee5bb
as well, which seems to big change for backport (and also isn't needed to
resolve this parsing error - and I don't use multiconfig at all to properly
test it with dunfell).

Cheers,

On Thu, Jun 3, 2021 at 5:55 PM Steve Sakoman <steve@sakoman.com> wrote:

> Hi Martin,
>
> Are you seeing a particular issue that these patches resolve?
>
> I seem to recall considering these patches last summer and
> encountering issues on the autobuilder.  Sadly it has been long enough
> that I don't recall the details.
>
> I spoke briefly with Richard this morning, and he also has some
> concerns about taking these.  Any details you can provide on why you
> find these necessary would be appreciated.
>
> Steve
>
> On Thu, Jun 3, 2021 at 1:45 AM Martin Jansa <martin.jansa@gmail.com>
> wrote:
> >
> > From: Richard Purdie <richard.purdie@linuxfoundation.org>
> >
> > Each run through the parser would leak a thread from the queue created to
> > shut the parser down. Close this down correctly and clean up the code
> flow
> > slightly whilst in the area, making sure this thread does shut down
> correctly
> > (we don't care if it loses data).
> >
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > ---
> >  lib/bb/cooker.py | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> > index 11cc2b95..4820d268 100644
> > --- a/lib/bb/cooker.py
> > +++ b/lib/bb/cooker.py
> > @@ -2056,12 +2056,11 @@ class CookerParser(object):
> >                                              self.total)
> >
> >              bb.event.fire(event, self.cfgdata)
> > -            for process in self.processes:
> > -                self.parser_quit.put(None)
> > -        else:
> > -            self.parser_quit.cancel_join_thread()
> > -            for process in self.processes:
> > -                self.parser_quit.put(None)
> > +
> > +        # Allow data left in the cancel queue to be discarded
> > +        self.parser_quit.cancel_join_thread()
> > +        for process in self.processes:
> > +            self.parser_quit.put(None)
> >
> >          # Cleanup the queue before call process.join(), otherwise there
> might be
> >          # deadlocks.
> > @@ -2078,6 +2077,9 @@ class CookerParser(object):
> >              else:
> >                  process.join()
> >
> > +        self.parser_quit.close()
> > +        self.parser_quit.join_thread()
> > +
> >          sync = threading.Thread(target=self.bb_cache.sync)
> >          sync.start()
> >          multiprocessing.util.Finalize(None, sync.join,
> exitpriority=-100)
> > --
> > 2.30.2
> >
>

--0000000000006d848d05c3dee85f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Yes, on big build with a lot of recipes and also mult=
ilib enabled I&#39;m seeing bitbake getting stuck quite often after parsing=
 errors (usually when developers use wrong version in SRCPV fails to expand=
). Unfortunately this means that such jenkins jobs are stuck forever until =
someone notices that they are running way too long and aborts them manually=
 (which is quite bad as the regular builds can take between 1-20 hours, so =
the stuck build really stands-out only after it was blocking whole builder =
for a day or 2.</div><div><br></div><div>I&#39;ve also asked RP about these=
 earlier today:</div>09:32 &lt; JaMa&gt; RP: any bad memories about top 4 c=
ommits in <a href=3D"https://git.openembedded.org/bitbake-contrib/log/?h=3D=
jansa/1.46-cooker-backports">https://git.openembedded.org/bitbake-contrib/l=
og/?h=3Djansa/1.46-cooker-backports</a> ? It seems to fix parser deadlock <=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 I&#39;m seeing quite of=
ten with dunfell after parsing exceptions (maybe only the last commit is ne=
eded), I&#39;ll do more testing and then would like to suggest them <br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 to Steve<br>09:42 &lt; RP&gt;=
 JaMa: I think it may lead to more autobuilder hangs/timeouts due to the ha=
nging writer thread we wait on :/<br>09:42 &lt; RP&gt; JaMa: but I can unde=
rstand why they may be a good idea<br><div><br></div><div><div>and I&#39;ve=
 shared more details with JPEW few days ago=C2=A0#yocto/2021-05-28:</div><d=
iv><br></div><div>00:13 &lt; JaMa&gt; JPEW: I have a question about your la=
st bitbake fix <a href=3D"https://lists.openembedded.org/g/bitbake-devel/me=
ssage/12343">https://lists.openembedded.org/g/bitbake-devel/message/12343</=
a> does this happen always or only rarely? I&#39;m seeing bitbake hanging a=
fter early parsing errors (typically b.data_smart.ExpansionError: Failure e=
xpanding variable SRCPV, expression was ${@bb.fetch2.get_srcrev(d)} which t=
riggered exception FetchError: Fetcher failure: Unable to resolve &#39;foo&=
#39; in<br>00:13 &lt; JaMa&gt; upstream git repository in git ls-remote out=
put for ...<br>00:14 &lt; JaMa&gt; but it&#39;s quite rare and I haven&#39;=
t found a reliable way to trigger this yet<br>00:15 &lt; JPEW&gt; It seems =
like it&#39;s always<br>00:16 &lt; JPEW&gt; It came up a lot in the YP summ=
it when the students would mistype something<br>00:16 &lt; JaMa&gt; rm -rf =
tmp-glibc cache/ __pycache__/; bitbake --runall=3Dwrite_bom_data lib32-some=
-big-image; in for loop was able to eventually reproduce it, but when I try=
 to replicate it on something smaller with less layers it doesn&#39;t happe=
n (or I wasn&#39;t patient enough)<br></div><div>00:18 &lt; JPEW&gt; JaMa: =
Interesting. It could be related... Its caused by the client not sending an=
 message to the server, perhaps there is something else that could cause it=
<br>00:19 &lt; JPEW&gt; Something more likely with a lot of layers<br></div=
><div>00:19 &lt; JaMa&gt; it left 3 processes behind, strace -p shows:<br>0=
0:19 &lt; JaMa&gt; select(12, [10 11], [], [], {tv_sec=3D30, tv_usec=3D0}) =
=3D 0 (Timeout)<br>00:19 &lt; JaMa&gt; 2nd one:<br>00:20 &lt; JaMa&gt; fute=
x(0x12e9930, FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 0, {tv_sec=3D1=
622142706, tv_nsec=3D509127000}, 0xffffffff) =3D -1 ETIMEDOUT (Connection t=
imed out)<br>00:20 &lt; JaMa&gt; 3rd:<br>00:20 &lt; JaMa&gt; read(20,<br>00=
:21 &lt; JPEW&gt; JaMa: The defining characteristic was that bitbake-server=
 didn&#39;t exit and you had to kill it...I didn&#39;t look for other proce=
sses<br>00:21 &lt; JaMa&gt; ok, possibly different path then, here bitbake-=
server is already gone<br>00:22 &lt; JPEW&gt; Probably then<br>00:22 &lt; J=
PEW&gt; Sorry :)<br>00:22 &lt; JaMa&gt; will continue to debug this, it&#39=
;s also worth noting that I see it on dunfell, but that&#39;s just because =
most our developers produce those parsing errors on dunfell based builds :)=
<br>00:23 &lt; JaMa&gt; no problem, thanks anyway<br></div><div><br></div><=
div><br></div><div>In the end I was able to trigger this hang after parsing=
 error (wrong tag in SRCREV intentionally included in conf/local.conf) in l=
ess then 10 iterations of:</div><div>for i in `seq -w 1 1000`; do rm -rf tm=
p-glibc/ bitbake-cookerdaemon.log =C2=A0cache/ __pycache__/; echo $i; bitba=
ke --runall=3Dwrite_bom_data lib32-big-image &gt;log.parse.$i 2&gt;&amp;1; =
done<br></div><div><br></div><div>and was surprised that it passed all 1000=
 iterations with gatesgarth and newer. Then confirmed that it can also pass=
 1000 iterations when using 1.48 bitbake with dunfell based build. First I =
was backporting process.py related changes as originally I was hoping that =
already backported</div><div><a href=3D"https://git.openembedded.org/bitbak=
e/commit/?h=3D1.46&amp;id=3D017a39ed05d065bf28fd38f91bcde8a098300551">https=
://git.openembedded.org/bitbake/commit/?h=3D1.46&amp;id=3D017a39ed05d065bf2=
8fd38f91bcde8a098300551</a><br></div><div>will fix these stuck jenkins jobs=
.</div><div><br></div><div>Then I did git bisect on 1.46..1.48 just to disc=
over the same commit in 1.48:</div><div><a href=3D"https://git.openembedded=
.org/bitbake/commit/?h=3D1.48&amp;id=3D5d02c98489d3a5836676b9c3fb3bd0157449=
db2b">https://git.openembedded.org/bitbake/commit/?h=3D1.48&amp;id=3D5d02c9=
8489d3a5836676b9c3fb3bd0157449db2b</a><br></div><div>to be the &quot;final =
piece&quot; to fix this, but this change without the cooker changes didn&#3=
9;t fix it in 1.46.</div><div><br></div><div>I&#39;ve also tried to remove =
some of these commits and backport only the last 4/4 commit, but that only =
makes the conflicts bigger and diverges from 1.48 behavior, so I&#39;ve kep=
t all 4. To apply all without conflicts we would need to backport=C2=A0<a h=
ref=3D"https://git.openembedded.org/bitbake/commit/?h=3D1.48&amp;id=3D5272f=
2489586479880ae8d046dfcdbe0963ee5bb">https://git.openembedded.org/bitbake/c=
ommit/?h=3D1.48&amp;id=3D5272f2489586479880ae8d046dfcdbe0963ee5bb</a> as we=
ll, which seems to big change for backport (and also isn&#39;t needed to re=
solve this parsing error - and I don&#39;t use multiconfig at all to proper=
ly test it with dunfell).</div><div><br></div><div>Cheers,</div><div></div>=
</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_=
attr">On Thu, Jun 3, 2021 at 5:55 PM Steve Sakoman &lt;<a href=3D"mailto:st=
eve@sakoman.com">steve@sakoman.com</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">Hi Martin,<br>
<br>
Are you seeing a particular issue that these patches resolve?<br>
<br>
I seem to recall considering these patches last summer and<br>
encountering issues on the autobuilder.=C2=A0 Sadly it has been long enough=
<br>
that I don&#39;t recall the details.<br>
<br>
I spoke briefly with Richard this morning, and he also has some<br>
concerns about taking these.=C2=A0 Any details you can provide on why you<b=
r>
find these necessary would be appreciated.<br>
<br>
Steve<br>
<br>
On Thu, Jun 3, 2021 at 1:45 AM Martin Jansa &lt;<a href=3D"mailto:martin.ja=
nsa@gmail.com" target=3D"_blank">martin.jansa@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; From: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfoundat=
ion.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;<br>
&gt;<br>
&gt; Each run through the parser would leak a thread from the queue created=
 to<br>
&gt; shut the parser down. Close this down correctly and clean up the code =
flow<br>
&gt; slightly whilst in the area, making sure this thread does shut down co=
rrectly<br>
&gt; (we don&#39;t care if it loses data).<br>
&gt;<br>
&gt; Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@lin=
uxfoundation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&=
gt;<br>
&gt; ---<br>
&gt;=C2=A0 lib/bb/cooker.py | 14 ++++++++------<br>
&gt;=C2=A0 1 file changed, 8 insertions(+), 6 deletions(-)<br>
&gt;<br>
&gt; diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py<br>
&gt; index 11cc2b95..4820d268 100644<br>
&gt; --- a/lib/bb/cooker.py<br>
&gt; +++ b/lib/bb/cooker.py<br>
&gt; @@ -2056,12 +2056,11 @@ class CookerParser(object):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 self.total)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.event.fire(event, s=
elf.cfgdata)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for process in self.process=
es:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.parser_q=
uit.put(None)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.parser_quit.cancel_joi=
n_thread()<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for process in self.process=
es:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.parser_q=
uit.put(None)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Allow data left in the cancel queue to =
be discarded<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.parser_quit.cancel_join_thread()<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for process in self.processes:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.parser_quit.put(None)<=
br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Cleanup the queue before call proc=
ess.join(), otherwise there might be<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # deadlocks.<br>
&gt; @@ -2078,6 +2077,9 @@ class CookerParser(object):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 process.=
join()<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.parser_quit.close()<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.parser_quit.join_thread()<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sync =3D threading.Thread(target=3Ds=
elf.bb_cache.sync)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sync.start()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 multiprocessing.util.Finalize(None, =
sync.join, exitpriority=3D-100)<br>
&gt; --<br>
&gt; 2.30.2<br>
&gt;<br>
</blockquote></div>

--0000000000006d848d05c3dee85f--
