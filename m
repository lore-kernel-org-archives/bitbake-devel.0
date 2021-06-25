Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
 by mx.groups.io with SMTP id smtpd.web09.6850.1624624697399509885
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 25 Jun 2021 05:38:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=dkSBEOGN;
 spf=pass (domain: gmail.com, ip: 209.85.210.41, mailfrom: krussell7711@gmail.com)
Received: by mail-ot1-f41.google.com with SMTP id 6-20020a9d07860000b02903e83bf8f8fcso9059081oto.12
        for <bitbake-devel@lists.openembedded.org>; Fri, 25 Jun 2021 05:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+R57mTTX1qw8q0VoQPK0QoANmcjqx+SNAxq6ehbBMMs=;
        b=dkSBEOGNd61HmMwL1VZ489MTIlD6OjppORMqN8Bgny8N1f8hpMG9c6bBgImFAO1eOc
         p01icXNupS8om+tKqYHJNZkNLtLLqX4MTnDYBQ+gtlPMxMU/x8he7HmpRLYpvMQ6eRzP
         EE3GzwZKulnPrmYx8n9ZYWB9Aqw8rkYywRBgw1ZH+29jRhKuAaTLGRchWdVW484yxtzr
         Yk4pUcf1m4ynFDniwI1c3AI9lTmV+DNDZ9h70EZjYNAkgHawT2DA7+q+JZxoYeg+wRs3
         Uy2b9BpRcjj9tpVl7ULj8xCnHJeZvQ/77l+jOP3GPU2JHVeKgMSu8LH/tZcGK+a4AMVZ
         Z21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+R57mTTX1qw8q0VoQPK0QoANmcjqx+SNAxq6ehbBMMs=;
        b=rriwIc27T/GN0xaOtzHNnZUmKPke+2iMcdXJjlbiGbMb6q9lrl10I7P2bcZGshA3ZR
         BRs3h3E2Pfh/PQ+esNw+F2GhDDuxAizv9yCUDNTm5rzxPmlirhUWqwrJUpk3pwea7Bpi
         3YdQ4yU0ObHqW2ITgBu0fifNfMadfk4UtALyn2S4qQi0IqIbL0qkgrwfXfKqMv+PrIwo
         LOpVvNdmMbzlgazpZvp7SUeiB6Cw6P7BZDPzV3LuSGx7kA81Z970wlH3n6W0f5Fqaczw
         gOQKT3VMBFnEhu7I5IBaCF15cNdJnguUK6Wb8RMmHlCYTUOmaJrSIri51NkbzoebO7Ob
         W/Wg==
X-Gm-Message-State: AOAM531b25bA1jzLYFD+bDk+CPDCKSZRzux0sPypj5+P+TiXwAsAFtAh
	gqjra4KBvCPztTEV92E/rHufWQZapXmFzdX60R2gtgh8uzg=
X-Google-Smtp-Source: ABdhPJx62Td8MnZLCH3NoGp+fyXWEQNdNynMv/JtW3GxlaLb/VE1L359KrmjdLCaMHt40qDVvdgw0NAGt6YJo5uepBE=
X-Received: by 2002:a9d:4105:: with SMTP id o5mr9398438ote.20.1624624696482;
 Fri, 25 Jun 2021 05:38:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210508091457.2084843-1-richard.purdie@linuxfoundation.org>
 <CAFrQVPMHson5cyOgmcDZHFTbzYHVPrdebiSZ5Ad8AtjkfmhGvw@mail.gmail.com> <5fb285259b90e3f8d7f9c01c778e79686563e350.camel@linuxfoundation.org>
In-Reply-To: <5fb285259b90e3f8d7f9c01c778e79686563e350.camel@linuxfoundation.org>
From: bkylerussell@gmail.com
Date: Fri, 25 Jun 2021 08:38:05 -0400
Message-ID: <CAFrQVPM1U858WOZYg06UKCOCPHkPKzsWVJzd4RcoY+S+sP8NSA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] runqueue: Improve multiconfig deferred task issues
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000ed5d0b05c5966979"

--000000000000ed5d0b05c5966979
Content-Type: text/plain; charset="UTF-8"

On Fri, Jun 25, 2021 at 6:05 AM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> I'm afraid I simply don't have the bandwidth to work on everything and
> whilst I do want to look into and fix those issues, I'm struggling
> to find the time (amongst a long list of other things).
>

Thanks, Richard.  No worries.  I completely understand.  The information
you've provided
is helpful to at least make sure I'm headed in the right direction.  I'll
keep studying the recent
multiconfig patch sets to see if I can come up with some options.

That said, I've held off since I know if this does cause further problems,
> I don't have the bandwidth to look into it. I've also not 100% happy
> the code is right and I don' want to see the inevitable backport to dunfell
> request when I know there are more issues remaining.
>

I did try naively backporting this to dunfell (in addition to a handful of
other
multiconfig runqueue patches that have been submitted recently), but ended
up
with a runqueue deadlock where essentially all the native tasks that had
just been
deferred were forced to run.  I'll keep analyzing.

> I have an issue on dunfell where two valid setscene tasks are getting
> > scheduled for native packages even though the hashes are equivalent.
> > When both configs' do_populate_sysroot_setscene tasks get scheduled near
> > the same time, one config often fails with an unpack error.  One config
> > sees that the other config's task has already started downloading
> sstate,
> > so it immediately starts unpacking the tgz it finds.  However, if wget
> > hasn't actually finished, tar errors on EOF during
> run.sstate_unpack_package.
> > I can readily reproduce this on my setup.
> I'm not completely confident it I'm not completely confident it
> That sounds like an sstate or fetcher bug, it should be moving the files
> into place. Obviously it shouldn't be racing either but two builds could
> race. We should probably have a bug filed for that...
>

I do think that my issue would be avoided if sstate_installpkg() looked for
the tgz done file
instead of the tgz itself.  Even if both tasks were scheduled, making sure
the download had
completed would be preferable to unpacking an incomplete download, but it
didn't seem like
the best approach if one of the tasks could be optimized away.  I'd be
happy to submit a patch
for that if it sounds interesting, but didn't want to waste time on it if
we'd rather just address the
task deferment.

Thanks again,

Kyle

--000000000000ed5d0b05c5966979
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Fri, Jun 25, 2021 at 6:05 AM Richard Purdie &lt;<a href=3D"mailto=
:richard.purdie@linuxfoundation.org">richard.purdie@linuxfoundation.org</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
I&#39;m afraid I simply don&#39;t have the bandwidth to work on everything =
and<br>
whilst I do want to look into and fix those issues, I&#39;m struggling<br>
to find the time (amongst a long list of other things).<br></blockquote><di=
v><br></div><div>Thanks, Richard.=C2=A0 No worries.=C2=A0 I completely unde=
rstand.=C2=A0 The information you&#39;ve provided</div><div>is helpful to a=
t least make sure I&#39;m headed in the right direction.=C2=A0 I&#39;ll kee=
p studying the recent</div><div>multiconfig patch sets to see if I can come=
 up with some options.</div><br><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">

That said, I&#39;ve held off since I know if this does cause further proble=
ms,<br>
I don&#39;t have the bandwidth to look into it. I&#39;ve also not 100% happ=
y<br>
the code is right and I don&#39; want to see the inevitable backport to dun=
fell<br>
request when I know there are more issues remaining.<br></blockquote><div><=
br></div><div>I did try naively backporting this to dunfell (in addition to=
 a handful of other</div><div>multiconfig runqueue patches that have been s=
ubmitted recently), but ended up</div><div>with a runqueue deadlock where e=
ssentially all the native tasks that had just been</div><div>deferred were =
forced to run.=C2=A0 I&#39;ll keep analyzing.<br></div><div><br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">

&gt; I have an issue on dunfell where two valid setscene tasks are getting<=
br>
&gt; scheduled for native packages even though the hashes are equivalent.=
=C2=A0=C2=A0<br>
&gt; When both configs&#39; do_populate_sysroot_setscene tasks get schedule=
d near=C2=A0<br>
&gt; the same time, one config often fails with an unpack error.=C2=A0 One =
config=C2=A0<br>
&gt; sees that the other config&#39;s task has already started downloading =
sstate,=C2=A0<br>
&gt; so it immediately starts unpacking the tgz it finds.=C2=A0 However, if=
 wget=C2=A0<br>
&gt; hasn&#39;t actually finished, tar errors on EOF during run.sstate_unpa=
ck_package.<br>
&gt; I can readily reproduce this on my setup.<br>
I&#39;m not completely confident it I&#39;m not completely confident it <br=
>
That sounds like an sstate or fetcher bug, it should be moving the files=C2=
=A0<br>
into place. Obviously it shouldn&#39;t be racing either but two builds coul=
d<br>
race. We should probably have a bug filed for that...<br></blockquote><div>=
<br></div><div>I do think that my issue would be avoided if sstate_installp=
kg() looked for the tgz done file</div><div>instead of the tgz itself.=C2=
=A0 Even if both tasks were scheduled, making sure the download had</div><d=
iv>completed would be preferable to unpacking an incomplete download, but i=
t didn&#39;t seem like</div><div>the best approach if one of the tasks coul=
d be optimized away.=C2=A0 I&#39;d be happy to submit a patch</div><div>for=
 that if it sounds interesting, but didn&#39;t want to waste time on it if =
we&#39;d rather just address the</div><div>task deferment.</div><div><br></=
div><div>Thanks again,</div><div><br></div><div>Kyle<br></div></div></div>

--000000000000ed5d0b05c5966979--
