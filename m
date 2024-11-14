Return-Path: <vvavrychuk@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA7FD65C49
	for <webhook@archiver.kernel.org>; Thu, 14 Nov 2024 12:28:38 +0000 (UTC)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
 by mx.groups.io with SMTP id smtpd.web10.36157.1731587310431617534
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Nov 2024 04:28:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Tfmh5bMy;
 spf=pass (domain: gmail.com, ip: 209.85.208.170, mailfrom: vvavrychuk@gmail.com)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb49510250so5297041fa.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 14 Nov 2024 04:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731587308; x=1732192108; darn=lists.openembedded.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iuqK17IqwK6ik9EuOaeJR5/l+xhLvk8wZB3XueJ5ceY=;
        b=Tfmh5bMyYk0QShfwXeTRsGAQ9wWqkO9vSqxVI4jUv2cbBd37MVnks7d8byosUn17DD
         Y4lVwssosb7hNJwQqOja5049zl47g3XKiKYelXrqofR1yapH/UbTbaDv/8P0SHjgFg5n
         PBjsX7/wW9lLf8FNROxY7Wzz7Y6HrK6U2HtxUs1LLC9JbNx7R+hrP+dl4rJ57aHNZTES
         oVpo+841rZEoLUkwbmz0RDKzLJvstE66WfbHku+nWxoif4AmocBb2VvO512gEcU28mCT
         XMy3WdWrYSA0IE42KO+5iqCz1kNMbi1CwMbeUHhGczitU+pl3S3HkjZ7/oMvQSZD1jGr
         JPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731587308; x=1732192108;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iuqK17IqwK6ik9EuOaeJR5/l+xhLvk8wZB3XueJ5ceY=;
        b=B6oif0Ok/SLEUwMEdPfaqze+G+7ieHiyzeSuk/eM74E2aEO0NgiFlirMmQ+EdaDwdB
         kdG9dbxhC053a/D2/RnxZMH02wp5oXCasHbxcR20XWNz73gfVl7Bb0oaLwMZyJ60LM1p
         GsROHifWM2tr5MxA3U+7XJALhK5hbxBcdtzvU+svKq1mzi/BgRHgcGvVvEqEa+Vmqc5u
         TdbDJhb/Qm4HJ+9n4f8cDSdjll8RhHD61BojKQP3LhM/a4d0P4JVOiN/MkvcHRtyLKNC
         NIlKupFeu3IPDRKoMeyh11Bb54mGvPFGsEpZCJtWLyBtmZCUpG4Iv1TZY2J0pT64V6k4
         WF1g==
X-Gm-Message-State: AOJu0YxbZ+/0u7jiRLFoVVGsUcwim8pdSgGOCJBlTPd/uNVcJxCmx+Oe
	XsTaHGP/CnQynWMtw1o51vLmK966U37qs7EdtiUl4VabtJ3STVaB0MG1NYx1s578CZ1njmYfAiA
	Q9T0vn6ubItvcdsJReBTBfw9Khi7ha2st6lE=
X-Google-Smtp-Source: AGHT+IHK0prtouCIaq/fjZwSp1dZqw6WyGwahFpZJgg2q+mOBsgKY033CHlasi7voyfAOdOhP0VR9UhIpnx8qBCObrM=
X-Received: by 2002:a05:651c:1146:b0:2ff:183d:df1d with SMTP id
 38308e7fff4ca-2ff4c6184a1mr36669691fa.27.1731587308077; Thu, 14 Nov 2024
 04:28:28 -0800 (PST)
MIME-Version: 1.0
From: Vasyl Vavrychuk <vvavrychuk@gmail.com>
Date: Thu, 14 Nov 2024 14:28:16 +0200
Message-ID: <CAGj4m+72ZBL6rtaGRQq13X-JJg5Okp0NTYhASOr2-zPG5zVVHQ@mail.gmail.com>
Subject: using non-existing variable in inline Python variable expansion
 results in parsing changed
To: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 14 Nov 2024 12:28:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16800

BitBake code

----
def python_function(value, other_value):
    return value

DEPENDS = "${@python_function("${NOT_EXISTING}", "")}"
----

produces errors

----
$ bitbake --dry-run example
Loading cache: 100% |#| Time: 0:00:00
Loaded 1868 entries from dependency cache.
NOTE: Resolving any missing task queue dependencies
ERROR: Nothing PROVIDES '${@python_function("${NOT_EXISTING}",' (but
.../example_0.1.bb DEPENDS on or otherwise requires it)
ERROR: Required build target 'example' has no buildable providers.
Missing or unbuildable dependency chain was: ['example',
'${@python_function("${NOT_EXISTING}",']

Summary: There were 2 ERROR messages, returning a non-zero exit code.
$ bitbake --dry-run example
Loading cache: 100% |#| Time: 0:00:00
Loaded 1868 entries from dependency cache.
NOTE: Resolving any missing task queue dependencies
ERROR: Nothing PROVIDES '"")}' (but .../example_0.1.bb DEPENDS on or
otherwise requires it)
ERROR: Required build target 'example' has no buildable providers.
Missing or unbuildable dependency chain was: ['example', '"")}']

Summary: There were 2 ERROR messages, returning a non-zero exit code.
----

Looks like when using an undefined variable in inline Python variable
expansion, then inline Python variable expansion is not parsed. Can we
avoid this? Can we have more user-friendly errors?

