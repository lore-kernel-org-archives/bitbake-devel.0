Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76815ECAAA3
	for <webhook@archiver.kernel.org>; Fri, 26 Aug 2022 14:22:06 +0000 (UTC)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by mx.groups.io with SMTP id smtpd.web09.37712.1661523716237628869
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 26 Aug 2022 07:21:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=VBVlLlh3;
 spf=pass (domain: axis.com, ip: 195.60.68.18,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1661523716;
  x=1693059716;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=AMyZXmg0DueM4aerOpdv52oTcKyzXCnCdV6Dnd1QBxk=;
  b=VBVlLlh3OG9zDISEPvowW4nzGzb//S8XaShknVEpqhMUr/WXm0rRrDx3
   7R4LAtI8WqhaB2Io1u0xMlgobNQ7tYLq7+h+X+CqULmpujySGEi5UGXWz
   dgqMTiqZUGurTB/o3u16S5VGUOeoF6r4RjsnaYRtti0RvxXmvRDXsyUTP
   NhxiCeJKSq00tp7tsOMf21LOZrkb8Rl5lZaHteNiXGVVz+pwrj0S81QZt
   0wwRqqQ8n0sSYzaPOApfBCAB4kYMbwCUxORjdhj/0t11np2usLzqgL5w5
   vrN72blWgSLbJqbJN+Tmi2LTg9E/0ajJzzDv44unfbsZotcyFyGKfIfD7
   Q==;
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Robert Yang <liezhi.yang@windriver.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [RFC][PATCH V2] bitbake: fetch2/git: Use git
 fetch to shallow clone revisions
Thread-Topic: [bitbake-devel] [RFC][PATCH V2] bitbake: fetch2/git: Use git
 fetch to shallow clone revisions
Thread-Index: AQHYuU1Gw59fzXMdoUasR/NEAFiDKa3BN3aQ
Date: Fri, 26 Aug 2022 14:21:53 +0000
Message-ID: <94af8607626d42e58b05fb79a2d07e02@axis.com>
References: <20220826131047.51373-1-liezhi.yang@windriver.com>
In-Reply-To: <20220826131047.51373-1-liezhi.yang@windriver.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.5.60]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 26 Aug 2022 14:22:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13940

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-
> devel@lists.openembedded.org> On Behalf Of Robert Yang
> Sent: den 26 augusti 2022 15:11
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [RFC][PATCH V2] bitbake: fetch2/git: Use git
> fetch to shallow clone revisions
>=20
> * V2
>   Fixed typos in commit message

Patch history should go after the --- below.

> The "git clone --depth" only works for refs, doesn't support revisions, b=
ut
> "git fetch --depth" supports revisions, so use it to do the shallow clone=
, the
> idea is from "git clone --recurse-submodules --shallow-submodules".
>=20
> The workflow is (Only enabled when BB_GIT_SHALLOW =3D "1"):
> $ git init --bare <clonedir>
> $ git remote add origin <url>
> $ git fetch origin --depth <depth> revision
> $ git branch <branchname> FETCH_HEAD
> $ git tag v<branchname> FETCH_HEAD
>=20
> Here is the testing data based on poky, the testing server has a very goo=
d
> network bandwidth:
>=20
> Add 'BB_GIT_SHALLOW =3D "1"' conf/local.conf
> $ rm -fr tmp downloads # Fresh download for each build
> $ time bitbake world --runall=3Dfetch
> $ du -sh downloads/git2/
>=20
>        Full        Shallow      Saved
> --------------------------------------
> Time:  15m59s       2m31s       84% (13m28s)
> Size:  12G          1.2G        90% (10.8G)
>=20
> * The Size is for downloads/git2/, the tarballs are not counted.
>=20
> We can see that it saves a lot of download time and disk space, for
> example:
>=20
> linux-yocto: 2.8G -> 228M
> llvm: 2.5G -> 171M
> cryptography: 1.5G -> 35M
>=20
> And "$ bitbake world" works well.
>=20
> This a RFC patch, please feel free to give you comments.
>=20
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> ---
>  bitbake/lib/bb/fetch2/git.py | 83 ++++++++++++++++++++++++++++--------
>  1 file changed, 66 insertions(+), 17 deletions(-)
>=20
> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
> index 4534bd75800..57bb61d5ee1 100644
> --- a/bitbake/lib/bb/fetch2/git.py
> +++ b/bitbake/lib/bb/fetch2/git.py
> @@ -244,6 +244,7 @@ class Git(FetchMethod):
>                  ud.unresolvedrev[name] =3D 'HEAD'
>=20
>          ud.basecmd =3D d.getVar("FETCHCMD_git") or "git -c core.fsyncobj=
ectfiles=3D0 -c gc.autoDetach=3Dfalse -c core.pager=3Dcat"
> +        ud.basecmd =3D "LANG=3DC %s" % ud.basecmd
>=20
>          write_tarballs =3D d.getVar("BB_GENERATE_MIRROR_TARBALLS") or "0=
"
>          ud.write_tarballs =3D write_tarballs !=3D "0" or ud.rebaseable
> @@ -344,6 +345,49 @@ class Git(FetchMethod):
>              return False
>          return True
>=20
> +    def shallow_clone_by_fetch(self, ud, repourl, d):
> +        """
> +        Use "git fetch --depth <depth> revision" to implement shallow cl=
one
> +        since git can't clone a revision, a better solution should be:
> +        "git fetch --depth <depth> revision:<branchname>" but it doesn't=
 work
> +        when revision is a tag, e.g.:
> +        error: cannot update ref 'refs/heads/master': trying to write
> +                non-commit object <revision> to branch 'refs/heads/maste=
r'
> +        """
> +
> +        import datetime
> +
> +        depth =3D ud.shallow_depths[ud.names[0]]
> +        revision =3D ud.revisions[ud.names[0]]
> +        branchname =3D ud.branches[ud.names[0]]
> +        if not branchname:
> +            branchname =3D "master"
> +
> +        # Rename branchname if it exists which can:
> +        # - Avoid conflicts during update
> +        # - Keep the revision on a branch so that "git submodule update =
--recursive"
> +        #    can work since it requires the revision on a branch.
> +        branch_path =3D os.path.join(ud.clonedir, 'refs/heads/%s' % bran=
chname)
> +        if os.path.exists(branch_path):
> +            os.rename(branch_path, '%s.%s' % (branch_path, datetime.date=
time.now().strftime("%Y%m%d%H%M%S")))

Any reason this is done using os.rename() rather than `git branch -m?

> +
> +        init_cmd =3D "%s init --bare -q" % ud.basecmd
> +        add_remote_cmd =3D "%s remote add origin %s" % (ud.basecmd, shle=
x.quote(repourl))
> +        fetch_cmd =3D "%s fetch --progress origin --depth %s %s" % (ud.b=
asecmd, depth, revision)
> +        # Create both branch and tag for the revision
> +        branch_cmd =3D "%s branch -f %s FETCH_HEAD" % (ud.basecmd, branc=
hname)
> +        tag_cmd =3D "%s tag -f v%s FETCH_HEAD" % (ud.basecmd, branchname=
)

Why not define these as a list instead:

        cmds =3D [
            "%s init --bare -q" % ud.basecmd,
            "%s remote add origin %s" % (ud.basecmd, shlex.quote(repourl))
            "%s fetch --progress origin --depth %s %s" % (ud.basecmd, depth=
, revision),
            # Create both branch and tag for the revision
            "%s branch -f %s FETCH_HEAD" % (ud.basecmd, branchname),
            "%s tag -f v%s FETCH_HEAD" % (ud.basecmd, branchname),
        ]

> +
> +        if ud.proto.lower() !=3D 'file':
> +            bb.fetch2.check_network_access(d, fetch_cmd, ud.url)
> +
> +        if not os.path.exists(ud.clonedir):
> +            bb.utils.mkdirhier(ud.clonedir)
> +
> +        progresshandler =3D GitProgressHandler(d)
> +        for cmd in (init_cmd, add_remote_cmd, fetch_cmd, branch_cmd, tag=
_cmd):
> +            runfetchcmd(cmd, d, log=3Dprogresshandler, workdir=3Dud.clon=
edir)
> +
>      def download(self, ud, d):
>          """Fetch url"""
>=20
> @@ -360,7 +404,7 @@ class Git(FetchMethod):
>              else:
>                  tmpdir =3D tempfile.mkdtemp(dir=3Dd.getVar('DL_DIR'))
>                  runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdir=3D=
tmpdir)
> -                fetch_cmd =3D "LANG=3DC %s fetch -f --progress %s " % (u=
d.basecmd, shlex.quote(tmpdir))
> +                fetch_cmd =3D "%s fetch -f --progress %s " % (ud.basecmd=
, shlex.quote(tmpdir))
>                  runfetchcmd(fetch_cmd, d, workdir=3Dud.clonedir)
>          repourl =3D self._get_repo_url(ud)
>=20
> @@ -369,27 +413,32 @@ class Git(FetchMethod):
>              # We do this since git will use a "-l" option automatically =
for local urls where possible
>              if repourl.startswith("file://"):
>                  repourl =3D repourl[7:]
> -            clone_cmd =3D "LANG=3DC %s clone --bare --mirror %s %s --pro=
gress" % (ud.basecmd, shlex.quote(repourl), ud.clonedir)
> -            if ud.proto.lower() !=3D 'file':
> -                bb.fetch2.check_network_access(d, clone_cmd, ud.url)
> -            progresshandler =3D GitProgressHandler(d)
> -            runfetchcmd(clone_cmd, d, log=3Dprogresshandler)
> +            if ud.shallow:
> +                self.shallow_clone_by_fetch(ud, repourl, d)
> +            else:
> +                clone_cmd =3D "%s clone --bare --mirror %s %s --progress=
" % (ud.basecmd, shlex.quote(repourl), ud.clonedir)
> +                progresshandler =3D GitProgressHandler(d)
> +                if ud.proto.lower() !=3D 'file':
> +                    bb.fetch2.check_network_access(d, clone_cmd, ud.url)
> +                runfetchcmd(clone_cmd, d, log=3Dprogresshandler)
>=20
>          # Update the checkout if needed
>          if self.clonedir_need_update(ud, d):
>              output =3D runfetchcmd("%s remote" % ud.basecmd, d, quiet=3D=
True, workdir=3Dud.clonedir)
>              if "origin" in output:
> -              runfetchcmd("%s remote rm origin" % ud.basecmd, d, workdir=
=3Dud.clonedir)
> -
> -            runfetchcmd("%s remote add --mirror=3Dfetch origin %s" % (ud=
.basecmd, shlex.quote(repourl)), d, workdir=3Dud.clonedir)
> -            fetch_cmd =3D "LANG=3DC %s fetch -f --progress %s refs/*:ref=
s/*" % (ud.basecmd, shlex.quote(repourl))
> -            if ud.proto.lower() !=3D 'file':
> -                bb.fetch2.check_network_access(d, fetch_cmd, ud.url)
> -            progresshandler =3D GitProgressHandler(d)
> -            runfetchcmd(fetch_cmd, d, log=3Dprogresshandler, workdir=3Du=
d.clonedir)
> -            runfetchcmd("%s prune-packed" % ud.basecmd, d, workdir=3Dud.=
clonedir)
> -            runfetchcmd("%s pack-refs --all" % ud.basecmd, d, workdir=3D=
ud.clonedir)
> -            runfetchcmd("%s pack-redundant --all | xargs -r rm" % ud.bas=
ecmd, d, workdir=3Dud.clonedir)
> +                runfetchcmd("%s remote rm origin" % ud.basecmd, d, workd=
ir=3Dud.clonedir)
> +            if ud.shallow:
> +                self.shallow_clone_by_fetch(ud, repourl, d)
> +            else:
> +                runfetchcmd("%s remote add --mirror=3Dfetch origin %s" %=
 (ud.basecmd, shlex.quote(repourl)), d, workdir=3Dud.clonedir)
> +                fetch_cmd =3D "%s fetch -f --progress %s refs/*:refs/*" =
% (ud.basecmd, shlex.quote(repourl))
> +                if ud.proto.lower() !=3D 'file':
> +                    bb.fetch2.check_network_access(d, fetch_cmd, ud.url)
> +                progresshandler =3D GitProgressHandler(d)
> +                runfetchcmd(fetch_cmd, d, log=3Dprogresshandler, workdir=
=3Dud.clonedir)
> +                runfetchcmd("%s prune-packed" % ud.basecmd, d, workdir=
=3Dud.clonedir)
> +                runfetchcmd("%s pack-refs --all" % ud.basecmd, d, workdi=
r=3Dud.clonedir)
> +                runfetchcmd("%s pack-redundant --all | xargs -r rm" % ud=
.basecmd, d, workdir=3Dud.clonedir)
>              try:
>                  os.unlink(ud.fullmirror)
>              except OSError as exc:
> --
> 2.35.1

//Peter


