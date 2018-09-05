Return-Path: <lukaszgardon555@gmail.com>
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
	by mail.openembedded.org (Postfix) with ESMTP id EFB1A78D34
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  5 Sep 2018 17:24:09 +0000 (UTC)
Received: by mail-wm0-f46.google.com with SMTP id n11-v6so8537245wmc.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 05 Sep 2018 10:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:mime-version:subject:date:references:to:in-reply-to:message-id; 
	bh=aEojqXnZhju6Sv68ymCAPqrWFIVA30aVV/UNdvQwuCQ=;
	b=GtQAtut4J0TgDJmSkN2tu031n284INQp9/HycNuWFuItXzhl6znZV23+GHUYZ6lgqD
	N3IiOwfPatWemNHDZaGZaedzFjlBjR/fjil9T5KV1HmWSVw1CMw6PRZfKk9SkYmRVadB
	rQw1TZDt1D4N0WNuvLrkQc3sKh9WtPIYgXAhR/M5nW0rGzvjZRChIQD85/SpbJtNSX/B
	YIbrXXwGvtMTaGC+XO/7grfVqOO0IU9XdRhsGUcyaiszM1WmNR2PsFONQcxOaLrLe70x
	MCvh49jUft+XSGafr/lqCGpvb45pBs/4QIdgVYru27DNXTmXGDxf1Eq+GkixLVeLdkGJ
	gDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:mime-version:subject:date:references:to
	:in-reply-to:message-id;
	bh=aEojqXnZhju6Sv68ymCAPqrWFIVA30aVV/UNdvQwuCQ=;
	b=fiqxxqLfI8Y6gkOx5we6pMzPuF0xlDnY0/Iw3ONQzT3u55zeknl7eUT3OygRLRg+3g
	JMx53Bpkt03aVZd3Gz/YOuTCCOYfktDuIcOoN7DTSm0eaiwoKO7QEQ+7kHE7YFQMAMFX
	qEXoCMsJZm25On7pJWfIwGxeo25Sm7Osc22Jcm2oDGKbu+T8L9qSGlV1xorDrBg0mkE3
	1i1Nd3z3BcU4jRua+CcTY0cKxG5EFESZcRZa5HckHZ0pyN7dV7r5J1HA1GGM1J8Z4Q11
	o7unlhAAjKdYDaG89JnR7XJRL6FOM9zZBRxY5LgvdS6ImP/QYsTYspzeuwo6MA5cE1Vl
	rp/w==
X-Gm-Message-State: APzg51A1aG/Bgw/Qy0pQPF03NKrqMnGW3Qpa35UtNyh5gJB4UHhTFjhV
	FKc0/Ep8qaxTtEV0wWdFruU=
X-Google-Smtp-Source: ANB0VdbptlWbhxlN4OH3gBbZtdBzwiQTlACyobnDOb2uUEq6cI2eR9NyuCkXxSC3W3QJupTH7PmzLQ==
X-Received: by 2002:a1c:114:: with SMTP id 20-v6mr836032wmb.4.1536168250621;
	Wed, 05 Sep 2018 10:24:10 -0700 (PDT)
Received: from [192.168.1.180] (public-gprs206918.centertel.pl.
	[46.134.147.135]) by smtp.gmail.com with ESMTPSA id
	o3-v6sm3609339wrn.58.2018.09.05.10.24.08
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Sep 2018 10:24:09 -0700 (PDT)
From: =?utf-8?B?xYF1a2FzeiBHYXJkb8WE?= <lukaszgardon555@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Date: Wed, 5 Sep 2018 19:24:06 +0200
References: <20180901133644.1577-1-lukaszgardon555@gmail.com>
	<CANNYZj9-ybLPr=kNLEGFgdPG1U_kNJEEVzCw_5FiYUPYVVQQYw@mail.gmail.com>
	<94B3180E-9326-43AC-9780-39A3E2D9F850@gmail.com>
	<CANNYZj9UY7rrTySn-ctmd0u+OGnneB+p_nH=OvXe35L+JB-Zzg@mail.gmail.com>
	<1577859A-5F16-4E3F-8C23-1ECB099AB770@gmail.com>
	<7679349B-ECD4-4895-BE9D-052E4674408C@gmail.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>,
	bitbake-devel@lists.openembedded.org, richard.purdie@linuxfoundation.org
In-Reply-To: <7679349B-ECD4-4895-BE9D-052E4674408C@gmail.com>
Message-Id: <CC13D61A-9A15-4BD7-B8F8-531EC354D62A@gmail.com>
X-Mailer: Apple Mail (2.3445.9.1)
X-Mailman-Approved-At: Mon, 10 Sep 2018 11:15:27 +0000
Subject: Re: Add files supporting bash completion for bitbake tools
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
X-List-Received-Date: Wed, 05 Sep 2018 17:24:10 -0000
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_2B0A5304-1D20-4A5A-B471-889CC96C54E0"

--Apple-Mail=_2B0A5304-1D20-4A5A-B471-889CC96C54E0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Richard, may I ask You kindly help here to decide if such files should =
be stored in bitbake repository ?

And I see that I used --subject-prefix=3D"[bitbake-devel]=E2=80=9D  flag =
while uploading patch, that cause to add additional "[ ]" to topic:
[[bitbake-devel]] Add files supporting bash completion for bitbake tools
Generally I can=E2=80=99t see my patch in the patchwork, It means that I =
should try again upload this changes to be sure that will be in =
patchwork properly ?

> Wiadomo=C5=9B=C4=87 napisana przez =C5=81ukasz Gardo=C5=84 =
<lukaszgardon555@gmail.com> w dniu 03.09.2018, o godz. 21:25:
>=20
> Add missed bitbake-devel@lists.openembedded.org =
<mailto:bitbake-devel@lists.openembedded.org> mailing group to this =
thread.
>=20
>> Wiadomo=C5=9B=C4=87 napisana przez =C5=81ukasz Gardo=C5=84 =
<lukaszgardon555@gmail.com <mailto:lukaszgardon555@gmail.com>> w dniu =
03.09.2018, o godz. 21:22:
>>=20
>> Hi Alex,
>>=20
>> thank=E2=80=99s for Your suggestion but for in my opinion keeping =
this files in bitbake repository is the better place.
>> I would not know to find/search such completion files in =
bash-completion or any other place.
>> What about vim plugin which is stored in contrib/ dir[1] and which is =
also comes from dedicated repo[2] same thing.
>>=20
>> Anyway, could someone from project architects could comment and help =
here ?
>>=20
>> [1] vim bitbake plugin in bitbake: =
https://github.com/openembedded/bitbake/tree/master/contrib/vim =
<https://github.com/openembedded/bitbake/tree/master/contrib/vim>
>> [2] vim bitbake plugin repo: https://github.com/kergoth/vim-bitbake =
<https://github.com/kergoth/vim-bitbake>
>>=20
>>> Wiadomo=C5=9B=C4=87 napisana przez Alexander Kanavin =
<alex.kanavin@gmail.com <mailto:alex.kanavin@gmail.com>> w dniu =
03.09.2018, o godz. 11:25:
>>>=20
>>> Hello Lukasz,
>>>=20
>>> nobody will find your contributions in bitbake/contrib, and so they
>>> will be unused and will bitrot. The proper place is the upstream
>>> bash-completion project, which will get picked up by all Linux
>>> distributions.
>>>=20
>>> Alex
>>>=20
>>> 2018-09-02 12:27 GMT+02:00 =C5=81ukasz Gardo=C5=84 =
<lukaszgardon555@gmail.com <mailto:lukaszgardon555@gmail.com>>:
>>>> Hi Alex,
>>>>=20
>>>> With information comes file from bitbake repository -
>>>> bitbake/contrib/README: "This directory is for additional =
contributed files
>>>> which may be useful.=E2=80=9D.
>>>> I think that this is proper place for such files.
>>>>=20
>>>> Wiadomo=C5=9B=C4=87 napisana przez Alexander Kanavin =
<alex.kanavin@gmail.com <mailto:alex.kanavin@gmail.com>> w dniu
>>>> 01.09.2018, o godz. 21:33:
>>>>=20
>>>> The right upstream destination for this is almost certainly
>>>> https://github.com/scop/bash-completion =
<https://github.com/scop/bash-completion>
>>>>=20
>>>> Alex
>>>>=20
>>>> 2018-09-01 15:36 GMT+02:00 =C5=81ukasz Gardo=C5=84 =
<lukaszgardon555@gmail.com <mailto:lukaszgardon555@gmail.com>>:
>>>>=20
>>>> Repository with more details:
>>>> https://github.com/lukaszgard/bitbake-completion =
<https://github.com/lukaszgard/bitbake-completion>
>>>>=20
>>>> Signed-off-by: =C5=81ukasz Gardo=C5=84 <lukaszgardon555@gmail.com>
>>>> ---
>>>> contrib/completion/bash/bitbake_completion    | 108 ++++++++++
>>>> .../bash/bitbake_diffsigs_completion          |  86 ++++++++
>>>> .../bash/bitbake_dumpsig_completion           |  89 +++++++++
>>>> .../completion/bash/bitbake_layers_completion | 188 =
++++++++++++++++++
>>>> .../completion/bash/bitbake_prserv_completion |  76 +++++++
>>>> .../bash/bitbake_selftest_completion          |  34 ++++
>>>> 6 files changed, 581 insertions(+)
>>>> create mode 100644 contrib/completion/bash/bitbake_completion
>>>> create mode 100644 =
contrib/completion/bash/bitbake_diffsigs_completion
>>>> create mode 100644 =
contrib/completion/bash/bitbake_dumpsig_completion
>>>> create mode 100644 =
contrib/completion/bash/bitbake_layers_completion
>>>> create mode 100644 =
contrib/completion/bash/bitbake_prserv_completion
>>>> create mode 100644 =
contrib/completion/bash/bitbake_selftest_completion
>>>>=20
>>>> diff --git a/contrib/completion/bash/bitbake_completion
>>>> b/contrib/completion/bash/bitbake_completion
>>>> new file mode 100644
>>>> index 00000000..23cadf6e
>>>> --- /dev/null
>>>> +++ b/contrib/completion/bash/bitbake_completion
>>>> @@ -0,0 +1,108 @@
>>>> +#!bash
>>>> +# Bash completion support for bitbake 1.39.1 release.
>>>> +#
>>>> +# Copyright (C) 2014 Sergio Prado <sergio.prado@e-labworks.com>
>>>> +# Copyright (C) 2018 Lukasz Gardon <lukasz.gardon@gmail.com>
>>>> +#
>>>> +# Distributed under the MIT License (MIT)
>>>> +#
>>>> +
>>>> +_bitbake()
>>>> +{
>>>> +    local cur prev opts_short opts_long tasks recipes ui
>>>> +    local bb_layers_conf bb_layers_md5 bb_recipes
>>>> +
>>>> +    COMPREPLY=3D()
>>>> +
>>>> +    cur=3D"${COMP_WORDS[COMP_CWORD]}"
>>>> +    prev=3D"${COMP_WORDS[COMP_CWORD-1]}"
>>>> +
>>>> +    opts_short=3D"-h -b -k -f -c -C -r -R -v -D -q -n -S -p -s -e =
-g -I \
>>>> +                -l -P -u -B -T -m -w"
>>>> +
>>>> +    opts_long=3D"--version --help --buildfile=3D --continue =
--force --cmd=3D \
>>>> +               --clear-stamp=3D --read=3D --postread=3D --verbose =
--debug --quiet
>>>> \
>>>> +               --dry-run --dump-signatures=3D --parse-only =
--show-versions \
>>>> +               --environment --graphviz --ignore-deps=3D =
--log-domains=3D
>>>> --profile \
>>>> +               --ui=3D --token=3D --revisions-changed =
--server-only --bind=3D \
>>>> +               --idle-timeout=3D --no-setscene --setscene-only
>>>> --remote-server=3D \
>>>> +               --kill-server --observe-only --status-only =
--write-log=3D
>>>> --runall=3D \
>>>> +               --runonly=3D"
>>>> +
>>>> +    tasks=3D"build compile compile_ptest_base configure =
configure_ptest_base
>>>> deploy \
>>>> +           distrodata fetch image image_complete install =
install_ptest_base
>>>> package \
>>>> +           package_qa package_write_deb package_write_ipk =
package_write_rpm
>>>> package_write_tar \
>>>> +           packagedata patch populate_lic populate_sdk =
populate_sysroot
>>>> prepare_recipe_sysroot \
>>>> +           rm_work rm_work_all unpack checkpkg checkuri clean =
cleanall
>>>> cleansstate devpyshell \
>>>> +           devshell listtasks package_index bootimg =
bundle_initramfs rootfs
>>>> testimage \
>>>> +           testimage_auto compile_kernelmodules diffconfig =
kernel_checkout
>>>> kernel_configcheck \
>>>> +           kernel_configme kernel_menuconfig kernel_metadata =
menuconfig
>>>> savedefconfig shared_workdir \
>>>> +           sizecheck strip validate_branches spdx"
>>>> +
>>>> +    ui=3D"knotty ncurses taskexp"
>>>> +
>>>> +    if [[ "$prev" =3D=3D "=3D" ]]; then
>>>> +        prev=3D"${COMP_WORDS[COMP_CWORD - 2]}"
>>>> +    elif [[ "$cur" =3D=3D "=3D" ]]; then
>>>> +        cur=3D""
>>>> +    fi
>>>> +
>>>> +    conf_files=3D$(find . -maxdepth 1 -name "*.conf" -type f =
-printf '%P\n')
>>>> +
>>>> +    case "$prev" in
>>>> +
>>>> =
"-c"|"--cmd"|"-C"|"--clear-stamp"|"--ignore-deps"|"--runall"|"--runonly")
>>>> +            COMPREPLY=3D( $(compgen -W "${tasks}" -- ${cur}) )
>>>> +            return 0
>>>> +        ;;
>>>> +        "-r"|"--read"|"-R"|"--postread")
>>>> +            COMPREPLY=3D( $(compgen -W "${conf_files}" -- ${cur}) =
)
>>>> +            return 0
>>>> +        ;;
>>>> +        "-u"|"--ui")
>>>> +            COMPREPLY=3D( $(compgen -W "${ui}" -- ${cur}) )
>>>> +            return 0
>>>> +        ;;
>>>> +    esac
>>>> +
>>>> +    case "$cur" in
>>>> +        "--"*)
>>>> +            COMPREPLY=3D( $(compgen -W "${opts_long}" -- ${cur}) )
>>>> +            if [[ ${#COMPREPLY[@]} =3D=3D 1 && ${COMPREPLY[0]} =3D=3D=
 "--"*"=3D" ]] ;
>>>> then
>>>> +                compopt -o nospace
>>>> +            fi
>>>> +            return 0
>>>> +        ;;
>>>> +        "-"*)
>>>> +            COMPREPLY=3D( $(compgen -W "${opts_short}" -- ${cur}) =
)
>>>> +            return 0
>>>> +        ;;
>>>> +    esac
>>>> +
>>>> +    bb_layers_conf=3D"conf/bblayers.conf"
>>>> +    bb_layers_md5=3D".bb_layers_conf.md5"
>>>> +    bb_recipes=3D".bb_recipes"
>>>> +
>>>> +    _parse_recipes () {
>>>> +        bitbake -s | sed -e '0,/^=3D.*/d' -e '/^\s*$/d' -e =
'/^Summary:/d' |
>>>> awk '{print $1}' > $bb_recipes
>>>> +    }
>>>> +
>>>> +    if [ ! -e $bb_layers_conf ]; then
>>>> +        return 0
>>>> +    fi
>>>> +
>>>> +    if [ "$prev" =3D "bitbake" -a "$cur" =3D "" ]; then
>>>> +        _parse_recipes
>>>> +    fi
>>>> +
>>>> +    md5sum --quiet --status -c $bb_layers_md5 2>/dev/null
>>>> +    if [ $? !=3D 0 -o ! -e $bb_recipes ]; then
>>>> +         md5sum $bb_layers_conf > $bb_layers_md5
>>>> +         _parse_recipes
>>>> +    fi
>>>> +
>>>> +    recipes=3D$(cat $bb_recipes)
>>>> +
>>>> +    COMPREPLY=3D( $(compgen -W "${recipes}" -- ${cur}) )
>>>> +    return 0
>>>> +}
>>>> +complete -F _bitbake bitbake
>>>> \ No newline at end of file
>>>> diff --git a/contrib/completion/bash/bitbake_diffsigs_completion
>>>> b/contrib/completion/bash/bitbake_diffsigs_completion
>>>> new file mode 100644
>>>> index 00000000..cbf2c5f1
>>>> --- /dev/null
>>>> +++ b/contrib/completion/bash/bitbake_diffsigs_completion
>>>> @@ -0,0 +1,86 @@
>>>> +#!bash
>>>> +# Bash completion support for bitbake-diffsigs tool,
>>>> +# compatible with Bitbake 1.39.1.
>>>> +#
>>>> +# Copyright (C) 2018 Lukasz Gardon <lukasz.gardon@gmail.com>
>>>> +#
>>>> +# Distributed under the MIT License (MIT)
>>>> +#
>>>> +
>>>> +_bitbake_diffsigs()
>>>> +{
>>>> +    local cur prev opts_short opts_long tasks colors
>>>> +    local bb_layers_conf bb_layers_md5 bb_recipes
>>>> +
>>>> +    COMPREPLY=3D()
>>>> +
>>>> +    cur=3D"${COMP_WORDS[COMP_CWORD]}"
>>>> +    prev=3D"${COMP_WORDS[COMP_CWORD-1]}"
>>>> +
>>>> +    opts_short=3D"-h -d -t -s"
>>>> +
>>>> +    opts_long=3D"--help --debug --color --task --signature"
>>>> +
>>>> +    tasks=3D"build compile compile_ptest_base configure =
configure_ptest_base
>>>> deploy \
>>>> +           distrodata fetch image image_complete install =
install_ptest_base
>>>> package \
>>>> +           package_qa package_write_deb package_write_ipk =
package_write_rpm
>>>> package_write_tar \
>>>> +           packagedata patch populate_lic populate_sdk =
populate_sysroot
>>>> prepare_recipe_sysroot \
>>>> +           rm_work rm_work_all unpack checkpkg checkuri clean =
cleanall
>>>> cleansstate devpyshell \
>>>> +           devshell listtasks package_index bootimg =
bundle_initramfs rootfs
>>>> testimage \
>>>> +           testimage_auto compile_kernelmodules diffconfig =
kernel_checkout
>>>> kernel_configcheck \
>>>> +           kernel_configme kernel_menuconfig kernel_metadata =
menuconfig
>>>> savedefconfig shared_workdir \
>>>> +           sizecheck strip validate_branches spdx"
>>>> +
>>>> +    colors=3D"auto always never"
>>>> +
>>>> +    case "$cur" in
>>>> +        "--"*)
>>>> +            COMPREPLY=3D( $(compgen -W "${opts_long}" -- ${cur}) )
>>>> +            return 0
>>>> +        ;;
>>>> +        "-"*)
>>>> +            COMPREPLY=3D( $(compgen -W "${opts_short}" -- ${cur}) =
)
>>>> +            return 0
>>>> +        ;;
>>>> +    esac
>>>> +
>>>> +    bb_layers_conf=3D"conf/bblayers.conf"
>>>> +    bb_layers_md5=3D".bb_layers_conf.md5"
>>>> +    bb_recipes=3D".bb_recipes"
>>>> +
>>>> +    _parse_recipes () {
>>>> +        bitbake -s | sed -e '0,/^=3D.*/d' -e '/^\s*$/d' -e =
'/^Summary:/d' |
>>>> awk '{print $1}' > $bb_recipes
>>>> +    }
>>>> +
>>>> +    if [ ! -e $bb_layers_conf ]; then
>>>> +        return 0
>>>> +    fi
>>>> +
>>>> +    if [ "$prev" =3D "bitbake" -a "$cur" =3D "" ]; then
>>>> +           _parse_recipes
>>>> +    fi
>>>> +
>>>> +    md5sum --quiet --status -c $bb_layers_md5 2>/dev/null
>>>> +    if [ $? !=3D 0 -o ! -e $bb_recipes ]; then
>>>> +        md5sum $bb_layers_conf > $bb_layers_md5
>>>> +        _parse_recipes
>>>> +    fi
>>>> +
>>>> +    recipes=3D$(cat $bb_recipes)
>>>> +
>>>> +    case "$prev" in
>>>> +        "-c"|"--color")
>>>> +            COMPREPLY=3D( $(compgen -W "${colors}" -- ${cur}) )
>>>> +            return 0
>>>> +        ;;
>>>> +        "-t"|"--task")
>>>> +          COMPREPLY=3D( $(compgen -W "${recipes}" -- ${cur}) )
>>>> +          return 0
>>>> +    esac
>>>> +
>>>> +    if [[ ${COMP_WORDS[COMP_CWORD -2]} =3D=3D "-t" ]] || [[
>>>> ${COMP_WORDS[COMP_CWORD -2]} =3D=3D "--task" ]]; then
>>>> +        COMPREPLY=3D( $(compgen -W "${tasks}" -- ${cur}) )
>>>> +           return 0
>>>> +    fi
>>>> +}
>>>> +complete -F _bitbake_diffsigs bitbake-diffsigs
>>>> \ No newline at end of file
>>>> diff --git a/contrib/completion/bash/bitbake_dumpsig_completion
>>>> b/contrib/completion/bash/bitbake_dumpsig_completion
>>>> new file mode 100644
>>>> index 00000000..95eb2394
>>>> --- /dev/null
>>>> +++ b/contrib/completion/bash/bitbake_dumpsig_completion
>>>> @@ -0,0 +1,89 @@
>>>> +#!bash
>>>> +# Bash completion support for bitbake-dumpsig tool,
>>>> +# compatible with Bitbake 1.39.1.
>>>> +#
>>>> +# Copyright (C) 2018 Lukasz Gardon <lukasz.gardon@gmail.com>
>>>> +#
>>>> +# Distributed under the MIT License (MIT)
>>>> +#
>>>> +
>>>> +_bitbake_dumpsig()
>>>> +{
>>>> +    local cur prev opts_short opts_long tasks
>>>> +    local bb_layers_conf bb_layers_md5 bb_recipes
>>>> +
>>>> +    COMPREPLY=3D()
>>>> +
>>>> +    cur=3D"${COMP_WORDS[COMP_CWORD]}"
>>>> +    prev=3D"${COMP_WORDS[COMP_CWORD-1]}"
>>>> +
>>>> +    opts_short=3D"-h -d -t"
>>>> +
>>>> +    opts_long=3D"--help --debug --task=3D"
>>>> +
>>>> +    tasks=3D"build compile compile_ptest_base configure =
configure_ptest_base
>>>> deploy \
>>>> +           distrodata fetch image image_complete install =
install_ptest_base
>>>> package \
>>>> +           package_qa package_write_deb package_write_ipk =
package_write_rpm
>>>> package_write_tar \
>>>> +           packagedata patch populate_lic populate_sdk =
populate_sysroot
>>>> prepare_recipe_sysroot \
>>>> +           rm_work rm_work_all unpack checkpkg checkuri clean =
cleanall
>>>> cleansstate devpyshell \
>>>> +           devshell listtasks package_index bootimg =
bundle_initramfs rootfs
>>>> testimage \
>>>> +           testimage_auto compile_kernelmodules diffconfig =
kernel_checkout
>>>> kernel_configcheck \
>>>> +           kernel_configme kernel_menuconfig kernel_metadata =
menuconfig
>>>> savedefconfig shared_workdir \
>>>> +           sizecheck strip validate_branches spdx"
>>>> +
>>>> +    if [[ "$prev" =3D=3D "=3D" ]]; then
>>>> +        prev=3D"${COMP_WORDS[COMP_CWORD - 2]}"
>>>> +    elif [[ "$cur" =3D=3D "=3D" ]]; then
>>>> +        cur=3D""
>>>> +    fi
>>>> +
>>>> +    case "$cur" in
>>>> +        "--"*)
>>>> +            COMPREPLY=3D( $(compgen -W "${opts_long}" -- ${cur}) )
>>>> +            if [[ ${#COMPREPLY[@]} =3D=3D 1 && ${COMPREPLY[0]} =3D=3D=
 "--"*"=3D" ]] ;
>>>> then
>>>> +                compopt -o nospace
>>>> +            fi
>>>> +            return 0
>>>> +        ;;
>>>> +        "-"*)
>>>> +            COMPREPLY=3D( $(compgen -W "${opts_short}" -- ${cur}) =
)
>>>> +            return 0
>>>> +        ;;
>>>> +    esac
>>>> +
>>>> +    bb_layers_conf=3D"conf/bblayers.conf"
>>>> +    bb_layers_md5=3D".bb_layers_conf.md5"
>>>> +    bb_recipes=3D".bb_recipes"
>>>> +
>>>> +    _parse_recipes () {
>>>> +        bitbake -s | sed -e '0,/^=3D.*/d' -e '/^\s*$/d' -e =
'/^Summary:/d' |
>>>> awk '{print $1}' > $bb_recipes
>>>> +    }
>>>> +
>>>> +    if [ ! -e $bb_layers_conf ]; then
>>>> +        return 0
>>>> +    fi
>>>> +
>>>> +    if [ "$prev" =3D "bitbake" -a "$cur" =3D "" ]; then
>>>> +           _parse_recipes
>>>> +    fi
>>>> +
>>>> +    md5sum --quiet --status -c $bb_layers_md5 2>/dev/null
>>>> +    if [ $? !=3D 0 -o ! -e $bb_recipes ]; then
>>>> +        md5sum $bb_layers_conf > $bb_layers_md5
>>>> +        _parse_recipes
>>>> +    fi
>>>> +
>>>> +    recipes=3D$(cat $bb_recipes)
>>>> +
>>>> +    case "$prev" in
>>>> +        "-t"|"--task")
>>>> +           COMPREPLY=3D( $(compgen -W "${recipes}" -- ${cur}) )
>>>> +           return 0
>>>> +    esac
>>>> +
>>>> +    if [[ ${COMP_WORDS[COMP_CWORD -2]} =3D~ "-t" ]] || [[
>>>> ${COMP_WORDS[COMP_CWORD -3]} =3D=3D "--task" ]]; then
>>>> +        COMPREPLY=3D( $(compgen -W "${tasks}" -- ${cur}) )
>>>> +           return 0
>>>> +    fi
>>>> +}
>>>> +complete -F _bitbake_dumpsig bitbake-dumpsig
>>>> \ No newline at end of file
>>>> diff --git a/contrib/completion/bash/bitbake_layers_completion
>>>> b/contrib/completion/bash/bitbake_layers_completion
>>>> new file mode 100644
>>>> index 00000000..37ca8afb
>>>> --- /dev/null
>>>> +++ b/contrib/completion/bash/bitbake_layers_completion
>>>> @@ -0,0 +1,188 @@
>>>> +#!bash
>>>> +# Bash completion support for bitbake-layers tool,
>>>> +# compatible with Bitbake 1.39.1.
>>>> +#
>>>> +# Copyright (C) 2018 Lukasz Gardon <lukasz.gardon@gmail.com>
>>>> +#
>>>> +# Distributed under the MIT License (MIT)
>>>> +#
>>>> +
>>>> +_bitbake_layers()
>>>> +{
>>>> +    local cur prev opts_short opts_long subcommands colors
>>>> +    local opts_long_add_layer opts_short_add_layer =
opts_long_show_overlayed
>>>> +    local opts_short_show_overlayed opts_long_show_recipes
>>>> opts_short_show_recipes
>>>> +    local opts_long_show_cross_depends =
opts_short_show_cross_depends
>>>> +    local opts_long_show_layerindex_fetch =
opts_short_show_layerindex_fetch
>>>> +    local opts_long_show_layerindex_show_depends
>>>> opts_short_show_layerindex_show_depends
>>>> +    local opts_long_show_create_layer opts_short_show_create_layer
>>>> bb_class_files classes
>>>> +
>>>> +    COMPREPLY=3D()
>>>> +
>>>> +    cur=3D"${COMP_WORDS[COMP_CWORD]}"
>>>> +    prev=3D"${COMP_WORDS[COMP_CWORD-1]}"
>>>> +
>>>> +    opts_short=3D"-d -q -F -h"
>>>> +
>>>> +    opts_long=3D"--debug --quiet --force --color --help"
>>>> +
>>>> +    subcommands=3D"layerindex-fetch layerindex-show-depends =
add-layer \
>>>> +                    remove-layer flatten show-layers =
show-overlayed \
>>>> +                        show-recipes show-appends =
show-cross-depends \
>>>> +                        create-layer"
>>>> +
>>>> +    colors=3D"auto always never"
>>>> +
>>>> +    opts_long_show_overlayed=3D"--help --filenames --same-version"
>>>> +    opts_short_show_overlayed=3D"-h -f -s"
>>>> +
>>>> +    opts_long_show_recipes=3D"--help --filenames --multiple =
--inherits"
>>>> +    opts_short_show_recipes=3D"-h -f -m -i"
>>>> +
>>>> +    opts_long_show_layerindex_fetch=3D"--help --show-only --branch =
--ignore"
>>>> +    opts_short_show_layerindex_fetch=3D"-h -n -b -i"
>>>> +
>>>> +    opts_long_add_layer=3D"--help --priority --example-recipe-name
>>>> --example-recipe-version"
>>>> +    opts_short_add_layer=3D"-h"
>>>> +
>>>> +    opts_long_show_cross_depends=3D"--help --filenames --ignore"
>>>> +    opts_short_show_cross_depends=3D"-h -f -i"
>>>> +
>>>> +    opts_long_show_layerindex_show_depends=3D"--help --branch"
>>>> +    opts_short_show_layerindex_show_depends=3D"-h -b"
>>>> +
>>>> +    opts_long_show_create_layer=3D"--help --priority =
--example-recipe-name
>>>> --example-recipe-version"
>>>> +    opts_short_show_create_layer=3D"-h -p -e -v"
>>>> +
>>>> +    bb_class_files=3D".bb_class_files"
>>>> +
>>>> +    _get_classes() {
>>>> +        find $BBPATH/../meta*/classes/ -name *.bbclass -exec =
basename {} \;
>>>> | sed 's/.bbclass//' > $bb_class_files
>>>> +    }
>>>> +
>>>> +    if [[ "${COMP_WORDS[@]}" =3D~ show-recipes ]] ; then
>>>> +        if [[ "$prev" =3D=3D "--inherits" ]] || [[ "$prev" =3D=3D =
"-i" ]]; then
>>>> +            _get_classes
>>>> +            classes=3D$(cat $bb_class_files)
>>>> +            COMPREPLY=3D( $(compgen -W "${classes}" -- ${cur}) )
>>>> +            return 0
>>>> +        fi
>>>> +    fi
>>>> +
>>>> +    if [[ "${COMP_WORDS[1]}" =3D~
>>>> show-layers|show-appends|remove-layer|flatten ]]; then
>>>> +        case "$cur" in
>>>> +            "--"*)
>>>> +                COMPREPLY=3D( $(compgen -W "--help" -- ${cur}) )
>>>> +                return 0
>>>> +            ;;
>>>> +            "-"*)
>>>> +                COMPREPLY=3D( $(compgen -W "-h" -- ${cur}) )
>>>> +                return 0
>>>> +            ;;
>>>> +        esac
>>>> +    elif [[ "${COMP_WORDS[1]}" =3D=3D "add-layer" ]]; then
>>>> +        case "$cur" in
>>>> +            "--"*|"")
>>>> +                COMPREPLY=3D( $(compgen -W =
"${opts_long_add_layer}" --
>>>> ${cur}) )
>>>> +                return 0
>>>> +            ;;
>>>> +            "-"*)
>>>> +                COMPREPLY=3D( $(compgen -W =
"${opts_short_add_layer}" --
>>>> ${cur}) )
>>>> +                return 0
>>>> +            ;;
>>>> +        esac
>>>> +    elif [[ "${COMP_WORDS[1]}" =3D=3D "show-overlayed" ]]; then
>>>> +        case "$cur" in
>>>> +            "--"*|"")
>>>> +                COMPREPLY=3D( $(compgen -W =
"${opts_long_show_overlayed}" --
>>>> ${cur}) )
>>>> +                return 0
>>>> +            ;;
>>>> +            "-"*)
>>>> +                COMPREPLY=3D( $(compgen -W =
"${opts_short_show_overlayed}" --
>>>> ${cur}) )
>>>> +                return 0
>>>> +            ;;
>>>> +        esac
>>>> +    elif [[ "${COMP_WORDS[1]}" =3D=3D "show-recipes" ]]; then
>>>> +        case "$cur" in
>>>> +            "--"*|"")
>>>> +                COMPREPLY=3D( $(compgen -W =
"${opts_long_show_recipes}" --
>>>> ${cur}) )
>>>> +                return 0
>>>> +            ;;
>>>> +            "-"*)
>>>> +                COMPREPLY=3D( $(compgen -W =
"${opts_short_show_recipes}" --
>>>> ${cur}) )
>>>> +                return 0
>>>> +            ;;
>>>> +        esac
>>>> +    elif [[ "${COMP_WORDS[1]}" =3D=3D "show-cross-depends" ]]; =
then
>>>> +        case "$cur" in
>>>> +            "--"*|"")
>>>> +                COMPREPLY=3D( $(compgen -W =
"${opts_long_show_cross_depends}"
>>>> -- ${cur}) )
>>>> +                return 0
>>>> +            ;;
>>>> +            "-"*)
>>>> +                COMPREPLY=3D( $(compgen -W =
"${opts_short_show_cross_depends}"
>>>> -- ${cur}) )
>>>> +                return 0
>>>> +            ;;
>>>> +        esac
>>>> +    elif [[ "${COMP_WORDS[1]}" =3D=3D "layerindex-fetch" ]]; then
>>>> +        case "$cur" in
>>>> +            "--"*|"")
>>>> +                COMPREPLY=3D( $(compgen -W
>>>> "${opts_long_show_layerindex_fetch}" -- ${cur}) )
>>>> +                return 0
>>>> +            ;;
>>>> +            "-"*)
>>>> +                COMPREPLY=3D( $(compgen -W
>>>> "${opts_short_show_layerindex_fetch}" -- ${cur}) )
>>>> +                return 0
>>>> +            ;;
>>>> +        esac
>>>> +    elif [[ "${COMP_WORDS[1]}" =3D=3D "layerindex-show-depends" =
]]; then
>>>> +        case "$cur" in
>>>> +            "--"*|"")
>>>> +                COMPREPLY=3D( $(compgen -W
>>>> "${opts_long_show_layerindex_show_depends}" -- ${cur}) )
>>>> +                return 0
>>>> +            ;;
>>>> +            "-"*)
>>>> +                COMPREPLY=3D( $(compgen -W
>>>> "${opts_short_show_layerindex_show_depends}" -- ${cur}) )
>>>> +                return 0
>>>> +            ;;
>>>> +        esac
>>>> +    elif [[ "${COMP_WORDS[1]}" =3D=3D "create-layer" ]]; then
>>>> +        case "$cur" in
>>>> +            "--"*|"")
>>>> +                COMPREPLY=3D( $(compgen -W =
"${opts_long_show_create_layer}"
>>>> -- ${cur}) )
>>>> +                return 0
>>>> +            ;;
>>>> +            "-"*)
>>>> +                COMPREPLY=3D( $(compgen -W =
"${opts_short_show_create_layer}"
>>>> -- ${cur}) )
>>>> +                return 0
>>>> +            ;;
>>>> +        esac
>>>> +    fi
>>>> +
>>>> +    case "$prev" in
>>>> +        "-c"|"--color")
>>>> +            COMPREPLY=3D( $(compgen -W "${colors}" -- ${cur}) )
>>>> +            return 0
>>>> +        ;;
>>>> +    esac
>>>> +
>>>> +    case "$cur" in
>>>> +        "--"*)
>>>> +            COMPREPLY=3D( $(compgen -W "${opts_long}" -- ${cur}) )
>>>> +            return 0
>>>> +        ;;
>>>> +        "-"*)
>>>> +            COMPREPLY=3D( $(compgen -W "${opts_short}" -- ${cur}) =
)
>>>> +            return 0
>>>> +        ;;
>>>> +    esac
>>>> +
>>>> +    if [[ ${prev} =3D=3D "bitbake-layers" ]]; then
>>>> +        COMPREPLY=3D( $(compgen -W "${subcommands}" -- ${cur}) )
>>>> +        return 0
>>>> +    elif [[ ! ${subcommands} =3D~ [[:space:]]${cur}[[:space:]] ]]; =
then
>>>> +        COMPREPLY=3D( $(compgen -W "${subcommands}" -- ${cur}) )
>>>> +        return 0
>>>> +    fi
>>>> +}
>>>> +complete -F _bitbake_layers bitbake-layers
>>>> \ No newline at end of file
>>>> diff --git a/contrib/completion/bash/bitbake_prserv_completion
>>>> b/contrib/completion/bash/bitbake_prserv_completion
>>>> new file mode 100644
>>>> index 00000000..3bca1197
>>>> --- /dev/null
>>>> +++ b/contrib/completion/bash/bitbake_prserv_completion
>>>> @@ -0,0 +1,76 @@
>>>> +#!bash
>>>> +# Bash completion support for bitbake-prserv tool,
>>>> +# compatible with Bitbake 1.39.1.
>>>> +#
>>>> +# Copyright (C) 2018 Lukasz Gardon <lukasz.gardon@gmail.com>
>>>> +#
>>>> +# Distributed under the MIT License (MIT)
>>>> +#
>>>> +
>>>> +_bitbake_prserv()
>>>> +{
>>>> +    local cur prev opts_short opts_long subcommands file_default
>>>> log_default log_levels
>>>> +
>>>> +    COMPREPLY=3D()
>>>> +
>>>> +    cur=3D"${COMP_WORDS[COMP_CWORD]}"
>>>> +    prev=3D"${COMP_WORDS[COMP_CWORD-1]}"
>>>> +
>>>> +    opts_short=3D"-h -f -l"
>>>> +
>>>> +    opts_long=3D"--version --help --file=3D --log=3D --loglevel=3D =
--start \
>>>> +                  --stop --host=3D --port=3D"
>>>> +
>>>> +    subcommands=3D"layerindex-fetch layerindex-show-depends =
add-layer \
>>>> +                    remove-layer flatten show-layers =
show-overlayed \
>>>> +                        show-recipes show-appends =
show-cross-depends \
>>>> +                        create-layer"
>>>> +
>>>> +    file_default=3D"prserv.sqlite3"
>>>> +    log_default=3D"prserv.log"
>>>> +    log_levels=3D"CRITICAL ERROR WARNING INFO DEBUG"
>>>> +
>>>> +    if [[ "$prev" =3D=3D "=3D" ]]; then
>>>> +        prev=3D"${COMP_WORDS[COMP_CWORD -2]}"
>>>> +    elif [[ "$cur" =3D=3D "=3D" ]]; then
>>>> +        cur=3D""
>>>> +    fi
>>>> +
>>>> +    case "$prev" in
>>>> +        "-f"|"--file")
>>>> +            COMPREPLY=3D( $(compgen -W "${file_default}" -- =
${cur}) )
>>>> +            return 0
>>>> +        ;;
>>>> +        "-l"|"--log")
>>>> +            COMPREPLY=3D( $(compgen -W "${log_default}" -- ${cur}) =
)
>>>> +            return 0
>>>> +        ;;
>>>> +        "--loglevel")
>>>> +            COMPREPLY=3D( $(compgen -W "${log_levels}" -- ${cur}) =
)
>>>> +            return 0
>>>> +        ;;
>>>> +    esac
>>>> +
>>>> +    case "$cur" in
>>>> +        "--"*|"")
>>>> +            COMPREPLY=3D( $(compgen -W "${opts_long}" -- ${cur}) )
>>>> +            if [[ ${#COMPREPLY[@]} =3D=3D 1 && ${COMPREPLY[0]} =3D=3D=
 "--"*"=3D" ]] ;
>>>> then
>>>> +                compopt -o nospace
>>>> +            fi
>>>> +            return 0
>>>> +        ;;
>>>> +        "-"*)
>>>> +            COMPREPLY=3D( $(compgen -W "${opts_short}" -- ${cur}) =
)
>>>> +            return 0
>>>> +        ;;
>>>> +    esac
>>>> +
>>>> +    if [[ ${prev} =3D=3D "bitbake-layers" ]]; then
>>>> +        COMPREPLY=3D( $(compgen -W "${subcommands}" -- ${cur}) )
>>>> +        return 0
>>>> +    elif [[ ! ${subcommands} =3D~ [[:space:]]${cur}[[:space:]] ]]; =
then
>>>> +        COMPREPLY=3D( $(compgen -W "${subcommands}" -- ${cur}) )
>>>> +        return 0
>>>> +    fi
>>>> +}
>>>> +complete -F _bitbake_prserv bitbake-prserv
>>>> \ No newline at end of file
>>>> diff --git a/contrib/completion/bash/bitbake_selftest_completion
>>>> b/contrib/completion/bash/bitbake_selftest_completion
>>>> new file mode 100644
>>>> index 00000000..8b6bf641
>>>> --- /dev/null
>>>> +++ b/contrib/completion/bash/bitbake_selftest_completion
>>>> @@ -0,0 +1,34 @@
>>>> +#!bash
>>>> +# Bash completion support for bitbake-selftest tool,
>>>> +# compatible with Bitbake version 1.39.1.
>>>> +#
>>>> +# Copyright (C) 2018 Lukasz Gardon <lukasz.gardon@gmail.com>
>>>> +#
>>>> +# Distributed under the MIT License (MIT)
>>>> +#
>>>> +
>>>> +_bitbake_selftest()
>>>> +{
>>>> +    local cur prev opts_short opts_long
>>>> +
>>>> +    COMPREPLY=3D()
>>>> +
>>>> +    cur=3D"${COMP_WORDS[COMP_CWORD]}"
>>>> +    prev=3D"${COMP_WORDS[COMP_CWORD-1]}"
>>>> +
>>>> +    opts_short=3D"-h -v -q -f -c"
>>>> +
>>>> +    opts_long=3D"--help --verbose --quiet --locals --failfast =
--catch"
>>>> +
>>>> +    case "$cur" in
>>>> +        "--"*)
>>>> +            COMPREPLY=3D( $(compgen -W "${opts_long}" -- ${cur}) )
>>>> +            return 0
>>>> +        ;;
>>>> +        "-"*)
>>>> +            COMPREPLY=3D( $(compgen -W "${opts_short}" -- ${cur}) =
)
>>>> +            return 0
>>>> +        ;;
>>>> +    esac
>>>> +}
>>>> +complete -F _bitbake_selftest bitbake-selftest
>>>> \ No newline at end of file
>>>> --
>>>> 2.18.0
>>>>=20
>>>> --
>>>> _______________________________________________
>>>> bitbake-devel mailing list
>>>> bitbake-devel@lists.openembedded.org
>>>> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>>>>=20
>>>>=20
>>=20
>=20


--Apple-Mail=_2B0A5304-1D20-4A5A-B471-889CC96C54E0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" =
class=3D"">Richard, may I ask You kindly help here to decide if such =
files should be stored in <i class=3D"">bitbake</i> repository ?<div =
class=3D""><br class=3D""><div class=3D"">And I see that I used&nbsp;<i =
class=3D"">--subject-prefix=3D"[bitbake-devel]=E2=80=9D</i>&nbsp; flag =
while uploading patch, that cause to add additional "[ ]" to =
topic:</div><div class=3D""><i class=3D"">[[bitbake-devel]] Add files =
supporting bash completion for bitbake tools</i></div><div =
class=3D"">Generally I can=E2=80=99t see my patch in the patchwork, It =
means that I should try again upload this changes to be sure that will =
be in patchwork properly ?</div><div class=3D""><br =
class=3D""><div><blockquote type=3D"cite" class=3D""><div =
class=3D"">Wiadomo=C5=9B=C4=87 napisana przez =C5=81ukasz Gardo=C5=84 =
&lt;<a href=3D"mailto:lukaszgardon555@gmail.com" =
class=3D"">lukaszgardon555@gmail.com</a>&gt; w dniu 03.09.2018, o godz. =
21:25:</div><br class=3D"Apple-interchange-newline"><div class=3D""><meta =
http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8" =
class=3D""><div style=3D"word-wrap: break-word; -webkit-nbsp-mode: =
space; line-break: after-white-space;" class=3D"">Add missed&nbsp;<a =
href=3D"mailto:bitbake-devel@lists.openembedded.org" =
class=3D"">bitbake-devel@lists.openembedded.org</a>&nbsp;mailing group =
to this thread.<br class=3D""><div class=3D""><br class=3D""><blockquote =
type=3D"cite" class=3D""><div class=3D"">Wiadomo=C5=9B=C4=87 napisana =
przez =C5=81ukasz Gardo=C5=84 &lt;<a =
href=3D"mailto:lukaszgardon555@gmail.com" =
class=3D"">lukaszgardon555@gmail.com</a>&gt; w dniu 03.09.2018, o godz. =
21:22:</div><br class=3D"Apple-interchange-newline"><div class=3D""><meta =
http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8" =
class=3D""><div style=3D"word-wrap: break-word; -webkit-nbsp-mode: =
space; line-break: after-white-space;" class=3D"">Hi Alex,<div =
class=3D""><br class=3D""></div><div class=3D"">thank=E2=80=99s for Your =
suggestion but for in my opinion keeping this files in <i =
class=3D"">bitbake</i> repository is the better place.</div><div =
class=3D"">I would not know to find/search such completion files in <i =
class=3D"">bash-completion</i>&nbsp;or any other place.</div><div =
class=3D"">What about vim plugin which is stored in <i =
class=3D"">contrib/</i> dir[1] and which is also comes from dedicated =
repo[2] same thing.</div><div class=3D""><br class=3D""></div><div =
class=3D"">Anyway, could someone from project architects could comment =
and help here ?</div><div class=3D""><br class=3D""></div><div =
class=3D"">[1] vim bitbake plugin in <i class=3D"">bitbake:&nbsp;<a =
href=3D"https://github.com/openembedded/bitbake/tree/master/contrib/vim" =
class=3D"">https://github.com/openembedded/bitbake/tree/master/contrib/vim=
</a></i></div><div class=3D"">[2] vim bitbake plugin repo:&nbsp;<a =
href=3D"https://github.com/kergoth/vim-bitbake" =
class=3D"">https://github.com/kergoth/vim-bitbake</a><br class=3D""><div =
class=3D""><br class=3D""><blockquote type=3D"cite" class=3D""><div =
class=3D"">Wiadomo=C5=9B=C4=87 napisana przez Alexander Kanavin &lt;<a =
href=3D"mailto:alex.kanavin@gmail.com" =
class=3D"">alex.kanavin@gmail.com</a>&gt; w dniu 03.09.2018, o godz. =
11:25:</div><br class=3D"Apple-interchange-newline"><div class=3D""><div =
class=3D"">Hello Lukasz,<br class=3D""><br class=3D"">nobody will find =
your contributions in bitbake/contrib, and so they<br class=3D"">will be =
unused and will bitrot. The proper place is the upstream<br =
class=3D"">bash-completion project, which will get picked up by all =
Linux<br class=3D"">distributions.<br class=3D""><br class=3D"">Alex<br =
class=3D""><br class=3D"">2018-09-02 12:27 GMT+02:00 =C5=81ukasz Gardo=C5=84=
 &lt;<a href=3D"mailto:lukaszgardon555@gmail.com" =
class=3D"">lukaszgardon555@gmail.com</a>&gt;:<br class=3D""><blockquote =
type=3D"cite" class=3D"">Hi Alex,<br class=3D""><br class=3D"">With =
information comes file from bitbake repository -<br =
class=3D"">bitbake/contrib/README: "This directory is for additional =
contributed files<br class=3D"">which may be useful.=E2=80=9D.<br =
class=3D"">I think that this is proper place for such files.<br =
class=3D""><br class=3D"">Wiadomo=C5=9B=C4=87 napisana przez Alexander =
Kanavin &lt;<a href=3D"mailto:alex.kanavin@gmail.com" =
class=3D"">alex.kanavin@gmail.com</a>&gt; w dniu<br class=3D"">01.09.2018,=
 o godz. 21:33:<br class=3D""><br class=3D"">The right upstream =
destination for this is almost certainly<br class=3D""><a =
href=3D"https://github.com/scop/bash-completion" =
class=3D"">https://github.com/scop/bash-completion</a><br class=3D""><br =
class=3D"">Alex<br class=3D""><br class=3D"">2018-09-01 15:36 GMT+02:00 =
=C5=81ukasz Gardo=C5=84 &lt;<a href=3D"mailto:lukaszgardon555@gmail.com" =
class=3D"">lukaszgardon555@gmail.com</a>&gt;:<br class=3D""><br =
class=3D"">Repository with more details:<br class=3D""><a =
href=3D"https://github.com/lukaszgard/bitbake-completion" =
class=3D"">https://github.com/lukaszgard/bitbake-completion</a><br =
class=3D""><br class=3D"">Signed-off-by: =C5=81ukasz Gardo=C5=84 &lt;<a =
href=3D"mailto:lukaszgardon555@gmail.com" =
class=3D"">lukaszgardon555@gmail.com</a>&gt;<br class=3D"">---<br =
class=3D"">contrib/completion/bash/bitbake_completion =
&nbsp;&nbsp;&nbsp;| 108 ++++++++++<br =
class=3D"">.../bash/bitbake_diffsigs_completion =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;86 =
++++++++<br class=3D"">.../bash/bitbake_dumpsig_completion =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;89 =
+++++++++<br class=3D"">.../completion/bash/bitbake_layers_completion | =
188 ++++++++++++++++++<br =
class=3D"">.../completion/bash/bitbake_prserv_completion | &nbsp;76 =
+++++++<br class=3D"">.../bash/bitbake_selftest_completion =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;34 ++++<br =
class=3D"">6 files changed, 581 insertions(+)<br class=3D"">create mode =
100644 contrib/completion/bash/bitbake_completion<br class=3D"">create =
mode 100644 contrib/completion/bash/bitbake_diffsigs_completion<br =
class=3D"">create mode 100644 =
contrib/completion/bash/bitbake_dumpsig_completion<br class=3D"">create =
mode 100644 contrib/completion/bash/bitbake_layers_completion<br =
class=3D"">create mode 100644 =
contrib/completion/bash/bitbake_prserv_completion<br class=3D"">create =
mode 100644 contrib/completion/bash/bitbake_selftest_completion<br =
class=3D""><br class=3D"">diff --git =
a/contrib/completion/bash/bitbake_completion<br =
class=3D"">b/contrib/completion/bash/bitbake_completion<br class=3D"">new =
file mode 100644<br class=3D"">index 00000000..23cadf6e<br class=3D"">--- =
/dev/null<br class=3D"">+++ =
b/contrib/completion/bash/bitbake_completion<br class=3D"">@@ -0,0 =
+1,108 @@<br class=3D"">+#!bash<br class=3D"">+# Bash completion support =
for bitbake 1.39.1 release.<br class=3D"">+#<br class=3D"">+# Copyright =
(C) 2014 Sergio Prado &lt;<a href=3D"mailto:sergio.prado@e-labworks.com" =
class=3D"">sergio.prado@e-labworks.com</a>&gt;<br class=3D"">+# =
Copyright (C) 2018 Lukasz Gardon &lt;<a =
href=3D"mailto:lukasz.gardon@gmail.com" =
class=3D"">lukasz.gardon@gmail.com</a>&gt;<br class=3D"">+#<br =
class=3D"">+# Distributed under the MIT License (MIT)<br class=3D"">+#<br =
class=3D"">+<br class=3D"">+_bitbake()<br class=3D"">+{<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;local cur prev opts_short opts_long tasks recipes =
ui<br class=3D"">+ &nbsp;&nbsp;&nbsp;local bb_layers_conf bb_layers_md5 =
bb_recipes<br class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;COMPREPLY=3D()<br class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;cur=3D"${COMP_WORDS[COMP_CWORD]}"<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;prev=3D"${COMP_WORDS[COMP_CWORD-1]}"<br class=3D"">+<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;opts_short=3D"-h -b -k -f -c -C -r -R -v =
-D -q -n -S -p -s -e -g -I \<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;-l -P -u -B -T -m -w"<br class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;opts_long=3D"--version --help --buildfile=3D =
--continue --force --cmd=3D \<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;--clear-stamp=3D --read=3D --postread=3D --verbose --debug =
--quiet<br class=3D"">\<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;--dry-run --dump-signatures=3D --parse-only --show-versions =
\<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;--environment --graphviz --ignore-deps=3D --log-domains=3D<br =
class=3D"">--profile \<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;--ui=3D --token=3D --revisions-changed --server-only --bind=3D =
\<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;--idle-timeout=3D --no-setscene --setscene-only<br =
class=3D"">--remote-server=3D \<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;--kill-server --observe-only --status-only --write-log=3D<br =
class=3D"">--runall=3D \<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;--runonly=3D"<br class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;tasks=3D"build compile compile_ptest_base configure =
configure_ptest_base<br class=3D"">deploy \<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;distrodata =
fetch image image_complete install install_ptest_base<br =
class=3D"">package \<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;package_qa =
package_write_deb package_write_ipk package_write_rpm<br =
class=3D"">package_write_tar \<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;packagedata =
patch populate_lic populate_sdk populate_sysroot<br =
class=3D"">prepare_recipe_sysroot \<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rm_work =
rm_work_all unpack checkpkg checkuri clean cleanall<br =
class=3D"">cleansstate devpyshell \<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;devshell =
listtasks package_index bootimg bundle_initramfs rootfs<br =
class=3D"">testimage \<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;testimage_auto=
 compile_kernelmodules diffconfig kernel_checkout<br =
class=3D"">kernel_configcheck \<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel_configm=
e kernel_menuconfig kernel_metadata menuconfig<br class=3D"">savedefconfig=
 shared_workdir \<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sizecheck =
strip validate_branches spdx"<br class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;ui=3D"knotty ncurses taskexp"<br class=3D"">+<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;if [[ "$prev" =3D=3D "=3D" ]]; then<br =
class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;prev=3D"${COMP_WORDS[COMP_CWORD =
- 2]}"<br class=3D"">+ &nbsp;&nbsp;&nbsp;elif [[ "$cur" =3D=3D "=3D" ]]; =
then<br class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;cur=3D""<br=
 class=3D"">+ &nbsp;&nbsp;&nbsp;fi<br class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;conf_files=3D$(find . -maxdepth 1 -name "*.conf" -type =
f -printf '%P\n')<br class=3D"">+<br class=3D"">+ &nbsp;&nbsp;&nbsp;case =
"$prev" in<br class=3D"">+<br =
class=3D"">"-c"|"--cmd"|"-C"|"--clear-stamp"|"--ignore-deps"|"--runall"|"-=
-runonly")<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;COMPREPL=
Y=3D( $(compgen -W "${tasks}" -- ${cur}) )<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
0<br class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;;;<br =
class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"-r"|"--read"|"-R"|"--postread")=
<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;COMPREPL=
Y=3D( $(compgen -W "${conf_files}" -- ${cur}) )<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
0<br class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;;;<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"-u"|"--ui")<br =
class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;COMPREPL=
Y=3D( $(compgen -W "${ui}" -- ${cur}) )<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
0<br class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;;;<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;esac<br class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;case "$cur" in<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"--"*)<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;COMPREPL=
Y=3D( $(compgen -W "${opts_long}" -- ${cur}) )<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if [[ =
${#COMPREPLY[@]} =3D=3D 1 &amp;&amp; ${COMPREPLY[0]} =3D=3D "--"*"=3D" =
]] ;<br class=3D"">then<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;compopt -o nospace<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;fi<br =
class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
0<br class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;;;<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"-"*)<br =
class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;COMPREPL=
Y=3D( $(compgen -W "${opts_short}" -- ${cur}) )<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
0<br class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;;;<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;esac<br class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;bb_layers_conf=3D"conf/bblayers.conf"<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;bb_layers_md5=3D".bb_layers_conf.md5"<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;bb_recipes=3D".bb_recipes"<br class=3D"">+<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;_parse_recipes () {<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bitbake -s | sed -e =
'0,/^=3D.*/d' -e '/^\s*$/d' -e '/^Summary:/d' |<br class=3D"">awk =
'{print $1}' &gt; $bb_recipes<br class=3D"">+ &nbsp;&nbsp;&nbsp;}<br =
class=3D"">+<br class=3D"">+ &nbsp;&nbsp;&nbsp;if [ ! -e $bb_layers_conf =
]; then<br class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
0<br class=3D"">+ &nbsp;&nbsp;&nbsp;fi<br class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;if [ "$prev" =3D "bitbake" -a "$cur" =3D "" ]; then<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;_parse_recipes<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;fi<br class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;md5sum --quiet --status -c $bb_layers_md5 =
2&gt;/dev/null<br class=3D"">+ &nbsp;&nbsp;&nbsp;if [ $? !=3D 0 -o ! -e =
$bb_recipes ]; then<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;md5sum $bb_layers_conf =
&gt; $bb_layers_md5<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;_parse_recipes<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;fi<br class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;recipes=3D$(cat $bb_recipes)<br class=3D"">+<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;COMPREPLY=3D( $(compgen -W "${recipes}" =
-- ${cur}) )<br class=3D"">+ &nbsp;&nbsp;&nbsp;return 0<br =
class=3D"">+}<br class=3D"">+complete -F _bitbake bitbake<br class=3D"">\ =
No newline at end of file<br class=3D"">diff --git =
a/contrib/completion/bash/bitbake_diffsigs_completion<br =
class=3D"">b/contrib/completion/bash/bitbake_diffsigs_completion<br =
class=3D"">new file mode 100644<br class=3D"">index =
00000000..cbf2c5f1<br class=3D"">--- /dev/null<br class=3D"">+++ =
b/contrib/completion/bash/bitbake_diffsigs_completion<br class=3D"">@@ =
-0,0 +1,86 @@<br class=3D"">+#!bash<br class=3D"">+# Bash completion =
support for bitbake-diffsigs tool,<br class=3D"">+# compatible with =
Bitbake 1.39.1.<br class=3D"">+#<br class=3D"">+# Copyright (C) 2018 =
Lukasz Gardon &lt;<a href=3D"mailto:lukasz.gardon@gmail.com" =
class=3D"">lukasz.gardon@gmail.com</a>&gt;<br class=3D"">+#<br =
class=3D"">+# Distributed under the MIT License (MIT)<br class=3D"">+#<br =
class=3D"">+<br class=3D"">+_bitbake_diffsigs()<br class=3D"">+{<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;local cur prev opts_short opts_long tasks =
colors<br class=3D"">+ &nbsp;&nbsp;&nbsp;local bb_layers_conf =
bb_layers_md5 bb_recipes<br class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;COMPREPLY=3D()<br class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;cur=3D"${COMP_WORDS[COMP_CWORD]}"<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;prev=3D"${COMP_WORDS[COMP_CWORD-1]}"<br class=3D"">+<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;opts_short=3D"-h -d -t -s"<br =
class=3D"">+<br class=3D"">+ &nbsp;&nbsp;&nbsp;opts_long=3D"--help =
--debug --color --task --signature"<br class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;tasks=3D"build compile compile_ptest_base configure =
configure_ptest_base<br class=3D"">deploy \<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;distrodata =
fetch image image_complete install install_ptest_base<br =
class=3D"">package \<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;package_qa =
package_write_deb package_write_ipk package_write_rpm<br =
class=3D"">package_write_tar \<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;packagedata =
patch populate_lic populate_sdk populate_sysroot<br =
class=3D"">prepare_recipe_sysroot \<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rm_work =
rm_work_all unpack checkpkg checkuri clean cleanall<br =
class=3D"">cleansstate devpyshell \<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;devshell =
listtasks package_index bootimg bundle_initramfs rootfs<br =
class=3D"">testimage \<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;testimage_auto=
 compile_kernelmodules diffconfig kernel_checkout<br =
class=3D"">kernel_configcheck \<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel_configm=
e kernel_menuconfig kernel_metadata menuconfig<br class=3D"">savedefconfig=
 shared_workdir \<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sizecheck =
strip validate_branches spdx"<br class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;colors=3D"auto always never"<br class=3D"">+<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;case "$cur" in<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"--"*)<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;COMPREPL=
Y=3D( $(compgen -W "${opts_long}" -- ${cur}) )<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
0<br class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;;;<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"-"*)<br =
class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;COMPREPL=
Y=3D( $(compgen -W "${opts_short}" -- ${cur}) )<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
0<br class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;;;<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;esac<br class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;bb_layers_conf=3D"conf/bblayers.conf"<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;bb_layers_md5=3D".bb_layers_conf.md5"<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;bb_recipes=3D".bb_recipes"<br class=3D"">+<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;_parse_recipes () {<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bitbake -s | sed -e =
'0,/^=3D.*/d' -e '/^\s*$/d' -e '/^Summary:/d' |<br class=3D"">awk =
'{print $1}' &gt; $bb_recipes<br class=3D"">+ &nbsp;&nbsp;&nbsp;}<br =
class=3D"">+<br class=3D"">+ &nbsp;&nbsp;&nbsp;if [ ! -e $bb_layers_conf =
]; then<br class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
0<br class=3D"">+ &nbsp;&nbsp;&nbsp;fi<br class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;if [ "$prev" =3D "bitbake" -a "$cur" =3D "" ]; then<br =
class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;_parse_recipes=
<br class=3D"">+ &nbsp;&nbsp;&nbsp;fi<br class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;md5sum --quiet --status -c $bb_layers_md5 =
2&gt;/dev/null<br class=3D"">+ &nbsp;&nbsp;&nbsp;if [ $? !=3D 0 -o ! -e =
$bb_recipes ]; then<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;md5sum $bb_layers_conf &gt; =
$bb_layers_md5<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;_parse_recipes<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;fi<br class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;recipes=3D$(cat $bb_recipes)<br class=3D"">+<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;case "$prev" in<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"-c"|"--color")<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;COMPREPL=
Y=3D( $(compgen -W "${colors}" -- ${cur}) )<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
0<br class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;;;<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"-t"|"--task")<br =
class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;COMPREPLY=3D( =
$(compgen -W "${recipes}" -- ${cur}) )<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return 0<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;esac<br class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;if [[ ${COMP_WORDS[COMP_CWORD -2]} =3D=3D "-t" ]] || =
[[<br class=3D"">${COMP_WORDS[COMP_CWORD -2]} =3D=3D "--task" ]]; =
then<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;COMPREPLY=3D( $(compgen -W =
"${tasks}" -- ${cur}) )<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return 0<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;fi<br class=3D"">+}<br class=3D"">+complete=
 -F _bitbake_diffsigs bitbake-diffsigs<br class=3D"">\ No newline at end =
of file<br class=3D"">diff --git =
a/contrib/completion/bash/bitbake_dumpsig_completion<br =
class=3D"">b/contrib/completion/bash/bitbake_dumpsig_completion<br =
class=3D"">new file mode 100644<br class=3D"">index =
00000000..95eb2394<br class=3D"">--- /dev/null<br class=3D"">+++ =
b/contrib/completion/bash/bitbake_dumpsig_completion<br class=3D"">@@ =
-0,0 +1,89 @@<br class=3D"">+#!bash<br class=3D"">+# Bash completion =
support for bitbake-dumpsig tool,<br class=3D"">+# compatible with =
Bitbake 1.39.1.<br class=3D"">+#<br class=3D"">+# Copyright (C) 2018 =
Lukasz Gardon &lt;<a href=3D"mailto:lukasz.gardon@gmail.com" =
class=3D"">lukasz.gardon@gmail.com</a>&gt;<br class=3D"">+#<br =
class=3D"">+# Distributed under the MIT License (MIT)<br class=3D"">+#<br =
class=3D"">+<br class=3D"">+_bitbake_dumpsig()<br class=3D"">+{<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;local cur prev opts_short opts_long =
tasks<br class=3D"">+ &nbsp;&nbsp;&nbsp;local bb_layers_conf =
bb_layers_md5 bb_recipes<br class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;COMPREPLY=3D()<br class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;cur=3D"${COMP_WORDS[COMP_CWORD]}"<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;prev=3D"${COMP_WORDS[COMP_CWORD-1]}"<br class=3D"">+<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;opts_short=3D"-h -d -t"<br class=3D"">+<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;opts_long=3D"--help --debug --task=3D"<br =
class=3D"">+<br class=3D"">+ &nbsp;&nbsp;&nbsp;tasks=3D"build compile =
compile_ptest_base configure configure_ptest_base<br class=3D"">deploy =
\<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;distrodata =
fetch image image_complete install install_ptest_base<br =
class=3D"">package \<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;package_qa =
package_write_deb package_write_ipk package_write_rpm<br =
class=3D"">package_write_tar \<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;packagedata =
patch populate_lic populate_sdk populate_sysroot<br =
class=3D"">prepare_recipe_sysroot \<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rm_work =
rm_work_all unpack checkpkg checkuri clean cleanall<br =
class=3D"">cleansstate devpyshell \<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;devshell =
listtasks package_index bootimg bundle_initramfs rootfs<br =
class=3D"">testimage \<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;testimage_auto=
 compile_kernelmodules diffconfig kernel_checkout<br =
class=3D"">kernel_configcheck \<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel_configm=
e kernel_menuconfig kernel_metadata menuconfig<br class=3D"">savedefconfig=
 shared_workdir \<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sizecheck =
strip validate_branches spdx"<br class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;if [[ "$prev" =3D=3D "=3D" ]]; then<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;prev=3D"${COMP_WORDS[COMP_CWORD =
- 2]}"<br class=3D"">+ &nbsp;&nbsp;&nbsp;elif [[ "$cur" =3D=3D "=3D" ]]; =
then<br class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;cur=3D""<br=
 class=3D"">+ &nbsp;&nbsp;&nbsp;fi<br class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;case "$cur" in<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"--"*)<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;COMPREPL=
Y=3D( $(compgen -W "${opts_long}" -- ${cur}) )<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if [[ =
${#COMPREPLY[@]} =3D=3D 1 &amp;&amp; ${COMPREPLY[0]} =3D=3D "--"*"=3D" =
]] ;<br class=3D"">then<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;compopt -o nospace<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;fi<br =
class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
0<br class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;;;<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"-"*)<br =
class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;COMPREPL=
Y=3D( $(compgen -W "${opts_short}" -- ${cur}) )<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
0<br class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;;;<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;esac<br class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;bb_layers_conf=3D"conf/bblayers.conf"<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;bb_layers_md5=3D".bb_layers_conf.md5"<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;bb_recipes=3D".bb_recipes"<br class=3D"">+<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;_parse_recipes () {<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bitbake -s | sed -e =
'0,/^=3D.*/d' -e '/^\s*$/d' -e '/^Summary:/d' |<br class=3D"">awk =
'{print $1}' &gt; $bb_recipes<br class=3D"">+ &nbsp;&nbsp;&nbsp;}<br =
class=3D"">+<br class=3D"">+ &nbsp;&nbsp;&nbsp;if [ ! -e $bb_layers_conf =
]; then<br class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
0<br class=3D"">+ &nbsp;&nbsp;&nbsp;fi<br class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;if [ "$prev" =3D "bitbake" -a "$cur" =3D "" ]; then<br =
class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;_parse_recipes=
<br class=3D"">+ &nbsp;&nbsp;&nbsp;fi<br class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;md5sum --quiet --status -c $bb_layers_md5 =
2&gt;/dev/null<br class=3D"">+ &nbsp;&nbsp;&nbsp;if [ $? !=3D 0 -o ! -e =
$bb_recipes ]; then<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;md5sum $bb_layers_conf &gt; =
$bb_layers_md5<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;_parse_recipes<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;fi<br class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;recipes=3D$(cat $bb_recipes)<br class=3D"">+<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;case "$prev" in<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"-t"|"--task")<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;COMPREPLY=3D( =
$(compgen -W "${recipes}" -- ${cur}) )<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return 0<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;esac<br class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;if [[ ${COMP_WORDS[COMP_CWORD -2]} =3D~ "-t" ]] || =
[[<br class=3D"">${COMP_WORDS[COMP_CWORD -3]} =3D=3D "--task" ]]; =
then<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;COMPREPLY=3D( $(compgen -W =
"${tasks}" -- ${cur}) )<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return 0<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;fi<br class=3D"">+}<br class=3D"">+complete=
 -F _bitbake_dumpsig bitbake-dumpsig<br class=3D"">\ No newline at end =
of file<br class=3D"">diff --git =
a/contrib/completion/bash/bitbake_layers_completion<br =
class=3D"">b/contrib/completion/bash/bitbake_layers_completion<br =
class=3D"">new file mode 100644<br class=3D"">index =
00000000..37ca8afb<br class=3D"">--- /dev/null<br class=3D"">+++ =
b/contrib/completion/bash/bitbake_layers_completion<br class=3D"">@@ =
-0,0 +1,188 @@<br class=3D"">+#!bash<br class=3D"">+# Bash completion =
support for bitbake-layers tool,<br class=3D"">+# compatible with =
Bitbake 1.39.1.<br class=3D"">+#<br class=3D"">+# Copyright (C) 2018 =
Lukasz Gardon &lt;<a href=3D"mailto:lukasz.gardon@gmail.com" =
class=3D"">lukasz.gardon@gmail.com</a>&gt;<br class=3D"">+#<br =
class=3D"">+# Distributed under the MIT License (MIT)<br class=3D"">+#<br =
class=3D"">+<br class=3D"">+_bitbake_layers()<br class=3D"">+{<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;local cur prev opts_short opts_long =
subcommands colors<br class=3D"">+ &nbsp;&nbsp;&nbsp;local =
opts_long_add_layer opts_short_add_layer opts_long_show_overlayed<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;local opts_short_show_overlayed =
opts_long_show_recipes<br class=3D"">opts_short_show_recipes<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;local opts_long_show_cross_depends =
opts_short_show_cross_depends<br class=3D"">+ &nbsp;&nbsp;&nbsp;local =
opts_long_show_layerindex_fetch opts_short_show_layerindex_fetch<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;local =
opts_long_show_layerindex_show_depends<br =
class=3D"">opts_short_show_layerindex_show_depends<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;local opts_long_show_create_layer =
opts_short_show_create_layer<br class=3D"">bb_class_files classes<br =
class=3D"">+<br class=3D"">+ &nbsp;&nbsp;&nbsp;COMPREPLY=3D()<br =
class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;cur=3D"${COMP_WORDS[COMP_CWORD]}"<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;prev=3D"${COMP_WORDS[COMP_CWORD-1]}"<br class=3D"">+<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;opts_short=3D"-d -q -F -h"<br =
class=3D"">+<br class=3D"">+ &nbsp;&nbsp;&nbsp;opts_long=3D"--debug =
--quiet --force --color --help"<br class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;subcommands=3D"layerindex-fetch =
layerindex-show-depends add-layer \<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;remove-layer flatten show-layers =
show-overlayed \<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;show-recip=
es show-appends show-cross-depends \<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;create-lay=
er"<br class=3D"">+<br class=3D"">+ &nbsp;&nbsp;&nbsp;colors=3D"auto =
always never"<br class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;opts_long_show_overlayed=3D"--help --filenames =
--same-version"<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;opts_short_show_overlayed=3D"-h -f -s"<br =
class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;opts_long_show_recipes=3D"--help --filenames =
--multiple --inherits"<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;opts_short_show_recipes=3D"-h -f -m -i"<br =
class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;opts_long_show_layerindex_fetch=3D"--help --show-only =
--branch --ignore"<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;opts_short_show_layerindex_fetch=3D"-h -n -b -i"<br =
class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;opts_long_add_layer=3D"--help --priority =
--example-recipe-name<br class=3D"">--example-recipe-version"<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;opts_short_add_layer=3D"-h"<br =
class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;opts_long_show_cross_depends=3D"--help --filenames =
--ignore"<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;opts_short_show_cross_depends=3D"-h -f -i"<br =
class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;opts_long_show_layerindex_show_depends=3D"--help =
--branch"<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;opts_short_show_layerindex_show_depends=3D"-h -b"<br =
class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;opts_long_show_create_layer=3D"--help --priority =
--example-recipe-name<br class=3D"">--example-recipe-version"<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;opts_short_show_create_layer=3D"-h -p -e =
-v"<br class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;bb_class_files=3D".bb_class_files"<br class=3D"">+<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;_get_classes() {<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;find $BBPATH/../meta*/classes/ =
-name *.bbclass -exec basename {} \;<br class=3D"">| sed 's/.bbclass//' =
&gt; $bb_class_files<br class=3D"">+ &nbsp;&nbsp;&nbsp;}<br =
class=3D"">+<br class=3D"">+ &nbsp;&nbsp;&nbsp;if [[ "${COMP_WORDS[@]}" =
=3D~ show-recipes ]] ; then<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if [[ "$prev" =3D=3D =
"--inherits" ]] || [[ "$prev" =3D=3D "-i" ]]; then<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;_get_cla=
sses<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;classes=3D=
$(cat $bb_class_files)<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;COMPREPL=
Y=3D( $(compgen -W "${classes}" -- ${cur}) )<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
0<br class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;fi<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;fi<br class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;if [[ "${COMP_WORDS[1]}" =3D~<br =
class=3D"">show-layers|show-appends|remove-layer|flatten ]]; then<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;case "$cur" in<br =
class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"--"*)<b=
r class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;COMPREPLY=3D( $(compgen -W "--help" -- ${cur}) )<br =
class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;return 0<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;;;<br =
class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"-"*)<br=
 class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;COMPREPLY=3D( $(compgen -W "-h" -- ${cur}) )<br =
class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;return 0<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;;;<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;esac<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;elif [[ "${COMP_WORDS[1]}" =3D=3D =
"add-layer" ]]; then<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;case "$cur" in<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"--"*|""=
)<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;COMPREPLY=3D( $(compgen -W "${opts_long_add_layer}" =
--<br class=3D"">${cur}) )<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;return 0<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;;;<br =
class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"-"*)<br=
 class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;COMPREPLY=3D( $(compgen -W "${opts_short_add_layer}" =
--<br class=3D"">${cur}) )<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;return 0<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;;;<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;esac<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;elif [[ "${COMP_WORDS[1]}" =3D=3D =
"show-overlayed" ]]; then<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;case "$cur" in<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"--"*|""=
)<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;COMPREPLY=3D( $(compgen -W "${opts_long_show_overlayed}" =
--<br class=3D"">${cur}) )<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;return 0<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;;;<br =
class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"-"*)<br=
 class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;COMPREPLY=3D( $(compgen -W =
"${opts_short_show_overlayed}" --<br class=3D"">${cur}) )<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;return 0<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;;;<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;esac<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;elif [[ "${COMP_WORDS[1]}" =3D=3D =
"show-recipes" ]]; then<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;case "$cur" in<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"--"*|""=
)<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;COMPREPLY=3D( $(compgen -W "${opts_long_show_recipes}" =
--<br class=3D"">${cur}) )<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;return 0<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;;;<br =
class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"-"*)<br=
 class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;COMPREPLY=3D( $(compgen -W "${opts_short_show_recipes}" =
--<br class=3D"">${cur}) )<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;return 0<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;;;<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;esac<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;elif [[ "${COMP_WORDS[1]}" =3D=3D =
"show-cross-depends" ]]; then<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;case "$cur" in<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"--"*|""=
)<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;COMPREPLY=3D( $(compgen -W =
"${opts_long_show_cross_depends}"<br class=3D"">-- ${cur}) )<br =
class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;return 0<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;;;<br =
class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"-"*)<br=
 class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;COMPREPLY=3D( $(compgen -W =
"${opts_short_show_cross_depends}"<br class=3D"">-- ${cur}) )<br =
class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;return 0<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;;;<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;esac<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;elif [[ "${COMP_WORDS[1]}" =3D=3D =
"layerindex-fetch" ]]; then<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;case "$cur" in<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"--"*|""=
)<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;COMPREPLY=3D( $(compgen -W<br =
class=3D"">"${opts_long_show_layerindex_fetch}" -- ${cur}) )<br =
class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;return 0<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;;;<br =
class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"-"*)<br=
 class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;COMPREPLY=3D( $(compgen -W<br =
class=3D"">"${opts_short_show_layerindex_fetch}" -- ${cur}) )<br =
class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;return 0<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;;;<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;esac<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;elif [[ "${COMP_WORDS[1]}" =3D=3D =
"layerindex-show-depends" ]]; then<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;case "$cur" in<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"--"*|""=
)<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;COMPREPLY=3D( $(compgen -W<br =
class=3D"">"${opts_long_show_layerindex_show_depends}" -- ${cur}) )<br =
class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;return 0<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;;;<br =
class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"-"*)<br=
 class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;COMPREPLY=3D( $(compgen -W<br =
class=3D"">"${opts_short_show_layerindex_show_depends}" -- ${cur}) )<br =
class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;return 0<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;;;<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;esac<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;elif [[ "${COMP_WORDS[1]}" =3D=3D =
"create-layer" ]]; then<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;case "$cur" in<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"--"*|""=
)<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;COMPREPLY=3D( $(compgen -W =
"${opts_long_show_create_layer}"<br class=3D"">-- ${cur}) )<br =
class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;return 0<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;;;<br =
class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"-"*)<br=
 class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;COMPREPLY=3D( $(compgen -W =
"${opts_short_show_create_layer}"<br class=3D"">-- ${cur}) )<br =
class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;return 0<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;;;<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;esac<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;fi<br class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;case "$prev" in<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"-c"|"--color")<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;COMPREPL=
Y=3D( $(compgen -W "${colors}" -- ${cur}) )<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
0<br class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;;;<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;esac<br class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;case "$cur" in<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"--"*)<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;COMPREPL=
Y=3D( $(compgen -W "${opts_long}" -- ${cur}) )<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
0<br class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;;;<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"-"*)<br =
class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;COMPREPL=
Y=3D( $(compgen -W "${opts_short}" -- ${cur}) )<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
0<br class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;;;<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;esac<br class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;if [[ ${prev} =3D=3D "bitbake-layers" ]]; then<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;COMPREPLY=3D( =
$(compgen -W "${subcommands}" -- ${cur}) )<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return 0<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;elif [[ ! ${subcommands} =3D~ =
[[:space:]]${cur}[[:space:]] ]]; then<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;COMPREPLY=3D( $(compgen -W =
"${subcommands}" -- ${cur}) )<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return 0<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;fi<br class=3D"">+}<br class=3D"">+complete -F =
_bitbake_layers bitbake-layers<br class=3D"">\ No newline at end of =
file<br class=3D"">diff --git =
a/contrib/completion/bash/bitbake_prserv_completion<br =
class=3D"">b/contrib/completion/bash/bitbake_prserv_completion<br =
class=3D"">new file mode 100644<br class=3D"">index =
00000000..3bca1197<br class=3D"">--- /dev/null<br class=3D"">+++ =
b/contrib/completion/bash/bitbake_prserv_completion<br class=3D"">@@ =
-0,0 +1,76 @@<br class=3D"">+#!bash<br class=3D"">+# Bash completion =
support for bitbake-prserv tool,<br class=3D"">+# compatible with =
Bitbake 1.39.1.<br class=3D"">+#<br class=3D"">+# Copyright (C) 2018 =
Lukasz Gardon &lt;<a href=3D"mailto:lukasz.gardon@gmail.com" =
class=3D"">lukasz.gardon@gmail.com</a>&gt;<br class=3D"">+#<br =
class=3D"">+# Distributed under the MIT License (MIT)<br class=3D"">+#<br =
class=3D"">+<br class=3D"">+_bitbake_prserv()<br class=3D"">+{<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;local cur prev opts_short opts_long =
subcommands file_default<br class=3D"">log_default log_levels<br =
class=3D"">+<br class=3D"">+ &nbsp;&nbsp;&nbsp;COMPREPLY=3D()<br =
class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;cur=3D"${COMP_WORDS[COMP_CWORD]}"<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;prev=3D"${COMP_WORDS[COMP_CWORD-1]}"<br class=3D"">+<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;opts_short=3D"-h -f -l"<br class=3D"">+<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;opts_long=3D"--version --help --file=3D =
--log=3D --loglevel=3D --start \<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;--stop --host=3D --port=3D"<br class=3D"">+<br=
 class=3D"">+ &nbsp;&nbsp;&nbsp;subcommands=3D"layerindex-fetch =
layerindex-show-depends add-layer \<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;remove-layer flatten show-layers =
show-overlayed \<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;show-recip=
es show-appends show-cross-depends \<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;create-lay=
er"<br class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;file_default=3D"prserv.sqlite3"<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;log_default=3D"prserv.log"<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;log_levels=3D"CRITICAL ERROR WARNING INFO DEBUG"<br =
class=3D"">+<br class=3D"">+ &nbsp;&nbsp;&nbsp;if [[ "$prev" =3D=3D "=3D" =
]]; then<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;prev=3D"${COMP_WORDS[COMP_CWORD =
-2]}"<br class=3D"">+ &nbsp;&nbsp;&nbsp;elif [[ "$cur" =3D=3D "=3D" ]]; =
then<br class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;cur=3D""<br=
 class=3D"">+ &nbsp;&nbsp;&nbsp;fi<br class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;case "$prev" in<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"-f"|"--file")<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;COMPREPL=
Y=3D( $(compgen -W "${file_default}" -- ${cur}) )<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
0<br class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;;;<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"-l"|"--log")<br =
class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;COMPREPL=
Y=3D( $(compgen -W "${log_default}" -- ${cur}) )<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
0<br class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;;;<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"--loglevel")<br =
class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;COMPREPL=
Y=3D( $(compgen -W "${log_levels}" -- ${cur}) )<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
0<br class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;;;<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;esac<br class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;case "$cur" in<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"--"*|"")<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;COMPREPL=
Y=3D( $(compgen -W "${opts_long}" -- ${cur}) )<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if [[ =
${#COMPREPLY[@]} =3D=3D 1 &amp;&amp; ${COMPREPLY[0]} =3D=3D "--"*"=3D" =
]] ;<br class=3D"">then<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;compopt -o nospace<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;fi<br =
class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
0<br class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;;;<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"-"*)<br =
class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;COMPREPL=
Y=3D( $(compgen -W "${opts_short}" -- ${cur}) )<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
0<br class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;;;<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;esac<br class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;if [[ ${prev} =3D=3D "bitbake-layers" ]]; then<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;COMPREPLY=3D( =
$(compgen -W "${subcommands}" -- ${cur}) )<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return 0<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;elif [[ ! ${subcommands} =3D~ =
[[:space:]]${cur}[[:space:]] ]]; then<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;COMPREPLY=3D( $(compgen -W =
"${subcommands}" -- ${cur}) )<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return 0<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;fi<br class=3D"">+}<br class=3D"">+complete -F =
_bitbake_prserv bitbake-prserv<br class=3D"">\ No newline at end of =
file<br class=3D"">diff --git =
a/contrib/completion/bash/bitbake_selftest_completion<br =
class=3D"">b/contrib/completion/bash/bitbake_selftest_completion<br =
class=3D"">new file mode 100644<br class=3D"">index =
00000000..8b6bf641<br class=3D"">--- /dev/null<br class=3D"">+++ =
b/contrib/completion/bash/bitbake_selftest_completion<br class=3D"">@@ =
-0,0 +1,34 @@<br class=3D"">+#!bash<br class=3D"">+# Bash completion =
support for bitbake-selftest tool,<br class=3D"">+# compatible with =
Bitbake version 1.39.1.<br class=3D"">+#<br class=3D"">+# Copyright (C) =
2018 Lukasz Gardon &lt;<a href=3D"mailto:lukasz.gardon@gmail.com" =
class=3D"">lukasz.gardon@gmail.com</a>&gt;<br class=3D"">+#<br =
class=3D"">+# Distributed under the MIT License (MIT)<br class=3D"">+#<br =
class=3D"">+<br class=3D"">+_bitbake_selftest()<br class=3D"">+{<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;local cur prev opts_short opts_long<br =
class=3D"">+<br class=3D"">+ &nbsp;&nbsp;&nbsp;COMPREPLY=3D()<br =
class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;cur=3D"${COMP_WORDS[COMP_CWORD]}"<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;prev=3D"${COMP_WORDS[COMP_CWORD-1]}"<br class=3D"">+<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;opts_short=3D"-h -v -q -f -c"<br =
class=3D"">+<br class=3D"">+ &nbsp;&nbsp;&nbsp;opts_long=3D"--help =
--verbose --quiet --locals --failfast --catch"<br class=3D"">+<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;case "$cur" in<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"--"*)<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;COMPREPL=
Y=3D( $(compgen -W "${opts_long}" -- ${cur}) )<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
0<br class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;;;<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"-"*)<br =
class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;COMPREPL=
Y=3D( $(compgen -W "${opts_short}" -- ${cur}) )<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
0<br class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;;;<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;esac<br class=3D"">+}<br =
class=3D"">+complete -F _bitbake_selftest bitbake-selftest<br class=3D"">\=
 No newline at end of file<br class=3D"">--<br class=3D"">2.18.0<br =
class=3D""><br class=3D"">--<br =
class=3D"">_______________________________________________<br =
class=3D"">bitbake-devel mailing list<br class=3D""><a =
href=3D"mailto:bitbake-devel@lists.openembedded.org" =
class=3D"">bitbake-devel@lists.openembedded.org</a><br =
class=3D"">http://lists.openembedded.org/mailman/listinfo/bitbake-devel<br=
 class=3D""><br class=3D""><br =
class=3D""></blockquote></div></div></blockquote></div><br =
class=3D""></div></div></div></blockquote></div><br =
class=3D""></div></div></blockquote></div><br =
class=3D""></div></div></body></html>=

--Apple-Mail=_2B0A5304-1D20-4A5A-B471-889CC96C54E0--
