Return-Path: <eekmecic@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD85CC001DF
	for <webhook@archiver.kernel.org>; Tue,  1 Aug 2023 14:30:10 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
 by mx.groups.io with SMTP id smtpd.web11.14436.1690900203778537649
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 01 Aug 2023 07:30:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=cvrVelvm;
 spf=pass (domain: snapchat.com, ip: 209.85.208.44, mailfrom: eekmecic@snapchat.com)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5221f3affe4so7716287a12.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 01 Aug 2023 07:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1690900202; x=1691505002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v40zSXDQ7/bhp8Nqz8KGeTssetu1UGhtY3YwvUkGH/M=;
        b=cvrVelvmJiBKNPSh+ybI8FGjn1tbU4ieE0qeoe6DS6CjzoOYMd16af0NxbSssi+67V
         zaPfSgwwPeKkEoCuiirqNa3IYpkoMcoWbnVYMi7sqPyutX7PGTC740hgCwgxdZVRCjPQ
         O6Pd5QKFGNQiATSTjGEsvee9mQtXZDo06aKWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690900202; x=1691505002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v40zSXDQ7/bhp8Nqz8KGeTssetu1UGhtY3YwvUkGH/M=;
        b=NF/Dfm/JgJCmHfccD/1T7zgn6GiIOBSIn+sXMS6CkDXyVoa3YQYEtvjvhbFM4SA0JC
         QzTLpc7uTMyiKuUATSJJb9wDVqx1SP3M4+7tcudqXGSmAmCF19yc0CT8MFOP6ufTX9lD
         SPxJ2aFDTswDvKRutqMuOcEQDuuECg4Rj2VLi3yPX/4LOGy+1zBkCpnsOds3jydS/mWC
         FoHkpX4c74Zqrwxd31mWjaUPcP7UZdWjI3O7rToBfGnMWmU4YoQmYUpRVxW7EXRX1LHG
         T6KcEG94Hi1kQsZ1qs1+AxLtJzrUvU+hJcHGReV4Pl1/cbKkDX+fjsLKlHijus3pkhJ8
         45ew==
X-Gm-Message-State: ABy/qLZvLV4tF0lYjnaKFLgEF7EJv+laGl3Y3PX/ysJDWL/uL6qWVCXR
	AKgfd111VABhZK4TU/bQ8E7QepGKQVu989iOjGrX/A==
X-Google-Smtp-Source: APBJJlGYB7X84zg+pyK5tjYBKKTNMfG8NVBnVSWDdYPxHfaHUhUk9qBW4H1vMuwHBYXUBqBLTtyK9UPP4ChPprPtS84=
X-Received: by 2002:a17:906:3119:b0:99b:d4a0:1329 with SMTP id
 25-20020a170906311900b0099bd4a01329mr2506838ejx.38.1690900202036; Tue, 01 Aug
 2023 07:30:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230801124715.752243-1-eekmecic@snap.com> <CANNYZj8mkTBNfevYz7eWr45D2renfen5FCLc1C6pMNHpUhd03A@mail.gmail.com>
In-Reply-To: <CANNYZj8mkTBNfevYz7eWr45D2renfen5FCLc1C6pMNHpUhd03A@mail.gmail.com>
From: =?UTF-8?B?RW1pbCBFa21lxI1pxIc=?= <eekmecic@snap.com>
Date: Tue, 1 Aug 2023 16:29:49 +0200
Message-ID: <CACjag3tMLM_wHyVbSqD6sDHox-dCRjwNXgv-Q75bqfhLzo5eUw@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH v2] fetch2: add Google Cloud Platform (GCP) fetcher
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 01 Aug 2023 14:30:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14899

On Tue, Aug 1, 2023 at 3:18=E2=80=AFPM Alexander Kanavin <alex.kanavin@gmai=
l.com> wrote:
>
> On Tue, 1 Aug 2023 at 14:47, eekmecic via lists.openembedded.org
> <eekmecic=3Dsnap.com@lists.openembedded.org> wrote:
> > e) Yes, the fetcher output is deterministic because it is downloading
> > tarballs from a bucket and not modifying them in any way.
>
> Let's say there's a supply chain attack on the bucket side, and the
> tarball has been replaced with a maliciously modified one. Will this
> fetcher be able to detect and reject such a download? For http tarball
> checksums are provided in the recipe. For git, the commit revision
> doubles as an integrity checksum (we trust that the local git client
> performs the check correctly). How is this handled here?
>
> Alex

This fetcher, in its current state, will not be able to detect a supply
chain attack of the type you've described. It does no verification of
any kind.

We are using this fetcher to support fetching sstate artifacts from a GCS
bucket. From my understanding, these artifacts have signatures that are
based on their inputs so BitBake would be able to verify that the
expected signature matches the signature of the file downloaded by the
fetcher.

I am unsure of how (if?) BitBake verifies the integrity of source
tarballs downloaded from mirrors. We are not using it to fetch source,
only prebuilt artifacts. I took a look at the other two fetchers
that implement support for S3 and Azure and I don't see any differences
in how they would handle a supply chain attack of the type you
described. Please correct me if I'm wrong. Likewise please let me know
if there's something that needs to be implemented in the fetcher code
to prevent such an attack.

Emil

