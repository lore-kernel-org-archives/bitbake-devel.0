Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79189C02196
	for <webhook@archiver.kernel.org>; Fri,  7 Feb 2025 10:26:31 +0000 (UTC)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
 by mx.groups.io with SMTP id smtpd.web11.66590.1738923989708003632
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Feb 2025 02:26:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=PpUkBZVc;
 spf=pass (domain: gmail.com, ip: 209.85.219.44, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6e43557fd94so17071816d6.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 07 Feb 2025 02:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738923989; x=1739528789; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q1i9k9bRsWQ17drCg+X814pdQ4XClaAiNv69JTqN0/o=;
        b=PpUkBZVcBKLadeMAmQpyFjbdxwR7BC2ErdorelQd5dXJy9Q0mB6X6VPCL+qmahozNE
         SFudcR7ok5iP0nYoKoEouzBQHw1JILl8nygE65pL4YXwTlsE0RIC4lR91P9srLgSFKrD
         z8Jv1k9hAEnpPHn4H176tCcFmgjWPBLP8k2+EzrgEbB0CqcCsJ+rw2XcEHAC+zsjufOO
         k1Ja7QXyelGkeDdKcrJqB/wX/AzL7jTiRZOCiyzHP1nfYmIpC/ncMmx4tlNZql3JQwlN
         oH7BfXvr22kvtlhZWrQQq5W6JqYAhr6Oe2fooRqZ12QeHuM6kMblHy2A88OuAAPMoRP7
         LH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738923989; x=1739528789;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q1i9k9bRsWQ17drCg+X814pdQ4XClaAiNv69JTqN0/o=;
        b=LbKQ36r44+F5Npo2lAzbtyAwylf39uIirBnzWLpc+cnfYwv2XydLJDQt/y5UAvsphV
         pTBu/PNsroV+GuoHI8CAL8f9f+y8LcJ7xsdfxC/yKw1XhQXth8xvQqt8f6nLV2S/xkyv
         fqaSG0XZGJYgQN42BwDvSXg0Rhji+JwQ/LJdEcna9NuGO4psF0zsQUhV7sAubMgbgtJP
         RAzIvi/54qdjYRYCbvqE3MMQIGSeMeVqwthVTK8PxMknuAX4gDqBgECa8VnTXnM21OGA
         Qw2YK8ypBaQn55ZWIUC31TFnbUw0cf1pJcUxQ84xM2qXvxf6/bPE1woYncvV7AmT3h9j
         cO0A==
X-Forwarded-Encrypted: i=1; AJvYcCU8d7sZohU3Oivny0qr+SCf/COHYZAVsH3TXAQeTw/Tj5lLJ2TJYzsbaJMcndHRV4aW45mKcu10oMnoGv+Z@lists.openembedded.org
X-Gm-Message-State: AOJu0YzpCxCYCn6m5xmfGD9OlwLWfKnN3s8IfrFFThInwOe53JKK4y9+
	NfvixtKFPv7gaIkIlkwxQZHetF9OV4vtnNay4mZm2exXCrrYyaThQ3P2MT7YO5E3z3dxhy+gZC2
	32svf83Q1yPMn1EPqfFWQTiLFOAA=
X-Gm-Gg: ASbGncsY4FUHgJ5KxQBOzFhWQzAC8qNLGBh/yln2j6UB0GZHF8a5HwJ8295LJ27GguM
	OfUZ8IuEMauvqXiNIOk9ny4Q6Km3G1sbPDDM05qxWFEer4izIOO7fqcPzUzKWTp15mbhTV7QEcy
	LLEnIs+plczSu3MzyH2n07ybB9exrWfJg=
X-Google-Smtp-Source: AGHT+IGqI/QG0WjSB+u7Uybi0caQChMnw2NUJQtf2gzvpfx//5ajS+GwDro7m2OnOxja1fAxh7oPyeExTSX0YhPjRV8=
X-Received: by 2002:a05:6214:5016:b0:6e4:242b:934 with SMTP id
 6a1803df08f44-6e4455eda09mr36520476d6.17.1738923988704; Fri, 07 Feb 2025
 02:26:28 -0800 (PST)
MIME-Version: 1.0
References: <20250129112406.1660522-1-stefan-koch@siemens.com>
 <20250129112406.1660522-3-stefan-koch@siemens.com> <CANNYZj_sd3O_=dYGPuC1NKQDzbMSsjHPPLGi+qb2=3L174rUMg@mail.gmail.com>
 <87f5216654f92c2b0a9790cf336023ec1b788eb1.camel@siemens.com>
In-Reply-To: <87f5216654f92c2b0a9790cf336023ec1b788eb1.camel@siemens.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 7 Feb 2025 11:26:17 +0100
X-Gm-Features: AWEUYZmPLzNQH3HWgO5R0Y51fgg5hJxKxaFmCxIRzuKAgEY2aVUg7tdDOrXhB4Q
Message-ID: <CANNYZj8GVPrZCvcwjZxG2c9869XpXwsO5aiHGgQ=6GtYG6g36w@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 2/3] fetch2/git: Add offline build support
 for tags
To: "Koch, Stefan" <stefan-koch@siemens.com>
Cc: "Sudler, Simon" <simon.sudler@siemens.com>, 
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>, 
	"Kiszka, Jan" <jan.kiszka@siemens.com>, 
	Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Feb 2025 10:26:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17165

On Thu, 6 Feb 2025 at 13:46, Koch, Stefan <stefan-koch@siemens.com> wrote:
>  File "/work/isar/bitbake/lib/bb/fetch2/__init__.py", line 1670, in
> Git.latest_revision(ud=<bb.fetch2.FetchData object at 0x7f873f06eb90>,
> d=<bb.data_smart.DataSmart object at 0x7f873fce9590>, name='default'):
>  except KeyError:
>  > revs[key] = rev = self._latest_revision(ud, d, name)
>  return rev

This is the function:

    def latest_revision(self, ud, d, name):
        """
        Look in the cache for the latest revision, if not present ask the SCM.
        """
        if not hasattr(self, "_latest_revision"):
            raise ParameterError("The fetcher for this URL does not
support _latest_revision", ud.url)

        revs = bb.persist_data.persist('BB_URI_HEADREVS', d)
        key = self.generate_revision_key(ud, d, name)
        try:
            return revs[key]
        except KeyError:
            revs[key] = rev = self._latest_revision(ud, d, name)
            return rev

Something doesn't compute properly here: the cached revision should've
been successfully looked up via BB_URI_HEADREVS, and a call to
_latest_revision (triggering network access) avoided altogether.

Please look into why it isn't happening, or explain what your fix does
that addresses the problem. There's moving code around (changing the
condition for what is considered a revision on the way, which should
be in a separate commit), and adding a BB_NO_NETWORK check, and I
struggle to understand what these changes do :(

Alex

