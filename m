Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D630C433EF
	for <webhook@archiver.kernel.org>; Thu, 27 Jan 2022 10:53:14 +0000 (UTC)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com
 [209.85.222.45])
 by mx.groups.io with SMTP id smtpd.web10.27245.1643280792982345658
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Jan 2022 02:53:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=Gop7dxg0;
 spf=pass (domain: gmail.com, ip: 209.85.222.45,
 mailfrom: alex.kanavin@gmail.com)
Received: by mail-ua1-f45.google.com with SMTP id c36so3873745uae.13
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Jan 2022 02:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VNy+60tjJWBgqiKsNZ0IOE0bN0TWrZRYsJn+jwj3acE=;
        b=Gop7dxg0Q/n19baodShn5DHGGKeQMza5Qsl+0WLFNye/zgyK8zs/lzP5ZNy70GQs5b
         gtB43UGq2exkl9+4mP9DBNkZlzcg1wBojXH92rrXoP0/8gvnKeMb7LQRJkcKKG53E2ms
         fTDKxdb168qdTN2DLRyzbBK4N8+9Fh4nRic98oA7KhjBrdOtjZsypvRUtrHrkNw9sNf8
         bgyP8rWzS069pf6PvcI0inhgwV/jc3xcgKxGlFkxW2RAh2MJfEulGyCXEOni1mpF0uO8
         vhUFBV3R9lqtAm3fFUbpfZqGk75FOCnVnqy6s3cre3gevgSG0+neCNi0lx1IM7bjdBmn
         izCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VNy+60tjJWBgqiKsNZ0IOE0bN0TWrZRYsJn+jwj3acE=;
        b=SAv+2INICdNkyMDYkTdP3iCqc2Ru0uPOn4CiVRe2ykKa6aNTj+j3zZJ5U3rLUu1w39
         v3gjaTzHppXaNzZJZaWxI/40R57QdmeErKJ8OcIplvJ2bgcML5KBAGBcsUttlw1cqZeU
         s3Lr80vkRTqMHuyfwvesNcRpR4H6puFrzlzjjkPMHCLIQ/ZG73nKDzsmR9lV4SkAhXoq
         qABTeMe1wNqd+98OCvcNIeJl9f5q2EnXi3wE4H/REAgkinOorQn8Lv1jgPbITIfLFZiu
         SEX0joM9C0eWVXnuC19Xx8bp5lKzvSS0ksMFY9jIOMQIUlXrwfgykjWUSHxSuiC2vHKa
         Sbhg==
X-Gm-Message-State: AOAM533BbNT6QBTqBYQfjn1C3Es/wCEqgZxCo/oAua5arON5LGS7ZtbV
	5t7TIEP4Seli/Z53ZTXk1QtqnBMiyeOP6WGfLZw=
X-Google-Smtp-Source: 
 ABdhPJwkkRvSIEo11QoUX+nhY5cK+m2u1sgXr+BDLAVmoEUaF7od7RFHuChhsYv0ZVhej3D5Z5LoXNOnh+qeV4/ySmk=
X-Received: by 2002:a67:a401:: with SMTP id n1mr1259722vse.38.1643280791938;
 Thu, 27 Jan 2022 02:53:11 -0800 (PST)
MIME-Version: 1.0
References: <20220119180015.1931903-1-richard.purdie@linuxfoundation.org>
 <b889e360-9b6e-4517-c03a-f31f3168e36e@weidmueller.com>
In-Reply-To: <b889e360-9b6e-4517-c03a-f31f3168e36e@weidmueller.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 27 Jan 2022 11:53:00 +0100
Message-ID: 
 <CANNYZj8X3-zB+JBf2aHhiNmgPEBZ6KrrdZCAxBr9gj6WVJwsxQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: Add crate fetcher
To: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="000000000000dea8d405d68e1f4d"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Jan 2022 10:53:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13288

--000000000000dea8d405d68e1f4d
Content-Type: text/plain; charset="UTF-8"

Hello Stefan,

this is already in master, so the concerns you have are probably better
addressed with followup patches.

Alex

On Thu, 27 Jan 2022 at 11:39, Stefan Herbrechtsmeier <
stefan.herbrechtsmeier-oss@weidmueller.com> wrote:

> Hi Richard,
>
> Am 19.01.2022 um 19:00 schrieb Richard Purdie via lists.openembedded.org:
> > This imports the crate fetcher from OE-Core to resolve various module
> issues
> > and adds some very very basic tests of that new fetcher.
> >
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > ---
> >   lib/bb/fetch2/__init__.py |   2 +
> >   lib/bb/fetch2/crate.py    | 137 ++++++++++++++++++++++++++++++++++++++
> >   lib/bb/tests/fetch.py     |  35 ++++++++++
> >   3 files changed, 174 insertions(+)
> >   create mode 100644 lib/bb/fetch2/crate.py
> >
> > diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> > index 0b39ea6aaa..d37174185a 100644
> > --- a/lib/bb/fetch2/__init__.py
> > +++ b/lib/bb/fetch2/__init__.py
> > @@ -1942,6 +1942,7 @@ from . import clearcase
> >   from . import npm
> >   from . import npmsw
> >   from . import az
> > +from . import crate
> >
> >   methods.append(local.Local())
> >   methods.append(wget.Wget())
> > @@ -1962,3 +1963,4 @@ methods.append(clearcase.ClearCase())
> >   methods.append(npm.Npm())
> >   methods.append(npmsw.NpmShrinkWrap())
> >   methods.append(az.Az())
> > +methods.append(crate.Crate())
> > diff --git a/lib/bb/fetch2/crate.py b/lib/bb/fetch2/crate.py
> > new file mode 100644
> > index 0000000000..f7e2354afb
> > --- /dev/null
> > +++ b/lib/bb/fetch2/crate.py
> > @@ -0,0 +1,137 @@
> > +# ex:ts=4:sw=4:sts=4:et
> > +# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
> > +"""
> > +BitBake 'Fetch' implementation for crates.io
> > +"""
> > +
> > +# Copyright (C) 2016 Doug Goldstein
> > +#
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +#
> > +# Based on functions from the base bb module, Copyright 2003 Holger
> Schurig
> > +
> > +import hashlib
> > +import json
> > +import os
> > +import shutil
> > +import subprocess
> > +import bb
> > +from   bb.fetch2 import logger, subprocess_setup, UnpackError
> > +from   bb.fetch2.wget import Wget
> > +
> > +
> > +class Crate(Wget):
> > +
> > +    """Class to fetch crates via wget"""
> > +
> > +    def _cargo_bitbake_path(self, rootdir):
> > +        return os.path.join(rootdir, "cargo_home", "bitbake")
> > +
> > +    def supports(self, ud, d):
> > +        """
> > +        Check to see if a given url is for this fetcher
> > +        """
> > +        return ud.type in ['crate']
> > +
> > +    def recommends_checksum(self, urldata):
> > +        return False
>
> Why is this false? How the fetcher check the integrity?
>
> > +
> > +    def urldata_init(self, ud, d):
> > +        """
> > +        Sets up to download the respective crate from crates.io
> > +        """
> > +
> > +        if ud.type == 'crate':
> > +            self._crate_urldata_init(ud, d)
> > +
> > +        super(Crate, self).urldata_init(ud, d)
>
> Why is this needed? The ud.type should always be 'crate'.
>
> > +
> > +    def _crate_urldata_init(self, ud, d):
> > +        """
> > +        Sets up the download for a crate
> > +        """
> > +
> > +        # URL syntax is: crate://NAME/VERSION
> > +        # break the URL apart by /
>
> Why does this fetcher use a '/' as separation? The npm fetcher use
> package and version options:
>
> npm://some.registry.url;package=${BPN];version=${PV}
>
> > +        parts = ud.url.split('/')
> > +        if len(parts) < 5:
> > +            raise bb.fetch2.ParameterError("Invalid URL: Must be
> crate://HOST/NAME/VERSION", ud.url)
> > +
> > +        # last field is version
> > +        version = parts[len(parts) - 1]
> > +        # second to last field is name
> > +        name = parts[len(parts) - 2]
> > +        # host (this is to allow custom crate registries to be specified
> > +        host = '/'.join(parts[2:len(parts) - 2])
>
> This is error-prone because it is impossible to detect a missing name or
> version if the real host url is used.
>
> > +
> > +        # if using upstream just fix it up nicely
> > +        if host == 'crates.io':
> > +            host = 'crates.io/api/v1/crates'
> > +
> > +        ud.url = "https://%s/%s/%s/download" % (host, name, version)
> > +        ud.parm['downloadfilename'] = "%s-%s.crate" % (name, version)
> > +        ud.parm['name'] = name
> > +
> > +        logger.debug(2, "Fetching %s to %s" % (ud.url,
> ud.parm['downloadfilename']))
> > +
> > +    def unpack(self, ud, rootdir, d):
> > +        """
> > +        Uses the crate to build the necessary paths for cargo to
> utilize it
> > +        """
> > +        if ud.type == 'crate':
> > +            return self._crate_unpack(ud, rootdir, d)
> > +        else:
> > +            super(Crate, self).unpack(ud, rootdir, d)
>
> Why is this needed? The ud.type should always be 'crate'.
>
> > +
> > +    def _crate_unpack(self, ud, rootdir, d):
> > +        """
> > +        Unpacks a crate
> > +        """
> > +        thefile = ud.localpath
> > +
> > +        # possible metadata we need to write out
> > +        metadata = {}
> > +
> > +        # change to the rootdir to unpack but save the old working dir
> > +        save_cwd = os.getcwd()
> > +        os.chdir(rootdir)
> > +
> > +        pn = d.getVar('BPN')
> > +        if pn == ud.parm.get('name'):
> > +            cmd = "tar -xz --no-same-owner -f %s" % thefile
> > +        else:
> > +            cargo_bitbake = self._cargo_bitbake_path(rootdir)
> > +
> > +            cmd = "tar -xz --no-same-owner -f %s -C %s" % (thefile,
> cargo_bitbake)
> > +
> > +            # ensure we've got these paths made
> > +            bb.utils.mkdirhier(cargo_bitbake)
> > +
>
> Why don't you use the origin unpack and set the subdir to the correct
> folder. This allows the usage of the wget fetcher for crate archives
> outside of a repository.
>
> > +            # generate metadata necessary
> > +            with open(thefile, 'rb') as f:
> > +                # get the SHA256 of the original tarball
> > +                tarhash = hashlib.sha256(f.read()).hexdigest()
>
> Why don't you reuse the checksum from the recipe.
>
> > +
> > +            metadata['files'] = {}
> > +            metadata['package'] = tarhash
> > +
> > +        path = d.getVar('PATH')
> > +        if path:
> > +            cmd = "PATH=\"%s\" %s" % (path, cmd)
> > +        bb.note("Unpacking %s to %s/" % (thefile, os.getcwd()))
> > +
> > +        ret = subprocess.call(cmd, preexec_fn=subprocess_setup,
> shell=True)
> > +
> > +        os.chdir(save_cwd)
> > +
> > +        if ret != 0:
> > +            raise UnpackError("Unpack command %s failed with return
> value %s" % (cmd, ret), ud.url)
> > +
> > +        # if we have metadata to write out..
> > +        if len(metadata) > 0:
> > +            cratepath = os.path.splitext(os.path.basename(thefile))[0]
> > +            bbpath = self._cargo_bitbake_path(rootdir)
> > +            mdfile = '.cargo-checksum.json'
> > +            mdpath = os.path.join(bbpath, cratepath, mdfile)
> > +            with open(mdpath, "w") as f:
> > +                json.dump(metadata, f)
>
> [snip]
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13287):
> https://lists.openembedded.org/g/bitbake-devel/message/13287
> Mute This Topic: https://lists.openembedded.org/mt/88540302/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

--000000000000dea8d405d68e1f4d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello Stefan,</div><div><br></div><div>this is alread=
y in master, so the concerns you have are probably better addressed with fo=
llowup patches.</div><div><br></div><div>Alex<br></div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, 27 Jan 2022 =
at 11:39, Stefan Herbrechtsmeier &lt;<a href=3D"mailto:stefan.herbrechtsmei=
er-oss@weidmueller.com">stefan.herbrechtsmeier-oss@weidmueller.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Richar=
d,<br>
<br>
Am 19.01.2022 um 19:00 schrieb Richard Purdie via <a href=3D"http://lists.o=
penembedded.org" rel=3D"noreferrer" target=3D"_blank">lists.openembedded.or=
g</a>:<br>
&gt; This imports the crate fetcher from OE-Core to resolve various module =
issues<br>
&gt; and adds some very very basic tests of that new fetcher.<br>
&gt; <br>
&gt; Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@lin=
uxfoundation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&=
gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0lib/bb/fetch2/__init__.py |=C2=A0 =C2=A02 +<br>
&gt;=C2=A0 =C2=A0lib/bb/fetch2/crate.py=C2=A0 =C2=A0 | 137 ++++++++++++++++=
++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0lib/bb/tests/fetch.py=C2=A0 =C2=A0 =C2=A0|=C2=A0 35 ++++++=
++++<br>
&gt;=C2=A0 =C2=A03 files changed, 174 insertions(+)<br>
&gt;=C2=A0 =C2=A0create mode 100644 lib/bb/fetch2/crate.py<br>
&gt; <br>
&gt; diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py<br>
&gt; index 0b39ea6aaa..d37174185a 100644<br>
&gt; --- a/lib/bb/fetch2/__init__.py<br>
&gt; +++ b/lib/bb/fetch2/__init__.py<br>
&gt; @@ -1942,6 +1942,7 @@ from . import clearcase<br>
&gt;=C2=A0 =C2=A0from . import npm<br>
&gt;=C2=A0 =C2=A0from . import npmsw<br>
&gt;=C2=A0 =C2=A0from . import az<br>
&gt; +from . import crate<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0methods.append(local.Local())<br>
&gt;=C2=A0 =C2=A0methods.append(wget.Wget())<br>
&gt; @@ -1962,3 +1963,4 @@ methods.append(clearcase.ClearCase())<br>
&gt;=C2=A0 =C2=A0methods.append(npm.Npm())<br>
&gt;=C2=A0 =C2=A0methods.append(npmsw.NpmShrinkWrap())<br>
&gt;=C2=A0 =C2=A0methods.append(az.Az())<br>
&gt; +methods.append(crate.Crate())<br>
&gt; diff --git a/lib/bb/fetch2/crate.py b/lib/bb/fetch2/crate.py<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..f7e2354afb<br>
&gt; --- /dev/null<br>
&gt; +++ b/lib/bb/fetch2/crate.py<br>
&gt; @@ -0,0 +1,137 @@<br>
&gt; +# ex:ts=3D4:sw=3D4:sts=3D4:et<br>
&gt; +# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-<br>
&gt; +&quot;&quot;&quot;<br>
&gt; +BitBake &#39;Fetch&#39; implementation for <a href=3D"http://crates.i=
o" rel=3D"noreferrer" target=3D"_blank">crates.io</a><br>
&gt; +&quot;&quot;&quot;<br>
&gt; +<br>
&gt; +# Copyright (C) 2016 Doug Goldstein<br>
&gt; +#<br>
&gt; +# SPDX-License-Identifier: GPL-2.0-only<br>
&gt; +#<br>
&gt; +# Based on functions from the base bb module, Copyright 2003 Holger S=
churig<br>
&gt; +<br>
&gt; +import hashlib<br>
&gt; +import json<br>
&gt; +import os<br>
&gt; +import shutil<br>
&gt; +import subprocess<br>
&gt; +import bb<br>
&gt; +from=C2=A0 =C2=A0bb.fetch2 import logger, subprocess_setup, UnpackErr=
or<br>
&gt; +from=C2=A0 =C2=A0bb.fetch2.wget import Wget<br>
&gt; +<br>
&gt; +<br>
&gt; +class Crate(Wget):<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 &quot;&quot;&quot;Class to fetch crates via wget&quot;&=
quot;&quot;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def _cargo_bitbake_path(self, rootdir):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return os.path.join(rootdir, &quot;cargo_=
home&quot;, &quot;bitbake&quot;)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def supports(self, ud, d):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 Check to see if a given url is for this f=
etcher<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ud.type in [&#39;crate&#39;]<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def recommends_checksum(self, urldata):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return False<br>
<br>
Why is this false? How the fetcher check the integrity?<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def urldata_init(self, ud, d):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 Sets up to download the respective crate =
from <a href=3D"http://crates.io" rel=3D"noreferrer" target=3D"_blank">crat=
es.io</a><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ud.type =3D=3D &#39;crate&#39;:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._crate_urldata_init(ud=
, d)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 super(Crate, self).urldata_init(ud, d)<br=
>
<br>
Why is this needed? The ud.type should always be &#39;crate&#39;.<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def _crate_urldata_init(self, ud, d):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 Sets up the download for a crate<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # URL syntax is: crate://NAME/VERSION<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # break the URL apart by /<br>
<br>
Why does this fetcher use a &#39;/&#39; as separation? The npm fetcher use =
<br>
package and version options:<br>
<br>
npm://some.registry.url;package=3D${BPN];version=3D${PV}<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 parts =3D ud.url.split(&#39;/&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if len(parts) &lt; 5:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise bb.fetch2.ParameterEr=
ror(&quot;Invalid URL: Must be crate://HOST/NAME/VERSION&quot;, ud.url)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # last field is version<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 version =3D parts[len(parts) - 1]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # second to last field is name<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 name =3D parts[len(parts) - 2]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # host (this is to allow custom crate reg=
istries to be specified<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 host =3D &#39;/&#39;.join(parts[2:len(par=
ts) - 2])<br>
<br>
This is error-prone because it is impossible to detect a missing name or <b=
r>
version if the real host url is used.<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # if using upstream just fix it up nicely=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if host =3D=3D &#39;<a href=3D"http://cra=
tes.io" rel=3D"noreferrer" target=3D"_blank">crates.io</a>&#39;:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host =3D &#39;<a href=3D"ht=
tp://crates.io/api/v1/crates" rel=3D"noreferrer" target=3D"_blank">crates.i=
o/api/v1/crates</a>&#39;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.url =3D &quot;https://%s/%s/%s/downloa=
d&quot; % (host, name, version)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.parm[&#39;downloadfilename&#39;] =3D &=
quot;%s-%s.crate&quot; % (name, version)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.parm[&#39;name&#39;] =3D name<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 logger.debug(2, &quot;Fetching %s to %s&q=
uot; % (ud.url, ud.parm[&#39;downloadfilename&#39;]))<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def unpack(self, ud, rootdir, d):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 Uses the crate to build the necessary pat=
hs for cargo to utilize it<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ud.type =3D=3D &#39;crate&#39;:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return self._crate_unpack(u=
d, rootdir, d)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 super(Crate, self).unpack(u=
d, rootdir, d)<br>
<br>
Why is this needed? The ud.type should always be &#39;crate&#39;.<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def _crate_unpack(self, ud, rootdir, d):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 Unpacks a crate<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 thefile =3D ud.localpath<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # possible metadata we need to write out<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 metadata =3D {}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # change to the rootdir to unpack but sav=
e the old working dir<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 save_cwd =3D os.getcwd()<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 os.chdir(rootdir)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pn =3D d.getVar(&#39;BPN&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if pn =3D=3D ud.parm.get(&#39;name&#39;):=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd =3D &quot;tar -xz --no-=
same-owner -f %s&quot; % thefile<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cargo_bitbake =3D self._car=
go_bitbake_path(rootdir)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd =3D &quot;tar -xz --no-=
same-owner -f %s -C %s&quot; % (thefile, cargo_bitbake)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # ensure we&#39;ve got thes=
e paths made<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.utils.mkdirhier(cargo_bi=
tbake)<br>
&gt; +<br>
<br>
Why don&#39;t you use the origin unpack and set the subdir to the correct <=
br>
folder. This allows the usage of the wget fetcher for crate archives <br>
outside of a repository.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # generate metadata necessa=
ry<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 with open(thefile, &#39;rb&=
#39;) as f:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # get the SHA=
256 of the original tarball<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tarhash =3D h=
ashlib.sha256(f.read()).hexdigest()<br>
<br>
Why don&#39;t you reuse the checksum from the recipe.<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 metadata[&#39;files&#39;] =
=3D {}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 metadata[&#39;package&#39;]=
 =3D tarhash<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 path =3D d.getVar(&#39;PATH&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if path:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd =3D &quot;PATH=3D\&quot=
;%s\&quot; %s&quot; % (path, cmd)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.note(&quot;Unpacking %s to %s/&quot; %=
 (thefile, os.getcwd()))<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D subprocess.call(cmd, preexec_fn=
=3Dsubprocess_setup, shell=3DTrue)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 os.chdir(save_cwd)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ret !=3D 0:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise UnpackError(&quot;Unp=
ack command %s failed with return value %s&quot; % (cmd, ret), ud.url)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # if we have metadata to write out..<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if len(metadata) &gt; 0:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cratepath =3D os.path.split=
ext(os.path.basename(thefile))[0]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bbpath =3D self._cargo_bitb=
ake_path(rootdir)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mdfile =3D &#39;.cargo-chec=
ksum.json&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mdpath =3D os.path.join(bbp=
ath, cratepath, mdfile)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 with open(mdpath, &quot;w&q=
uot;) as f:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 json.dump(met=
adata, f)<br>
<br>
[snip]<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#13287): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/13287" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/13287</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/88540302/1686=
489" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/88540302/1686489</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:alex.kanavin@gmail.com" target=3D"=
_blank">alex.kanavin@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--000000000000dea8d405d68e1f4d--

