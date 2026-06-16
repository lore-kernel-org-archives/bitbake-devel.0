Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10148CD98DA
	for <webhook@archiver.kernel.org>; Tue, 16 Jun 2026 12:28:08 +0000 (UTC)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.153258.1781612886588764768
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Jun 2026 05:28:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=PEUhFsHe;
 spf=pass (domain: gmail.com, ip: 209.85.219.50, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8cc0ef7c306so40510056d6.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2026 05:28:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781612885; cv=none;
        d=google.com; s=arc-20240605;
        b=b/eocI4qGB5NDabGyVGka6XvPmdEuWw2oRafMdKkpU0aeJBihtD8aT6XROGIh7dXM6
         17/9gZW7lohqQ/S3Cpt93W4Jo4p1Ww5AlKqtNZy+4MrEeLrd2iYhyH++hKjG9MwsNOhp
         vjsGd1Su2My7P3hvqIkdM4Fc2jsHdChfWtVAFhGFL0OZZsadKG2SW7B13dj+JLrO8xxR
         4ql563tuNpi8QJ7Eb+OC9CmR0Ff5i1XpWsORgwAT1xZ3hm/aMJi3ZLfdAOW3tEUfFfuQ
         qBe97ou2kvGv2V7967nErUgrd5dJ2+hVQUGoE7aQOlXLI35DlnVgk2MqXuMxVDcUH+Dm
         s4fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=L9PzTMezZntl8XQbD+Tqq/sOFgsXXmPs51yGPJCNxl0=;
        fh=AvfLsEmkbPpgcCGbXYUZb2LN5IXnxq5aw7xiXcsvl7Q=;
        b=cjc/akUPL0HDvR1vLbxXB8mBaeg25Pno/epY+qnC0e+MTt2JZN0lX8ben3LXbgz28W
         6E0wG03G4y7SlNm7Z+Smr9bGvv0zBnx0sdkF/I9IZOV6YfK06A4rq1FKzpTOsvtu2Tyk
         CZ0oQU7WKZt5CS5CZBG/qNHOLQwKNMQ7zIbdt++N65SmwYtczEOe+VE08ujMsAUKXXFi
         xlZvwpJ97A9VxnbsjxxYwRF70cjV64NEm4Y0bblU+6buSTmWnu9M67ClHvh5lkYeHFDS
         OUKwoKkktF/dpY9KCxrIwXpUCf5JmPYdyrlLPOk39TB0FLnCYGA7vRb79aTHQHuuJjRn
         ECjQ==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781612885; x=1782217685; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L9PzTMezZntl8XQbD+Tqq/sOFgsXXmPs51yGPJCNxl0=;
        b=PEUhFsHeUxd/ftUFBj9DRw6y0lJ0iWZbSxdG95SoLb95MgegNx+gdYmZZEqBR0KAG5
         FU4YtbxZbvP5zmdXYhwFZaJyQwDcMhntaGW0vxv2RZBeWUKAAzIc8WwGBjQeQEl4Ekl/
         N9t8E7cpwVx4AJAeC5BNGMyRurM5i8sLxgBmi7K9r+KNpMpq+eKF9SpcWneASwNOhUQw
         8mifY+jsZoRDlXOBJZClVjUjwceeCoDNMPM72cF5S1YRTymnxyrA/DiZchUvO7pct+2+
         WhMJmEnLsy2IGj5rDVRG9UwBaxHn6Kz//cn1Gy9QWpygCqkbOSVbXxLUeAiuHrmlaPd4
         Qp1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781612885; x=1782217685;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9PzTMezZntl8XQbD+Tqq/sOFgsXXmPs51yGPJCNxl0=;
        b=FWBgtcFRmHFflnVIuSqYQl8VnI8j7kM5ntlOh9uHMzo1a6P0e9eSViIG0KklzAKAiq
         jpI+PWrrH+Jl4mpP1OnhvOfQM5PC5K8fi8zj66ILoCR0t/vZ3nnOehjfiJf8QoGANr5H
         B3eDp4awjtRWLhu7KD7btjX1ndsn2DBe9ie3Ejc5tuvZkqDis/udM395gPH4QRYUdtgu
         IBolUolwwplH98e+0epVPAFfpGY0gOu5J0xZNZSwzkJ/Qb4wcjU0JgsXUCZGj0vo3knM
         loqkeDrhRv68Yp3xI5b23rpiY2F2ODwgSBBJFWgHMklKcIL9rP3W4qxBsxmgDlOQ2jFa
         t8PQ==
X-Gm-Message-State: AOJu0Yx+4KjIuaKv4NK6yRrab9r98mhPCUp39TW/T27e8g1Qs1g+PY9b
	RNo/EAsSz8/fK7ldLzddOMc6QPhoseLke5de1/dw6IN9QGHOF4agI7Ggubv0ufoJ2KfazsQPZSW
	2p9rn+/zaYsapfs+B5mioD3byTOkwwQs=
X-Gm-Gg: Acq92OEnzqQNH6P8tCREuOwkshaHbstH//3Fii+5j8f7jkJEJ++zHJU7NnlV4kl4MaN
	q5T5Rm2vxoKwTHGbEDyrtaslEm0hKlejgfu7ppWX69QnQ/ObIsOLE7XUHWJXHTna8XosAbIFkGD
	WegP0dZVGkCPp9MChevswlGjm6xJTfzdaLnHK/ixY84uEY3sxZoZhio4WhypCyAOdPYr8U2W3hG
	7n8N2WJdtfQKk6zc0koQfau/5leUJrvGpxMEkZPmw7qvmPIyUC/RNDD91Euzf5z7d3p2JlddS+p
	D5c1F01QZc2R1bt0GspwAasdnpKMzD1jZXo15ZC+31h0gwxBhle9
X-Received: by 2002:a05:6214:2b9d:b0:8d0:3fd3:8dbe with SMTP id
 6a1803df08f44-8da1d6ff8c2mr56455586d6.9.1781612885309; Tue, 16 Jun 2026
 05:28:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260616-bb-setup-source-choices-integrated-tests-v1-1-a1e51bdeead5@toradex.com>
In-Reply-To: <20260616-bb-setup-source-choices-integrated-tests-v1-1-a1e51bdeead5@toradex.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 16 Jun 2026 14:27:54 +0200
X-Gm-Features: AVVi8CfwjrQNKzdC53xXo0cQGUqI2tlQW_3Gjk7eW-4YjhI5SxULswXuQoSIPsY
Message-ID: <CANNYZj-qyMbJGxgvKDkNDE1tq5aU-gdk=sG3NPh=EHivLy-+3w@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH RFC] bitbake-setup: add source choices
To: ernestvanhoecke@gmail.com
Cc: bitbake-devel@lists.openembedded.org, 
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2026 12:28:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19704

On Tue, 16 Jun 2026 at 13:05, Ernest Van Hoecke via
lists.openembedded.org
<ernestvanhoecke=gmail.com@lists.openembedded.org> wrote:
> In this proposal, I instead added an optional "source-selection"
> property to the configurations node. This would behave as follows:
>   * If the selected config has no "source-selection": use top-level
>     "sources"
>   * If the selected config has "source-selection", but no top-level
>     "source-choices" is present: error out
>   * If the selected config has "source-selection" and "source-choices"
>     is present:
>     - When "source-selection" is a string or 1-element array, choice is
>       made automatically
>     - When "source-selection" is an array with multiple entries, user
>       has to make a choice out of the given options

Thanks for pushing this forward!

Keep in mind that I'd like to support 'folding' existing registry
configurations with this into just two files (oe, poky), so any
proposal should include a rework of them that showcases the feature
(e.g. add new json files, but don't touch existing ones).

Allowing both 'sources' and 'source-choices' complicates the logic and
understanding of it. The relation between 'sources' and
'source-choices' when both are present is not obvious. The use case of
choosing from all available options when there's no explicit
'source-selection' is not supported, it just falls back to 'sources'.

So I'm leaning towards making "sources" and "source-choices" mutually
exclusive, you can have one, or the other, but not both. This makes
the logic much simpler: if you have 'sources', then that is always
selected because there is nothing else. If you have 'source-choices',
then the user needs to select from available options (subject to
possible filters), unless there is only one choice, which is then
auto-selected. Making a choice works same way as for configurations:
either an identifier on the command line, or interactive selection.
Each choice should have its own expiration date, because each choice
can be a yocto release.

There's also the question of the order in which the user should be
making selections: what is more natural, sources first, configurations
second, or the opposite? Typically one selects a yocto release (or tip
of master) first, and a particular configuration in that release next,
but this RFC forces the opposite order. I think we should keep the
order.

To keep things manageable, I would suggest that this is split into
several commits, so the parts that are not controversial can be merged
quicker, and the parts that are can be refined and adjusted.
Specifically, can you first add the mutliple source choices support
that can be used with any configuration, and then add 'source-choices'
filter in a separate commit? So that how we do filters can be
discussed separately.

Thanks,
Alex

