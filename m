Return-Path: <paul.barker@konsulko.com>
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
	[209.85.210.67])
	by mail.openembedded.org (Postfix) with ESMTP id F22FB601F3
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Mar 2020 13:45:25 +0000 (UTC)
Received: by mail-ot1-f67.google.com with SMTP id s15so1317487otq.8
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Mar 2020 06:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=konsulko.com; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=k9P2JFtBWdz9Tp3Ow28z17f2/nhxwtbVSpVh4IHGkL0=;
	b=Z1lHZxvfVPRR44u3rsbsZPZ3XsvfCRVggWLsfIcs59T9qVbgFy9CjJG7pGetMbs3+I
	+7wT+cV26YrdC4LYMUswNyN7rOJvIvc+T4o4rJ5NyZPSohlKTnHcNc3SlC9LE43ivXqB
	R8qNq8tuWFMGJ20cp2rQtrR6JDHSJtkyC9wGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=k9P2JFtBWdz9Tp3Ow28z17f2/nhxwtbVSpVh4IHGkL0=;
	b=uaUXewrLD5kqcfXl+diUrr15r6uevYryGJa3kNoB8aRf/ichVvj18Hb1cWqrOEZFXr
	z4iASIFTHCXCqsOpyfDhvM1eCDCbXvWJKIB1dH/eVNMVmqgr9EDpUpw/NAfXJGgb9vMN
	66sx/smcCfNnCqqhuz9ZoxdjjiBaowuLsSIOahbvWQ34/Pmssr/zBvodrTPOUGxozTTo
	qJH/lqskVeAG4qw8vEvxPs3RyRcWgDi83GJC5U3GpRl6lsWc9PQUTJGWBSqQ4+Mvlfvu
	d6JegT+h8yw4C5Q4zVqWpYDUMSS9emaEGKNktG4clGbjdYo7sNhSBavjdAhD13uPt4vv
	iDCA==
X-Gm-Message-State: ANhLgQ2mkm19PJU57bjicDfUxK2u1S9D5F3Gpxr8HhQTDyvvNzH6vT5+
	JkrWxGyUOWKsPfGCuV6IjJEnYGxocdBv/nKcZ4qxcJQhDpskdw==
X-Google-Smtp-Source: ADFU+vu27+WWIRHfHcApJ4bYIo4HWSqOaAi5JsvGmWPz96s1ckgmT46724wMnLWpim/BR/UG71QrnI1nDxUvueoEHuU=
X-Received: by 2002:a9d:21c5:: with SMTP id s63mr12455657otb.142.1583761526416;
	Mon, 09 Mar 2020 06:45:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200309134246.14067-1-pbarker@konsulko.com>
In-Reply-To: <20200309134246.14067-1-pbarker@konsulko.com>
From: Paul Barker <pbarker@konsulko.com>
Date: Mon, 9 Mar 2020 13:45:13 +0000
Message-ID: <CAM9ZRVuAbnBE2G3xC6fHCmiFc8+L+Eu=KTF-_ymG5XNFb7Cw0w@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH v2] fetch2/gitsm: Unpack shallow mirror tarballs
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 09 Mar 2020 13:45:26 -0000
Content-Type: multipart/alternative; boundary="00000000000030ffa905a06c373e"

--00000000000030ffa905a06c373e
Content-Type: text/plain; charset="UTF-8"

Sorry, I missed the new test when copying this from a poky checkout to a
bitbake checkout to generate the patch. I'll send the test as a follow-up.

On Mon, 9 Mar 2020 at 13:43, Paul Barker <pbarker@konsulko.com> wrote:

> When a shallow mirror tarball is used to satisfy a gitsm URI it needs to
> be unpacked temporarily so that the .gitmodules file can be examined.
>
> Signed-off-by: Paul Barker <pbarker@konsulko.com>
> ---
>  lib/bb/fetch2/gitsm.py | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
> index aa121cbe..e7083001 100644
> --- a/lib/bb/fetch2/gitsm.py
> +++ b/lib/bb/fetch2/gitsm.py
> @@ -20,6 +20,8 @@ NOTE: Switching a SRC_URI from "git://" to "gitsm://"
> requires a clean of your r
>  import os
>  import bb
>  import copy
> +import shutil
> +import tempfile
>  from   bb.fetch2.git import Git
>  from   bb.fetch2 import runfetchcmd
>  from   bb.fetch2 import logger
> @@ -130,7 +132,7 @@ class GitSM(Git):
>              ld.setVar('SRCPV', d.getVar('SRCPV'))
>              ld.setVar('SRCREV_FORMAT', module)
>
> -            function(ud, url, module, paths[module], ld)
> +            function(ud, url, module, paths[module], workdir, ld)
>
>          return submodules != []
>
> @@ -152,7 +154,7 @@ class GitSM(Git):
>          return False
>
>      def download(self, ud, d):
> -        def download_submodule(ud, url, module, modpath, d):
> +        def download_submodule(ud, url, module, modpath, workdir, d):
>              url += ";bareclone=1;nobranch=1"
>
>              # Is the following still needed?
> @@ -163,16 +165,25 @@ class GitSM(Git):
>                  newfetch.download()
>                  # Drop a nugget to add each of the srcrevs we've fetched
> (used by need_update)
>                  runfetchcmd("%s config --add bitbake.srcrev %s" % \
> -                            (ud.basecmd, ud.revisions[ud.names[0]]), d,
> workdir=ud.clonedir)
> +                            (ud.basecmd, ud.revisions[ud.names[0]]), d,
> workdir=workdir)
>              except Exception as e:
>                  logger.error('gitsm: submodule download failed: %s %s' %
> (type(e).__name__, str(e)))
>                  raise
>
>          Git.download(self, ud, d)
> -        self.process_submodules(ud, ud.clonedir, download_submodule, d)
> +
> +        # If we're using a shallow mirror tarball it needs to be unpacked
> +        # temporarily so that we can examine the .gitmodules file
> +        if ud.shallow and os.path.exists(ud.fullshallow) and
> self.need_update(ud, d):
> +            tmpdir = tempfile.mkdtemp(dir=d.getVar("DL_DIR"))
> +            runfetchcmd("tar -xzf %s" % ud.fullshallow, d, workdir=tmpdir)
> +            self.process_submodules(ud, tmpdir, download_submodule, d)
> +            shutil.rmtree(tmpdir)
> +        else:
> +            self.process_submodules(ud, ud.clonedir, download_submodule,
> d)
>
>      def unpack(self, ud, destdir, d):
> -        def unpack_submodules(ud, url, module, modpath, d):
> +        def unpack_submodules(ud, url, module, modpath, workdir, d):
>              url += ";bareclone=1;nobranch=1"
>
>              # Figure out where we clone over the bare submodules...
> --
> 2.20.1
>
>

--00000000000030ffa905a06c373e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Sorry, I missed the new test when copying this from a poky=
 checkout to a bitbake checkout to generate the patch. I&#39;ll send the te=
st as a follow-up.</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cla=
ss=3D"gmail_attr">On Mon, 9 Mar 2020 at 13:43, Paul Barker &lt;<a href=3D"m=
ailto:pbarker@konsulko.com">pbarker@konsulko.com</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">When a shallow mirror tarba=
ll is used to satisfy a gitsm URI it needs to<br>
be unpacked temporarily so that the .gitmodules file can be examined.<br>
<br>
Signed-off-by: Paul Barker &lt;<a href=3D"mailto:pbarker@konsulko.com" targ=
et=3D"_blank">pbarker@konsulko.com</a>&gt;<br>
---<br>
=C2=A0lib/bb/fetch2/gitsm.py | 21 ++++++++++++++++-----<br>
=C2=A01 file changed, 16 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py<br>
index aa121cbe..e7083001 100644<br>
--- a/lib/bb/fetch2/gitsm.py<br>
+++ b/lib/bb/fetch2/gitsm.py<br>
@@ -20,6 +20,8 @@ NOTE: Switching a SRC_URI from &quot;git://&quot; to &quo=
t;gitsm://&quot; requires a clean of your r<br>
=C2=A0import os<br>
=C2=A0import bb<br>
=C2=A0import copy<br>
+import shutil<br>
+import tempfile<br>
=C2=A0from=C2=A0 =C2=A0bb.fetch2.git import Git<br>
=C2=A0from=C2=A0 =C2=A0bb.fetch2 import runfetchcmd<br>
=C2=A0from=C2=A0 =C2=A0bb.fetch2 import logger<br>
@@ -130,7 +132,7 @@ class GitSM(Git):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ld.setVar(&#39;SRCPV&#39;, =
d.getVar(&#39;SRCPV&#39;))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ld.setVar(&#39;SRCREV_FORMA=
T&#39;, module)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 function(ud, url, module, paths[=
module], ld)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 function(ud, url, module, paths[=
module], workdir, ld)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return submodules !=3D []<br>
<br>
@@ -152,7 +154,7 @@ class GitSM(Git):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return False<br>
<br>
=C2=A0 =C2=A0 =C2=A0def download(self, ud, d):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 def download_submodule(ud, url, module, modpat=
h, d):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 def download_submodule(ud, url, module, modpat=
h, workdir, d):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0url +=3D &quot;;bareclone=
=3D1;nobranch=3D1&quot;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Is the following still ne=
eded?<br>
@@ -163,16 +165,25 @@ class GitSM(Git):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0newfetch.down=
load()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Drop a nugg=
et to add each of the srcrevs we&#39;ve fetched (used by need_update)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0runfetchcmd(&=
quot;%s config --add bitbake.srcrev %s&quot; % \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 (ud.basecmd, ud.revisions[ud.names[0]]), d, workdi=
r=3Dud.clonedir)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 (ud.basecmd, ud.revisions[ud.names[0]]), d, workdi=
r=3Dworkdir)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except Exception as e:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger.error(=
&#39;gitsm: submodule download failed: %s %s&#39; % (type(e).__name__, str(=
e)))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Git.download(self, ud, d)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.process_submodules(ud, ud.clonedir, downl=
oad_submodule, d)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # If we&#39;re using a shallow mirror tarball =
it needs to be unpacked<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # temporarily so that we can examine the .gitm=
odules file<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ud.shallow and os.path.exists(ud.fullshallo=
w) and self.need_update(ud, d):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tmpdir =3D tempfile.mkdtemp(dir=
=3Dd.getVar(&quot;DL_DIR&quot;))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(&quot;tar -xzf %s&qu=
ot; % ud.fullshallow, d, workdir=3Dtmpdir)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.process_submodules(ud, tmpd=
ir, download_submodule, d)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 shutil.rmtree(tmpdir)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.process_submodules(ud, ud.c=
lonedir, download_submodule, d)<br>
<br>
=C2=A0 =C2=A0 =C2=A0def unpack(self, ud, destdir, d):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 def unpack_submodules(ud, url, module, modpath=
, d):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 def unpack_submodules(ud, url, module, modpath=
, workdir, d):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0url +=3D &quot;;bareclone=
=3D1;nobranch=3D1&quot;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Figure out where we clone=
 over the bare submodules...<br>
-- <br>
2.20.1<br>
<br>
</blockquote></div>

--00000000000030ffa905a06c373e--
