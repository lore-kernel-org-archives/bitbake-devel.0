Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDB5CD6E52
	for <webhook@archiver.kernel.org>; Fri, 29 May 2026 15:57:10 +0000 (UTC)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13756.1780070219946947002
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 29 May 2026 08:57:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=YhDkSQzN;
 spf=pass (domain: gmail.com, ip: 209.85.219.47, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8be236ce888so135497796d6.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 29 May 2026 08:56:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780070219; cv=none;
        d=google.com; s=arc-20240605;
        b=EG0mKM/783lm6LXB63f7jUnOs3luFT8EyCwJAetRLkrKFUjSFKG83SkEdS1kU9+i8R
         Z6kmPQ+yhORcSlBGHCnczMaCHh/BbbcN2foMUDfWeQQ2BtJmhuNJOQetk7V2quDOH1Ac
         VjZnbgSh+cHMRqZ0keQ6AxPyc/mTuKFRUJj4DVwltgwzhQhLTfEv7SO8NJ43ARI6rYvv
         NKnycjH3I0z1tgoylncXTmdlrHdAh7QXD5idBWIhmVYfqty4aHxghdwpfRVuFH3tlkkM
         y6Ev07rI2dmjARvctEFVW12dRbIn0NEpT2QaieJEj6WQGlHHuBW6M+09ehGbMCBi6vmO
         +bQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VciANqPdpBByu2GnhECnwhC7rvOzhNhbRVS4dRNZO24=;
        fh=GWExUfJR88oeVCRfRxKHLPc/xMpLE0KqWIH3LUJXQUs=;
        b=E6kFmp7qaumhQ5lb5t5LcfUbSILNKkER5gU6tzD9CBWWfX6yZgwzsR2t3LG4K1qZTj
         c6VNqcrYADsmBZIg8PBFTdSPYv+jYKP/2+DHHCmT0MwHWZ/zgw+gF0VosPStN+GDdxC4
         opsuVBdn/1mR07b8ymbYd3j20k9zoJn/b8BUwcoixZLM+iq9oR5KaHgm/vRukWvxlPEq
         6CdrZgJHH38BW7Klp1H//zT7CIGLUpWWnFE2dHLEWN05ibqiBcdQVn0ccZXFxkNd1vTK
         MOwyH0zsUfOzuZ/+UL19ECw1ILjmSvC2FvZRsg2+50MLlXj8vbvATlczThsq3NXGCRRM
         TxCA==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780070219; x=1780675019; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VciANqPdpBByu2GnhECnwhC7rvOzhNhbRVS4dRNZO24=;
        b=YhDkSQzNFJVBQh2BOOuVqtEoFClEM9C7lRV2sCnaIDY9STNW5hnrapIaP9KdEfbn7o
         AehDx4MY6GIRXwXgRD4ASBLmewCru221khum4wDkCyWljtCi8klMfT+n3gHGJfreI7qr
         YCddOiILwCjcJo4LqDC1kvbm4u7YXHAdTzd/NP6BBiUeP2lvnkbDmoXzLlNjaWE7sFYM
         +W9He9Gowt6qATo3jYK967WQN5SstPRubLa4RZWfXtGR2dgWBUEwhuh8WsbIDHEQmhC0
         /cCO+LsaACb7n22mCu8nG+OWgusBGpAuebLY4cJKZ2JAwO3RbgW0E0idrsVgJLDRJnBS
         K7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780070219; x=1780675019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VciANqPdpBByu2GnhECnwhC7rvOzhNhbRVS4dRNZO24=;
        b=dPEMOeOhmnA80eFiNk6EBOFx7rIrqMt1RfRaTUvjd0b0TgQeyU3VViNtNaoE/YTV5j
         fbFYIRWG/H0SahtNmJw62+DCsamNHjYC+5ZxSAw4zrgaAXuV7ydlvt19n0/xHXF5DZSW
         42G2LxlBM3WOwTTiVj1mOEKthBE5NEiLJu7KJQGJCtDpNjVWyVbAIPmUjV+u3IG+fSLt
         lxEz7WwIr/gqpPedDFucWqHlojNTpangczSPsoMzXfvWzowklhcRnX3mymNo6Ag/8Gwt
         H9H2ra1/4vqzu5GdFWHx3+KEaRPt8rON3BsaiGxWAiZdGZUVk7L0YyIFUXLDwpEgGfqJ
         jETw==
X-Gm-Message-State: AOJu0YwoRaGubdXVmk0PbBdSAu58qEjIBY4mvpUjzZwp/B4TDXfeM2hz
	4CSUZSGOcfpn6jZ9cMRj5MF729DMyetQg+hC9Z7b2yOTHFiMXLIM2842ezFuUBUZMdmpB66qtMi
	zkLcwlmZDaMo+7RK+2Fl4MUat1EoynyE=
X-Gm-Gg: Acq92OFuMHTi/uuLO1mm1Wov3RhiqokYFdoK9fxIOxYp8xf+Q85R+7NCT3oXTFq3dAN
	DN9LlMVnHY2SMDlLIVxaxQzV6lrmi0Q01/Yc89CDC1q34takv+TCkoctixMaMVgQi3H5J4Of4wY
	3qiRYPxpKeJ+yFhUThy4eQCti9pF9MMHUtEYSPp05Q4KT4tLw1Iz3ohHdUeQu5VKajAPpwjebGb
	cKysD/WCsF8r4JMQUyPkfI19K7z1wnGDwpGkIb5HwbALTv0GRqah/cySE3KqiinpfvYwbDjE114
	q+HkMZg9Kj+3kVRwXPbBXIQIYuS4egtwIA3Qe+0lEL+qTousrT6MjpqHrzhQKMc=
X-Received: by 2002:ad4:4eec:0:b0:8ac:732b:6cf1 with SMTP id
 6a1803df08f44-8ccefd8d65bmr4402956d6.24.1780070218719; Fri, 29 May 2026
 08:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260529-bb-setup-override-improvements-v1-0-91db62e0149e@toradex.com>
 <20260529-bb-setup-override-improvements-v1-2-91db62e0149e@toradex.com>
In-Reply-To: <20260529-bb-setup-override-improvements-v1-2-91db62e0149e@toradex.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 29 May 2026 17:56:46 +0200
X-Gm-Features: AVHnY4KS1ejZanc4K37cD0dP9ujaws786C-bsjU5455aX7HXciwkoJ6pLf-sUNM
Message-ID: <CANNYZj9FxhgKEfBu0M=1o7pc3RYZ67XdcpOyr5dEKTpmTAWYYg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 2/2] bitbake-setup: support default source overrides
To: ernestvanhoecke@gmail.com
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>, docs@lists.yoctoproject.org, 
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 29 May 2026 15:57:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19566

On Fri, 29 May 2026 at 16:52, Ernest Van Hoecke via
lists.openembedded.org
<ernestvanhoecke=3Dgmail.com@lists.openembedded.org> wrote:
> Allow a BitBake configuration to list source override files to apply by
> default when that configuration is selected. This allows specifying
> source-overrides files (such as fixed revisions) that live in a remote
> registry, which is not possible with the CLI argument
> '--source-overrides'.

I'm not sure I like the idea. One of the design goals was that a
configuration file is self-contained, and adding references to other
files greatly complicates the logic (e.g. I can't figure out from
reading the changes if 'update' and 'status' operations will still
work properly, probably they won't, as the tests don't check updates
to the default overrides, or going from using default overrides to not
using them), and decreases readability.

Is the issue that you'd like to avoid having multiple files for tagged
releases, with largely same configuration content, and different
source revisions? I'd like to understand the use case first.

Alex



> Relative override paths resolve against the configuration file,
> including files loaded from a fetched registry checkout. Default
> overrides are applied before command-line source overrides.
>
> For "config-upstream", keep "source-overrides" as the persisted
> command-line override data so existing setups retain their meaning.
> Store loaded defaults in "default-source-overrides" and merge them only
> when applying sources.
>
> Extend the setup selftest to cover a registry-provided default override
> file.
>
> Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> ---
>  bin/bitbake-setup                                  | 41 ++++++++++++++++=
------
>  .../bitbake-user-manual-environment-setup.rst      | 13 +++++++
>  lib/bb/tests/setup.py                              | 33 ++++++++++++----=
-
>  setup-schema/bitbake-setup.schema.json             |  7 ++++
>  4 files changed, 75 insertions(+), 19 deletions(-)
>
> diff --git a/bin/bitbake-setup b/bin/bitbake-setup
> index 2e234cccaba9..e032e1cd3a1e 100755
> --- a/bin/bitbake-setup
> +++ b/bin/bitbake-setup
> @@ -458,8 +458,13 @@ def merge_overrides_into_sources(sources, overrides)=
:
>              layers[k] =3D v
>      return layers
>
> +def effective_source_overrides(config):
> +    overrides =3D copy.deepcopy(config.get("default-source-overrides", {=
'sources':{}}))
> +    overrides["sources"].update(config["source-overrides"]["sources"])
> +    return overrides
> +
>  def update_build(config, confdir, setupdir, layerdir, d, update_bb_conf=
=3D"prompt", init_vscode=3DFalse, rebase_conflicts_strategy=3D'abort'):
> -    layer_config =3D merge_overrides_into_sources(config["data"]["source=
s"], config["source-overrides"]["sources"])
> +    layer_config =3D merge_overrides_into_sources(config["data"]["source=
s"], effective_source_overrides(config)["sources"])
>      sources_fixed_revisions =3D checkout_layers(layer_config, confdir, l=
ayerdir, d, rebase_conflicts_strategy=3Drebase_conflicts_strategy)
>      bitbake_config =3D config["bitbake-config"]
>      thisdir =3D os.path.dirname(config["path"]) if config["type"] =3D=3D=
 'local' else None
> @@ -591,11 +596,13 @@ def choose_fragments(possibilities, parameters, non=
_interactive, skip_selection)
>      return choices
>
>  def obtain_config(top_dir, registry, args, source_overrides, d):
> +    config_dir =3D None
>      if args.config:
>          config_id =3D args.config[0]
>          config_parameters =3D args.config[1:]
>          if os.path.exists(config_id):
>              config_id =3D os.path.abspath(config_id)
> +            config_dir =3D os.path.dirname(config_id)
>              logger.info("Reading configuration from local file\n    {}".=
format(config_id))
>              upstream_config =3D {'type':'local',
>                                 'path':config_id,
> @@ -617,7 +624,9 @@ def obtain_config(top_dir, registry, args, source_ove=
rrides, d):
>              registry_configs =3D list_registry(registry_path, with_expir=
ed=3DTrue)
>              if config_id not in registry_configs:
>                  raise Exception("Config {} not found in configuration re=
gistry, re-run 'init' without parameters to choose from available configura=
tions.".format(config_id))
> -            upstream_config =3D {'type':'registry','registry':registry,'=
name':config_id,'data':json.load(open(get_registry_config(registry_path,con=
fig_id)))}
> +            config_path =3D get_registry_config(registry_path,config_id)
> +            config_dir =3D os.path.dirname(config_path)
> +            upstream_config =3D {'type':'registry','registry':registry,'=
name':config_id,'data':json.load(open(config_path))}
>          expiry_date =3D upstream_config['data'].get("expires", None)
>          if has_expired(expiry_date):
>              logger.warning("This configuration is no longer supported af=
ter {}. Please consider changing to a supported configuration.".format(expi=
ry_date))
> @@ -626,18 +635,26 @@ def obtain_config(top_dir, registry, args, source_o=
verrides, d):
>          registry_configs =3D list_registry(registry_path, with_expired=
=3DTrue)
>          config_id =3D choose_config(registry_configs, args.non_interacti=
ve)
>          config_parameters =3D []
> -        upstream_config =3D {'type':'registry','registry':registry,'name=
':config_id,'data':json.load(open(get_registry_config(registry_path,config_=
id)))}
> +        config_path =3D get_registry_config(registry_path,config_id)
> +        config_dir =3D os.path.dirname(config_path)
> +        upstream_config =3D {'type':'registry','registry':registry,'name=
':config_id,'data':json.load(open(config_path))}
>
>      upstream_config['bitbake-config'] =3D choose_bitbake_config(upstream=
_config['data']['bitbake-setup']['configurations'], config_parameters, args=
.non_interactive)
>      upstream_config['bitbake-config']['oe-fragment-choices'] =3D choose_=
fragments(upstream_config['bitbake-config'].get('oe-fragments-one-of',{}), =
config_parameters[1:], args.non_interactive, args.skip_selection)
>      upstream_config['non-interactive-cmdline-options'] =3D [config_id, u=
pstream_config['bitbake-config']['name']] + sorted(upstream_config['bitbake=
-config']['oe-fragment-choices'].values())
> -    upstream_config['source-overrides'] =3D source_overrides
>      upstream_config['skip-selection'] =3D args.skip_selection
> +    default_source_overrides =3D upstream_config['bitbake-config'].get('=
default-source-overrides')
> +    if default_source_overrides and not config_dir:
> +        raise Exception("default-source-overrides can only be used with =
configuration templates from a registry or a local file.")
> +    upstream_config['default-source-overrides'] =3D read_source_override=
s(default_source_overrides, base_dir=3Dconfig_dir)
> +    upstream_config['source-overrides'] =3D source_overrides
>      return upstream_config
>
> -def obtain_overrides(args):
> +def read_source_overrides(source_override_files, base_dir=3DNone):
>      all_overrides =3D {'sources':{}}
> -    for overrides_file in args.source_overrides or []:
> +    for overrides_file in source_override_files or []:
> +        if base_dir and not os.path.isabs(overrides_file):
> +            overrides_file =3D os.path.join(base_dir, overrides_file)
>          overrides =3D json.load(open(overrides_file))
>          overrides_dir =3D os.path.dirname(os.path.abspath(overrides_file=
))
>          for s,v in overrides['sources'].items():
> @@ -647,11 +664,13 @@ def obtain_overrides(args):
>                  if not os.path.isabs(path):
>                      v['local']['path'] =3D os.path.join(overrides_dir, p=
ath)
>              all_overrides['sources'][s] =3D v
> +    return all_overrides
>
> +def obtain_cli_overrides(args):
> +    overrides =3D read_source_overrides(args.source_overrides)
>      for local_name, local_path in args.use_local_source:
> -        all_overrides['sources'][local_name] =3D {'local':{'path':os.pat=
h.abspath(os.path.expanduser(local_path))}}
> -
> -    return all_overrides
> +        overrides['sources'][local_name] =3D {'local':{'path':os.path.ab=
spath(os.path.expanduser(local_path))}}
> +    return overrides
>
>  def configure_vscode(setupdir, layerdir, builddir, init_script):
>      """
> @@ -811,7 +830,7 @@ def init_config(top_dir, settings, args):
>          logger.plain("{}% {}                ".format(progress, rate))
>          logger.handlers[0].terminator =3D '\n'
>
> -    source_overrides =3D obtain_overrides(args)
> +    source_overrides =3D obtain_cli_overrides(args)
>      upstream_config =3D obtain_config(top_dir, settings["default"]["regi=
stry"], args, source_overrides, d)
>      logger.info("Run 'bitbake-setup init --non-interactive {}' to select=
 this configuration non-interactively.\n".format(" ".join(upstream_config['=
non-interactive-cmdline-options'])))
>
> @@ -949,7 +968,7 @@ def build_status(top_dir, settings, args, d, update=
=3DFalse):
>              bb.process.run('git -C {} restore config-upstream.json'.form=
at(confdir))
>          return
>
> -    layer_config =3D merge_overrides_into_sources(current_upstream_confi=
g["data"]["sources"], current_upstream_config["source-overrides"]["sources"=
])
> +    layer_config =3D merge_overrides_into_sources(current_upstream_confi=
g["data"]["sources"], effective_source_overrides(current_upstream_config)["=
sources"])
>      if are_layers_changed(layer_config, layerdir, d):
>          if update:
>              update_build(current_upstream_config, confdir, setupdir, lay=
erdir,
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setu=
p.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> index 77fc4c3dcba0..b30ebe8aeaeb 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> @@ -1141,6 +1141,12 @@ They contain the following sections:
>        See https://docs.yoctoproject.org/dev/ref-manual/fragments.html fo=
r
>        more information of OpenEmbedded configuration fragments.
>
> +   -  ``default-source-overrides`` (*optional*): a list of source overri=
de files
> +      to apply by default when this configuration is selected. This is s=
upported
> +      only for configuration templates read from registries or local fil=
es; paths
> +      are resolved relative to the configuration file. See the
> +      :ref:`ref-bbsetup-source-overrides` section.
> +
>     -  ``setup-dir-name`` (*optional*): a suggestion for the :term:`Setup=
`
>        directory name. Bitbake-setup will use it, unless it already exist=
s, or
>        the :ref:`ref-bbsetup-setting-use-full-setup-dir-name` setting is =
set
> @@ -1193,6 +1199,13 @@ These files are written in the JSON file format an=
d are optionally passed to the
>  The ``--source-overrides`` option can be passed multiple times, in which=
 case the
>  overrides are applied in the order specified in the command-line.
>
> +A :term:`BitBake Configuration` can also select source override files wi=
th the
> +``default-source-overrides`` property. These overrides are applied befor=
e any
> +``--source-overrides`` arguments. Relative paths are resolved relative t=
o the
> +:term:`Configuration Template` file, or inside the fetched registry chec=
kout.
> +This allows a remote registry to provide its own default override files;=
 the
> +``--source-overrides`` command-line option only accepts local files.
> +
>  Here is an example file that overrides the branch of the BitBake reposit=
ory to
>  "master-next", and provides openembedded-core as a symlink to a path on =
local disk:
>
> diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
> index d425faa1f6b6..de9fde488539 100644
> --- a/lib/bb/tests/setup.py
> +++ b/lib/bb/tests/setup.py
> @@ -95,7 +95,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
>          return bb.process.run("{} --global-settings {} {}".format(bbsetu=
p, os.path.join(self.tempdir, 'global-config'), cmd))
>
>
> -    def _add_json_config_to_registry_helper(self, name, sources):
> +    def _add_json_config_to_registry_helper(self, name, sources, default=
_source_overrides=3D()):
>          config =3D """
>  {
>      "sources": {
> @@ -107,6 +107,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
>              {
>                  "name": "gadget",
>                  "description": "Gadget configuration",
> +                "default-source-overrides": %s,
>                  "oe-template": "test-configuration-gadget",
>                  "oe-fragments": ["test-fragment-1"]
>              },
> @@ -172,7 +173,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
>      },
>      "version": "1.0"
>  }
> -""" % (sources)
> +""" % (sources, json.dumps(default_source_overrides))
>          os.makedirs(os.path.join(self.registrypath, os.path.dirname(name=
)), exist_ok=3DTrue)
>          with open(os.path.join(self.registrypath, name), 'w') as f:
>              f.write(config)
> @@ -180,7 +181,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
>          self.git('commit -m "Adding {}"'.format(name), cwd=3Dself.regist=
rypath)
>          return json.loads(config)
>
> -    def add_json_config_to_registry(self, name, rev, branch, source_name=
s=3D("test-repo",)):
> +    def add_json_config_to_registry(self, name, rev, branch, source_name=
s=3D("test-repo",), default_source_overrides=3D()):
>          sources =3D []
>          for source_name in source_names:
>              sources.append("""
> @@ -196,7 +197,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
>                  }
>              }
>  """ % (source_name, self.testrepopath, branch, rev))
> -        return self._add_json_config_to_registry_helper(name, ",\n".join=
(sources))
> +        return self._add_json_config_to_registry_helper(name, ",\n".join=
(sources), default_source_overrides)
>
>      def add_local_json_config_to_registry(self, name, path):
>          sources =3D """
> @@ -520,11 +521,21 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"])=
)
>              out =3D self.runbbsetup("update --update-bb-conf=3D'yes'")
>          _check_layer_backups(layers_path, 1)
>
> -        # check source overrides, local sources provided with symlinks, =
and custom setup dir name
> -        source_override_content =3D """
> +        # check source overrides, default source overrides, local source=
s provided with symlinks, and custom setup dir name
> +        default_source_overrides_content =3D """
>  {
>      "sources": {
>          "test-repo": {
> +            "local": {
> +                "path": "%s"
> +            }
> +        }
> +    }
> +}""" % (self.testrepopath)
> +        source_override_content =3D """
> +{
> +    "sources": {
> +        "test-repo-cli": {
>              "local": {
>                  "path": "."
>              }
> @@ -546,14 +557,20 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"])=
)
>          }
>      }
>  }"""
> +        default_source_overrides_filename =3D 'releases/default-source-o=
verrides.json'
>          override_filename =3D 'source-overrides.json'
>          second_override_filename =3D 'second-source-overrides.json'
>          custom_setup_dir =3D 'special-setup-dir'
> -        self.add_json_config_to_registry('test-config-1.conf.json', bran=
ch, branch, ("test-repo", "test-repo-extra"))
> +        os.makedirs(os.path.join(self.registrypath, os.path.dirname(defa=
ult_source_overrides_filename)), exist_ok=3DTrue)
> +        with open(os.path.join(self.registrypath, default_source_overrid=
es_filename), 'w') as f:
> +            f.write(default_source_overrides_content)
> +        self.git('add {}'.format(default_source_overrides_filename), cwd=
=3Dself.registrypath)
> +        self.git('commit -m "Adding {}"'.format(default_source_overrides=
_filename), cwd=3Dself.registrypath)
> +        self.add_json_config_to_registry('test-config-1.conf.json', bran=
ch, branch, ("test-repo", "test-repo-cli", "test-repo-extra"), default_sour=
ce_overrides=3D[default_source_overrides_filename])
>          self.add_file_to_testrepo(override_filename, source_override_con=
tent)
>          self.add_file_to_testrepo(second_override_filename, second_sourc=
e_override_content)
>          out =3D self.runbbsetup("init --non-interactive --source-overrid=
es {} --source-overrides {} --setup-dir-name {} test-config-1 gadget".forma=
t(os.path.join(self.testrepopath, override_filename), os.path.join(self.tes=
trepopath, second_override_filename), custom_setup_dir))
> -        _check_local_sources(custom_setup_dir, ("test-repo", "test-repo-=
extra"))
> +        _check_local_sources(custom_setup_dir, ("test-repo", "test-repo-=
cli", "test-repo-extra"))
>
>          # same but use command line options to specify local overrides
>          custom_setup_dir =3D 'special-setup-dir-with-cmdline-overrides'
> diff --git a/setup-schema/bitbake-setup.schema.json b/setup-schema/bitbak=
e-setup.schema.json
> index be8772db1b2d..1a3a056198cd 100644
> --- a/setup-schema/bitbake-setup.schema.json
> +++ b/setup-schema/bitbake-setup.schema.json
> @@ -120,6 +120,13 @@
>                                      "type": "string"
>                                  }
>                              },
> +                            "default-source-overrides": {
> +                                "description": "Source override files to=
 apply by default when this configuration is selected from a registry or lo=
cal file. Relative paths are relative to the configuration file.",
> +                                "type": "array",
> +                                "items": {
> +                                    "type": "string"
> +                                }
> +                            },
>                              "setup-dir-name": {
>                                  "type": "string",
>                                  "description": "A suggestion for the set=
up directory name, $-prefixed keys from oe-fragments-one-of will be substit=
uted with user selections."
>
> --
> 2.43.0
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#19562): https://lists.openembedded.org/g/bitbake-deve=
l/message/19562
> Mute This Topic: https://lists.openembedded.org/mt/119548105/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.k=
anavin@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

