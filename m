Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3078CD3442
	for <webhook@archiver.kernel.org>; Thu,  7 May 2026 10:43:47 +0000 (UTC)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8730.1778150622907523588
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 May 2026 03:43:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=LdHBfue0;
 spf=pass (domain: gmail.com, ip: 209.85.222.171, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cbc593a67aso63791385a.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 07 May 2026 03:43:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778150622; cv=none;
        d=google.com; s=arc-20240605;
        b=VMX1EHqWClQtyO1DjBRbCzBLHWAQl1i1ixAcm89FNMqEZJDB8DoVOYkvDkQAuMR7fh
         KgU838+UamK4bJ8MFViVTniGuVqcprQzzOO8Xxe74cjWga+gq9P3j6g5rLjooqYU/+OV
         p8sb1eW2es9EuCqHMBJ+G1UNI1uuYVljOBRb2j6ysVIs2r/cCkf9TdIo2/de+Ms7mqW0
         iYfzG+UV4av2zPVyDojsLNUaxwst6clpjFwXyYjKaHtZruF7Ym4k0lZR8mEHZkB8hSKe
         b/0mcEMng+KWVXT7pLfl+/N//ZVsM62OrG3+efrXgsOWyDoLoNZq6kKavXc2ukXst5ds
         YVYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DiAThaUf4U8iCTufd/BX6d6GHpNe8WtAIUBmS92c5fA=;
        fh=dgzQfTLjzSgWVmQrNoc/yMagAB/pjHol9ZsAWrRYMX0=;
        b=VPdHlz4N10Tn1Li3Nfbnu2DC3+58+GQCNBlqTyx8jy1BNCk0TB6Mf6bcv9PoYekGbE
         EpK2T0nc5r8dyj9v41RLyp44l7QLB9s8Ug6FqGDPE3to4qebj80NeTt38GZnwhhCBvQg
         9w+stOnvTZipkfh9rS6nGc7sWsNxIpL5fh5I/k8mco2rbz2cJJ4R5ttDVeY4Gbh+xJcv
         e0nlDBFv/k9KT+mel/1TXHtDrFGY71aJauQb+ZajUBH2Jyl46WxQasm5BHOasgdWDwPg
         /es+iQuZON/H0fMfdqlIltC4LsAsotP9U0m43Ca8Qw8p9ZbUMJyIaGZXgJPJ8wzeKH8M
         x0SQ==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778150622; x=1778755422; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DiAThaUf4U8iCTufd/BX6d6GHpNe8WtAIUBmS92c5fA=;
        b=LdHBfue0vyzTJvHEWGi7HYInHoST6JaJCM3uddkNh2Gea71i6htxy6A+MFiGut+TM2
         eUCcLy91XWNastw/j5IGakdH3JMt5dxbOs2U0BuxgLGDntT9shrYa5SjQTcymrLNEMr7
         VYMiXOvuLXIc7LujNM3RKQP3Cb0Ej2rktuAiBJpBRTe0XB+uCfE/+3SC9TSFknN9cBUU
         96yLqp0HhNVkDCZbFLfyH6oST/TyEtVhWG8nIVtICjXu647gBTmNBrVkGAMPsHBQlFRI
         h3z88Qh2gVmhHZnLD22hnOXF3SuOYY6Eqapf2jOMHouc1XxhdU0TxHqmGxF5A7tTfSun
         iRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778150622; x=1778755422;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DiAThaUf4U8iCTufd/BX6d6GHpNe8WtAIUBmS92c5fA=;
        b=A/NbZLgLgnBG1xYmUU9wdTUyFFXgK/zqghjcoJJgsicFbCYkxVMpOWWJ0xx4qJ4joO
         5FHAb7QS9xSc1BcsWfDmPXlP//A30nwhCG+XievFCX/rq7diNB8mb358ub84apPPCayW
         mzOFPdCO7pE60CRtlALrgdpXb6VZ3BdYBmpnExBoTsutd4wCAlrJwcaGnWS7HXLCgFct
         FNS9ncwpnxw9XhRrL3n4kcUzT40yqxtVBp66Gfcncm0Kun5Ik++nSPZq2On1/apq9bZu
         Vls/nO+94wcDqonoNpTr+i34Bw4g3cMTh01XJ8k7D2dOoS/krS6BXtktTcNYK99jEZpz
         hXbA==
X-Gm-Message-State: AOJu0YzL8ZCN9f/Od+TRNTAQl8AlfipD+0zmEMFhizY6ipaszjtOGIQp
	1hxWPCn7poDeJ+teaCyHfIfm2/cmoeliCP5m0ZXyo5ROO2dRgBBQXMexf38JTFEEpJqnUxVFXPi
	T8zfjzXGdKlnDXCfb4kA92mnyWNLljxQqhg==
X-Gm-Gg: AeBDies0ta6cJWN+QNPrZ5rBBTygdq7gOUsvDqaDS4K1gvG/Vbhn+stYgt/EyYs388j
	Lu2x0/d29wXjLWQMVSCLSUfA0jn7n/PLzhEhMe1q0rimQpP0OZyq72F8HUEYEpoLok4md4qra6C
	mpGsUhoYBGJLSORBXVgRjXsG1pb+c86S0UsYyXozfHVD6XrHsmdw3FBDtlog3w8KyuruQEhZyXX
	1E5jov07bsEjXcg0XZITjl9MR7APIMXtDZS+BYNAKR0Kg1CYj3UdLcTre1FhYC9cWa8vvShBlZO
	uTq7p9YJn1iaJSTmu6YnzSNweeAINM//5gfuVqqRFyJCZRJdAMXy7Lp+N8nHtes=
X-Received: by 2002:a0c:e016:0:b0:8b1:f069:3fc6 with SMTP id
 6a1803df08f44-8bc4536b4f5mr96314216d6.40.1778150621869; Thu, 07 May 2026
 03:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260507061845.1460893-1-Qi.Chen@windriver.com> <20260507061845.1460893-2-Qi.Chen@windriver.com>
In-Reply-To: <20260507061845.1460893-2-Qi.Chen@windriver.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 7 May 2026 12:43:29 +0200
X-Gm-Features: AVHnY4KKxdwQ7uIqIT8Xd6bbWwKV77QaJFpx6pHIg3C1P5WNIYcJOkcpklPm4cA
Message-ID: <CANNYZj86Swp0qkKi2U_3zusvGm2cXXeSg3iMd6fRLN05uCKwfA@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH V2 2/5] fetch2/wget.py: add filter_regex
 parameter to latest_versionstring
To: Qi.Chen@windriver.com
Cc: bitbake-devel@lists.openembedded.org, randy.macleod@windriver.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 May 2026 10:43:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19456

On Thu, 7 May 2026 at 08:19, <Qi.Chen@windriver.com> wrote:
> +                if filter_regex:
> +                    if not re.match(filter_regex, re.sub('_', '.', newver[1])):

This needs to include a note explaining that filter_regex is derived
from PV, and so uses . as separator, while upstream may be using _ as
separator (as seen below in the code where the same conversion happens
before the discovered version is returned).

> -                            package, package_regex, current_version, ud, d)
> +                            package, package_regex, current_version, ud, d, filter_regex=filter_regex)

Here and in other places you can perhaps simply pass in filter_regex
without naming the argument?

Alex

