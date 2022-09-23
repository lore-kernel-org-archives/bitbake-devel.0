Return-Path: <rg@braneaudio.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A4DC07E9D
	for <webhook@archiver.kernel.org>; Fri, 23 Sep 2022 23:34:19 +0000 (UTC)
Subject: Git lfs support does not work if destsuffix is set. #bitbake
To: bitbake-devel@lists.openembedded.org
From: "Richard Greer" <rg@braneaudio.com>
X-Originating-Location: Austin, Texas, US (70.113.41.81)
X-Originating-Platform: Linux Chrome 105
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Fri, 23 Sep 2022 16:34:18 -0700
Message-ID: <qdE8.1663976058379726644.HOzG@lists.openembedded.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 23 Sep 2022 23:34:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13994

First off, this is my first ever post to the list.  So, if I am doing somet=
hing incorrectly please let me know.  I also have very limited knowledge in=
to the inner workings of bitbake.

This was done on the kirkstone release, but I do not think the relevant fil=
e has been changed since then for git LFS support.

I have a private git repository that requires LFS support.  I setup the SRC=
_URI as:
   SRC_URI =3D "git://git@github.com/BraneAudio/Image.git;branch=3Dmain;pro=
tocol=3Dssh;lfs=3D1;destsuffix=3Dbrane-files"

The relevant file is bitbake/lib/bb/fetch2/git.py.

When it gets to the do_unpack task, it fails since it cannot find the large=
 files.  This is because Git.download()
calls Git.unpack to put items into a tmpdir.  When it goes to check for and=
 LFS into the repo, it assumes that
the unpack put the repo into a "git" folder which is not the case if destsu=
ffix is set.

I believe that ud.destdir would have the correct path if it were used inste=
ad.

It would mean changing the following lines (line numbers 424-425 in kirksto=
ne):
                if os.path.exists(os.path.join(tmpdir, "git", ".git", "lfs"=
)):
                    runfetchcmd("tar -cf - lfs | tar -xf - -C %s" % ud.clon=
edir, d, workdir=3D"%s/git/.git" % tmpdir)
to:
                if os.path.exists(os.path.join(ud.destdir, ".git", "lfs")):
                    runfetchcmd("tar -cf - lfs | tar -xf - -C %s" % ud.clon=
edir, d, workdir=3D"%s/.git" % ud.destdir)

I do not know enough about bitbake and all of the fetching code to know if =
it works for all cases.  It does work for my case though.

It should be noted that if subdir is set to an absolute path, the Git.unpac=
k() to the tmpdir will fail since there is no way for that absolute path to=
 exist in the tmpdir.  That does not affect me, and I would assume that to =
fix that for LFS support would be a lot more involved.  If I were to make a=
 patch, I would include a comment about that though.

Does anyone know if my fix can be applied in the general case, or if there =
are some potential problems with it?

Thanks for reading my first post.

Richard Greer

