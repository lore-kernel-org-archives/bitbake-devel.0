Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D70C44502
	for <webhook@archiver.kernel.org>; Wed, 21 Jan 2026 09:42:20 +0000 (UTC)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8248.1768988531030538234
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 21 Jan 2026 01:42:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=e8E2JPDD;
 spf=pass (domain: gmail.com, ip: 209.85.222.179, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8c6a7638f42so813312985a.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 21 Jan 2026 01:42:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768988530; cv=none;
        d=google.com; s=arc-20240605;
        b=lUznjFc1Q2lLZTR2z/C1382U/Ef+j9uYsIwrBHbpyWZwS/Kz/mwwxiyhGaI6XBfkin
         5D73VyWDN8Btpg1gUJ5fqKsBYMsJIswUiLMNaM6sK2/x+Nxmg8I7wCEvgza+A8LlsroO
         e+Ef1oKAye0q9cj12J1LZz2obGRpgd48WUTt2mURdjOBM51kaomVa0sZP6lpV8FjATPD
         ApK1EEF+UoOhqPNceeTroQ7hw6YUG6EIamF+TT4yAlo0sgKnLhmcVKub2f1WXeiYt+8e
         JVZ3fFRLGvHOVfMDDhwqprVHzxM3nSxDqL1BuHb3YL/tyOJ6z40W7kb6IkQPlKW+M8gS
         nREA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jKm+Pbbu7JjPD/8WAbCLTLULx7TERI5NN351I8KRp78=;
        fh=HCy9zDhRwPGFURRNU4/XWJVzlNpJiiYdWN9iJYKwgs0=;
        b=cSEjK9NmN9gS64GXsuzJA4ptwpwghje5QxgtE6ivBU3EG9mkAlIHeQwu2FE1BbeV+k
         3UsFRTRp9wMPOXNFr42TcDFUr7ldk+1cy7b3/qvpsJ00C9B5PyVuMqlcII8y+mEOaksF
         vo+RTMGjYqGSY1vQ+/7OWXJCBmTPHSmd2vjDpQI7V+2ddEdY/oHUjGLWYS0RWuUwMt6z
         hAsjS/EdBEME7UY7uxIJ6oidNjusCn9E9TFZ0uvndwpgHywNIGJTTeiKEvxmViKYwBmq
         rfWjhcmOoK9vZfL1OojjRWQ7lhsqqn7QEtCcmimAyG8DtxfAk+77YXsY7q1LMpam2h0S
         TEPg==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768988530; x=1769593330; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jKm+Pbbu7JjPD/8WAbCLTLULx7TERI5NN351I8KRp78=;
        b=e8E2JPDDR9u4QTFcvDNKPnAVBvpFbwHp7OTYg8Bj7n7w7fX6bX8JKnZh79fOoot9B8
         RVk0CLmhLKQVHTI12JhztdSQhL2NmDTYOqgGBKwQyUfIpj0hp+eOXjR3KVTB2NZc5mkM
         ZnIyOl8lAtA5E6jiqMRcZ+wNu1LEMldzJ9zUz0icMFNQvMLRwPK2GsPQNRyLFfoKT4qD
         sQA3RSS8C1wrGDEeWp2LHzjIWHAJh+GLb+jrSistJmF6SGQtShFDQ7LMOtvmsfwOCwDu
         GiZZs3bRH+E59F2e/RmWfJQqVlWP93OCF3YR38BuX00JvHkVaSc4QvMStbN0JTImkj9H
         tNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768988530; x=1769593330;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKm+Pbbu7JjPD/8WAbCLTLULx7TERI5NN351I8KRp78=;
        b=eUwuzeeWu13tncvCUaukFWfa9EmeK4DwlOeo4tMy/TZDFRRZPgbPeFbZ+bhM1me8VW
         pEiaX/FPAJNmdFiZs8Y/UDLwpesUt02zQkeIRidGzmIqoq0VMhkDfu6h6SX3TtZHmhX5
         X3InTVfv6Ur98pcb3abwPAIeM7k5PQRxsK/3FDkJVVjmn3xshhRbf+oxbj9W2ZXqjNCX
         UOGJNB3oyR9oaeGotyu0HAz/Rg96jXmS4ZiUPfO5zD4J/ZxZmz+SxwUpCCdctyPwZQlb
         Az5Sz+zzeDW9AMtClEE2nua9krPcps8y5NssRjDblXI/EBf2r+6cdbk5sFBXp58P4ARz
         Yw6w==
X-Gm-Message-State: AOJu0Yz+hOKKT2C1z4X0xuVFMeeD9guqDOUdHayQnDIwZNpbjjisZg6u
	nQ3rxEZHhzL2CaZeNuBXwMAn0VIUCQJNk8PX77CJJFnjbD5MRjZlNS13DRJtr8Kwrkn1OTafAWF
	9vTgJYr56HEi0Hcj3ITT9JY4qg9y6dL8VgQ==
X-Gm-Gg: AZuq6aKHpYb5swrdObIsfhN3Fnbd5Ja8PxQwnMiWHE0SH85gsWg1c+Qkk6s1+2a0gHE
	mzTocRv4NoimIHwZuaHmNEP7CtIuRuBd9aFRAPobgfYGDmM96a56aJijsDMHU5Eaz8I43u9staW
	Buw8jm6DSnJ6XLhKTi9QSCeBGIUr3WJYfANZM1nBpfwqdNnnP8nLOoWjsYHqytqHPUaVcoHOuFg
	U/zytgs7ztxs4W7GF5gBFtaCNSLj7SxFFecEiKQ4hUU3p7hzXuVGIu2MXU9gI5t7MevHr52cFUH
	UyGkFoIstpv/fBwEf/00N25+PVgppLzaU1R/Nh96
X-Received: by 2002:a05:620a:440f:b0:8b2:e284:1bd6 with SMTP id
 af79cd13be357-8c6a695f445mr2303521885a.76.1768988529900; Wed, 21 Jan 2026
 01:42:09 -0800 (PST)
MIME-Version: 1.0
References: <20260121024723.2634264-1-rob.woolley@windriver.com> <20260121024723.2634264-5-rob.woolley@windriver.com>
In-Reply-To: <20260121024723.2634264-5-rob.woolley@windriver.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 21 Jan 2026 10:41:58 +0100
X-Gm-Features: AZwV_QjBcbzjyRLVdR7CByNsMW1lXkmJ_cpm_trGVZbH73pfNUOycwoKQeTudtA
Message-ID: <CANNYZj_DjeLtLYLFNdwc=_RjagYAkdPuZznP5+QRLpc8bdE3hQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 4/5] Add Python packaging files
To: rob.woolley@windriver.com
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>, Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 21 Jan 2026 09:42:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18833

On Wed, 21 Jan 2026 at 03:47, Rob Woolley via lists.openembedded.org
<rob.woolley=windriver.com@lists.openembedded.org> wrote:
> +version = 2.16.0a1

There are other issues in setup.cfg, and the commit title should be:
'bitbake-setup: add pypi packaging', but before that I think we need
to consider the release strategy and version scheme for it, and get
RP's blessing :)

Here's what there is in terms of tags and branches, and from what I've
heard it is not easy to change:
https://git.openembedded.org/bitbake/

I guess, bitbake-setup would only be released from the master branch,
at least once when a new yocto release happens, at the point where
stable and master branches diverge. Those releases should match the
stable version, e.g. whinlatter release would have been 2.16.

Then the question I can't quite answer is, how to version something
from the master trunk? E.g. if we want to release from master right
now, what version would it have? Note that ideally it needs to contain
the short commit id, for traceability.

Alex

