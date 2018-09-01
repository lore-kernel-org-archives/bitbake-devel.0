Return-Path: <alex.kanavin@gmail.com>
Received: from mail-oi0-f65.google.com (mail-oi0-f65.google.com
	[209.85.218.65])
	by mail.openembedded.org (Postfix) with ESMTP id D14DF79503
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  1 Sep 2018 19:33:28 +0000 (UTC)
Received: by mail-oi0-f65.google.com with SMTP id p84-v6so27413950oic.4
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 01 Sep 2018 12:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=T53DJam2MmB0ZfpKzc/xTY3a5sORk7l9OdtxMXcVF98=;
	b=OZSBA5WdceDc2k5mZ5g7m5jWiWrXK1GT024iuSi6Fhy+SDNaZmvN6pwIEuRUmovVip
	6lrUD6ZJ5ZaD7M3jlK6H5w8Ycmk9sR4HrmNQRLBV1SJY+ZvELjtGI6CCh6XA+ACVXKg3
	cnE8MxLFhAAzL1+3jzxnQBs0KtbbnFKQFYHejbGVYZC2atXH4FNO8To7D8YJiPeEkAfi
	77a6PtzSVWUydt0MbZNW5wjqSVQiU/6kp3P8nxvWhKfPDhLVETXee817dLxnxXcOzOr4
	gI/JVm2y6ab8xkhfzMly8V+POevEDmOOAdO0lVKZXMWauaPBoySd1OwVx5DPOPgyNaC8
	qkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=T53DJam2MmB0ZfpKzc/xTY3a5sORk7l9OdtxMXcVF98=;
	b=O5h+oQTNcqKDk4PFpiuyYbNH69NLWkOc7FqYsDkpmgZrpfDPBlVLfToMLjg9O7Wx5Y
	LbnE6vBC5uZwcQ8asTTdndGM7ebUfz8YRO8PmLKHVItHAOaKKTM4No3f1+pyOoOVZhBw
	9xnAit/kfvR2j/8o9y69ioCdy/F++Wy8VfUJg4c8iSLwmoRF45Xnv8WX+pyI9ZJkhgnp
	IStjwf12djlA3kS69Da08A/Ha/ahy2iE1u+JzdbewCbPOtfc3DjWtsLUvwrDBjADWmaN
	69ohCyABn3l94rIWGGNCen0VhbmxDCl5VVJZHVdaVr/N4fQmFP3PDRxKQ8YlY6qQEirX
	sSAw==
X-Gm-Message-State: APzg51DmGzjZ0xjhd1AeSDR1zqPtIxKi9Ps1qgT8Pa/UIyjxeEN3EJe9
	ThGPHVe3HCAHrEw/cMNnHXqyZXPPq0JMZCODTcU=
X-Google-Smtp-Source: ANB0VdZlPgYbgDihhEb/KE4jQFjG7447ZpLTqZKJKX7ZkOzn8SwM/XlwJ6CAtUc9iZJx7ooHLqZ1v506qBglNqY7mgE=
X-Received: by 2002:aca:edd8:: with SMTP id
	l207-v6mr13525316oih.65.1535830409723; 
	Sat, 01 Sep 2018 12:33:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:1847:0:0:0:0:0 with HTTP;
	Sat, 1 Sep 2018 12:33:29 -0700 (PDT)
In-Reply-To: <20180901133644.1577-1-lukaszgardon555@gmail.com>
References: <20180901133644.1577-1-lukaszgardon555@gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Sat, 1 Sep 2018 21:33:29 +0200
Message-ID: <CANNYZj9-ybLPr=kNLEGFgdPG1U_kNJEEVzCw_5FiYUPYVVQQYw@mail.gmail.com>
To: =?UTF-8?B?xYF1a2FzeiBHYXJkb8WE?= <lukaszgardon555@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [] Add files supporting bash completion for bitbake tools
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
X-List-Received-Date: Sat, 01 Sep 2018 19:33:29 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The right upstream destination for this is almost certainly
https://github.com/scop/bash-completion

Alex

2018-09-01 15:36 GMT+02:00 =C5=81ukasz Gardo=C5=84 <lukaszgardon555@gmail.c=
om>:
> Repository with more details:
> https://github.com/lukaszgard/bitbake-completion
>
> Signed-off-by: =C5=81ukasz Gardo=C5=84 <lukaszgardon555@gmail.com>
> ---
>  contrib/completion/bash/bitbake_completion    | 108 ++++++++++
>  .../bash/bitbake_diffsigs_completion          |  86 ++++++++
>  .../bash/bitbake_dumpsig_completion           |  89 +++++++++
>  .../completion/bash/bitbake_layers_completion | 188 ++++++++++++++++++
>  .../completion/bash/bitbake_prserv_completion |  76 +++++++
>  .../bash/bitbake_selftest_completion          |  34 ++++
>  6 files changed, 581 insertions(+)
>  create mode 100644 contrib/completion/bash/bitbake_completion
>  create mode 100644 contrib/completion/bash/bitbake_diffsigs_completion
>  create mode 100644 contrib/completion/bash/bitbake_dumpsig_completion
>  create mode 100644 contrib/completion/bash/bitbake_layers_completion
>  create mode 100644 contrib/completion/bash/bitbake_prserv_completion
>  create mode 100644 contrib/completion/bash/bitbake_selftest_completion
>
> diff --git a/contrib/completion/bash/bitbake_completion b/contrib/complet=
ion/bash/bitbake_completion
> new file mode 100644
> index 00000000..23cadf6e
> --- /dev/null
> +++ b/contrib/completion/bash/bitbake_completion
> @@ -0,0 +1,108 @@
> +#!bash
> +# Bash completion support for bitbake 1.39.1 release.
> +#
> +# Copyright (C) 2014 Sergio Prado <sergio.prado@e-labworks.com>
> +# Copyright (C) 2018 Lukasz Gardon <lukasz.gardon@gmail.com>
> +#
> +# Distributed under the MIT License (MIT)
> +#
> +
> +_bitbake()
> +{
> +    local cur prev opts_short opts_long tasks recipes ui
> +    local bb_layers_conf bb_layers_md5 bb_recipes
> +
> +    COMPREPLY=3D()
> +
> +    cur=3D"${COMP_WORDS[COMP_CWORD]}"
> +    prev=3D"${COMP_WORDS[COMP_CWORD-1]}"
> +
> +    opts_short=3D"-h -b -k -f -c -C -r -R -v -D -q -n -S -p -s -e -g -I =
\
> +                -l -P -u -B -T -m -w"
> +
> +    opts_long=3D"--version --help --buildfile=3D --continue --force --cm=
d=3D \
> +               --clear-stamp=3D --read=3D --postread=3D --verbose --debu=
g --quiet \
> +               --dry-run --dump-signatures=3D --parse-only --show-versio=
ns \
> +               --environment --graphviz --ignore-deps=3D --log-domains=
=3D --profile \
> +               --ui=3D --token=3D --revisions-changed --server-only --bi=
nd=3D \
> +               --idle-timeout=3D --no-setscene --setscene-only --remote-=
server=3D \
> +               --kill-server --observe-only --status-only --write-log=3D=
 --runall=3D \
> +               --runonly=3D"
> +
> +    tasks=3D"build compile compile_ptest_base configure configure_ptest_=
base deploy \
> +           distrodata fetch image image_complete install install_ptest_b=
ase package \
> +           package_qa package_write_deb package_write_ipk package_write_=
rpm package_write_tar \
> +           packagedata patch populate_lic populate_sdk populate_sysroot =
prepare_recipe_sysroot \
> +           rm_work rm_work_all unpack checkpkg checkuri clean cleanall c=
leansstate devpyshell \
> +           devshell listtasks package_index bootimg bundle_initramfs roo=
tfs testimage \
> +           testimage_auto compile_kernelmodules diffconfig kernel_checko=
ut kernel_configcheck \
> +           kernel_configme kernel_menuconfig kernel_metadata menuconfig =
savedefconfig shared_workdir \
> +           sizecheck strip validate_branches spdx"
> +
> +    ui=3D"knotty ncurses taskexp"
> +
> +    if [[ "$prev" =3D=3D "=3D" ]]; then
> +        prev=3D"${COMP_WORDS[COMP_CWORD - 2]}"
> +    elif [[ "$cur" =3D=3D "=3D" ]]; then
> +        cur=3D""
> +    fi
> +
> +    conf_files=3D$(find . -maxdepth 1 -name "*.conf" -type f -printf '%P=
\n')
> +
> +    case "$prev" in
> +        "-c"|"--cmd"|"-C"|"--clear-stamp"|"--ignore-deps"|"--runall"|"--=
runonly")
> +            COMPREPLY=3D( $(compgen -W "${tasks}" -- ${cur}) )
> +            return 0
> +        ;;
> +        "-r"|"--read"|"-R"|"--postread")
> +            COMPREPLY=3D( $(compgen -W "${conf_files}" -- ${cur}) )
> +            return 0
> +        ;;
> +        "-u"|"--ui")
> +            COMPREPLY=3D( $(compgen -W "${ui}" -- ${cur}) )
> +            return 0
> +        ;;
> +    esac
> +
> +    case "$cur" in
> +        "--"*)
> +            COMPREPLY=3D( $(compgen -W "${opts_long}" -- ${cur}) )
> +            if [[ ${#COMPREPLY[@]} =3D=3D 1 && ${COMPREPLY[0]} =3D=3D "-=
-"*"=3D" ]] ; then
> +                compopt -o nospace
> +            fi
> +            return 0
> +        ;;
> +        "-"*)
> +            COMPREPLY=3D( $(compgen -W "${opts_short}" -- ${cur}) )
> +            return 0
> +        ;;
> +    esac
> +
> +    bb_layers_conf=3D"conf/bblayers.conf"
> +    bb_layers_md5=3D".bb_layers_conf.md5"
> +    bb_recipes=3D".bb_recipes"
> +
> +    _parse_recipes () {
> +        bitbake -s | sed -e '0,/^=3D.*/d' -e '/^\s*$/d' -e '/^Summary:/d=
' | awk '{print $1}' > $bb_recipes
> +    }
> +
> +    if [ ! -e $bb_layers_conf ]; then
> +        return 0
> +    fi
> +
> +    if [ "$prev" =3D "bitbake" -a "$cur" =3D "" ]; then
> +        _parse_recipes
> +    fi
> +
> +    md5sum --quiet --status -c $bb_layers_md5 2>/dev/null
> +    if [ $? !=3D 0 -o ! -e $bb_recipes ]; then
> +         md5sum $bb_layers_conf > $bb_layers_md5
> +         _parse_recipes
> +    fi
> +
> +    recipes=3D$(cat $bb_recipes)
> +
> +    COMPREPLY=3D( $(compgen -W "${recipes}" -- ${cur}) )
> +    return 0
> +}
> +complete -F _bitbake bitbake
> \ No newline at end of file
> diff --git a/contrib/completion/bash/bitbake_diffsigs_completion b/contri=
b/completion/bash/bitbake_diffsigs_completion
> new file mode 100644
> index 00000000..cbf2c5f1
> --- /dev/null
> +++ b/contrib/completion/bash/bitbake_diffsigs_completion
> @@ -0,0 +1,86 @@
> +#!bash
> +# Bash completion support for bitbake-diffsigs tool,
> +# compatible with Bitbake 1.39.1.
> +#
> +# Copyright (C) 2018 Lukasz Gardon <lukasz.gardon@gmail.com>
> +#
> +# Distributed under the MIT License (MIT)
> +#
> +
> +_bitbake_diffsigs()
> +{
> +    local cur prev opts_short opts_long tasks colors
> +    local bb_layers_conf bb_layers_md5 bb_recipes
> +
> +    COMPREPLY=3D()
> +
> +    cur=3D"${COMP_WORDS[COMP_CWORD]}"
> +    prev=3D"${COMP_WORDS[COMP_CWORD-1]}"
> +
> +    opts_short=3D"-h -d -t -s"
> +
> +    opts_long=3D"--help --debug --color --task --signature"
> +
> +    tasks=3D"build compile compile_ptest_base configure configure_ptest_=
base deploy \
> +           distrodata fetch image image_complete install install_ptest_b=
ase package \
> +           package_qa package_write_deb package_write_ipk package_write_=
rpm package_write_tar \
> +           packagedata patch populate_lic populate_sdk populate_sysroot =
prepare_recipe_sysroot \
> +           rm_work rm_work_all unpack checkpkg checkuri clean cleanall c=
leansstate devpyshell \
> +           devshell listtasks package_index bootimg bundle_initramfs roo=
tfs testimage \
> +           testimage_auto compile_kernelmodules diffconfig kernel_checko=
ut kernel_configcheck \
> +           kernel_configme kernel_menuconfig kernel_metadata menuconfig =
savedefconfig shared_workdir \
> +           sizecheck strip validate_branches spdx"
> +
> +    colors=3D"auto always never"
> +
> +    case "$cur" in
> +        "--"*)
> +            COMPREPLY=3D( $(compgen -W "${opts_long}" -- ${cur}) )
> +            return 0
> +        ;;
> +        "-"*)
> +            COMPREPLY=3D( $(compgen -W "${opts_short}" -- ${cur}) )
> +            return 0
> +        ;;
> +    esac
> +
> +    bb_layers_conf=3D"conf/bblayers.conf"
> +    bb_layers_md5=3D".bb_layers_conf.md5"
> +    bb_recipes=3D".bb_recipes"
> +
> +    _parse_recipes () {
> +        bitbake -s | sed -e '0,/^=3D.*/d' -e '/^\s*$/d' -e '/^Summary:/d=
' | awk '{print $1}' > $bb_recipes
> +    }
> +
> +    if [ ! -e $bb_layers_conf ]; then
> +        return 0
> +    fi
> +
> +    if [ "$prev" =3D "bitbake" -a "$cur" =3D "" ]; then
> +           _parse_recipes
> +    fi
> +
> +    md5sum --quiet --status -c $bb_layers_md5 2>/dev/null
> +    if [ $? !=3D 0 -o ! -e $bb_recipes ]; then
> +        md5sum $bb_layers_conf > $bb_layers_md5
> +        _parse_recipes
> +    fi
> +
> +    recipes=3D$(cat $bb_recipes)
> +
> +    case "$prev" in
> +        "-c"|"--color")
> +            COMPREPLY=3D( $(compgen -W "${colors}" -- ${cur}) )
> +            return 0
> +        ;;
> +        "-t"|"--task")
> +          COMPREPLY=3D( $(compgen -W "${recipes}" -- ${cur}) )
> +          return 0
> +    esac
> +
> +    if [[ ${COMP_WORDS[COMP_CWORD -2]} =3D=3D "-t" ]] || [[ ${COMP_WORDS=
[COMP_CWORD -2]} =3D=3D "--task" ]]; then
> +        COMPREPLY=3D( $(compgen -W "${tasks}" -- ${cur}) )
> +           return 0
> +    fi
> +}
> +complete -F _bitbake_diffsigs bitbake-diffsigs
> \ No newline at end of file
> diff --git a/contrib/completion/bash/bitbake_dumpsig_completion b/contrib=
/completion/bash/bitbake_dumpsig_completion
> new file mode 100644
> index 00000000..95eb2394
> --- /dev/null
> +++ b/contrib/completion/bash/bitbake_dumpsig_completion
> @@ -0,0 +1,89 @@
> +#!bash
> +# Bash completion support for bitbake-dumpsig tool,
> +# compatible with Bitbake 1.39.1.
> +#
> +# Copyright (C) 2018 Lukasz Gardon <lukasz.gardon@gmail.com>
> +#
> +# Distributed under the MIT License (MIT)
> +#
> +
> +_bitbake_dumpsig()
> +{
> +    local cur prev opts_short opts_long tasks
> +    local bb_layers_conf bb_layers_md5 bb_recipes
> +
> +    COMPREPLY=3D()
> +
> +    cur=3D"${COMP_WORDS[COMP_CWORD]}"
> +    prev=3D"${COMP_WORDS[COMP_CWORD-1]}"
> +
> +    opts_short=3D"-h -d -t"
> +
> +    opts_long=3D"--help --debug --task=3D"
> +
> +    tasks=3D"build compile compile_ptest_base configure configure_ptest_=
base deploy \
> +           distrodata fetch image image_complete install install_ptest_b=
ase package \
> +           package_qa package_write_deb package_write_ipk package_write_=
rpm package_write_tar \
> +           packagedata patch populate_lic populate_sdk populate_sysroot =
prepare_recipe_sysroot \
> +           rm_work rm_work_all unpack checkpkg checkuri clean cleanall c=
leansstate devpyshell \
> +           devshell listtasks package_index bootimg bundle_initramfs roo=
tfs testimage \
> +           testimage_auto compile_kernelmodules diffconfig kernel_checko=
ut kernel_configcheck \
> +           kernel_configme kernel_menuconfig kernel_metadata menuconfig =
savedefconfig shared_workdir \
> +           sizecheck strip validate_branches spdx"
> +
> +    if [[ "$prev" =3D=3D "=3D" ]]; then
> +        prev=3D"${COMP_WORDS[COMP_CWORD - 2]}"
> +    elif [[ "$cur" =3D=3D "=3D" ]]; then
> +        cur=3D""
> +    fi
> +
> +    case "$cur" in
> +        "--"*)
> +            COMPREPLY=3D( $(compgen -W "${opts_long}" -- ${cur}) )
> +            if [[ ${#COMPREPLY[@]} =3D=3D 1 && ${COMPREPLY[0]} =3D=3D "-=
-"*"=3D" ]] ; then
> +                compopt -o nospace
> +            fi
> +            return 0
> +        ;;
> +        "-"*)
> +            COMPREPLY=3D( $(compgen -W "${opts_short}" -- ${cur}) )
> +            return 0
> +        ;;
> +    esac
> +
> +    bb_layers_conf=3D"conf/bblayers.conf"
> +    bb_layers_md5=3D".bb_layers_conf.md5"
> +    bb_recipes=3D".bb_recipes"
> +
> +    _parse_recipes () {
> +        bitbake -s | sed -e '0,/^=3D.*/d' -e '/^\s*$/d' -e '/^Summary:/d=
' | awk '{print $1}' > $bb_recipes
> +    }
> +
> +    if [ ! -e $bb_layers_conf ]; then
> +        return 0
> +    fi
> +
> +    if [ "$prev" =3D "bitbake" -a "$cur" =3D "" ]; then
> +           _parse_recipes
> +    fi
> +
> +    md5sum --quiet --status -c $bb_layers_md5 2>/dev/null
> +    if [ $? !=3D 0 -o ! -e $bb_recipes ]; then
> +        md5sum $bb_layers_conf > $bb_layers_md5
> +        _parse_recipes
> +    fi
> +
> +    recipes=3D$(cat $bb_recipes)
> +
> +    case "$prev" in
> +        "-t"|"--task")
> +           COMPREPLY=3D( $(compgen -W "${recipes}" -- ${cur}) )
> +           return 0
> +    esac
> +
> +    if [[ ${COMP_WORDS[COMP_CWORD -2]} =3D~ "-t" ]] || [[ ${COMP_WORDS[C=
OMP_CWORD -3]} =3D=3D "--task" ]]; then
> +        COMPREPLY=3D( $(compgen -W "${tasks}" -- ${cur}) )
> +           return 0
> +    fi
> +}
> +complete -F _bitbake_dumpsig bitbake-dumpsig
> \ No newline at end of file
> diff --git a/contrib/completion/bash/bitbake_layers_completion b/contrib/=
completion/bash/bitbake_layers_completion
> new file mode 100644
> index 00000000..37ca8afb
> --- /dev/null
> +++ b/contrib/completion/bash/bitbake_layers_completion
> @@ -0,0 +1,188 @@
> +#!bash
> +# Bash completion support for bitbake-layers tool,
> +# compatible with Bitbake 1.39.1.
> +#
> +# Copyright (C) 2018 Lukasz Gardon <lukasz.gardon@gmail.com>
> +#
> +# Distributed under the MIT License (MIT)
> +#
> +
> +_bitbake_layers()
> +{
> +    local cur prev opts_short opts_long subcommands colors
> +    local opts_long_add_layer opts_short_add_layer opts_long_show_overla=
yed
> +    local opts_short_show_overlayed opts_long_show_recipes opts_short_sh=
ow_recipes
> +    local opts_long_show_cross_depends opts_short_show_cross_depends
> +    local opts_long_show_layerindex_fetch opts_short_show_layerindex_fet=
ch
> +    local opts_long_show_layerindex_show_depends opts_short_show_layerin=
dex_show_depends
> +    local opts_long_show_create_layer opts_short_show_create_layer bb_cl=
ass_files classes
> +
> +    COMPREPLY=3D()
> +
> +    cur=3D"${COMP_WORDS[COMP_CWORD]}"
> +    prev=3D"${COMP_WORDS[COMP_CWORD-1]}"
> +
> +    opts_short=3D"-d -q -F -h"
> +
> +    opts_long=3D"--debug --quiet --force --color --help"
> +
> +    subcommands=3D"layerindex-fetch layerindex-show-depends add-layer \
> +                    remove-layer flatten show-layers show-overlayed \
> +                        show-recipes show-appends show-cross-depends \
> +                        create-layer"
> +
> +    colors=3D"auto always never"
> +
> +    opts_long_show_overlayed=3D"--help --filenames --same-version"
> +    opts_short_show_overlayed=3D"-h -f -s"
> +
> +    opts_long_show_recipes=3D"--help --filenames --multiple --inherits"
> +    opts_short_show_recipes=3D"-h -f -m -i"
> +
> +    opts_long_show_layerindex_fetch=3D"--help --show-only --branch --ign=
ore"
> +    opts_short_show_layerindex_fetch=3D"-h -n -b -i"
> +
> +    opts_long_add_layer=3D"--help --priority --example-recipe-name --exa=
mple-recipe-version"
> +    opts_short_add_layer=3D"-h"
> +
> +    opts_long_show_cross_depends=3D"--help --filenames --ignore"
> +    opts_short_show_cross_depends=3D"-h -f -i"
> +
> +    opts_long_show_layerindex_show_depends=3D"--help --branch"
> +    opts_short_show_layerindex_show_depends=3D"-h -b"
> +
> +    opts_long_show_create_layer=3D"--help --priority --example-recipe-na=
me --example-recipe-version"
> +    opts_short_show_create_layer=3D"-h -p -e -v"
> +
> +    bb_class_files=3D".bb_class_files"
> +
> +    _get_classes() {
> +        find $BBPATH/../meta*/classes/ -name *.bbclass -exec basename {}=
 \; | sed 's/.bbclass//' > $bb_class_files
> +    }
> +
> +    if [[ "${COMP_WORDS[@]}" =3D~ show-recipes ]] ; then
> +        if [[ "$prev" =3D=3D "--inherits" ]] || [[ "$prev" =3D=3D "-i" ]=
]; then
> +            _get_classes
> +            classes=3D$(cat $bb_class_files)
> +            COMPREPLY=3D( $(compgen -W "${classes}" -- ${cur}) )
> +            return 0
> +        fi
> +    fi
> +
> +    if [[ "${COMP_WORDS[1]}" =3D~ show-layers|show-appends|remove-layer|=
flatten ]]; then
> +        case "$cur" in
> +            "--"*)
> +                COMPREPLY=3D( $(compgen -W "--help" -- ${cur}) )
> +                return 0
> +            ;;
> +            "-"*)
> +                COMPREPLY=3D( $(compgen -W "-h" -- ${cur}) )
> +                return 0
> +            ;;
> +        esac
> +    elif [[ "${COMP_WORDS[1]}" =3D=3D "add-layer" ]]; then
> +        case "$cur" in
> +            "--"*|"")
> +                COMPREPLY=3D( $(compgen -W "${opts_long_add_layer}" -- $=
{cur}) )
> +                return 0
> +            ;;
> +            "-"*)
> +                COMPREPLY=3D( $(compgen -W "${opts_short_add_layer}" -- =
${cur}) )
> +                return 0
> +            ;;
> +        esac
> +    elif [[ "${COMP_WORDS[1]}" =3D=3D "show-overlayed" ]]; then
> +        case "$cur" in
> +            "--"*|"")
> +                COMPREPLY=3D( $(compgen -W "${opts_long_show_overlayed}"=
 -- ${cur}) )
> +                return 0
> +            ;;
> +            "-"*)
> +                COMPREPLY=3D( $(compgen -W "${opts_short_show_overlayed}=
" -- ${cur}) )
> +                return 0
> +            ;;
> +        esac
> +    elif [[ "${COMP_WORDS[1]}" =3D=3D "show-recipes" ]]; then
> +        case "$cur" in
> +            "--"*|"")
> +                COMPREPLY=3D( $(compgen -W "${opts_long_show_recipes}" -=
- ${cur}) )
> +                return 0
> +            ;;
> +            "-"*)
> +                COMPREPLY=3D( $(compgen -W "${opts_short_show_recipes}" =
-- ${cur}) )
> +                return 0
> +            ;;
> +        esac
> +    elif [[ "${COMP_WORDS[1]}" =3D=3D "show-cross-depends" ]]; then
> +        case "$cur" in
> +            "--"*|"")
> +                COMPREPLY=3D( $(compgen -W "${opts_long_show_cross_depen=
ds}" -- ${cur}) )
> +                return 0
> +            ;;
> +            "-"*)
> +                COMPREPLY=3D( $(compgen -W "${opts_short_show_cross_depe=
nds}" -- ${cur}) )
> +                return 0
> +            ;;
> +        esac
> +    elif [[ "${COMP_WORDS[1]}" =3D=3D "layerindex-fetch" ]]; then
> +        case "$cur" in
> +            "--"*|"")
> +                COMPREPLY=3D( $(compgen -W "${opts_long_show_layerindex_=
fetch}" -- ${cur}) )
> +                return 0
> +            ;;
> +            "-"*)
> +                COMPREPLY=3D( $(compgen -W "${opts_short_show_layerindex=
_fetch}" -- ${cur}) )
> +                return 0
> +            ;;
> +        esac
> +    elif [[ "${COMP_WORDS[1]}" =3D=3D "layerindex-show-depends" ]]; then
> +        case "$cur" in
> +            "--"*|"")
> +                COMPREPLY=3D( $(compgen -W "${opts_long_show_layerindex_=
show_depends}" -- ${cur}) )
> +                return 0
> +            ;;
> +            "-"*)
> +                COMPREPLY=3D( $(compgen -W "${opts_short_show_layerindex=
_show_depends}" -- ${cur}) )
> +                return 0
> +            ;;
> +        esac
> +    elif [[ "${COMP_WORDS[1]}" =3D=3D "create-layer" ]]; then
> +        case "$cur" in
> +            "--"*|"")
> +                COMPREPLY=3D( $(compgen -W "${opts_long_show_create_laye=
r}" -- ${cur}) )
> +                return 0
> +            ;;
> +            "-"*)
> +                COMPREPLY=3D( $(compgen -W "${opts_short_show_create_lay=
er}" -- ${cur}) )
> +                return 0
> +            ;;
> +        esac
> +    fi
> +
> +    case "$prev" in
> +        "-c"|"--color")
> +            COMPREPLY=3D( $(compgen -W "${colors}" -- ${cur}) )
> +            return 0
> +        ;;
> +    esac
> +
> +    case "$cur" in
> +        "--"*)
> +            COMPREPLY=3D( $(compgen -W "${opts_long}" -- ${cur}) )
> +            return 0
> +        ;;
> +        "-"*)
> +            COMPREPLY=3D( $(compgen -W "${opts_short}" -- ${cur}) )
> +            return 0
> +        ;;
> +    esac
> +
> +    if [[ ${prev} =3D=3D "bitbake-layers" ]]; then
> +        COMPREPLY=3D( $(compgen -W "${subcommands}" -- ${cur}) )
> +        return 0
> +    elif [[ ! ${subcommands} =3D~ [[:space:]]${cur}[[:space:]] ]]; then
> +        COMPREPLY=3D( $(compgen -W "${subcommands}" -- ${cur}) )
> +        return 0
> +    fi
> +}
> +complete -F _bitbake_layers bitbake-layers
> \ No newline at end of file
> diff --git a/contrib/completion/bash/bitbake_prserv_completion b/contrib/=
completion/bash/bitbake_prserv_completion
> new file mode 100644
> index 00000000..3bca1197
> --- /dev/null
> +++ b/contrib/completion/bash/bitbake_prserv_completion
> @@ -0,0 +1,76 @@
> +#!bash
> +# Bash completion support for bitbake-prserv tool,
> +# compatible with Bitbake 1.39.1.
> +#
> +# Copyright (C) 2018 Lukasz Gardon <lukasz.gardon@gmail.com>
> +#
> +# Distributed under the MIT License (MIT)
> +#
> +
> +_bitbake_prserv()
> +{
> +    local cur prev opts_short opts_long subcommands file_default log_def=
ault log_levels
> +
> +    COMPREPLY=3D()
> +
> +    cur=3D"${COMP_WORDS[COMP_CWORD]}"
> +    prev=3D"${COMP_WORDS[COMP_CWORD-1]}"
> +
> +    opts_short=3D"-h -f -l"
> +
> +    opts_long=3D"--version --help --file=3D --log=3D --loglevel=3D --sta=
rt \
> +                  --stop --host=3D --port=3D"
> +
> +    subcommands=3D"layerindex-fetch layerindex-show-depends add-layer \
> +                    remove-layer flatten show-layers show-overlayed \
> +                        show-recipes show-appends show-cross-depends \
> +                        create-layer"
> +
> +    file_default=3D"prserv.sqlite3"
> +    log_default=3D"prserv.log"
> +    log_levels=3D"CRITICAL ERROR WARNING INFO DEBUG"
> +
> +    if [[ "$prev" =3D=3D "=3D" ]]; then
> +        prev=3D"${COMP_WORDS[COMP_CWORD -2]}"
> +    elif [[ "$cur" =3D=3D "=3D" ]]; then
> +        cur=3D""
> +    fi
> +
> +    case "$prev" in
> +        "-f"|"--file")
> +            COMPREPLY=3D( $(compgen -W "${file_default}" -- ${cur}) )
> +            return 0
> +        ;;
> +        "-l"|"--log")
> +            COMPREPLY=3D( $(compgen -W "${log_default}" -- ${cur}) )
> +            return 0
> +        ;;
> +        "--loglevel")
> +            COMPREPLY=3D( $(compgen -W "${log_levels}" -- ${cur}) )
> +            return 0
> +        ;;
> +    esac
> +
> +    case "$cur" in
> +        "--"*|"")
> +            COMPREPLY=3D( $(compgen -W "${opts_long}" -- ${cur}) )
> +            if [[ ${#COMPREPLY[@]} =3D=3D 1 && ${COMPREPLY[0]} =3D=3D "-=
-"*"=3D" ]] ; then
> +                compopt -o nospace
> +            fi
> +            return 0
> +        ;;
> +        "-"*)
> +            COMPREPLY=3D( $(compgen -W "${opts_short}" -- ${cur}) )
> +            return 0
> +        ;;
> +    esac
> +
> +    if [[ ${prev} =3D=3D "bitbake-layers" ]]; then
> +        COMPREPLY=3D( $(compgen -W "${subcommands}" -- ${cur}) )
> +        return 0
> +    elif [[ ! ${subcommands} =3D~ [[:space:]]${cur}[[:space:]] ]]; then
> +        COMPREPLY=3D( $(compgen -W "${subcommands}" -- ${cur}) )
> +        return 0
> +    fi
> +}
> +complete -F _bitbake_prserv bitbake-prserv
> \ No newline at end of file
> diff --git a/contrib/completion/bash/bitbake_selftest_completion b/contri=
b/completion/bash/bitbake_selftest_completion
> new file mode 100644
> index 00000000..8b6bf641
> --- /dev/null
> +++ b/contrib/completion/bash/bitbake_selftest_completion
> @@ -0,0 +1,34 @@
> +#!bash
> +# Bash completion support for bitbake-selftest tool,
> +# compatible with Bitbake version 1.39.1.
> +#
> +# Copyright (C) 2018 Lukasz Gardon <lukasz.gardon@gmail.com>
> +#
> +# Distributed under the MIT License (MIT)
> +#
> +
> +_bitbake_selftest()
> +{
> +    local cur prev opts_short opts_long
> +
> +    COMPREPLY=3D()
> +
> +    cur=3D"${COMP_WORDS[COMP_CWORD]}"
> +    prev=3D"${COMP_WORDS[COMP_CWORD-1]}"
> +
> +    opts_short=3D"-h -v -q -f -c"
> +
> +    opts_long=3D"--help --verbose --quiet --locals --failfast --catch"
> +
> +    case "$cur" in
> +        "--"*)
> +            COMPREPLY=3D( $(compgen -W "${opts_long}" -- ${cur}) )
> +            return 0
> +        ;;
> +        "-"*)
> +            COMPREPLY=3D( $(compgen -W "${opts_short}" -- ${cur}) )
> +            return 0
> +        ;;
> +    esac
> +}
> +complete -F _bitbake_selftest bitbake-selftest
> \ No newline at end of file
> --
> 2.18.0
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

