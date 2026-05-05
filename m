Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE91CD3436
	for <webhook@archiver.kernel.org>; Tue,  5 May 2026 10:18:15 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.35501.1777976288898345092
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 May 2026 03:18:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=hoG/w52h;
 spf=pass (domain: gmail.com, ip: 209.85.219.53, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8acae26e564so56962836d6.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 05 May 2026 03:18:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777976288; cv=none;
        d=google.com; s=arc-20240605;
        b=eAiupGFSJuPtNcG2pIdnIWiMhqLt1ziX9SWHeNwzjrDiYgkca3cSDL4zj2vRSAKpWm
         /wQPZtmJs3MsWij7sFvcVEgDn6DPXX1wdABTeWl6Pj0Mcu8CZoaJT54RxPku9aT6aQhq
         UxwB0BWNyKoTiuamrfgmELO/MjviiASCoIaRDwh6uAjfgelNnDvlhwokDoeybQqDakNX
         xdAX6ojKVm5v9dUaltD33dMz/kmp3K/Bo6/V+9in9C0MKF4Z3Gliq5HzJxPe/3Sxi7Gr
         2RkDwr/qstzrp3+vqISi1asbEOu3/YrF3FTuORSKM6oL67wOwfjp7xgwH7YZfzdD4mOW
         hzEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=yLH7T/q9GlnulcBlgWduRvWX+JuQf6bMzZp1jQz/M/o=;
        fh=s6/eSLcAb/9Eou+x7s6XzERmHPTCE2m421x3NkLhcjg=;
        b=ZYNbE0tBnfjkmxAaS2aU6ghf5BbN6C8gvWbmSPdRwur7dZud29RLzNRpeghKRGg76r
         RZ6AI65qdiMlzaJLCzFO4sRdIjcMrhxuoz7P6Y/ux6T9fV8wISr/BgXL6rz8vomnrKxA
         zgNH8xfS/udGoqB4fchFKtaOpS0fBGcPVqovlWGw42w7jaoWCvjNYzmMF5eLbggNiBYA
         X/5x0BmMz52OIDNa8BnMeHCglGTaFBAP6LmuWyl6p+Rnv1iX+92yqPbEE11c0lyqYVw/
         mAdYaW0DNZ0nhXdbl+4OJwT5dOXuM4U02w6KgSdvscjZ5p9K0NEyHpD6t5w1I8UtOXLZ
         yQ2g==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777976288; x=1778581088; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yLH7T/q9GlnulcBlgWduRvWX+JuQf6bMzZp1jQz/M/o=;
        b=hoG/w52h+ROzuYcwa1unUhTh/fi0jyDqDYRhUc7BQh4yMgPKy/JdNspjHCO/x2ds5H
         4WQIgPe/nz8AD0zq53snCebC4xKicb/3SFSAxD7XkP6WHjisR6y9n1ATwoQPTsgVRF7H
         vTbDg5zkpluk+CD8su27cclJFZb87UoQRC8wbMDl7bKeu3ruA6FXfMOn/PE5jYhNG4sA
         XCsv/3wYI4G/dPP7inCOMfbo5KF3CqDCakzv5beW+jG67J7f7/EwsK9Rd/jZrHS/QyBB
         mrt2x+Js025iU8dXf9hb6+gm4ZWNeWQUvQDiqYgg3FTdev6RgIQfBNaFm22chfFp25Oa
         S9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777976288; x=1778581088;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yLH7T/q9GlnulcBlgWduRvWX+JuQf6bMzZp1jQz/M/o=;
        b=AQMItw2Nwc+7VC2Cm9LD469gBAR3fBVSWZDO9rZGKeYDJRuSMb7Vv3GJtx9glyGs5b
         uMPamClzo2KGTA9XDXYhO+E46rGONiOV2pj3kLkLa7ugnrMxDWGpH4o40Gk5YxyzTm4r
         YQR0iEm9JMqQf8gox2SbwREKGMZsOrFL4V+DUAgaTsDR4CZcfcBjIDElZV5mYeN9BqDu
         7AqgfrjbFW2MD7irtc0DvzNoaHIKYHfIzEdKbHjtVRSjv9huGr4Ew4bditG6mG0dJCNG
         2Ym+Wm0Tbc6eaGFzZux5/g3djnDpZD4SsHUB79WczgN8v7yPvS9gmufVNstnTIZAWah+
         gNgg==
X-Forwarded-Encrypted: i=1; AFNElJ9N4CWO4HBBYHRssh2hfnOI8Zyv4hDqgirIoyQbogH7778IlQSg8s5tDhKMm9gMbd6Cabw53qsjeq8uxwoC@lists.openembedded.org
X-Gm-Message-State: AOJu0YxNOm+HlFKGEBaH78C7l64U6XTpO3bWU+YJ22AW7v0bG82Ug+cN
	q6s4YPqFxScCnYCWfc2U/DiDawCcYTk48J5lnj9XIJrq1WzwsMGyp715RpaFrAgiSJSz3V7l8Fa
	6jBORBrtNNipZRa+uu5OcLPZHLaNhsPk=
X-Gm-Gg: AeBDiesvmTUhUlOGXrodBeT8JnlbSA6kSWzN8KKarhiiyeahwATKdiAt4yrhCbXtZyF
	zkiyBf61MyemZyWo/DgRrnX3MKv2fDDJRq/k75CBVOtfpGZaMxgHUI3gvwvT/vXIyuoAiyzQ//7
	2JDuOV/vy2T02r/Rh06sz4G5WdTVgUKHPOwufDk1g7m6ec+cUJ009sd44cYACIv+IswuUxZk8V7
	dNqmn3FT3eDG/HzotLt0kf0TKJm7ywm9QO7ReuthAp614Sp4tjruaAPRtA0fROcWPlzcKjABc7n
	J2K+kNpYAJgdbbDXYCIGgXFlvwfW8C0YJ2kpmxjPGyRHNv2o5H2C
X-Received: by 2002:a0c:f40c:0:b0:8ac:a62a:a451 with SMTP id
 6a1803df08f44-8b6667ee786mr228338486d6.12.1777976287813; Tue, 05 May 2026
 03:18:07 -0700 (PDT)
MIME-Version: 1.0
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 5 May 2026 12:17:56 +0200
X-Gm-Features: AVHnY4LDlgd8L4ccdLjUQRzUXFt9PQH3zC1NelmB_8Gd1bEl84Gq1OtOseKbz4w
Message-ID: <CANNYZj-hrSdEoX5XRmM1MYhXMVkqpa0CBHHbMqVhjM034bKTDg@mail.gmail.com>
Subject: proposal: build pipelines in bitbake-setup
To: openembedded-architecture <openembedded-architecture@lists.openembedded.org>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	Yocto-mailing-list <yocto@lists.yoctoproject.org>
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 05 May 2026 10:18:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19435

Hello,

bitbake-setup currently doesn't support describing build pipelines: a
sequence of commands that actually produce something useful. For a
true end-to-end solution this gap should be filled.

Here's my proposal, which probably has obvious shortcomings, that I
would like to hear about :)

0. Design goals:

- something suitable for most situations, including newcomers running
a local build, and CI doing a nightly job
- avoid custom scripts in most situations
- self-documented; everything must be described
- extensible; if there's something missing that no one thought about,
it can be added later in a way that supplements existing features
without replacing them.

1. Specification in a build configuration would look like this:

"build-targets": {
    "steps" : [
        { "name": "build-apple", "description": "Build an apple for
the purpose of making apple pie", "command": "bitbake apple-image"},
        { "name": "build-orange", "description": "Build an orange for
the purpose of making orange juice", "command": "bitbake
orange-image"},
        { "name": "test-apple", "description": "Test an apple using
testimage class", "command": "bitbake -c testimage apple-image"},
        { "name": "test-orange", "description": "Test an orange using
testimage class", "command": "bitbake -c testimage orange-image"},
        { "name": "qemu-console", "description": "Start the last built
image in qemu with console UI", "command": "runqemu kvm snapshot
nographic"},
        { "name": "publish", "description":"Copy build artefacts to a
public download server", "command":
"path/to/publish-image-executable"}
    ],
    "pipelines": [
        {"name": "publish-apple", "description": "Build, test, and
publish apple (requires publishing rights on the download server)",
"steps": ["build-apple", "test-apple", "publish"]},
        {"name": "publish-orange", "description": "Build, test, and
publish orange  (requires publishing rights on the download server)",
"steps": ["build-orange", "test-orange", "publish"]},
        {"name": "qemu-apple", "description": "Build and start apple
in qemu with console UI", "steps": ["build-apple", "qemu-console"]},
        {"name": "qemu-orange", "description": "Build and start orange
in qemu with console UI", "steps": ["build-orange", "qemu-console"]}
    ]
}

Configurations would include a list of possible pipelines:
        "configurations": [
        {
            "name": "fruitgarden",
            "description": "Alex's fruit garden",
            "bb-layers": ["meta-fruit"],
            "oe-fragments": [ "distro/fruit-garden", "machine/earth" ],
            "pipelines": ["qemu-apple", "qemu-orange",
"publish-apple", "publish-orange"]
        }

2. Nomenclature:

- "step" is a single command that is also given a short name and a
longer description. Steps are building blocks for pipelines and can't
be individually executed.
- "pipeline" is a sequence of steps, that is also given a short name
and a longer description. Pipelines can mix and match defined steps as
they please.
- each configuration includes a list of possible targets, and once it
is set up, any of them can be executed (see below for the UI).

3. User Interface to pipelines

Once there is a setup, there are two ways to execute a pipeline:

a) For each pipeline there is a shell script that can be run directly:

/path/to/bitbake-builds/fruitgarden/qemu-apple
/path/to/bitbake-builds/fruitgarden/publish-apple
etc.

qemu-apple script would look something like:

#!/bin/sh
# Build and start apple in qemu with console UI
. init-build-env
# Build an apple for the purpose of making apple pie
bitbake apple-image
# Start the last built image in qemu with console UI
runqemu kvm snapshot nographic

e.g. assembled from pipeline steps and their descriptions.

b) Interactive UI :'bitbake-setup build'

This would present an interactive UI similar to 'bitbake-setup init', e.g:
$ bitbake-setup build
Available build pipelines:
1. qemu-apple  Build and start apple in qemu with console UI
2. qemu-orange Build and start orange in qemu with console UI
... etc
Please choose one of the above: 1

The following commands will be executed:
# Build an apple for the purpose of making apple pie
bitbake apple-image
# Start the last built image in qemu with console UI
runqemu kvm snapshot nographic

Proceed? [y/N]
etc.

4. Implementation

This should actually be fairly straightforward. There's no need to add
new features to bitbake (e.g. 'standard target definitions' in layers
was considered at some point, but after more consideration I think it
can be postponed or perhaps altogether avoided), or modify oe-core.

Alex

