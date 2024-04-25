Return-Path: <sam@liddicott.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79A3C4345F
	for <webhook@archiver.kernel.org>; Thu, 25 Apr 2024 10:45:49 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
 by mx.groups.io with SMTP id smtpd.web11.13837.1714041943062896991
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 25 Apr 2024 03:45:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@liddicott-com.20230601.gappssmtp.com header.s=20230601 header.b=ovIH+FAI;
 spf=none, err=SPF record not found (domain: liddicott.com, ip: 209.85.218.50, mailfrom: sam@liddicott.com)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a56d7d457a1so98497366b.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 25 Apr 2024 03:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=liddicott-com.20230601.gappssmtp.com; s=20230601; t=1714041941; x=1714646741; darn=lists.openembedded.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aU1NoOxKyNcQFzt49x/cBC6knci6Jj5OOmMdmrky3JU=;
        b=ovIH+FAItVjLU6ZeC43PgUmVo3gnmxz1v9R73zilacRZEP3Uo3BO/leEhjvkrCxf20
         xkJQTT+FVeQ+gg+vb+P5v2+wWpSnNfS7W+kDmJt6t0YXHlIzhACp2XewZHawUbpp+muB
         ZFdMzPWDP1vFf5eNrfvXfbDtBpbqLjQRNs3ejZUblP3inAo4Ek/tU8AFzH4zzo3ldjue
         m7wXlf3zRXfD/nbhP7zhBXoUOkGR0wKg6OGtJ1eqZykrtETfW9JdbSNgLuCvupI8uRXu
         rcx2VNOeIwa1XADd6qLXQS1+ijxh/CmFfohpaZMvmSjtL6zctHaAnyUvax50Z0FDrESZ
         d/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714041941; x=1714646741;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aU1NoOxKyNcQFzt49x/cBC6knci6Jj5OOmMdmrky3JU=;
        b=R+fZs66xn6Vlo6cHHZ9z095Il/6sb4J3BejTHnq06AB2OOlTQc0th9czf5EzwmW5ki
         qhzH0pUVYAplS3D4m5R0AOQ+aaRRoYrwahiPvFZDhHLPF0h/R6UXvtxzaATJGbhIeNtA
         jcoiolVR20T8sjoPwCAqSZCx+wEagzC4+JG5XniihSe/uHpP5iiRFpczW6mesIZaWZfG
         MAAsKhCgp5DIT2v9gyiELFa5Rg3NE7xZShFEA0VLCoq06XSo5yyOOPoyEZ9I5J4URuXW
         391utxViKJ8gyeQ7IbwKUoSUCM+r7dOXyX/eBYcgNpymiT+vbBTl5P/Rp8EVs7kXI1IX
         bjVQ==
X-Gm-Message-State: AOJu0Yz6jlSGAh79waFPC58dCxZ65CFIksVrAsp9Sq3z8YE9U4rgp4bk
	dbxK04N+lnKVwJlg3gXoubp8bzr8YIA5vHpDtdolecVgdKnkjM9PkISIaHxRCbnOJPOfMoKqtOm
	XnL2D+LC46iCzKlXbmwWb3GcfCe4xp80ElTN0OrUB/wMENa5Yk6aq
X-Google-Smtp-Source: AGHT+IF5JV3L7XleDtWrRIZuPkRWU7oAI31pIDdbetmav9sJ2JirgVMVPghWEq4muLUWMcNasIYHXU9Nc16gFLiR7vg=
X-Received: by 2002:a17:906:2896:b0:a46:65fd:969d with SMTP id
 o22-20020a170906289600b00a4665fd969dmr3469555ejd.71.1714041940647; Thu, 25
 Apr 2024 03:45:40 -0700 (PDT)
MIME-Version: 1.0
From: Sam Liddicott <sam@liddicott.com>
Date: Thu, 25 Apr 2024 11:45:04 +0100
Message-ID: <CAOj-5WAjWd78fvVVT_oNboRia61QXjyqcAtKXSyYtOPO7VR1jA@mail.gmail.com>
Subject: Solution to recover from missing SPDX problems
To: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000000bfe20616e97d7c"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 25 Apr 2024 10:45:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16140

--00000000000000bfe20616e97d7c
Content-Type: text/plain; charset="UTF-8"

I've been plagued with the SPDX issues described here:
https://lists.yoctoproject.org/g/yocto/topic/sstate_cache_issue_with_spdx/99403018

It seems to hit randomly where recipes fail because the assumed-deployed
SPDX files of other dependent packages are missing, e.g.

Exception: FileNotFoundError: [Errno 2] No such file or directory:
'/.../build_output/deploy/spdx/product/recipes/recipe-bzip2-native.spdx.json'
ERROR: Logfile of failure stored in:
/.../build_output/work/x86_64-linux/rust-llvm-native/1.59.0-r0/temp/log.do_create_spdx.4100101
ERROR: Task
(virtual:native:/.../meta/recipes-devtools/rust/rust-llvm_1.59.0.bb:do_create_spdx)
failed with exit code '1'

Recovery is not been easy, but here I share a tip on how to recover from
the situation:

# First re-run failed bitbake with -g option to compute dependencies into
file pn-buildlist
bitbake ... *-g*

# then run bitbake to force re-run of do_create_spdx for those dependencies
$ bitbake ... $(cat pn-buildlist) -c do_create_spdx -f ...

# then re-run the failed command (you know what it was)
bitbake ...

The general issue seems to be that recipes tasks don't track
build_output/deploy artifacts and don't know to re-run if they are missing,
maybe related to the fact that some sstate is being replayed but not
do_create_spdx (perhaps for the reason give).

I hope this is helpful, I'll be building it into my meta-build tool to help
developers recover from this situation.

Sam

--00000000000000bfe20616e97d7c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I&#39;ve been plagued with the SPDX issues described here:=
=C2=A0<a href=3D"https://lists.yoctoproject.org/g/yocto/topic/sstate_cache_=
issue_with_spdx/99403018">https://lists.yoctoproject.org/g/yocto/topic/ssta=
te_cache_issue_with_spdx/99403018</a><div><br></div><div>It seems to hit ra=
ndomly where recipes fail because the assumed-deployed SPDX files of other =
dependent packages are missing, e.g.</div><div><br></div><div><font face=3D=
"monospace">Exception: FileNotFoundError: [Errno 2] No such file or directo=
ry: &#39;/.../build_output/deploy/spdx/product/recipes/recipe-bzip2-native.=
spdx.json&#39;<br>ERROR: Logfile of failure stored in: /.../build_output/wo=
rk/x86_64-linux/rust-llvm-native/1.59.0-r0/temp/log.do_create_spdx.4100101<=
br>ERROR: Task (virtual:native:/.../meta/recipes-devtools/rust/rust-llvm_1.=
59.0.bb:do_create_spdx) failed with exit code &#39;1&#39;</font><br></div><=
div><br></div><div>Recovery is not been easy, but here I share a tip on how=
 to recover from the situation:<br></div><div><br></div><div># First re-run=
 failed bitbake with -g option to compute dependencies into file pn-buildli=
st</div><div>bitbake ...=C2=A0<b>-g</b></div><div><br># then run bitbake to=
 force re-run of do_create_spdx for those dependencies</div><div><span clas=
s=3D"gmail-ui-provider ed gmail-brd gmail-bpn gmail-bre gmail-brf gmail-brg=
 gmail-brh gmail-bri gmail-brj gmail-brk gmail-brl gmail-brm gmail-brn gmai=
l-bro gmail-brp gmail-brq gmail-brr gmail-brs gmail-brt gmail-bru gmail-brv=
 gmail-brw gmail-brx gmail-bry gmail-brz gmail-bsa gmail-bsb gmail-bsc gmai=
l-bsd gmail-bse gmail-bsf gmail-bsg gmail-bsh gmail-bsi gmail-bsj" dir=3D"l=
tr">$ bitbake ... $(cat pn-buildlist) -c do_create_spdx -f ...</span><br></=
div><div><span class=3D"gmail-ui-provider ed gmail-brd gmail-bpn gmail-bre =
gmail-brf gmail-brg gmail-brh gmail-bri gmail-brj gmail-brk gmail-brl gmail=
-brm gmail-brn gmail-bro gmail-brp gmail-brq gmail-brr gmail-brs gmail-brt =
gmail-bru gmail-brv gmail-brw gmail-brx gmail-bry gmail-brz gmail-bsa gmail=
-bsb gmail-bsc gmail-bsd gmail-bse gmail-bsf gmail-bsg gmail-bsh gmail-bsi =
gmail-bsj" dir=3D"ltr"><br></span></div><div><span class=3D"gmail-ui-provid=
er ed gmail-brd gmail-bpn gmail-bre gmail-brf gmail-brg gmail-brh gmail-bri=
 gmail-brj gmail-brk gmail-brl gmail-brm gmail-brn gmail-bro gmail-brp gmai=
l-brq gmail-brr gmail-brs gmail-brt gmail-bru gmail-brv gmail-brw gmail-brx=
 gmail-bry gmail-brz gmail-bsa gmail-bsb gmail-bsc gmail-bsd gmail-bse gmai=
l-bsf gmail-bsg gmail-bsh gmail-bsi gmail-bsj" dir=3D"ltr"># then re-run th=
e failed command (you know what it was)</span></div><div><span class=3D"gma=
il-ui-provider ed gmail-brd gmail-bpn gmail-bre gmail-brf gmail-brg gmail-b=
rh gmail-bri gmail-brj gmail-brk gmail-brl gmail-brm gmail-brn gmail-bro gm=
ail-brp gmail-brq gmail-brr gmail-brs gmail-brt gmail-bru gmail-brv gmail-b=
rw gmail-brx gmail-bry gmail-brz gmail-bsa gmail-bsb gmail-bsc gmail-bsd gm=
ail-bse gmail-bsf gmail-bsg gmail-bsh gmail-bsi gmail-bsj" dir=3D"ltr">bitb=
ake ...</span></div><div><span class=3D"gmail-ui-provider ed gmail-brd gmai=
l-bpn gmail-bre gmail-brf gmail-brg gmail-brh gmail-bri gmail-brj gmail-brk=
 gmail-brl gmail-brm gmail-brn gmail-bro gmail-brp gmail-brq gmail-brr gmai=
l-brs gmail-brt gmail-bru gmail-brv gmail-brw gmail-brx gmail-bry gmail-brz=
 gmail-bsa gmail-bsb gmail-bsc gmail-bsd gmail-bse gmail-bsf gmail-bsg gmai=
l-bsh gmail-bsi gmail-bsj" dir=3D"ltr"><br></span></div><div><span class=3D=
"gmail-ui-provider ed gmail-brd gmail-bpn gmail-bre gmail-brf gmail-brg gma=
il-brh gmail-bri gmail-brj gmail-brk gmail-brl gmail-brm gmail-brn gmail-br=
o gmail-brp gmail-brq gmail-brr gmail-brs gmail-brt gmail-bru gmail-brv gma=
il-brw gmail-brx gmail-bry gmail-brz gmail-bsa gmail-bsb gmail-bsc gmail-bs=
d gmail-bse gmail-bsf gmail-bsg gmail-bsh gmail-bsi gmail-bsj" dir=3D"ltr">=
The general issue seems to be that recipes tasks don&#39;t track build_outp=
ut/deploy artifacts and don&#39;t know to re-run if they are missing, maybe=
 related to the fact that some sstate is being replayed but not do_create_s=
pdx (perhaps for the reason give).</span></div><div><span class=3D"gmail-ui=
-provider ed gmail-brd gmail-bpn gmail-bre gmail-brf gmail-brg gmail-brh gm=
ail-bri gmail-brj gmail-brk gmail-brl gmail-brm gmail-brn gmail-bro gmail-b=
rp gmail-brq gmail-brr gmail-brs gmail-brt gmail-bru gmail-brv gmail-brw gm=
ail-brx gmail-bry gmail-brz gmail-bsa gmail-bsb gmail-bsc gmail-bsd gmail-b=
se gmail-bsf gmail-bsg gmail-bsh gmail-bsi gmail-bsj" dir=3D"ltr"><br></spa=
n></div><div><span class=3D"gmail-ui-provider ed gmail-brd gmail-bpn gmail-=
bre gmail-brf gmail-brg gmail-brh gmail-bri gmail-brj gmail-brk gmail-brl g=
mail-brm gmail-brn gmail-bro gmail-brp gmail-brq gmail-brr gmail-brs gmail-=
brt gmail-bru gmail-brv gmail-brw gmail-brx gmail-bry gmail-brz gmail-bsa g=
mail-bsb gmail-bsc gmail-bsd gmail-bse gmail-bsf gmail-bsg gmail-bsh gmail-=
bsi gmail-bsj" dir=3D"ltr">I hope this is helpful, I&#39;ll be building it =
into my meta-build tool to help developers recover from this situation.</sp=
an></div><div><span class=3D"gmail-ui-provider ed gmail-brd gmail-bpn gmail=
-bre gmail-brf gmail-brg gmail-brh gmail-bri gmail-brj gmail-brk gmail-brl =
gmail-brm gmail-brn gmail-bro gmail-brp gmail-brq gmail-brr gmail-brs gmail=
-brt gmail-bru gmail-brv gmail-brw gmail-brx gmail-bry gmail-brz gmail-bsa =
gmail-bsb gmail-bsc gmail-bsd gmail-bse gmail-bsf gmail-bsg gmail-bsh gmail=
-bsi gmail-bsj" dir=3D"ltr"><br></span></div><div><span class=3D"gmail-ui-p=
rovider ed gmail-brd gmail-bpn gmail-bre gmail-brf gmail-brg gmail-brh gmai=
l-bri gmail-brj gmail-brk gmail-brl gmail-brm gmail-brn gmail-bro gmail-brp=
 gmail-brq gmail-brr gmail-brs gmail-brt gmail-bru gmail-brv gmail-brw gmai=
l-brx gmail-bry gmail-brz gmail-bsa gmail-bsb gmail-bsc gmail-bsd gmail-bse=
 gmail-bsf gmail-bsg gmail-bsh gmail-bsi gmail-bsj" dir=3D"ltr">Sam</span><=
/div></div>

--00000000000000bfe20616e97d7c--

