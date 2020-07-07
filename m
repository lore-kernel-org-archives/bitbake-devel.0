Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com [209.85.208.196])
 by mx.groups.io with SMTP id smtpd.web12.14696.1594123740800539850
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Jul 2020 05:09:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=dYYmISfY;
 spf=pass (domain: gmail.com, ip: 209.85.208.196, mailfrom: dakhouya@gmail.com)
Received: by mail-lj1-f196.google.com with SMTP id q4so13865074lji.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 07 Jul 2020 05:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A4bThXTQ3ancoyp41DUS6AtBmNo0W2bG6UsxYcWY/qU=;
        b=dYYmISfYNCri4GnMOOpQpi/9npzBddVMzErQnvqUFzuQ2xH09s1xJ+EiWlMN7mDft+
         VAayeN/3ekxXRv1Zo03XqhRZsbyzCuleK0xZP4yT0U2budzp34KKvLEVivnoA+ScFayp
         bvqYFFIbItS40D1d5WwZfIERWBUwu0Lys1W76F7Mrns7usDWyCGuSs9VdZi5kCI+WgZ/
         DH5KXSgg8H+F9oYWm4Z97E2ZamxaBQNi6nd87XpKkdLQm7Bz3j/N5YtivTUyMoZwnGDh
         mttcF/3SBPPuI47ll5M4tr9y61vu7jqHYYEEUMHcJ7ZT6my8VQ6R5YZ10gjC5NqTAq6W
         CuzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A4bThXTQ3ancoyp41DUS6AtBmNo0W2bG6UsxYcWY/qU=;
        b=S2WswoGJAvCNQEiMdI/unFFkzEqZaJu5hM58+Xz0p9G9Xr6Yn40rIo+pjytPTLBZtJ
         F7mA6w8W+2xVHFJUvkykSFpwH2KPuvqhqHAYqSD4TyIX3gV/CGN0AlqOChotMXW7e2aW
         MQxi8uJ9EMEwLotacmarxIhKJYBWND7uyuYFkzSpRTusdlRqdYZddxD2YeSDDjJXiX9I
         o7RDmcK58zQGf6dLayDu76WA+2e7rrBmJuPJ3lRN05xSot/vbrYRfotW3sp9Ga0BLUkD
         yh9zNrCNtfR/cnpJVM4TQaE074De0rfNuN0VzBeQ30K/s2LQpyyxPiPPIwGjbt1iraWM
         A0Yg==
X-Gm-Message-State: AOAM532a5HU1PWR9aIX1QlZn2GwcrvkcrWgmnwiSjOuqKKg/5bL5XFE1
	IwfOpy+pNRmWKBjArhyEF9kKSNxg4M1TyrQw0UE=
X-Google-Smtp-Source: ABdhPJxXzBdquUVJdbW1oaNDAvq2rw50HdEJLKI3vOsGNLsypaFqxOAFP+q4X7tGK+ytejmGCwx/wIwX7IWI6coQlIY=
X-Received: by 2002:a2e:9ac4:: with SMTP id p4mr28267134ljj.143.1594123738915;
 Tue, 07 Jul 2020 05:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200701162740.258157-1-dakhouya@gmail.com> <d679c275-a191-eed0-a5bb-54f6d5a499c0@gmail.com>
 <CAKvemSJd9sbfbbKcw=hQhFSOLO2r05UwhSffmgQztb4JcCj30Q@mail.gmail.com> <CA+chaQebiZSLXiVh0a+dkGdfZ3+4aEiL-S5f5UeNv7YHmJAoTg@mail.gmail.com>
In-Reply-To: <CA+chaQebiZSLXiVh0a+dkGdfZ3+4aEiL-S5f5UeNv7YHmJAoTg@mail.gmail.com>
From: "David Khouya" <dakhouya@gmail.com>
Date: Tue, 7 Jul 2020 08:08:22 -0400
Message-ID: <CAKvemSKjpHNqDVV7wvhwOGQK48tzFkFFvgGmrgTin10taChnZQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [bitbake][PATCH] lib/ui/taskexp: Validate gi import
To: Martin Jansa <martin.jansa@gmail.com>
Cc: Jacob Kroon <jacob.kroon@gmail.com>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="0000000000002fa6bb05a9d8db12"

--0000000000002fa6bb05a9d8db12
Content-Type: text/plain; charset="UTF-8"

Perfect, will do.

On Tue, Jul 7, 2020 at 8:05 AM Martin Jansa <martin.jansa@gmail.com> wrote:

> It's already in master:
>
> https://git.openembedded.org/bitbake/commit/?id=2a2c507f239b047f34765312df4168030e38b90d
> you should send a separate fixup patch instead of v2.
>
> On Tue, Jul 7, 2020 at 1:57 PM David Khouya <dakhouya@gmail.com> wrote:
>
>> Thanks Jacob for the feedback. I'll submit a patch v2 with the changes
>>
>>
>> On Tue, Jul 7, 2020 at 5:53 AM Jacob Kroon <jacob.kroon@gmail.com> wrote:
>>
>>> On 7/1/20 6:27 PM, David Khouya wrote:
>>> > When running bitbake -g -u taskexp without having gi python module or
>>> > and invalid gtk version, bitbake fails with a stack trace.
>>> >
>>> > In case of import or version error, bitbake should exit with an error
>>> > message instead of a stack trace.
>>> >
>>> > Signed-off-by: David Khouya <dakhouya@gmail.com>
>>> > ---
>>> >   lib/bb/ui/taskexp.py | 12 +++++++++---
>>> >   1 file changed, 9 insertions(+), 3 deletions(-)
>>> >
>>> > diff --git a/lib/bb/ui/taskexp.py b/lib/bb/ui/taskexp.py
>>> > index 8fff2442..336d197d 100644
>>> > --- a/lib/bb/ui/taskexp.py
>>> > +++ b/lib/bb/ui/taskexp.py
>>> > @@ -8,9 +8,15 @@
>>> >   #
>>> >
>>> >   import sys
>>> > -import gi
>>> > -gi.require_version('Gtk', '3.0')
>>> > -from gi.repository import Gtk, Gdk, GObject
>>> > +
>>> > +try:
>>> > +    import gi
>>> > +    gi.require_version('Gtk', '3.0')
>>> > +except ValueError:
>>> > +    sys.exit("FATAL: Gtk version needs to be 3.0")
>>> > +except ImportError:
>>> > +    sys.exit("FATAL: Gtk ui could not load the required gi python
>>> module")
>>> > +
>>> >   import threading
>>> >   from xmlrpc import client
>>> >   import bb
>>> >
>>> >
>>>
>>> With this patch applied I get:
>>>
>>> Traceback (most recent call last):
>>>    File "/home/jkroon/Projects/foo-linux/bitbake/bin/bitbake", line 35,
>>> in <module>
>>>      sys.exit(bitbake_main(BitBakeConfigParameters(sys.argv),
>>>    File "/home/jkroon/Projects/foo-linux/bitbake/lib/bb/main.py", line
>>> 366, in bitbake_main
>>>      server_connection, ui_module = setup_bitbake(configParams,
>>> configuration)
>>>    File "/home/jkroon/Projects/foo-linux/bitbake/lib/bb/main.py", line
>>> 404, in setup_bitbake
>>>      ui_module = import_extension_module(bb.ui, configParams.ui, 'main')
>>>    File "/home/jkroon/Projects/foo-linux/bitbake/lib/bb/main.py", line
>>> 96, in import_extension_module
>>>      module = __import__(pkg.__name__, fromlist=[modulename])
>>>    File "/home/jkroon/Projects/foo-linux/bitbake/lib/bb/ui/taskexp.py",
>>> line 33, in <module>
>>>      class PackageDepView(Gtk.TreeView):
>>> NameError: name 'Gtk' is not defined
>>>
>>> Reverting the patch allows me to run
>>>
>>>   bitbake -g -u taskexp core-image-minimal
>>>
>>> and browsing via the Gtk UI works fine.
>>>
>>> Jacob
>>>
>> 
>>
>

-- 
*David Khouya*

--0000000000002fa6bb05a9d8db12
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Perfect, will do.</div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 7, 2020 at 8:05 AM Martin Jan=
sa &lt;<a href=3D"mailto:martin.jansa@gmail.com">martin.jansa@gmail.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div=
 dir=3D"ltr">It&#39;s already in master:<div><a href=3D"https://git.openemb=
edded.org/bitbake/commit/?id=3D2a2c507f239b047f34765312df4168030e38b90d" ta=
rget=3D"_blank">https://git.openembedded.org/bitbake/commit/?id=3D2a2c507f2=
39b047f34765312df4168030e38b90d</a><br></div><div>you should=C2=A0send a se=
parate fixup patch instead of v2.</div></div><br><div class=3D"gmail_quote"=
><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 7, 2020 at 1:57 PM David=
 Khouya &lt;<a href=3D"mailto:dakhouya@gmail.com" target=3D"_blank">dakhouy=
a@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex"><div dir=3D"ltr">Thanks=C2=A0Jacob for the feedback. I&#39;ll s=
ubmit a patch v2 with the changes</div><div><div dir=3D"auto"><br></div></d=
iv><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr=
">On Tue, Jul 7, 2020 at 5:53 AM Jacob Kroon &lt;<a href=3D"mailto:jacob.kr=
oon@gmail.com" target=3D"_blank">jacob.kroon@gmail.com</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">On 7/1/20 6:27 PM, Da=
vid Khouya wrote:<br>
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
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr=
" class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div dir=
=
=3D"ltr"><div><span style=3D"font-size:13px;color:rgb(0,0,0)"><strong>Davi=
d Khouya</strong></span><em style=3D"color:rgb(136,136,136);font-size:13px"=
>=C2=A0</em></div><br><br></div></div></div></div></div>

--0000000000002fa6bb05a9d8db12--
