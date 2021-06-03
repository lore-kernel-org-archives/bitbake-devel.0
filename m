Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web11.1516.1622738486485796774
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 03 Jun 2021 09:41:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=EVzB+5UI;
 spf=softfail (domain: sakoman.com, ip: 209.85.221.41, mailfrom: steve@sakoman.com)
Received: by mail-wr1-f41.google.com with SMTP id q5so6543348wrm.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 03 Jun 2021 09:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XSTwR5P7ju1HiIc07ym8e097B4jJjx8HAV8kyIrrb1k=;
        b=EVzB+5UIGikE+2DLfkSC8NKnt8tfQtxY1WQwNgbJfVbeu63diLiCJMZwMwxLbmBxPH
         nQ1SwjigTshA+CFGNs3o55O6PiIHogh1y5/g7Bv0AodHt55IXGXKwAnZIu6QJePvWVmh
         z9JxpK/99s4y14zGxLX8koN0D2FpEtOjV3MgZilQ22Jd2UfxKQdXfb17gHuFxgNcubJ7
         92U0MEs3v4WtQoWbThBWuWEQ7x2AATSINSKbkd9B+TkYqCA86tt19bmtO3eP251l94i4
         kvEv6om3LZkMe1Om3pA8QUl1f/ZCTq8XttlTGaSdeAcneauRsbHQ6F68S/23+IYoEJVi
         zuow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XSTwR5P7ju1HiIc07ym8e097B4jJjx8HAV8kyIrrb1k=;
        b=NRaywRlRSBQoKDFFNi8Kn5jXHkWTqz4DJwPRE/ZbQyiD6nuAvP6b/xBJGU3Dge8+AE
         aqsTw1pUSy5iY1Bv/ng4L0LYZXxBRV/u8xkoM2E30UMq4v6iDFor0teqvejC2LlcU7a7
         sM/AGfhcaEPNX3PqIYbts2htm6GmRc3n3IF+NMH+Y38BSLCr/Ks2LBqkp64FM5FiSdTd
         5V0y19+LA6BC60fSosh3x1Jo77hKwe5IHf1L45kTD8nc/lzweCB1kk8NxQksNIsypxzm
         JqA4oLM7NDrFUpgL3X5cuD2OaHEY/IkzfH9T5bZJCPJkpkh6NuyopyBGgdlygk/WINQM
         vGjQ==
X-Gm-Message-State: AOAM532A5z0r0DgCVH7P45LAERzYP09tDjm2+iEKbRzIRvpV8QBg9APT
	O8vtOrdRWwZ4M8ndv/jnY46WSSCPCUAOXuvH/0OLiQ==
X-Google-Smtp-Source: ABdhPJxrULfzNcRx8sTf5ofLDw8J/wBo0yMPw/xL/8uIrV0UK/T64Kq5G4mF+7vJip9SZux7xUY3TTV9WP4AmO2IUck=
X-Received: by 2002:a5d:6c6d:: with SMTP id r13mr829812wrz.350.1622738484703;
 Thu, 03 Jun 2021 09:41:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210603114543.98044-1-Martin.Jansa@gmail.com>
 <CAOSpxdaLzBr-cO2KhD5-JETRxDYnV=-Ykg12YWZa1AH1bzAGmQ@mail.gmail.com> <CA+chaQcfQt2m+3=bFnqDHekPs4Ts26tpkRhVOGE0dDjBvqVcDQ@mail.gmail.com>
In-Reply-To: <CA+chaQcfQt2m+3=bFnqDHekPs4Ts26tpkRhVOGE0dDjBvqVcDQ@mail.gmail.com>
From: "Steve Sakoman" <steve@sakoman.com>
Date: Thu, 3 Jun 2021 06:41:13 -1000
Message-ID: <CAOSpxdZwjX30TBesHZLxSx6oppzgdAGwS3Sh4O3N9Dybz3hy4g@mail.gmail.com>
Subject: Re: [1.46][PATCH 1/4] cooker: Ensure parse_quit thread is closed down
To: Martin Jansa <martin.jansa@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 3, 2021 at 6:17 AM Martin Jansa <martin.jansa@gmail.com> wrote:
>
> Yes, on big build with a lot of recipes and also multilib enabled I'm see=
ing bitbake getting stuck quite often after parsing errors (usually when de=
velopers use wrong version in SRCPV fails to expand). Unfortunately this me=
ans that such jenkins jobs are stuck forever until someone notices that the=
y are running way too long and aborts them manually (which is quite bad as =
the regular builds can take between 1-20 hours, so the stuck build really s=
tands-out only after it was blocking whole builder for a day or 2.

Thanks for the additional details.  I'll pull these into my test queue
and see if it causes any problems on the autobuilder.

Steve

> I've also asked RP about these earlier today:
> 09:32 < JaMa> RP: any bad memories about top 4 commits in https://git.ope=
nembedded.org/bitbake-contrib/log/?h=3Djansa/1.46-cooker-backports ? It see=
ms to fix parser deadlock
>               I'm seeing quite often with dunfell after parsing exception=
s (maybe only the last commit is needed), I'll do more testing and then wou=
ld like to suggest them
>               to Steve
> 09:42 < RP> JaMa: I think it may lead to more autobuilder hangs/timeouts =
due to the hanging writer thread we wait on :/
> 09:42 < RP> JaMa: but I can understand why they may be a good idea
>
> and I've shared more details with JPEW few days ago #yocto/2021-05-28:
>
> 00:13 < JaMa> JPEW: I have a question about your last bitbake fix https:/=
/lists.openembedded.org/g/bitbake-devel/message/12343 does this happen alwa=
ys or only rarely? I'm seeing bitbake hanging after early parsing errors (t=
ypically b.data_smart.ExpansionError: Failure expanding variable SRCPV, exp=
ression was ${@bb.fetch2.get_srcrev(d)} which triggered exception FetchErro=
r: Fetcher failure: Unable to resolve 'foo' in
> 00:13 < JaMa> upstream git repository in git ls-remote output for ...
> 00:14 < JaMa> but it's quite rare and I haven't found a reliable way to t=
rigger this yet
> 00:15 < JPEW> It seems like it's always
> 00:16 < JPEW> It came up a lot in the YP summit when the students would m=
istype something
> 00:16 < JaMa> rm -rf tmp-glibc cache/ __pycache__/; bitbake --runall=3Dwr=
ite_bom_data lib32-some-big-image; in for loop was able to eventually repro=
duce it, but when I try to replicate it on something smaller with less laye=
rs it doesn't happen (or I wasn't patient enough)
> 00:18 < JPEW> JaMa: Interesting. It could be related... Its caused by the=
 client not sending an message to the server, perhaps there is something el=
se that could cause it
> 00:19 < JPEW> Something more likely with a lot of layers
> 00:19 < JaMa> it left 3 processes behind, strace -p shows:
> 00:19 < JaMa> select(12, [10 11], [], [], {tv_sec=3D30, tv_usec=3D0}) =3D=
 0 (Timeout)
> 00:19 < JaMa> 2nd one:
> 00:20 < JaMa> futex(0x12e9930, FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REAL=
TIME, 0, {tv_sec=3D1622142706, tv_nsec=3D509127000}, 0xffffffff) =3D -1 ETI=
MEDOUT (Connection timed out)
> 00:20 < JaMa> 3rd:
> 00:20 < JaMa> read(20,
> 00:21 < JPEW> JaMa: The defining characteristic was that bitbake-server d=
idn't exit and you had to kill it...I didn't look for other processes
> 00:21 < JaMa> ok, possibly different path then, here bitbake-server is al=
ready gone
> 00:22 < JPEW> Probably then
> 00:22 < JPEW> Sorry :)
> 00:22 < JaMa> will continue to debug this, it's also worth noting that I =
see it on dunfell, but that's just because most our developers produce thos=
e parsing errors on dunfell based builds :)
> 00:23 < JaMa> no problem, thanks anyway
>
>
> In the end I was able to trigger this hang after parsing error (wrong tag=
 in SRCREV intentionally included in conf/local.conf) in less then 10 itera=
tions of:
> for i in `seq -w 1 1000`; do rm -rf tmp-glibc/ bitbake-cookerdaemon.log  =
cache/ __pycache__/; echo $i; bitbake --runall=3Dwrite_bom_data lib32-big-i=
mage >log.parse.$i 2>&1; done
>
> and was surprised that it passed all 1000 iterations with gatesgarth and =
newer. Then confirmed that it can also pass 1000 iterations when using 1.48=
 bitbake with dunfell based build. First I was backporting process.py relat=
ed changes as originally I was hoping that already backported
> https://git.openembedded.org/bitbake/commit/?h=3D1.46&id=3D017a39ed05d065=
bf28fd38f91bcde8a098300551
> will fix these stuck jenkins jobs.
>
> Then I did git bisect on 1.46..1.48 just to discover the same commit in 1=
.48:
> https://git.openembedded.org/bitbake/commit/?h=3D1.48&id=3D5d02c98489d3a5=
836676b9c3fb3bd0157449db2b
> to be the "final piece" to fix this, but this change without the cooker c=
hanges didn't fix it in 1.46.
>
> I've also tried to remove some of these commits and backport only the las=
t 4/4 commit, but that only makes the conflicts bigger and diverges from 1.=
48 behavior, so I've kept all 4. To apply all without conflicts we would ne=
ed to backport https://git.openembedded.org/bitbake/commit/?h=3D1.48&id=3D5=
272f2489586479880ae8d046dfcdbe0963ee5bb as well, which seems to big change =
for backport (and also isn't needed to resolve this parsing error - and I d=
on't use multiconfig at all to properly test it with dunfell).
>
> Cheers,
>
> On Thu, Jun 3, 2021 at 5:55 PM Steve Sakoman <steve@sakoman.com> wrote:
>>
>> Hi Martin,
>>
>> Are you seeing a particular issue that these patches resolve?
>>
>> I seem to recall considering these patches last summer and
>> encountering issues on the autobuilder.  Sadly it has been long enough
>> that I don't recall the details.
>>
>> I spoke briefly with Richard this morning, and he also has some
>> concerns about taking these.  Any details you can provide on why you
>> find these necessary would be appreciated.
>>
>> Steve
>>
>> On Thu, Jun 3, 2021 at 1:45 AM Martin Jansa <martin.jansa@gmail.com> wro=
te:
>> >
>> > From: Richard Purdie <richard.purdie@linuxfoundation.org>
>> >
>> > Each run through the parser would leak a thread from the queue created=
 to
>> > shut the parser down. Close this down correctly and clean up the code =
flow
>> > slightly whilst in the area, making sure this thread does shut down co=
rrectly
>> > (we don't care if it loses data).
>> >
>> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>> > ---
>> >  lib/bb/cooker.py | 14 ++++++++------
>> >  1 file changed, 8 insertions(+), 6 deletions(-)
>> >
>> > diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
>> > index 11cc2b95..4820d268 100644
>> > --- a/lib/bb/cooker.py
>> > +++ b/lib/bb/cooker.py
>> > @@ -2056,12 +2056,11 @@ class CookerParser(object):
>> >                                              self.total)
>> >
>> >              bb.event.fire(event, self.cfgdata)
>> > -            for process in self.processes:
>> > -                self.parser_quit.put(None)
>> > -        else:
>> > -            self.parser_quit.cancel_join_thread()
>> > -            for process in self.processes:
>> > -                self.parser_quit.put(None)
>> > +
>> > +        # Allow data left in the cancel queue to be discarded
>> > +        self.parser_quit.cancel_join_thread()
>> > +        for process in self.processes:
>> > +            self.parser_quit.put(None)
>> >
>> >          # Cleanup the queue before call process.join(), otherwise the=
re might be
>> >          # deadlocks.
>> > @@ -2078,6 +2077,9 @@ class CookerParser(object):
>> >              else:
>> >                  process.join()
>> >
>> > +        self.parser_quit.close()
>> > +        self.parser_quit.join_thread()
>> > +
>> >          sync =3D threading.Thread(target=3Dself.bb_cache.sync)
>> >          sync.start()
>> >          multiprocessing.util.Finalize(None, sync.join, exitpriority=
=3D-100)
>> > --
>> > 2.30.2
>> >
