Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35772CCD1AF
	for <webhook@archiver.kernel.org>; Tue, 21 Oct 2025 18:52:57 +0000 (UTC)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
 by mx.groups.io with SMTP id smtpd.web11.21173.1761072775023374848
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Oct 2025 11:52:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=cJlgUxlL;
 spf=pass (domain: gmail.com, ip: 209.85.219.47, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-87c103928ffso87801986d6.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 21 Oct 2025 11:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761072774; x=1761677574; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XlUiB3OyD/JRL6E9mERoEPly2fEWqW0JrGtatC6HBJw=;
        b=cJlgUxlLgn2GHll3gG+ncYn/iaLgJOD2HA2Z+x44lZDfT5hsV7kaXewZHvRDK6P3P5
         KXhuQ8n5TIac08D/l2BZ9kVjSrTqEbJZUWnAB8xhC5XRmTfI33MnUjK23JkxKwHzPIBH
         MlANwitHsILy/Ttatzz3FpjsK/GpAI3T44VbITqwIc3gqFpmFDEwsJpwHWcQ8i9WsVee
         dCMbqBvHAlf7Hm55CpfXHRF54GYi3m6DsSdkUP+hGr9HIeXGpTcy7S8g9LJAwRl4Tbos
         kEln4szxCuUoyxRj6WmY5xRCaP1219PMGQuDnrxj1OA1VUsh4drWxQq2Gvw5MIWQfRqB
         KtWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761072774; x=1761677574;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XlUiB3OyD/JRL6E9mERoEPly2fEWqW0JrGtatC6HBJw=;
        b=mSR9/AfzRT1nBO+8ozJR4+dtP9SAAwSU9owoowBVcWtmPb2N/N0jToVwqMU24Us6Lg
         +aI0qDEMYNHB7JkbpanLGSrnl43M4YsghOMd0PMeDW7mHBxvp8uBKqwD+hNqvyGnlwIp
         J2pN3zVEOlzOQipdAj5G852BbrIRq+DwhLkuBVKYbJlEPzG+f4AnrE0op527CalUmxHJ
         QMV/GUoUe08E7i06KwN5Y4Vv2uvG2WEzGbHntwQ4zuVRJQDvX4QY3eCBehyftMczZwWp
         o0dRFT9DkNc3WMmtu4lYwQMC9jE+glMzMzoxPSSdkcAj39iN3wRt1ftFzjqmsLDKG/Z8
         EAbw==
X-Gm-Message-State: AOJu0YxB00MpKU2JcGcY0JqI/vxs0tyUAJkWlkbiKje3QCEn+wxa6UI3
	BiPJmsvyDFlvfbWX1DlnLb9oBAwpwYqje42T6FrfwkZXuNG/MuzXyJrBDO7qFlYyb0680W5WXFi
	TEdsOKgpYdLcssnupkaFwvAeQhUcGq98=
X-Gm-Gg: ASbGnctnxDdZJpdZnViKPSF9fSJNuMWKaYpG5+vUHuBttT529dOjwCB4IQGvGxV7HE8
	rnXVkXCwWskudzAzuBqI9I7CoXU0xervK8f5+Meq5J9KHkrUjGq4nGD9iCDPvfOM16HQhuQsEG5
	Glg2jPa9ih1QwCeB4B1wNEG3BbZ+CeeTvJ+FOYgBaf5Vo+SfrSet1v7+53ZrYTCMTJKpAcLFpge
	nkWpd6YsfLTfecvOt7v+l/7MU3YCsHGUmtnPjZaPNRX/YfYVD0GeE2QlohKp5674dNU7V5Uc3nz
	IktbRNeyXuynAPxYOlSs8pVJBdRpw+iuKd4xzmvdPV6NCd1Q2eZc5p7NXL78+PwF1Op1VRnxALY
	WOsoZF9bOg/TLkTxRgg==
X-Google-Smtp-Source: AGHT+IFotAEkpppvG41M7DXiFw+OF1x98In08alZg3d30s7za8F7IsTT24FZPcWnOggNz3sqV0oROUJqwgyHmGRgNjc=
X-Received: by 2002:a05:6214:d8f:b0:87c:1d89:a245 with SMTP id
 6a1803df08f44-87c20639474mr220685216d6.49.1761072773957; Tue, 21 Oct 2025
 11:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <20251021182834.11403-1-adam.blank.g@gmail.com> <20251021182834.11403-2-adam.blank.g@gmail.com>
In-Reply-To: <20251021182834.11403-2-adam.blank.g@gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 21 Oct 2025 20:52:42 +0200
X-Gm-Features: AS18NWCHHKuoCx0BqTXzjeGMRsuStXo2SPqIa-cORsGECShFfO7n-SvDwClPjRg
Message-ID: <CANNYZj89auY9L+aeYNuRpxBqV0kX=3pmDMVx8w8+diAuoQuMMQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/3] doc: bitbake-user-manual: describe
 UNPACKDIR in fetching
To: adam.blank.g@gmail.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Oct 2025 18:52:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18201

On Tue, 21 Oct 2025 at 20:29, Adam Blank via lists.openembedded.org
<adam.blank.g=gmail.com@lists.openembedded.org> wrote:

> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -1697,3 +1697,7 @@ overview of their function and contents.
>     :term:`TOPDIR`
>        Points to the build directory. BitBake automatically sets this
>        variable.
> +
> +   :term:`UNPACKDIR`
> +      The directory into which recipe's downloads are unpacked during its
> +      build process.

Adding this to bitbake manual is incorrect. UNPACKDIR is specific to
openembedded-core (defined in bitbake.conf and used in base.bbclass if
memory serves) and is not used anywhere in bitbake.

UNPACKDIR is used in bitbake manual in examples of how to use the
fecher, but this doesn't mean it is a part of bitbake, and it is
already documented in yocto's manual in ref-manual/variables.rst.

Alex

