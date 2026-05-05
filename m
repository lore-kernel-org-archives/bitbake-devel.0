Return-Path: <tgamblin@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73351FF8855
	for <webhook@archiver.kernel.org>; Tue,  5 May 2026 16:17:12 +0000 (UTC)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.52.1777997831094565469
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 May 2026 09:17:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20251104.gappssmtp.com header.s=20251104 header.b=EO8sI/p3;
 spf=pass (domain: baylibre.com, ip: 209.85.217.44, mailfrom: tgamblin@baylibre.com)
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5ff05af29b4so2074269137.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 05 May 2026 09:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777997830; x=1778602630; darn=lists.openembedded.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6nGSvQVpSfeJYCcs1PDXxkoAM88WLZN8az4OGBrRbmg=;
        b=EO8sI/p30J/m2COiVYCZabdn5F4/61GIiS3Rk7KMBce88rcUMRTtcqgtTMj9dmkGBt
         mEFkt1Nn1iBvbZM8wUW/QagG20C8v7Dq3V3rbaS8f+DcbWzrHqNRQ80UlCQcMuuvM+Js
         E5KW3GX1v9C+SDeTg/Vr/UKg98UjinGKTSFWxqY0T4Vcgnbb1eBcT/yGwf7ep9rHfDLh
         cAN5zpxW3+qZK1snsrtxv4AVwxa0SHSAv0PhEfvD/HNU/y6JU/5e8gAtKUd3B7a8LOvG
         LQlGd9vMFTOci/Nr/1o+5J9BIgjBF3RT0Sta8KJ+3fd0s3+2GPh7Tcszv2HMV21OwX69
         vL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777997830; x=1778602630;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6nGSvQVpSfeJYCcs1PDXxkoAM88WLZN8az4OGBrRbmg=;
        b=lgGcNrSHmlwT7DxWhWq9dMns9cE9bVt+VFeVOpEXp2K7zXKGDycCMvEqcSVjc3IkOX
         j5jtQz8vyXceV3umhjT1hVO0jlwg/1/2mSnnkDDXu+fFIsWZ9t4XPrCxFo2IOFwejCY6
         15XmuSEjBAR5pqTH2LtAooXYCMTZk2FvYAGniAttuuihP+tdg5fsiwM8RCaFUp6P8e7N
         R5yQXn2hf9o4ZyyAt8LsyHx62J1pfIs09cRgoHLt8DT4SLHNCqM4vGM5/73L2rMAV+IS
         dQk3nkzEdpQtiJ09rCk6wZ31eKM5cWGwUk6ZK0UE/dMS5I0oQ++H9MBP0+RNs1S/IW0Z
         jsUw==
X-Forwarded-Encrypted: i=1; AFNElJ8AvczYX/HX9fxKubg2H2OnqrpLniOcmGrI01TpT97H/8Glf/37eWAZ5wEhQ083lwRmTllygu/OJmqjB77Q@lists.openembedded.org
X-Gm-Message-State: AOJu0YyfgyAXN3zEY7UD2QFIE8Rwwcf5G8O+AguvfjMVATwJNMdia08H
	49luJCnH8C/uAi68mYu8fCurBmt6wPFF5e0Hz8WA06UOOfZdV0snjSDAYlqoc1fpjQI=
X-Gm-Gg: AeBDieuJ8ukcmKWBnjrR+Ve5ZHVwLACJc21k6zmr96tw2HQYTKiANHWAfhIXtlWxrYt
	bs+cMucH4JOw/1hlYzvUJOMFA4b5KfhfUxdCqRPLIYUtcEr5xFIGt7OpTcjenOjlKsy//HpI2Op
	v1SMYusQVWyF8yvrOfXpuV+xhEltR355X4hL4k3pHMK7y7MRYK8ESec0ZnvCzn6mnClcGdoLXzr
	lNa1yy22xbbNihq0lq2SttDi9KrGxADwpOG4Tmk0SyN324mOYw23zrP7R6fcty69KqJOvHbAqNv
	WAa3OaLNe8bVVwLPnZPq14ZjjNgDYknod96npi02zGovxNiaqLILOjl+FJQACuMdC/4vyGrUE43
	+gqOS7DNhNuXWtr9PpB7u6Kt4n0opZMczXNva0HR8GzLnJuRvCcXra6+HvQJW34Np+UVYZDL8yY
	tpOpAk7HCWJe5wax7tAcMwEUxUqeieiQCU0dgl4QOjH3+iNt6d+8ht9cx3RCk22UoJhYLERJDIf
	xF5RSonz353QU4=
X-Received: by 2002:a05:6102:50a5:b0:605:3556:6619 with SMTP id ada2fe7eead31-62f593135e9mr2250953137.31.1777997829842;
        Tue, 05 May 2026 09:17:09 -0700 (PDT)
Received: from ?IPV6:2001:1970:3847:e000:1977:be2f:4a71:2892? ([2001:1970:3847:e000:1977:be2f:4a71:2892])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-62bfd8b5aeesm7598475137.7.2026.05.05.09.17.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 09:17:09 -0700 (PDT)
Message-ID: <66b3dbc7-e6f0-4013-8d2e-d646f0fd8c9b@baylibre.com>
Date: Tue, 5 May 2026 12:17:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Openembedded-architecture] proposal: build pipelines in
 bitbake-setup
To: alex.kanavin@gmail.com,
 openembedded-architecture
 <openembedded-architecture@lists.openembedded.org>,
 bitbake-devel <bitbake-devel@lists.openembedded.org>,
 Yocto-mailing-list <yocto@lists.yoctoproject.org>
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
References: <CANNYZj-hrSdEoX5XRmM1MYhXMVkqpa0CBHHbMqVhjM034bKTDg@mail.gmail.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <CANNYZj-hrSdEoX5XRmM1MYhXMVkqpa0CBHHbMqVhjM034bKTDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 05 May 2026 16:17:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19438


On 2026-05-05 06:17, Alexander Kanavin via lists.openembedded.org wrote:
> Hello,
>
> bitbake-setup currently doesn't support describing build pipelines: a
> sequence of commands that actually produce something useful. For a
> true end-to-end solution this gap should be filled.
>
> Here's my proposal, which probably has obvious shortcomings, that I
> would like to hear about :)

Hi,

Thanks for submitting this proposal. I will try to summarize some of my 
thoughts from the public call and otherwise in-line.

>
> 0. Design goals:
>
> - something suitable for most situations, including newcomers running
> a local build, and CI doing a nightly job
> - avoid custom scripts in most situations
> - self-documented; everything must be described
> - extensible; if there's something missing that no one thought about,
> it can be added later in a way that supplements existing features
> without replacing them.
>
> 1. Specification in a build configuration would look like this:
>
> "build-targets": {
>      "steps" : [
>          { "name": "build-apple", "description": "Build an apple for
> the purpose of making apple pie", "command": "bitbake apple-image"},
>          { "name": "build-orange", "description": "Build an orange for
> the purpose of making orange juice", "command": "bitbake
> orange-image"},
>          { "name": "test-apple", "description": "Test an apple using
> testimage class", "command": "bitbake -c testimage apple-image"},
>          { "name": "test-orange", "description": "Test an orange using
> testimage class", "command": "bitbake -c testimage orange-image"},
>          { "name": "qemu-console", "description": "Start the last built
> image in qemu with console UI", "command": "runqemu kvm snapshot
> nographic"},
>          { "name": "publish", "description":"Copy build artefacts to a
> public download server", "command":
> "path/to/publish-image-executable"}
>      ],
>      "pipelines": [
>          {"name": "publish-apple", "description": "Build, test, and
> publish apple (requires publishing rights on the download server)",
> "steps": ["build-apple", "test-apple", "publish"]},
>          {"name": "publish-orange", "description": "Build, test, and
> publish orange  (requires publishing rights on the download server)",
> "steps": ["build-orange", "test-orange", "publish"]},
>          {"name": "qemu-apple", "description": "Build and start apple
> in qemu with console UI", "steps": ["build-apple", "qemu-console"]},
>          {"name": "qemu-orange", "description": "Build and start orange
> in qemu with console UI", "steps": ["build-orange", "qemu-console"]}
>      ]
> }
>
> Configurations would include a list of possible pipelines:
>          "configurations": [
>          {
>              "name": "fruitgarden",
>              "description": "Alex's fruit garden",
>              "bb-layers": ["meta-fruit"],
>              "oe-fragments": [ "distro/fruit-garden", "machine/earth" ],
>              "pipelines": ["qemu-apple", "qemu-orange",
> "publish-apple", "publish-orange"]
>          }
I think it's worth considering for the nightly-job-in-CI case whether 
people will want to use bitbake-setup to cover that entire scope (i.e., 
build-test-publish). There are a lot of existing CI systems out there 
(Buildbot, Tekton, GitHub/Gitea/Forgejo Actions, GitLab CI, etc.) where 
you already define pipelines as a series of stages/steps, and each one 
is generally intended to cover either a single command or a handful of 
closely-associated ones. I am not sure that users would want to invoke a 
bitbake-setup pipeline as a single step in these systems, as that would 
potentially obfuscate failures and configuration issues just by having 
too many things happening per step. However, I can see it being useful 
to people who want a fire-and-forget reproducer for typical build/test 
configurations.

As a side note, it feels like stepping outside of the "build setup" 
space and including things like runtime testing, artifact publishing, 
etc. feels like a clash with bitbake-setup's name.
>
> 2. Nomenclature:
>
> - "step" is a single command that is also given a short name and a
> longer description. Steps are building blocks for pipelines and can't
> be individually executed.
Why not? Why not have the ability to run something like 'bitbake-setup 
run-step <step_name'? That would actually be an advantage this feature 
could provide over many other CI systems, as it's usually difficult or 
impossible to rerun individual steps (you have to re-run a whole job or 
pipeline). I can see this being very useful for example when you need to 
run 'bitbake -c testimage' in a loop many times to try and catch 
intermittent failures.
> - "pipeline" is a sequence of steps, that is also given a short name
> and a longer description. Pipelines can mix and match defined steps as
> they please.
> - each configuration includes a list of possible targets, and once it
> is set up, any of them can be executed (see below for the UI).
>
> 3. User Interface to pipelines
>
> Once there is a setup, there are two ways to execute a pipeline:
>
> a) For each pipeline there is a shell script that can be run directly:
>
> /path/to/bitbake-builds/fruitgarden/qemu-apple
> /path/to/bitbake-builds/fruitgarden/publish-apple
> etc.
>
> qemu-apple script would look something like:
>
> #!/bin/sh
> # Build and start apple in qemu with console UI
> . init-build-env
> # Build an apple for the purpose of making apple pie
> bitbake apple-image
> # Start the last built image in qemu with console UI
> runqemu kvm snapshot nographic
>
> e.g. assembled from pipeline steps and their descriptions.
Similarly here - maybe a 'bitbake-setup run-pipeline <pipeline_name>' 
would be more effective?
>
> b) Interactive UI :'bitbake-setup build'
>
> This would present an interactive UI similar to 'bitbake-setup init', e.g:
> $ bitbake-setup build
> Available build pipelines:
> 1. qemu-apple  Build and start apple in qemu with console UI
> 2. qemu-orange Build and start orange in qemu with console UI
> ... etc
> Please choose one of the above: 1
>
> The following commands will be executed:
> # Build an apple for the purpose of making apple pie
> bitbake apple-image
> # Start the last built image in qemu with console UI
> runqemu kvm snapshot nographic
>
> Proceed? [y/N]
> etc.
>
> 4. Implementation
>
> This should actually be fairly straightforward. There's no need to add
> new features to bitbake (e.g. 'standard target definitions' in layers
> was considered at some point, but after more consideration I think it
> can be postponed or perhaps altogether avoided), or modify oe-core.
My other main concern about this is around maintenance - depending on 
how it is ultimately implemented, it could end up looking like a 
miniature CI/CD system for Yocto builds - that is certainly how I find 
myself seeing it, and I've written my responses in that mindset. I can 
see the utility in having the feature available more generally to reduce 
time spent reproducing a common build/test case, but I wonder if it'd 
get used often enough under its currently proposed form.

Trevor
>
> Alex
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#2324): https://lists.openembedded.org/g/openembedded-architecture/message/2324
> Mute This Topic: https://lists.openembedded.org/mt/119158252/7611679
> Group Owner: openembedded-architecture+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/openembedded-architecture/unsub [tgamblin@baylibre.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

