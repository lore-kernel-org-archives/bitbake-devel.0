Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD45C77B61
	for <webhook@archiver.kernel.org>; Mon, 24 Apr 2023 11:39:11 +0000 (UTC)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
 by mx.groups.io with SMTP id smtpd.web11.48346.1682336342274655265
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Apr 2023 04:39:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@linaro.org header.s=google header.b=whr2YGgv;
 spf=pass (domain: linaro.org, ip: 209.85.167.46, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-4edcdfa8638so4592879e87.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 24 Apr 2023 04:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682336340; x=1684928340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SKZSUUqEMqdU/nDE3Ddp3ENCUC+9ubIBnmi2RU2RRkA=;
        b=whr2YGgvz+6FT5HQEYAw5zP83e/54T9jGz747Sb50FEfINqK42vpiXfE0nUs6IKAQO
         pN6W6Ag9rkaH8Ds00ZwciiPRwQNqDVEDWyiwDzxaKvpfysyznDv8U7cxm7mRupo5vUlM
         7Cm4tyO8DGPNV6VkvZ62fler0ky14qcMxVF4QMYaxTnifG81tQqKrj1HKsJDalwGk9Cv
         OCghqLA+QpJINN8aOA0Q7Zx3YWxz6c8vyM6RC5BK8Uf0YfKpdMBTWqCpA6AT3sGZ5ZxN
         N5aCqzaaziK38L3Mqmid4rFP0X4Bl3XFM61Fvx6zeS/RYzmAraJfbo8XcNPP0X1JjZGW
         eIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682336340; x=1684928340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKZSUUqEMqdU/nDE3Ddp3ENCUC+9ubIBnmi2RU2RRkA=;
        b=VEY903kTlpcmk4P/dY8mZSXiwQk330XtizsOC+0B1jb0dlL0SbkqDm5dozIuhPCfzM
         uoMEwyy+rdrsFEM1MvO4/sW5/FBMgonAzNqzfG6BihGcoGIk+PCwYp2wjso3MuurbhrU
         qBnJZc8lwUMTClTfp120qqXMxrsH8hLg5WiX18fUWYR5NlblIP4ha94ze/+P/vFTI81T
         ddfnK7iac92tw6eaTn8vuqecJsDCFYUT6qUHpZyOqgo8fNd1Eqf3uKONknR6q0ZDOv5X
         qjDOSxFs6ZENpBnb2OxdaWpJ4mQnYmUHm4Hz5HzbEHxZ57KqsrApHzr+2pgTj83Wzj9A
         Qy1Q==
X-Gm-Message-State: AAQBX9ffEzeSeNAhveipjDBQTOGGZ4rWY/XmQOXyA+h6eQbqeh7GcCUD
	3OmBbaq+G2VQ1WWVJlJ9tOLE/A==
X-Google-Smtp-Source: AKy350Z9KAF9pCXcW42j0i6KyypopTqr8vysRYHN0DlWwSurAbWRLP3hVeGGH5QArckos7CNzTUDvQ==
X-Received: by 2002:a05:6512:102a:b0:4e8:a0a3:e242 with SMTP id r10-20020a056512102a00b004e8a0a3e242mr3166548lfr.7.1682336340159;
        Mon, 24 Apr 2023 04:39:00 -0700 (PDT)
Received: from nuoska (dsl-olubng11-54f814-94.dhcp.inet.fi. [84.248.20.94])
        by smtp.gmail.com with ESMTPSA id q14-20020ac25a0e000000b004eff530efe7sm147283lfn.93.2023.04.24.04.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 04:38:59 -0700 (PDT)
Date: Mon, 24 Apr 2023 14:38:57 +0300
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: Alberto Pianon <alberto@pianon.eu>
Cc: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org, jpewhacker@gmail.com,
	carlo@piana.eu, luca.ceresoli@bootlin.com,
	peter.kjellerstedt@axis.com
Subject: Re: [bitbake-devel] [PATCH v3 1/3] fetch2: Add support for upstream
 source tracing
Message-ID: <ZEZqUcsc8smwt6DE@nuoska>
References: <20230423060143.63665-1-alberto@pianon.eu>
 <ZEZIwF3cCgdkOuG2@nuoska>
 <f298a6d0a5f2700cd2c534531c760525@pianon.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f298a6d0a5f2700cd2c534531c760525@pianon.eu>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 24 Apr 2023 11:39:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14746

Hi,

On Mon, Apr 24, 2023 at 12:41:45PM +0200, Alberto Pianon wrote:
> Hi Mikko,
> 
> thanks for your feedback.
> 
> On 2023-04-24 11:15 Mikko Rapeli wrote:
> > Hi,
> > 
> > On Sun, Apr 23, 2023 at 08:01:42AM +0200, Alberto Pianon wrote:
> > > From: Alberto Pianon <alberto@pianon.eu>
> > > 
> > > License compliance, SBoM generation and CVE checking require to be
> > > able
> > > to trace each source file back to its corresponding upstream source.
> > > The
> > > current implementation of bb.fetch2 makes it difficult, especially
> > > when
> > > multiple upstream sources are combined together.
> > 
> > No comment to the patch itself, which seems to create a way to capture
> > checksums of recipe source files which can be mapped to SRC_URI entries.
> 
> Not only to SRC_URI entries but to actual upstream download locations,
> especially for file:// SRC_URIs (which are local, but they usually have
> an upstream source such as a git repo) and for npmsw:// and gitsm://
> SRC_URIs (a single SRC_URI may map to multiple download locations).
> 
> To grasp a better idea of the final result, you may have a look at
> (compressed) test data in the last patch, and at the corresponding
> test cases in TraceUnpackIntegrationTest:
> 
> http://cgit.openembedded.org/bitbake-contrib/commit/?h=alpianon/srctrace2

I checked this. In the past I had exported similar information into
buildhistory, though did not expand the SRC_URI entries. But post
processing the data in buildhistory was handy for a few extra checks,
like making sure all SW components/recipes have a valid CVE_PRODUCT.
Richard rejected this approach though.

> > Would be nice to have this as an optional feature though, unless the
> > performance impact on builds is close to zero. Measurements?
> > 
> 
> bitbake core-image-full-cmdline on a 16-core 32GB-ram VM, using an existing
> download cache (to avoid differences due to network performance) took
> 41m57.043s without the patches, and 42m26.727s with the patches. That's
> roughly 30s more; IMHO it seems acceptable.
> Keep also in mind that source tracing is done only once and then data should
> be stored somehow in sstate-cache (WIP).
> BTW the thing would require some more performance testing in an adequate
> testing infrastructure, could you (or others) help in this respect?

Ok, sounds like the performance impact is small enough. File
system buffering in RAM hides most of the work, I think.

> > But I see no connection toe CVE checking? The problem I have is that
> > I've seen SPDX and SBOM things sold as solutions to CVE checking while
> > in reality they have done nothing. Yocto has cve-check.bbclass which
> > uses PN/CVE_PRODUCT and PV/CVE_VERSION to query data from CVE database
> > and to generate reports about affected, patched and unpatched CVEs,
> > which then also include info from patch files (CVE number, if any)
> > and list of ignored CVEs from recipe metadata.
> > 
> > Even if SRC_URI can be split to individual entries, and each file in
> > soure tree can be mapped to exact SRC_URI entry, then what's the link
> > to CVEs?
> > 
> > CVEs don't map to SRC_URI entries even if they in theory could. CVEs
> > don't map the exact source file checksums. Multiple versions of a source
> > file can be mapped to be affected by a CVE they contain the same bug,
> > which is usually encoded in CVEs as SW component name and upstream
> > release version range. The SRC_URI entry SW component name and version
> > are not
> > added in this patch, and the CVE metadata about ignored and patched CVEs
> > are not exported, so I don't see any links to CVEs.
> 
> Actually the commit message could be improved in this respect. Being able
> to get upstream download locations (especially with recipes mixing multiple
> upstream sources, and with gitsm and npmsw fetchers) is a pre-condition to
> identify the relevant components and therefore do CVE checks, but CVE checks
> as such are not covered by the patch. I may clarify that.
> 
> For example, a possible improvement in this respect could be to calculate
> not
> only download locations (SPDX), but also purls
> (https://github.com/package-url/purl-spec),
> which may be used to do CVE checks against commercial or, even better, open
> databases (such as VulnerableCode https://www.nexb.com/vulnerablecode/).

Actually, I think it would serve yocto better to improve the yocto side
cve-checker.bbclass or language/module specific bbclasses to generate additional
CVE_PRODUCT and CVE_VERSION variables for SRC_URI entries of embedded SW like npm
modules or rust crates. Then for the embedded gitsm and other modules,
additional CVE_PRODUCT and matching CVE_VERSION variables should be set,
somehow, possibly with some automation.

Exporting the data to be used by other, possibly commercial tools,
doesn't help the community, in my opinion. I've also seen how commercial
solutions failed to fill the gaps, and (a backported) yocto cve-checker.bbclass
helped to identify how grave they were.

Cheers,

-Mikko

