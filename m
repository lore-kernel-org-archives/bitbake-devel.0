Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B2FE8382D
	for <webhook@archiver.kernel.org>; Mon, 16 Feb 2026 19:55:04 +0000 (UTC)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2643.1771271701244413084
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 16 Feb 2026 11:55:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=FxSwr8o6;
 spf=pass (domain: gmail.com, ip: 209.85.219.45, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-896f5af3d8aso52618176d6.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 16 Feb 2026 11:55:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771271700; cv=none;
        d=google.com; s=arc-20240605;
        b=HMDIG73cDjT6ALZLvKbpLKezTAZChVtIkUXIP8RS5QHVnSh4qV2kgHFrPmgf3E4KPy
         5XM/Xo5e2dgzG6s5r+hQMyIiVCo2aRzjDdDWXSpB3vif6SDHUCNY2vBc8pFoo324lNqr
         oq1xg1vmyF86fPkUJ6dyLF0jMbiJXPnfkGfWUbNBjzSFuEjHBhndHLF4kkCGJ1W8sD6o
         7h9nHcbOP1NG3pgAcfsADeP0LKvxRW6weibw0R38RdcUTWLwUWml6fKA/d7/xEcHntFj
         7TUZvgAVb3HZQHXO68jcynmbQ0aUFQSDEokiSIM81D94H+/RCvy4z4Ke6+bQgcuwlWIv
         q0Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=H5NqIUWKhcl1vXNW7Rft5uw/KvIY44wZXLiwh5EIsK4=;
        fh=UY90k4PlQOzv0SHkLPYnGUROqDnYu+dGNcFSIvIhMlk=;
        b=etOdKGW840IFMWd/ErErnX3gDEBVgB4f0SAiGTiuTe/VW7tEa34BUONHKfTH6D/gSp
         SCXlRbJzc1XRcTtKqjZtx9IsYIMb7J1sfoPpwPF1oixJAjTkmUPxd1dnamqRPkE2MCu4
         awav5UBugSAcXQi1GLWQPDpXIL6l3eWGj+CRMpKGwETTt61P3vzmrMJraMGAve7E32lV
         JWQyUd7AK5rlbws1liB0xIY/a+gJBzWPV2f97dGJwnJY6RvDohvvDxrU8gXr7wDVR28u
         FfnKLghf6Qg680M4snuPK9U3c4XYmLwWEQLalQo9Qoey8N3RIDnwgcTExSXuhPHyhGCC
         xC2Q==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771271700; x=1771876500; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H5NqIUWKhcl1vXNW7Rft5uw/KvIY44wZXLiwh5EIsK4=;
        b=FxSwr8o6+Aa8qrtXaX7thLh7WGQoJFCC6PTWZmqa6KGu1cVR1Ub8B8TP+KK/yClLHF
         UZsIyEit98CP83Yog7qw3GkG3krA17Arb2PeGNHxmtWNICLDRHVtFfsGxAFSLTwFgnsL
         wMaSNMbcjNhOddZbGOOJBzLlWWhQ2B6mNfmlN3LBaZSDO9IMfJxI0cjQpD0M88Aof2jM
         kXoUIu7paV+qaQYt8Nw/LyFSvwGMQ+7yrUlElAyTx33VV5tb8VfasjNGB0wdjwvZRIxg
         mD0jgmYU+6T2AtWaTkSVH5qCw+ChttsSptNeteidSCG8Ecb05sD+PlACMospqZKLy1cx
         /2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771271700; x=1771876500;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5NqIUWKhcl1vXNW7Rft5uw/KvIY44wZXLiwh5EIsK4=;
        b=IWitCoIs9cbMHknJI4dvYtp4hv4454I1z/sF2BMTk5xwt6BuX1qgNuG+sINtQhxpxK
         SQWHQKVJOBPmKSV1MQXqfDeIQd/P0TBBqWrrE8A1TI44tr7pxYbV2OrEkmNOtHOAgtgE
         rFzhX0POWSrHjjaCIjnx5IDarI6Iwjs6j5OC4v3p70MoZuFLkImzEHqPvWqnOgUsvP0N
         UbDBivzQOKNuHDQcqmqAfryT9qXLdgMbyga/aLpLUVDRKF8tju0k8IO4OJot03d7Y19W
         JAYT6m1nO7PoI6tzdrponu5EIo0o3+F/QUcq7DXJgqqAnruZ9Fmt+dQ3a8mlaPL60CFe
         NpsQ==
X-Gm-Message-State: AOJu0Yx1+jsyRjpTJNRVegysPYb7kfy9dybbSiuO2OOfkVSVfxRBcYE+
	EyXLCrVhH6kmeA03ejRsZNtPZ7/Bf7qn+WMhzWEqyXPH6u2siZfaLsskyLFMCq0xtZKDw7CGNf/
	VGV+0dSA3CIjmcxzSAcLMw09+NUlBXN0=
X-Gm-Gg: AZuq6aIRVKTVm1/Aqby9ta3NNy3DndC4AlvIaoDCyZ6aAOe1d6hx7xPz+EDHJaebrka
	05wmd+tKTkwBREsn07DVFAPpwAATuU/YhVUV4vmmdIisXzLE4t0J8/1y9IBN12qtiYzPWYAgXHG
	MB+bDOCTqatMT6WdvhVMRgOWI42q2wgLFNQNkPObHYOo3iJ51m4dF84f24J7/FhCKKqF75FnUy4
	WF4c/D1N7IZapR6NgkvbszkNWOPTTub1v6w51PAoqdQ0WLji9Y27soWQvbKNosiVtqCbqnsGoYX
	rujRIheTyld++AnH0sq2wfRVe/opWjywq477L0WoSA==
X-Received: by 2002:a05:6214:1d21:b0:896:fdd6:4a8f with SMTP id
 6a1803df08f44-8973630c3c1mr168942946d6.69.1771271700220; Mon, 16 Feb 2026
 11:55:00 -0800 (PST)
MIME-Version: 1.0
References: <20260213-improve-bbsetup-readability-v1-0-41cec3b06992@bootlin.com>
 <20260213-improve-bbsetup-readability-v1-4-41cec3b06992@bootlin.com>
In-Reply-To: <20260213-improve-bbsetup-readability-v1-4-41cec3b06992@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 16 Feb 2026 20:54:49 +0100
X-Gm-Features: AaiRm52xTQryXB3li3gmwQpq-bs8afGBLVdfRwg3LtiiVu0Dm500enQuTIGeHLc
Message-ID: <CANNYZj-V3gv=4dbwCJY9r_d=EagM7+8qq0L_ahrHrp_8U2zXnw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 4/4] bitbake-setup: print colored diffs
To: antonin.godard@bootlin.com
Cc: bitbake-devel@lists.openembedded.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 16 Feb 2026 19:55:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19042

On Fri, 13 Feb 2026 at 14:50, Antonin Godard via
lists.openembedded.org
<antonin.godard=bootlin.com@lists.openembedded.org> wrote:
> -    config_diff = bb.process.run('git -C {} diff'.format(confdir))[0]
> +    config_diff = bb.process.run('git -C {} diff --color={}'.format(confdir, "always" if BBSETUP_COLOR else "never"))[0]

These three color-enabling changes also should be split into a helper function:

run_git_diff(path, parameters)

Alex

