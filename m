Return-Path: <amikan@ilbers.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3E7C433EF
	for <webhook@archiver.kernel.org>; Fri, 17 Dec 2021 17:49:50 +0000 (UTC)
Received: from shymkent.ilbers.de (shymkent.ilbers.de [85.214.156.166])
 by mx.groups.io with SMTP id smtpd.web08.9305.1639763388791009546
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Dec 2021 09:49:49 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: ilbers.de, ip: 85.214.156.166, mailfrom: amikan@ilbers.de)
Received: from [192.168.67.164] (mm-214-81-214-37.mgts.dynamic.pppoe.byfly.by
 [37.214.81.214] (may be forged))
	(authenticated bits=0)
	by shymkent.ilbers.de (8.15.2/8.15.2/Debian-8) with ESMTPSA id 1BHHnfgS019499
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Dec 2021 18:49:44 +0100
Subject: Re: [bitbake-devel] [PATCH] process: Do not mix stderr with stdout
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: Baurzhan Ismagulov <ibr@ilbers.de>, bitbake-devel@lists.openembedded.org
References: <16BED60D9AF8ECE2.12270@lists.openembedded.org>
 <dc689a39-6fa3-a839-32a0-653e09b8d448@ilbers.de>
 <CANNYZj9-NcL+gjdnvZAAUWWyL3V4nkwOXefaZ=fCryo4bqoHjQ@mail.gmail.com>
From: Anton Mikanovich <amikan@ilbers.de>
Message-ID: <ef707ea2-c766-2b25-0e09-cb5fc38812c9@ilbers.de>
Date: Fri, 17 Dec 2021 20:49:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: 
 <CANNYZj9-NcL+gjdnvZAAUWWyL3V4nkwOXefaZ=fCryo4bqoHjQ@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------D43DB6D8E87A20F4126FE58E"
Content-Language: en-US
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Dec 2021 17:49:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13193

This is a multi-part message in MIME format.
--------------D43DB6D8E87A20F4126FE58E
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by shymkent.ilbers.de id
 1BHHnfgS019499

17.12.2021 19:54, Alexander Kanavin wrote:
> It helps if you describe the problem that occurs without the patch and=20
> how it can be observed.
>
> Ale
>
> On Fri 17. Dec 2021 at 19.43, Anton Mikanovich <amikan@ilbers.de=20
> <mailto:amikan@ilbers.de>> wrote:
>
>     08.12.2021 19:57, Anton Mikanovich wrote:
>     > We should not redirect stderr to stdout if we need to get separat=
ed
>     > stdout and stderr contents from Popen.communicate() later.
>     >
>     > Signed-off-by: Anton Mikanovich <amikan@ilbers.de
>     <mailto:amikan@ilbers.de>>
>     > ---
>     >=C2=A0 =C2=A0lib/bb/process.py | 2 +-
>     >=C2=A0 =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>     >
>     > diff --git a/lib/bb/process.py b/lib/bb/process.py
>     > index d5a1775f..af5d804a 100644
>     > --- a/lib/bb/process.py
>     > +++ b/lib/bb/process.py
>     > @@ -60,7 +60,7 @@ class Popen(subprocess.Popen):
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"close_fds": True,
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"preexec_fn": subprocess_=
setup,
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"stdout": subprocess.PIPE=
,
>     > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 "stderr": subprocess.STDOUT,
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 "stderr": subprocess.PIPE,
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"stdin": subprocess.PIPE,
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"shell": False,
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
>     Can anyone review this change to proof the fix is correct?
>
>     --=20
>     Anton Mikanovich
>     Promwad Ltd.
>     External service provider of ilbers GmbH
>     Maria-Merian-Str. 8
>     85521 Ottobrunn, Germany
>     +49 (89) 122 67 24-0
>     Commercial register Munich, HRB 214197
>     General Manager: Baurzhan Ismagulov
>
>
>     -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>     Links: You receive all messages sent to this group.
>     View/Reply Online (#13190):
>     https://lists.openembedded.org/g/bitbake-devel/message/13190
>     <https://lists.openembedded.org/g/bitbake-devel/message/13190>
>     Mute This Topic:
>     https://lists.openembedded.org/mt/87592650/1686489
>     <https://lists.openembedded.org/mt/87592650/1686489>
>     Group Owner: bitbake-devel+owner@lists.openembedded.org
>     <mailto:bitbake-devel%2Bowner@lists.openembedded.org>
>     Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub
>     <https://lists.openembedded.org/g/bitbake-devel/unsub>
>     [alex.kanavin@gmail.com <mailto:alex.kanavin@gmail.com>]
>     -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
Hello, Alexander

As I've already mentioned in description the problem is mixing both=20
stderr and stdout of the command to stdout output variable when using=20
bb.process.run()
Here are minimal steps to reproduce:

$ cat /usr/bin/test.sh
#!/bin/sh
echo "This is stderr" >&2
echo "This is stdout"

Task:

python do_test() {
 =C2=A0=C2=A0=C2=A0 out,err =3D bb.process.run('test.sh')
 =C2=A0=C2=A0=C2=A0 bb.warn('STDOUT:', out or 'EMPTY')
 =C2=A0=C2=A0=C2=A0 bb.warn('STDERR:', err or 'EMPTY')
}
addtask do_test

Result without the patch:

WARNING: do_test: STDOUT:This is stderr
This is stdout
WARNING: do_test: STDERR:EMPTY

So both stdout and stderr of test.sh were filled to out variable.

Result after the patch:

WARNING: do_test: STDOUT:This is stdout
WARNING: do_test: STDERR:This is stderr

--=20
Anton Mikanovich
Promwad Ltd.
External service provider of ilbers GmbH
Maria-Merian-Str. 8
85521 Ottobrunn, Germany
+49 (89) 122 67 24-0
Commercial register Munich, HRB 214197
General Manager: Baurzhan Ismagulov


--------------D43DB6D8E87A20F4126FE58E
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by shymkent.ilbers.de id
 1BHHnfgS019499

<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF=
-8">
  </head>
  <body>
    17.12.2021 19:54, Alexander Kanavin wrote:<br>
    <blockquote type=3D"cite"
cite=3D"mid:CANNYZj9-NcL+gjdnvZAAUWWyL3V4nkwOXefaZ=3DfCryo4bqoHjQ@mail.gm=
ail.com">
      <meta http-equiv=3D"content-type" content=3D"text/html; charset=3DU=
TF-8">
      <div dir=3D"auto">It helps if you describe the problem that occurs
        without the patch and how it can be observed.</div>
      <div dir=3D"auto"><br>
      </div>
      <div dir=3D"auto">Ale=C2=A0</div>
      <div><br>
        <div class=3D"gmail_quote">
          <div dir=3D"ltr" class=3D"gmail_attr">On Fri 17. Dec 2021 at
            19.43, Anton Mikanovich &lt;<a
              href=3D"mailto:amikan@ilbers.de" moz-do-not-send=3D"true">a=
mikan@ilbers.de</a>&gt;
            wrote:<br>
          </div>
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px
0.8ex;border-left-width:1px;border-left-style:solid;padding-left:1ex;bord=
er-left-color:rgb(204,204,204)">08.12.2021
            19:57, Anton Mikanovich wrote:<br>
            &gt; We should not redirect stderr to stdout if we need to
            get separated<br>
            &gt; stdout and stderr contents from Popen.communicate()
            later.<br>
            &gt;<br>
            &gt; Signed-off-by: Anton Mikanovich &lt;<a
              href=3D"mailto:amikan@ilbers.de" target=3D"_blank"
              moz-do-not-send=3D"true">amikan@ilbers.de</a>&gt;<br>
            &gt; ---<br>
            &gt;=C2=A0 =C2=A0lib/bb/process.py | 2 +-<br>
            &gt;=C2=A0 =C2=A01 file changed, 1 insertion(+), 1 deletion(-=
)<br>
            &gt;<br>
            &gt; diff --git a/lib/bb/process.py b/lib/bb/process.py<br>
            &gt; index d5a1775f..af5d804a 100644<br>
            &gt; --- a/lib/bb/process.py<br>
            &gt; +++ b/lib/bb/process.py<br>
            &gt; @@ -60,7 +60,7 @@ class Popen(subprocess.Popen):<br>
            &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"close_fds": Tru=
e,<br>
            &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"preexec_fn": su=
bprocess_setup,<br>
            &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"stdout": subpro=
cess.PIPE,<br>
            &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 "stderr": subprocess.STDOUT=
,<br>
            &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 "stderr": subprocess.PIPE,<=
br>
            &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"stdin": subproc=
ess.PIPE,<br>
            &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"shell": False,<=
br>
            &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
            <br>
            Can anyone review this change to proof the fix is correct?<br=
>
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
            View/Reply Online (#13190): <a
              href=3D"https://lists.openembedded.org/g/bitbake-devel/mess=
age/13190"
              rel=3D"noreferrer" target=3D"_blank" moz-do-not-send=3D"tru=
e">https://lists.openembedded.org/g/bitbake-devel/message/13190</a><br>
            Mute This Topic: <a
              href=3D"https://lists.openembedded.org/mt/87592650/1686489"
              rel=3D"noreferrer" target=3D"_blank" moz-do-not-send=3D"tru=
e">https://lists.openembedded.org/mt/87592650/1686489</a><br>
            Group Owner: <a
              href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
"
              target=3D"_blank" moz-do-not-send=3D"true">bitbake-devel+ow=
ner@lists.openembedded.org</a><br>
            Unsubscribe: <a
              href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b"
              rel=3D"noreferrer" target=3D"_blank" moz-do-not-send=3D"tru=
e">https://lists.openembedded.org/g/bitbake-devel/unsub</a>
            [<a href=3D"mailto:alex.kanavin@gmail.com" target=3D"_blank"
              moz-do-not-send=3D"true">alex.kanavin@gmail.com</a>]<br>
            -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
            <br>
          </blockquote>
        </div>
      </div>
    </blockquote>
    <p>Hello, Alexander<br>
      <br>
      As I've already mentioned in description the problem is mixing
      both stderr and stdout of the command to stdout output variable
      when using bb.process.run()<br>
      Here are minimal steps to reproduce:<br>
      <br>
      $ cat /usr/bin/test.sh<br>
      #!/bin/sh<br>
      echo "This is stderr" &gt;&amp;2<br>
      echo "This is stdout"<br>
      <br>
      Task:<br>
      <br>
      python do_test() {<br>
      =C2=A0=C2=A0=C2=A0 out,err =3D bb.process.run('test.sh')<br>
      =C2=A0=C2=A0=C2=A0 bb.warn('STDOUT:', out or 'EMPTY')<br>
      =C2=A0=C2=A0=C2=A0 bb.warn('STDERR:', err or 'EMPTY')<br>
      }<br>
      addtask do_test<br>
      <br>
      Result without the patch:<br>
      <br>
      WARNING: do_test: STDOUT:This is stderr<br>
      This is stdout<br>
      WARNING: do_test: STDERR:EMPTY<br>
      <br>
      So both stdout and stderr of test.sh were filled to out variable.<b=
r>
      <br>
      Result after the patch:<br>
      <br>
      WARNING: do_test: STDOUT:This is stdout<br>
      WARNING: do_test: STDERR:This is stderr<br>
    </p>
    <pre class=3D"moz-signature" cols=3D"72">--=20
Anton Mikanovich
Promwad Ltd.
External service provider of ilbers GmbH
Maria-Merian-Str. 8
85521 Ottobrunn, Germany
+49 (89) 122 67 24-0
Commercial register Munich, HRB 214197
General Manager: Baurzhan Ismagulov</pre>
  </body>
</html>

--------------D43DB6D8E87A20F4126FE58E--

