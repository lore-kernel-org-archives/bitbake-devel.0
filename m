Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
 by mx.groups.io with SMTP id smtpd.web12.282.1614970739896787087
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Mar 2021 10:59:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=FbKnxWYj;
 spf=pass (domain: gmail.com, ip: 209.85.166.175, mailfrom: tomasz.dziendzielski@gmail.com)
Received: by mail-il1-f175.google.com with SMTP id c10so2942207ilo.8
        for <bitbake-devel@lists.openembedded.org>; Fri, 05 Mar 2021 10:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=87WAs/Jv52HAIZZeKb3Pkxgh+PjoMpWALfXAQug/rM4=;
        b=FbKnxWYjk/JNxH8Fyf4cN7M4ThAT7MJ4gboYmhgJheJP0y0fYCnZ4dI0YK5EQ9ri+I
         tHc8bX4NzY8GU/LD3GZuiXPNC+anYzz9KYkLh9kioPYkIB+6JjEPjzrus26kgx+fTOyR
         6L99bwK/yYgR2poqThCcjcxS64QNiHesLISGnNerUKWKaH3dtmd/58aWyvgd0Ic7t57P
         omU0THM0BW8Shw7KHqp8sX2y+BLEvbcujTuT0m7CCO6OhBLiqVnn21Qf/8bbXsNvJK1B
         Eig2VaUtoYOksZprO3p2eGSiqpmxNZjJhOhP4eoR8LGrQ29XvjFxg896qgic+jr7cDQ/
         a/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=87WAs/Jv52HAIZZeKb3Pkxgh+PjoMpWALfXAQug/rM4=;
        b=RaTB4XhzCx9vHhDthygyPPUaqtNcTtdTB81wDarah19Y7iKj6DFhev9cYhJnCxPP0e
         g9/VL1mOkLmi+22hFMpOhYRnUwdbS1TIAe7D8I4xUHFihdt0YgRB00go4j2GxdO4wWYc
         8YHBvU9jrly6fJyAH1mvbfZlniH9U8xd5c7k4oJEiZ2doBNWIh6mQJJxT9tDSHSt2lFd
         cIbu+XYzUruqoh7/Q8jm+A/KAaBiB1GBU+mjGrTua7v5VQGmhkiiNw6pOhRToybir2Kh
         BgjZxWTM+x+kpz/J4xmqWDNPxDjJK4QiqkmC5VL5CZy6ZvlN8OcHzgOE5S1axViGcFdg
         09ew==
X-Gm-Message-State: AOAM530Cb/9oIsaS9tjlx2Sa8BUEpTYwvzr0bYIIqrF6mbO/QxRsu0PL
	q6zSKZeIiqp6ghiWrdlS1YzDCE706HD2jw427lM=
X-Google-Smtp-Source: ABdhPJyqzTPnHxhAGY+XrHxh6vhL+zJTMZGIQol6pPbstTHzbqpI9qYbhtdgU3nzd/GajClKmjj4YgfFbc+9sEvxk+s=
X-Received: by 2002:a92:b08:: with SMTP id b8mr10206457ilf.13.1614970739392;
 Fri, 05 Mar 2021 10:58:59 -0800 (PST)
MIME-Version: 1.0
References: <20210305114424.10665-1-tomasz.dziendzielski@gmail.com> <7133548d7c805c051099c599553027689c2351ce.camel@linuxfoundation.org>
In-Reply-To: <7133548d7c805c051099c599553027689c2351ce.camel@linuxfoundation.org>
From: "Tomasz Dziendzielski" <tomasz.dziendzielski@gmail.com>
Date: Fri, 5 Mar 2021 20:01:43 +0100
Message-ID: <CAJkqNs1pR+Rr9TV10V5rSDiO=dVQWKfPwYgHy-SteZuv1WjvDw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v4] runqueue: Print pseudo.log if fakeroot task failed
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org, 
	Jan Brzezanski <jan.brzezanski@gmail.com>, Paulo Neves <ptsneves@gmail.com>, 
	Mikolaj Lasota <mikolaj.lasota@protonmail.com>, Wiktor Baura <wbaura@gmail.com>, 
	Kamil Kwiek <kamil.kwiek@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000003e84ad05bccead36"

--0000000000003e84ad05bccead36
Content-Type: text/plain; charset="UTF-8"

>On Fri, 2021-03-05 at 12:44 +0100, Tomasz Dziendzielski wrote:
>> Currently if pseudo fails we can only see the path to pseudo.log. If we
>> have no access to server and can only rely on bitbake log then debugging
>> becomes impossible. This printing needs to be added in runqueue level,
>> not inside task execution, because in some cases task fails with pseudo
>> abort really early and we don't even see any log.
>>
>> In this change I'm adding pseudo log printing in every fakeroot task
>> failure that logged `mismatch`, `error` or `fatal` to logfile, because
>> we have no other way to communicate with pseudo if it failed or not.
>> Only lines from last pseudo server execution will be printed.
>
>I don't think this is going to work as it has the same issue as with
taskfn.
>
>There are only two bitbake-worker processes started and these fork off
>individual processes. The fakeroot enrvionment is adjusted in those
>workers as the tasks are started and pseudo will reread from the
>environment. The log analysis code will need to update to the current
>process' environment too...

It's not the same issue. In this case we loop over each tasks in queue:

        while found and len(self.queue):
...
            while index != -1 and self.queue.startswith(b"<exitcode>"):
                try:
                    task, status = pickle.loads(self.queue[10:index])
...
                (_, _, _, taskfn) = split_tid_mcfn(task)
                fakerootlog = None
                if self.fakerootlogs and taskfn and taskfn in
self.fakerootlogs:
                    fakerootlog = self.fakerootlogs[taskfn]
                self.rqexec.runqueue_process_waitpid(task, status,
fakerootlog=fakerootlog)

so every time we get a new task, new taskfn and then new (correct) pseudo
log path specific for each task.
To verify this I triggered more than one pseudo abort in one build and I
got correct pseudo logs printed for each failed fakeroot task. For
comparison, with the previous patch I'm getting the same (wrong) pseudo log
printed multiple times.

Best regards,
Tomasz Dziendzielski

--0000000000003e84ad05bccead36
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">&gt;On Fri, 2021-03-05 at 12:44 +0100, Tomasz Dziendzielsk=
i wrote:<br>&gt;&gt; Currently if pseudo fails we can only see the path to =
pseudo.log. If we<br>&gt;&gt; have no access to server and can only rely on=
 bitbake log then debugging<br>&gt;&gt; becomes impossible. This printing n=
eeds to be added in runqueue level,<br>&gt;&gt; not inside task execution, =
because in some cases task fails with pseudo<br>&gt;&gt; abort really early=
 and we don&#39;t even see any log.<br>&gt;&gt;<br>&gt;&gt; In this change =
I&#39;m adding pseudo log printing in every fakeroot task<br>&gt;&gt; failu=
re that logged `mismatch`, `error` or `fatal` to logfile, because<br>&gt;&g=
t; we have no other way to communicate with pseudo if it failed or not.<br>=
&gt;&gt; Only lines from last pseudo server execution will be printed.<br>&=
gt;<br>&gt;I don&#39;t think this is going to work as it has the same issue=
 as with taskfn.<br>&gt;<br>&gt;There are only two bitbake-worker processes=
 started and these fork off<br>&gt;individual processes. The fakeroot enrvi=
onment is adjusted in those<br>&gt;workers as the tasks are started and pse=
udo will reread from the<br>&gt;environment. The log analysis code will nee=
d to update to the current<br><div>&gt;process&#39; environment too...</div=
><div><br></div><div>It&#39;s not the same issue. In this case we loop over=
 each tasks in queue:</div><div><br></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
while found and len(self.queue):<br>...<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 while index !=3D -1 and self.queue.startswith(b&quot;&lt;exitcod=
e&gt;&quot;):<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tr=
y:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 task, status =3D pickle.loads(self.queue[10:index])<br>...<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (_, _, _, taskfn) =3D split_t=
id_mcfn(task)<br></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 fakerootlog =3D None<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 if self.fakerootlogs and taskfn and taskfn in self.fakero=
otlogs:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 fakerootlog =3D self.fakerootlogs[taskfn]<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.rqexec.runqueue_process_waitpid(tas=
k, status, fakerootlog=3Dfakerootlog)</div><div><br></div><div></div><div>s=
o every time we get a new task, new taskfn and then new (correct) pseudo lo=
g path specific for each task.</div><div>To verify this I triggered more th=
an one pseudo abort in one build and I got correct pseudo logs printed for =
each failed fakeroot task. For comparison, with the previous patch I&#39;m =
getting the same (wrong) pseudo log printed multiple times.<br></div><div><=
br></div><div>Best regards,</div><div>Tomasz Dziendzielski<br></div></div>

--0000000000003e84ad05bccead36--
