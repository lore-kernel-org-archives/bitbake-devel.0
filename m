Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
 by mx.groups.io with SMTP id smtpd.web12.14540.1594123047230292522
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Jul 2020 04:57:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=lxqUTGaj;
 spf=pass (domain: gmail.com, ip: 209.85.167.67, mailfrom: dakhouya@gmail.com)
Received: by mail-lf1-f67.google.com with SMTP id s16so19072298lfp.12
        for <bitbake-devel@lists.openembedded.org>; Tue, 07 Jul 2020 04:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ndySY2o6r//u137h2HvEXhUlpBR5n3WaKVshZ0CdXfM=;
        b=lxqUTGaje4mhp56W4aa6suV41d0fVtBHtIF3xGxt0qs1b/lSGlNRZdF+4VqfA0cU/b
         ihmNfNim4SBNvFryJiM5uJ72PXO2KkbuE94q7gxh894WYMBBrBM287mCJn3ipDWxdkrw
         6H8Pnd5D0hmNLFm/SYiGz5fGRo9dc6AnWRo59nZkKN+Qhl1pSvS52E+dbAVRgrXBLz94
         2MmOcDefwTUlqsS2v0msKz6goWzN1sqoCO9lamkbnBVV869vA3BHwxMKy3a0T57W/Ntt
         EVJGlwiqQ7p8qaI+R+xJDPC5diyq1WQBJaRaeM3Iahk8FCaBxzYi1hElRoT3XutkDd+w
         JRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ndySY2o6r//u137h2HvEXhUlpBR5n3WaKVshZ0CdXfM=;
        b=ZvRLz7A1OyN/GOTK1KFpbYJGV6UcHOrpOPgHhuqfKd1E3GyjMrANuqqmcD9O6JiVqn
         8HelR3EUPYdza6xkN9SEVwgQ4W+C99l2vHiJkX522572UJ+vWAYtgiT34o5eBnKhhtpB
         zkZd+lG7M/YIxafWmnjxUdzl0smycZkIDbaQZJkcV7RktEsFxA2VY5n2vhcCANdQmcnG
         oJyClsmGVl3Z1YDoduCFZc31+XkvFOLNU6p/bqFt/wywWNyglOHFXAj/9Hs+wjABIs+B
         MAcTjU/eUvplACuGlvBPG1lIyUYKPOzOFmeepozPEtbzLnXNUx2UQt4XYrVWDYFrE1vZ
         gmPA==
X-Gm-Message-State: AOAM5313wDwrvGS2UfbKiuPtspL1hPvtNyqhLG9S96zdV26HWA1SjycA
	fEYvYNd3AM6KCEHOFvq05H2eax9o0v6CDBYrbw0=
X-Google-Smtp-Source: ABdhPJwxux6XXSu86iKCxWsGHaKyfISjiiNwmzlsScJ9mACQdU25qlKCAvf+aKGewd8jtIMYJYsg3RvBtqdgpn6D1to=
X-Received: by 2002:a05:6512:20f:: with SMTP id a15mr32665056lfo.118.1594123045378;
 Tue, 07 Jul 2020 04:57:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200701162740.258157-1-dakhouya@gmail.com> <d679c275-a191-eed0-a5bb-54f6d5a499c0@gmail.com>
In-Reply-To: <d679c275-a191-eed0-a5bb-54f6d5a499c0@gmail.com>
From: "David Khouya" <dakhouya@gmail.com>
Date: Tue, 7 Jul 2020 07:56:48 -0400
Message-ID: <CAKvemSJd9sbfbbKcw=hQhFSOLO2r05UwhSffmgQztb4JcCj30Q@mail.gmail.com>
Subject: Re: [bitbake-devel] [bitbake][PATCH] lib/ui/taskexp: Validate gi import
To: Jacob Kroon <jacob.kroon@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000d91c6805a9d8b1e3"

--000000000000d91c6805a9d8b1e3
Content-Type: text/plain; charset="UTF-8"

Thanks Jacob for the feedback. I'll submit a patch v2 with the changes


On Tue, Jul 7, 2020 at 5:53 AM Jacob Kroon <jacob.kroon@gmail.com> wrote:

> On 7/1/20 6:27 PM, David Khouya wrote:
> > When running bitbake -g -u taskexp without having gi python module or
> > and invalid gtk version, bitbake fails with a stack trace.
> >
> > In case of import or version error, bitbake should exit with an error
> > message instead of a stack trace.
> >
> > Signed-off-by: David Khouya <dakhouya@gmail.com>
> > ---
> >   lib/bb/ui/taskexp.py | 12 +++++++++---
> >   1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/lib/bb/ui/taskexp.py b/lib/bb/ui/taskexp.py
> > index 8fff2442..336d197d 100644
> > --- a/lib/bb/ui/taskexp.py
> > +++ b/lib/bb/ui/taskexp.py
> > @@ -8,9 +8,15 @@
> >   #
> >
> >   import sys
> > -import gi
> > -gi.require_version('Gtk', '3.0')
> > -from gi.repository import Gtk, Gdk, GObject
> > +
> > +try:
> > +    import gi
> > +    gi.require_version('Gtk', '3.0')
> > +except ValueError:
> > +    sys.exit("FATAL: Gtk version needs to be 3.0")
> > +except ImportError:
> > +    sys.exit("FATAL: Gtk ui could not load the required gi python
> module")
> > +
> >   import threading
> >   from xmlrpc import client
> >   import bb
> >
> >
>
> With this patch applied I get:
>
> Traceback (most recent call last):
>    File "/home/jkroon/Projects/foo-linux/bitbake/bin/bitbake", line 35,
> in <module>
>      sys.exit(bitbake_main(BitBakeConfigParameters(sys.argv),
>    File "/home/jkroon/Projects/foo-linux/bitbake/lib/bb/main.py", line
> 366, in bitbake_main
>      server_connection, ui_module = setup_bitbake(configParams,
> configuration)
>    File "/home/jkroon/Projects/foo-linux/bitbake/lib/bb/main.py", line
> 404, in setup_bitbake
>      ui_module = import_extension_module(bb.ui, configParams.ui, 'main')
>    File "/home/jkroon/Projects/foo-linux/bitbake/lib/bb/main.py", line
> 96, in import_extension_module
>      module = __import__(pkg.__name__, fromlist=[modulename])
>    File "/home/jkroon/Projects/foo-linux/bitbake/lib/bb/ui/taskexp.py",
> line 33, in <module>
>      class PackageDepView(Gtk.TreeView):
> NameError: name 'Gtk' is not defined
>
> Reverting the patch allows me to run
>
>   bitbake -g -u taskexp core-image-minimal
>
> and browsing via the Gtk UI works fine.
>
> Jacob
>

--000000000000d91c6805a9d8b1e3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks=C2=A0Jacob for the feedback. I&#39;ll submit a patc=
h v2 with the changes</div><div><div dir=3D"auto"><br></div></div><div><br>=
<div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Ju=
l 7, 2020 at 5:53 AM Jacob Kroon &lt;<a href=3D"mailto:jacob.kroon@gmail.co=
m" target=3D"_blank">jacob.kroon@gmail.com</a>&gt; wrote:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">On 7/1/20 6:27 PM, David Khouya w=
rote:<br>
&gt; When running bitbake -g -u taskexp without having gi python module or<=
br>
&gt; and invalid gtk version, bitbake fails with a stack trace.<br>
&gt; <br>
&gt; In case of import or version error, bitbake should exit with an error<=
br>
&gt; message instead of a stack trace.<br>
&gt; <br>
&gt; Signed-off-by: David Khouya &lt;<a href=3D"mailto:dakhouya@gmail.com" =
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
&gt; +=C2=A0 =C2=A0 sys.exit(&quot;FATAL: Gtk version needs to be 3.0&quot;=
)<br>
&gt; +except ImportError:<br>
&gt; +=C2=A0 =C2=A0 sys.exit(&quot;FATAL: Gtk ui could not load the require=
d gi python module&quot;)<br>
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
=C2=A0 =C2=A0File &quot;/home/jkroon/Projects/foo-linux/bitbake/bin/bitbake=
&quot;, line 35, <br>
in &lt;module&gt;<br>
=C2=A0 =C2=A0 =C2=A0sys.exit(bitbake_main(BitBakeConfigParameters(sys.argv)=
,<br>
=C2=A0 =C2=A0File &quot;/home/jkroon/Projects/foo-linux/bitbake/lib/bb/main=
.py&quot;, line <br>
366, in bitbake_main<br>
=C2=A0 =C2=A0 =C2=A0server_connection, ui_module =3D setup_bitbake(configPa=
rams, <br>
configuration)<br>
=C2=A0 =C2=A0File &quot;/home/jkroon/Projects/foo-linux/bitbake/lib/bb/main=
.py&quot;, line <br>
404, in setup_bitbake<br>
=C2=A0 =C2=A0 =C2=A0ui_module =3D import_extension_module(bb.ui, configPara=
ms.ui, &#39;main&#39;)<br>
=C2=A0 =C2=A0File &quot;/home/jkroon/Projects/foo-linux/bitbake/lib/bb/main=
.py&quot;, line <br>
96, in import_extension_module<br>
=C2=A0 =C2=A0 =C2=A0module =3D __import__(pkg.__name__, fromlist=3D[modulen=
ame])<br>
=C2=A0 =C2=A0File &quot;/home/jkroon/Projects/foo-linux/bitbake/lib/bb/ui/t=
askexp.py&quot;, <br>
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

--000000000000d91c6805a9d8b1e3--
