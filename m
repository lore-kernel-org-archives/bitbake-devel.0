Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB9FC433F5
	for <webhook@archiver.kernel.org>; Wed, 15 Dec 2021 14:45:07 +0000 (UTC)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com
 [209.85.222.41])
 by mx.groups.io with SMTP id smtpd.web11.41069.1639579506045770127
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Dec 2021 06:45:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=XKeTyUV7;
 spf=pass (domain: gmail.com, ip: 209.85.222.41,
 mailfrom: alex.kanavin@gmail.com)
Received: by mail-ua1-f41.google.com with SMTP id y5so41347601ual.7
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Dec 2021 06:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OdL8spj2PPW+AY3KlYx55ZA4GD3XFzQRMAKeTCuMf9s=;
        b=XKeTyUV77U/+z1L0leQX2GheNEoyy8WsesKIlETkLnrycXKUL/7yQmU+dCbG8obN/E
         8SukwwO/iqqVmyC2FnJpcJa+IqlkSE9uWUzge7dJENUUOuCndkjs9g6Gg3DhFJ5l3BCu
         3Cptap+mb2pxYJBVLCBNz7aunswQ380j17vW32yS/+9DuYN3UdTwpGoEMw6oqOyVXdak
         b+/3aOZnMOa6p9JZ8uuouHXU+82YWOLCZWDsLdRe8BRSkky/ud0J+iapRyjJJ/zP3IdL
         z4Un6F0xrhbcNtQ8QzzReXJlmAGXFUDWFXm4lztQJYj2gVG3KvFhoZFn2ABFCLNvOmgM
         4DiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OdL8spj2PPW+AY3KlYx55ZA4GD3XFzQRMAKeTCuMf9s=;
        b=rXwJgsVI22aiUl5eBWtRELpq/nfhce7d4hXLmGYTwfB9InUNySbK0476wrKI62ja/J
         RAJ2G021P58E8CbUMRkFyauUM0tZM/pMqg4luaEMLNl3O0Z8kRtgb3tlLYq+R23Diphy
         sYcqrKZPW9D0Vmwxf1ig/IHpqIfGmi0qhaFI2Ovromi+ZPEfN0eiK3ZbQ7GJLJhJCSO7
         6hil1bYiGUjgXboqfbBK7zL9CcuZpVFRm2d/P6v0etbDSea7slpaTdw63GdbWKd9jHvW
         Ox7BSE4WVeMj/4cb4rycoQeM6i4AoWlMRA6PIyuCBFMFULR5/hle/AA+lTLLeM2535RF
         NLAA==
X-Gm-Message-State: AOAM531Y3iILfZ3nmxYhUQAvMuuSoBRxTCirzG04IWEz5obTdV2HZHex
	Twnk4YPuSF2vSgrP6IeTl3QKH68o5iyGlm9Is+M=
X-Google-Smtp-Source: 
 ABdhPJzirMdZwE+Cnp0vIgVl+gktINXLSv7EyFEBKehptVEQV+S69tz0L8PSQhXrnbEGve+u9fAqmQDwCP/svuZtWN0=
X-Received: by 2002:a67:7105:: with SMTP id m5mr2954719vsc.81.1639579505042;
 Wed, 15 Dec 2021 06:45:05 -0800 (PST)
MIME-Version: 1.0
References: <20211215142449.13469-1-pontusja@lap5cg1077w4w.se.axis.com>
In-Reply-To: <20211215142449.13469-1-pontusja@lap5cg1077w4w.se.axis.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 15 Dec 2021 15:44:53 +0100
Message-ID: 
 <CANNYZj-EFA-tZzFLQvVDrLmiFyat5BsU14nyKdQ3BC7gzsmPfg@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC] Implementation of a submodule fetcher
To: Pontus Jaensson <pontus.jaensson@axis.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Fredrik Gustafsson <fredrik.gustafsson@axis.com>,
 Pontus Jaensson <pontusja@axis.com>
Content-Type: multipart/alternative; boundary="000000000000faa6f005d330591b"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Dec 2021 14:45:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13170

--000000000000faa6f005d330591b
Content-Type: text/plain; charset="UTF-8"

Apologies, but this implements non-reproducible fetching (one submodule
revision today, another tomorrow), and therefore unlikely to be accepted.
You can use gitsm:// to check out a specific top level revision, then build
just the submodule.

Alex

On Wed, 15 Dec 2021 at 15:25, Pontus Jaensson <pontus.jaensson@axis.com>
wrote:

> From: Pontus Jaensson <pontusja@axis.com>
>
> This patch consists of a Submodule class which inherits from and extends
> the FetchMethod-class
> for retrieving, initializing and updating a submodule directory. The main
> reason for implementing
> it is to make it possible to track the version of a packet with git
> instead of just a recipe.
>
> The submodule fetcher is used by using the following syntax in the SRC_URI
> field in the recipe:
> SRC_URI = submodule://<PATH TO TOP LEVEL DIRECTORY>;localpath=<NAME OF THE
> WANTED SUBMODULE>.
> Where the submodule-keyword is necessary to use in order to call this
> specific fetcher.
>
> In the download-method the URI is then parsed and the relevant parts from
> it are extracted and
> used to find information about the module in the .gitmodules-file in the
> top level git directory.
> The final thing that happens in the download-method is that git submodule
> init & git submodule
> update are called and executed at the right location for the specified
> submodule.
>
> In the unpack-method the empty directory, that is being created during the
> process but contains no
> information, is removed and replaced with a symlink to the directory that
> contains the actual
> source code.
>
> The code has been tested and so far it seems to work fine.
> ---
>  bitbake/lib/bb/fetch2/__init__.py  |   2 +
>  bitbake/lib/bb/fetch2/submodule.py | 123 +++++++++++++++++++++++++++++
>  2 files changed, 125 insertions(+)
>  create mode 100644 bitbake/lib/bb/fetch2/submodule.py
>
> diff --git a/bitbake/lib/bb/fetch2/__init__.py
> b/bitbake/lib/bb/fetch2/__init__.py
> index 6a38cb0955..a87e0b5338 100644
> --- a/bitbake/lib/bb/fetch2/__init__.py
> +++ b/bitbake/lib/bb/fetch2/__init__.py
> @@ -1923,6 +1923,7 @@ class FetchConnectionCache(object):
>  from . import cvs
>  from . import git
>  from . import gitsm
> +from . import submodule
>  from . import gitannex
>  from . import local
>  from . import svn
> @@ -1945,6 +1946,7 @@ methods.append(wget.Wget())
>  methods.append(svn.Svn())
>  methods.append(git.Git())
>  methods.append(gitsm.GitSM())
> +methods.append(submodule.Submodule())
>  methods.append(gitannex.GitANNEX())
>  methods.append(cvs.Cvs())
>  methods.append(ssh.SSH())
> diff --git a/bitbake/lib/bb/fetch2/submodule.py
> b/bitbake/lib/bb/fetch2/submodule.py
> new file mode 100644
> index 0000000000..ef46404c2e
> --- /dev/null
> +++ b/bitbake/lib/bb/fetch2/submodule.py
> @@ -0,0 +1,123 @@
> +"""
> +BitBake 'Fetch' implementation for local git submodules.
> +
> +Inherits from and extends the FetchMethod for retrieving, initializing and
> +updating a submodule directory.
> +
> +SRC_URI = "submodule://<PATH TO TOP LEVEL GIT
> DIRECTORY>;localpath=<SUBMODULE NAME>"
> +
> +NOTE: If the name of the submodule contains space(s), please indicate
> this by placing
> +the <SUBMODULE NAME> within a single quotation mark and replace the
> space(s) with a
> +backslash (\). Ex) If the submodule name is: name with spaces, then write
> the
> +following: localpath='name\with\spaces'.
> +
> +"""
> +
> +# Pontus Jaensson 2021
> +#
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +
> +import os
> +import subprocess
> +from re import compile
> +from bb.fetch2 import FetchMethod
> +
> +class Submodule(FetchMethod):
> +
> +    def supports(self, ud, d):
> +        """
> +        Checks if the given url can be fetched with submodule.
> +        """
> +        return ud.type in ['submodule']
> +
> +    def download(self, ud, d):
> +        """
> +        Finds the path and the location to the submodule in the local
> .gitmodules
> +        file and then passes it to the execution method.
> +        """
> +        module_path, module_location = self._prepare_module_data(ud.url)
> +
> +        self._run_command(f'git submodule init {module_path}',
> module_location)
> +        self._run_command(f'git submodule update {module_path}',
> module_location)
> +
> +    def unpack(self, ud, root, d):
> +        """
> +        Is called once the 'download' of the submodule has been completed
> in order
> +        to ensure that the source code is in the right location thanks to
> symlinks.
> +        """
> +        path, location = self._prepare_module_data(ud.url)
> +        abs_path = location + path
> +
> +        try:
> +            subprocess.check_output(['rm', '-r', 'gitmodule'])
> +            subprocess.check_output(['ln', '-s', abs_path, 'gitmodule'])
> +        except subprocess.CalledProcessError as e:
> +            raise Exception(f'Failed setting up the symlinks correctly')
> from e
> +
> +    def _run_command(self, cmd, location):
> +        """
> +        Runs the provided cmd command at the path specified by the
> location argument.
> +        Raises an error if the location is unvalid or if the cmd command
> fails.
> +        """
> +        try:
> +            modules_git_command = cmd.split(' ')[:3]
> +            module_path = cmd.split(' ')[3:]
> +            os.chdir(location)
> +            if len(module_path) > 1:
> +                module_path = [' '.join(module_path)]
> +            cmd_array = modules_git_command + module_path
> +            subprocess.check_output(cmd_array)
> +        except OSError as e:
> +            raise Exception(f'Not able to change current working
> directory to: {location}') from e
> +        except subprocess.CalledProcessError as e:
> +            raise Exception(f'Not able to run command: {cmd} at
> {location}') from e
> +
> +    def _parse_url(self, url):
> +        """
> +        Helper method for deconstructing the url from the user data.
> +        """
> +        res =
> compile('([^:]*)://(([^/;]+)@)?(?P<location>[^;]+)(;(?P<submodule>.*))?').match(url)
> +        module_location = res.group('location') + '/'
> +        submodule = res.group('submodule').split('=')[1]
> +        return module_location, submodule
> +
> +    def _prepare_module_data(self, url):
> +        """
> +        Helper method for preparing and processing the submodule data
> based on the
> +        url provided.
> +        """
> +        module_location, name = self._parse_url(url)
> +        modules_path = os.path.abspath(module_location + '.gitmodules')
> +        try:
> +            with open(modules_path) as file:
> +                gitmodule_data = file.readlines()
> +        except:
> +            raise Exception(f'Could not open .gitmodules file located at:
> {modules_path}')
> +
> +        return self._process_submodules_info(gitmodule_data, name),
> module_location
> +
> +    def _process_submodules_info(self, gitmodule_data, wanted_module):
> +        """
> +        Helper method for iterating through the provided gitmodule_data
> in order to find
> +        the path to the wanted_module. Returns it if it is found
> otherwise raises an Exception.
> +        """
> +        module_path = ''
> +
> +        if wanted_module[0] == wanted_module[-1] == "'":
> +            wanted_module = wanted_module[1:-1].replace('\\', ' ')
> +
> +        for line in gitmodule_data:
> +            if line.startswith('[submodule'):
> +                name = line.split('"')[1]
> +                if name == wanted_module:
> +                    current_module = True
> +                else:
> +                    current_module = False
> +            elif line.strip().startswith('path') and current_module:
> +                module_path = line.split('=')[1].strip()
> +                break
> +        if module_path:
> +            return module_path
> +        else:
> +            raise ValueError(f'{wanted_module} is not a valid submodule
> name.')
> --
> 2.20.1
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13168):
> https://lists.openembedded.org/g/bitbake-devel/message/13168
> Mute This Topic: https://lists.openembedded.org/mt/87744763/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

--000000000000faa6f005d330591b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Apologies, but this implements non-reproducible fetch=
ing (one submodule revision today, another tomorrow), and therefore unlikel=
y to be accepted. You can use gitsm:// to check out a specific top level re=
vision, then build just the submodule.<br></div><div><br></div><div>Alex<br=
></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Wed, 15 Dec 2021 at 15:25, Pontus Jaensson &lt;<a href=3D"mailto:=
pontus.jaensson@axis.com">pontus.jaensson@axis.com</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">From: Pontus Jaensson &lt=
;<a href=3D"mailto:pontusja@axis.com" target=3D"_blank">pontusja@axis.com</=
a>&gt;<br>
<br>
This patch consists of a Submodule class which inherits from and extends th=
e FetchMethod-class<br>
for retrieving, initializing and updating a submodule directory. The main r=
eason for implementing<br>
it is to make it possible to track the version of a packet with git instead=
 of just a recipe.<br>
<br>
The submodule fetcher is used by using the following syntax in the SRC_URI =
field in the recipe:<br>
SRC_URI =3D submodule://&lt;PATH TO TOP LEVEL DIRECTORY&gt;;localpath=3D&lt=
;NAME OF THE WANTED SUBMODULE&gt;.<br>
Where the submodule-keyword is necessary to use in order to call this speci=
fic fetcher.<br>
<br>
In the download-method the URI is then parsed and the relevant parts from i=
t are extracted and<br>
used to find information about the module in the .gitmodules-file in the to=
p level git directory.<br>
The final thing that happens in the download-method is that git submodule i=
nit &amp; git submodule<br>
update are called and executed at the right location for the specified subm=
odule.<br>
<br>
In the unpack-method the empty directory, that is being created during the =
process but contains no<br>
information, is removed and replaced with a symlink to the directory that c=
ontains the actual<br>
source code.<br>
<br>
The code has been tested and so far it seems to work fine.<br>
---<br>
=C2=A0bitbake/lib/bb/fetch2/__init__.py=C2=A0 |=C2=A0 =C2=A02 +<br>
=C2=A0bitbake/lib/bb/fetch2/submodule.py | 123 ++++++++++++++++++++++++++++=
+<br>
=C2=A02 files changed, 125 insertions(+)<br>
=C2=A0create mode 100644 bitbake/lib/bb/fetch2/submodule.py<br>
<br>
diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__in=
it__.py<br>
index 6a38cb0955..a87e0b5338 100644<br>
--- a/bitbake/lib/bb/fetch2/__init__.py<br>
+++ b/bitbake/lib/bb/fetch2/__init__.py<br>
@@ -1923,6 +1923,7 @@ class FetchConnectionCache(object):<br>
=C2=A0from . import cvs<br>
=C2=A0from . import git<br>
=C2=A0from . import gitsm<br>
+from . import submodule<br>
=C2=A0from . import gitannex<br>
=C2=A0from . import local<br>
=C2=A0from . import svn<br>
@@ -1945,6 +1946,7 @@ methods.append(wget.Wget())<br>
=C2=A0methods.append(svn.Svn())<br>
=C2=A0methods.append(git.Git())<br>
=C2=A0methods.append(gitsm.GitSM())<br>
+methods.append(submodule.Submodule())<br>
=C2=A0methods.append(gitannex.GitANNEX())<br>
=C2=A0methods.append(cvs.Cvs())<br>
=C2=A0methods.append(ssh.SSH())<br>
diff --git a/bitbake/lib/bb/fetch2/submodule.py b/bitbake/lib/bb/fetch2/sub=
module.py<br>
new file mode 100644<br>
index 0000000000..ef46404c2e<br>
--- /dev/null<br>
+++ b/bitbake/lib/bb/fetch2/submodule.py<br>
@@ -0,0 +1,123 @@<br>
+&quot;&quot;&quot;<br>
+BitBake &#39;Fetch&#39; implementation for local git submodules.<br>
+<br>
+Inherits from and extends the FetchMethod for retrieving, initializing and=
<br>
+updating a submodule directory.<br>
+<br>
+SRC_URI =3D &quot;submodule://&lt;PATH TO TOP LEVEL GIT DIRECTORY&gt;;loca=
lpath=3D&lt;SUBMODULE NAME&gt;&quot;<br>
+<br>
+NOTE: If the name of the submodule contains space(s), please indicate this=
 by placing<br>
+the &lt;SUBMODULE NAME&gt; within a single quotation mark and replace the =
space(s) with a<br>
+backslash (\). Ex) If the submodule name is: name with spaces, then write =
the<br>
+following: localpath=3D&#39;name\with\spaces&#39;.<br>
+<br>
+&quot;&quot;&quot;<br>
+<br>
+# Pontus Jaensson 2021<br>
+#<br>
+# SPDX-License-Identifier: GPL-2.0-only<br>
+#<br>
+<br>
+import os<br>
+import subprocess<br>
+from re import compile<br>
+from bb.fetch2 import FetchMethod<br>
+<br>
+class Submodule(FetchMethod):<br>
+<br>
+=C2=A0 =C2=A0 def supports(self, ud, d):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Checks if the given url can be fetched with su=
bmodule.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ud.type in [&#39;submodule&#39;]<br>
+<br>
+=C2=A0 =C2=A0 def download(self, ud, d):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Finds the path and the location to the submodu=
le in the local .gitmodules<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 file and then passes it to the execution metho=
d.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 module_path, module_location =3D self._prepare=
_module_data(ud.url)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._run_command(f&#39;git submodule init {mo=
dule_path}&#39;, module_location)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._run_command(f&#39;git submodule update {=
module_path}&#39;, module_location)<br>
+<br>
+=C2=A0 =C2=A0 def unpack(self, ud, root, d):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Is called once the &#39;download&#39; of the s=
ubmodule has been completed in order<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 to ensure that the source code is in the right=
 location thanks to symlinks.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 path, location =3D self._prepare_module_data(u=
d.url)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 abs_path =3D location + path<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 subprocess.check_output([&#39;rm=
&#39;, &#39;-r&#39;, &#39;gitmodule&#39;])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 subprocess.check_output([&#39;ln=
&#39;, &#39;-s&#39;, abs_path, &#39;gitmodule&#39;])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 except subprocess.CalledProcessError as e:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise Exception(f&#39;Failed set=
ting up the symlinks correctly&#39;) from e<br>
+<br>
+=C2=A0 =C2=A0 def _run_command(self, cmd, location):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Runs the provided cmd command at the path spec=
ified by the location argument.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises an error if the location is unvalid or =
if the cmd command fails.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 modules_git_command =3D cmd.spli=
t(&#39; &#39;)[:3]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 module_path =3D cmd.split(&#39; =
&#39;)[3:]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.chdir(location)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if len(module_path) &gt; 1:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 module_path =3D [&=
#39; &#39;.join(module_path)]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd_array =3D modules_git_comman=
d + module_path<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 subprocess.check_output(cmd_arra=
y)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 except OSError as e:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise Exception(f&#39;Not able t=
o change current working directory to: {location}&#39;) from e<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 except subprocess.CalledProcessError as e:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise Exception(f&#39;Not able t=
o run command: {cmd} at {location}&#39;) from e<br>
+<br>
+=C2=A0 =C2=A0 def _parse_url(self, url):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Helper method for deconstructing the url from =
the user data.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D compile(&#39;([^:]*)://(([^/;]+)@)?(?P=
&lt;location&gt;[^;]+)(;(?P&lt;submodule&gt;.*))?&#39;).match(url)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 module_location =3D res.group(&#39;location&#3=
9;) + &#39;/&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 submodule =3D res.group(&#39;submodule&#39;).s=
plit(&#39;=3D&#39;)[1]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return module_location, submodule<br>
+<br>
+=C2=A0 =C2=A0 def _prepare_module_data(self, url):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Helper method for preparing and processing the=
 submodule data based on the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 url provided.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 module_location, name =3D self._parse_url(url)=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 modules_path =3D os.path.abspath(module_locati=
on + &#39;.gitmodules&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 with open(modules_path) as file:=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gitmodule_data =3D=
 file.readlines()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 except:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise Exception(f&#39;Could not =
open .gitmodules file located at: {modules_path}&#39;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self._process_submodules_info(gitmodule=
_data, name), module_location<br>
+<br>
+=C2=A0 =C2=A0 def _process_submodules_info(self, gitmodule_data, wanted_mo=
dule):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Helper method for iterating through the provid=
ed gitmodule_data in order to find<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 the path to the wanted_module. Returns it if i=
t is found otherwise raises an Exception.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 module_path =3D &#39;&#39;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if wanted_module[0] =3D=3D wanted_module[-1] =
=3D=3D &quot;&#39;&quot;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wanted_module =3D wanted_module[=
1:-1].replace(&#39;\\&#39;, &#39; &#39;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for line in gitmodule_data:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if line.startswith(&#39;[submodu=
le&#39;):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name =3D line.spli=
t(&#39;&quot;&#39;)[1]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if name =3D=3D wan=
ted_module:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 curr=
ent_module =3D True<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 curr=
ent_module =3D False<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif line.strip().startswith(&#3=
9;path&#39;) and current_module:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 module_path =3D li=
ne.split(&#39;=3D&#39;)[1].strip()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if module_path:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return module_path<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise ValueError(f&#39;{wanted_m=
odule} is not a valid submodule name.&#39;)<br>
-- <br>
2.20.1<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#13168): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/13168" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/13168</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/87744763/1686=
489" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/87744763/1686489</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:alex.kanavin@gmail.com" target=3D"=
_blank">alex.kanavin@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--000000000000faa6f005d330591b--

