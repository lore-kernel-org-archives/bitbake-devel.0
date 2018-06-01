Return-Path: <matt.hoosier@gmail.com>
Received: from mail-yb0-f177.google.com (mail-yb0-f177.google.com
	[209.85.213.177])
	by mail.openembedded.org (Postfix) with ESMTP id A5B6C60107
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Jun 2018 14:02:46 +0000 (UTC)
Received: by mail-yb0-f177.google.com with SMTP id i1-v6so8782637ybe.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 01 Jun 2018 07:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to; 
	bh=4IAQcY7pbpmVr5y2MUFc2/B0oZb9JKmz0x6wcPBbPlk=;
	b=CTiUTb54x68qZnrzZOa+w8eCcGp+Tq9GNMj2BXU4GlF5Vt/6W/C1LmW/vcXM20gZOg
	fhwdMyKQ30/aY2y2X5ECMUqYjxvw84uncById047ep+fP7FojTGqwcPods+QKS1DT+2p
	aGhjasadoMdPQNhcsFOkEtWSiIybkUN9Ti5zisX4A0ywlzhBSqW8zTMKVR04H4ObXZzT
	0fbGL57IhxSTmJ2dhUnxYrLfALVoS5cM2Enc1IzLSd91GUzEYUMJOVpA9lrr8LeEY7S3
	b/DiGT2BPjG4L5SzcpEcGilN3k3FYVwKa2ye7HgXiOgkuFANwNveIywigAbPTnR1lFIk
	+tLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to;
	bh=4IAQcY7pbpmVr5y2MUFc2/B0oZb9JKmz0x6wcPBbPlk=;
	b=LgwgGvPm1TUMjyl5iiWLeBnOLxao+vOOAiWd11GRW/losP9gNliXNSvA/ZCWTOz82Y
	+moxAPbbYrn24LBS2pV5MJtoq3JP4VuePx6BYwvbCZ+bZqArj2dS895e9TLlCoEkolKN
	lrElk8jhQ/JsEnTZMOF6ofoloUnujglROkTUbJxlBF4BCcooTOrj7pFFyjnTybbYVjkD
	ZBk+3YhaYYJIbp6l2u+yVrU+7fAFHIP2VulUmpb1FfT7uJgUOSSXu2ocG31l02nnEEBK
	Zx975F9duDU6bTHjb42kH5HcJtuaqJ+OEf2tiMEtDv+y2Am7HlEFpIiFFmT/tK+AbBou
	IRog==
X-Gm-Message-State: ALKqPwenr4W+d0YI7i5G8g8jvVIUrXAuP1NT/cDGdgXoxxhGOxWIV7aq
	jNYkBlAo+CjEPeW7nWQ1CobdbifYID2vlbQavHcOvQ==
X-Google-Smtp-Source: ADUXVKJE8hiv+GfMjxomNGyBrdxaD0eXauzz9QPI1atGNRXqQyKh5J7yxt9tIFjmW1tBHQcoW0DNT3tt2I57AUgNFmE=
X-Received: by 2002:a25:8585:: with SMTP id
	x5-v6mr6121516ybk.300.1527861767091; 
	Fri, 01 Jun 2018 07:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180525134537.27659-1-matt.hoosier@gmail.com>
In-Reply-To: <20180525134537.27659-1-matt.hoosier@gmail.com>
From: Matt Hoosier <matt.hoosier@gmail.com>
Date: Fri, 1 Jun 2018 09:02:11 -0500
Message-ID: <CAJgxT3_wpJWAdH--G5=W9rqCP9Hg97WvVjXBJHGbeojkWOvD+A@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH v5] fetch/gitsm: avoid live submodule fetching during unpack()
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
X-List-Received-Date: Fri, 01 Jun 2018 14:02:46 -0000
Content-Type: multipart/alternative; boundary="000000000000e4bae6056d950953"

--000000000000e4bae6056d950953
Content-Type: text/plain; charset="UTF-8"

Hi;

I was just wondering what the expected procedure is here among the bitbake
devs. Should I be contacting the specific people that have historically
been the committers for the particular code affected by the change?

Thanks,
Matt

On Fri, May 25, 2018 at 8:45 AM Matt Hoosier <matt.hoosier@gmail.com> wrote:

> Although the submodules' histories have been fetched during the
> do_fetch() phase, the mechanics used to clone the workdir copy
> of the repo haven't been transferring the actual .git/modules
> directory from the repo fetched into downloads/ during the
> fetch task.
>
> Fix that, and for good measure also explicitly tell Git to avoid
> hitting the network during do_unpack() of the submodules.
>
> [YOCTO #12739]
>
> Signed-off-by: Matt Hoosier <matt.hoosier@gmail.com>
> ---
>  lib/bb/fetch2/gitsm.py | 84
> +++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 76 insertions(+), 8 deletions(-)
>
> diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
> index 0aff1008..7ac0dbb1 100644
> --- a/lib/bb/fetch2/gitsm.py
> +++ b/lib/bb/fetch2/gitsm.py
> @@ -98,7 +98,7 @@ class GitSM(Git):
>                          for line in lines:
>                              f.write(line)
>
> -    def update_submodules(self, ud, d):
> +    def update_submodules(self, ud, d, allow_network):
>          # We have to convert bare -> full repo, do the submodule bit,
> then convert back
>          tmpclonedir = ud.clonedir + ".tmp"
>          gitdir = tmpclonedir + os.sep + ".git"
> @@ -108,11 +108,47 @@ class GitSM(Git):
>          runfetchcmd("sed " + gitdir + "/config -i -e
> 's/bare.*=.*true/bare = false/'", d)
>          runfetchcmd(ud.basecmd + " reset --hard", d, workdir=tmpclonedir)
>          runfetchcmd(ud.basecmd + " checkout -f " +
> ud.revisions[ud.names[0]], d, workdir=tmpclonedir)
> -        runfetchcmd(ud.basecmd + " submodule update --init --recursive",
> d, workdir=tmpclonedir)
> -        self._set_relative_paths(tmpclonedir)
> -        runfetchcmd("sed " + gitdir + "/config -i -e
> 's/bare.*=.*false/bare = true/'", d, workdir=tmpclonedir)
> -        os.rename(gitdir, ud.clonedir,)
> -        bb.utils.remove(tmpclonedir, True)
> +
> +        try:
> +            if allow_network:
> +                fetch_flags = ""
> +            else:
> +                fetch_flags = "--no-fetch"
> +
> +            # The 'git submodule sync' sandwiched between two successive
> 'git submodule update' commands is
> +            # intentional. See the notes on the similar construction in
> download() for an explanation.
> +            runfetchcmd("%(basecmd)s submodule update --init --recursive
> %(fetch_flags)s || (%(basecmd)s submodule sync --recursive && %(basecmd)s
> submodule update --init --recursive %(fetch_flags)s)" % {'basecmd':
> ud.basecmd, 'fetch_flags' : fetch_flags}, d, workdir=tmpclonedir)
> +        except bb.fetch.FetchError:
> +            if allow_network:
> +                raise
> +            else:
> +                # This method was called as a probe to see whether the
> submodule history
> +                # is complete enough to allow the current working copy to
> have its
> +                # modules filled in. It's not, so swallow up the
> exception and report
> +                # the negative result.
> +                return False
> +        finally:
> +            self._set_relative_paths(tmpclonedir)
> +            runfetchcmd(ud.basecmd + " submodule deinit -f --all", d,
> workdir=tmpclonedir)
> +            runfetchcmd("sed " + gitdir + "/config -i -e
> 's/bare.*=.*false/bare = true/'", d, workdir=tmpclonedir)
> +            os.rename(gitdir, ud.clonedir,)
> +            bb.utils.remove(tmpclonedir, True)
> +
> +        return True
> +
> +    def need_update(self, ud, d):
> +        main_repo_needs_update = Git.need_update(self, ud, d)
> +
> +        # First check that the main repository has enough history
> fetched. If it doesn't, then we don't
> +        # even have the .gitmodules and gitlinks for the submodules to
> attempt asking whether the
> +        # submodules' histories are recent enough.
> +        if main_repo_needs_update:
> +            return True
> +
> +        # Now check that the submodule histories are new enough. The
> git-submodule command doesn't have
> +        # any clean interface for doing this aside from just attempting
> the checkout (with network
> +        # fetched disabled).
> +        return not self.update_submodules(ud, d, allow_network=False)
>
>      def download(self, ud, d):
>          Git.download(self, ud, d)
> @@ -120,7 +156,7 @@ class GitSM(Git):
>          if not ud.shallow or ud.localpath != ud.fullshallow:
>              submodules = self.uses_submodules(ud, d, ud.clonedir)
>              if submodules:
> -                self.update_submodules(ud, d)
> +                self.update_submodules(ud, d, allow_network=True)
>
>      def clone_shallow_local(self, ud, dest, d):
>          super(GitSM, self).clone_shallow_local(ud, dest, d)
> @@ -132,4 +168,36 @@ class GitSM(Git):
>
>          if self.uses_submodules(ud, d, ud.destdir):
>              runfetchcmd(ud.basecmd + " checkout " +
> ud.revisions[ud.names[0]], d, workdir=ud.destdir)
> -            runfetchcmd(ud.basecmd + " submodule update --init
> --recursive", d, workdir=ud.destdir)
> +
> +            # Copy over the submodules' fetched histories too.
> +            if ud.bareclone:
> +                repo_conf = ud.destdir
> +            else:
> +                repo_conf = os.path.join(ud.destdir, '.git')
> +
> +            if os.path.exists(ud.clonedir):
> +                # This is not a copy unpacked from a shallow mirror
> clone. So
> +                # the manual intervention to populate the .git/modules
> done
> +                # in clone_shallow_local() won't have been done yet.
> +                runfetchcmd("cp -fpPRH %s %s" %
> (os.path.join(ud.clonedir, 'modules'), repo_conf), d)
> +                fetch_flags = "--no-fetch"
> +            elif os.path.exists(os.path.join(repo_conf, 'modules')):
> +                # Unpacked from a shallow mirror clone. Manual population
> of
> +                # .git/modules is already done.
> +                fetch_flags = "--no-fetch"
> +            else:
> +                # This isn't fatal; git-submodule will just fetch it
> +                # during do_unpack().
> +                fetch_flags = ""
> +                bb.error("submodule history not retrieved during
> do_fetch()")
> +
> +            # Careful not to hit the network during unpacking; all
> history should already
> +            # be fetched.
> +            #
> +            # The repeated attempts to do the submodule initialization
> sandwiched around a sync to
> +            # install the correct remote URLs into the submodules'
> .git/config metadata are deliberate.
> +            # Bad remote URLs are leftover in the modules' .git/config
> files from the unpack of bare
> +            # clone tarballs and an initial 'git submodule update' is
> necessary to prod them back to
> +            # enough life so that the 'git submodule sync' realizes the
> existing module .git/config
> +            # files exist to be updated.
> +            runfetchcmd("%(basecmd)s submodule update --init --recursive
> %(fetch_flags)s || (%(basecmd)s submodule sync --recursive && %(basecmd)s
> submodule update --init --recursive %(fetch_flags)s)" % {'basecmd':
> ud.basecmd, 'fetch_flags': fetch_flags}, d, workdir=ud.destdir)
> --
> 2.13.6
>
>

--000000000000e4bae6056d950953
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi;<div><br></div><div>I was just wondering what the expec=
ted procedure is here among the bitbake devs. Should I be contacting the sp=
ecific people that have historically been the committers for the particular=
 code affected by the change?</div><div><br></div><div>Thanks,</div><div>Ma=
tt</div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Fri, May 25, 201=
8 at 8:45 AM Matt Hoosier &lt;<a href=3D"mailto:matt.hoosier@gmail.com">mat=
t.hoosier@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
Although the submodules&#39; histories have been fetched during the<br>
do_fetch() phase, the mechanics used to clone the workdir copy<br>
of the repo haven&#39;t been transferring the actual .git/modules<br>
directory from the repo fetched into downloads/ during the<br>
fetch task.<br>
<br>
Fix that, and for good measure also explicitly tell Git to avoid<br>
hitting the network during do_unpack() of the submodules.<br>
<br>
[YOCTO #12739]<br>
<br>
Signed-off-by: Matt Hoosier &lt;<a href=3D"mailto:matt.hoosier@gmail.com" t=
arget=3D"_blank">matt.hoosier@gmail.com</a>&gt;<br>
---<br>
=C2=A0lib/bb/fetch2/gitsm.py | 84 +++++++++++++++++++++++++++++++++++++++++=
++++-----<br>
=C2=A01 file changed, 76 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py<br>
index 0aff1008..7ac0dbb1 100644<br>
--- a/lib/bb/fetch2/gitsm.py<br>
+++ b/lib/bb/fetch2/gitsm.py<br>
@@ -98,7 +98,7 @@ class GitSM(Git):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0for line in lines:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f.write(line)<br>
<br>
-=C2=A0 =C2=A0 def update_submodules(self, ud, d):<br>
+=C2=A0 =C2=A0 def update_submodules(self, ud, d, allow_network):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# We have to convert bare -&gt; full repo=
, do the submodule bit, then convert back<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tmpclonedir =3D ud.clonedir + &quot;.tmp&=
quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gitdir =3D tmpclonedir + os.sep + &quot;.=
git&quot;<br>
@@ -108,11 +108,47 @@ class GitSM(Git):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0runfetchcmd(&quot;sed &quot; + gitdir + &=
quot;/config -i -e &#39;s/bare.*=3D.*true/bare =3D false/&#39;&quot;, d)<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0runfetchcmd(ud.basecmd + &quot; reset --h=
ard&quot;, d, workdir=3Dtmpclonedir)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0runfetchcmd(ud.basecmd + &quot; checkout =
-f &quot; + ud.revisions[ud.names[0]], d, workdir=3Dtmpclonedir)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(ud.basecmd + &quot; submodule upda=
te --init --recursive&quot;, d, workdir=3Dtmpclonedir)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._set_relative_paths(tmpclonedir)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(&quot;sed &quot; + gitdir + &quot;=
/config -i -e &#39;s/bare.*=3D.*false/bare =3D true/&#39;&quot;, d, workdir=
=3Dtmpclonedir)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 os.rename(gitdir, ud.clonedir,)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.utils.remove(tmpclonedir, True)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if allow_network:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fetch_flags =3D &q=
uot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fetch_flags =3D &q=
uot;--no-fetch&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # The &#39;git submodule sync&#3=
9; sandwiched between two successive &#39;git submodule update&#39; command=
s is<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # intentional. See the notes on =
the similar construction in download() for an explanation.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(&quot;%(basecmd)s su=
bmodule update --init --recursive %(fetch_flags)s || (%(basecmd)s submodule=
 sync --recursive &amp;&amp; %(basecmd)s submodule update --init --recursiv=
e %(fetch_flags)s)&quot; % {&#39;basecmd&#39;: ud.basecmd, &#39;fetch_flags=
&#39; : fetch_flags}, d, workdir=3Dtmpclonedir)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 except bb.fetch.FetchError:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if allow_network:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # This method was =
called as a probe to see whether the submodule history<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # is complete enou=
gh to allow the current working copy to have its<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # modules filled i=
n. It&#39;s not, so swallow up the exception and report<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # the negative res=
ult.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return False<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 finally:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._set_relative_paths(tmpclon=
edir)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(ud.basecmd + &quot; =
submodule deinit -f --all&quot;, d, workdir=3Dtmpclonedir)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(&quot;sed &quot; + g=
itdir + &quot;/config -i -e &#39;s/bare.*=3D.*false/bare =3D true/&#39;&quo=
t;, d, workdir=3Dtmpclonedir)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.rename(gitdir, ud.clonedir,)<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.utils.remove(tmpclonedir, Tru=
e)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return True<br>
+<br>
+=C2=A0 =C2=A0 def need_update(self, ud, d):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 main_repo_needs_update =3D Git.need_update(sel=
f, ud, d)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # First check that the main repository has eno=
ugh history fetched. If it doesn&#39;t, then we don&#39;t<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # even have the .gitmodules and gitlinks for t=
he submodules to attempt asking whether the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # submodules&#39; histories are recent enough.=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if main_repo_needs_update:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return True<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Now check that the submodule histories are n=
ew enough. The git-submodule command doesn&#39;t have<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # any clean interface for doing this aside fro=
m just attempting the checkout (with network<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # fetched disabled).<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return not self.update_submodules(ud, d, allow=
_network=3DFalse)<br>
<br>
=C2=A0 =C2=A0 =C2=A0def download(self, ud, d):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Git.download(self, ud, d)<br>
@@ -120,7 +156,7 @@ class GitSM(Git):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not ud.shallow or ud.localpath !=3D ud=
.fullshallow:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0submodules =3D self.uses_su=
bmodules(ud, d, ud.clonedir)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if submodules:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.update_submod=
ules(ud, d)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.update_submod=
ules(ud, d, allow_network=3DTrue)<br>
<br>
=C2=A0 =C2=A0 =C2=A0def clone_shallow_local(self, ud, dest, d):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0super(GitSM, self).clone_shallow_local(ud=
, dest, d)<br>
@@ -132,4 +168,36 @@ class GitSM(Git):<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.uses_submodules(ud, d, ud.destdir=
):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0runfetchcmd(ud.basecmd + &q=
uot; checkout &quot; + ud.revisions[ud.names[0]], d, workdir=3Dud.destdir)<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(ud.basecmd + &quot; =
submodule update --init --recursive&quot;, d, workdir=3Dud.destdir)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Copy over the submodules&#39; =
fetched histories too.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ud.bareclone:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 repo_conf =3D ud.d=
estdir<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 repo_conf =3D os.p=
ath.join(ud.destdir, &#39;.git&#39;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if os.path.exists(ud.clonedir):<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # This is not a co=
py unpacked from a shallow mirror clone. So<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # the manual inter=
vention to populate the .git/modules done<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # in clone_shallow=
_local() won&#39;t have been done yet.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(&quot;=
cp -fpPRH %s %s&quot; % (os.path.join(ud.clonedir, &#39;modules&#39;), repo=
_conf), d)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fetch_flags =3D &q=
uot;--no-fetch&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif os.path.exists(os.path.join=
(repo_conf, &#39;modules&#39;)):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Unpacked from a =
shallow mirror clone. Manual population of<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # .git/modules is =
already done.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fetch_flags =3D &q=
uot;--no-fetch&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # This isn&#39;t f=
atal; git-submodule will just fetch it<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # during do_unpack=
().<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fetch_flags =3D &q=
uot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.error(&quot;sub=
module history not retrieved during do_fetch()&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Careful not to hit the network=
 during unpacking; all history should already<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # be fetched.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 #<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # The repeated attempts to do th=
e submodule initialization sandwiched around a sync to<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # install the correct remote URL=
s into the submodules&#39; .git/config metadata are deliberate.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Bad remote URLs are leftover i=
n the modules&#39; .git/config files from the unpack of bare<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # clone tarballs and an initial =
&#39;git submodule update&#39; is necessary to prod them back to<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # enough life so that the &#39;g=
it submodule sync&#39; realizes the existing module .git/config<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # files exist to be updated.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(&quot;%(basecmd)s su=
bmodule update --init --recursive %(fetch_flags)s || (%(basecmd)s submodule=
 sync --recursive &amp;&amp; %(basecmd)s submodule update --init --recursiv=
e %(fetch_flags)s)&quot; % {&#39;basecmd&#39;: ud.basecmd, &#39;fetch_flags=
&#39;: fetch_flags}, d, workdir=3Dud.destdir)<br>
-- <br>
2.13.6<br>
<br>
</blockquote></div></div>

--000000000000e4bae6056d950953--
