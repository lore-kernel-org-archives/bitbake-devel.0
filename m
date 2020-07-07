Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
 by mx.groups.io with SMTP id smtpd.web10.14726.1594123530391753849
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Jul 2020 05:05:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=u0JZWJIz;
 spf=pass (domain: gmail.com, ip: 209.85.208.65, mailfrom: martin.jansa@gmail.com)
Received: by mail-ed1-f65.google.com with SMTP id by13so28276359edb.11
        for <bitbake-devel@lists.openembedded.org>; Tue, 07 Jul 2020 05:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mYLVzOQQu7f2n7gnxFRtvSQwIWHJQ5R8ToPxOESXlDA=;
        b=u0JZWJIzYPpV/FuoxePfOL+fCKI8r7salQQaOhrEyRYQFHgL0K0xOu20yKcdjF+iz6
         8XN33eZ0DfrTaRuoWS1jiQ1BV6Y1sxj6AgwY6ujjS1jpywPau5naWSnGCXcLgs8SyswQ
         ZcFNeuJ/TDvpcwjkT6hiPgzhr2ENt30Wtl8LGUYug0pT1MpwIac6QKIIwIJF2PUhokrr
         iUYjSiTDJupxH1Qvj4FtX1yhVhvDm1s6IVTvBFoTYSAOLmzLjNVaRehP52ZUN6AduRUc
         MYXG2rKhTEoxz74NpEEwGVskSOrdTtoZfMCH7lACt/Mu9FTIpq5PFwnN3PpW2BIovjjd
         0CGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mYLVzOQQu7f2n7gnxFRtvSQwIWHJQ5R8ToPxOESXlDA=;
        b=aauO4ochjD01h6XdCnEx5eAAGghVVRCc2ZWrcRyMw28g+Y5fQoSTWpxo+P1bQDPwOG
         HWemzbLJP3IUFcN45GbpLG5ixP1CiMwtmR+8biznRphd06cU2GXpqemyHBVAxhQVdDFl
         6Dwc2uyYs4rjSqRSGTvF7D+xp5+3kkRTBljsU0Tbxo22mdOEoTAiVtit3/WKY2EpP0+c
         dttc3PuZy/0uOjkpqk0Od/NbLjz61GwCN+P+UO+dOxPU27RRnPlKvxJXZP1M6H+3nY7p
         yrkO6PyZo7DSLzLU3hdHB/MRkLmxnGrABdISZMaUPypzVNH2B/AVYtpCHnauHa2zhCdB
         DWIg==
X-Gm-Message-State: AOAM530bD7dtFDZQq2BG77CpkRkMaJoHejAhb3fj24J1H3P0Gk2hP26O
	jTpZ8NvcoyFbFUmryH7G4GRGOjsAhovrUeeFzqA=
X-Google-Smtp-Source: ABdhPJwkVA2StZrPoFAU0jzkMR4IqJQL65hPFsFeRHugqLFGau+W9OMB78ddPV5OmoJz3WoV/gZOXO/OrauSt6QUT84=
X-Received: by 2002:a50:ee01:: with SMTP id g1mr52994492eds.264.1594123528791;
 Tue, 07 Jul 2020 05:05:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200701162740.258157-1-dakhouya@gmail.com> <d679c275-a191-eed0-a5bb-54f6d5a499c0@gmail.com>
 <CAKvemSJd9sbfbbKcw=hQhFSOLO2r05UwhSffmgQztb4JcCj30Q@mail.gmail.com>
In-Reply-To: <CAKvemSJd9sbfbbKcw=hQhFSOLO2r05UwhSffmgQztb4JcCj30Q@mail.gmail.com>
From: "Martin Jansa" <Martin.Jansa@gmail.com>
Date: Tue, 7 Jul 2020 14:05:17 +0200
Message-ID: <CA+chaQebiZSLXiVh0a+dkGdfZ3+4aEiL-S5f5UeNv7YHmJAoTg@mail.gmail.com>
Subject: Re: [bitbake-devel] [bitbake][PATCH] lib/ui/taskexp: Validate gi import
To: David Khouya <dakhouya@gmail.com>
Cc: Jacob Kroon <jacob.kroon@gmail.com>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="000000000000a968ee05a9d8ce68"

--000000000000a968ee05a9d8ce68
Content-Type: text/plain; charset="UTF-8"

It's already in master:
https://git.openembedded.org/bitbake/commit/?id=2a2c507f239b047f34765312df4168030e38b90d
you should send a separate fixup patch instead of v2.

On Tue, Jul 7, 2020 at 1:57 PM David Khouya <dakhouya@gmail.com> wrote:

> Thanks Jacob for the feedback. I'll submit a patch v2 with the changes
>
>
> On Tue, Jul 7, 2020 at 5:53 AM Jacob Kroon <jacob.kroon@gmail.com> wrote:
>
>> On 7/1/20 6:27 PM, David Khouya wrote:
>> > When running bitbake -g -u taskexp without having gi python module or
>> > and invalid gtk version, bitbake fails with a stack trace.
>> >
>> > In case of import or version error, bitbake should exit with an error
>> > message instead of a stack trace.
>> >
>> > Signed-off-by: David Khouya <dakhouya@gmail.com>
>> > ---
>> >   lib/bb/ui/taskexp.py | 12 +++++++++---
>> >   1 file changed, 9 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/lib/bb/ui/taskexp.py b/lib/bb/ui/taskexp.py
>> > index 8fff2442..336d197d 100644
>> > --- a/lib/bb/ui/taskexp.py
>> > +++ b/lib/bb/ui/taskexp.py
>> > @@ -8,9 +8,15 @@
>> >   #
>> >
>> >   import sys
>> > -import gi
>> > -gi.require_version('Gtk', '3.0')
>> > -from gi.repository import Gtk, Gdk, GObject
>> > +
>> > +try:
>> > +    import gi
>> > +    gi.require_version('Gtk', '3.0')
>> > +except ValueError:
>> > +    sys.exit("FATAL: Gtk version needs to be 3.0")
>> > +except ImportError:
>> > +    sys.exit("FATAL: Gtk ui could not load the required gi python
>> module")
>> > +
>> >   import threading
>> >   from xmlrpc import client
>> >   import bb
>> >
>> >
>>
>> With this patch applied I get:
>>
>> Traceback (most recent call last):
>>    File "/home/jkroon/Projects/foo-linux/bitbake/bin/bitbake", line 35,
>> in <module>
>>      sys.exit(bitbake_main(BitBakeConfigParameters(sys.argv),
>>    File "/home/jkroon/Projects/foo-linux/bitbake/lib/bb/main.py", line
>> 366, in bitbake_main
>>      server_connection, ui_module = setup_bitbake(configParams,
>> configuration)
>>    File "/home/jkroon/Projects/foo-linux/bitbake/lib/bb/main.py", line
>> 404, in setup_bitbake
>>      ui_module = import_extension_module(bb.ui, configParams.ui, 'main')
>>    File "/home/jkroon/Projects/foo-linux/bitbake/lib/bb/main.py", line
>> 96, in import_extension_module
>>      module = __import__(pkg.__name__, fromlist=[modulename])
>>    File "/home/jkroon/Projects/foo-linux/bitbake/lib/bb/ui/taskexp.py",
>> line 33, in <module>
>>      class PackageDepView(Gtk.TreeView):
>> NameError: name 'Gtk' is not defined
>>
>> Reverting the patch allows me to run
>>
>>   bitbake -g -u taskexp core-image-minimal
>>
>> and browsing via the Gtk UI works fine.
>>
>> Jacob
>>
> 
>

--000000000000a968ee05a9d8ce68
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">It&#39;s already in master:<div><a href=3D"https://git.ope=
nembedded.org/bitbake/commit/?id=3D2a2c507f239b047f34765312df4168030e38b90d=
">https://git.openembedded.org/bitbake/commit/?id=3D2a2c507f239b047f3476531=
2df4168030e38b90d</a><br></div><div>you should=C2=A0send a separate fixup p=
atch instead of v2.</div></div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Tue, Jul 7, 2020 at 1:57 PM David Khouya &lt;<a=
 href=3D"mailto:dakhouya@gmail.com">dakhouya@gmail.com</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">Than=
ks=C2=A0Jacob for the feedback. I&#39;ll submit a patch v2 with the changes=
</div><div><div dir=3D"auto"><br></div></div><div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 7, 2020 at 5:53 AM =
Jacob Kroon &lt;<a href=3D"mailto:jacob.kroon@gmail.com" target=3D"_blank">=
jacob.kroon@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">On 7/1/20 6:27 PM, David Khouya wrote:<br>
&gt; When running bitbake -g -u taskexp without having gi python module or=
<br>
&gt; and invalid gtk version, bitbake fails with a stack trace.<br>
&gt; <br>
&gt; In case of import or version error, bitbake should exit with an error=
<br>
&gt; message instead of a stack trace.<br>
&gt; <br>
&gt; Signed-off-by: David Khouya &lt;<a href=3D"mailto:dakhouya@gmail.com"=
 target=3D"_blank">dakhouya@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0lib/bb/ui/taskexp.py | 12 +++++++++---<br>
&gt;=C2=A0 =C2=A01 file changed, 9 insertions(+), 3 deletions(-)<br>
&gt; <br>
&gt; diff --git a/lib/bb/ui/taskexp.py b/lib/bb/ui/taskexp.py<br>
&gt; index 8fff2442..336d197d 100644<br>
&gt; --- a/lib/bb/ui/taskexp.py<br>
&gt; +++ b/lib/bb/ui/taskexp.py<br>
&gt; @@ -8,9 +8,15 @@<br>
&gt;=C2=A0 =C2=A0#<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0import sys<br>
&gt; -import gi<br>
&gt; -gi.require_version(&#39;Gtk&#39;, &#39;3.0&#39;)<br>
&gt; -from gi.repository import Gtk, Gdk, GObject<br>
&gt; +<br>
&gt; +try:<br>
&gt; +=C2=A0 =C2=A0 import gi<br>
&gt; +=C2=A0 =C2=A0 gi.require_version(&#39;Gtk&#39;, &#39;3.0&#39;)<br>
&gt; +except ValueError:<br>
&gt; +=C2=A0 =C2=A0 sys.exit(&quot;FATAL: Gtk version needs to be 3.0&quot=
;)<br>
&gt; +except ImportError:<br>
&gt; +=C2=A0 =C2=A0 sys.exit(&quot;FATAL: Gtk ui could not load the requir=
ed gi python module&quot;)<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0import threading<br>
&gt;=C2=A0 =C2=A0from xmlrpc import client<br>
&gt;=C2=A0 =C2=A0import bb<br>
&gt; <br>
&gt; <br>
<br>
With this patch applied I get:<br>
<br>
Traceback (most recent call last):<br>
=C2=A0 =C2=A0File &quot;/home/jkroon/Projects/foo-linux/bitbake/bin/bitbak=
e&quot;, line 35, <br>
in &lt;module&gt;<br>
=C2=A0 =C2=A0 =C2=A0sys.exit(bitbake_main(BitBakeConfigParameters(sys.argv=
),<br>
=C2=A0 =C2=A0File &quot;/home/jkroon/Projects/foo-linux/bitbake/lib/bb/mai=
n.py&quot;, line <br>
366, in bitbake_main<br>
=C2=A0 =C2=A0 =C2=A0server_connection, ui_module =3D setup_bitbake(configP=
arams, <br>
configuration)<br>
=C2=A0 =C2=A0File &quot;/home/jkroon/Projects/foo-linux/bitbake/lib/bb/mai=
n.py&quot;, line <br>
404, in setup_bitbake<br>
=C2=A0 =C2=A0 =C2=A0ui_module =3D import_extension_module(bb.ui, configPar=
ams.ui, &#39;main&#39;)<br>
=C2=A0 =C2=A0File &quot;/home/jkroon/Projects/foo-linux/bitbake/lib/bb/mai=
n.py&quot;, line <br>
96, in import_extension_module<br>
=C2=A0 =C2=A0 =C2=A0module =3D __import__(pkg.__name__, fromlist=3D[module=
name])<br>
=C2=A0 =C2=A0File &quot;/home/jkroon/Projects/foo-linux/bitbake/lib/bb/ui/=
taskexp.py&quot;, <br>
line 33, in &lt;module&gt;<br>
=C2=A0 =C2=A0 =C2=A0class PackageDepView(Gtk.TreeView):<br>
NameError: name &#39;Gtk&#39; is not defined<br>
<br>
Reverting the patch allows me to run<br>
<br>
=C2=A0 bitbake -g -u taskexp core-image-minimal<br>
<br>
and browsing via the Gtk UI works fine.<br>
<br>
Jacob<br>
</blockquote></div></div>
<br>
</blockquote></div>

--000000000000a968ee05a9d8ce68--
