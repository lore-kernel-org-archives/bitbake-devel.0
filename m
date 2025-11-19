Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5F4CF3185
	for <webhook@archiver.kernel.org>; Wed, 19 Nov 2025 09:33:15 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2986.1763544787442997996
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Nov 2025 01:33:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=EpR7/1RR;
 spf=pass (domain: gmail.com, ip: 209.85.219.48, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-880570bdef8so62741736d6.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 19 Nov 2025 01:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763544786; x=1764149586; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pjipmBVnE9OcOr4YX8q2PnIYJUI+wDGQgdY585yD6Sk=;
        b=EpR7/1RRT7pZfFmSwmUHLcQj/nl0AzWr/W2RYw0a2lKPnYqiz6XYhauvRDel7gMa1H
         nUXFQD1ipISSReEvH4mM4wOnp6KWEgZVfEtXuNjzB74GljoAkfye3rqcTvemZoFnI5Zw
         NQWSvFePUX7inAXncwJRXVz8kF37+fgAi7/YL+pyaSDxzAEimNrUNZgPMcqmNKpvsxI7
         Lu4tZHa0scgPJ4XatkTk8cBIHmHd+TzvpE2eRRI6q3N1eOxSfWcXX/LrRuieOBscoVHj
         JVgrPBjRL85hqXg/jUVEf8/UA2bwNDyGvd7bDUwF34oJqGO59AA5wZ9OFBxLGHFditmX
         D06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763544786; x=1764149586;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pjipmBVnE9OcOr4YX8q2PnIYJUI+wDGQgdY585yD6Sk=;
        b=Z0x+vfn6ml8Y5tPPo8mh+Zhr0NUNYoyS2lVGYTNf2RVsWay/BoWLyLnTsdGBi42U86
         qeXSJ/Q0R8Anugi3WvG7JxIvaQFTJ/lOBZposP7TS3/bifRBvQXfrxG1DXf40ujp44F3
         r9Luu9n0muMbwopX5C6EmLzGxoA744fsQg57uBTm01v70g++nyE11b1+M/wTN/1LDgXB
         lsLFYsIspPt6dmOgaWIksRCkfbaRpBuBBA8EKUWLuNzpVLUvilL1f2L10IKwLpQh9kKY
         1KzkErARbXz21DQJ/WVtV6PDTJAsXV1CcCVm7Qro0WyZEZ15G9Ja0MCdjs+ZJpbZHBOB
         YXQQ==
X-Gm-Message-State: AOJu0YwrseruricXFRd4BI8XOyT1rBpkg+GSHUESbWEcP7Lnv9OYDFkc
	mjcgGaaCeuPsfLKQxWQdAvPgqLuzVCqS8zW1vMdUrEYAAMhdFefbiZ0n2bOcFsMuBtSMkhsk5ZF
	eY9fGS6JbR57jtl9ks70GUAkDxg/TksY=
X-Gm-Gg: ASbGncsEnlFHXbiVHydQ+AbDcEBnssauOCFjnp0Gdx8uRlG4QTpSuaeTEYHBUPrlEen
	fAW2rqixE0kHp/Iuj/KGX+GKaQJzTPMJ2fe1kNTl1WBVnYaWT2yVnjQhM+vJyILAdpL71PC+wxu
	JGI9UIsJG7z4lGANvMN5cZkDkBV9Bjnv1verYDVd1Q2/oOWr/PO/3o79OwOe8ZDGIyezOh/C7a2
	1sWn40VMmnOB+XjoVVRaghVABXNBtj3sNo1cXL+ioxQAhUoZlFbrMJB+vYlsAYOPvAV995F7bAu
	wopGowisW66caljKfJTROmEa4Jir0g==
X-Google-Smtp-Source: AGHT+IGlzDj79323wqeZ+8vxbRLkZEjhUR2dKviOpkC7CG7Iqgu50u2CXTIZCQQdji1iElhDeya83NoofUxHCKgLf1s=
X-Received: by 2002:a05:6214:410f:b0:87c:28cc:9e69 with SMTP id
 6a1803df08f44-882926af38dmr270428966d6.55.1763544786276; Wed, 19 Nov 2025
 01:33:06 -0800 (PST)
MIME-Version: 1.0
References: <20251119090045.107642-1-Qi.Chen@windriver.com> <20251119090045.107642-2-Qi.Chen@windriver.com>
In-Reply-To: <20251119090045.107642-2-Qi.Chen@windriver.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 19 Nov 2025 10:32:54 +0100
X-Gm-Features: AWmQ_bltjzOnFdUNjXZvO4oa0snAsTHp4jOwDnAecqnm6jkXmCc7gtsX4tzWtaM
Message-ID: <CANNYZj-4R8w3urqPq6cD-kVFF82RWODEDTE=RDz7+xsCrjCuEA@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH V3 2/2] lib/bb/parse/ast.py: error out for
 internal fragment in case of a previous value
To: Qi.Chen@windriver.com
Cc: bitbake-devel@lists.openembedded.org, richard.purdie@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Nov 2025 09:33:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18451

Thanks, this looks much more elegant!

Now I just need to finish up the shorter setup dir name feature (and a
couple minor tweaks), and we're good to release.

Alex

On Wed, 19 Nov 2025 at 10:01, <Qi.Chen@windriver.com> wrote:
>
> From: Chen Qi <Qi.Chen@windriver.com>
>
> When an internal fragment is enabled, and there's already a value
> for the corresponding variable, we should error out to avoid any
> confusion.
>
> For example, when 'machine/qemux86-64' fragement is enabled, and
> we get some "MACHINE = xxx" in local.conf or env, we should error
> out and recomment users to use 'bitbake-config-build disable-fragment'.
>
> We should be tolerating '??=' assignments. For example, DISTRO defaults
> to "nodistro" in oe-core layer, and when 'distro/poky" fragment is enabled,
> there should be no confusion.
>
> Fixes [YOCTO #16060]
>
> Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
> ---
>  lib/bb/parse/ast.py | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
> index bf9bd4f55..00e3615e6 100644
> --- a/lib/bb/parse/ast.py
> +++ b/lib/bb/parse/ast.py
> @@ -367,6 +367,12 @@ class AddFragmentsNode(AstNode):
>          def check_and_set_builtin_fragment(fragment, data, builtin_fragments):
>              prefix, value = fragment.split('/', 1)
>              if prefix in builtin_fragments.keys():
> +                if data.getVar(builtin_fragments[prefix], noweakdefault=True) != None:
> +                    bb.fatal(
> +                        ("A builtin fragment '%s' is used while %s has already got an assignment.\n"
> +                         "Please either disable the fragment or remove the value assignment.\n"
> +                         "To disable the fragment, use 'bitbake-config-build disable-fragment %s'."
> +                         ) % (fragment, builtin_fragments[prefix], fragment))
>                  fragment_history = data.varhistory.variable(self.fragments_variable)
>                  loginfo={}
>                  for fh in fragment_history[::-1]:
> --
> 2.34.1
>

