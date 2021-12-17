Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C084C433EF
	for <webhook@archiver.kernel.org>; Fri, 17 Dec 2021 18:41:51 +0000 (UTC)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com
 [209.85.222.54])
 by mx.groups.io with SMTP id smtpd.web08.385.1639766510972975885
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Dec 2021 10:41:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=qLgDy86A;
 spf=pass (domain: gmail.com, ip: 209.85.222.54,
 mailfrom: alex.kanavin@gmail.com)
Received: by mail-ua1-f54.google.com with SMTP id i6so6061160uae.6
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Dec 2021 10:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4u+EB3nNkR8ZXNr4AcJZcWwjk2E9wq8BqAjvMU1w9xA=;
        b=qLgDy86AR9FX9yIYZNl3qAYOARgH16a1WBdpGl0uFq2GikmokESgEQoDZqil3y+krO
         yE73Ow5yFrb0Yc3lZcQPTwfQBlvCPNN5+CLIasuG56cadcRmeTjYL9cpaQ3aZ1gQuxr1
         KukSHvIze1RL/fZjcsxXL7WBE/Gp/JR8tbj43vlVJ6PFbzanwNwRztSKPNj+5vifJ9n9
         6gXzBqIEPdo9GeUt7kTlnPrt2U1rSD55PQqMMONEPW5u4T+bp9WEShYWiR/Lweyl9FJ5
         A2d3S1RPC1W9RkL1MbUIBh5Aq4pPFYlnSRDOJyBEtnDgL9dALQUe1gIhXw6XoFCjK05x
         FNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4u+EB3nNkR8ZXNr4AcJZcWwjk2E9wq8BqAjvMU1w9xA=;
        b=ssi0ii10hulDtif+Nmk+eVAwu60uM+Ucxxft0lN1wsn5qCtlKU2wAmtV7UBqx0EhsG
         1VTDgtqbKu4XQvQ+noLWxEkj7wlEML56jrvFenSQcImjnNAosi5NR/f7e7Ur2aforOpb
         RZasBPDV3A/lFdzShIMyiNghN4k9hp1xE+2aAAQGNnTuAjuBy0iZCJ38b8ofTE4uwCmn
         DvmGfwL9G9X8yNzAxqx9NMZBlQjzrrJh85cJUUYtZ9gifF+8h0ulE/L63dH9nKEAEeEM
         wwI+gvPCydQGpzG9ueCcilRdCV2uOytEwhxXO78/1QJJ8rwttkcvmqzImwq7Mk0krxgp
         fx3g==
X-Gm-Message-State: AOAM531EKXs7nrAbymHv/PuRMYkwKoPWEkGPJTOkfb6t614Y/zxx/rcs
	AbtjtB5KP2uXYNM6Z1XmoXJ8FbCna6x0GNRTob4=
X-Google-Smtp-Source: 
 ABdhPJzikFi7PTnbYm7215vx5X11etSwh82qb3IfEISn2zB2WXM/JbATp5Krya8jX9xqZgoFy+SaSAqMgC+3dZBZovI=
X-Received: by 2002:ab0:6f14:: with SMTP id r20mr1939354uah.22.1639766509980;
 Fri, 17 Dec 2021 10:41:49 -0800 (PST)
MIME-Version: 1.0
References: <16BED60D9AF8ECE2.12270@lists.openembedded.org>
 <dc689a39-6fa3-a839-32a0-653e09b8d448@ilbers.de>
 <CANNYZj9-NcL+gjdnvZAAUWWyL3V4nkwOXefaZ=fCryo4bqoHjQ@mail.gmail.com>
 <ef707ea2-c766-2b25-0e09-cb5fc38812c9@ilbers.de>
In-Reply-To: <ef707ea2-c766-2b25-0e09-cb5fc38812c9@ilbers.de>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 17 Dec 2021 21:41:38 +0300
Message-ID: 
 <CANNYZj_DT0Y+B0CABEFzpQY0u07zAs8TzjsK7YEeMFW3dPFjiA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] process: Do not mix stderr with stdout
To: Anton Mikanovich <amikan@ilbers.de>
Cc: Baurzhan Ismagulov <ibr@ilbers.de>, bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000005790f905d35be4f0"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Dec 2021 18:41:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13194

--0000000000005790f905d35be4f0
Content-Type: text/plain; charset="UTF-8"

Thanks, looks like the issue is real, so the patch should go in unless
there are other concerns.

Alex

On Fri 17. Dec 2021 at 20.49, Anton Mikanovich <amikan@ilbers.de> wrote:

> 17.12.2021 19:54, Alexander Kanavin wrote:
>
> It helps if you describe the problem that occurs without the patch and how
> it can be observed.
>
> Ale
>
> On Fri 17. Dec 2021 at 19.43, Anton Mikanovich <amikan@ilbers.de> wrote:
>
>> 08.12.2021 19:57, Anton Mikanovich wrote:
>> > We should not redirect stderr to stdout if we need to get separated
>> > stdout and stderr contents from Popen.communicate() later.
>> >
>> > Signed-off-by: Anton Mikanovich <amikan@ilbers.de>
>> > ---
>> >   lib/bb/process.py | 2 +-
>> >   1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/lib/bb/process.py b/lib/bb/process.py
>> > index d5a1775f..af5d804a 100644
>> > --- a/lib/bb/process.py
>> > +++ b/lib/bb/process.py
>> > @@ -60,7 +60,7 @@ class Popen(subprocess.Popen):
>> >           "close_fds": True,
>> >           "preexec_fn": subprocess_setup,
>> >           "stdout": subprocess.PIPE,
>> > -        "stderr": subprocess.STDOUT,
>> > +        "stderr": subprocess.PIPE,
>> >           "stdin": subprocess.PIPE,
>> >           "shell": False,
>> >       }
>>
>> Can anyone review this change to proof the fix is correct?
>>
>> --
>> Anton Mikanovich
>> Promwad Ltd.
>> External service provider of ilbers GmbH
>> Maria-Merian-Str. 8
>> 85521 Ottobrunn, Germany
>> +49 (89) 122 67 24-0
>> Commercial register Munich, HRB 214197
>> General Manager: Baurzhan Ismagulov
>>
>>
>> -=-=-=-=-=-=-=-=-=-=-=-
>> Links: You receive all messages sent to this group.
>> View/Reply Online (#13190):
>> https://lists.openembedded.org/g/bitbake-devel/message/13190
>> Mute This Topic: https://lists.openembedded.org/mt/87592650/1686489
>> Group Owner: bitbake-devel+owner@lists.openembedded.org
>> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
>> alex.kanavin@gmail.com]
>> -=-=-=-=-=-=-=-=-=-=-=-
>>
>> Hello, Alexander
>
> As I've already mentioned in description the problem is mixing both stderr
> and stdout of the command to stdout output variable when using
> bb.process.run()
> Here are minimal steps to reproduce:
>
> $ cat /usr/bin/test.sh
> #!/bin/sh
> echo "This is stderr" >&2
> echo "This is stdout"
>
> Task:
>
> python do_test() {
>     out,err = bb.process.run('test.sh')
>     bb.warn('STDOUT:', out or 'EMPTY')
>     bb.warn('STDERR:', err or 'EMPTY')
> }
> addtask do_test
>
> Result without the patch:
>
> WARNING: do_test: STDOUT:This is stderr
> This is stdout
> WARNING: do_test: STDERR:EMPTY
>
> So both stdout and stderr of test.sh were filled to out variable.
>
> Result after the patch:
>
> WARNING: do_test: STDOUT:This is stdout
> WARNING: do_test: STDERR:This is stderr
>
> --
> Anton Mikanovich
> Promwad Ltd.
> External service provider of ilbers GmbH
> Maria-Merian-Str. 8
> 85521 Ottobrunn, Germany
> +49 (89) 122 67 24-0
> Commercial register Munich, HRB 214197
> General Manager: Baurzhan Ismagulov
>
>

--0000000000005790f905d35be4f0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Thanks, looks like the issue is real, so the patch should=
 go in unless there are other concerns.</div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">Alex</div><div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Fri 17. Dec 2021 at 20.49, Anton Mikanovich &lt=
;<a href=3D"mailto:amikan@ilbers.de">amikan@ilbers.de</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left-width:1px;border-left-style:solid;padding-left:1ex;border-left-colo=
r:rgb(204,204,204)">
 =20
   =20
 =20
  <div></div><div>
    17.12.2021 19:54, Alexander Kanavin wrote:<br>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"auto">It helps if you describe the problem that occurs
        without the patch and how it can be observed.</div>
      <div dir=3D"auto"><br>
      </div>
      <div dir=3D"auto">Ale=C2=A0</div>
      <div><br>
        <div class=3D"gmail_quote">
          <div dir=3D"ltr" class=3D"gmail_attr">On Fri 17. Dec 2021 at
            19.43, Anton Mikanovich &lt;<a href=3D"mailto:amikan@ilbers.de"=
 target=3D"_blank">amikan@ilbers.de</a>&gt;
            wrote:<br>
          </div>
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left-width:1px;border-left-style:solid;padding-left:1ex;border-le=
ft-color:rgb(204,204,204)">08.12.2021
            19:57, Anton Mikanovich wrote:<br>
            &gt; We should not redirect stderr to stdout if we need to
            get separated<br>
            &gt; stdout and stderr contents from Popen.communicate()
            later.<br>
            &gt;<br>
            &gt; Signed-off-by: Anton Mikanovich &lt;<a href=3D"mailto:amik=
an@ilbers.de" target=3D"_blank">amikan@ilbers.de</a>&gt;<br>
            &gt; ---<br>
            &gt;=C2=A0 =C2=A0lib/bb/process.py | 2 +-<br>
            &gt;=C2=A0 =C2=A01 file changed, 1 insertion(+), 1 deletion(-)<=
br>
            &gt;<br>
            &gt; diff --git a/lib/bb/process.py b/lib/bb/process.py<br>
            &gt; index d5a1775f..af5d804a 100644<br>
            &gt; --- a/lib/bb/process.py<br>
            &gt; +++ b/lib/bb/process.py<br>
            &gt; @@ -60,7 +60,7 @@ class Popen(subprocess.Popen):<br>
            &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;close_fds&qu=
ot;: True,<br>
            &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;preexec_fn&q=
uot;: subprocess_setup,<br>
            &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;stdout&quot;=
: subprocess.PIPE,<br>
            &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;stderr&quot;: subproces=
s.STDOUT,<br>
            &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;stderr&quot;: subproces=
s.PIPE,<br>
            &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;stdin&quot;:=
 subprocess.PIPE,<br>
            &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;shell&quot;:=
 False,<br>
            &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
            <br>
            Can anyone review this change to proof the fix is correct?<br>
            <br>
            -- <br>
            Anton Mikanovich<br>
            Promwad Ltd.<br>
            External service provider of ilbers GmbH<br>
            Maria-Merian-Str. 8<br>
            85521 Ottobrunn, Germany<br>
            +49 (89) 122 67 24-0<br>
            Commercial register Munich, HRB 214197<br>
            General Manager: Baurzhan Ismagulov<br>
            <br>
            <br>
            -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
            Links: You receive all messages sent to this group.<br>
            View/Reply Online (#13190): <a href=3D"https://lists.openembedd=
ed.org/g/bitbake-devel/message/13190" rel=3D"noreferrer" target=3D"_blank">=
https://lists.openembedded.org/g/bitbake-devel/message/13190</a><br>
            Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/8=
7592650/1686489" rel=3D"noreferrer" target=3D"_blank">https://lists.openemb=
edded.org/mt/87592650/1686489</a><br>
            Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.open=
embedded.org" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org<=
/a><br>
            Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbak=
e-devel/unsub" rel=3D"noreferrer" target=3D"_blank">https://lists.openembed=
ded.org/g/bitbake-devel/unsub</a>
            [<a href=3D"mailto:alex.kanavin@gmail.com" target=3D"_blank">al=
ex.kanavin@gmail.com</a>]<br>
            -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
            <br>
          </blockquote>
        </div>
      </div>
    </blockquote>
    </div><div><p>Hello, Alexander<br>
      <br>
      As I&#39;ve already mentioned in description the problem is mixing
      both stderr and stdout of the command to stdout output variable
      when using bb.process.run()<br>
      Here are minimal steps to reproduce:<br>
      <br>
      $ cat /usr/bin/test.sh<br>
      #!/bin/sh<br>
      echo &quot;This is stderr&quot; &gt;&amp;2<br>
      echo &quot;This is stdout&quot;<br>
      <br>
      Task:<br>
      <br>
      python do_test() {<br>
      =C2=A0=C2=A0=C2=A0 out,err =3D bb.process.run(&#39;test.sh&#39;)<br>
      =C2=A0=C2=A0=C2=A0 bb.warn(&#39;STDOUT:&#39;, out or &#39;EMPTY&#39;)=
<br>
      =C2=A0=C2=A0=C2=A0 bb.warn(&#39;STDERR:&#39;, err or &#39;EMPTY&#39;)=
<br>
      }<br>
      addtask do_test<br>
      <br>
      Result without the patch:<br>
      <br>
      WARNING: do_test: STDOUT:This is stderr<br>
      This is stdout<br>
      WARNING: do_test: STDERR:EMPTY<br>
      <br>
      So both stdout and stderr of test.sh were filled to out variable.<br>
      <br>
      Result after the patch:<br>
      <br>
      WARNING: do_test: STDOUT:This is stdout<br>
      WARNING: do_test: STDERR:This is stderr<br>
    </p></div><div>
    <pre cols=3D"72" style=3D"font-family:monospace">--=20
Anton Mikanovich
Promwad Ltd.
External service provider of ilbers GmbH
Maria-Merian-Str. 8
85521 Ottobrunn, Germany
+49 (89) 122 67 24-0
Commercial register Munich, HRB 214197
General Manager: Baurzhan Ismagulov</pre>
  </div>

</blockquote></div></div>

--0000000000005790f905d35be4f0--

