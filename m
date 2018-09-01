Return-Path: <lukaszgardon555@gmail.com>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
	by mail.openembedded.org (Postfix) with ESMTP id E57446006A
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  1 Sep 2018 13:37:09 +0000 (UTC)
Received: by mail-wm0-f68.google.com with SMTP id 207-v6so7688908wme.5
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 01 Sep 2018 06:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=P3F8xCfCGrFbLqly9fJ/3Umlqzx/8F0QClvSa3jucfc=;
	b=vT48i+Kc2iFz4tdeI5iMAt76rqGo/wDa/kOi/hpJKlzUd9hxg2ZPQHeOvJxHyTSLdX
	DDR+tmsrlyUNrNkpUpAnqhQ8nRFTwwfvgIXrF4jy0Cxp3w4Y2SMTc1L2cYMhAHfWXrEr
	Z8zXUIEhe5mLK3ehYlcZQ+Usb00BrGRE4dP5V77c3qybAlpAzkqfGk7AVZ/bNFqbAzM5
	UvPWi2H2Yp6Lu0GILSr98i/jrf0XIYDTGSlvb/CBvCMt5/jht7Jv3+SLyzZ5Tn/LYru3
	YjrNCF8IWWnqz23ihcQfd1Uw5vALuWH+qcr2jJ6gYKas6MTqBKVAp/zU1ocLTrRDXuew
	w3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=P3F8xCfCGrFbLqly9fJ/3Umlqzx/8F0QClvSa3jucfc=;
	b=ZzyO52Fn++G2wuxPCP2FkmXAwbrlar51KCIwZiBeasJ6sIfgOMIQ18DI3IE6DS3k9+
	Daf4h+5aSazbWe1xwLOwfr2ks/u7FtQMAXoojhbhu/bsRq6LKzSYCC2vMUVvCTjLfhYr
	qDo1SrkHT4IroGJx0AlQmJwLr7ePjIm7Q/ny3HdwY4PsFa63Kr5yV40ps/MWwIYEyQr/
	EoH7nUj/iMQop0uJr/H6UHIx75c4uabEYkGMNLAPP72LOHe6uVVZr6EsR5SLF3EovEt8
	Dfr7de3bfKeoyo50It6l5uwKEiM7th5NWsWub21wzkQq8qo1SGNwAkErJcSQtIZ5QgAO
	XeVA==
X-Gm-Message-State: APzg51CvO5x8luXj4gJr9lf6R6XNWu1gsj06/8U0gcLMlRCSY214/Lp6
	JAgWbRmXeu20goY8nZZ2mmMjKr2b
X-Google-Smtp-Source: ANB0VdYa6ZaGTjgjC8hyJO7v2vH4Q9lA1Rwhwizx+L2Uxi43LEcX5CVKa901jVKd5QoZLGcIYi7g/g==
X-Received: by 2002:a1c:230f:: with SMTP id
	j15-v6mr775232wmj.124.1535809029859; 
	Sat, 01 Sep 2018 06:37:09 -0700 (PDT)
Received: from localhost.localdomain (public-gprs177422.centertel.pl.
	[46.134.32.79]) by smtp.gmail.com with ESMTPSA id
	j2-v6sm5587634wmj.5.2018.09.01.06.37.07
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 01 Sep 2018 06:37:09 -0700 (PDT)
From: =?UTF-8?q?=C5=81ukasz=20Gardo=C5=84?= <lukaszgardon555@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat,  1 Sep 2018 15:36:44 +0200
Message-Id: <20180901133644.1577-1-lukaszgardon555@gmail.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Subject: [] Add files supporting bash completion for bitbake tools
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
X-List-Received-Date: Sat, 01 Sep 2018 13:37:10 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Repository with more details:
https://github.com/lukaszgard/bitbake-completion

Signed-off-by: Łukasz Gardoń <lukaszgardon555@gmail.com>
---
 contrib/completion/bash/bitbake_completion    | 108 ++++++++++
 .../bash/bitbake_diffsigs_completion          |  86 ++++++++
 .../bash/bitbake_dumpsig_completion           |  89 +++++++++
 .../completion/bash/bitbake_layers_completion | 188 ++++++++++++++++++
 .../completion/bash/bitbake_prserv_completion |  76 +++++++
 .../bash/bitbake_selftest_completion          |  34 ++++
 6 files changed, 581 insertions(+)
 create mode 100644 contrib/completion/bash/bitbake_completion
 create mode 100644 contrib/completion/bash/bitbake_diffsigs_completion
 create mode 100644 contrib/completion/bash/bitbake_dumpsig_completion
 create mode 100644 contrib/completion/bash/bitbake_layers_completion
 create mode 100644 contrib/completion/bash/bitbake_prserv_completion
 create mode 100644 contrib/completion/bash/bitbake_selftest_completion

diff --git a/contrib/completion/bash/bitbake_completion b/contrib/completion/bash/bitbake_completion
new file mode 100644
index 00000000..23cadf6e
--- /dev/null
+++ b/contrib/completion/bash/bitbake_completion
@@ -0,0 +1,108 @@
+#!bash
+# Bash completion support for bitbake 1.39.1 release.
+#
+# Copyright (C) 2014 Sergio Prado <sergio.prado@e-labworks.com>
+# Copyright (C) 2018 Lukasz Gardon <lukasz.gardon@gmail.com>
+#
+# Distributed under the MIT License (MIT)
+#
+
+_bitbake()
+{
+    local cur prev opts_short opts_long tasks recipes ui
+    local bb_layers_conf bb_layers_md5 bb_recipes
+
+    COMPREPLY=()
+
+    cur="${COMP_WORDS[COMP_CWORD]}"
+    prev="${COMP_WORDS[COMP_CWORD-1]}"
+
+    opts_short="-h -b -k -f -c -C -r -R -v -D -q -n -S -p -s -e -g -I \
+                -l -P -u -B -T -m -w"
+
+    opts_long="--version --help --buildfile= --continue --force --cmd= \
+               --clear-stamp= --read= --postread= --verbose --debug --quiet \
+               --dry-run --dump-signatures= --parse-only --show-versions \
+               --environment --graphviz --ignore-deps= --log-domains= --profile \
+               --ui= --token= --revisions-changed --server-only --bind= \
+               --idle-timeout= --no-setscene --setscene-only --remote-server= \
+               --kill-server --observe-only --status-only --write-log= --runall= \
+               --runonly="
+
+    tasks="build compile compile_ptest_base configure configure_ptest_base deploy \
+           distrodata fetch image image_complete install install_ptest_base package \
+           package_qa package_write_deb package_write_ipk package_write_rpm package_write_tar \
+           packagedata patch populate_lic populate_sdk populate_sysroot prepare_recipe_sysroot \
+           rm_work rm_work_all unpack checkpkg checkuri clean cleanall cleansstate devpyshell \
+           devshell listtasks package_index bootimg bundle_initramfs rootfs testimage \
+           testimage_auto compile_kernelmodules diffconfig kernel_checkout kernel_configcheck \
+           kernel_configme kernel_menuconfig kernel_metadata menuconfig savedefconfig shared_workdir \
+           sizecheck strip validate_branches spdx"
+
+    ui="knotty ncurses taskexp"
+
+    if [[ "$prev" == "=" ]]; then
+        prev="${COMP_WORDS[COMP_CWORD - 2]}"
+    elif [[ "$cur" == "=" ]]; then
+        cur=""
+    fi
+
+    conf_files=$(find . -maxdepth 1 -name "*.conf" -type f -printf '%P\n')
+
+    case "$prev" in
+        "-c"|"--cmd"|"-C"|"--clear-stamp"|"--ignore-deps"|"--runall"|"--runonly")
+            COMPREPLY=( $(compgen -W "${tasks}" -- ${cur}) )
+            return 0
+        ;;
+        "-r"|"--read"|"-R"|"--postread")
+            COMPREPLY=( $(compgen -W "${conf_files}" -- ${cur}) )
+            return 0
+        ;;
+        "-u"|"--ui")
+            COMPREPLY=( $(compgen -W "${ui}" -- ${cur}) )
+            return 0
+        ;;
+    esac
+
+    case "$cur" in
+        "--"*)
+            COMPREPLY=( $(compgen -W "${opts_long}" -- ${cur}) )
+            if [[ ${#COMPREPLY[@]} == 1 && ${COMPREPLY[0]} == "--"*"=" ]] ; then
+                compopt -o nospace
+            fi
+            return 0
+        ;;
+        "-"*)
+            COMPREPLY=( $(compgen -W "${opts_short}" -- ${cur}) )
+            return 0
+        ;;
+    esac
+
+    bb_layers_conf="conf/bblayers.conf"
+    bb_layers_md5=".bb_layers_conf.md5"
+    bb_recipes=".bb_recipes"
+
+    _parse_recipes () {
+        bitbake -s | sed -e '0,/^=.*/d' -e '/^\s*$/d' -e '/^Summary:/d' | awk '{print $1}' > $bb_recipes
+    }
+
+    if [ ! -e $bb_layers_conf ]; then
+        return 0
+    fi
+
+    if [ "$prev" = "bitbake" -a "$cur" = "" ]; then
+        _parse_recipes
+    fi
+
+    md5sum --quiet --status -c $bb_layers_md5 2>/dev/null
+    if [ $? != 0 -o ! -e $bb_recipes ]; then
+         md5sum $bb_layers_conf > $bb_layers_md5
+         _parse_recipes
+    fi
+
+    recipes=$(cat $bb_recipes)
+
+    COMPREPLY=( $(compgen -W "${recipes}" -- ${cur}) )
+    return 0
+}
+complete -F _bitbake bitbake
\ No newline at end of file
diff --git a/contrib/completion/bash/bitbake_diffsigs_completion b/contrib/completion/bash/bitbake_diffsigs_completion
new file mode 100644
index 00000000..cbf2c5f1
--- /dev/null
+++ b/contrib/completion/bash/bitbake_diffsigs_completion
@@ -0,0 +1,86 @@
+#!bash
+# Bash completion support for bitbake-diffsigs tool,
+# compatible with Bitbake 1.39.1.
+#
+# Copyright (C) 2018 Lukasz Gardon <lukasz.gardon@gmail.com>
+#
+# Distributed under the MIT License (MIT)
+#
+
+_bitbake_diffsigs()
+{
+    local cur prev opts_short opts_long tasks colors
+    local bb_layers_conf bb_layers_md5 bb_recipes
+
+    COMPREPLY=()
+
+    cur="${COMP_WORDS[COMP_CWORD]}"
+    prev="${COMP_WORDS[COMP_CWORD-1]}"
+
+    opts_short="-h -d -t -s"
+
+    opts_long="--help --debug --color --task --signature"
+
+    tasks="build compile compile_ptest_base configure configure_ptest_base deploy \
+           distrodata fetch image image_complete install install_ptest_base package \
+           package_qa package_write_deb package_write_ipk package_write_rpm package_write_tar \
+           packagedata patch populate_lic populate_sdk populate_sysroot prepare_recipe_sysroot \
+           rm_work rm_work_all unpack checkpkg checkuri clean cleanall cleansstate devpyshell \
+           devshell listtasks package_index bootimg bundle_initramfs rootfs testimage \
+           testimage_auto compile_kernelmodules diffconfig kernel_checkout kernel_configcheck \
+           kernel_configme kernel_menuconfig kernel_metadata menuconfig savedefconfig shared_workdir \
+           sizecheck strip validate_branches spdx"
+
+    colors="auto always never"
+
+    case "$cur" in
+        "--"*)
+            COMPREPLY=( $(compgen -W "${opts_long}" -- ${cur}) )
+            return 0
+        ;;
+        "-"*)
+            COMPREPLY=( $(compgen -W "${opts_short}" -- ${cur}) )
+            return 0
+        ;;
+    esac
+
+    bb_layers_conf="conf/bblayers.conf"
+    bb_layers_md5=".bb_layers_conf.md5"
+    bb_recipes=".bb_recipes"
+
+    _parse_recipes () {
+        bitbake -s | sed -e '0,/^=.*/d' -e '/^\s*$/d' -e '/^Summary:/d' | awk '{print $1}' > $bb_recipes
+    }
+
+    if [ ! -e $bb_layers_conf ]; then
+        return 0
+    fi
+
+    if [ "$prev" = "bitbake" -a "$cur" = "" ]; then
+	    _parse_recipes
+    fi
+
+    md5sum --quiet --status -c $bb_layers_md5 2>/dev/null
+    if [ $? != 0 -o ! -e $bb_recipes ]; then
+        md5sum $bb_layers_conf > $bb_layers_md5
+        _parse_recipes
+    fi
+
+    recipes=$(cat $bb_recipes)
+
+    case "$prev" in
+        "-c"|"--color")
+            COMPREPLY=( $(compgen -W "${colors}" -- ${cur}) )
+            return 0
+        ;;
+        "-t"|"--task")
+	   COMPREPLY=( $(compgen -W "${recipes}" -- ${cur}) )
+	   return 0
+    esac
+
+    if [[ ${COMP_WORDS[COMP_CWORD -2]} == "-t" ]] || [[ ${COMP_WORDS[COMP_CWORD -2]} == "--task" ]]; then 
+        COMPREPLY=( $(compgen -W "${tasks}" -- ${cur}) )
+	    return 0
+    fi
+}
+complete -F _bitbake_diffsigs bitbake-diffsigs
\ No newline at end of file
diff --git a/contrib/completion/bash/bitbake_dumpsig_completion b/contrib/completion/bash/bitbake_dumpsig_completion
new file mode 100644
index 00000000..95eb2394
--- /dev/null
+++ b/contrib/completion/bash/bitbake_dumpsig_completion
@@ -0,0 +1,89 @@
+#!bash
+# Bash completion support for bitbake-dumpsig tool,
+# compatible with Bitbake 1.39.1.
+#
+# Copyright (C) 2018 Lukasz Gardon <lukasz.gardon@gmail.com>
+#
+# Distributed under the MIT License (MIT)
+#
+
+_bitbake_dumpsig()
+{
+    local cur prev opts_short opts_long tasks
+    local bb_layers_conf bb_layers_md5 bb_recipes
+
+    COMPREPLY=()
+
+    cur="${COMP_WORDS[COMP_CWORD]}"
+    prev="${COMP_WORDS[COMP_CWORD-1]}"
+
+    opts_short="-h -d -t"
+
+    opts_long="--help --debug --task="
+
+    tasks="build compile compile_ptest_base configure configure_ptest_base deploy \
+           distrodata fetch image image_complete install install_ptest_base package \
+           package_qa package_write_deb package_write_ipk package_write_rpm package_write_tar \
+           packagedata patch populate_lic populate_sdk populate_sysroot prepare_recipe_sysroot \
+           rm_work rm_work_all unpack checkpkg checkuri clean cleanall cleansstate devpyshell \
+           devshell listtasks package_index bootimg bundle_initramfs rootfs testimage \
+           testimage_auto compile_kernelmodules diffconfig kernel_checkout kernel_configcheck \
+           kernel_configme kernel_menuconfig kernel_metadata menuconfig savedefconfig shared_workdir \
+           sizecheck strip validate_branches spdx"
+
+    if [[ "$prev" == "=" ]]; then
+        prev="${COMP_WORDS[COMP_CWORD - 2]}"
+    elif [[ "$cur" == "=" ]]; then
+        cur=""
+    fi
+
+    case "$cur" in
+        "--"*)
+            COMPREPLY=( $(compgen -W "${opts_long}" -- ${cur}) )
+            if [[ ${#COMPREPLY[@]} == 1 && ${COMPREPLY[0]} == "--"*"=" ]] ; then
+                compopt -o nospace
+            fi
+            return 0
+        ;;
+        "-"*)
+            COMPREPLY=( $(compgen -W "${opts_short}" -- ${cur}) )
+            return 0
+        ;;
+    esac
+
+    bb_layers_conf="conf/bblayers.conf"
+    bb_layers_md5=".bb_layers_conf.md5"
+    bb_recipes=".bb_recipes"
+
+    _parse_recipes () {
+        bitbake -s | sed -e '0,/^=.*/d' -e '/^\s*$/d' -e '/^Summary:/d' | awk '{print $1}' > $bb_recipes    
+    }
+
+    if [ ! -e $bb_layers_conf ]; then
+        return 0
+    fi
+
+    if [ "$prev" = "bitbake" -a "$cur" = "" ]; then
+	    _parse_recipes
+    fi
+
+    md5sum --quiet --status -c $bb_layers_md5 2>/dev/null
+    if [ $? != 0 -o ! -e $bb_recipes ]; then
+        md5sum $bb_layers_conf > $bb_layers_md5
+        _parse_recipes
+    fi
+
+    recipes=$(cat $bb_recipes)
+
+    case "$prev" in
+        "-t"|"--task")
+	    COMPREPLY=( $(compgen -W "${recipes}" -- ${cur}) )
+	    return 0
+    esac
+
+    if [[ ${COMP_WORDS[COMP_CWORD -2]} =~ "-t" ]] || [[ ${COMP_WORDS[COMP_CWORD -3]} == "--task" ]]; then 
+        COMPREPLY=( $(compgen -W "${tasks}" -- ${cur}) )
+	    return 0
+    fi
+}
+complete -F _bitbake_dumpsig bitbake-dumpsig
\ No newline at end of file
diff --git a/contrib/completion/bash/bitbake_layers_completion b/contrib/completion/bash/bitbake_layers_completion
new file mode 100644
index 00000000..37ca8afb
--- /dev/null
+++ b/contrib/completion/bash/bitbake_layers_completion
@@ -0,0 +1,188 @@
+#!bash
+# Bash completion support for bitbake-layers tool,
+# compatible with Bitbake 1.39.1.
+#
+# Copyright (C) 2018 Lukasz Gardon <lukasz.gardon@gmail.com>
+#
+# Distributed under the MIT License (MIT)
+#
+
+_bitbake_layers()
+{
+    local cur prev opts_short opts_long subcommands colors
+    local opts_long_add_layer opts_short_add_layer opts_long_show_overlayed
+    local opts_short_show_overlayed opts_long_show_recipes opts_short_show_recipes
+    local opts_long_show_cross_depends opts_short_show_cross_depends
+    local opts_long_show_layerindex_fetch opts_short_show_layerindex_fetch
+    local opts_long_show_layerindex_show_depends opts_short_show_layerindex_show_depends
+    local opts_long_show_create_layer opts_short_show_create_layer bb_class_files classes
+
+    COMPREPLY=()
+
+    cur="${COMP_WORDS[COMP_CWORD]}"
+    prev="${COMP_WORDS[COMP_CWORD-1]}"
+
+    opts_short="-d -q -F -h"
+
+    opts_long="--debug --quiet --force --color --help"
+
+    subcommands="layerindex-fetch layerindex-show-depends add-layer \
+	             remove-layer flatten show-layers show-overlayed \
+		         show-recipes show-appends show-cross-depends \
+		         create-layer"
+
+    colors="auto always never" 
+
+    opts_long_show_overlayed="--help --filenames --same-version"
+    opts_short_show_overlayed="-h -f -s"
+
+    opts_long_show_recipes="--help --filenames --multiple --inherits"
+    opts_short_show_recipes="-h -f -m -i"
+
+    opts_long_show_layerindex_fetch="--help --show-only --branch --ignore"
+    opts_short_show_layerindex_fetch="-h -n -b -i"
+
+    opts_long_add_layer="--help --priority --example-recipe-name --example-recipe-version"
+    opts_short_add_layer="-h"
+
+    opts_long_show_cross_depends="--help --filenames --ignore"
+    opts_short_show_cross_depends="-h -f -i"
+
+    opts_long_show_layerindex_show_depends="--help --branch"
+    opts_short_show_layerindex_show_depends="-h -b"
+
+    opts_long_show_create_layer="--help --priority --example-recipe-name --example-recipe-version"
+    opts_short_show_create_layer="-h -p -e -v"
+
+    bb_class_files=".bb_class_files"
+
+    _get_classes() {
+        find $BBPATH/../meta*/classes/ -name *.bbclass -exec basename {} \; | sed 's/.bbclass//' > $bb_class_files
+    }
+
+    if [[ "${COMP_WORDS[@]}" =~ show-recipes ]] ; then
+        if [[ "$prev" == "--inherits" ]] || [[ "$prev" == "-i" ]]; then
+            _get_classes
+            classes=$(cat $bb_class_files)
+            COMPREPLY=( $(compgen -W "${classes}" -- ${cur}) )
+            return 0
+        fi
+    fi
+
+    if [[ "${COMP_WORDS[1]}" =~ show-layers|show-appends|remove-layer|flatten ]]; then
+        case "$cur" in
+            "--"*)
+                COMPREPLY=( $(compgen -W "--help" -- ${cur}) )
+                return 0
+            ;;
+            "-"*)
+                COMPREPLY=( $(compgen -W "-h" -- ${cur}) )
+                return 0
+            ;;
+        esac
+    elif [[ "${COMP_WORDS[1]}" == "add-layer" ]]; then
+        case "$cur" in
+            "--"*|"")
+                COMPREPLY=( $(compgen -W "${opts_long_add_layer}" -- ${cur}) )
+                return 0
+            ;;
+            "-"*)
+                COMPREPLY=( $(compgen -W "${opts_short_add_layer}" -- ${cur}) )
+                return 0
+            ;;
+        esac
+    elif [[ "${COMP_WORDS[1]}" == "show-overlayed" ]]; then
+        case "$cur" in
+            "--"*|"")
+                COMPREPLY=( $(compgen -W "${opts_long_show_overlayed}" -- ${cur}) )
+                return 0
+            ;;
+            "-"*)
+                COMPREPLY=( $(compgen -W "${opts_short_show_overlayed}" -- ${cur}) )
+                return 0
+            ;;
+        esac
+    elif [[ "${COMP_WORDS[1]}" == "show-recipes" ]]; then
+        case "$cur" in
+            "--"*|"")
+                COMPREPLY=( $(compgen -W "${opts_long_show_recipes}" -- ${cur}) )
+                return 0
+            ;;
+            "-"*)
+                COMPREPLY=( $(compgen -W "${opts_short_show_recipes}" -- ${cur}) )
+                return 0
+            ;;
+        esac
+    elif [[ "${COMP_WORDS[1]}" == "show-cross-depends" ]]; then
+        case "$cur" in
+            "--"*|"")
+                COMPREPLY=( $(compgen -W "${opts_long_show_cross_depends}" -- ${cur}) )
+                return 0
+            ;;
+            "-"*)
+                COMPREPLY=( $(compgen -W "${opts_short_show_cross_depends}" -- ${cur}) )
+                return 0
+            ;;
+        esac    
+    elif [[ "${COMP_WORDS[1]}" == "layerindex-fetch" ]]; then
+        case "$cur" in
+            "--"*|"")
+                COMPREPLY=( $(compgen -W "${opts_long_show_layerindex_fetch}" -- ${cur}) )
+                return 0
+            ;;
+            "-"*)
+                COMPREPLY=( $(compgen -W "${opts_short_show_layerindex_fetch}" -- ${cur}) )
+                return 0
+            ;;
+        esac    
+    elif [[ "${COMP_WORDS[1]}" == "layerindex-show-depends" ]]; then
+        case "$cur" in
+            "--"*|"")
+                COMPREPLY=( $(compgen -W "${opts_long_show_layerindex_show_depends}" -- ${cur}) )
+                return 0
+            ;;
+            "-"*)
+                COMPREPLY=( $(compgen -W "${opts_short_show_layerindex_show_depends}" -- ${cur}) )
+                return 0
+            ;;
+        esac
+    elif [[ "${COMP_WORDS[1]}" == "create-layer" ]]; then
+        case "$cur" in
+            "--"*|"")
+                COMPREPLY=( $(compgen -W "${opts_long_show_create_layer}" -- ${cur}) )
+                return 0
+            ;;
+            "-"*)
+                COMPREPLY=( $(compgen -W "${opts_short_show_create_layer}" -- ${cur}) )
+                return 0
+            ;;
+        esac                          
+    fi
+
+    case "$prev" in
+        "-c"|"--color")
+            COMPREPLY=( $(compgen -W "${colors}" -- ${cur}) )
+            return 0
+        ;;
+    esac
+
+    case "$cur" in
+        "--"*)
+            COMPREPLY=( $(compgen -W "${opts_long}" -- ${cur}) )
+            return 0
+        ;;
+        "-"*)
+            COMPREPLY=( $(compgen -W "${opts_short}" -- ${cur}) )
+            return 0
+        ;;
+    esac
+
+    if [[ ${prev} == "bitbake-layers" ]]; then
+        COMPREPLY=( $(compgen -W "${subcommands}" -- ${cur}) )
+        return 0
+    elif [[ ! ${subcommands} =~ [[:space:]]${cur}[[:space:]] ]]; then
+        COMPREPLY=( $(compgen -W "${subcommands}" -- ${cur}) )
+        return 0
+    fi
+}
+complete -F _bitbake_layers bitbake-layers
\ No newline at end of file
diff --git a/contrib/completion/bash/bitbake_prserv_completion b/contrib/completion/bash/bitbake_prserv_completion
new file mode 100644
index 00000000..3bca1197
--- /dev/null
+++ b/contrib/completion/bash/bitbake_prserv_completion
@@ -0,0 +1,76 @@
+#!bash
+# Bash completion support for bitbake-prserv tool,
+# compatible with Bitbake 1.39.1.
+#
+# Copyright (C) 2018 Lukasz Gardon <lukasz.gardon@gmail.com>
+#
+# Distributed under the MIT License (MIT)
+#
+
+_bitbake_prserv()
+{
+    local cur prev opts_short opts_long subcommands file_default log_default log_levels
+
+    COMPREPLY=()
+
+    cur="${COMP_WORDS[COMP_CWORD]}"
+    prev="${COMP_WORDS[COMP_CWORD-1]}"
+
+    opts_short="-h -f -l"
+
+    opts_long="--version --help --file= --log= --loglevel= --start \
+	           --stop --host= --port="
+
+    subcommands="layerindex-fetch layerindex-show-depends add-layer \
+	             remove-layer flatten show-layers show-overlayed \
+		         show-recipes show-appends show-cross-depends \
+		         create-layer"
+
+    file_default="prserv.sqlite3"
+    log_default="prserv.log"
+    log_levels="CRITICAL ERROR WARNING INFO DEBUG"
+
+    if [[ "$prev" == "=" ]]; then
+        prev="${COMP_WORDS[COMP_CWORD -2]}"
+    elif [[ "$cur" == "=" ]]; then
+        cur=""
+    fi
+
+    case "$prev" in
+        "-f"|"--file")
+            COMPREPLY=( $(compgen -W "${file_default}" -- ${cur}) )
+            return 0
+        ;;
+        "-l"|"--log")
+            COMPREPLY=( $(compgen -W "${log_default}" -- ${cur}) )
+            return 0
+        ;;
+        "--loglevel")
+            COMPREPLY=( $(compgen -W "${log_levels}" -- ${cur}) )
+            return 0
+        ;;
+    esac
+
+    case "$cur" in
+        "--"*|"")
+            COMPREPLY=( $(compgen -W "${opts_long}" -- ${cur}) )
+            if [[ ${#COMPREPLY[@]} == 1 && ${COMPREPLY[0]} == "--"*"=" ]] ; then
+                compopt -o nospace
+            fi
+            return 0
+        ;;
+        "-"*)
+            COMPREPLY=( $(compgen -W "${opts_short}" -- ${cur}) )
+            return 0
+        ;;
+    esac
+
+    if [[ ${prev} == "bitbake-layers" ]]; then
+        COMPREPLY=( $(compgen -W "${subcommands}" -- ${cur}) )
+        return 0
+    elif [[ ! ${subcommands} =~ [[:space:]]${cur}[[:space:]] ]]; then
+        COMPREPLY=( $(compgen -W "${subcommands}" -- ${cur}) )
+        return 0
+    fi
+}
+complete -F _bitbake_prserv bitbake-prserv
\ No newline at end of file
diff --git a/contrib/completion/bash/bitbake_selftest_completion b/contrib/completion/bash/bitbake_selftest_completion
new file mode 100644
index 00000000..8b6bf641
--- /dev/null
+++ b/contrib/completion/bash/bitbake_selftest_completion
@@ -0,0 +1,34 @@
+#!bash
+# Bash completion support for bitbake-selftest tool,
+# compatible with Bitbake version 1.39.1.
+#
+# Copyright (C) 2018 Lukasz Gardon <lukasz.gardon@gmail.com>
+#
+# Distributed under the MIT License (MIT)
+#
+
+_bitbake_selftest()
+{
+    local cur prev opts_short opts_long
+
+    COMPREPLY=()
+
+    cur="${COMP_WORDS[COMP_CWORD]}"
+    prev="${COMP_WORDS[COMP_CWORD-1]}"
+
+    opts_short="-h -v -q -f -c"
+
+    opts_long="--help --verbose --quiet --locals --failfast --catch"
+
+    case "$cur" in
+        "--"*)
+            COMPREPLY=( $(compgen -W "${opts_long}" -- ${cur}) )
+            return 0
+        ;;
+        "-"*)
+            COMPREPLY=( $(compgen -W "${opts_short}" -- ${cur}) )
+            return 0
+        ;;
+    esac
+}
+complete -F _bitbake_selftest bitbake-selftest
\ No newline at end of file
-- 
2.18.0


