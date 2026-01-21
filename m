Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADA5C44501
	for <webhook@archiver.kernel.org>; Wed, 21 Jan 2026 09:35:00 +0000 (UTC)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8145.1768988093195057284
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 21 Jan 2026 01:34:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=O4OBC0LG;
 spf=pass (domain: gmail.com, ip: 209.85.219.51, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-88888d80590so93733626d6.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 21 Jan 2026 01:34:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768988092; cv=none;
        d=google.com; s=arc-20240605;
        b=KsitRqKG0vCLvbgE2aZRwbjUH6+prsHl+PYBUdX0tJxnUtK6gj3xblvRBvh6mVLfOZ
         AVwBHCBsMrTBt/+mhvlxCBnnc9QPIw1T1L8WhsXt0p4m9WqUn/xHvU6M1ZVsIZAnRul8
         oaFNzH/UDC6CkoZQJWPdQHK5V8+gdh2Bupb1SymuIfIeKe36D90Rtk4Hwu4ZrLaP69fy
         dXAwDN5/rnlwPvUjicJClAFGVYY0fp0jMLt8T8WtKif0lp4KKWTmvLarpP5eF8PMuQR5
         fT/PeDOAk1wTBkT0K5808FQ+i4JmkWFinJHfTYhw8Q4UlQadFcLG3TtbnOttVOTcpboY
         p0jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=52YG+/p60wJ3Ya+QpmBEXeJTwM84Ewb06hCocIrqpDs=;
        fh=EDWU2tBsLzGSMILdf24myye+6XvP5MXMb5z/2yUvO+c=;
        b=GBvWykdbqi9JPwxWHt4PUVLIJrtfMeHkgrK7qm8whtcsxvd/EnDI0MznuxgrR8YaDZ
         eZAm9AhqhkKP4iM16YBSF7RIkIqb+5rO4Px+jUcHqcmFrPSecC1Ozpz42b0mnMoDgA2A
         h40Ajhs7d+XUO5m8eBiW93x0piyKOdJW6GOtz0Rn9g9YwqlXLLboHyC/vWpo86ScFaEU
         wgXnBZHr+qnXwF4q5NdP58PfNAfRWCyFcWUDWLJNXbhxI/D8unF2xMmcO+w4mRsTEy1H
         9Ys7jZJtiZw1zPwg7dXbt0bBhnokuZ1XAlQhA4QiNFz3brGsHAKLFw34XDRPho3xsbhx
         N9sA==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768988092; x=1769592892; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=52YG+/p60wJ3Ya+QpmBEXeJTwM84Ewb06hCocIrqpDs=;
        b=O4OBC0LG2ZOg5h38YB+S1vZCVUixP3q4N7o5Qb6M/7MRRTPyyLfUb5cq/sk5WOLcsL
         /GIabg+HzMLWc0nCb7jGnSQDaQWfAbvx+KPBaasC/5ox1Q8fK8kTKVrFTIrjzTF4Cl+X
         Wmb6yjtBQutxZvIZcLMVRjKEEP1XXenrsxt+c9BWO9/pbdK8cP/WPPlZMyzoc1nljJQ3
         plyJ+Y33z41gyhSqfn6smjGaeMWnJ7sV4VsWA4X3avOPwWp10CSQmBYA+m1nWM69/ack
         5EbbQxx8KnfDUgyb3UTxIP1nluyIpsPMkw30y8qsY52iUE6puMmf1JbCB0QBUQhWxNCP
         snag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768988092; x=1769592892;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52YG+/p60wJ3Ya+QpmBEXeJTwM84Ewb06hCocIrqpDs=;
        b=rxB635VCw/cpBBomx6ruvpglk7wOLzTcTZakUN0mJzlvegyH0SuSF3BdUZVqVUxisJ
         dC9wpBMjozhUuowhqKZcaE6/oNeJ++tlXimT8kmbMjdRrRKvdKb68YNJV9sYPfmLoOvf
         tniZ7qcqWaQcB7x/kvXhn6IdV86qOvQspmUHgHtm2BQ0k32MLnI8exwtFo6aNZAJeSvp
         awZ/w1+2XQ1X9ykBTPdgoPy7UspCDfor9lJgIECWfgQEEfMubqR2GvrMAgBvubJATyF5
         iqoTfRDBwHPxyetAwcTqNWl/Qpnu56NfuNT9TrpfIKTs9hlE0o+lPLc8+ECHInMnrQdE
         fr9g==
X-Gm-Message-State: AOJu0YxId9CyGw/FzyNYOde/p+XAL7gDD9c+sg0SK0xHmviOVTIXZNJx
	T2ZiW4XF4WW6gx1HIYzAqT14/n9RakjQWt9OskGOzLwEgfBEsaBIEhyeD0vlFjLLRNHY+43NyO4
	lX1XDlhi3xg3sSUY9ROqWGJOS/wlSK5oarQ==
X-Gm-Gg: AZuq6aKtG1p/L1Z0oAdaqSx+u0LJBXA2P86V4TYAVPIROdcZYN2eUvFZO5049mrMjwy
	IrUEe9v3MNDbvZqRhFVE2+vcKmfOYXKUSpaGC19x+gJkMBCickCoOhqpGXpzmH/tNW1tL0PBmYM
	Iemmm9yzAMhIyg2PzZts/Hq1QOv/pTHNrphtnhDxljCloIXWdthOiUOlvdl5UhSHpDkkucmE4RB
	bNmAAkJR+Cq9k0FzQFZzr+ICwvVQCVc+RK2o73VB7Cush69I05nizJAGp6xrH7DoWcdKXUGSWmB
	igUrIrMvZrnuDFAaeH6a5AZVAXvKkw==
X-Received: by 2002:a05:6214:80d9:20b0:894:5cfd:22c9 with SMTP id
 6a1803df08f44-8945cfd22cfmr73541576d6.65.1768988092119; Wed, 21 Jan 2026
 01:34:52 -0800 (PST)
MIME-Version: 1.0
References: <20260121024723.2634264-1-rob.woolley@windriver.com>
In-Reply-To: <20260121024723.2634264-1-rob.woolley@windriver.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 21 Jan 2026 10:34:40 +0100
X-Gm-Features: AZwV_QhBVltgvvB2iE4OhZSpAhLoQcDgIY5uyhYlM_YwoKziozRe8APYc47PwOU
Message-ID: <CANNYZj-nDaVXW3NYyn_FUqmvyyn-aEBsgpyHK20VNEqW7gTUGw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 0/5] Package bitbake-setup for PyPI
To: rob.woolley@windriver.com
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 21 Jan 2026 09:35:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18832

On Wed, 21 Jan 2026 at 03:47, Rob Woolley via lists.openembedded.org
<rob.woolley=windriver.com@lists.openembedded.org> wrote:
>
> Adding bitbake-setup to PyPI is helpful to developers who are already
> comfortable with using pip in their workflow.
>
> This series makes the necessary changes to build a wheel that may
> be uploaded to PyPI.
>
> The build sequence would be:
>     git clone https://git.openembedded.org/bitbake
>
>     python3 -m venv venv
>     source venv/bin/activate
>
>     python3 -m pip install build
>     python3 -m build
> This produces a wheel (.whl) file in the dist directory.  This may
> be installed using pip.

There should be a test for producing the .whl, ideally that also
installs the resulting local .whl into a temporary location and runs
'bitbake-setup list' from that installation. Is that feasible?

The instructions to produce, publish, and install the .whl should be
in a README.

Alex

