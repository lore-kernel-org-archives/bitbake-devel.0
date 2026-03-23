Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E907F46101
	for <webhook@archiver.kernel.org>; Mon, 23 Mar 2026 13:24:05 +0000 (UTC)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17424.1774272236724246602
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 23 Mar 2026 06:23:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=SmwIjj2Z;
 spf=pass (domain: gmail.com, ip: 209.85.222.181, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8cfdac74050so214393685a.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 23 Mar 2026 06:23:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774272236; cv=none;
        d=google.com; s=arc-20240605;
        b=j3q7AOpGE5UoWiLlnL5/BG1rwAh1pwRSK1hfn3GIJTPkUxCM2eF5l/pFujkFM+O7Hw
         Zg5RIJM9Ydbmkmvfos2NVdquLR3AnjXrLaRy9YY9p7tVmmewaTmhJ2eMzA97J0KjBU4Y
         CAHRQhu9VKZ1/ZolOUmMwYqEQayFQScrivN7vT0AJ5gN7Qa/pSPJk2qQN4KmwWoMuhdA
         VGtIawUm0QyauAZ4K7XQ5YFAGeiMQIwV8uQn6AUnMSe+aMU3/VNNGFzB4le6GSzsIBgD
         MAgxoVNBS53GRZrGH6iRGuvgRH59GU2uXaB+ht3hVdygZ+ywqPF/ZxQ3a1GhrtchLKnk
         9qmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4S8zVpWyT/iznMx8AjFnD9oMgzmZ3J3kUDJe2BGjTE0=;
        fh=OW3Dv9aSaONdxqFEg+gHG7ItOEhRMtXzTVqh/JdGy3c=;
        b=jb7OzWbAa/wCBf+Zn60F7Du9cVozTzCPXizBw+Yt62m+dd7V5RhVAcLwh4n5QZfDfs
         vuNZe+gaW/DRhds6L9Ljp8kRz8evSLKu747ia11FGK0U/BbukfwruMhdDqD9TaexSEHV
         0UsuRGfa8/14Q8TBmU1nvUm9LaL7OqBy8KR9mUiMrHHINDEDt1BURZXAvfrTZqToLTSz
         wv46+b5N3d9SlTMTFIdyYOBxmGKvio1ksw5Hvr58cVLcRL4rNYmrDjgCiFZ3yV3MWune
         KvHS6R2PYMPTfOzdn/qrgUgC4pYRgNPD15aF+2yzp/Q39ZY3KS9ZaLsKjrGg62QbspWM
         Y41A==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774272236; x=1774877036; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4S8zVpWyT/iznMx8AjFnD9oMgzmZ3J3kUDJe2BGjTE0=;
        b=SmwIjj2Z9mjxFTulpjuRwTDCnLcz6EIfEjIytXNqeJgg2hw8G8DyaBkPzBnFhA6rGl
         UHIf/gI2y+l7usBndajaidh/d2VzhgpARFpaLg+bFLYj372OhoxE6TDk55JTZE4HfiPX
         OxvO3R5wHKKM0l6qRTbBu8CXPmZyB4rOT4o834XedhD62S5wCQ1neUDT957vpGMYpVsa
         c72y0tS1uPFGQLP90HAYDDlGbFx4yiYFJKqCSlLolNBCdUwgsO73AjNY+cx/Z79yhbhJ
         CNZrROOHFhXoT8DuoXAdb0ZN1CA2srZjhzyMowP+yXQJRMH1JomAwNOC0DcumCDUFBGO
         mK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774272236; x=1774877036;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4S8zVpWyT/iznMx8AjFnD9oMgzmZ3J3kUDJe2BGjTE0=;
        b=NMJfkqsHn52ZXe6m7ppqxxQg9IK2DXDz7GS4xjqPy+NGOb9sXTw/Hphv5M4MjsongG
         AoWskioiOjMjtEWbyv4cnW0mEo/GsTdcCvjxn1htbJgyCXdAdKKev90s/eARkCiP7aPO
         MZZ+MF1LWFfXtq+l48/ewTrh8xgflPBhEbGTB67jhq+Zokk8AvcOdZN/WcwR3qEWvUj2
         GiZjCmlj5cW2pOeLDCrEwCwLfr81OUvAQU/sMefmGDdRbK1O+ADLZybxJ3WiwaPzN6JG
         USYGVIHLGwnQxG5hIEsXufJH8UEnyNtBpkeVv6c5BzaBDiHpmhtEqOfxwcTg788oVAX1
         qTXQ==
X-Gm-Message-State: AOJu0YzjmFGpQg3vE6ipXJLe7uQdIxtif1DfRjIcfo1xsAxwklnHpmAc
	kTI0eIMwJBoWeXIEd/QXPAqVnI+WTy7Cf1xiFs3RVZAxRbPjB/w9HCRxHlU/Hst/nY6H9sfVU0H
	fIWB3K5uoY5tp5/PmDPuObd6aIDhF270WGQ==
X-Gm-Gg: ATEYQzxE6YV+Lp38T+cCb5/KgsqASNDdNJ7nldnuNgbyfkOAe0wLkJztiO5HLqkA3TX
	JVaqLdN2jz/dnSnhRRDGnms5kAbpCkuHb/RmAaPyDx/Ic8DWJZUSuK+oLIhD41xFQvcjz0C3sbX
	yM8VPYwCAhL/FXBD9GKMBWCM66//spU+W3JM/5twez86nWbhenZhqsx75PfCgSClT4W5DHtVxFg
	Pbh/wO53dlBJwfdHBPyXR5+QVkZwduiaHjtNHtQMFGz/48zzio9Hr6vn1BagveFvYwJ9rJ9/+y7
	6CzzF3x6imRmnkfhCkquTZXEBx5xkHlLAo/i8KMIcdHEL5I18Bi2
X-Received: by 2002:a05:622a:1b8c:b0:50b:4001:ae12 with SMTP id
 d75a77b69052e-50b4001b068mr154836231cf.46.1774272235674; Mon, 23 Mar 2026
 06:23:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260127160508.3392732-1-rob.woolley@windriver.com>
In-Reply-To: <20260127160508.3392732-1-rob.woolley@windriver.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 23 Mar 2026 14:23:44 +0100
X-Gm-Features: AQROBzA3un-MUk5QkTzQJmggFk7Q3StPcE53Lror2zeWJuUuqllqPCDGmP-X2Zc
Message-ID: <CANNYZj8RmDhcAaJEjrWyu+2OzA_HYgtk5idPLSLwXR8ggJp9VQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2 00/10] Package bitbake-setup for PyPI
To: rob.woolley@windriver.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 23 Mar 2026 13:24:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19207

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

