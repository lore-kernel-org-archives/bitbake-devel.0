Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.web11.7653.1626551835553577279
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 17 Jul 2021 12:57:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=Fo+CuccX;
 spf=pass (domain: gmail.com, ip: 209.85.216.52, mailfrom: chuckwolber@gmail.com)
Received: by mail-pj1-f52.google.com with SMTP id p9so8850110pjl.3
        for <bitbake-devel@lists.openembedded.org>; Sat, 17 Jul 2021 12:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H7nC28WLWArSWaiSqF63PgVmvjWgHu+7q1VlcY8/NcI=;
        b=Fo+CuccXGpmkuM4J9caCai8exkpTiYD77k6oJNFsinKcp0N6str658jQukhoK2r5Ra
         dEaU6Ghi8kKzW15qZzCrjub5b9NQS3WE7q7e9BScqD2G0omQ0wVFq+zfFaQ8C+giGZqN
         wPVpAApCaWUC8fsgM+epD4eTPhp7hDCDMyYTLJDhV6q+JLnEnfD6DkDB4YjvsjOT49Hz
         jY9PRfitWN+UnIQmgs3nXTK/W9ld/VnoD8CJJgES+sheUrRmcng+FLIAe2OdxtEJkA6B
         zoNKj8ybwOBkIbtnp0OTJuoVX42Sf9eZO5aJbbYmW5b9rX6SQBWo9k0tcQj2QHpNnGJ3
         d0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H7nC28WLWArSWaiSqF63PgVmvjWgHu+7q1VlcY8/NcI=;
        b=at2aPXhaz7k90tfXGUoDBNlQMoLh0UCprXNQUbjffug5ns9wj34bnBp6zrL96pGU5L
         GTzxHmEO0+epQDS72aO7CuECLPNpspe2u3RZoSf71z8A6PUX2Ik6WnX6Tsvk5cHamavC
         yC+9IjOkOqBYr/jyF0+FRDLHyPws01uW1Aqp2iC9iqHibQc3eZxKQHQk0p8SHa+iha3o
         /cs/H6l86Ss+8/wpXXWTbdMf6ZqSwjBK3gJ5iRQA9sOaSJGGl8TkLrMeMtAg0uZxDnky
         VhLv0oWke4bEYqpuKxECtWUj5mVF3uBqzViVZFeLDVSUWM9LqjeEHlUyEAwmCkyfsPT4
         Sn5A==
X-Gm-Message-State: AOAM53051zMW5MNCGOmTCP40m94dOKcf8Df277lJlPw/WfeIOq6ymG1Q
	nAlzEJUgAlyjH4vjNYYsMslg+2YIclOUolLaCuA=
X-Google-Smtp-Source: ABdhPJxJeXcjmBzItCjrWiyYQL1zyv0Bv5dfPS7EiTfHVVcom0QtIPSjVm0KDZ+/hkOFiU9NL4NMvYElo+w5ERs+G5Q=
X-Received: by 2002:a17:902:76cb:b029:12b:2fb8:7c35 with SMTP id
 j11-20020a17090276cbb029012b2fb87c35mr12788741plt.16.1626551834744; Sat, 17
 Jul 2021 12:57:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAKjpqyJ3NOLfgPQpuRqh6gwBJRZebW5sEPkEOT5bW6=Y_ZzkCA@mail.gmail.com>
In-Reply-To: <CAKjpqyJ3NOLfgPQpuRqh6gwBJRZebW5sEPkEOT5bW6=Y_ZzkCA@mail.gmail.com>
From: "Chuck Wolber" <chuckwolber@gmail.com>
Date: Sat, 17 Jul 2021 12:57:03 -0700
Message-ID: <CAB=6tBRfyCnAVOX3JsjLcM4qy+n15g2ov63V-ZkKvCqovxXAbQ@mail.gmail.com>
Subject: Re: [bitbake-devel] how bitbake works
To: Mayank Agarwal <mayank77fromindia@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000519f0405c7571cca"

--000000000000519f0405c7571cca
Content-Type: text/plain; charset="UTF-8"

On Sat, Jul 17, 2021 at 2:12 AM Mayank Agarwal <mayank77fromindia@gmail.com>
wrote:

>
> a) How bitbake decides the order of  compiling and executing modules.
>

You generally build images. Images have dependencies. If you map out the
dependencies as a big giant graph, the dependencies with no child nodes get
built first. The build continues from there as all dependencies are met and
then the core image can be assembled.

There are also some intrinsic dependencies like the sysroot compiler, etc
that always have to be built first. Bitbake caches dependencies and reuses
them in subsequent builds if it does not detect any changes to them.


> b) Is it possible to compile 1 module before or after another one
>

Think of it in terms of dependencies. If A depends on B, then B gets built
first. You would use the DEPENDS (build time dependency) and the
RDEPDENDS_${PN} (runtime dependencies) variables for this.



> c) Is there any file where we can see the complete list of all tasks that
> bitbake executes in the order of execution.
>

Yes, you can generate a graph of the entire execution with the --graphviz
argument, e.g. "bitbake core-image-sato --graphviz". This generates a build
graph document in the build directory.



> d) How can we use logging mechanism in bitbake.Is it possible to put log
> statements in recipe files and see the logs on terminal during compilation
> and execution.
>

Yes, but that is out of scope for a quick email reply like this.

You should read the manuals at https://docs.yoctoproject.org. They are a
very rich source of information. The more you read them, the smarter your
questions will get, and the more likely you are to get help when you
experience complex problems.

You might also want to take a look at the FAQ (
https://wiki.yoctoproject.org/wiki/FAQ) and the Technical FAQ (
https://wiki.yoctoproject.org/wiki/Technical_FAQ).


e) Optmization of bitbake steps.Is there any guide that tells how can we
> optimize.For me 1 module takes close to 3 hrs in executing
> Is there any method that i can reduce build time by pre compiling that
> module.
>

Faster hardware? It really depends on the specifics of what you are
building. There is no magic formula.

I have one build that takes 28 hours on a 2 core machine. It builds in 2-3
hours now on a 20 Core machine. My developers only require a subset of that
build so they can cache an initial build on their 4 core laptops in about 8
hours. There is also an option to use shared cache if that works for your
particular situation.

Also, I normally dedicate about 2.5 gigs of RAM per core to avoid crashes
due to RAM starvation. Otherwise you may experience random "difficult to
explain" build crashes.

..Ch:W..

-- 
*"Perfection must be reached by degrees; she requires the slow hand of
time." - Voltaire*

--000000000000519f0405c7571cca
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Sat, Jul 17, 2021 at 2:12 AM Mayank Ag=
arwal &lt;<a href=3D"mailto:mayank77fromindia@gmail.com">mayank77fromindia@=
gmail.com</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><br><div>a) How bitbak=
e decides the order of=C2=A0 compiling and executing modules.</div></div></=
blockquote><div><br></div><div>You generally build images. Images have depe=
ndencies. If you map out the dependencies as a big giant graph, the depende=
ncies with no child nodes get built first. The build continues from there a=
s all dependencies are met and then the core image can be assembled. <br></=
div><div><br></div><div>There are also some intrinsic dependencies like the=
 sysroot compiler, etc that always have to be built first. Bitbake caches d=
ependencies and reuses them in subsequent builds if it does not detect any =
changes to them.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex"><div dir=3D"ltr"><div>b) Is it possible to compile 1 modu=
le before or after another=C2=A0one</div></div></blockquote><div><br></div>=
<div>Think of it in terms of dependencies. If A depends on B, then B gets b=
uilt first. You would use the DEPENDS (build time dependency) and the RDEPD=
ENDS_${PN} (runtime dependencies) variables for this.</div><div><br></div><=
div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=
=3D"ltr"><div>c) Is there any file where we can see the complete list of al=
l tasks that bitbake executes in the order of execution.</div></div></block=
quote><div><br></div><div>Yes, you can generate a graph of the entire execu=
tion with the --graphviz argument, e.g. &quot;bitbake core-image-sato --gra=
phviz&quot;. This generates a build graph document in the build directory.<=
br></div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex"><div dir=3D"ltr"><div>d) How can we use logging mechanism i=
n bitbake.Is it possible to put log statements in recipe files and see the =
logs on terminal during compilation and execution.</div></div></blockquote>=
<div><br></div><div>Yes, but that is out of scope for a quick email reply l=
ike this.</div><div><br></div><div>You should read the manuals at <a href=
=3D"https://docs.yoctoproject.org">https://docs.yoctoproject.org</a>. They =
are a very rich source of information. The more you read them, the smarter =
your questions will get, and the more likely you are to get help when you e=
xperience complex problems. <br></div><div><br></div><div>You might also wa=
nt to take a look at the FAQ (<a href=3D"https://wiki.yoctoproject.org/wiki=
/FAQ">https://wiki.yoctoproject.org/wiki/FAQ</a>) and the Technical FAQ (<a=
 href=3D"https://wiki.yoctoproject.org/wiki/Technical_FAQ">https://wiki.yoc=
toproject.org/wiki/Technical_FAQ</a>).</div><div>=C2=A0</div><div><br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div>e)=
 Optmization of bitbake steps.Is there any guide that tells how can we opti=
mize.For me 1 module takes close to 3 hrs in executing</div><div>Is there a=
ny method that i can reduce build time by pre compiling that module.</div><=
/div></blockquote><div><br></div><div>Faster hardware? It really depends on=
 the specifics of what you are building. There is no magic formula.</div><d=
iv><br></div><div>I have one build that takes 28 hours on a 2 core machine.=
 It builds in 2-3 hours now on a 20 Core machine. My developers only requir=
e a subset of that build so they can cache an initial build on their 4 core=
 laptops in about 8 hours. There is also an option to use shared cache if t=
hat works for your particular situation.<br></div><div><br></div><div>Also,=
 I normally dedicate about 2.5 gigs of RAM per core to avoid crashes due to=
 RAM starvation. Otherwise you may experience random &quot;difficult to exp=
lain&quot; build crashes.<br></div></div><div><br></div><div>..Ch:W..<br></=
div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div d=
ir=3D"ltr"><div><b><span style=3D"font-family:monospace">&quot;Perfection m=
ust be reached by degrees; she requires the slow hand of time.&quot; - Volt=
aire</span></b></div></div></div></div>

--000000000000519f0405c7571cca--
