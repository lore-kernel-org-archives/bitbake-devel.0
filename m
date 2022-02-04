Return-Path: <jdmason@kudzu.us>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3663AC433FE
	for <webhook@archiver.kernel.org>; Fri,  4 Feb 2022 02:31:18 +0000 (UTC)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 by mx.groups.io with SMTP id smtpd.web08.4460.1643941877269953481
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 03 Feb 2022 18:31:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kudzu-us.20210112.gappssmtp.com header.s=20210112
 header.b=aglW31J2;
 spf=none, err=permanent DNS error (domain: kudzu.us, ip: 209.85.160.175,
 mailfrom: jdmason@kudzu.us)
Received: by mail-qt1-f175.google.com with SMTP id y8so4610763qtn.8
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 03 Feb 2022 18:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=zNoB18OOKovCHPCNE772E4SbEYe1hwvmGZ05K2QPrsk=;
        b=aglW31J2MYExZbN6xkEigGGOKofxp6+XKEJPEbpwyfDunAGB3DOt8FXWRD+HH2yLZ8
         fTlG//28w5nb//KN+Rtjn9zwnbuoPu/OVPm6NmsXQKi6diIUVv7PZyIQBgB+ul1JA/l1
         6iE0avTTOBOtnhWpTKTSPNbXWuB5q7KeVgxwzwpq4G3PmZgb3uN8SyxkIWrbdQ3rg5Tt
         ZOCNwMHXoGFDoQxlLweS4J8QOJQh3ZHpKAA/03Lqbhvka4zUj5YqmtOqGYmodgdXzK4T
         Y6nqEKq1+vWtRlaGEObLuWu0lXnGS7n9JtJ7aX6X90vPrG9DesCTbrK0nKWaFVJfClMJ
         mfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=zNoB18OOKovCHPCNE772E4SbEYe1hwvmGZ05K2QPrsk=;
        b=OoyEceWjrWp8VY7WmIF6tr72FvQDFvL0JZjhGuRPjAiJypx3zZDDp5wLFaX/cHQ8Na
         xS8F9od8WzBrERri4Eu0yXj9u6JxAPoeyifxfcl56EuVLhLKLHHMEvXyMJUCFaefO20Z
         JIAXkCLBnropMAch8eFK6XsFkdGjk98ezLHfp1K8XmxwN/jJdxwM3XYSSh96j5Gg4Yze
         CA/Itg7nF1fJtZU7S7MrWACom+MfHMaJhCME8ImQcAvOSCOTyZipOB9MkPsyKerTu7t4
         y65SJ5XkW5ZgRr1N/6+GrWbXvrOcwAFsmNJkXKjYCZg4+xN4LDBb9QvJTY7dsIF+zHi0
         PMWQ==
X-Gm-Message-State: AOAM531MzCBKkxVtLm6CjwAdft/VbdhKg7EJVRdaxmmELOv9G0s8DFxU
	QFPvDB361GR6TtdD8FRw4oDw8d63iqIRleySnpTaBg==
X-Google-Smtp-Source: 
 ABdhPJzvb/lZ6h0nKOVIFQt3DHx4fVJ9uGWWcRHWcLfm2PpLYVTlXYkmkuUdcrBuzadjOe/dWNrx0eERWjG3juVrmzc=
X-Received: by 2002:a05:622a:4f:: with SMTP id
 y15mr687627qtw.661.1643941876319;
 Thu, 03 Feb 2022 18:31:16 -0800 (PST)
MIME-Version: 1.0
From: Jon Mason <jdmason@kudzu.us>
Date: Thu, 3 Feb 2022 21:31:08 -0500
Message-ID: 
 <CAPoiz9xdMynAdLjHMoG76kiny4CUbvj6n7DxHR6HYecuLxcVwg@mail.gmail.com>
Subject: Inclusive Language Proposal for YP/OE folllow-up
To: yocto@lists.yoctoproject.org,
	Patches and discussions about the oe-core layer
 <openembedded-core@lists.openembedded.org>,
	OpenEmbedded Devel List <openembedded-devel@lists.openembedded.org>,
	openembedded-architecture <openembedded-architecture@lists.openembedded.org>,
	bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 04 Feb 2022 02:31:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13311

This is a follow up to the Inclusive Language email I sent out on
January 24 (see
https://lore.kernel.org/yocto/CAPoiz9wL16OTzxNHdw_5-L72GOHkhhM0--WZF7An071cx6sr_A@mail.gmail.com/).
I'm adding a couple of additional mailing lists to this email that
were not on the original distribution, in case there are developers
for those areas which didn't see the original email.

I really appreciate the positive feedback received on this.  I've
updated the wiki with the suggested changes by Ross (acked by Randy)
and Mikko, and extrapolated that to be the following list:

CVE_CHECK_PN_WHITELIST ->
CVE_CHECK_SKIPRECIPE ->
CVE_CHECK_SKIP_RECIPE

CVE_CHECK_WHITELIST ->
CVE_CHECK_IGNORECVE ->
CVE_CHECK_IGNORE

INHERIT_BLACKLIST ->
INHERIT_RECIPESKIP ->
INHERIT_RECIPE_SKIP

SDK_LOCAL_CONF_BLACKLIST ->
ESDK_LOCALCONF_REMOVE ->
ESDK_LOCAL_CONF_REMOVE

If anyone wants to nack the changes above, please let me know (or
modify https://wiki.yoctoproject.org/wiki/Inclusive_language).
Similarly, I've added all of the proposed names to the "approved name"
column.

On the same wiki, I've changed the tables to now have a volunteer
developer column (from the "Assigned Developer" name) to make it more
clear that we need help in doing these tasks.  If there is anything
you are interested in, please feel free to put your name down there
and have at it.

Thanks,
Jon

