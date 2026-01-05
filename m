Return-Path: <anibal@limonsoftware.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDDDC79FA7
	for <webhook@archiver.kernel.org>; Mon,  5 Jan 2026 17:20:12 +0000 (UTC)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.69448.1767633611642854040
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 05 Jan 2026 09:20:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@limonsoftware-com.20230601.gappssmtp.com header.s=20230601 header.b=b9RPk3KR;
 spf=pass (domain: limonsoftware.com, ip: 209.85.128.178, mailfrom: anibal@limonsoftware.com)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-79018a412edso2299567b3.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 05 Jan 2026 09:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=limonsoftware-com.20230601.gappssmtp.com; s=20230601; t=1767633611; x=1768238411; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EPgcnIDlJGS7DOXYik1Agxp0HN43BGBDPma53Dg6/nk=;
        b=b9RPk3KRbyS1G5X3GX2BK9onjXJR3z1z/L9DJt4nzRMbph+Q/ICOt5P4Wm19rPg4Ow
         8mS8AlZKrGAbaCF89PcWq2MZsElX1htECeiAtc+79/8CfR2uYvq2rBSPIaUAfAl57sE6
         d2JIDh5C2yY7UCVmJQVnvir584225ZhuqGa1R1dtK//30K4LtajbTdxOpgrEOlsIHUui
         V9WNZ5J8S4MC15SnLcxwniA/ZALubi0NdqSFTL9XhBc6R/BiEXXl11yog6hNuvxj3uDj
         aPkDWOxGQM20huoeUbHa6FnR1Gp/QZu3V4llhsJuNKL96OkG9q9L6hALyxZWvOAGgGgJ
         lDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767633611; x=1768238411;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPgcnIDlJGS7DOXYik1Agxp0HN43BGBDPma53Dg6/nk=;
        b=A9z/WXpP2T5Qj74fG9XUOxWQBYc2oJAVyn3FOaXdFBAvJ95JrFMr/d537e3PsKjNax
         53aTMlpleHObtaGInrWfaAPG4CEjnVufowfVsoQ1qBkpKlEpDlAeb6HsmM8Hv+J2NRAz
         AjyqT80mhpXxT/itulb9Nv2ibgp4YNI0LdEjDlQtt35/tRKBwpuOLR42jO0CNGMF5nLo
         jcPeekFBx5OYabNBLcV1lv3GTc38VRaySh3ii9M61dVIbG81yS5jHuH7i8UUarqrxEEn
         vL4prVmnw30w7ADLezbldtG1FrMAfBKk1OnShvgelq2d44zMPH5L7SWscV82hzoO8//q
         G1Jg==
X-Gm-Message-State: AOJu0YzZbJ45slXIIS+NZy1f6NOqic8ksxBOABwkqvPEP0a7g+DT96sS
	v7aBPgXyZxvajMVfvuElZDqMAAaqzHVyiczW06sin05udmU1B58l+fu40PXfSWsRZslmJIJyHJs
	4F2r+OSVU4T0zg/kYODZU9EqTLt1Zd5FSU02RAUkN+Q==
X-Gm-Gg: AY/fxX6PwByKQikKkcwr2Ccc2y1Lj38eU6snYT37uvv0MNnxKIlBWvxCq5RlyrBepJI
	kjhoE5iVokuzf/uAgYUDAIb5z7ErdWdbfv4/uAFrPF/MfYjiR7Q+L91Q59nnxPr7+U19puSC9HI
	uD/ktI8tTJ9OMWgundR+2YbA8f80aQolVXp6R5e4toL/XY9B1cEtll2u2gVgVdVm8J2wwznyOVP
	QXwdIGWBr1kBYipxtcDuQ/Iz09/oqFHrv1A3Aat1fCZ0vSbfIjpvvuNALopwxO2rhZwQx1bTRMq
	Rd+sYIyHCzrQZ47Z16GwGtr6hgvoUjRRJNxfzKhA6cqf7J8iCM94zyhOUxgIrPWKLGeTyA==
X-Google-Smtp-Source: AGHT+IH4wC2gir2eTSqAOphp7F0OMO3b6BiDm4ar3kkyp2ULD++E1ZSPwFOP0jbBHhRXUuQXLk7Zr/9AubMY6WCKEtg=
X-Received: by 2002:a05:690c:60c6:b0:78f:8f4c:884e with SMTP id
 00721157ae682-790a8a429f8mr2963187b3.21.1767633609566; Mon, 05 Jan 2026
 09:20:09 -0800 (PST)
MIME-Version: 1.0
References: <20260102193438.2960561-1-alex.kanavin@gmail.com> <20260102193438.2960561-10-alex.kanavin@gmail.com>
In-Reply-To: <20260102193438.2960561-10-alex.kanavin@gmail.com>
From: Anibal Limon <anibal@limonsoftware.com>
Date: Mon, 5 Jan 2026 11:19:58 -0600
X-Gm-Features: AQt7F2p1415OH6lVlWvVPJobxkN6cM7o_vj9dHMSFcSLSQcZ4Z7e1nSoTuEFrCk
Message-ID: <CAOU5ZMu-8_9xT1kPC85L=2vRecurdoCKFNTWE0YADiYyJT7Pzw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 10/10] bitbake-setup: correct (and test)
 several scenarios in layer checkout
To: alex.kanavin@gmail.com
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: multipart/alternative; boundary="0000000000006438fe0647a745b9"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 05 Jan 2026 17:20:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18688

--0000000000006438fe0647a745b9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tested the whole series + last patch to fix revisions path and it is
working as expected.

Cheers!,
Anibal

On Fri, Jan 2, 2026 at 1:34=E2=80=AFPM Alexander Kanavin via lists.openembe=
dded.org
<alex.kanavin=3Dgmail.com@lists.openembedded.org> wrote:

> From: Alexander Kanavin <alex@linutronix.de>
>
> There were untested scenarios in layer updates which did not work properl=
y.
>
> The most serious of them is updating a remote layer which had user-made
> local
> modifications (e.g. newly made local commits or simply edited files
> without a commit). Bitbake-setup relies on git fetcher's unpack operation
> which simply wipes it all out. Yes, the user should've used -L option
> to symlink a local clone from elsewhere; this doesn't help when their
> work is gone.
>
> The commit adds a function that checks if such modifications have been
> made, and a code that moves the layer into a backup location if the
> function
> returns true. I considered asking the user what to do (similar to bitbake
> config handling), but this would've resulted in a half-updated, possibly
> broken layer set which ultimately just would be more confusing.
>
> The above check is a part of a broader logic block that handles already
> existing sources, and in particular addresses another issue: when a local
> source replaces a git remote or another local source, this scenario faile=
d
> with 'file exists' errors (thanks to Anibal Limon for spotting that). In
> this case the original symlink or source tree is removed before the new
> one is unpacked from git or symlinked as a local source.
>
> Adjust commit_config() to allow updates with no changes to configs: this
> can
> happen when local modifications to a layer are undone and the original
> layer
> commit is unpacked.
>
> Add tests for all of this: both transitions between remote and local
> sources,
> and ensuring that layer backups do happen when that is expected.
>
> Signed-off-by: Alexander Kanavin <alex@linutronix.de>
> ---
>  bin/bitbake-setup     | 30 ++++++++++++++++++--
>  lib/bb/tests/setup.py | 65 ++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 92 insertions(+), 3 deletions(-)
>
> diff --git a/bin/bitbake-setup b/bin/bitbake-setup
> index 06255b112..58273e4dd 100755
> --- a/bin/bitbake-setup
> +++ b/bin/bitbake-setup
> @@ -81,7 +81,7 @@ def write_sources_fixed_revisions(config_dir, layer_dir=
,
> config_data):
>
>  def commit_config(config_dir):
>      bb.process.run("git -C {} add .".format(config_dir))
> -    bb.process.run("git -C {} commit --no-verify -a -m 'Configuration at
> {}'".format(config_dir, time.asctime()))
> +    bb.process.run("git -C {} commit --allow-empty --no-verify -a -m
> 'Configuration at {}'".format(config_dir, time.asctime()))
>
>  def _write_layer_list(dest, repodirs):
>      layers =3D []
> @@ -117,6 +117,17 @@ def checkout_layers(layers, layerdir, d):
>          logger.plain("Making a symbolic link {} pointing to
> {}".format(dst, src))
>          os.symlink(src, dst)
>
> +    def _has_local_modifications(r_name, r_path):
> +        fixed_revisions =3D json.load(open(os.path.join(layerdir,
> "sources-fixed-revisions.json")))
> +        rev =3D fixed_revisions['sources'][r_name]['git-remote']['rev']
> +        status =3D bb.process.run('git -C {} status
> --porcelain'.format(r_path))[0]
> +        if status:
> +            return True
> +        diff =3D bb.process.run('git -C {} diff {}'.format(r_path, rev))=
[0]
> +        if diff:
> +            return True
> +        return False
> +
>      layers_fixed_revisions =3D copy.deepcopy(layers)
>      repodirs =3D []
>      oesetupbuild =3D None
> @@ -130,10 +141,25 @@ def checkout_layers(layers, layerdir, d):
>          r_local =3D r_data.get('local')
>          if r_remote and r_local:
>              raise Exception("Source {} contains both git-remote and loca=
l
> properties.".format(r_name))
> +
> +        repodir_path =3D os.path.join(layerdir, repodir)
> +        if os.path.lexists(repodir_path):
> +            if os.path.islink(repodir_path):
> +                os.remove(repodir_path)
> +            elif _has_local_modifications(r_name, repodir_path):
> +                timestamp =3D time.strftime("%Y%m%d%H%M%S")
> +                backup_path =3D repodir_path +
> '-backup.{}'.format(timestamp)
> +                logger.warning("""Source {} in {} contains local
> modifications. Renaming to {} to preserve them.
> +For local development work it is recommended to clone the needed layers
> separately and use 'bitbake-setup init' with -L option to use
> them.""".format(
> +                    r_name, repodir_path, backup_path))
> +                os.rename(repodir_path, backup_path)
> +            else:
> +                shutil.rmtree(repodir_path)
> +
>          if r_remote:
>              _checkout_git_remote(r_remote, repodir,
> layers_fixed_revisions)
>          if r_local:
> -            _symlink_local(os.path.expanduser(r_local["path"]),
> os.path.join(layerdir,repodir))
> +            _symlink_local(os.path.expanduser(r_local["path"]),
> repodir_path)
>
>          if os.path.exists(os.path.join(layerdir, repodir,
> 'scripts/oe-setup-build')):
>              oesetupbuild =3D os.path.join(layerdir, repodir,
> 'scripts/oe-setup-build')
> diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
> index 438dc0cd8..5ff489cbe 100644
> --- a/lib/bb/tests/setup.py
> +++ b/lib/bb/tests/setup.py
> @@ -175,6 +175,16 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
>  """ % (self.testrepopath, branch, rev)
>          return self._add_json_config_to_registry_helper(name, sources)
>
> +    def add_local_json_config_to_registry(self, name, path):
> +        sources =3D """
> +        "test-repo": {
> +            "local": {
> +                "path": "%s"
> +            }
> +        }
> +""" % (path)
> +        return self._add_json_config_to_registry_helper(name, sources)
> +
>      def add_file_to_testrepo(self, name, content, script=3DFalse):
>          fullname =3D os.path.join(self.testrepopath, name)
>          os.makedirs(os.path.join(self.testrepopath,
> os.path.dirname(name)), exist_ok=3DTrue)
> @@ -413,7 +423,6 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
>              sums_after =3D _conf_chksum(f"{setuppath}/build/conf")
>              self.assertEqual(sums_before, sums_after)
>
> -        # check source overrides, local sources provided with symlinks,
> and custom setup dir name
>          def _check_local_sources(custom_setup_dir):
>              custom_setup_path =3D os.path.join(self.tempdir,
> 'bitbake-builds', custom_setup_dir)
>              custom_layer_path =3D os.path.join(custom_setup_path, 'layer=
s',
> 'test-repo')
> @@ -421,6 +430,60 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
>              self.assertEqual(self.testrepopath,
> os.path.realpath(custom_layer_path))
>              self.config_is_unchanged(custom_setup_path)
>
> +        # Change the configuration to refer to a local source, then to
> another local source, then back to a git remote
> +        # Run status/update after each change and verify that nothing
> breaks
> +        c =3D 'gadget'
> +        setuppath =3D self.get_setup_path('test-config-1', c)
> +        self.config_is_unchanged(setuppath)
> +
> +        json_1 =3D
> self.add_local_json_config_to_registry('test-config-1.conf.json',
> self.testrepopath)
> +        os.environ['BBPATH'] =3D os.path.join(setuppath, 'build')
> +        out =3D self.runbbsetup("update --update-bb-conf=3D'yes'")
> +        _check_local_sources(setuppath)
> +
> +        prev_path =3D self.testrepopath
> +        self.testrepopath =3D prev_path + "-2"
> +        self.git("clone {} {}".format(prev_path, self.testrepopath),
> cwd=3Dself.tempdir)
> +        json_1 =3D
> self.add_local_json_config_to_registry('test-config-1.conf.json',
> self.testrepopath)
> +        os.environ['BBPATH'] =3D os.path.join(setuppath, 'build')
> +        out =3D self.runbbsetup("update --update-bb-conf=3D'yes'")
> +        _check_local_sources(setuppath)
> +
> +        self.testrepopath =3D prev_path
> +        json_1 =3D
> self.add_json_config_to_registry('test-config-1.conf.json', branch, branc=
h)
> +        os.environ['BBPATH'] =3D os.path.join(setuppath, 'build')
> +        out =3D self.runbbsetup("update --update-bb-conf=3D'yes'")
> +        self.check_setupdir_files(setuppath, test_file_content)
> +
> +        # Also check that there are no layer backups up to this point,
> then make a change that should
> +        # result in a layer backup, and check that it does happen.
> +        def _check_layer_backups(layer_path, expected_backups):
> +            files =3D os.listdir(layer_path)
> +            backups =3D len([f for f in files if 'backup' in f])
> +            self.assertEqual(backups, expected_backups, msg =3D "Expecte=
d
> {} layer backups, got {}, directory listing: {}".format(expected_backups,
> backups, files))
> +
> +        layers_path =3D os.path.join(setuppath, 'layers')
> +        layer_path =3D os.path.join(layers_path, 'test-repo')
> +        _check_layer_backups(layers_path, 0)
> +
> +        ## edit a file without making a commit
> +        with open(os.path.join(layer_path, 'local-modification'), 'w') a=
s
> f:
> +            f.write('locally-modified\n')
> +        test_file_content =3D "modified-again\n"
> +        self.add_file_to_testrepo('test-file', test_file_content)
> +        os.environ['BBPATH'] =3D os.path.join(setuppath, 'build')
> +        out =3D self.runbbsetup("update --update-bb-conf=3D'yes'")
> +        _check_layer_backups(layers_path, 1)
> +
> +        ## edit a file and make a commit
> +        with open(os.path.join(layer_path, 'local-modification'), 'w') a=
s
> f:
> +            f.write('locally-modified-again\n')
> +        self.git('add .', cwd=3Dlayer_path)
> +        self.git('commit -m "Adding a local modification"',
> cwd=3Dlayer_path)
> +        out =3D self.runbbsetup("update --update-bb-conf=3D'yes'")
> +        _check_layer_backups(layers_path, 2)
> +
> +        # check source overrides, local sources provided with symlinks,
> and custom setup dir name
>          source_override_content =3D """
>  {
>      "sources": {
> --
> 2.47.3
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18680):
> https://lists.openembedded.org/g/bitbake-devel/message/18680
> Mute This Topic: https://lists.openembedded.org/mt/117046550/8181911
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> anibal@limonsoftware.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--0000000000006438fe0647a745b9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I tested the whole series=C2=A0+ last patch to fix revisio=
ns path and it is working as=C2=A0expected.<div><br></div><div>Cheers!,</di=
v><div>Anibal</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cl=
ass=3D"gmail_attr">On Fri, Jan 2, 2026 at 1:34=E2=80=AFPM Alexander Kanavin=
 via <a href=3D"http://lists.openembedded.org" target=3D"_blank">lists.open=
embedded.org</a> &lt;alex.kanavin=3D<a href=3D"mailto:gmail.com@lists.opene=
mbedded.org" target=3D"_blank">gmail.com@lists.openembedded.org</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: Alexan=
der Kanavin &lt;<a href=3D"mailto:alex@linutronix.de" target=3D"_blank">ale=
x@linutronix.de</a>&gt;<br>
<br>
There were untested scenarios in layer updates which did not work properly.=
<br>
<br>
The most serious of them is updating a remote layer which had user-made loc=
al<br>
modifications (e.g. newly made local commits or simply edited files<br>
without a commit). Bitbake-setup relies on git fetcher&#39;s unpack operati=
on<br>
which simply wipes it all out. Yes, the user should&#39;ve used -L option<b=
r>
to symlink a local clone from elsewhere; this doesn&#39;t help when their<b=
r>
work is gone.<br>
<br>
The commit adds a function that checks if such modifications have been<br>
made, and a code that moves the layer into a backup location if the functio=
n<br>
returns true. I considered asking the user what to do (similar to bitbake<b=
r>
config handling), but this would&#39;ve resulted in a half-updated, possibl=
y<br>
broken layer set which ultimately just would be more confusing.<br>
<br>
The above check is a part of a broader logic block that handles already<br>
existing sources, and in particular addresses another issue: when a local<b=
r>
source replaces a git remote or another local source, this scenario failed<=
br>
with &#39;file exists&#39; errors (thanks to Anibal Limon for spotting that=
). In<br>
this case the original symlink or source tree is removed before the new<br>
one is unpacked from git or symlinked as a local source.<br>
<br>
Adjust commit_config() to allow updates with no changes to configs: this ca=
n<br>
happen when local modifications to a layer are undone and the original laye=
r<br>
commit is unpacked.<br>
<br>
Add tests for all of this: both transitions between remote and local source=
s,<br>
and ensuring that layer backups do happen when that is expected.<br>
<br>
Signed-off-by: Alexander Kanavin &lt;<a href=3D"mailto:alex@linutronix.de" =
target=3D"_blank">alex@linutronix.de</a>&gt;<br>
---<br>
=C2=A0bin/bitbake-setup=C2=A0 =C2=A0 =C2=A0| 30 ++++++++++++++++++--<br>
=C2=A0lib/bb/tests/setup.py | 65 ++++++++++++++++++++++++++++++++++++++++++=
-<br>
=C2=A02 files changed, 92 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/bin/bitbake-setup b/bin/bitbake-setup<br>
index 06255b112..58273e4dd 100755<br>
--- a/bin/bitbake-setup<br>
+++ b/bin/bitbake-setup<br>
@@ -81,7 +81,7 @@ def write_sources_fixed_revisions(config_dir, layer_dir, =
config_data):<br>
<br>
=C2=A0def commit_config(config_dir):<br>
=C2=A0 =C2=A0 =C2=A0bb.process.run(&quot;git -C {} add .&quot;.format(confi=
g_dir))<br>
-=C2=A0 =C2=A0 bb.process.run(&quot;git -C {} commit --no-verify -a -m &#39=
;Configuration at {}&#39;&quot;.format(config_dir, time.asctime()))<br>
+=C2=A0 =C2=A0 bb.process.run(&quot;git -C {} commit --allow-empty --no-ver=
ify -a -m &#39;Configuration at {}&#39;&quot;.format(config_dir, time.ascti=
me()))<br>
<br>
=C2=A0def _write_layer_list(dest, repodirs):<br>
=C2=A0 =C2=A0 =C2=A0layers =3D []<br>
@@ -117,6 +117,17 @@ def checkout_layers(layers, layerdir, d):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger.plain(&quot;Making a symbolic link=
 {} pointing to {}&quot;.format(dst, src))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0os.symlink(src, dst)<br>
<br>
+=C2=A0 =C2=A0 def _has_local_modifications(r_name, r_path):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fixed_revisions =3D json.load(open(os.path.joi=
n(layerdir, &quot;sources-fixed-revisions.json&quot;)))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rev =3D fixed_revisions[&#39;sources&#39;][r_n=
ame][&#39;git-remote&#39;][&#39;rev&#39;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D bb.process.run(&#39;git -C {} statu=
s --porcelain&#39;.format(r_path))[0]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if status:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return True<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 diff =3D bb.process.run(&#39;git -C {} diff {}=
&#39;.format(r_path, rev))[0]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if diff:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return True<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return False<br>
+<br>
=C2=A0 =C2=A0 =C2=A0layers_fixed_revisions =3D copy.deepcopy(layers)<br>
=C2=A0 =C2=A0 =C2=A0repodirs =3D []<br>
=C2=A0 =C2=A0 =C2=A0oesetupbuild =3D None<br>
@@ -130,10 +141,25 @@ def checkout_layers(layers, layerdir, d):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r_local =3D r_data.get(&#39;local&#39;)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if r_remote and r_local:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Exception(&quot;Sourc=
e {} contains both git-remote and local properties.&quot;.format(r_name))<b=
r>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 repodir_path =3D os.path.join(layerdir, repodi=
r)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if os.path.lexists(repodir_path):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if os.path.islink(repodir_path):=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.remove(repodir_=
path)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif _has_local_modifications(r_=
name, repodir_path):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 timestamp =3D time=
.strftime(&quot;%Y%m%d%H%M%S&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 backup_path =3D re=
podir_path + &#39;-backup.{}&#39;.format(timestamp)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 logger.warning(&qu=
ot;&quot;&quot;Source {} in {} contains local modifications. Renaming to {}=
 to preserve them.<br>
+For local development work it is recommended to clone the needed layers se=
parately and use &#39;bitbake-setup init&#39; with -L option to use them.&q=
uot;&quot;&quot;.format(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r_na=
me, repodir_path, backup_path))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.rename(repodir_=
path, backup_path)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 shutil.rmtree(repo=
dir_path)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if r_remote:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0_checkout_git_remote(r_remo=
te, repodir, layers_fixed_revisions)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if r_local:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _symlink_local(os.path.expanduse=
r(r_local[&quot;path&quot;]), os.path.join(layerdir,repodir))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _symlink_local(os.path.expanduse=
r(r_local[&quot;path&quot;]), repodir_path)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if os.path.exists(os.path.join(layerdir, =
repodir, &#39;scripts/oe-setup-build&#39;)):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0oesetupbuild =3D os.path.jo=
in(layerdir, repodir, &#39;scripts/oe-setup-build&#39;)<br>
diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py<br>
index 438dc0cd8..5ff489cbe 100644<br>
--- a/lib/bb/tests/setup.py<br>
+++ b/lib/bb/tests/setup.py<br>
@@ -175,6 +175,16 @@ print(&quot;BBPATH is {{}}&quot;.format(os.environ[&qu=
ot;BBPATH&quot;]))<br>
=C2=A0&quot;&quot;&quot; % (self.testrepopath, branch, rev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return self._add_json_config_to_registry_=
helper(name, sources)<br>
<br>
+=C2=A0 =C2=A0 def add_local_json_config_to_registry(self, name, path):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sources =3D &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;test-repo&quot;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;local&quot;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;path&quot;: =
&quot;%s&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+&quot;&quot;&quot; % (path)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self._add_json_config_to_registry_helpe=
r(name, sources)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0def add_file_to_testrepo(self, name, content, script=3D=
False):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fullname =3D os.path.join(self.testrepopa=
th, name)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0os.makedirs(os.path.join(self.testrepopat=
h, os.path.dirname(name)), exist_ok=3DTrue)<br>
@@ -413,7 +423,6 @@ print(&quot;BBPATH is {{}}&quot;.format(os.environ[&quo=
t;BBPATH&quot;]))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sums_after =3D _conf_chksum=
(f&quot;{setuppath}/build/conf&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertEqual(sums_befor=
e, sums_after)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 # check source overrides, local sources provid=
ed with symlinks, and custom setup dir name<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0def _check_local_sources(custom_setup_dir=
):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0custom_setup_path =3D os.pa=
th.join(self.tempdir, &#39;bitbake-builds&#39;, custom_setup_dir)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0custom_layer_path =3D os.pa=
th.join(custom_setup_path, &#39;layers&#39;, &#39;test-repo&#39;)<br>
@@ -421,6 +430,60 @@ print(&quot;BBPATH is {{}}&quot;.format(os.environ[&qu=
ot;BBPATH&quot;]))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertEqual(self.testr=
epopath, os.path.realpath(custom_layer_path))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.config_is_unchanged(cu=
stom_setup_path)<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Change the configuration to refer to a local=
 source, then to another local source, then back to a git remote<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Run status/update after each change and veri=
fy that nothing breaks<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 c =3D &#39;gadget&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 setuppath =3D self.get_setup_path(&#39;test-co=
nfig-1&#39;, c)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.config_is_unchanged(setuppath)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 json_1 =3D self.add_local_json_config_to_regis=
try(&#39;test-config-1.conf.json&#39;, self.testrepopath)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 os.environ[&#39;BBPATH&#39;] =3D os.path.join(=
setuppath, &#39;build&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 out =3D self.runbbsetup(&quot;update --update-=
bb-conf=3D&#39;yes&#39;&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 _check_local_sources(setuppath)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 prev_path =3D self.testrepopath<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.testrepopath =3D prev_path + &quot;-2&quo=
t;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.git(&quot;clone {} {}&quot;.format(prev_p=
ath, self.testrepopath), cwd=3Dself.tempdir)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 json_1 =3D self.add_local_json_config_to_regis=
try(&#39;test-config-1.conf.json&#39;, self.testrepopath)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 os.environ[&#39;BBPATH&#39;] =3D os.path.join(=
setuppath, &#39;build&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 out =3D self.runbbsetup(&quot;update --update-=
bb-conf=3D&#39;yes&#39;&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 _check_local_sources(setuppath)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.testrepopath =3D prev_path<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 json_1 =3D self.add_json_config_to_registry(&#=
39;test-config-1.conf.json&#39;, branch, branch)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 os.environ[&#39;BBPATH&#39;] =3D os.path.join(=
setuppath, &#39;build&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 out =3D self.runbbsetup(&quot;update --update-=
bb-conf=3D&#39;yes&#39;&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.check_setupdir_files(setuppath, test_file=
_content)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Also check that there are no layer backups u=
p to this point, then make a change that should<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # result in a layer backup, and check that it =
does happen.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 def _check_layer_backups(layer_path, expected_=
backups):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 files =3D os.listdir(layer_path)=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 backups =3D len([f for f in file=
s if &#39;backup&#39; in f])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(backups, expect=
ed_backups, msg =3D &quot;Expected {} layer backups, got {}, directory list=
ing: {}&quot;.format(expected_backups, backups, files))<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 layers_path =3D os.path.join(setuppath, &#39;l=
ayers&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 layer_path =3D os.path.join(layers_path, &#39;=
test-repo&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 _check_layer_backups(layers_path, 0)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ## edit a file without making a commit<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with open(os.path.join(layer_path, &#39;local-=
modification&#39;), &#39;w&#39;) as f:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f.write(&#39;locally-modified\n&=
#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 test_file_content =3D &quot;modified-again\n&q=
uot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.add_file_to_testrepo(&#39;test-file&#39;,=
 test_file_content)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 os.environ[&#39;BBPATH&#39;] =3D os.path.join(=
setuppath, &#39;build&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 out =3D self.runbbsetup(&quot;update --update-=
bb-conf=3D&#39;yes&#39;&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 _check_layer_backups(layers_path, 1)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ## edit a file and make a commit<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with open(os.path.join(layer_path, &#39;local-=
modification&#39;), &#39;w&#39;) as f:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f.write(&#39;locally-modified-ag=
ain\n&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.git(&#39;add .&#39;, cwd=3Dlayer_path)<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.git(&#39;commit -m &quot;Adding a local m=
odification&quot;&#39;, cwd=3Dlayer_path)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 out =3D self.runbbsetup(&quot;update --update-=
bb-conf=3D&#39;yes&#39;&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 _check_layer_backups(layers_path, 2)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # check source overrides, local sources provid=
ed with symlinks, and custom setup dir name<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0source_override_content =3D &quot;&quot;&=
quot;<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0&quot;sources&quot;: {<br>
-- <br>
2.47.3<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#18680): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/18680" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/18680</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/117046550/818=
1911" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/117046550/8181911</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:anibal@limonsoftware.com" target=
=3D"_blank">anibal@limonsoftware.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--0000000000006438fe0647a745b9--

