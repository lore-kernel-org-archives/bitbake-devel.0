Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22791C64ED8
	for <webhook@archiver.kernel.org>; Fri, 24 Feb 2023 21:33:43 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web11.30926.1677274419553889079
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Feb 2023 13:33:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=XClaAEVv;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id r7so494631wrz.6
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 Feb 2023 13:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ugXRQyklcbTX8qhCgkuBrBhRFDLejPGUqHTH3SkV4E4=;
        b=XClaAEVvS/u5Uc4QJtyYMcsnoWbfHj/j64ckDIZhd1NRyinf/ZMAAzaEzTluULtUv1
         TVKW3iMVy8KmWDkDqmlI4J8+VZY8sy5rGkgsZqTKYey+u2FCIUftOCJKuZ4Mw1ULXz+K
         6cMYkBkx2SV3UFbqyTX2ceWQ3VwkurXAKuVvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ugXRQyklcbTX8qhCgkuBrBhRFDLejPGUqHTH3SkV4E4=;
        b=m+qXOcu+98s/5Zd/mcJ4vkEPgz6Bs48QQgxO7sLi0fEx3XcQ45npcJ8lFBta7Kis+T
         402lsMYnmu7tsFDQFwKLtgOt6DMPXnHpPy4vD7j9ParE3VsdFyAgaq4IPrIhwtKiBPQM
         nv+0qLhFNx3p9CJvZrgngXNKsU16psWNC4EPi/xoE6M9Bra5yv73zxVr7caPSdXMrBlL
         l9Qgus4zmqA5m0B1ZLqglRAI9SrBm3Nmhj+q6DgPHq5MPJMa4GJ+7EcZxVN37hpbMkAc
         zELJOHDcZO4jfhYzJbUGmeymLP1ipoQ8CMIF+2H+Kb/mYpgS6vjP9KdK1BSsje2vgpqw
         O58A==
X-Gm-Message-State: AO0yUKWm8T3J0nPlTVSMzrBvgjfmP+ae+aAFqd6dHHqWE9h+YEr8F6Lw
	hxUGc4mbAG22iyq2rA15IJheEg==
X-Google-Smtp-Source: AK7set+sfq0mBwu/TpHWjDlDMSTICD1/liEVR0WB7UYqm2RvaN5jum2gWYBiopFiEKGOt+AvTRKDhA==
X-Received: by 2002:a05:6000:189:b0:2c6:dbe7:1d8e with SMTP id p9-20020a056000018900b002c6dbe71d8emr13090134wrx.45.1677274417787;
        Fri, 24 Feb 2023 13:33:37 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:e7ea:a56:22dd:5e1f? ([2001:8b0:aba:5f3c:e7ea:a56:22dd:5e1f])
        by smtp.gmail.com with ESMTPSA id j24-20020a05600c1c1800b003e22508a343sm475957wms.12.2023.02.24.13.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 13:33:37 -0800 (PST)
Message-ID: <8ddacda7563bc605bae4686733d3e8bf72f0f9ed.camel@linuxfoundation.org>
Subject: Re: [docs] [PATCH] documentation: bitbake: add file-checksums to
 varflags section
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Richard Elberger <rich@richelberger.com>, 
	"bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Cc: "docs@lists.yoctoproject.org" <docs@lists.yoctoproject.org>
Date: Fri, 24 Feb 2023 21:33:35 +0000
In-Reply-To: <010001868510232c-5929cc94-ce2e-4817-b311-3ea6f58a267c-000000@email.amazonses.com>
References: <20230224201426.357606-1-rich@richelberger.com>
	 <010001868510232c-5929cc94-ce2e-4817-b311-3ea6f58a267c-000000@email.amazonses.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 Feb 2023 21:33:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14491

On Fri, 2023-02-24 at 20:14 +0000, Richard Elberger wrote:
> Fixes [YOCTO #11605] by:
>=20
> - Adding definition of file-checksums to Variable Flags section.
> - Describe data to add to list which adds external file dependencies.
> - Write example on usage to prepend a value to file-checksums list.
>=20
> Signed-off-by: Richard Elberger <rich@richelberger.com>
> ---
>  .../bitbake-user-manual-metadata.rst                  | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/d=
oc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> index deb7afad..c2f0cad2 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> @@ -1496,6 +1496,17 @@ functionality of the task:
>     directory listed is used as the current working directory for the
>     task.
> =20
> +- ``[file-checksums]``: Controls the file dependencies for a task. The
> +  baseline file list is the set of files associated with
> +  :term:`SRC_URI`. May be used to set additional dependencies on
> +  files not associated with :term:`SRC_URI`.
> +
> +  The value set to the list is a pair where the first value is the
> +  file name and the second is whether or not it physically exists on
> +  the filesystem. ::
> +
> +    do_configure[file-checksums] +=3D "${MY_DIRPATH}/my-file.txt:True"
> +

Thanks, this is good to document. We should probably add that:

"""
It is important to record any paths which the task looked at and which
didn't exist. This means that if these do exist at a later time, the
task can be rerun with the new additional files. The "exists" True or
False value after the path allows this to be handled.
"""

Cheers,

Richard


