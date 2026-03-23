Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11764F4610E
	for <webhook@archiver.kernel.org>; Mon, 23 Mar 2026 13:24:55 +0000 (UTC)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17309.1774272289519680747
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 23 Mar 2026 06:24:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=P86yqLQX;
 spf=pass (domain: gmail.com, ip: 209.85.219.49, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-89c5340fed0so44834836d6.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 23 Mar 2026 06:24:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774272288; cv=none;
        d=google.com; s=arc-20240605;
        b=Xe5GgN1r1L/l9Xh0lxG1lUmOgo00B5MXwEhpkVY2F5E/HjiVadZ5Y06VzcBeuRmvqL
         jnv0wHkCa2U1ldykbVCviRdRDNo5X+nsXBSuCKXEud3ZHRPQQca3c/zixYS+01AyP9x6
         J+qnD2QDYeeQaeASL8GF8gB0vuOUSi4ZzVYk3hcfEV1iAAdvo6lD4+8lhQKBd+J9/NWV
         BKoty970h5Uad8ab9xglTxuq6lB4clI+Ki5kjDLzwDH0m0o4NU3k9vY3gnRppXGEj1OB
         WHQafozuJCm2vXmy6r03dGOhRktpvj6pCykB/oZcW7O3P1IiUOR/6S+LLharIHJnXzRw
         LQlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4S8zVpWyT/iznMx8AjFnD9oMgzmZ3J3kUDJe2BGjTE0=;
        fh=KqrK6tVaEERj7xKrWNGE2BgFvln1jR0o6iM3QsewVcA=;
        b=QjW++gs36sTTRBYW5yGeaTMCoTlWP5whPxoY/VP1yzrEfwooN4fORwq2OXw6a/BPRh
         wOSgP03D/yYvtgKlAZD3RiaHyjSjKJBRpWS2VuXnKtioBMjEuSHS1ciGuPDpBcJuHE45
         4bOxppIHVgig2m5tp0o0bycu70w868vglkCjXkcVuLwtdp3hpZMT25BrczsD4/UNJYeF
         9K3iUYKNC2N+8HlhQuSPVgrzGGD11J8QqVtL6m4K1khmX0fUDi9rfhT3xV0prX2pW000
         31S6Qm87jS2RFAEUE8ac5l2i/XDE+VYQkqS7mIhS+M7PHOqYKKLKiDD0ICl4fMcMx423
         d73g==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774272288; x=1774877088; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4S8zVpWyT/iznMx8AjFnD9oMgzmZ3J3kUDJe2BGjTE0=;
        b=P86yqLQXcz2quZkeXB2QoXwdBXc7kQUWvBMDwrsV7ko1EE1BGeXyvTWhPOfxu3q4iB
         dvvrMMPx1npl6hOsCZLqMJ/6x2lMCgEqqwRiplqx3eObEF4hxHT+Bha7LLHFXWt8v5pp
         kWAz4rYIUT7P2FnQ4Av9pnuH4ntx26M8KQNntI6M3G8T3BUm3XxU3eaxZS2sAB/FPn1V
         UnmxXhckNCmX6vo+ek5PIF/jOYYVRUSUyE0FQjr/J+huqsoHPBSb8iOH0udnDHMjE8bi
         7z7gH2fLXBmwpkWIuaWsx3SLSZXZwRD9hBkmMoE8aI+ugI5HTKPz5dHOqRAiTFcwP8zZ
         racw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774272288; x=1774877088;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4S8zVpWyT/iznMx8AjFnD9oMgzmZ3J3kUDJe2BGjTE0=;
        b=TVGoVNkj2iRK1F5CqxtiOtnhUShWibM2GOAXY/PpNKI1s5gbudK4DIu9q73aAyK4CU
         4KIBeWt7s4cT5KIVwMnUmx00qirgmOUXRcRytHViolBDYhIGcPszETTEGlXN1yVfd6HA
         HMKuHRyrvmJyMFNZfpFJrlEXOZCdaj9/9lhHtKZaeyxu1g9i1MaHgXpuhxymtREDkf6u
         eSo3tZo705v8PidHUTKrR6pQCX2kWBGacJ/ed2WKfFV3zP1gHi2seSmh3xgzuUeYSFRB
         /Q+g3wxbCdANR/CfPXbOopex3Fa4BH7FeHyb1rd4PUwAorbE6suOY30rqqOQaVuhBO9w
         1xIw==
X-Gm-Message-State: AOJu0YwyC8JrLhDvzLTUv5nzISDhvHSmsqaKLMAyjBmuJjdduilZyDJD
	GY5nHwhVyagDkBI4vKi2vRuX7h/VSBBApTo1/XZ2chN0a+rtTi9frYMWHojmRDyguJKL38s4Iz7
	n0BOOUjDALeeLVrcOFnZKcQupw90PpHU=
X-Gm-Gg: ATEYQzyPbf3ZEJQX0e38uZSqgmJmI/YZZltO7ou0J7tDuzbW2QXjzRchBHNxUbPuRr7
	crezDBT1t7EmXDjvCrRDK/5s+8oAtw+Z9DFoQ/AjEEaQK0ONi0Gzx85j+zeoMOnpYXUge9GXafQ
	XaJp0reRT05vQce72UElSXJvYYu7CYlnLc5CcD7oKhy6+JvRKstFVHk1Rfqzd2zZqJ24nyWjneB
	/JOLzujCsZNgxd799u2ZtkHsucWWEbr9IOy7LdKgBPmBr3vfrzi3uPQAByXwugxYdVzkeZRqICE
	jSFuTzaA6QIKV1fTMwlxpc9byUxVefMsupcRa8J0Cw==
X-Received: by 2002:a0c:f10f:0:b0:89c:867b:a9bb with SMTP id
 6a1803df08f44-89c867bb3e0mr119827076d6.18.1774272288252; Mon, 23 Mar 2026
 06:24:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260127160508.3392732-1-rob.woolley@windriver.com>
In-Reply-To: <20260127160508.3392732-1-rob.woolley@windriver.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 23 Mar 2026 14:24:37 +0100
X-Gm-Features: AQROBzA2QyPS8r_UMLNOxskotDTopXn52l_AHlFitprUhDnIrNIVNPfTk9j89z4
Message-ID: <CANNYZj8X=o=dPMAfcSC+pNytN12-d7=y7R8W5qJCO=2RL0V3Vg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2 00/10] Package bitbake-setup for PyPI
To: rob.woolley@windriver.com, Rob Woolley <rob.woolleywr@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 23 Mar 2026 13:24:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19208

Hello Rob,

can you send the latest patchset for bitbake-setup in pypi please?

Alex

On Tue, 27 Jan 2026 at 17:05, Rob Woolley via lists.openembedded.org
<rob.woolley=windriver.com@lists.openembedded.org> wrote:
>
> Thanks for the feedback from the 1st series.  I included all requested
> changes:
>    * Moved packaging files from top-level to contrib/pypi
>    * Created package-bitbake-setup.py to create a new workspace to
>      build the package and be compliant with PEP 517
>    * Changed the title of patch #4 to start with bitbake-setup:
>    * Converted setup.cfg to pyproject.toml
>    * Remove old license classifiers
>    * Made AND operator uppercase for license entry
>    * Set the minimum Python requirement to 3.9
>    * Created a custom README.md and BUILD.md for bitbake-setup
>    * Changed the URL to https://git.openembedded.org/bitbake/
>    * Added support for nox to automate the packaging including
>      linting, building, and testing
>
> There was a question about the wildcards in the includes section.
> In this context they are not used for filename globbing and instead
> denote to include any Python sub-modules as well.  See the Python
> documentation for details:
> https://setupttools.pypa.io/en/latest/userguide/package_discovery.html
>
> The bitbake-setup script is no longer being turned into a module in
> the git repository.  Instead it is being done by the script.  The
> rationale for doing this is that it:
>    * ensures the module works reliably on all platforms
>    * avoids shebang and path issues
>    * places nicely with wheels, venvs, and zipapps
>    * easier to test
>
> I did make an attempt to ensure that pyproject.toml and noxfile.py
> are compatible with older tools.  Building the wheel using the
> pyprojet.toml should be supported with pip >=19.
>
> Wheels built newer versions of pip should remain backwards
> compatible with pip when installing on older systems.
>
> Outstanding:
>    * Determine a release strategy and version scheme
>    * Document steps for publishing the module to PyPI
>
> To run the automated tests all that should be required is to
> install the python3-nox package or nox Python module.  Then run
>
> nox -s lint
> nox -s build
> nox -s tests
>
> Rob Woolley (10):
>   bitbake-setup: Add the conditional script stanza
>   bitbake-setup: Add pypi packaging
>   bitbake-setup: Remove extraneous variable from str.format()
>   bitbake-setup: Sort and format imports
>   bitbake-setup: Resolve unused loop control variables
>   bitbake-setup: Fix ambiguous variable names
>   bitbake-setup: Remove unused stdout variable
>   bitbake-setup: Replace f-string without placeholders
>   bitbake-setup: Remove unused Namespace import
>   bitbake-setup: Remove unused parser_settings_list
>
>  .gitignore                            |  1 +
>  bin/bitbake-setup                     | 76 ++++++++++-----------
>  contrib/pypi/BUILD.md                 | 57 ++++++++++++++++
>  contrib/pypi/LICENSE                  |  9 +++
>  contrib/pypi/README.md                | 42 ++++++++++++
>  contrib/pypi/noxfile.py               | 30 +++++++++
>  contrib/pypi/package-bitbake-setup.py | 93 +++++++++++++++++++++++++
>  contrib/pypi/pyproject.toml           | 97 +++++++++++++++++++++++++++
>  contrib/pypi/tests/test_install.py    | 17 +++++
>  9 files changed, 383 insertions(+), 39 deletions(-)
>  create mode 100644 contrib/pypi/BUILD.md
>  create mode 100644 contrib/pypi/LICENSE
>  create mode 100644 contrib/pypi/README.md
>  create mode 100644 contrib/pypi/noxfile.py
>  create mode 100755 contrib/pypi/package-bitbake-setup.py
>  create mode 100644 contrib/pypi/pyproject.toml
>  create mode 100644 contrib/pypi/tests/test_install.py
>
> --
> 2.49.0
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18889): https://lists.openembedded.org/g/bitbake-devel/message/18889
> Mute This Topic: https://lists.openembedded.org/mt/117490844/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

