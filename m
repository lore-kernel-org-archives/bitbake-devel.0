Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6B3C7618E
	for <webhook@archiver.kernel.org>; Mon, 24 Apr 2023 09:15:50 +0000 (UTC)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
 by mx.groups.io with SMTP id smtpd.web11.46476.1682327748917890538
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Apr 2023 02:15:49 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@linaro.org header.s=google header.b=i73SoBxs;
 spf=pass (domain: linaro.org, ip: 209.85.208.179, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2a8dd1489b0so39327871fa.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 24 Apr 2023 02:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682327747; x=1684919747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VzbTH1t72ZW3yIadVqgmr7EZVdH1xRN6ikDYGFRC6ew=;
        b=i73SoBxsupt3KQvY02STtuzzcnokitj5ZmsthKIwgZeFvtJX6APWEb4uHgQI2wI90i
         EPtdYUGsjCxWgQeU9wSNLtzGwzqoP2bbN9YFzTNDL2u1ct10P/RMad+Jx6R/5twIVfvI
         QV/Fo+yH0wLPt+ggTdPPIugrK+TdCGkp1vhN3lUxfAUEkuzKEjmWyqkYzfjGbp7vLy0u
         6mlBxNU/xx5Ycwbj/8Kfb/OqXSt/ChXrs/gNs80V0B/MHvOo66CK1A2bS5BtlcQMvCN4
         v1wJwYJy59E3S6acZ146f8BtEOATPtx1QTdDZLdGmby7h4Vcbi1eaCUj6MmZ1MU08Hvv
         aTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682327747; x=1684919747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzbTH1t72ZW3yIadVqgmr7EZVdH1xRN6ikDYGFRC6ew=;
        b=Hd/Elp2KxUDYizm6zKN4+Nm/p65Dl6BwnASmZbLkinn46wlNzc0ZM/e5DzG+UluhiE
         eCiWH/ZKpFdJQFbpqyhtztU/ZyJepqv+3zTGbaX9ckF9qZ5QauZEoR2Pq2o+EqQVCzSd
         MXWbf43OgcABHZ6DNQjA+jpOlO3kCrDBidDOXzvHp8CI4NbxcW6XEZvb6vQn1Zcg4eWM
         oGZuYbQgebci5lHneUzkQLJC2WEf4+IYeRnpEMAk+ycPI90Ozjy1RWqkJToeKqdvujzM
         JCx/m1GqlL7VNY2Nj1d0EHW4g1OfgvKa039PGOH2t+CSEPXgKxBgmFbmA0BGkjOzvU46
         G5vQ==
X-Gm-Message-State: AAQBX9f6mUNQo7Mf9MVoOkQVXj7Uy0Gvm6T85fbXwt87i/ZQ8wpHN/yA
	T5HvUjWw4FyP/EsjfrrjVszadw==
X-Google-Smtp-Source: AKy350Z9SXEmv0iFCHUldhWYwnOkZkwUtPEW/l+fIrfsOlN22CnYmzP2n+N2ogzOHfTmy3i170IptQ==
X-Received: by 2002:a2e:7e03:0:b0:2a7:a3b4:7747 with SMTP id z3-20020a2e7e03000000b002a7a3b47747mr2274579ljc.29.1682327747124;
        Mon, 24 Apr 2023 02:15:47 -0700 (PDT)
Received: from nuoska (dsl-olubng11-54f814-94.dhcp.inet.fi. [84.248.20.94])
        by smtp.gmail.com with ESMTPSA id l26-20020a2e3e1a000000b002a8c7bd0798sm1681945lja.86.2023.04.24.02.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 02:15:46 -0700 (PDT)
Date: Mon, 24 Apr 2023 12:15:44 +0300
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: Alberto Pianon <alberto@pianon.eu>
Cc: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org, jpewhacker@gmail.com,
	carlo@piana.eu, luca.ceresoli@bootlin.com,
	peter.kjellerstedt@axis.com
Subject: Re: [bitbake-devel] [PATCH v3 1/3] fetch2: Add support for upstream
 source tracing
Message-ID: <ZEZIwF3cCgdkOuG2@nuoska>
References: <20230423060143.63665-1-alberto@pianon.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230423060143.63665-1-alberto@pianon.eu>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 24 Apr 2023 09:15:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14744

Hi,

On Sun, Apr 23, 2023 at 08:01:42AM +0200, Alberto Pianon wrote:
> From: Alberto Pianon <alberto@pianon.eu>
> 
> License compliance, SBoM generation and CVE checking require to be able
> to trace each source file back to its corresponding upstream source. The
> current implementation of bb.fetch2 makes it difficult, especially when
> multiple upstream sources are combined together.

No comment to the patch itself, which seems to create a way to capture
checksums of recipe source files which can be mapped to SRC_URI entries.
Would be nice to have this as an optional feature though, unless the
performance impact on builds is close to zero. Measurements?

But I see no connection toe CVE checking? The problem I have is that
I've seen SPDX and SBOM things sold as solutions to CVE checking while
in reality they have done nothing. Yocto has cve-check.bbclass which
uses PN/CVE_PRODUCT and PV/CVE_VERSION to query data from CVE database
and to generate reports about affected, patched and unpatched CVEs,
which then also include info from patch files (CVE number, if any)
and list of ignored CVEs from recipe metadata.

Even if SRC_URI can be split to individual entries, and each file in
soure tree can be mapped to exact SRC_URI entry, then what's the link
to CVEs?

CVEs don't map to SRC_URI entries even if they in theory could. CVEs
don't map the exact source file checksums. Multiple versions of a source
file can be mapped to be affected by a CVE they contain the same bug,
which is usually encoded in CVEs as SW component name and upstream
release version range. The SRC_URI entry SW component name and version are not
added in this patch, and the CVE metadata about ignored and patched CVEs
are not exported, so I don't see any links to CVEs.

Cheers,

-Mikko

