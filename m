Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCB2FF5133
	for <webhook@archiver.kernel.org>; Tue,  7 Apr 2026 18:35:07 +0000 (UTC)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.88451.1775586901531591751
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Apr 2026 11:35:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=r8gn8vVD;
 spf=pass (domain: gmail.com, ip: 209.85.222.171, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cfbbf35354so707440985a.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 07 Apr 2026 11:35:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775586900; cv=none;
        d=google.com; s=arc-20240605;
        b=lx+6+XaJhRW+k7//BrAwEIJf1eiqTuZs2glly+7Ye2ugFBRK1wwdYJAIVZwKjzamjR
         ++Q/SYhNO6yd3O8z87tBC+jJVoz1INZn8vJsdao8KbOacuRKX/p3HLVmIEOTziuUhmRX
         /KtKA6ztRKZt5w/twtC4iZDZZT2cEgIHNAZV5B7bwXuQT9XNgWKrFkdGHKvQFV1Ilnte
         D0QiG/7P8Cg1ikEfRe6DPEaPozbPb6btwyI8KIp/fo2m3qnv1+q1NMnAggZvoCAWlKw0
         WzvjjudG+aMbtqUa7FAEivquv1FGdX1gbXvUpvonANBDkuyBW5BcX1w27xM+DlhYsjRk
         Y7eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OvNJkr72kSTX/Y0XTsjlLxIFpcyDwmbPj1EZXixjexY=;
        fh=z79r7devTYIWKIIJnNEQrp8fu91t3iK8WPc0gYxDyHM=;
        b=WMbehOPVei1LUnenioSg2UHpkJ8a4xrCR2I6pXbv9Sl5qE/onc0waxFNTf6ocDlqAy
         jOq9CjX0X+IcfVeQ9NKTJsfkW5fGLatEJhFOuj02ugwBFCI67vtAEUI7cQ7I3DVb+Q4h
         wijysvi3Oe4mX7eQdJGHU4F5v3I8IbABd5+zvtjcvoiYKoa8LIRFATrcESNkNQ4X9uIa
         5CgHNLAuF2gPekXA8GiRmhA92VOvc+6a7HdhluoG6p2Y+s49jcgSfjzGgpubrLg3B1Iy
         gqzAIjFjYOXfKwsaQSUd972ItcTBz+o/ib7NOLCKwAoLojEMLMeyDA8AG3y8QwjbUE8g
         DtNg==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775586900; x=1776191700; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OvNJkr72kSTX/Y0XTsjlLxIFpcyDwmbPj1EZXixjexY=;
        b=r8gn8vVDwfH+Hrdd3gnIJtwxUiUZvnXiy0V8Z9vFercDDkyAwpTiXlCHB1P/mhpz0j
         iQ0+t9uzBwCFbgYEj7doV8PoUEnA1JsQrLtsKc9RvytGzyBrWnURHVPENHFMMCsGeqKl
         k3hN4+tCvu7a1qe3TNxGWL5YEnPIa5DwvfvNnQMZf74K5mujjlPqhLuB5Gi9YcaDhJ/8
         QZqHvvw5aEkkyr+EQtFgdPRd0vaPxSLNGgtqoiXz7zxUyJvCojLKX+0R9q1bN8sOTsid
         pU0/bJasVSxY/ovePg81y3LEK4+6epSWW3S9hzXyDLBSrJVV9sV7XRD2Vec574p8nJ99
         TajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775586900; x=1776191700;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OvNJkr72kSTX/Y0XTsjlLxIFpcyDwmbPj1EZXixjexY=;
        b=EKnJArGrawGIP+2osS6FxClckj7hGws/zgLc4wN8NmsdCtLj4S+tcs+c02ROBtoN8O
         9RBqZIda2WwF+d0CRrdWn7VIp/U4M8P2IRc6iIdzYHqG/keRRm+11r11sKVqPKCtS8iG
         PYozcT/9iVHIN2L2Jy2CFZrvDR1VEgjSchiuy6lNYtMGBRuJJS1/g08VeEQrqGYvJsXQ
         RYNfbJMgHGZjzdUyjwY5SvHaekeWs5SPJMsJ8ddYHAEDMl6XESywPHU97YCUqWVDhwxc
         DYTtYROO+7YwLVtQhQ7mt54Ymc0e7VqCZauPkHV3VH6cW4aNczZOnOpR4pU06cDx3Z+Z
         vFWA==
X-Gm-Message-State: AOJu0YyyKr15EvC7DCrFJLZkTyovFsYMDtIxo8TMeVGliueOwrDWOnmh
	4jlaaOBAJF1/+uqjp1bTtt15HaMc5UgNbf55vL0ZnJeIZl/zBh+rjR89L6MYA2eBrfYlc2Mnzgo
	nRjuW2FncsoV1PEe7XKlnXFLqSrojn4s=
X-Gm-Gg: AeBDiescSR61vvg+8BkXG767k1nsq48seh5yMqxMZMKaKEJ50T3dyTBx7pWqD3hRYAi
	PJm7ufd3WtV0N1P4EeWeGqe6ErGIc2n9vrajXPrjnw/lhej7QxyQErrfMXFGMfz+b+npLZx97sO
	YHoDxoUq788BwCQLzwAa6W7V4cuS9Ij5XbJF9J86+GSFwEWZZsYAbuv6V8AF1mWjJ2vZI1Y0NF4
	T8d1SIqYIOlFh0FyCnK+IWFESBlJIcHT33GH0pgd9C1lZGW5/+79FtDX2lK1BXW5D8qi6jYWTgv
	Q9Bzy9l/YhMQOkjhO6AgTwnkBwICrhJOdROVyYKxiA==
X-Received: by 2002:a05:620a:4409:b0:8d7:6d40:713e with SMTP id
 af79cd13be357-8d76d407d47mr1412760585a.39.1775586900341; Tue, 07 Apr 2026
 11:35:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260406202430.1856836-1-adrian.freihofer@siemens.com> <20260406202430.1856836-3-adrian.freihofer@siemens.com>
In-Reply-To: <20260406202430.1856836-3-adrian.freihofer@siemens.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 7 Apr 2026 20:34:49 +0200
X-Gm-Features: AQROBzBeycPMP9hMpK0qPhecgIO57j5PQ_HMO4FGNKpw838l4rFVsd6clwOkDD4
Message-ID: <CANNYZj-J_f54ZEGzi8NFWJZuUG2UZY5W5jt9Mf4tcyG=SAcYBQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 2/4] bitbake-setup: add support for
 extra-remotes in layer sources
To: adrian.freihofer@siemens.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Apr 2026 18:35:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19352

I'd rather think we should make regular 'multiple remotes' work well,
instead of adding a whole new 'extra-remotes' property. E.g. define
additional per-remote properties to avoid fetching when that is
undesired, etc.

Alex

On Mon, 6 Apr 2026 at 22:24, Adrian Freihofer via
lists.openembedded.org
<adrian.freihofer=siemens.com@lists.openembedded.org> wrote:
>
> From: Adrian Freihofer <adrian.freihofer@siemens.com>
>
> Support an easy way to configure the contrib git remotes in checked-out
> layer repositories.
>
> Add an 'extra-remotes' property to the git-remote source definition.
> Extra remotes are added to checked-out repositories via 'git remote add'
> after checkout, but are not used for fetching or change detection. This
> is useful for contrib push URIs (e.g. SSH push mirrors) that should
> not affect how bitbake-setup fetches or tracks upstream changes.
>
> Each extra remote entry supports:
> - 'uri': the remote URI (required)
> - 'optional': if true, the remote is excluded by the default 'non-optional'
>   filter (useful for remotes that require special access like SSH keys);
>   failures when adding any extra remote are always reported as warnings
>
> A new --extra-remotes-filter option is added to 'init' and 'update':
> - 'non-optional' (default): configure only non-optional extra remotes
> - 'all': configure all extra remotes including optional ones
> - 'none': skip all extra remotes
> - comma-separated names: configure only the named remotes
>
> Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
> ---
>  bin/bitbake-setup               | 82 ++++++++++++++++++++++++++++++---
>  setup-schema/layers.schema.json | 22 +++++++++
>  2 files changed, 98 insertions(+), 6 deletions(-)
>
> diff --git a/bin/bitbake-setup b/bin/bitbake-setup
> index 5a3394092..9962a25f1 100755
> --- a/bin/bitbake-setup
> +++ b/bin/bitbake-setup
> @@ -152,6 +152,27 @@ def add_unique_timestamp_to_path(path):
>                  break
>      return path_unique
>
> +def _filter_extra_remotes(extra_remotes, filter_value):
> +    """
> +    Filter the extra-remotes dict according to --extra-remotes-filter.
> +    'non-optional' -> return only entries where optional is False (default)
> +    'all'  -> return all entries including optional ones
> +    'none' -> return empty dict
> +    otherwise -> treat filter_value as a comma-separated list of allowed remote names
> +    """
> +    logger.debug("_filter_extra_remotes: filter='{}', candidates={}".format(filter_value, list(extra_remotes.keys())))
> +    if filter_value == 'non-optional':
> +        result = {k: v for k, v in extra_remotes.items() if not v.get('optional', False)}
> +    elif filter_value == 'all':
> +        result = extra_remotes
> +    elif filter_value == 'none':
> +        result = {}
> +    else:
> +        allowed = {n.strip() for n in filter_value.split(',')}
> +        result = {k: v for k, v in extra_remotes.items() if k in allowed}
> +    logger.debug("_filter_extra_remotes: selected={}".format(list(result.keys())))
> +    return result
> +
>  def _get_remotes(r_remote):
>      remotes = []
>
> @@ -167,7 +188,41 @@ def _get_remotes(r_remote):
>
>      return remotes
>
> -def checkout_layers(layers, confdir, layerdir, d, rebase_conflicts_strategy='abort'):
> +def _add_extra_remotes(extra_remotes, repodir_path):
> +    if not os.path.exists(os.path.join(repodir_path, '.git')):
> +        logger.debug("_add_extra_remotes: skipping {}, no .git entry found".format(repodir_path))
> +        return
> +    existing = bb.process.run('git -C {} remote'.format(repodir_path))[0].split()
> +    logger.debug("_add_extra_remotes: existing remotes in {}: {}".format(repodir_path, existing))
> +    for remote_name, remote_data in extra_remotes.items():
> +        uri = remote_data['uri']
> +        try:
> +            if remote_name in existing:
> +                bb.process.run('git -C {} remote set-url {} {}'.format(repodir_path, remote_name, uri))
> +                logger.plain("    Updated extra remote '{}' -> {}".format(remote_name, uri))
> +            else:
> +                bb.process.run('git -C {} remote add {} {}'.format(repodir_path, remote_name, uri))
> +                logger.plain("    Added extra remote '{}' -> {}".format(remote_name, uri))
> +        except bb.process.ExecutionError as e:
> +            logger.warning("    Skipping extra remote '{}': {}".format(remote_name, e))
> +
> +def _apply_extra_remotes(r_name, r_data, layerdir, extra_remotes_filter):
> +    r_remote = r_data.get('git-remote')
> +    if not r_remote:
> +        logger.debug("_apply_extra_remotes: skipping {}, no git-remote".format(r_name))
> +        return
> +    extra_remotes = r_remote.get('extra-remotes')
> +    if not extra_remotes:
> +        logger.debug("_apply_extra_remotes: skipping {}, no extra-remotes defined".format(r_name))
> +        return
> +    extra_remotes = _filter_extra_remotes(extra_remotes, extra_remotes_filter)
> +    if extra_remotes:
> +        repodir = r_data.get('path', r_name)
> +        _add_extra_remotes(extra_remotes, os.path.join(layerdir, repodir))
> +    else:
> +        logger.debug("_apply_extra_remotes: all extra-remotes for {} were filtered out".format(r_name))
> +
> +def checkout_layers(layers, confdir, layerdir, d, rebase_conflicts_strategy='abort', extra_remotes_filter='non-optional'):
>      def _checkout_git_remote(r_remote, repodir, layers_fixed_revisions):
>          rev = r_remote['rev']
>          branch = r_remote.get('branch', None)
> @@ -236,6 +291,7 @@ bitbake-setup init -L {} /path/to/repo/checkout""".format(
>
>          if r_remote:
>              _checkout_git_remote(r_remote, repodir, layers_fixed_revisions)
> +            _apply_extra_remotes(r_name, r_data, layerdir, extra_remotes_filter)
>          if r_local:
>              _symlink_local(os.path.expanduser(r_local["path"]), repodir_path)
>
> @@ -458,9 +514,9 @@ def merge_overrides_into_sources(sources, overrides):
>              layers[k] = v
>      return layers
>
> -def update_build(config, confdir, setupdir, layerdir, d, update_bb_conf="prompt", init_vscode=False, rebase_conflicts_strategy='abort'):
> +def update_build(config, confdir, setupdir, layerdir, d, update_bb_conf="prompt", init_vscode=False, rebase_conflicts_strategy='abort', extra_remotes_filter='non-optional'):
>      layer_config = merge_overrides_into_sources(config["data"]["sources"], config["source-overrides"]["sources"])
> -    sources_fixed_revisions = checkout_layers(layer_config, confdir, layerdir, d, rebase_conflicts_strategy=rebase_conflicts_strategy)
> +    sources_fixed_revisions = checkout_layers(layer_config, confdir, layerdir, d, rebase_conflicts_strategy=rebase_conflicts_strategy, extra_remotes_filter=extra_remotes_filter)
>      bitbake_config = config["bitbake-config"]
>      thisdir = os.path.dirname(config["path"]) if config["type"] == 'local' else None
>      setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_conf, init_vscode)
> @@ -866,7 +922,7 @@ def init_config(top_dir, settings, args):
>      bb.event.register("bb.build.TaskProgress", handle_task_progress, data=d)
>
>      write_upstream_config(confdir, upstream_config)
> -    update_build(upstream_config, confdir, setupdir, layerdir, d, update_bb_conf="yes", init_vscode=args.init_vscode)
> +    update_build(upstream_config, confdir, setupdir, layerdir, d, update_bb_conf="yes", init_vscode=args.init_vscode, extra_remotes_filter=args.extra_remotes_filter)
>
>      bb.event.remove("bb.build.TaskProgress", None)
>
> @@ -943,7 +999,8 @@ def build_status(top_dir, settings, args, d, update=False):
>          logger.plain('\nConfiguration in {} has changed:\n{}'.format(setupdir, config_diff))
>          if update:
>              update_build(new_upstream_config, confdir, setupdir, layerdir, d,
> -                         update_bb_conf=args.update_bb_conf, rebase_conflicts_strategy=args.rebase_conflicts_strategy)
> +                         update_bb_conf=args.update_bb_conf, rebase_conflicts_strategy=args.rebase_conflicts_strategy,
> +                         extra_remotes_filter=args.extra_remotes_filter)
>          else:
>              bb.process.run('git -C {} restore config-upstream.json'.format(confdir))
>          return
> @@ -952,11 +1009,14 @@ def build_status(top_dir, settings, args, d, update=False):
>      if are_layers_changed(layer_config, layerdir, d):
>          if update:
>              update_build(current_upstream_config, confdir, setupdir, layerdir,
> -                         d, update_bb_conf=args.update_bb_conf, rebase_conflicts_strategy=args.rebase_conflicts_strategy)
> +                         d, update_bb_conf=args.update_bb_conf, rebase_conflicts_strategy=args.rebase_conflicts_strategy,
> +                         extra_remotes_filter=args.extra_remotes_filter)
>          return
>
>      logger.plain("\nConfiguration in {} has not changed.".format(setupdir))
>      if update:
> +        for r_name, r_data in layer_config.items():
> +            _apply_extra_remotes(r_name, r_data, layerdir, args.extra_remotes_filter)
>          workspace_file = os.path.join(setupdir, "bitbake.code-workspace")
>          if os.path.exists(workspace_file):
>              bitbake_builddir = os.path.join(setupdir, "build")
> @@ -1239,6 +1299,14 @@ def main():
>          else:
>              parser.add_argument('--setup-dir', required=True, help="Path to the setup")
>
> +    def add_extra_remotes_filter_arg(parser):
> +        parser.add_argument('--extra-remotes-filter', default='non-optional', metavar='FILTER', dest='extra_remotes_filter',
> +                            help="Control which extra-remotes are configured in checked-out repositories: "
> +                                 "'non-optional' (default) configures only extra-remotes that are not marked as optional; "
> +                                 "'all' configures all extra-remotes including optional ones; "
> +                                 "'none' skips all extra-remotes; "
> +                                 "a comma-separated list of remote names configures only those named remotes (e.g. 'contrib,upstream').")
> +
>      parser = argparse.ArgumentParser(
>          description="BitBake setup utility. Run with 'init' argument to get started.",
>          epilog="Use %(prog)s <subcommand> --help to get help on a specific command"
> @@ -1269,6 +1337,7 @@ def main():
>                          help='Symlink local source into a build, instead of getting it as prescribed by a configuration (useful for local development).')
>      parser_init.add_argument('--init-vscode', action=argparse.BooleanOptionalAction, default=bool(shutil.which('code')),
>                          help='Generate VSCode workspace configuration (default: %(default)s)')
> +    add_extra_remotes_filter_arg(parser_init)
>      parser_init.set_defaults(func=init_config)
>
>      parser_status = subparsers.add_parser('status', help='Check if the setup needs to be synchronized with configuration')
> @@ -1282,6 +1351,7 @@ def main():
>                          help="What to do when a layer repository has local modifications that prevent "
>                               "an in-place update: 'abort' (default) aborts with an error message; "
>                               "'backup' renames the directory to a timestamped backup and re-clones from upstream.")
> +    add_extra_remotes_filter_arg(parser_update)
>      parser_update.set_defaults(func=build_update)
>
>      parser_install_buildtools = subparsers.add_parser('install-buildtools', help='Install buildtools which can help fulfil missing or incorrect dependencies on the host machine')
> diff --git a/setup-schema/layers.schema.json b/setup-schema/layers.schema.json
> index f42606941..65b5ae5c7 100644
> --- a/setup-schema/layers.schema.json
> +++ b/setup-schema/layers.schema.json
> @@ -67,6 +67,28 @@
>                                          }
>                                      }
>                                  }}
> +                            },
> +                            "extra-remotes": {
> +                                "description": "Additional named git remotes to configure in the checked-out repository. These are not used for fetching or change detection, only added via 'git remote add'.",
> +                                "type": "object",
> +                                "patternProperties": { ".*" : {
> +                                    "description": "An extra git remote",
> +                                    "type": "object",
> +                                    "additionalProperties": false,
> +                                    "required": [
> +                                        "uri"
> +                                    ],
> +                                    "properties": {
> +                                        "uri": {
> +                                            "description": "The URI for the remote",
> +                                            "type": "string"
> +                                        },
> +                                        "optional": {
> +                                            "description": "If true, the remote is excluded by the default 'non-optional' filter. Useful for remotes that require special access (e.g. contrib push URIs with SSH keys).",
> +                                            "type": "boolean"
> +                                        }
> +                                    }
> +                                }}
>                              }
>                          }
>                      },
> --
> 2.53.0
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#19336): https://lists.openembedded.org/g/bitbake-devel/message/19336
> Mute This Topic: https://lists.openembedded.org/mt/118697285/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

