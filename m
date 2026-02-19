Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD31FE9A04C
	for <webhook@archiver.kernel.org>; Thu, 19 Feb 2026 09:36:33 +0000 (UTC)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10470.1771493788332818351
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 19 Feb 2026 01:36:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=JZmU5kJh;
 spf=pass (domain: gmail.com, ip: 209.85.219.52, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8947e17968eso8315796d6.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 19 Feb 2026 01:36:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771493787; cv=none;
        d=google.com; s=arc-20240605;
        b=GNHvFLLjAKASjqSbOZopQ0M1AY71WEOgn9ECJ0JkbrY2g/LB2RhaP+6a+trhn6cl/w
         sVu9phvqJByj5o/JAT3NnAI7vHPqEtw6NqbDTVz59Ox3NLb7P6shjrd/nbw0kEd7tGqR
         72StDl52umQBABOJPkYQqVVj4KuB05etRgMCqO58zZwqW019UxVDwSc+AVNxS5nhkna6
         5FR1hVI1WXOMYq3pE2R7bjjPTfzeSG3SIq4J4TIbDa33PuL5PdHNqFxRLSC/spruLUlg
         mQcLgdpqYkXTRzVFxT2ZCZW7lCIA3+yqgyqmQ0CTDZXcsWfVZaUbCIWY7Wk9M0baMVx6
         jBqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tmAcN/HwtNffH1nN8brwy9r7eWtO0vZ0FHiTRwzNJDU=;
        fh=UY90k4PlQOzv0SHkLPYnGUROqDnYu+dGNcFSIvIhMlk=;
        b=O1hlleutb4eJmexbl6scWlHknZ2nPj84geux5X4ZR9iz/cBS7BC9SdQ2ADYdig9gEe
         0vc6VwTd269n08cRo8RpHJANDDLayhxfnxKgW/TGhWL12hR0OgyXRG+p60slOnaQL4v3
         4EuKZWpctW/kUU4vOML4+LcvF1SXE6vnXyGOaMYRmdhfCSl5L0mZqFH37JiJ4xapFWS7
         Io40vuN57uVja9pF9f/SGHpuckQA58/f1QxG9MFjTg3KfB54wdO7Fe7/VcMMooXfPsgD
         G/ck+d8CHPjTR+Yups3tMcYV8rLNNztc7IpxTM3LJkLHIgvUDg8H2F0uk/v2SrjjUEIy
         FQtQ==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771493787; x=1772098587; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tmAcN/HwtNffH1nN8brwy9r7eWtO0vZ0FHiTRwzNJDU=;
        b=JZmU5kJh6dL3AaWitd8DzgqA2tS+fRNBEybNRUEa5B95/WyQPwEhX/mySbfgXJAJMh
         nHm8TCa0myWm5KqIS2eS/o3Mpi8TtRJNENDmyd/nrOnav92yu6tqaRO7ghcYOnWMhf66
         qNpld1C9+5ktbE/FWaA0fmjHl/R5hDL7px/S5OZnQXDCNqPNHeUxIdGrOVa+sTY3rus+
         6Ud3p9Of2MSCZWWcGJawu4PkzVQxHT3uqdUZB2vxBV1WRaRgD4/goqV23gQyUMo9mnoT
         4bTYm/z9vP+3ymHp3oaBonsf6wPelIQHD/ZR0jkElhOsNYgyXG3T9idOADjFdk0yaBqZ
         QMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771493787; x=1772098587;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmAcN/HwtNffH1nN8brwy9r7eWtO0vZ0FHiTRwzNJDU=;
        b=TZAXbHZlq+NOs/9SzuaeZGt44fnPoWN1Vv+k1xN0Zu8yMVTOM63WiI5A0DvXrAfHzs
         XByaGw7xMMrSX1z89a1Qt1BD5Jg/cLtALm95nU3FvabHVXV1Lmt+OMA+LHHZKZ5G+HQ3
         4VOSCpaO0x/trj3G4bmazJMKGOIqM8m4kHzc3enEtAj2BIEgdmAG5bSHjmx1FX3kCkFP
         M/o8bXMZJDw1AT/uEm3Cf8bmoPggJkP0bsA9518hL4mNyDm9ZGx370TXRJNs0g348sOC
         6U5TacDIY6muAQU3c4h5uLvdVks6NKY1Nv0dLuIq9WWgz0kOYcOWAgzfFpGEfyox7awO
         Rt6Q==
X-Gm-Message-State: AOJu0YwPXoVS3NXkuUaj6VVg9M2dNkxdyaNorvs2EtvLY89zkURpXcNN
	7GKDh42cSlxoqfCamHIX/36Zn/oc9U1rTKPfe1PBth6YNPxMaX1wRDLXy9TYV9j26cK0HlmU0aS
	mlOlpkxMqQ78gNCgA3on0iTpkQIDm5Ic=
X-Gm-Gg: AZuq6aKJChMbikxt7XFIr9hWWfAN1n+umVpnWVe2e9QuCh129NjSx2sBrP7kHtF0xD1
	z9solowz5iVBmVtYRJHHo4MmiMBJyThGAnESFSfVR7cHgqp3tpVm+h0HMk+FJw1X8qc90qsqeD7
	v8fFzuT0PbuTwZ4+93A5x9bIT0iyNSS+wq176SI+5h9g7BwJ0QK1MJZGpoy8r1x0fYF8rPHVLOi
	FuBtOUEWBGKW4daJDx1rgn5pOM5OCIWTVzPD/iFNILmoA/QD3Vp5/4uLDP9oHacAZMWaI2q3lX1
	eS904Ly89dyyIeTYTH+QbPwda3cKsIoMzggPc0ffxxAyCFA60hH1
X-Received: by 2002:ad4:5745:0:b0:890:7eed:a7d3 with SMTP id
 6a1803df08f44-89734948211mr339817876d6.55.1771493787322; Thu, 19 Feb 2026
 01:36:27 -0800 (PST)
MIME-Version: 1.0
References: <20260218-improve-bbsetup-readability-v2-0-351584e5df9c@bootlin.com>
 <20260218-improve-bbsetup-readability-v2-3-351584e5df9c@bootlin.com> <DGI6Z0US5NPC.6Y8DAVVEYWRG@bootlin.com>
In-Reply-To: <DGI6Z0US5NPC.6Y8DAVVEYWRG@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 19 Feb 2026 10:36:15 +0100
X-Gm-Features: AaiRm53bp2do3gZyijzx2M1WSnh8Qc51P4NDH-oy-dkl6s0mt12i3Zttz5VMMOs
Message-ID: <CANNYZj9grDk3dYjGARxhyca6a++GtHYaSKB0ouxpaoX03NWt+Q@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2 3/4] bitbake-setup: print colored diffs
To: antonin.godard@bootlin.com
Cc: bitbake-devel@lists.openembedded.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 19 Feb 2026 09:36:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19064

On Wed, 18 Feb 2026 at 16:27, Antonin Godard via
lists.openembedded.org
<antonin.godard=bootlin.com@lists.openembedded.org> wrote:

> Oops, this slipped through, but shouldn't be changed at all since it is removed
> in the next commit. I will resend the series.

Also the function is *way* over-engineered. I only wanted to avoid
repeating the color logic, so perhaps just this bit could be
abstracted and used in all three locations?

def get_color_param():
    return "always" if BBSETUP_COLOR else "never"

Alex

