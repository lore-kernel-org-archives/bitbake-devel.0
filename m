Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB01C5B543
	for <webhook@archiver.kernel.org>; Wed,  4 Jun 2025 16:48:04 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web11.21572.1749055680640926512
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Jun 2025 09:48:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=bxxqSVJn;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-450cfb79177so47955e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 04 Jun 2025 09:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1749055678; x=1749660478; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eJURoTZDma4XmHixCmwBe0KoRHtGCbx0xOWgj+8dSPg=;
        b=bxxqSVJnWMoFj4pVBIsI2dr2ud6TCv+4QHoEGyEqKtYpIg85RBClAMPXhP/1uXqPAw
         rftz2AFoUma1vA5bifpXfflfgkK6iZ+9jaVJx0t88MRYlUHP/RmxK5QIuA5ACMlChsZ9
         6A96/O5TqXTPQEjd74veTmEDaTYq9IygZ7JME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749055678; x=1749660478;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJURoTZDma4XmHixCmwBe0KoRHtGCbx0xOWgj+8dSPg=;
        b=u3T1q4V78O7REvc4c76tetW2WnagCHde0gDBOXWuT3Cy+AI2VkptJMuNM0W6RNgM8S
         tfSCCbj/kmbpWj3k2bBO+Fftf6OvkCJqJVlYtzownb9rWPWYO29ceOLp7JkU3ASwOgC3
         qYHSaXG+KFjzeLoaISClOlC+M+rd8ZSUiTy1fLKWNHOCiL6X99u5ZDgWScNSP/LPRVQE
         kRSgGWcNF3pDpVPguuDJ66U4g8N30iJbCNt4hX8dgtPQrahHE2u8BnGOMbY4R+U5l4b2
         TiMv06/dslIeMKaZFE47E25kWBq134MrKzjroGSywt65PHLLukUGmNkzVLAKeLfpd/L9
         d/lA==
X-Gm-Message-State: AOJu0YxTfrOojthXhfCxLg/wRiWgFIbb3++0AIS6IRwHSuCl4L+ew/gb
	+4tzq8+OWUGvdgfVzIjXtTPXeo5f6pPhi8EIyntya1LHE55m38xXhFzxmB3YjVikaRFeOXZBQpi
	qru2fLdw=
X-Gm-Gg: ASbGncvWsS/Nh/fmG8UfhzCIOgrXPJWE8jrlHoFmBqdUF2pu8TIsfSNlau2K1LAbJbh
	kjQ9QXyg8dZhlghnWdmsSOw4lU2pnywYggEhmDtGlPlg8ceC+6lXqTqlteA8KEA6vTXUWDJO12K
	Njwj7hvcSiveUZNfxpA4hYtXcejwIVV02UG9DA2a77oIxw1FnQrZHLJ7JDDyHoVUGuOjoFaEKTg
	onbkO4eXmnpZQ35rqBD+fcdBgq9MOpAb1KNrSb8vC9cm9LDKjs8auL+VE2ZZ8LfzzToOOUrMMFJ
	N2CX68dL9/4mP4w67VU++fpulT5LF8IUK/H51WKaqXqV88OcnR/OHh85OM6Tq08+yoe06TUlczv
	Emc+3bg5elc0eNe/jdlLMV7jXqiPsdhxlx01MGT3C
X-Google-Smtp-Source: AGHT+IFBD9RSIZnziKnUeOfix4TJxJIxfRXEUtC/jjF4wnQuqno8BAfrzyZwMNGtDJVA9qqG7ltBWQ==
X-Received: by 2002:a05:6000:288c:b0:3a4:e841:b236 with SMTP id ffacd0b85a97d-3a51d961c44mr3309309f8f.33.1749055678197;
        Wed, 04 Jun 2025 09:47:58 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:204c:fb2e:c462:29df? ([2001:8b0:aba:5f3c:204c:fb2e:c462:29df])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5215e4c4asm2132282f8f.17.2025.06.04.09.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 09:47:57 -0700 (PDT)
Message-ID: <8106f8243e8050cbb716b0dfb01b64f707c10702.camel@linuxfoundation.org>
Subject: Parsing speed/efficiency, native class extensions and the expand
 cache
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Cc: Joshua Watt <JPEWhacker@gmail.com>
Date: Wed, 04 Jun 2025 17:47:56 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 04 Jun 2025 16:48:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17682

I had a look at our parsing for various reasons, partly to see what
kind of impact moving deferred inherits would have.

While in there, I noticed the variable expansion cache isn't working as
well as it should, particularly for native recipes.

The cache is there to cache the results of variable lookups/expansions.
It works by caching results and being cleared any time we write to the
datastore.

meta/lib/oe/classextend.py has this code:


def get_depends(varprefix, d):
    extcls =3D d.getVar("EXTENDERCLASS")
    return extcls.map_depends_variable(varprefix + "_NONML")


    def map_depends_variable(self, varname, suffix =3D ""):
        # We need to preserve EXTENDPKGV so it can be expanded correctly la=
ter
        if suffix:
            varname =3D varname + ":" + suffix
        orig =3D self.d.getVar("EXTENDPKGV", False)
        self.d.setVar("EXTENDPKGV", "EXTENDPKGV")
        deps =3D self.d.getVar(varname)
        if not deps:
            self.d.setVar("EXTENDPKGV", orig)
            return
        deps =3D bb.utils.explode_dep_versions2(deps)
        newdeps =3D collections.OrderedDict()
        for dep in deps:
            newdeps[self.map_depends(dep)] =3D deps[dep]

        if not varname.endswith("_NONML"):
            self.d.renameVar(varname, varname + "_NONML")
            self.d.setVar(varname, "${@oe.classextend.get_depends('%s', d)}=
" % varname)
            self.d.appendVarFlag(varname, "vardeps", " " + varname + "_NONM=
L")
        ret =3D bb.utils.join_deps(newdeps, False).replace("EXTENDPKGV", "$=
{EXTENDPKGV}")
        self.d.setVar("EXTENDPKGV", orig)
        return ret

i.e. any time we try and expand a RDEPENDS* or similar variable, it has
an indirection to oe.classextend.get_depends() and EXTENDPKGV gets set
and unset which destroys the expand cache.

Obviously we're doing this for good reason to preserve EXTENDEDPKGV but
from a performance perspective it is horrible.

Going back in time, Joshua and I discussed the idea of a [filter]
function being applied to variables to try and avoid this kind of
problem. Given how horrible the above is, I think it may be time to
look at that again...

Cheers,

Richard

=20

