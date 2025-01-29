Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE887C02190
	for <webhook@archiver.kernel.org>; Wed, 29 Jan 2025 11:35:55 +0000 (UTC)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
 by mx.groups.io with SMTP id smtpd.web11.10444.1738150552335628998
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 Jan 2025 03:35:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=fyHT/gl6;
 spf=pass (domain: gmail.com, ip: 209.85.219.46, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6d8e8cb8605so34418416d6.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 29 Jan 2025 03:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738150551; x=1738755351; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L354Qnkoi0IEnFxmRYOOJepGxJdU/4g0Lq2KKF0J+fg=;
        b=fyHT/gl6y4+sE8+6bOhUrESAax8T/F20bx5Yu0FxnGl/yp2JqE83rl6b5cP/Ljn0Vq
         xtwE7xcwHNsVj71BW+8ztjsfGe2Mrm0eJ8vRZs7FMPdyP3B2PubMd9XsWM/+xfYyzQIu
         szVLDDNUql1Cxvw3GV5Td3qnN5yh9S8ftTjzr3CTIg6/QphBrshnepS+KDC76LJNTg68
         CTm4Lb0MCmcGWY4/Dr9v9VQL970XJANuq2hoe9ngaPd7FueL/N8eA/veO9SrnU8UHTAa
         5GqD6461DGfsBAlt/eAlwNghQfIWRdKrJG71oJeIlLzUr8UllvW1iphVnj/nd/oyC7Jf
         /EQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738150551; x=1738755351;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L354Qnkoi0IEnFxmRYOOJepGxJdU/4g0Lq2KKF0J+fg=;
        b=seASopXMBVGAWiPzIOfgFuHnbhOryiVIQdZtWma80HdhPgaK+zDBW6jUINViFWC4Vz
         Qsb80gp72HjhSXfd92Ovl/Bpsu2rPR2CqZE8W9kH0Y2bh2pVnIAPk4S8iYWZ4aUoooLv
         0YjOaSKIJ+wJ22/m+EX8ohJA1Vi/EhQnuGjp71yT4Bj1s8j0kCdiZYxEBSDGnjQOLxxo
         8brtxBQejUwQSaDWdSEpiw+zcXoRGyW7qSHybLY5qi5tBFvfg1Ebw2S+XHSxowg5jUa0
         jcn0UKAp6FufisdquKZVDIgf2paeV1t2rJUVdVpyKJhcDfSRiUtzHZfR4Au6fNs51CUz
         yRHQ==
X-Gm-Message-State: AOJu0YxzQNdQtISVGS8nah0PZTIOtGlr50ei5FcjkScRH9mVDje5xh0m
	lBAgzE20evbg2svZiOn9rVqPI4g0UCHo9aI68oIkYdw90zH1GW94zfsYo4IkcfCyeBc3hAaoSoO
	KZRod9j1DZneDMV5+KoYcF78es1U=
X-Gm-Gg: ASbGncsn7UYr/LLB9z0a8m6yK9nezHz93fa5eMm0DEKiBDtY3rsesjZHvjvZ9Q/jXaS
	vDzHIM5THCSbJBzygKcnCk1nb9FC5aJ7uoZ4ZNCMZGe2zTsQMkXaV750/tRy4IWe6ddsTDD9jnb
	t4jB0RH9Asr+cagAYpYdIlorlupTiDg6U=
X-Google-Smtp-Source: AGHT+IECaCTQAmX94/xYPcoZsht1IputiqIuuTigq7ZfQuM2ZxyuJbEyFzxklBh1D4M75US4HWo354hutEy5OL5N4e8=
X-Received: by 2002:a05:6214:21e7:b0:6d4:2131:563c with SMTP id
 6a1803df08f44-6e243bf62b2mr41943556d6.27.1738150551337; Wed, 29 Jan 2025
 03:35:51 -0800 (PST)
MIME-Version: 1.0
References: <20250129112406.1660522-1-stefan-koch@siemens.com> <20250129112406.1660522-2-stefan-koch@siemens.com>
In-Reply-To: <20250129112406.1660522-2-stefan-koch@siemens.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 29 Jan 2025 12:35:39 +0100
X-Gm-Features: AWEUYZmGvaYUc7LSPOizOtWcj6EWmmTsGkyFDKEYCb5dFOL--B_Y2eVmZiOC9M4
Message-ID: <CANNYZj9K1cCOmT=ZwXu85GYEpD_Z4RKDarJUwTVfZuH-psy1Mw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/3] fetch2/git: Add support for fast
 initial shallow fetch
To: stefan-koch@siemens.com
Cc: bitbake-devel@lists.openembedded.org, simon.sudler@siemens.com, 
	jan.kiszka@siemens.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 Jan 2025 11:35:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17113

This, and the other patches have no tests via bitbake-selftest. Can
you look into adding some?

Alex

On Wed, 29 Jan 2025 at 12:24, Koch, Stefan via lists.openembedded.org
<stefan-koch=siemens.com@lists.openembedded.org> wrote:
>
> When `ud.shallow == 1`:
> - Prefer an initial shallow clone over an initial bare clone,
>   while still utilizing any already existing bare clones.
>
> This improves:
> - Solves timeout issues during initial clones on slow internet connections
>   by reducing the amount of data transferred.
> - Eliminates the need to use a HTTPS tarball SRC_URI
>   to reduce data transfer.
> - Allows SSH-based authentication (e.g. cert and agent-based) when
>   using non-public repos, so additional HTTPS tokens may not be required.
>
> Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
> ---
>  lib/bb/fetch2/git.py | 92 ++++++++++++++++++++++++++++++++++----------
>  1 file changed, 71 insertions(+), 21 deletions(-)
>
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index 6badda597..6d87c2f18 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -366,6 +366,33 @@ class Git(FetchMethod):
>      def tarball_need_update(self, ud):
>          return ud.write_tarballs and not os.path.exists(ud.fullmirror)
>
> +    # Helper method for fetching Git LFS data
> +    def lfs_fetch(self, ud, d, clonedir, revision, progresshandler, fetchall=False):
> +        try:
> +            if self._need_lfs(ud) and self._contains_lfs(ud, d, clonedir) and self._find_git_lfs(d) and len(revision):
> +                # Using worktree with the revision because .lfsconfig may exists
> +                worktree_add_cmd = "%s worktree add wt %s" % (ud.basecmd, revision)
> +                runfetchcmd(worktree_add_cmd, d, log=progresshandler, workdir=clonedir)
> +                lfs_fetch_cmd = "%s lfs fetch %s" % (ud.basecmd, "--all" if fetchall else "")
> +                runfetchcmd(lfs_fetch_cmd, d, log=progresshandler, workdir=(clonedir + "/wt"))
> +                worktree_rem_cmd = "%s worktree remove -f wt" % ud.basecmd
> +                runfetchcmd(worktree_rem_cmd, d, log=progresshandler, workdir=clonedir)
> +        except:
> +            logger.warning("Fetching LFS did not succeed.")
> +
> +    # Create as a temp file and move atomically into position to avoid races
> +    @contextmanager
> +    def create_atomic(self, filename):
> +        fd, tfile = tempfile.mkstemp(dir=os.path.dirname(filename))
> +        try:
> +            yield tfile
> +            umask = os.umask(0o666)
> +            os.umask(umask)
> +            os.chmod(tfile, (0o666 & ~umask))
> +            os.rename(tfile, filename)
> +        finally:
> +            os.close(fd)
> +
>      def try_premirror(self, ud, d):
>          # If we don't do this, updating an existing checkout with only premirrors
>          # is not possible
> @@ -446,7 +473,40 @@ class Git(FetchMethod):
>              if ud.proto.lower() != 'file':
>                  bb.fetch2.check_network_access(d, clone_cmd, ud.url)
>              progresshandler = GitProgressHandler(d)
> -            runfetchcmd(clone_cmd, d, log=progresshandler)
> +
> +            # When ud.shallow is enabled:
> +            # Try creating an initial shallow clone
> +            shallowstate = False
> +            if ud.shallow:
> +                tempdir = tempfile.mkdtemp(dir=d.getVar('DL_DIR'))
> +                shallowclone = os.path.join(tempdir, 'git')
> +                try:
> +                    self.clone_shallow_local(ud, shallowclone, d)
> +                    shallowstate = True
> +                except:
> +                    logger.warning("Creating initial shallow clone failed, try regular clone now.")
> +
> +                # When the shallow clone has succeeded:
> +                # Create shallow tarball
> +                if shallowstate:
> +                    logger.info("Creating tarball of git repository")
> +                    with self.create_atomic(ud.fullshallow) as tfile:
> +                        runfetchcmd("tar -czf %s ." % tfile, d, workdir=shallowclone)
> +                    runfetchcmd("touch %s.done" % ud.fullshallow, d)
> +
> +                # Always cleanup tempdir
> +                bb.utils.remove(tempdir, recurse=True)
> +
> +                # When the shallow clone has succeeded:
> +                # Use shallow tarball
> +                if shallowstate:
> +                    ud.localpath = ud.fullshallow
> +                    return
> +
> +            # When ud.shallow is disabled or the shallow clone failed:
> +            # Create an initial regular clone
> +            if not shallowstate:
> +                runfetchcmd(clone_cmd, d, log=progresshandler)
>
>          # Update the checkout if needed
>          if self.clonedir_need_update(ud, d):
> @@ -509,20 +569,6 @@ class Git(FetchMethod):
>                      runfetchcmd("tar -cf - lfs | tar -xf - -C %s" % ud.clonedir, d, workdir="%s/.git" % ud.destdir)
>
>      def build_mirror_data(self, ud, d):
> -
> -        # Create as a temp file and move atomically into position to avoid races
> -        @contextmanager
> -        def create_atomic(filename):
> -            fd, tfile = tempfile.mkstemp(dir=os.path.dirname(filename))
> -            try:
> -                yield tfile
> -                umask = os.umask(0o666)
> -                os.umask(umask)
> -                os.chmod(tfile, (0o666 & ~umask))
> -                os.rename(tfile, filename)
> -            finally:
> -                os.close(fd)
> -
>          if ud.shallow and ud.write_shallow_tarballs:
>              if not os.path.exists(ud.fullshallow):
>                  if os.path.islink(ud.fullshallow):
> @@ -533,7 +579,7 @@ class Git(FetchMethod):
>                      self.clone_shallow_local(ud, shallowclone, d)
>
>                      logger.info("Creating tarball of git repository")
> -                    with create_atomic(ud.fullshallow) as tfile:
> +                    with self.create_atomic(ud.fullshallow) as tfile:
>                          runfetchcmd("tar -czf %s ." % tfile, d, workdir=shallowclone)
>                      runfetchcmd("touch %s.done" % ud.fullshallow, d)
>                  finally:
> @@ -543,7 +589,7 @@ class Git(FetchMethod):
>                  os.unlink(ud.fullmirror)
>
>              logger.info("Creating tarball of git repository")
> -            with create_atomic(ud.fullmirror) as tfile:
> +            with self.create_atomic(ud.fullmirror) as tfile:
>                  mtime = runfetchcmd("{} log --all -1 --format=%cD".format(ud.basecmd), d,
>                          quiet=True, workdir=ud.clonedir)
>                  runfetchcmd("tar -czf %s --owner oe:0 --group oe:0 --mtime \"%s\" ."
> @@ -557,12 +603,15 @@ class Git(FetchMethod):
>          - For BB_GIT_SHALLOW_REVS: git fetch --shallow-exclude=<revs> rev
>          """
>
> +        progresshandler = GitProgressHandler(d)
> +        repourl = self._get_repo_url(ud)
>          bb.utils.mkdirhier(dest)
>          init_cmd = "%s init -q" % ud.basecmd
>          if ud.bareclone:
>              init_cmd += " --bare"
>          runfetchcmd(init_cmd, d, workdir=dest)
> -        runfetchcmd("%s remote add origin %s" % (ud.basecmd, ud.clonedir), d, workdir=dest)
> +        # Use repourl when creating the initial shallow clone
> +        runfetchcmd("%s remote add origin %s" % (ud.basecmd, shlex.quote(repourl) if ud.shallow and not os.path.exists(ud.clonedir) else ud.clonedir), d, workdir=dest)
>
>          # Check the histories which should be excluded
>          shallow_exclude = ''
> @@ -600,10 +649,12 @@ class Git(FetchMethod):
>              # The ud.clonedir is a local temporary dir, will be removed when
>              # fetch is done, so we can do anything on it.
>              adv_cmd = 'git branch -f advertise-%s %s' % (revision, revision)
> -            runfetchcmd(adv_cmd, d, workdir=ud.clonedir)
> +            if not ud.shallow:
> +                runfetchcmd(adv_cmd, d, workdir=ud.clonedir)
>
> -            runfetchcmd(fetch_cmd, d, workdir=dest)
> +            runfetchcmd(fetch_cmd, d, log=progresshandler, workdir=dest)
>              runfetchcmd("%s update-ref %s %s" % (ud.basecmd, ref, revision), d, workdir=dest)
> +            self.lfs_fetch(ud, d, dest, ud.revisions[ud.names[0]], progresshandler)
>
>          # Apply extra ref wildcards
>          all_refs_remote = runfetchcmd("%s ls-remote origin 'refs/*'" % ud.basecmd, \
> @@ -629,7 +680,6 @@ class Git(FetchMethod):
>              runfetchcmd("%s update-ref %s %s" % (ud.basecmd, ref, revision), d, workdir=dest)
>
>          # The url is local ud.clonedir, set it to upstream one
> -        repourl = self._get_repo_url(ud)
>          runfetchcmd("%s remote set-url origin %s" % (ud.basecmd, shlex.quote(repourl)), d, workdir=dest)
>
>      def unpack(self, ud, destdir, d):
> --
> 2.39.5
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17109): https://lists.openembedded.org/g/bitbake-devel/message/17109
> Mute This Topic: https://lists.openembedded.org/mt/110876221/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

